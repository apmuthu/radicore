<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions related to session management

global $session_name;
if (isset($_REQUEST['session_name'])) {
    // use session name passed via $_GET or $_POST
    $session_name = $_REQUEST['session_name'];
} // if

// custom session handler uses a database table, not disk files
$session_obj =& singleton::getInstance('php_session');
session_set_save_handler(array(&$session_obj, 'open'),
                         array(&$session_obj, 'close'),
                         array(&$session_obj, 'read'),
                         array(&$session_obj, 'write'),
                         array(&$session_obj, 'destroy'),
                         array(&$session_obj, 'gc'));

// ****************************************************************************
function checkSelection ($task_id, $where=null)
// a new selection has been made, so verify and process it.
{
    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    //require_once 'classes/mnu_task.class.inc';
    $dbtask =& singleton::getInstance('mnu_task');

    $task_array = $dbtask->checkSelection($task_id);
    $errors = $dbtask->getErrors();

    if ($errors) return $errors;

    if ($task_array['task_type'] == 'MENU') {

        unset($GLOBALS['current_task']);

        if ($task_id == $_SESSION['start_task_id']) {
            $page_stack = array();
            // update page stack with current selection
            $page_stack = updatePageStack($task_id, $GLOBALS['button_text'], $PHP_SELF);
        } else {
            // update page stack with latest selection
            $page_stack = updatePageStack($task_id, $task_array['button_text'], $PHP_SELF);
        } // if

        if ($PHP_SELF == '/menu/menu.php') {
            // get menu details for the chosen menu
            $dbmenu =& singleton::getInstance('mnu_menu');
            $menu_buttons = $dbmenu->getMenuButtons($task_id);
            // we are in menu page, so update script_vars now
            $GLOBALS['menu_buttons'] = $menu_buttons;
            $GLOBALS['current_menu'] = $task_id;
            $GLOBALS['script_vars']['menu_buttons'] = $menu_buttons;
            $GLOBALS['script_vars']['current_menu'] = $task_id;
            $GLOBALS['script_vars']['page_stack']   = $page_stack;
            // switch task_id to the generic home page
            $GLOBALS['task_id'] = 'menu';
            // ensure script variables are available throughout this session
            $_SESSION[$PHP_SELF]['menu'] = $GLOBALS['script_vars'];
        } else {
            // we are not in the menu page, so jump to it
            $menu_array['query_string'] = "selection=$task_id";
            scriptNext('menu', null, null, $menu_array);
        } // if

    } else {
        // not a menu, so process designated script instead
        scriptNext($task_id, $where, null, $task_array);
    } // if

    return $errors;

} // checkSelection

// ****************************************************************************
function childForm ($post, $object_array, $where=null)
// look for an action which is another script.
// (this may be from a navigation button or a popup button)
{
    if (is_array($object_array)) {
        $objectname = key($object_array);
    	$dbobject   = $object_array[$objectname];
    } else {
        $objectname = null;
        $dbobject   = null;
    } // if

    if (isset($post['task#previous_search'])) {
        // use previous search criteria (from one of two tables)
        if (!empty($dbobject->sql_search_table)) {
        	$search_table = $dbobject->sql_search_table;
        } else {
            $search_table = $dbobject->tablename;
        } // if
        if ($count = preg_match("/\w+ as \w+/i", $search_table, $regs)) {
            // entry contains 'table AS alias', so use original table table
        	list($original, $alias) = preg_split('/ as /i', $regs[0]);
        	$search_table = $original;
        } // if
        if (isset($_SESSION['search'][$search_table])) {
            $GLOBALS['search'] = $_SESSION['search'][$search_table];
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
            // obtain row number in which this button was pressed
            if (is_array($value)) {
            	$offset = key($value);
            } else {
                $offset = 1;
            } // if

            break;
        } // if
    } // foreach

    global $script_vars;

    if (isset($next_task)) {
        // check to see if this selection is valid
        $taskobj =& singleton::getInstance('mnu_task');
        $task_array = $taskobj->checkSelection($next_task);
        $errors = $taskobj->getErrors();
        if ($errors) return($errors);

        foreach ($object_array as $objectname => $object) {
            // save current values in session array
        	$script_vars[$objectname] = serialize($object);
        } // foreach

        // check to see if a popup/filepicker form has been called
        if (eregi('popup|filepicker', $task_array['pattern_id'], $regs)) {

            if (is_array($post[$key])) {
                // advance to last entry in array
            	$last       = end($object_array);
            	$objectname = key($object_array);
    	        $dbobject   = $object_array[$objectname];
            } // if

            if (is_object($dbobject)) {
                // save these details for processing after returning from the popup
                $script_vars['popup_object'] = $objectname;
        	    $script_vars['popup_offset'] = $offset;

                // get current data from this object
                $fieldarray = $dbobject->getFieldarray();
                // extract current row from array of rows
                $current_row = $fieldarray[$offset-1];
                // allow $where and $settings to be modified
            	$settings = null;
                $where = $dbobject->popupcall($next_task, $where, $script_vars, $current_row, $settings);
                $task_array['settings'] = mergeSettings($task_array['settings'], $settings);
            } // if
            // call popup script
            scriptNext($next_task, $where, null, $task_array);
        } // if

        // this must be from a navigation button
        if (isset($post['select'])) {
            if (count($object_array) > 1) {
                // advance to last entry in array
            	$last       = end($object_array);
            	$objectname = key($object_array);
    	        $dbobject   = $object_array[$objectname];
            } // if
            // convert selection into SQL where format
            $selection = selection2where($dbobject->getPkeyArray(), $post['select']);
        } else {
            $selection = null;
        } // if
		if (is_object($dbobject)) {
		    if ($next_task == 'audit_dtl(list)3') {
		    	$database_id = $dbobject->dbname;
		    	// restrict selection to current database
		    	$script_vars['search'] = "base_name='$database_id'";
		    } elseif ($next_task == 'audit_dtl(list)3exact') {
		    	$database_id = $dbobject->dbname;
		    	$table_id    = $dbobject->tablename;
		    	// restrict selection to current database and table
		    	$script_vars['search'] = "base_name='$database_id' AND table_name='$table_id'";
		    } else {
            	// extract any sort parameters from the current object
            	// so that they can be passed to the next task
            	$task_array['sql_orderby']     = $dbobject->getOrderBy();
            	$task_array['sql_orderby_seq'] = $dbobject->getOrderBySeq();
            	$search                        = $dbobject->getSearch();
            	if (!empty($search)) {
            	    if (eregi('^(list|output|srch)', $task_array['pattern_id'])) {
            	    	// merge the SEARCH and WHERE strings
                        $where = mergeWhere($where, $search);
            	    } // if
            	} // if
		    } // if
		} // if
        // pass control to selected script
        scriptNext($next_task, $where, $selection, $task_array);
    } // if

    // nothing found, so return to calling script
    return;

} // childForm

// ****************************************************************************
function chooseButton ($postarray, $dbobject)
// 'choose' button has been pressed, so ...
// look to see if there is a selection to send back to the previous screen.
{
    if (isset($postarray['choosenull'])) {
        // return a NULL selection
        $selection = selection2null($dbobject->getPkeyNames());
        // send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = $_SESSION[$prev_script]['task_id'];
        $_SESSION[$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } elseif (isset($postarray['select'])) {
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
function copyForm ($post, &$dbobject)
// copy $_POST array into a memory area so that it can be used in a PASTE.
// NOTE: $dbobject is passed by reference so that it can be updated.
{
    // get current object data
    $fieldarray = $dbobject->getFieldArray();

    if (!is_string(key($fieldarray))) {
        // index by row, so use row zero only
        $fieldarray = $fieldarray[0];
    } // if

    // merge posted data with current object data
    $fieldarray = array_update_associative($fieldarray, $post);

    // save contents inside object
    $dbobject->setFieldArray($fieldarray);

    // get field specifications for this object
    $fieldspec = $dbobject->getFieldSpec();

    // do not allow auto-insert/autoupdate fields to be copies
    foreach ($fieldspec as $field => $spec) {
        if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
            unset($fieldarray[$field]);
        } // if
    } // foreach

    // remove empty fields
    foreach ($fieldarray as $field => $value) {
    	if (strlen(trim($value)) == 0) {
    	    unset($fieldarray[$field]);
    	} // if
    } // foreach

    if (count($fieldarray) == 0) {
        // 'No data available to be copied'
        $messages[] = getLanguageText('sys0050');
        unset($_SESSION['data'][$dbobject->tablename]);
    } else {
        // save current data for re-use via 'paste' button
        $_SESSION['data'][$dbobject->tablename] = $fieldarray;
        // 'Data has been copied'
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
function getPatternId ($script_id=null)
// get the pattern_id of the specified script.
{
    if (empty($script_id)) {
        $script_id = getSelf();
    } // if

    $pattern_id = $_SESSION[$script_id]['pattern_id'];

    return $pattern_id;

} // getPatternId

// ****************************************************************************
function getPreviousScript ($curr_task=null)
// return the name of the previous script in the current page stack
// (the one that called the current script).
{
    $page_stack = $GLOBALS['page_stack'];

    if (empty($curr_task)) {
        $PHP_SELF = getSelf();
        if (isset($_SESSION[$PHP_SELF]['task_id'])) {
            // default to task_id of current script
            $curr_task = $_SESSION[$PHP_SELF]['task_id'];
        } else {
            return; // nothing to return
        } // if
    } // if

    if (array_key_exists($curr_task, $page_stack)) {
        // look for the current task in the page stack
        // (starting at the end and work backwards)
        $end           = end($page_stack);
        $end_script_id = $end['script_id'];
        $end_task_id   = key($page_stack);
        while ($end_task_id != $curr_task) {
            // not found, so go back one entry
            $previous     = prev($page_stack);
            $end_task_id  = key($page_stack);
        } // while
        // pointer is now at current, so go back one more
        $previous = prev($page_stack);
    } //if

    // get script_id of this entry
    if (isset($previous)) {
        $script_id = $previous['script_id'];
        if ($script_id == '/menu/menu.php') {
            global $query_string;
            $query_string = 'selection=' .key($page_stack);
        } // if
    } else {
        $script_id = null;
    } // if

    return $script_id;

} // getPreviousScript

// ****************************************************************************
function getPreviousTask ($script_id=null)
// get the task identity associated with the previous script.
{
    if (empty($script_id)) {
        $script_id = getPreviousScript();
    } // if

    $task_id = $_SESSION[$script_id]['task_id'];

    return $task_id;

} // getPreviousTask

// ****************************************************************************
function initSession()
// initialise session data
{
    global $button_text;        // button text for current task
    global $current_menu;       // currently active menu on menu bar
    global $current_task;       // currently active task on menu bar
    global $errors;             // array of error messages
    global $instruction;        // optional instruction returned by previous script
    global $language;           // language code (for internationalisation)
    global $keep_data;          // keep data in session after exit?
    global $lock_rows;          // lock database rows during transaction? FALSE/SH/EX
    global $lock_tables;        // lock database tables during transaction? TRUE/FALSE
    global $log_sql_query;      // Yes/No switch
    global $lookup;             // array of lookup values
    global $menu_buttons;       // array of menu buttons
    global $messages;           // optional array of messages
    global $order_by;           // field names for ORDER BY clause of SELECT
    global $order_by_seq;       // sequence ('asc' or 'desc')
    global $page_stack;         // hierarchy of pages used in this session
    global $pagination;         // pagination values
    global $popup_object;       //
    global $popup_offset;       //
    global $remove_buttons;     // tasks to be removed from navigation bar
    global $report;             // file containing report structure
    global $report_structure;   // stucture of screen for PDF document
    global $return_action;      // set when returning to previous screen
    global $return_from;        // set when returning to previous screen
    global $screen;             // file containing screen structure
    global $screen_structure;   // stucture of screen for XSL stylesheet
    global $screen_refresh;     // force screen to refresh every 'n' seconds
    global $script_count;       // number of times this script has been called in this cycle
    global $script_start;       // start time
    global $script_vars;        // variables belonging to current script
    global $scrolling;          // scrolling values
    global $search;             // extra selection criteria from search screen
    global $selection;          // a selection of rows made in one screen that is passed back to another
    global $session_name;       // session name, to allow multiple sessions from the same PC
    global $settings;           // optional string of settings
    global $sql_orderby;        // used in ORDER BY in an sql SELECT statement
    global $sql_orderby_seq;    // sequence ('asc' or 'desc')
    global $subsys_dir;         // directory in which subsystem is located
    global $task_id;            // current task identity on menu database
    global $task_order_by;      // ORDER BY defined in task parameters
    global $transaction_has_started;    // Yes/No switch
    global $title;              // script title
    global $where;              // selection criteria, used in SQL query
    global $XSLT_client_side;   // on/off switch for client-side XSL transformations

    $errors   = array();
    $messages = array();

    if ($_SERVER['PHP_SELF'] != $_SERVER['SCRIPT_NAME']) {
        // somebody has added '/something-else' to the URL, so remove it
    	$_SERVER['PHP_SELF'] = $_SERVER['SCRIPT_NAME'];
    } // if

    // continue with existing session, or start a new one
    $session_obj =& singleton::getInstance('php_session');
    if (!isset($_SESSION)) {
        if (isset($session_name)) {
            session_name($session_name);    // set the session name
        } // if
        if (isset($_GET['session_id'])) {
            session_id($_GET['session_id']);    // set the session id
        } // if
        session_start();                    // open/reopen session
    } // if

    //logstuff("session_id: " .session_id(), __FUNCTION__, __LINE__);

    $PHP_SELF = getSelf();

	// look for session variables associated with the current script
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

    if (!isset($GLOBALS['log_sql_query'])) {
        // default settng is OFF
        $GLOBALS['log_sql_query'] = false;
    } // if
    if (isset($_SESSION['log_sql_query'])) {
        // override global setting with that from session data screen
        $GLOBALS['log_sql_query'] = $_SESSION['log_sql_query'];
    } else {
        // save global setting in session array
        $_SESSION['log_sql_query'] = $GLOBALS['log_sql_query'];
    } // if
    if (isset($script_vars['log_sql_query'])) {
        if (is_True($script_vars['log_sql_query'])) {
            // turn this ON for current script
            $GLOBALS['log_sql_query'] = true;
        } // if
    } // if

    // write start details to query log file, if option is turned on
    logSqlQuery (null, null, "\r\n***** " .$PHP_SELF .' ' .date('Y-m-d H:i:s'));

    list($shutdown_errors, $shutdown_messages) = getShutDownStatus();

    if (!empty($shutdown_errors)) {
    	if (isset($GLOBALS['mode']) and $GLOBALS['mode'] == 'logon') {
    	    // on LOGON screen, so convert error to a warning message
    	    $shutdown_messages = $shutdown_errors;
    		$shutdown_errors   = array();
    	} elseif (strtoupper($_SESSION['role_id']) == 'GLOBAL') {
    	    // user is administrator, so convert error to a warning message
    		$shutdown_messages = $shutdown_errors;
    		$shutdown_errors   = array();
    	} else {
            // not adminstrator, so cancel current screen and go back to logon screen
            $location = 'HTTP://' .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .'/menu/logon.php'
                                  .'?session_name=' .session_name();
            if (is_true($XSLT_client_side)) {
    	        $location .= '&csxslt=on';
            } // if

            //logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;
    	} // if
    } // if

    unset($_SESSION['global_access']); // ensure that data is re-fetched for each page

    if (!array_key_exists('XSLT_client_side', $_SESSION)) {
        // default is FALSE or OFF
    	$_SESSION['XSLT_client_side'] = FALSE;
    } // if
    if (isset($_GET['csxslt'])) {
        if (eregi('on|true', $_GET['csxslt'], $regs)) {
        	$_SESSION['XSLT_client_side'] = TRUE;
        } // if
    } // if
    if (is_True($XSLT_client_side)) {
	   $_SESSION['XSLT_client_side'] = TRUE;
    } // if
    $XSLT_client_side = $_SESSION['XSLT_client_side'];

    if (is_True($_SESSION['XSLT_client_side'])) {
    	if (eregi('(MSIE)', $_SERVER['HTTP_USER_AGENT'])) {
    	    //if ($_SERVER['REMOTE_ADDR'] != '80.177.120.119') {
        	    // this combination does not work with a secure server
        	    $GLOBALS['http_server']  = '';
                $GLOBALS['https_server'] = '';
                $GLOBALS['https_server_suffix'] = '';
    	    //} // if
    	} // if
    } // if

    if (isset($_COOKIE['theme'])) {
        $_SESSION['css_file'] = $_COOKIE['theme'];
    } // if

    if (!array_key_exists('css_file', $_SESSION)) {
        // not yet defined, so set to default
    	$_SESSION['css_file'] = 'default';
    } // if

    if (isset($_GET['action'])) {
	    if ($_GET['action'] == 'logout_all') {
	        // remove all cookies which refer to application sessions
	        foreach($_COOKIE as $cookie_name => $cookie_id) {
	            if (preg_match('/^(menu|phpsessid)/', $cookie_name, $regs)) {
                    setcookie($cookie_name, '', time()-42000, '/');
                    $session_obj->destroy($cookie_id);
	            } // if
	        } // if
	    } // if
	    if ($_GET['action'] == 'logout' or $_GET['action'] == 'logout_all') {
	        // clear current session data
	        $_SESSION = array();
	        $session_obj->destroy(session_id());
            // go back to logon screen
            $location = 'HTTP://' .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .'/menu/logon.php'
                                  .'?session_name=' .session_name();
            if (is_true($XSLT_client_side)) {
    	       $location .= '&csxslt=on';
            } // if

            //logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;
	    } // if
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
	    if ($_GET['action'] == 'recoverpswd') {
            // switch to specified task
            $_SESSION['role_id'] = 'GLOBAL';
            scriptNext('mnu_user(pswd)', 'true=false');
	    } // if
	} // if

	// look for security class from logon screen
    if (!isset($_SESSION['role_id'])) {
        if ($PHP_SELF != '/menu/logon.php'
        and (basename($PHP_SELF) != 'help.php')) {
            // not supplied yet, so jump to logon screen
            if (isset($_SESSION['XSLT_client_side'])) {
    	       $XSLT_client_side = $_SESSION['XSLT_client_side'];
            } // if
            session_unset();
            if (is_true($XSLT_client_side)) {
    	       $_SESSION['XSLT_client_side'] = true;
            } // if
            $_SESSION['messages'] = getLanguageText('sys0000'); // 'You must log in to access this system.'
            $location = 'HTTP://' .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .'/menu/logon.php'
                                  .'?session_name=' .session_name();

            //logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;
        } // if
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
    	//$errors[] = getLanguageText('sys0078', $country);
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

    if ($PHP_SELF == '/menu/logon.php') {
        // always true for logon screen
        $use_https = true;
    } elseif (isset($script_vars['use_https'])) {
        // optional for other scripts
        $use_https = $script_vars['use_https'];
    } else {
        $use_https = false;
    } // if

    if (is_True($use_https)) {
        // check that a secure server has been defined
        if (strlen($GLOBALS['https_server']) > 0) {
            // check that this script is using secure HTTPS protocol
        	if (empty($_SERVER['HTTPS'])) {
        	    // it is not, so redirect
        	    session_write_close();
        	    $location = 'HTTPS://' .$GLOBALS['https_server']
        	                           .$GLOBALS['https_server_suffix']
        	                           .getParentDIR()
        	                           .$PHP_SELF;
        	    $location .= '?session_id=' .session_id();
        	    if (is_true($XSLT_client_side)) {
        	       $location .= '&csxslt=on';
                } // if
        	    if (!empty($_SERVER['QUERY_STRING'])) {
        	    	$location .= '&' .$_SERVER['QUERY_STRING'];
        	    } // if

                //logstuff("location: $location", __FUNCTION__, __LINE__);

                header('Location: ' .$location);
                exit;
        	} // if
        } // if
    } else {
        // check that this script is NOT using secure HTTPS protocol
        if (!empty($_SERVER['HTTPS'])) {
            // it is, so redirect to standard HTTP server
            $location = 'HTTP://' .$GLOBALS['http_server']
                                 .getParentDIR()
                                 .$PHP_SELF;
            $location .= '?session_id=' .session_id();
            if (is_true($XSLT_client_side)) {
               $location .= '&csxslt=on';
            } // if
            if (!empty($_SERVER['QUERY_STRING'])) {
               $location .= '&' .$_SERVER['QUERY_STRING'];
            } // if

            //$location .= '&redirect=true';

            //logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;
        } // if
    } // if

    if (!isset($_SESSION['log_xml_document'])) {
        // ensure there is a value in the $_SESSION array
    	$_SESSION['log_xml_document'] =& $GLOBALS['log_xml_document'];
    } // if

    if (empty($script_vars)) {
        if (basename($PHP_SELF) == 'help.php') {
            // do nothing
        } elseif ($PHP_SELF != '/menu/logon.php') {
            // not allowed to be empty, so go back to last valid script
            if (!empty($page_stack)) {
            	$page_stack = $_SESSION['page_stack'];
                $end = end($page_stack); // get the last value
                $script_id = $end['script_id'];
            } else {
                // not found, so default to logon screen
                $script_id = '/menu/logon.php';
            } // if
            if (!empty($_SERVER['HTTPS'])) {
                $location = 'HTTPS://' .$GLOBALS['https_server'] .$GLOBALS['https_server_suffix'];
            } else {
                $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
            } // if
            $location .= getParentDIR()
                        .$script_id
                        .'?session_name=' .session_name();

            //logstuff("location: $location", __FUNCTION__, __LINE__);

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
    if (isset($script_vars['task_order_by'])) {
        $task_order_by = $script_vars['task_order_by'];
    } // if

    if (isset($_GET['selection'])) {
        // a new selection has been made ....

        if (!array_key_exists($_GET['selection'], $page_stack)) {
            // new selection does not exist in current stack, so ...
            if (!isset($current_task)) {
                // remove anything which follows current menu from $page_stack
                $page_stack = reducePageStack($current_menu, true);
            } else {
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
        $errors = array_merge($errors, checkSelection($_GET['selection']));
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
        $messages = array_merge($messages, (array)$script_vars['messages']);
        unset($script_vars['messages']);
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

    // check for details concerned with a popup form.
    if (isset($script_vars['popup_object'])) {
        $popup_object = $script_vars['popup_object'];
        unset ($script_vars['popup_object']);
    } // if
    if (isset($script_vars['popup_offset'])) {
        $popup_offset = $script_vars['popup_offset'];
        unset ($script_vars['popup_offset']);
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
        if ($return_from == 'pdf') {
            // PDF document was displayed in browser window, so return is via BACK button.
            // HTTP requests that have already been processed must be removed.
        	unset($_GET['orderby']);
        } // if
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

    // get current pagination information
    if (isset($script_vars['screen_refresh'])) {
        $screen_refresh = $script_vars['screen_refresh'];
    } // if

    if (isset($screen)) {
    	// get subdirectory which matches user's language code
        $subdir = getLanguageSubDir ('./screens');

        $screen = "$subdir/$screen";  // look in subirectory for this screen name
        if (!file_exists($screen)) {
            // 'File $screen cannot be found'
            trigger_error(getLanguageText('sys0056', $screen), E_USER_ERROR);
        } // if

        require $screen;                // import contents of disk file
        $screen_structure = $structure; // move to global space
    } // if

    if (isset($report)) {
    	// get subdirectory which matches user's language code
        $subdir = getLanguageSubDir ('./reports');

        $report = "$subdir/$report";  // look in subirectory for this screen name
        if (!file_exists($report)) {
            // 'File $report cannot be found'
            trigger_error(getLanguageText('sys0056', $report), E_USER_ERROR);
        } // if

        require $report;                // import contents of disk file
        $report_structure = $structure; // move to global space
    } // if

    if (isset($shutdown_errors)) {
    	$errors = array_merge($errors, $shutdown_errors);
    } // if
    if (isset($shutdown_messages)) {
    	$messages = array_merge($messages, $shutdown_messages);
    } // if

    return;

} // initSession

// ****************************************************************************
function reducePageStack ($task_id, $keep_entry=false)
// remove entries which follow $task_id from the page stack.
// (this causes page stack to contain only those pages which are current).
// if $keep_entry=FALSE then $task_id is removed as well.
{
    if (isset($GLOBALS['page_stack'])) {
        // retrieve current page stack
        $page_stack = $GLOBALS['page_stack'];
    } else {
        // create an empty page stack
        $page_stack = array();
    } // if

    if (array_key_exists($task_id, $page_stack)) {
        // task is within current stack, so remove anything which follows
        while (array_key_exists($task_id, $page_stack)) {
            // pick out the last entry on he stack
            $end           = end($page_stack);
        	$end_script_id = $end['script_id'];
        	$end_task_id   = key($page_stack);
        	if ($end_task_id == $task_id) {
        	    break;
        	} else {
        	    if ($end_script_id == '/menu/menu.php') {
        	        // leave menus alone!
        	    } else {
        	    	// remove this script's variables from session details if required
                    if (isset($_SESSION[$end_script_id])) {
                        if (isset($_SESSION[$end_script_id][$end_task_id]['keep_data'])) {
                            if (is_True($_SESSION[$end_script_id][$end_task_id]['keep_data'])) {
                                // keep script data in memory
                            } else {
                                unset($_SESSION[$end_script_id][$end_task_id]);
                            } // if
                        } else {
                            unset($_SESSION[$end_script_id][$end_task_id]);
                        } // if
                    	if (count($_SESSION[$end_script_id]) == 1) {
                            // no more tasks left for this script, so remove it from session array
                        	unset($_SESSION[$end_script_id]);
                        } // if
                    } // if
        	    } // if

                // remove page from page stack
                unset($page_stack[$end_task_id]);

        	} // if
        } // while
        if ($keep_entry) {
        	// do not delete this entry
        } else {
            // remove page from page stack (it may be added back later)
            unset($page_stack[$task_id]);
        } // if
    } // if

    return $page_stack;

} // reducePageStack

// ****************************************************************************
function updateScriptVars ($script_vars=null)
// update $script_vars with certain global variables so that they are available
// later in the same session.
{
    if (!isset($script_vars)) {
    	$script_vars = $GLOBALS['script_vars'];
    } // if

    unset($script_vars['selection']);   // this has already been used once, so remove it

    $PHP_SELF = getSelf();              // reduce PHP_SELF to '/dir/file.php'
    $task_id  = $GLOBALS['task_id'];    // name of current task

    // save details in session array, keyed by script_id and task_id
    $_SESSION[$PHP_SELF][$task_id] = $script_vars;

    return $script_vars;

} // saveScriptVars

// ****************************************************************************
function scriptNext ($task_id, $where=null, $selection=null, $task_array=array())
// proceed to a new script identified in $task_id.
{
    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        $errors[] = getLanguageText('sys0038'); // 'Not allowed in batch mode'
    	return $errors;
    } // if

    if (empty($task_id)) {
        trigger_error(getLanguageText('sys0052'), E_USER_ERROR); // 'task id is not defined'
    } // if

    global $current_menu;
    global $current_task;
    global $menu_buttons;
    global $messages;
    global $order_by;
    global $page_stack;
    global $script_vars;

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    // ensure that latest set of script variables is stored in $_SESSION array
    // for the current task (indexed under [script_id][task_id])
    if (isset($_SESSION[$PHP_SELF]['task_id'])) {
        $curr_task = $_SESSION[$PHP_SELF]['task_id'];
        $_SESSION[$PHP_SELF][$curr_task] = $script_vars;
        // do not save anything set in childform() method
        unset($_SESSION[$PHP_SELF][$curr_task]['search']);
    } // if

    // ensure all keywords are in UPPER case
    $selection = eregi_replace("\) or \(", ") OR (", $selection);
    $where     = eregi_replace("\) or \(", ") OR (", $where);

    if (isset($task_array['query_string'])) {
    	$query_string = $task_array['query_string'];
    } else {
        $query_string = null;
    } // if

    if (isset($task_array['settings'])) {
    	$settings_bf = $task_array['settings'];
    } else {
        $settings_bf = null;
    } // if

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
                if (!empty($messages)) {
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

    if (!isset($task_array['script_id'])) {
        // $script_id not supplied yet - so translate $task_id into $script_id
        //require_once 'classes/mnu_task.class.inc';
        $taskobj =& singleton::getInstance('mnu_task');
        $task_array = $taskobj->checkSelection($task_id);
        $errors = $taskobj->getErrors();
        if ($errors) {
            // cannot continue, so abort
            trigger_error("$task_id - $errors[0]", E_USER_ERROR);
        } // if
        if ($task_array['task_type'] == 'MENU') {
            $query_string = "selection={$task_array['task_id']}";
        } // if
        if (!empty($_SESSION['script_sequence'])) {
            $_SESSION['script_sequence'][0]['script_id'] = $script_id;
        } // if
    } // if

    $script_id = $task_array['script_id'];

    $settings = mergeSettings($task_array['settings'], $settings_bf);

    if ($script_id == basename($script_id)) {
        // script name is not qualified, so insert directory name
        if (!empty($task_array['subsys_dir'])) {
            $script_id = '/' .$task_array['subsys_dir'] .'/' .$script_id;
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
                unset($script_vars['where']);
                unset($script_vars['selection']);
                unset($script_vars['order_by']);
                unset($script_vars['messages']);
            } else {
                $script_vars = array();
            } // if
        } else {
            if (isset($script_vars['search'])) {
            	$search = $script_vars['search'];
            } // if
            $script_vars = array();
            if (isset($search)) {
            	$script_vars['search'] = $search;
            } // if
        } // if
        // script may be accessed by more than one task_id, so ...
        // identify current task_id for this script
        $_SESSION[$script_id]['task_id']    = $task_id;
        $_SESSION[$script_id]['pattern_id'] = $task_array['pattern_id'];

        if (isset($script_vars['script_count'])) {
            // script has already been executed, so do not load these variables
        } else {
            if (!empty($task_array['initial_passthru'])) {
                $script_vars['initial_passthru'] = $task_array['initial_passthru'];
            } // if
        } // if

        if (!empty($task_array['task_desc'])) {
            $script_vars['title'] = $task_array['task_desc'];
        } // if

        if (!empty($task_array['selection_fixed'])) {
            $script_vars['where'] = $task_array['selection_fixed'];
            // also append to $settings (after stripping any single quotes
            $selection_fixed = str_replace("'", '', $task_array['selection_fixed']);
            if (empty($settings)) {
            	$settings = $selection_fixed;
            } else {
            	$settings .= '&' .$selection_fixed;
            } // if
        } else {
            if (!empty($where)) {
                $script_vars['where'] = $where;
            } // if
        } // if

        if (!empty($task_array['selection_temp'])) {
            $script_vars['search'] = $task_array['selection_temp'];
        } // if

        if (isset($selection)) {
            $script_vars['selection'] = $selection;
        } // if

        if (!empty($settings)) {
            $script_vars['settings'] = $settings;
        } // if

        if (!empty($task_array['button_text'])) {
            $script_vars['button_text'] = $task_array['button_text'];
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
        if (isset($task_array['sql_orderby'])) {
            $script_vars['order_by']     = $task_array['sql_orderby'];
            $script_vars['order_by_seq'] = $task_array['sql_orderby_seq'];
        } elseif (!empty($order_by)) {
            $script_vars['order_by']     = $order_by;
        } // if

        if (!empty($task_array['order_by'])) {
            // defines sort order for CHILD in a PARENT-CHILD screen
            $script_vars['task_order_by'] = $task_array['order_by'];
        } // if

        if (!empty($task_array['keep_data'])) {
            $script_vars['keep_data'] = $task_array['keep_data'];
        } // if

        if (!empty($task_array['log_sql_query']) AND is_True($task_array['log_sql_query'])) {
            $script_vars['log_sql_query'] = $task_array['log_sql_query'];
        } else {
            unset($script_vars['log_sql_query']);
        } // if

        if (!empty($task_array['screen_refresh'])) {
            $script_vars['screen_refresh'] = $task_array['screen_refresh'];
        } else {
            unset($script_vars['screen_refresh']);
        } // if

        if (is_True($task_array['use_https'])) {
            $script_vars['use_https'] = 'Y';
        } else {
            unset($script_vars['use_https']);
        } // if
    } // if

    // ensure that latest set of script variables is stored in $_SESSION array
    // (indexed under [script_id][task_id])
    $_SESSION[$script_id][$task_id] = $script_vars;

    if (!empty($_SERVER['HTTPS'])) {
        $location = 'HTTPS://' .$GLOBALS['https_server'] .$GLOBALS['https_server_suffix'];
    } else {
        $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
    } // if
    $location .= getParentDIR()
                .$script_id
                .'?session_name=' .session_name();
    if (isset($query_string)) {
        $location .= "&$query_string";
    } // if

    //logstuff("location: $location", __FUNCTION__, __LINE__);

    header('Location: ' .$location);
    exit;

} // scriptNext

// ****************************************************************************
function scriptPrevious($errors=null, $messages=NULL, $action=NULL, $instruction=NULL)
// go back to the previous script in the current hierarchy.
{
    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
    	return $errors;
    } // if

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
    } else {
        $task_id = '*unknown*';
    } // if

    // get id of the previous script (and optional query string)
    global $query_string;
    $prev_script = getPreviousScript($task_id);
    $prev_task   = getPreviousTask($prev_script);

    // remove this script's variables from session details (if necessary)
    if (isset($_SESSION[$script_id])) {
        if (isset($_SESSION[$script_id][$task_id])) {
            if (isset($_SESSION[$script_id][$task_id]['keep_data'])) {
                if (is_True($_SESSION[$script_id][$task_id]['keep_data'])) {
                    // keep script data in memory
                } else {
                    unset($_SESSION[$script_id][$task_id]);
                } // if
            } else {
                unset($_SESSION[$script_id][$task_id]);
            } // if
            $remove = true;
            foreach ($_SESSION[$script_id] as $key => $value) {
            	if (is_array($value)) {
            		$remove = false;
            		break;
            	} // if
            } // foreach
            if ($remove === true) {
                // no arrays of task details left, so remove this entry
            	unset($_SESSION[$script_id]);
            } // if
        } else {
            unset($_SESSION[$script_id]);
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
            // continue with last entry in $page_stack
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

        if (!empty($_SERVER['HTTPS'])) {
            $location = 'HTTPS://' .$GLOBALS['https_server'] .$GLOBALS['https_server_suffix'];
        } else {
            $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
        } // if
        $location .= getParentDIR()
                    .$prev_script
                    .'?session_name=' .session_name();
        if (isset($query_string)) {
            $location .= "&$query_string";
        } // if

        //logstuff("location: $location", __FUNCTION__, __LINE__);

        header('Location: ' .$location);
        exit;
    } else {
        if (!empty($messages)) {
            $_SESSION['messages'] = $messages;
            session_write_close();
        } // if
        // no previous script, so go back to logon page
        if (!empty($_SERVER['HTTPS'])) {
            $location = 'HTTPS://' .$GLOBALS['https_server'] .$GLOBALS['https_server_suffix'];
        } else {
            $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
        } // if
        $location .= getParentDIR()
                   .'/menu/logon.php'
                   .'?session_id=' .session_id();

        if (is_true($XSLT_client_side)) {
	        $location .= '&csxslt=on';
        } // if

        //logstuff("location: $location", __FUNCTION__, __LINE__);

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
    	$task_array['query_string'] = $query_string;
    } // if

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    $task_array['script_id'] = $PHP_SELF;

    // restart the current task
    scriptNext($GLOBALS['task_id'], null, null, $task_array);

} // scriptRestart

// ****************************************************************************
function updatePageStack ($task_id, $task_desc, $script_id)
// update page stack with current selection.
{
    // remove redundant entries from page stack
    $page_stack = reducePageStack($task_id);

    // add current selection to stack
    $page_stack[$task_id]['button_text'] = $task_desc;
    $page_stack[$task_id]['script_id']   = $script_id;

    // save data in global area
    $GLOBALS['page_stack'] = $page_stack;

    return $page_stack;

} // updatePageStack

// ****************************************************************************
?>