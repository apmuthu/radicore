<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions related to session management

global $session_name;
if (isset($_REQUEST['session_name'])) {
    // use session name passed via $_GET or $_POST
    $session_name = $_REQUEST['session_name'];
} // if

require_once 'classes/php_session.class.inc';
$session_class = new php_session;
session_set_save_handler(array(&$session_class, 'open'),
                         array(&$session_class, 'close'),
                         array(&$session_class, 'read'),
                         array(&$session_class, 'write'),
                         array(&$session_class, 'destroy'),
                         array(&$session_class, 'gc'));

// ****************************************************************************
function checkSelection ($task_id, $where=null)
// a new selection has been made, so verify and process it.
{
    //DebugBreak();
    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    require_once 'classes/mnu_task.class.inc';
    $dbtask =& singleton::getInstance('mnu_task');

    $dbtask_data = $dbtask->checkSelection($task_id);
    $errors = $dbtask->getErrors();

    if ($errors) return $errors;

    if ($dbtask_data['task_type'] == 'MENU') {

        unset($GLOBALS['current_task']);

        if ($task_id == $_SESSION['start_task_id']) {
            $page_stack = array();
            // update page stack with current selection
            $page_stack = updatePageStack($task_id, $GLOBALS['button_text'], $PHP_SELF);
        } else {
            // update page stack with latest selection
            $page_stack = updatePageStack($task_id, $dbtask_data['button_text'], $PHP_SELF);
        } // if

        if (basename($PHP_SELF) == 'menu.php') {
            // get menu details for the chosen menu
            $menu_buttons = getMenuButtons($task_id);
            // we are in menu page, so update script_vars now
            $GLOBALS['menu_buttons'] = $menu_buttons;
            $GLOBALS['current_menu'] = $task_id;
            $GLOBALS['script_vars']['menu_buttons'] = $menu_buttons;
            $GLOBALS['script_vars']['current_menu'] = $task_id;
            $GLOBALS['script_vars']['page_stack']   = $page_stack;
            // switch task_id to the generic home page
            $task_id = 'menu';
            $GLOBALS['task_id'] = 'menu';
            // ensure script variables are available throughout this session
            $_SESSION[$PHP_SELF][$task_id] = $GLOBALS['script_vars'];
        } else {
            // we are not in the menu page, so jump to it
            $GLOBALS['query_string'] = "selection=$task_id";
            scriptNext('menu');
        } // if

    } else {
        // not a menu, so process designated script instead
        scriptNext($task_id, $where);
    } // if

    return $errors;

} // checkSelection

// ****************************************************************************
function childForm ($post, $dbobject, $objectname, $where=null, $fieldarray=null)
// look for an action which is another script.
// (this may be from a navigation button or a popup button)
{
    //DebugBreak();
    if (isset($post['task#previous_search'])) {
        // use previous search criteria (from one of two tables)
        if (isset($_SESSION['search'][$dbobject->tablename])) {
            $GLOBALS['search'] = $_SESSION['search'][$dbobject->tablename];
        } elseif (isset($_SESSION['search'][$dbobject->sql_search_table])) {
            $GLOBALS['search'] = $_SESSION['search'][$dbobject->sql_search_table];
        } // if
        // this is a dummy button, so clear it
        unset($_POST);
        return;
    } // if

    foreach ($post as $key => $value) {
        // look for a variable beginning with 'task#'
        if (eregi('^task#', $key, $regs)) {
            // strip pattern prefix
            $next_task = str_replace($regs[0], '', $key);
            // note: if the button is replaced with an image the key name returned
            // will be appended by '_x' as part of the x/y coordinates of the image.
            if (eregi('_x$', $next_task)) {
                // '_x' found, so strip it off.
                $next_task = substr_replace($next_task, '', -2);
            } // if
            break;
        } // if
    } // foreach

    global $script_vars;
    global $popup_where;
	global $settings;
    global $sql_orderby;
    global $sql_orderby_seq;

    if (isset($next_task)) {
        // check to see if this selection is valid
        require_once 'classes/mnu_task.class.inc';
        $mnu_task =& singleton::getInstance('mnu_task');
        $mnu_task_array = $mnu_task->checkSelection($next_task);
        $errors = $mnu_task->getErrors();
        if ($errors) return($errors);

        // check to see if a popup/filepicker form has been called
        if (eregi('popup|filepicker', $mnu_task_array['dialog_type_id'], $regs)) {
            if (is_object($dbobject)) {
                // allow $where and $settings to be modified
            	$settings = '';
                $where = $dbobject->popupcall($next_task, $where, $script_vars, $fieldarray, $settings);
                $settings = mergeSettings($mnu_task_array['settings'], $settings);
                // save current fieldarray inside database object
                $dbobject->setFieldArray($fieldarray);
                $script_vars[$objectname] = serialize($dbobject);
            } // if
            // call popup script
            scriptNext($next_task, $where, null);
        } // if

        // this must be from a navigation button
        if (isset($post['select'])) {
            // convert selection into SQL where format
            $selection = selection2where($dbobject->getPkeyArray(), $post['select']);
            //$where     = unqualifyWhere($where);
            //$selection = mergeWhere($selection, $where);
        } else {
            $selection = null;
        } // if
        if (isset($popup_where)) {
            // include $popup_where for a subsequent popup form
            if (!empty($where)) {
                $where = mergeWhere($where, $popup_where);
            } else {
                $where = $popup_where;
            } // if
        } // if
		if (is_object($dbobject)) {
        	// extract any sort parameters from the current object
        	$sql_orderby     = $dbobject->getOrderBy();
        	$sql_orderby_seq = $dbobject->getOrderBySeq();
		} // if
        // pass control to selected script
        scriptNext($next_task, $where, $selection);
    } // if

    // nothing found, so return to calling script
    return;

} // childForm

// ****************************************************************************
function chooseButton ($postarray, $dbobject)
// 'choose' button has been pressed, so ...
// look to see if there is a selection to send back to the previous screen.
{
    //DebugBreak();
    if (isset($postarray['select'])) {
        // convert selection into SQL where format
        $selection = selection2where($dbobject->getPkeyArray(), $postarray['select']);
        // send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = $_SESSION[$prev_script]['task_id'];
        $_SESSION[$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } else {
        $messages[] = getLanguageText('sys0081'); // 'Nothing has been selected yet.'
        return $messages;
    } // if

} // choose button

// ****************************************************************************
function copyForm ($post, $dbobject, $fieldarray)
// copy $_POST array into a memory area so that it can be used in a PASTE.
{
    //DebugBreak();
    if (!is_string(key($fieldarray))) {
        // index by row, so use row zero only
        $fieldarray = $fieldarray[0];
    } // if

    // merge posted data with current object data
    $fieldarray = array_update($fieldarray, $post);

    // save contents inside object
    $dbobject->setFieldArray($fieldarray);

    // unset system fields
    unset($fieldarray['created_date']);
    unset($fieldarray['created_user']);
    unset($fieldarray['revised_date']);
    unset($fieldarray['revised_user']);

    // remove empty fields
    foreach ($fieldarray as $field => $value) {
    	if (strlen(trim($value)) == 0) {
    	    unset($fieldarray[$field]);
    	} // if
    } // foreach

    if (count($fieldarray) == 0) {
        //$messages[] = 'No data available to be copied';
        $messages[] = getLanguageText('sys0050');
        unset($_SESSION['data'][$dbobject->tablename]);
    } else {
        // save current data for re-use via 'paste' button
        $_SESSION['data'][$dbobject->tablename] = $fieldarray;
        //$messages[] = 'Data has been copied';
        $messages[] = getLanguageText('sys0051');
    } // if

    return $messages;

} // copyForm

// ****************************************************************************
function getNewSession ($prefix='menu')
// create a new session name using $prefix + a number.
{
    // step through numbers 0-99
    for ($i = 0; $i <= 99; $i++) {
        $session_name = $prefix .$i;
        if (!array_key_exists($session_name, $_COOKIE)) {
            break;
        } // if
    } // if

    return $session_name;

} // getNewSession

// ****************************************************************************
function initSession()
// initialise session data
{
    global $button_text;        // button text for current task
    global $css_files;          // array of CSS file names
    global $current_menu;       // currently active menu on menu bar
    global $current_task;       // currently active task on menu bar
    global $errors;             // array of error messages
    global $instruction;        // optional instruction returned by previous script
    global $language;           // language code (for internationalisation)
    global $keep_data;          // keep data in session after exit?
    global $lock_rows;          // lock database rows during transaction? FALSE/SH/EX
    global $lock_tables;        // lock database tables during transaction? TRUE/FALSE
    global $lookup;             // array of lookup values
    global $menu_buttons;       // array of menu buttons
    global $messages;           // optional array of messages
    global $order_by;           // field names for ORDER BY clause of SELECT
    global $order_by_body;      // ORDER BY for the CHILD in a PARENT-CHILD screen
    global $order_by_seq;       // sequence ('asc' or 'desc')
    global $page_stack;         // hierarchy of pages used in this session
    global $pagination;         // pagination values
    global $popup_where;        // where clause for popup form
    global $protocol;           // HTTP or HTTPS
    global $remove_buttons;     // tasks to be removed from navigation bar
    global $return_action;      // set when returning to previous screen
    global $return_from;        // set when returning to previous screen
    global $scrolling;          // scrolling values
    global $search;             // extra selection criteria from search screen
    global $selection;          // a selection of rows made in one screen that is passed back to another
    global $settings;           // optional string of settings
    global $script_count;       // number of times this script has been called in this cycle
    global $script_start;       // start time
    global $script_vars;        // variables belonging to current script
    global $session_name;       // session name, to allow multiple sessions from the same PC
    global $sql_orderby;        // used in ORDER BY in an sql SELECT statement
    global $sql_orderby_seq;    // sequence ('asc' or 'desc')
    global $subsys_dir;         // directory in which subsystem is located
    global $task_id;            // current task identity on menu database
    global $transaction_has_started;    // Yes/No switch
    global $title;              // script title
    global $where;              // selection criteria, used in SQL query
    global $XSLT_client_side;   // on/off switch for client-side XSL transformations

    //DebugBreak();
    // continue with existing session, or start a new one
    if (!isset($_SESSION)) {
        if (isset($session_name)) {
            session_name($session_name);    // set the session name
        } // if
        session_start();                    // open/reopen session
    } // if

    $PHP_SELF = getSelf();

	if (isset($_GET['action'])) {
	    if ($_GET['action'] == 'newsession') {
            // get and register a new session name
	        $session_name = getNewSession('menu');
            session_name($session_name);
            // generate a new id to go with this name
            session_regenerate_id();
            // save this session data NOW!
            session_write_close();
            // now restart the current script
            $task_id = $_SESSION[$PHP_SELF]['task_id'];
            scriptNext($task_id);
	    } // if
	} // if

	// look for security class from logon screen
    if (!isset($_SESSION['role_id'])) {
        $basename = basename($PHP_SELF);
        if (basename($PHP_SELF) != 'logon.php'
        and (basename($PHP_SELF) != 'help.php')) {
            // not supplied yet, so jump to logon screen
            if (isset($_SESSION['XSLT_client_side'])) {
    	       $XSLT_client_side = $_SESSION['XSLT_client_side'];
            } // if
            session_unset();
            $_SESSION['message'] = getLanguageText('sys0000'); // 'You must log in to access this system.'
            $location = $protocol .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .'/menu/logon.php'
                                  .'?session_name=' .session_name();
            //if (is_true($XSLT_client_side)) {
    	    //   $location .= '&csxslt=on';
            //}// // if
            header('Location: ' .$location);
            exit;
        } // if
    } // if

    if (!array_key_exists('XSLT_client_side', $_SESSION)) {
    	$_SESSION['XSLT_client_side'] = FALSE;
    } // if
    if (isset($_GET['csxslt'])) {
    	$_SESSION['XSLT_client_side'] = $_GET['csxslt'];
    } // if
    if (is_True($XSLT_client_side)) {
	   $_SESSION['XSLT_client_side'] = TRUE;
    } // if

    // record the time at which this script started
    // (end time is determined in function XSLTransform)
    if (!isset($_SESSION['script_start'])) {
        list($usec, $sec) = explode(' ', microtime());
        $_SESSION['script_start'] = (float) $sec + (float) $usec;
    } // if

    // if a button is changed to an image it will have an '_x' suffix, so remove it
    if (isset($_POST['choose_x'])) {
        $_POST['choose'] = $_POST['choose_x'];
        unset($_POST['choose_x']);
    } // if
    if (isset($_POST['clear_x'])) {
        $_POST['clear'] = $_POST['clear_x'];
        unset($_POST['clear_x']);
    } // if
    if (isset($_POST['collapse_x'])) {
        $_POST['collapse'] = $_POST['collapse_x'];
        unset($_POST['collapse_x']);
    } // if
    if (isset($_POST['copy_x'])) {
        $_POST['copy'] = $_POST['copy_x'];
        unset($_POST['copy_x']);
    } // if
    if (isset($_POST['expand_x'])) {
        $_POST['expand'] = $_POST['expand_x'];
        unset($_POST['expand_x']);
    } // if
    if (isset($_POST['paste_x'])) {
        $_POST['paste'] = $_POST['paste_x'];
        unset($_POST['paste_x']);
    } // if
    if (isset($_POST['quit_x'])) {
        $_POST['quit'] = $_POST['quit_x'];
        unset($_POST['quit_x']);
    } // if
    if (isset($_POST['reset_x'])) {
        $_POST['reset'] = $_POST['reset_x'];
        unset($_POST['reset_x']);
    } // if
    if (isset($_POST['submit_x'])) {
        $_POST['submit'] = $_POST['submit_x'];
        unset($_POST['submit_x']);
    } // if
    if (isset($_POST['submitnext_x'])) {
        $_POST['submitnext'] = $_POST['submitnext_x'];
        unset($_POST['submitnext_x']);
    } // if
    if (isset($_POST['submitstay_x'])) {
        $_POST['submitstay'] = $_POST['submitstay_x'];
        unset($_POST['submitstay_x']);
    } // if

    $errors = array();

    if (!isset($_SESSION['user_language_array'])) {
    	// get language codes from HTTP header
        require_once 'language_detection.inc';
        $_SESSION['user_language_array'] = get_languages();
    } // if

    // get full language string from first entry in user_language_array
    if (isset($_SESSION['user_language_array'][0][2])) {
        $country = $_SESSION['user_language_array'][0][2];
    } else {
        $country = '**UNDEFINED**';
    } // if
    // extract locale which is enclosed in '[' and ']'
    if (!preg_match('?\[[^\[]+\]?', $country, $regs)) {
        // 'Locale is not defined in string'
    	$errors[] = getLanguageText('sys0078', $country);
    } else {
        $locale = trim($regs[0], '[]');
        // find out if this is a valid locale
        if (!$locale = setLocale(LC_ALL, $locale)) {
            // extract details in front of trailing '[xxx]'
            preg_match('?[^\[]+?', $country, $regs);
            if (!$locale = setLocale(LC_ALL, $regs[0])) {
                // 'Cannot set locale'
                //$errors[] = getLanguageText('sys0079', $country);
            } // if
        } // if
    } // if

    // look for session variables associated with this script
    if (isset($_SESSION[$PHP_SELF])) {
        if (isset($_SESSION[$PHP_SELF]['task_id'])) {
            $task_id     = $_SESSION[$PHP_SELF]['task_id'];
            $script_vars = $_SESSION[$PHP_SELF][$task_id];
        } else {
            $script_vars = array();
        } // if
    } else {
        $script_vars = array();
    } // if

    if (empty($script_vars)) {
        if (basename($PHP_SELF) == 'help.php') {
            // do nothing
        } elseif (basename($PHP_SELF) != 'logon.php') {
            // not allowed to be empty, so go back to last valid script
            $page_stack = $_SESSION['page_stack'];
            $end = end($page_stack); // get the last value
            $script_id = $end['script_id'];
            $location = $protocol .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .$script_id
                                  .'?session_name=' .session_name();
            header('Location: ' .$location);
            exit;
        } // if
    } // if

    // keep count of how many times this script has run
    if (!isset($script_vars['script_count'])) {
        $script_vars['script_count'] = 1;
    } else {
        $script_vars['script_count']++;
    } // if
    if (!empty($task_id)) {
        // save values in session data
        $_SESSION[$PHP_SELF]['task_id'] = $task_id;
        $_SESSION[$PHP_SELF][$task_id]  = $script_vars;
    } // if

    if (isset($script_vars['title'])) {
        $title = $script_vars['title'];
    } // if

    if (isset($script_vars['button_text'])) {
        $button_text = $script_vars['button_text'];
    } // if

    if (isset($script_vars['menu_buttons'])) {
        // this is the array of menu buttons at the top of each page
        $menu_buttons = $script_vars['menu_buttons'];
    } else {
        $menu_buttons = array();
     } // if

    if (isset($script_vars['current_menu'])) {
        // the current menu in $page_stack is not a hyperlink
        $current_menu = $script_vars['current_menu'];
    } // if

    if (isset($script_vars['page_stack'])) {
        // this is the hierarchy of visited pages
        $page_stack = $script_vars['page_stack'];
    } else {
        $page_stack = array();
    } // if

    if (isset($script_vars['current_task'])) {
        // the current tab in $menu_buttons is highlighted
        $current_task = $script_vars['current_task'];
    } // if

    if (isset($script_vars['initial_passthru'])) {
        // extract value before removing from session data
        // (ensures that value is used only once)
        $initial_passthru = $script_vars['initial_passthru'];
        unset($script_vars['initial_passthru']);
        $_SESSION[$PHP_SELF][$task_id] = $script_vars;

        // update page stack with current selection
        $page_stack = updatePageStack($task_id, $button_text, $PHP_SELF);

        // check for SQL 'where' string to be used within this script
        // (this is usually passed down by the parent script)
        $where = null;
        if (isset($script_vars['where'])) {
            $where = $script_vars['where'];
        } else {
            // check for a selection of one or more rows
            if (isset($script_vars['selection'])) {
               $where = $script_vars['selection'];
            } // if
        } // if

        // now jump to passthru script
        $errors = checkSelection($initial_passthru, $where);
    } // if

    // do database records need to be sorted into any particular order?
    if (isset($script_vars['order_by'])) {
        $order_by = $script_vars['order_by'];
        if (isset($script_vars['order_by_seq'])) {
            $order_by_seq = $script_vars['order_by_seq'];
        } // if
    } // if
    if (isset($script_vars['order_by_body'])) {
        $order_by_body = $script_vars['order_by_body'];
    } // if

    if (isset($_GET['selection'])) {
        // a new selection has been made ....

        if (!array_key_exists($_GET['selection'], $page_stack)) {
            // new selection does not exist in current stack, so ...
            if (isset($current_task)) {
                if ($current_task != $current_menu) {
                    // remove $current_task (and any following entries) from $page_stack
                    $page_stack = reducePageStack($current_task);
                } // if
            } // if
            // the new selection becomes the current tab
            $current_task = $_GET['selection'];
        } // if
        // clear script sequence as it has been interrupted and cannot be processed
        unset($_SESSION['script_sequence']);
        // verify and process selection
        $errors = checkSelection($_GET['selection']);
    } else {
        if (!empty($task_id)) {
            if ($task_id == 'logon' or $task_id == 'menu') {
                // do nothing
            } else {
                // add selection to current page stack
                $page_stack = updatePageStack($task_id, $button_text, $PHP_SELF);
            } // if
        } // if
    } // if

    // check for message(s) returned by previous script
    if (isset($script_vars['messages'])) {
        if (is_array($script_vars['messages'])) {
            $messages = $script_vars['messages'];
        } else {
            // convert simple string into an array
            $messages[] = $script_vars['messages'];
        } // if
        unset($script_vars['messages']);
    } else {
        if (!isset($messages)) {
        	$messages = array();
        } // if
    } // if

    // check for error(s) returned by previous script
    if (isset($script_vars['errors'])) {
        if (is_array($script_vars['errors'])) {
            $errors = $script_vars['errors'];
        } else {
            // convert simple string into an array
            $errors[] = $script_vars['errors'];
        } // if
        unset($script_vars['errors']);
    } else {
        if (!isset($errors)) {
            $errors = array();
        } // if
    } // if

    // check for instruction returned by previous script
    if (isset($script_vars['instruction'])) {
        $instruction = $script_vars['instruction'];
        unset($script_vars['instruction']);
    } // if

    // check for SQL 'where' string to be used within this script
    // (this is usually passed down by the parent script)
    if (isset($script_vars['where'])) {
        $where = $script_vars['where'];
    } // if

    // check for SQL 'where' string to be passed down to a subsequent popup form
    if (isset($script_vars['popup_where'])) {
        $popup_where = $script_vars['popup_where'];
        unset($script_vars['popup_where']);
    } // if

    // check for string returned by SEARCH script
    if (isset($script_vars['search'])) {
        $search = $script_vars['search'];
        unset ($script_vars['search']);
    } // if

    // check for a selection of one or more rows
    if (isset($script_vars['selection'])) {
        $selection = $script_vars['selection'];
    } // if

    // check for identity of previous script
    if (isset($script_vars['return_from'])) {
        $return_from = $script_vars['return_from'];
        unset($script_vars['return_from']);
    } // if

    // check action taken within previous script
    if (isset($script_vars['return_action'])) {
        $return_action = $script_vars['return_action'];
        unset($script_vars['return_action']);
    } // if

    // get current scrolling information
    if (isset($script_vars['scrolling'])) {
        $scrolling = $script_vars['scrolling'];
    } // if

    // get current pagination information
    if (isset($script_vars['pagination'])) {
        $pagination = $script_vars['pagination'];
    } // if

    // get any optional settings
    if (isset($script_vars['settings'])) {
        // this is a string of 'name=value' pairs separated by '&', so...
        // convert string into an array
        parse_str($script_vars['settings'], $settings);
    } else {
    	$settings = array();
    } // if

    if (!empty($page_stack)) {
        $script_vars['page_stack'] = $page_stack;
        // also save data without association to a particular script
        $_SESSION['page_stack']    = $page_stack;
    } // if

    if (basename($PHP_SELF) != 'help.php') {
        // save values in session data
        $_SESSION[$PHP_SELF][$task_id] = $script_vars;
    } // if

    if (!isset($_SESSION['rowsperpage'])) {
        // set page size to default value (used in list screens)
        $_SESSION['rowsperpage'] = 10;
    } // if

    return;

} // initSession

// ****************************************************************************
function reducePageStack ($task_id)
// remove this page (and any following pages) from the page stack.
// (this causes page stack to contain only those pages which are current).
{
    //DebugBreak();
    if (isset($GLOBALS['page_stack'])) {
        // retrieve current page stack
        $page_stack = $GLOBALS['page_stack'];
    } else {
        // create an empty page stack
        $page_stack = array();
    } // if

    if (array_key_exists($task_id, $page_stack)) {
        // task is within current stack, so remove anything which follows
        $end = end($page_stack); // get the last value
        while (key($page_stack) != $task_id) {
            $script_id = $end['script_id'];
            // remove this script's variables from session details
            if (isset($_SESSION[$script_id])) {
                if (isset($_SESSION[$script_id]['keep_data'])) {
                    if ($_SESSION[$script_id]['keep_data'] == 'N') {
                        unset($_SESSION[$script_id]);
                    } // if
                } // if
            } // if
            // remove page from page stack
            unset($page_stack[key($page_stack)]);
            $end = end($page_stack); // get the (new) last value
        } // while

        // remove specified task from the stack
        unset($page_stack[$task_id]);
    } // if

    return $page_stack;

} // reducePageStack

// ****************************************************************************
function scriptNext($task_id, $where=null, $selection=null)
// proceed to a new script identified in $task_id.
{
    //DebugBreak();
    if (empty($task_id)) {
        trigger_error(getLanguageText('sys0052'), E_USER_ERROR); // 'task id is not defined'
    } // if

    global $button_text;
    global $current_menu;
    global $current_task;
    global $initial_passthru;
    global $keep_data;
    global $menu_buttons;
    global $messages;
    global $order_by;
    global $order_by_body;
    global $page_stack;
    global $protocol;       // HTTP or HTTPS
    global $query_string;
    global $script_id;
    global $script_vars;
    global $selection_fixed;
    global $selection_temp;
    global $settings;
    global $sql_orderby;
    global $sql_orderby_seq;
    global $subsys_dir;
    global $title;

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    // ensure that latest set of script variables is stored in $_SESSION array
    // for the current task (indexed under [script_id][task_id])
    if (isset($_SESSION[$PHP_SELF]['task_id'])) {
        $curr_task = $_SESSION[$PHP_SELF]['task_id'];
        $_SESSION[$PHP_SELF][$curr_task] = $script_vars;
    } // if

    // ensure all keywords are in UPPER case
    $selection = eregi_replace("\) or \(", ") OR (", $selection);
    $where     = eregi_replace("\) or \(", ") OR (", $where);

    // 'script_sequence' identifies script(s) to be done before latest selection
    if (!empty($_SESSION['script_sequence'])) {
        $first = $_SESSION['script_sequence'][0];
        // check if requested task is at head of the array already
        if ($first['task_id'] <> $task_id) {
            // no it is not
            if (isset($first['script_id']) and $first['script_id'] == basename($PHP_SELF))  {
                // first entry is current script, so new selection has been requested from this
                // script. It therefore goes to the front of the array so it can return to the
                // current script when it has completed.
                $prepend['task_id'] = $task_id;
                array_unshift($_SESSION['script_sequence'], $prepend);
            } else {
                // add it to the end of the array
                $append['task_id'] = $task_id;
                if (isset($query_string)) {
                    $append['query_string'] = $query_string;
                    unset($query_string);
                } // if
                if (isset($where)) {
                    $append['where'] = $where;
                    unset($where);
                } // if
                if (isset($messages)) {
                    $append['messages'] = $messages;
                    unset($messages);
                } // if
                $append['previous'] = $PHP_SELF;
                array_push($_SESSION['script_sequence'], $append);
            } // if
        } // if

        // obtain first entry in array and process it now
        $first = $_SESSION['script_sequence'][0];
        $task_id = $first['task_id'];
        if (array_key_exists('query_string', $first)) {
            $query_string = $first['query_string'];
        } // if
        if (array_key_exists('where', $first)) {
            $where = $first['where'];
        } // if
        if (array_key_exists('messages', $first)) {
            $messages = $first['messages'];
        } // if
        if (array_key_exists('previous', $first)) {
            $previous = $first['previous'];
        } // if

        // if this is last entry in the sequence array then it can be cleared
        if (count($_SESSION['script_sequence']) == 1) {
            unset($_SESSION['script_sequence']);
        } // if
    } // if

    if (empty($script_id)) {
        $saved_settings = $settings;
        $settings = '';
        // $script_id not supplied yet - so translate $task_id into $script_id
        require_once 'classes/mnu_task.class.inc';
        $mnu_task =& singleton::getInstance('mnu_task');
        $mnu_task_array = $mnu_task->checkSelection($task_id);
        $errors = $mnu_task->getErrors();
        if ($errors) {
            // cannot continue, so abort
            trigger_error("$task_id - $errors[0]", E_USER_ERROR);
        } // if
        $script_id  = $mnu_task_array['script_id'];
        $subsys_dir = $mnu_task_array['subsys_dir'];
        $title      = $mnu_task_array['task_desc'];
        $settings = mergeSettings($settings, $saved_settings);
        if ($mnu_task_array['task_type'] == 'MENU') {
            $query_string = "selection={$mnu_task_array['task_id']}";
        } // if
        if (!empty($_SESSION['script_sequence'])) {
            $_SESSION['script_sequence'][0]['script_id'] = $script_id;
        } // if
    } // if

    if ($script_id == basename($script_id)) {
        // script name is not qualified, so insert directory name
        if (!empty($subsys_dir)) {
            $script_id = '/' .$subsys_dir .'/' .$script_id;
        } else {
            $script_id = dirname($PHP_SELF) .'/' .$script_id;
        } // if
    } // if

    if ($script_id == $PHP_SELF and $task_id == $_SESSION[$script_id]['task_id']) {
        // new script/task is same as current script/task, so do nothing
    } else {
        // look for session variables associated with this script
        if (isset($_SESSION[$script_id])) {
            if (isset($_SESSION[$script_id][$task_id])) {
                $script_vars = $_SESSION[$script_id][$task_id];
            } else {
                $script_vars = array();
            } // if
        } else {
            $script_vars = array();
        } // if
        // script may be accessed by more than one task_id, so ...
        // identify current task_id for this script
        $_SESSION[$script_id]['task_id'] = $task_id;

        if (isset($script_vars['script_count'])) {
            // script has already been executed, so do not load these variables
        } else {
            if (!empty($initial_passthru)) {
                $script_vars['initial_passthru'] = $initial_passthru;
            } // if
        } // if

        if (!empty($title)) {
            $script_vars['title'] = $title;
        } // if

        if (!empty($selection_fixed)) {
            $script_vars['where'] = $selection_fixed;
            // also append to $settings (after stripping any single quotes
            $selection_fixed = str_replace("'", '', $selection_fixed);
            if (empty($settings)) {
            	$settings = $selection_fixed;
            } else {
            	$settings .= '&' .$selection_fixed;
            } // if
        } elseif (!empty($where)) {
            $script_vars['where'] = $where;
        } // if

        if (!empty($selection_temp)) {
            $script_vars['search'] = $selection_temp;
        } // if

        if (!empty($selection)) {
            $script_vars['selection'] = $selection;
        } // if

        if (!empty($settings)) {
            $script_vars['settings'] = $settings;
        } // if

        if (!empty($button_text)) {
            $script_vars['button_text'] = $button_text;
        } // if

        if (!empty($menu_buttons)) {
            $script_vars['menu_buttons'] = $menu_buttons;
        } // if

        if (!empty($current_menu)) {
            $script_vars['current_menu'] = $current_menu;
        } // if

        if (!empty($page_stack)) {
            $script_vars['page_stack'] = $page_stack;
        } // if

        if (!empty($current_task)) {
            $script_vars['current_task'] = $current_task;
        } // if

        if (!empty($messages)) {
            $script_vars['messages'] = $messages;
        } // if

        // look for sorting parameters to be passed to the next script
        if (isset($sql_orderby)) {
            $script_vars['order_by']     = $sql_orderby;
            $script_vars['order_by_seq'] = $sql_orderby_seq;
        } elseif (!empty($order_by)) {
            $script_vars['order_by']     = $order_by;
        } // if
        if (!empty($order_by_body)) {
            $script_vars['order_by_body'] = $order_by_body;
        } // if

        if (!empty($keep_data)) {
            $_SESSION[$script_id]['keep_data'] = $keep_data;
        } // if
    } // if

    // ensure that latest set of script variables is stored in $_SESSION array
    // (indexed under [script_id][task_id])
    $_SESSION[$script_id][$task_id] = $script_vars;

    $location = $protocol .$_SERVER['HTTP_HOST']
                          .getParentDIR()
                          .$script_id
                          .'?session_name=' .session_name();
    if (isset($query_string)) {
        $location .= "&$query_string";
    } // if
    header('Location: ' .$location);
    exit;

} // scriptNext

// ****************************************************************************
function scriptPrevious($errors=null, $messages=NULL, $action=NULL, $instruction=NULL)
// go back to the previous script in the current hierarchy.
{
    //DebugBreak();
    global $protocol;       // HTTP or HTTPS

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    $script_id = $PHP_SELF;

    if (isset($this)) {
        if (method_exists($this, 'commit')) {
            // if we are executing from within a class then commit any outstanding updates
            // before switching to another script.
            $errors = $this->commit();
        } // if
    } // if

    // retrieve task_id for current script
    if (isset($_SESSION[$script_id]['task_id'])) {
        $task_id = $_SESSION[$script_id]['task_id'];
    } // if

    // get id of the previous script (and optional query string)
    global $query_string;
    $prev_script = getPreviousScript($task_id);
    $prev_task   = getPreviousTask($prev_script);

    // remove this script's variables from session details
    if (isset($_SESSION[$script_id])) {
        if (isset($_SESSION[$script_id]['keep_data'])) {
            if ($_SESSION[$script_id]['keep_data'] == 'N') {
                unset($_SESSION[$script_id]);
            } // if
        } // if
    } // if

    // 'script_sequence' identifies one or more scripts to be done in sequence
    if (isset($_SESSION['script_sequence'])) {
        // obtain first entry in array and examine its details
        $first = $_SESSION['script_sequence'][0];
        if ($first['task_id'] == $task_id) {
            if (isset($first['action'])) {
                if ($first['action'] <> $action) {
                    // current script did not terminate with required action,
                    // so it must be done again
                    scriptNext($first['task_id']);
                } // if
            } // if
            // script is done, so drop it from array
            $first = array_shift($_SESSION['script_sequence']);
        } // if

        if (empty($_SESSION['script_sequence'])) {
            // no more entries left, so clear this array
            unset($_SESSION['script_sequence']);
            global $page_stack;
            end($page_stack);
            $prev_script  = key($page_stack);
        } else {
            // obtain first entry in array and process it
            $first = $_SESSION['script_sequence'][0];
            global $page_stack;
            end($page_stack);
            $last  = key($page_stack);
            // is first entry same as last entry in current page stack?
            if ($first['task_id'] == $last) {
                // yes, so go back to previous script
            } else {
                // no, so remove current task from $page_stack
                unset($page_stack[$task_id]);
                // now go forwards to a new script
                scriptNext($first['task_id']);
            } // if
         } // if
    } // if

    if (isset($prev_script)) {
        // put any messages into session array
        if (!empty($messages)) {
            $_SESSION[$prev_script][$prev_task]['messages'] = $messages;
        } // if
        // put any errors into session array
        if (!empty($errors)) {
            $_SESSION[$prev_script][$prev_task]['errors'] = $errors;
        } // if
        // show which script we are leaving, and how ('ok' or 'quit')
        if (isset($action)) {
            $_SESSION[$prev_script][$prev_task]['return_action'] = $action;
        } // if
        // pass optional instruction back to the previous script
        if (isset($instruction)) {
            $_SESSION[$prev_script][$prev_task]['instruction'] = $instruction;
        } // if
        // identify where we are coming from
        $_SESSION[$prev_script][$prev_task]['return_from'] = $task_id;

        $location = $protocol .$_SERVER['HTTP_HOST']
                              .getParentDIR()
                              .$prev_script
                              .'?session_name=' .session_name();
        if (isset($query_string)) {
            $location .= "&$query_string";
        } // if
        header('Location: ' .$location);
        exit;
    } else {
        // no previous script, so go back to index page
        $location = $protocol .$_SERVER['HTTP_HOST']
                              .getParentDIR()
                              .'/';
        header('Location: ' .$location);
        exit;
    } // if

    return;

} // scriptPrevious

// ****************************************************************************
function scriptRestart (&$object, $query_string=null)
// restart the current script with an optional query string
{
    // ensure current transaction is completed
    $errors = $object->commit();
    if ($errors) return;

    if (isset($query_string)) {
    	$GLOBALS['query_string'] = $query_string;
    } // if

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    $GLOBALS['script_id'] = $PHP_SELF;

    // restart the current task
    scriptnext($GLOBALS['task_id']);

} // scriptRestart

// ****************************************************************************
function updatePageStack ($task_id, $task_desc, $script_id)
// update page stack with current selection.
{
    //DebugBreak();
    // remove redundant entries from page stack
    $page_stack = reducePageStack($task_id);

    // add current selection to stack
    $page_stack[$task_id]['task_desc'] = $task_desc;
    $page_stack[$task_id]['script_id'] = $script_id;

    // save data in global area
    $GLOBALS['page_stack'] = $page_stack;

    return $page_stack;

} // updatePageStack

// ****************************************************************************
?>