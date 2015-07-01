<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions related to session management

global $session_name;
if (isset($_REQUEST['session_name'])) {
    // use session name passed via $_GET or $_POST
    $session_name = $_REQUEST['session_name'];
} // if

// ****************************************************************************
function checkSelection ($task_id, $where=null)
// a new selection has been made, so verify and process it.
{
    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    if ($PHP_SELF == '/menu/menu.php' AND $task_id == 'menu') {
        // task_id has been lost because of initial_passthru, so reset it
        $task_id = $_SESSION['start_task_id'];
    } // if

    //require_once 'classes/mnu_task.class.inc';
    $dbtask =& RDCsingleton::getInstance('mnu_task');

    $task_array = $dbtask->checkSelection($task_id);
    $errors = $dbtask->getErrors();

    if ($errors) return $errors;

    $GLOBALS['orderby'] = null;  // do not carry forward this value

    if ($task_array['task_type'] == 'MENU') {

        // this is a new menu, so no tab is active yet
        unset($GLOBALS['current_menu_tab']);
        if (empty($GLOBALS['button_text'])) {
            $GLOBALS['button_text'] = $task_array['button_text'];
        } // if

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
            $dbmenu =& RDCsingleton::getInstance('mnu_menu');
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
            $_SESSION['pages'][$PHP_SELF]['menu'] = $GLOBALS['script_vars'];
        } else {
            // we are not in the menu page, so jump to it
            $menu_array['query_string'] = "selection=$task_id";
            $errors = scriptNext('menu', null, null, $menu_array);
        } // if

    } else {
        // not a menu, so process designated script instead
        $errors = scriptNext($task_id, $where, null, $task_array);
    } // if

    return $errors;

} // checkSelection

// ****************************************************************************
function childForm ($post, $object_array, $where=null)
// look for an action which is another script.
// (this may be from a navigation button or a popup button)
{
    global $script_vars;

    if (is_array($object_array)) {
        foreach ($object_array as $objectname => $object) {
            // save current values in session array
            $object->messages = array();
        	$script_vars[$objectname] = serialize($object);
        } // foreach
        // set to last entry in array
    	$null       = end($object_array);
    	$objectname = key($object_array);
        $dbobject   = $object_array[$objectname];
        unset($null);
    } else {
        $objectname = null;
        $dbobject   = null;
    } // if

    if (isset($post['rdc_selection_lock'])) {
    	$_SESSION['selection_lock'] = $post['rdc_selection_lock'];
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
        if (is_array($_SESSION['search']) AND isset($_SESSION['search'][$search_table])) {
            $GLOBALS['search'] = $_SESSION['search'][$search_table];
        } // if
        // this is a dummy button, so clear it
        unset($_POST);
        return;
    } // if

    $pattern_id = getPatternId();  // pattern for the current task

    foreach ($post as $key => $value) {
        // look for a variable beginning with 'task#' or 'favourite#'
        if (preg_match('/^(task#|favourite#)/i', $key, $regs)) {
            // strip pattern prefix
            $next_task = str_replace($regs[0], '', $key);
            // note: if the button is replaced with an image the key name returned
            // will be appended by '_x' as part of the x/y coordinates of the image.
            if (preg_match('/_x$/i', $next_task)) {
                // '_x' found, so strip it off.
                $next_task = substr_replace($next_task, '', -2);
            } // if
            // obtain row number in which this button was pressed
            if (is_array($value)) {
            	$offset   = key($value);
            	$multiple = true;
            } else {
                $offset   = 1;
                $multiple = false;
            } // if

            break;
        } // if
    } // foreach

    if (!isset($next_task)) {
        return;
    } // if

    // check to see if this selection is valid
    $taskobj =& RDCsingleton::getInstance('mnu_task');
    $task_array = $taskobj->checkSelection($next_task);
    if ($taskobj->errors) {
    	return $taskobj->errors;
    } // if

    if ($regs[0] == 'favourite#') {
    	// a favourite has been chosen, so rebuild menu bar and breadcrumbs area
    	$favObj = RDCsingleton::getInstance('mnu_favourite');
    	$result = $favObj->rebuildBreadcrumbs($_SESSION['logon_user_id'], $next_task, $task_array);
    	unset($favObj);
    } // if

    // check to see if a popup/filepicker/fileupload form has been called
    if (preg_match('/(popup|filepicker|fileupload)/i', $task_array['pattern_id'], $regs)) {
        if (is_object($dbobject)) {
            if (!$multiple AND count($object_array) > 1) {
        		// set to previous object in array
            	$null       = prev($object_array);
            	$objectname = key($object_array);
                $dbobject   = $object_array[$objectname];
        	} // if
            // save these details for processing after returning from the popup
            $script_vars['popup_object'] = $objectname;
    	    $script_vars['popup_offset'] = $offset;

            // get current data from this object
            $fieldarray = $dbobject->getFieldArray();
            if (is_long(key($fieldarray))) {
                $current_row = $fieldarray[$offset-1];  // extract current row from array of rows
            } else {
                $current_row = $fieldarray;  // only contains one row
            } // if

            if (isset($post['select']) AND preg_match('/(filepicker)/i', $task_array['pattern_id'], $regs)) {
                // convert selection into SQL where format
                $pkey_array = $dbobject->getPkeyArray($fieldarray, $task_array);
                $selection  = selection2where($pkey_array, $post['select']);
                if (is_True($_SESSION['selection_lock'])) {
                    $dbobject->select_string = $selection;
                    // serialise object contents for saving in session array
                    $script_vars[$objectname] = serialize($dbobject);
                } // if
                $where = $selection;
            } else {
                // extract current $where string from object
                $where = $dbobject->getWhere($task_array);
            } // if

            // allow $where and $settings to be modified
        	$settings = null;
            $where = $dbobject->popupcall($next_task, $where, $script_vars, $current_row, $settings);
            if ($dbobject->errors) {
        		return $dbobject->errors;
        	} // if
            if ($next_task != $task_array['task_id']) {
            	// task_id has changed, so...
            	$task_array = $taskobj->checkSelection($next_task);
            	if ($taskobj->errors) {
            		return $taskobj->errors;
            	} // if
            	$script_vars[$objectname] = serialize($dbobject);
            } // if
            $task_array['settings'] = mergeSettings($task_array['settings'], $settings);
        } // if
        // call popup script
        $errors = scriptNext($next_task, $where, null, $task_array);
    } // if

    if (is_object($dbobject)) {
    	$dbobject->select_string = null;
    } // if

    // this must be from a navigation button
    if (isset($post['select'])) {
        // convert selection into SQL where format
        $pkey_array = $dbobject->getPkeyArray(null, $task_array);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
            return $errors;
        } // if
        $selection = selection2where($pkey_array, $post['select']);
        if (is_True($_SESSION['selection_lock'])) {
        	$dbobject->select_string = $selection;
        } // if
    } else {
        $selection = null;
    } // if

    $search = null;
	if (is_object($dbobject)) {
	    // extract current $where string from object
        $where = $dbobject->getWhere($task_array);
	    if ($next_task == 'audit_dtl(list)3') {
            $database_id = $dbobject->dbname_server;
	    	// restrict selection to current database
	    	$search = "base_name='$database_id'";
	    } elseif ($next_task == 'audit_dtl(list)3exact') {
	    	$database_id = $dbobject->dbname_server;
	    	$table_id    = $dbobject->tablename;
	    	// restrict selection to current database and table
	    	$search = "base_name='$database_id' AND table_name='$table_id'";
	    } else {
        	// extract any sort parameters from the current object
        	// so that they can be passed to the next task
        	$task_array['sql_orderby']     = $dbobject->getOrderBy();
        	$task_array['sql_orderby_seq'] = $dbobject->sql_orderby_seq;
            if (empty($selection)) {
        	    $search                    = $dbobject->getSearch();
            } // if
        	if (!empty($search)) {
        	    if (preg_match('/^(list)/i', $task_array['pattern_id'])) {
        	    	// merge the SEARCH and WHERE strings
                    $where = mergeWhere($where, $search);
                    $search = null;
        	    } elseif (preg_match('/^(output|batch|other)/i', $task_array['pattern_id'])) {
        	        // leave $search string alone
        	    } else {
        	        $search = null;
        	    } // if
        	} // if
	    } // if
	} // if

	if (is_object($dbobject)) {
        // serialise object contents for saving in session array
		$script_vars[$objectname] = serialize($dbobject);
	} // if

	if (preg_match('/batch/i', $task_array['pattern_id'], $regs)) {
        // this is to be run in the background as a batch process
        if (!empty($where)) {
        	$task_array['where'] = $where;
        } // if
        if (!empty($search)) {
        	$task_array['search'] = $search;
        } // if
        if (!empty($selection)) {
        	$task_array['selection'] = $selection;
        } // if
        $errors = runInBackground($task_array, $script_vars);
        return $errors;
	} else {
        foreach ($object_array as $zone => $object) {
            // save objects in case there are changes which have yet to be saved to the database
            $script_vars[$zone] = serialize($object);
        } // foreach
        // pass control to selected script
        $errors = scriptNext($next_task, $where, $selection, $task_array, $search);
	} // if

    // nothing found, so return to calling script
    return $errors;

} // childForm

// ****************************************************************************
function chooseButton ($postarray, $dbobject, $objectname='dbobject')
// 'choose' button has been pressed, so ...
// look to see if there is a selection to send back to the previous screen.
{
    $PHP_SELF    = getSelf();  // reduce PHP_SELF to '/dir/file.php'
    $curr_task   = $_SESSION['pages'][$PHP_SELF]['task_id'];
    $prev_script = getPreviousScript();
    $prev_task   = $_SESSION['pages'][$prev_script]['task_id'];

    $errors   = array();
    $messages = array();

    if (isset($postarray['choosenull'])) {
        // return a NULL selection
        $selection = selection2null($dbobject->getPkeyNames());
        if (is_True($_SESSION['selection_lock'])) {
            // clear this selection
        	$dbobject->select_string = null;
        	// serialise object contents for saving in session array
        	$GLOBALS['script_vars'][$objectname] = serialize($dbobject);
    		$_SESSION['pages'][$PHP_SELF][$curr_task] = $GLOBALS['script_vars'];
        } // if
        // send selection back to the previous script
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');

    } elseif (isset($postarray['select'])) {
        $task_array['task_id']    = $prev_task;
        $task_array['pattern_id'] = $_SESSION['pages'][$prev_script]['pattern_id'];
        // convert selection into SQL where format
        $pkey_array = $dbobject->getPkeyArray(null, $task_array);
        $selection = selection2where($pkey_array, $postarray['select']);
        // perform any validation or processing on whatever has been selected
        $result = $dbobject->validateChooseButton($selection, $postarray['select']);
        $errors   = $dbobject->errors;
        $messages = $dbobject->messages;
        if (empty($errors)) {
            if (is_True($_SESSION['selection_lock'])) {
                // save this selection for next activation
        	    $dbobject->select_string = $selection;
        	    // serialise object contents for saving in session array
        	    $GLOBALS['script_vars'][$objectname] = serialize($dbobject);
                $_SESSION['pages'][$PHP_SELF][$curr_task] = $GLOBALS['script_vars'];
            } // if
            // send selection back to the previous script
            $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
            scriptPrevious(null, null, 'choose');
        } // if

    } else {
        $messages[] = getLanguageText('sys0081'); // 'Nothing has been selected yet.'
        //return $messages;
    } // if

    return array($errors, $messages);

} // choose button

// ****************************************************************************
function cleanSavedPages ($script_id, $task_id, $errors=array(), $selection=null)
// script has terminated, so check if its data can be removed from $_SESSION['pages']
{
    if (isset($_SESSION['pages'][$script_id])) {
        if (isset($_SESSION['pages'][$script_id][$task_id])) {
            if (empty($errors) AND isset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end'])) {
                // task has ended, so run this next
            	$next['task_id']    = $_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end'];
                if (!empty($selection) AND empty($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end_context'])) {
                    $next['where']  = $selection;
                } else {
                    $next['where']  = $_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end_context'];
                } // if
                $next['run_at_end'] = true;
                append2ScriptSequence($next, true);
                // these entries have been used, so remove them
                unset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end']);
                unset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_end_context']);
            } // if
            if (isset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_cancel'])) {
                // task has been cancelled, so run this next
            	$next['task_id']    = $_SESSION['pages'][$script_id][$task_id]['task_id_run_at_cancel'];
                $next['where']      = $_SESSION['pages'][$script_id][$task_id]['task_id_run_at_cancel_context'];
                append2ScriptSequence($next, true);
                // these entries have been used, so remove them
                unset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_cancel']);
                unset($_SESSION['pages'][$script_id][$task_id]['task_id_run_at_cancel_context']);
            } // if
            $keep_data =& $_SESSION['pages'][$script_id][$task_id]['keep_data'];
            if (is_True($keep_data)) {
                // keep script data in memory
            } else {
                // remove this task (there may be more than one) from this script
                unset($_SESSION['pages'][$script_id][$task_id]);
                unset($_SESSION['pages'][$script_id]['task_array'][$task_id]);
                if (count($_SESSION['pages'][$script_id]['task_array']) < 1) {
                	// no other tasks using this script, so remove this entry
                	unset($_SESSION['pages'][$script_id]);
                } else {
                    // replace task_id with the latest one in the array
                    $end  = end($_SESSION['pages'][$script_id]['task_array']);
                    $last = key($_SESSION['pages'][$script_id]['task_array']);
                    $_SESSION['pages'][$script_id]['task_id'] = $last;
                    // reload script_vars for this task
                    //$GLOBALS['script_vars'] = $_SESSION['pages'][$script_id][$last];
                } // if
            } // if
        } else {
            unset($_SESSION['pages'][$script_id]);
        } // if
    } // if

    return;

} // cleanSavedPages

// ****************************************************************************
function comparePageStacks ($session_stack, $script_stack)
// identify any entries in $session_stack which do not appear within $script_stack
// and see if they can be deleted.
{
    foreach ($session_stack as $task_id => $task_data) {
    	if (array_key_exists($task_id, $script_stack)) {
    		// this is OK, so do nothing
    	} else {
    	    $script_id = $task_data['script_id'];
            if (array_key_exists($script_id, $_SESSION['pages'])) {
                $page = $_SESSION['pages'][$script_id];
                $keep_data =& $page[$task_id]['keep_data'];
                if (is_True($keep_data)) {
                	// set to TRUE, so leave it alone
                } else {
                    // set to FALSE, so remove it
                    unset($session_stack[$task_id]);
                    // also check entry in $_SESSION['pages']
                    unset($_SESSION['pages'][$script_id][$task_id]);
                    unset($_SESSION['pages'][$script_id]['task_array'][$task_id]);
                    if (count($_SESSION['pages'][$script_id]['task_array']) < 1) {
                    	// no other tasks using this script, so remove this entry
                    	unset($_SESSION['pages'][$script_id]);
                    } else {
                        // replace task_id with the latest one in the array
                        $end = end($_SESSION['pages'][$script_id]['task_array']);
                        $last = key($_SESSION['pages'][$script_id]['task_array']);
                        $_SESSION['pages'][$script_id]['task_id'] = $last;
                    } // if
                } // if
            } else {
                // not found, so remove it
                unset($session_stack[$task_id]);
            } // if
    	} // if
    } // foreach

    return $session_stack;

} // comparePageStacks

// ****************************************************************************
function copyForm ($post, &$dbobject)
// copy $_POST array into a memory area so that it can be used in a PASTE.
// NOTE: $dbobject is passed by reference so that it can be updated.
{
    // get current object data
    $fieldarray = $dbobject->getFieldArray();

    if (is_long(key($fieldarray))) {
        // index by row, so use row zero only
        $fieldarray = $fieldarray[0];
    } // if

    // merge posted data with current object data
    $fieldarray = array_update_associative($fieldarray, $post, $dbobject->fieldspec);

    // change data from external to internal format
    $fieldarray = $dbobject->unFormatData($fieldarray);

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
        unset($_SESSION['data'][$dbobject->getClassName()]);
    } else {
        // save current data for re-use via 'paste' button
        $_SESSION['data'][$dbobject->tablename]      = $fieldarray;
        $_SESSION['data'][$dbobject->getClassName()] = $fieldarray;
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
function getPreviousPattern ($task_id=null)
// return the pattern of the previous script in the current page stack
// (the one that called the current script).
{
    $prev_script = getPreviousScript($task_id);

    if (isset($_SESSION['pages'][$prev_script]['pattern_id'])) {
		$pattern_id = $_SESSION['pages'][$prev_script]['pattern_id'];
    } else {
        $pattern_id = 'unknown';
	} // if

    return $pattern_id;

} // getPreviousPattern

// ****************************************************************************
function getPreviousScript ($curr_task=null)
// return the name of the previous script in the current page stack
// (the one that called the current script).
{
    $page_stack = $GLOBALS['page_stack'];

    if (empty($curr_task)) {
        $PHP_SELF = getSelf();
        if (isset($_SESSION['pages'][$PHP_SELF]['task_id'])) {
            // default to task_id of current script
            $curr_task = $_SESSION['pages'][$PHP_SELF]['task_id'];
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
    if (!empty($previous)) {
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

    if (isset($_SESSION['pages'][$script_id]) AND is_array($_SESSION['pages'][$script_id])) {
        $task_id = $_SESSION['pages'][$script_id]['task_id'];
    } elseif ($script_id == '/menu/menu.php') {
        $task_id = 'menu';
    } else {
        $task_id = null;
    } // if

    return $task_id;

} // getPreviousTask

// ****************************************************************************
function getShutDownStatus ()
// find out if the system has a scheduled shutdown time
{
    $errors   = array();
    $messages = array();

    if (!empty($_SESSION['empty_tables']) AND array_key_exists('SYSTEM_SHUTDOWN', $_SESSION['empty_tables'])) {
        // there is no data to lookup
    } else {
        $dbobject =& RDCsingleton::getInstance('mnu_control');
        $shutdown_data = $dbobject->getControlData('shutdown');
        unset($dbobject);

        $time = getTimeStamp('time');
        $dow  = date('l', time()); // get day of week (full name)
        $fieldname = 'shutdown_' .strtolower($dow);

        if (is_True($shutdown_data[$fieldname])) {
            // converts times from server timezone to client timezone
            $shutdown_start = getTimeStamp('date').' '.$shutdown_data['shutdown_start'];
            $shutdown_end   = getTimeStamp('date').' '.$shutdown_data['shutdown_end'];
            if (!empty($_SESSION['timezone_server']) AND !empty($_SESSION['timezone_client'])) {
                $shutdown_start = convertTZ($shutdown_start, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
                $shutdown_end   = convertTZ($shutdown_end,   $_SESSION['timezone_server'], $_SESSION['timezone_client']);
            } // if
            // there is a shutdown scheduled for this day...
            if ($shutdown_data['shutdown_warning'] <= $time AND $shutdown_data['shutdown_start'] >= $time) {
                // System will be shutting down between X and Y
                $messages[] = getLanguageText('sys0140', substr($shutdown_start, 11, 5), substr($shutdown_end, 11, 5));
            } // if
            if ($shutdown_data['shutdown_start'] <= $time AND $shutdown_data['shutdown_end'] >= $time) {
                // System has been shut down. It will be available at X
                $errors[] = getLanguageText('sys0141', substr($shutdown_end, 11, 5));
            } // if
        } // if
    } // if

    $result[] = $errors;
    $result[] = $messages;

    return $result;

} // getShutDownStatus

// ****************************************************************************
function getSupportedLanguages ()
// obtain list of languages which are supported in this installation
{
    $array = array();

    $dbobject =& RDCsingleton::getInstance('mnu_language');
    $dbobject->sql_select = 'language_id';
    $data = $dbobject->getData();
    foreach ($data as $rownum => $rowdata) {
    	$array[strtolower($rowdata['language_id'])] = $rowdata['language_id'];
    } // foreach

    return $array;

} // getSupportedLanguages

// ****************************************************************************
function getTimePeriodStatus ($user_id, $role_id)
// find out if any time periods have been set for this user or this role
{
    $errors   = array();
    $messages = array();

    $time = getTimeStamp('time');
    $dow  = date('l', time()); // get day of week (full name)
    $fieldname = 'scheduled_' .strtolower($dow);

    $query = "$fieldname=1 AND scheduled_start_time<='$time' AND scheduled_end_time>='$time'";

    if (!empty($_SESSION['empty_tables']) AND array_key_exists('mnu_time_limit_user', $_SESSION['empty_tables'])) {
        $count = 0;
    } else {
        $userOBJ =& RDCsingleton::getInstance('mnu_time_limit_user');
        $where = "user_id='$user_id' ";
        $count = $userOBJ->getCount($where);
    } // if
    if ($count > 0) {
        $data = $userOBJ->getData("$where AND $query");
        if (empty($data)) {
            // Your authorised time period has expired
            $errors[] = getLanguageText('sys0148');
        } else {
            $data = $data[0];
        } // if
    } else {
        // nothing found for user, so try again for role
        if (!empty($_SESSION['empty_tables']) AND array_key_exists('mnu_time_limit_role', $_SESSION['empty_tables'])) {
            $count = 0;
        } else {
            $roleOBJ =& RDCsingleton::getInstance('mnu_time_limit_role');
            $where = "role_id='$role_id'";
            $count = $roleOBJ->getCount($where);
        } // if
        if ($count > 0) {
            $data = $roleOBJ->getData("$where AND $query");
            if (empty($data)) {
                // Your authorised time period has expired
                $errors[] = getLanguageText('sys0148');
            } else {
                $data = $data[0];
            } // if
        } // if
    } // if

    if (!empty($data)) {
        // time period entry found, so how close are we to the end of this period?
        $minutes = getTimeDiff($time, $data['scheduled_end_time']);
        if ($minutes <= 5) {
            // Your authorised time period will expire at <time>
            $messages[] = getLanguageText('sys0147', $data['scheduled_end_time']);
        } // if
    } // if

    $result[] = $errors;
    $result[] = $messages;

    return $result;

} // getTimePeriodStatus

// ****************************************************************************
function initSession($save_session_data=array())
// initialise session data
{
    global $argv;               // command line arguments
    global $button_text;        // button text for current task
    global $current_menu;       // currently active menu on menu bar
    global $current_menu_tab;   // currently active tab on menu bar
    global $errors;             // array of error messages
    global $instruction;        // optional instruction returned by previous script
    global $keep_data;          // keep data in session after exit?
    global $lock_rows;          // lock database rows during transaction? FALSE/SH/EX
    global $lock_tables;        // lock database tables during transaction? TRUE/FALSE
    global $log_sql_query;      // Yes/No switch
    global $lookup;             // array of lookup values
    global $menu_buttons;       // array of menu buttons
    global $messages;           // optional array of messages
    global $nav_buttons_omit;   // tasks to be removed from navigation bar
    global $no_getdata;         // flag to ignore next getData() method
    global $orderby;            // field names for ORDER BY clause of SELECT
    global $orderby_seq;        // sequence ('asc' or 'desc')
    global $page_stack;         // hierarchy of pages used in this session
    global $pagination;         // pagination values
    global $popup_object;       //
    global $popup_offset;       //
    global $report;             // name of file containing report structure
    global $report_structure;   // report structure for PDF document
    global $return_action;      // set when returning to previous screen
    global $return_files;       // set when returning to previous screen
    global $return_from;        // set when returning to previous screen
    global $return_string;      // set when returning to previous screen (optional)
    global $screen;             // file containing screen structure
    global $screen_structure;   // stucture of screen for XSL stylesheet
    global $screen_refresh;     // force screen to refresh every 'n' seconds
    global $script_count;       // number of times this script has been called in this cycle
    global $script_start;       // start time
    global $script_vars;        // variables belonging to current script
    global $scrolling;          // scrolling values
    global $search;             // extra selection criteria from search screen
    global $quicksearch;        // extra selection criteria from list screen
    global $selection;          // a selection of rows made in one screen that is passed back to another
    global $session_name;       // session name, to allow multiple sessions from the same PC
    global $settings;           // optional array of settings
    global $sql_orderby;        // used in ORDER BY in an sql SELECT statement
    global $sql_orderby_seq;    // sequence ('asc' or 'desc')
    global $subsys_dir;         // directory in which subsystem is located
    global $task_id;            // current task identity on menu database
    global $task_orderby;       // ORDER BY defined in task parameters
    global $task_selection;     // selection criteria defined in task parameters
    global $transaction_has_started;    // Yes/No switch
    global $title;              // script title
    global $where;              // selection criteria, used in SQL query
    global $XSLT_client_side;   // on/off switch for client-side XSL transformations

    $errors   = array();
    $messages = array();

    if (basename($_SERVER['PHP_SELF']) != basename($_SERVER['SCRIPT_FILENAME'])) {
        // somebody has added '/something-else' to the URL, so remove it
        $array = explode('/', $_SERVER['PHP_SELF']);
        $key = array_search(basename($_SERVER['SCRIPT_FILENAME']), $array);
        $array = array_slice($array, 0, $key+1);
        $_SERVER['PHP_SELF'] = implode('/', $array);
    } // if

    if (!empty($GLOBALS['https_server_suffix']) AND preg_match('|^'.$GLOBALS['https_server_suffix'].'|i', $_SERVER['PHP_SELF'])) {
        // remove 'https_server_suffix' from PHP_SELF
        $_SERVER['PHP_SELF'] = substr($_SERVER['PHP_SELF'], strlen($GLOBALS['https_server_suffix']));
    } else {
        $PHP_SELF = str_replace($_SERVER['DOCUMENT_ROOT'], "", $_SERVER['SCRIPT_FILENAME']);
    } // if

    // write start details to query log file, if option is turned on
    logSqlQuery (null, null, "\r\n***** " .$PHP_SELF .' ' .date('Y-m-d H:i:s'));
    logstuff("PHP_SELF: $PHP_SELF", __FUNCTION__, __LINE__);

    if (!defined('NO_SESSION_HANDLER')) {
    	// continue with existing session, or start a new one
	    $session_obj =& RDCsingleton::getInstance('php_session');
	    if (isset($GLOBALS['batch'])) {
	        if (is_True($GLOBALS['batch'])) {
	            if (!empty($_SESSION)) {
	                $save_session_batch = $_SESSION;
	            } // if
	        } else {
	            unset($GLOBALS['batch']);
	        } // if
	    } // if
	} else {
		$save_session_batch = $_SESSION;
	} // if
    if (empty($_SESSION) OR isset($GLOBALS['batch'])) {
        if (!empty($argv)) {
            if ($argv[1] == 'PHPSESSID' AND !empty($argv[2])) {
                session_name($argv[1]);
                session_id($argv[2]);
                unset($argv);  // this is no longer required
            } // if
        } else {
            if (isset($session_name)) {
                session_name($session_name);    // set the session name
            } // if
            if (isset($_GET['session_id'])) {
                session_id($_GET['session_id']);    // set the session id
            } // if
        } // if
        if (!isset($_SESSION['pages'])) {
            $res = @session_start();                    // open/reopen session
            if (isset($save_session_batch)) {
                // do not overwrite certain values from the starting session
                if (!empty($_SESSION['role_id'])) {
            	    unset($save_session_batch['role_id']);
                } // if
                if (!empty($_SESSION['logon_user_id'])) {
    	            unset($save_session_batch['logon_user_id']);
                } // if
        	    $_SESSION = array_merge($_SESSION, $save_session_batch);
            } // if
            if (!empty($save_session_data)) {
        	    $_SESSION = array_merge($_SESSION, $save_session_data);
		    } // if
        } // if
    } // if

    logstuff("session_id: " .session_id(), __FUNCTION__, __LINE__);

    if ($GLOBALS['mode'] == 'protx') {
        // dealing with a payment on the PROTX server, so skip the rest
        return;
    } // if

    if (isset($_SESSION['restore_cookie_data'])) {
    	// have just switched between HTTP and HTTPS protocols, so restore cookies
    	restore_cookie_data();
    	unset($_SESSION['restore_cookie_data']);
    } // if

    $PHP_SELF = getSelf();

    if (basename($PHP_SELF) != 'help.php') {
        // record the time at which this script started
        // (end time is determined in function XSLTransform)
        if (!isset($_SESSION['script_start'])) {
            list($usec, $sec) = explode(' ', microtime());
            $_SESSION['script_start'] = (float) $sec + (float) $usec;
        } // if
    } // if

    if (isset($_SESSION['no_getdata'])) {
        $no_getdata = $_SESSION['no_getdata'];
    	unset($_SESSION['no_getdata']);
    } // if

    if ($GLOBALS['mode'] == 'logon') {
        // this is a logon screen (there could be several) so save its ID
        $logon_screen = $PHP_SELF;
        setcookie('logon_screen_'.$session_name, $PHP_SELF, 0, '/');
        // save it so that it can be reproduced when moving between HTTP and HTTPS protocols
        $_SESSION['cookie_data']['logon_screen_'.$session_name] = $PHP_SELF;
    } else {
        $logon_screen =& $_COOKIE['logon_screen_'.$session_name];
        if (empty($logon_screen)) {
        	$logon_screen = '/menu/logon.php';
        } // if
    } // if

    // look for session variables associated with the current script
    if (isset($_SESSION['pages'][$PHP_SELF])) {
        if (isset($_SESSION['pages'][$PHP_SELF]['task_id'])) {
            $task_id     = $_SESSION['pages'][$PHP_SELF]['task_id'];
            $pattern_id  = $_SESSION['pages'][$PHP_SELF]['pattern_id'];
            $script_vars = $_SESSION['pages'][$PHP_SELF][$task_id];
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

    if (version_compare(phpversion(), '5.2.0', '>=')) {
        $_SESSION['timezone_server'] = date_default_timezone_get();
    	if (!empty($GLOBALS['server_timezone'])) {
    	    // override with value from config.inc file
    		$_SESSION['timezone_server'] = $GLOBALS['server_timezone'];
    	} // if
    	if (empty($_SESSION['timezone_client'])) {
    		if (!empty($_COOKIE['timezone_client'])) {
        	    // this was created when the user last logged on
        		$_SESSION['timezone_client'] = $_COOKIE['timezone_client'];
        	} // if
    	} // if
    } // if

    if (isset($GLOBALS['batch'])) {
    	// running a batch job, so skip this next bit
    } else {
	    // find out if the system is being shut down today and issue a message
	    list($shutdown_errors, $shutdown_messages) = getShutDownStatus();

	    if (empty($shutdown_errors) AND !empty($_SESSION['logon_user_id'])) {
	        // find out if there are any restricted time periods for this user or this role
	        list($shutdown_errors, $shutdown_messages) = getTimePeriodStatus($_SESSION['logon_user_id'], $_SESSION['role_id']);
	    } // if

	    if (!empty($shutdown_errors)) {
    		if (isset($GLOBALS['mode']) AND $GLOBALS['mode'] == 'logon') {
    		    // on LOGON screen, so convert error to a warning message
    		    $shutdown_messages = $shutdown_errors;
    			$shutdown_errors   = array();
    		} elseif (strtoupper($_SESSION['role_id']) == 'GLOBAL') {
    		    // user is administrator, so convert error to a warning message
    			$shutdown_messages = $shutdown_errors;
    			$shutdown_errors   = array();
    		} else {
	            $_SESSION['errors'] = $shutdown_errors;
	            // not administrator, so cancel current screen and go back to logon screen
	            $location = 'HTTP://' .$_SERVER['HTTP_HOST']
	                                  .getParentDIR()
	                                  .$logon_screen
	                                  .'?session_name=' .session_name();

	            logstuff("location: $location", __FUNCTION__, __LINE__);

	            session_write_close();
                header('Location: ' .$location);
                exit;
    		} // if
	    } // if
	} // if

    unset($_SESSION['global_access']); // ensure that data is re-fetched for each page

    // find out if client-side XSL transformations are turned ON or OFF
    if (isset($GLOBALS['XSLT_client_side'])) {
        // this is a permanent setting in the CONFIG.INC file
    	if (is_True($GLOBALS['XSLT_client_side'])) {
        	$_SESSION['XSLT_client_side'] = TRUE;
    	} else {
    	    $_SESSION['XSLT_client_side'] = FALSE;
        } // if
    } // if
    // look for alternate settings
	if (isset($_COOKIE['XSLT_client_side'])) {
        $_SESSION['XSLT_client_side'] = $_COOKIE['XSLT_client_side'];
    } // if
    if (isset($_GET['csxslt'])) {
        // use this setting, and save it in a cookie for the following pages
        if (is_True($_GET['csxslt'])) {
        	$_SESSION['XSLT_client_side'] = TRUE;
        	setcookie("XSLT_client_side", 'on');
        	// save it so that it can be reproduced when moving between HTTP and HTTPS protocols
	        $_SESSION['cookie_data']['XSLT_client_side'] = 'on';
	        //$_SESSION['cookie_time']['XSLT_client_side'] = time()+7776000;
        } else {
            $_SESSION['XSLT_client_side'] = FALSE;
            setcookie("XSLT_client_side", 'off');
            // save it so that it can be reproduced when moving between HTTP and HTTPS protocols
	        $_SESSION['cookie_data']['XSLT_client_side'] = 'off';
	        //$_SESSION['cookie_time']['XSLT_client_side'] = time()+7776000;
        } // if
    } // if

    if (isset($_COOKIE['theme'])) {
        $_SESSION['css_file'] = $_COOKIE['theme'];
    } // if

    if (!array_key_exists('css_file', $_SESSION)) {
        // not yet defined, so set to default
    	$_SESSION['css_file'] = 'default.css';
    } // if

    // look for security class from logon screen
    if (!isset($_SESSION['role_id'])) {
        if (basename($PHP_SELF) == 'help.php') {
        	// ROLE_ID is not required in this screen, so continue
        } elseif ($PHP_SELF == $logon_screen) {
            // ROLE_ID will be supplied by this screen, so continue
        } else {
            // ROLE_ID not supplied yet, so jump to logon screen
            session_unset();
            $_SESSION['messages'] = getLanguageText('sys0000'); // 'You must log in to access this system.'
            $location = 'HTTP://' .$_SERVER['HTTP_HOST']
                                  .getParentDIR()
                                  .$logon_screen
                                  .'?session_name=' .session_name();

            logstuff("location: $location", __FUNCTION__, __LINE__);

            session_write_close();
            header('Location: ' .$location);
            exit;
        } // if
    } // if

    if ($PHP_SELF == $logon_screen){
        // always true for a logon screen
        $use_https = true;
    } elseif (is_True($GLOBALS['use_https'])) {
        $use_https = true;
    } elseif (isset($script_vars['use_https'])) {
        // optional for other scripts
        $use_https = $script_vars['use_https'];
    } else {
        $use_https = false;
    } // if

    if (empty($_SERVER['HTTPS'])) {
        $_SERVER['HTTPS'] = 'off';
    } // if

    if (empty($GLOBALS['http_server'])) {
        $GLOBALS['http_server'] = $_SERVER['HTTP_HOST'];
    } // if

    $GLOBALS['url_files'] = 'HTTP://'.$GLOBALS['http_server'];

    if (is_True($_SERVER['HTTPS'])) {
        if (empty($GLOBALS['https_server'])) {
            // no value has been defined for 'https_server'
            trigger_error(getLanguageText('sys0181'), E_USER_ERROR);
        } // if
        if (!empty($GLOBALS['https_server_suffix'])) {
            // ensure that 'https_server' ends with 'https_server_suffix'
            if (!preg_match('#'.$GLOBALS['https_server_suffix'].'$#i', $GLOBALS['https_server'], $regs)) {
                $GLOBALS['https_server'] = $GLOBALS['https_server'].$GLOBALS['https_server_suffix'];
            } // if
        } // if
        if (!defined('HTTPS_NOT_FOR_FILES')) {
            $GLOBALS['url_files'] = 'HTTPS://'.$GLOBALS['https_server'];
        } // if
    } // if

    if (isset($_GET['action'])) {
	    if ($_GET['action'] == 'logout_all') {
	        // remove all cookies which refer to application sessions
	        foreach($_COOKIE as $cookie_name => $cookie_id) {
	            if (preg_match('/^(menu|phpsessid)/', $cookie_name, $regs)) {
                    setcookie($cookie_name, '', time()-42000, '/');
                    $session_obj->destroy($cookie_id);
                    //logstuff("cookie_id: $cookie_id", __FUNCTION__, __LINE__);
	            } // if
	        } // foreach
	    } // if
	    if ($_GET['action'] == 'logout' OR $_GET['action'] == 'logout_all') {
            if (!empty($_SESSION['logon_user_id'])) {
                // perform any logout processing for the current user
                $logon_user_id = $_SESSION['logon_user_id'];
                $logonOBJ = RDCsingleton::getInstance('logon');
                $errors = $logonOBJ->user_logoff($logon_user_id);
            } // if
	        // clear current session data
	        $_SESSION = array();
            logstuff("session_id: ".session_id(), __FUNCTION__, __LINE__);
	        $session_obj->destroy(session_id());
            // go back to logon screen
            if (is_True($_SERVER['HTTPS'])) {
                if (!empty($GLOBALS['https_server'])) {
                    $location = 'HTTPS://' .$GLOBALS['https_server'];
                } else {
                    $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
                } // if
			} else {
				$location = 'HTTP://' .$_SERVER['HTTP_HOST'];
			} // if
            $location .= getParentDIR()
                        .$logon_screen
                        .'?session_name=' .session_name();

            logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;
	    } // if
	    if ($_GET['action'] == 'newsession') {
            // get and register a new session name
	        $session_name = getNewSession('menu');
            session_name($session_name);
            // generate a new id to go with this name
            session_regenerate_id();
            // save id of current logon screen with new new session name
            $result = setcookie('logon_screen_'.$session_name, $logon_screen, 0, '/');
		    // save it so that it can be reproduced when moving between HTTP and HTTPS protocols
		    $_SESSION['cookie_data']['logon_screen_'.$session_name] = $logon_screen;
            // save this session data NOW!
            session_write_close();

            if (!empty($_SESSION['logon_user_id'])) {
                // perform any logout processing for the current user
                $logon_user_id = $_SESSION['logon_user_id'];
                $logonOBJ = RDCsingleton::getInstance('logon');
                $errors = $logonOBJ->user_new_session($logon_user_id);
            } // if

            // now restart the current script
            if (is_True($_SERVER['HTTPS'])) {
            	if (!empty($GLOBALS['https_server'])) {
                    $location = 'HTTPS://' .$GLOBALS['https_server'];
                } else {
                    $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
                } // if
			} else {
				$location = 'HTTP://' .$_SERVER['HTTP_HOST'];
			} // if
            $location .= $_SERVER['PHP_SELF'];
            parse_str($query_string, $array);
            unset($array['action']);
            $location .= '?' .adjustQueryString($array);

            logstuff("location: $location", __FUNCTION__, __LINE__);

            header('Location: ' .$location);
            exit;

	    } elseif ($_GET['action'] == 'recoverpswd') {
            // switch to specified task
            updateScriptVars();
            $page_stack = updatePageStack($task_id, '', $PHP_SELF);
            $_SESSION['role_id']   = 'GLOBAL';
            $_SESSION['role_list'] = "'GLOBAL'";
            $errors = scriptNext('mnu_user(upd1)c', 'user_id=false');

	    } elseif ($_GET['action'] == 'add-to-favourites') {
            // add current task to MNU_FAVOURITES table
            $dbobject =& RDCsingleton::getInstance('mnu_favourite');
            $insert['user_id']      = $_SESSION['logon_user_id'];
            $insert['task_id']      = $task_id;
            $insert['current_menu'] = $script_vars['current_menu'];
            $insert['breadcrumbs']  = $script_vars['page_stack'];
            $dbobject->startTransaction();
            $insert = $dbobject->insertRecord($insert);
            $errors = $dbobject->getErrors();
            if (empty($errors)) {
            	$errors = $dbobject->commit();
            } // if
            if (empty($errors)) {
                // "Task has been added to favourites"
                $messages[] = getLanguageText('sys0203', $task_id);
            } else {
                $dbobject->rollback();
            } // if
            unset($dbobject);
	    } // if
	} // if

	if (defined('RADICORE_NO_MENU')) {
		// no MENU database, so skip this next bit
	} else {
		if (!empty($_SESSION['logon_user_id'])) {
			// check that this user_id is valid for this IP address (helps prevent session hijacking)
            if (!empty($_SESSION['empty_tables']) AND array_key_exists('mnu_user_ip_address', $_SESSION['empty_tables'])) {
                // table is empty, so no lookups are required
            } else {
	            $ip_address = getRealIPAddress();
	            $user_id    = $_SESSION['logon_user_id'];
	            $dbobject =& RDCsingleton::getInstance('mnu_user');
	            $dbobject->sql_select  = 'user_id, ip_address';
	            $dbobject->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE user_id='$user_id') = 0 THEN true"
	                                          ." WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE user_id='$user_id' AND ip_address='$ip_address') = 1 THEN true"
	                                          ." ELSE false"
	                                     ." END AS ip_address_valid";
	            $data = $dbobject->getData_raw("user_id='$user_id'");
	            if (!empty($data)) {
        		    $data = $data[0];
        		    if (!is_True($data['ip_address_valid'])) {
	                    // 'This IP address is not valid for this user'
            		    $_SESSION['messages'] = getLanguageText('sys0200', $ip_address);
	                    $location = 'HTTP://' .$_SERVER['HTTP_HOST']
	                                          .getParentDIR()
	                                          .$logon_screen
	                                          .'?session_name=' .session_name();

	                    logstuff("location: $location", __FUNCTION__, __LINE__);

	                    session_write_close();
                        header('Location: ' .$location);
                        exit;
	                } // if
	            } // if
	            unset($dbobject);
            } // if
		} // if

	    if (empty($_SESSION['default_language'])) {
    		// get default language from control table
	        $mnu_control =& RDCsingleton::getInstance('mnu_control');
	        $_SESSION['default_language'] = $mnu_control->getControlData('default_language');
	    } // if

	    if (empty($_SESSION['user_language_array'])) {
    		// obtain language code from browser settings
	        $_SESSION['user_language_array'] = get_languages($_SERVER["HTTP_ACCEPT_LANGUAGE"]);
	    } // if

	    if (empty($_SESSION['supported_languages'])) {
    		// obtain supported languages from MENU database
	        $_SESSION['supported_languages'] = getSupportedLanguages();
	    } // if
	} // if

    if (empty($_SESSION['user_language']) AND !empty($_SESSION['supported_languages'])) {
    	$found_lang = matchBrowserLanguage($_SESSION['user_language_array'], $_SESSION['supported_languages']);
    	if (!empty($found_lang)) {
    		$_SESSION['user_language'] = $found_lang;
    	} // if
    } // if
    if (empty($_SESSION['user_language']) AND !empty($_SESSION['default_language'])) {
    	$_SESSION['user_language'] = $_SESSION['default_language'];
    } // if

    if (empty($_SESSION['user_language'])) {
        $_SESSION['user_language'] = 'en';
    } // if

    if (!isset($_SESSION['date_format_input'])) {
        $dbobject =& RDCsingleton::getInstance('mnu_language');
        $data = $dbobject->getData("language_id='{$_SESSION['user_language']}'");
        $_SESSION['date_format_input']  = $data[0]['input_date_format'];
        $_SESSION['date_format_output'] = $data[0]['output_date_format'];
        unset($dbobject);
    } // if

    // set to locale where decimal point is '.' (as used internally)
    $locale = rdc_setLocale("English (United Kingdom) [en_GB]");

    // set default language for database access
    $GLOBALS['party_language'] = strtolower($_SESSION['user_language']);

    if (!empty($_SESSION['localeconv'])) {
    	// set default number formatting based on user's locale
        $GLOBALS['localeconv'] = $_SESSION['localeconv'];
    } // if

    // if a button is changed to an image it will have an '_x' or '_y' suffix, so remove it
    foreach ($_POST as $key => $value) {
        if (preg_match('/(_x|_y)$/', $key)) {
            $new = substr($key, 0, -2);
            $_POST{$new} = $_POST{$key};
            unset($_POST[$key]);
        } // if
    } // foreach

    if ($_SERVER['REMOTE_ADDR'] == 'batch') {
    	// do nothing
    } else {
        if (is_True($use_https)) {
            // check that a secure server has been defined
            if (empty($GLOBALS['https_server'])) {
                // not defined, so not used on this server
            } else {
                // check that this script is using secure HTTPS protocol
            	if (!is_True($_SERVER['HTTPS'])) {
            	    // it is not, so redirect
            	    $_SESSION['restore_cookie_data'] = true;
            	    session_write_close();
            	    $location = 'HTTPS://' .$GLOBALS['https_server']
            	                           .getParentDIR()
            	                           .$PHP_SELF;
            	    $location .= '?' .adjustQueryString($_SERVER['QUERY_STRING'], true);

                    logstuff("location: $location", __FUNCTION__, __LINE__);

                    header('Location: ' .$location);
                    exit;
            	} // if
            } // if
        } else {
            // check that this script is NOT using secure HTTPS protocol
            if (is_True($_SERVER['HTTPS'])) {
                // it is, so redirect to standard HTTP server
                $_SESSION['restore_cookie_data'] = true;
                $location = 'HTTP://' .$GLOBALS['http_server']
                                      .getParentDIR()
                                      .$PHP_SELF;
                $location .= '?' .adjustQueryString($_SERVER['QUERY_STRING'], true);

                logstuff("location: $location", __FUNCTION__, __LINE__);

                session_write_close();
                header('Location: ' .$location);
                exit;
            } // if
        } // if
    } // if

    if (isset($script_vars['max_execution_time'])) {
    	$result = ini_set('max_execution_time', $script_vars['max_execution_time']);
    } // if

    if (!isset($_SESSION['log_xml_document'])) {
        // ensure there is a value in the $_SESSION array
    	$_SESSION['log_xml_document'] =& $GLOBALS['log_xml_document'];
    } // if

    if (empty($script_vars)) {
        if (basename($PHP_SELF) == 'help.php') {
            // continue
        } elseif (isset($GLOBALS['batch'])) {
            // continue
        } elseif ($PHP_SELF == $logon_screen) {
            // continue
        } else {
            // not allowed to be empty, so go back to last valid script
            if (!empty($_SESSION['page_stack'])) {
            	$page_stack = $_SESSION['page_stack'];
                $end = array_pop($page_stack); // get the last value
                $script_id = $end['script_id'];
                if ($script_id == $PHP_SELF) {
                    // last entry is current script which is invalid, so get previous entry
                	$end = array_pop($page_stack); // get the last value
                	$script_id = $end['script_id'];
                } // if
                $_SESSION['page_stack'] = $page_stack;
            } else {
                // not found, so default to logon screen
                $script_id = $logon_screen;
            } // if
            if (is_True($_SERVER['HTTPS'])) {
                if (!empty($GLOBALS['https_server'])) {
                    $location = 'HTTPS://' .$GLOBALS['https_server'];
                } else {
                    $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
                } // if
            } else {
                $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
            } // if
            $location .= getParentDIR().$script_id;
            $location .= '?' .adjustQueryString($_SERVER['QUERY_STRING']);

            logstuff("location: $location", __FUNCTION__, __LINE__);

            session_write_close();
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

    if (isset($script_vars['page_stack'])) {
        // this is the hierarchy of visited pages
        $page_stack = $script_vars['page_stack'];
    } else {
        $page_stack = array();
    } // if

    if (!empty($_SESSION['page_stack'])) {
        if (basename($PHP_SELF) == 'help.php') {
            // continue
        } else {
        	// remove any redundant entries in $_SESSION['page_stack']
            $_SESSION['page_stack'] = comparePageStacks($_SESSION['page_stack'], $page_stack);
        } // if
    } // if

    if (!empty($task_id)) {
        // save values in session data
        $_SESSION['pages'][$PHP_SELF]['task_id']              = $task_id;
        $_SESSION['pages'][$PHP_SELF]['task_array'][$task_id] = TRUE;
        $_SESSION['pages'][$PHP_SELF][$task_id]               = $script_vars;
        if (empty($pattern_id)) {
            if (isset($GLOBALS['batch'])) {
            	$pattern_id = 'batch';
            } // if
        } // if
        if (!empty($pattern_id)) {
            $_SESSION['pages'][$PHP_SELF]['pattern_id']       = $pattern_id;
        } // if
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

    if (isset($script_vars['current_menu_tab'])) {
        // the current tab in $menu_buttons is highlighted
        $current_menu_tab = $script_vars['current_menu_tab'];
    } // if

    if (isset($script_vars['initial_passthru'])) {
        // extract value before removing from session data
        // (ensures that value is used only once)
        $initial_passthru = $script_vars['initial_passthru'];
        unset($script_vars['initial_passthru']);
        $_SESSION['pages'][$PHP_SELF][$task_id] = $script_vars;

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

    if (isset($GLOBALS['batch']) AND !empty($orderby)) {
        // keep what is already there
    } else {
        // do database records need to be sorted into any particular order?
        if (isset($script_vars['orderby'])) {
            $orderby = $script_vars['orderby'];
            if (isset($script_vars['orderby_seq'])) {
                $orderby_seq = $script_vars['orderby_seq'];
            } // if
        } // if
        if (isset($script_vars['task_orderby'])) {
            $task_orderby = $script_vars['task_orderby'];
        } // if
    } // if

    if (isset($_GET['selection'])) {
        // a new selection has been made ....

        if (!empty($_SESSION['script_sequence'])) {
            if ($_SESSION['script_sequence'][0]['task_id'] != $task_id) {
            	// attempting to leave a queued task, so go back
                $location = 'HTTP://' .$_SERVER['HTTP_HOST']
                           .getParentDIR()
                           .$PHP_SELF
                           .'?session_name=' .session_name();
                session_write_close();
                header('Location: ' .$location);
                exit;
            } // if
        } // if

        if (!array_key_exists($_GET['selection'], $page_stack)) {
            // new selection does not exist in current stack, so ...
            if (!isset($current_menu_tab)) {
                // remove anything which follows current menu task from $page_stack
                $page_stack = reducePageStack($current_menu, true);
            } else {
                if ($current_menu_tab != $current_menu) {
                    // remove $current_menu_tab (and any following entries) from $page_stack
                    $page_stack = reducePageStack($current_menu_tab);
                } // if
            } // if
            // the new selection becomes the current tab
            $current_menu_tab = $_GET['selection'];
        } else {
            // remove any entries which follow this task from $page_stack
            $page_stack = reducePageStack($_GET['selection'], true);
        } // if
        // clear script sequence as it has been interrupted and cannot be processed
        if (isset($_SESSION['script_sequence'])) {
            if (is_array($_SESSION['script_sequence'])) {
            	foreach ($_SESSION['script_sequence'] as $index => $entry) {
                	if (isset($entry['run_at_end'])) {
                	    // this entry is important, so leave it in
                	} else {
                	    unset($_SESSION['script_sequence'][$index]);
                	} // if
                } // foreach
                if (!empty($_SESSION['script_sequence'])) {
                    // cause array to be re-indexed
                	$_SESSION['script_sequence'] = array_merge($_SESSION['script_sequence']);
                } else {
                    unset($_SESSION['script_sequence']);
                } // if
        	} else {
                unset($_SESSION['script_sequence']);
            } // if
        } // if
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

    if (!empty($GLOBALS) AND !empty($where)) {
        // keep what is already there
    } else {
        // check for SQL 'where' string to be used within this script
        // (this is usually passed down by the parent script)
        if (isset($script_vars['where'])) {
            $where = $script_vars['where'];
        } // if
    } // if

    if (isset($GLOBALS['batch']) AND !empty($search)) {
        // keep what is already there
    } else {
        if (isset($_POST['quicksearch'])) {
            // search criteria has been entered in quicksearch area
            $quicksearch = quicksearch($_POST['quicksearch_field'], $_POST['quicksearch_value']);
        } elseif (isset($script_vars['search'])) {
            // search criteria has been saved in script variables
            $search = $script_vars['search'];
            if (empty($script_vars['return_string'])) {
                $return_string                = $script_vars['search'];
                $script_vars['return_string'] = $script_vars['search'];
            } // if
            unset ($script_vars['search']);
        } // if
    } // if

    // although this string has been merged into $where, it may be filtered out by an
    // outer entity before being passed to an inner entity, so it is defined separately.
    if (isset($script_vars['selection_fixed'])) {
        $task_selection = $script_vars['selection_fixed'];
        //unset ($script_vars['selection_fixed']);
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

    // check for a selection of one or more rows
    if (isset($script_vars['selection'])) {
        $selection = $script_vars['selection'];
    } else {
        $selection = null;
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
        // check action taken within previous script
        if (isset($script_vars['return_action'])) {
            $return_action = $script_vars['return_action'];
            unset($script_vars['return_action']);
        } // if
        // deal with optional return_string
        if (isset($script_vars['return_string'])) {
            $return_string = $script_vars['return_string'];
            unset($script_vars['return_string']);
        } elseif (!empty($selection)) {
            $return_string = $selection;
        } else {
            $return_string = null;
        } // if
        // check for a selection of one or more files
        if (isset($script_vars['files'])) {
            $return_files = $script_vars['files'];
            unset($script_vars['files']);
        } else {
            $return_files = null;
        } // if
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
        // convert string into an array with all keys in lower case
        parse_str($script_vars['settings'], $settings);
        $settings = array_change_key_case($settings, CASE_LOWER);
        foreach ($settings as $key => $value) {
            // remove single quotes from each value
        	$settings[$key] = trim($value, "'");
        } // foreach
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
        $_SESSION['pages'][$PHP_SELF]['task_id'] = $task_id;
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
    	// load screen structure from disk file
        $screen_structure = getFileStructure($screen, './screens');
    } // if

    if (isset($report)) {
        // load the structure details for this report.
    	$report_structure = getFileStructure($report, './reports');
    } // if

    if (!empty($shutdown_errors)) {
    	$errors = array_merge($errors, $shutdown_errors);
    } // if
    if (!empty($shutdown_messages)) {
    	$messages = array_merge($messages, $shutdown_messages);
    } // if

    return;

} // initSession

// ****************************************************************************
function quickSearch ($quicksearch_field, $quicksearch_value)
// the QuickSearch button has been pressed, so output result in $search string
{
    $quicksearch_value = trim($quicksearch_value);

    if (empty($quicksearch_field) OR empty($quicksearch_value)) {
        return false;
    } // if

    $quicksearch_field = strtolower($quicksearch_field);

    if (substr_count($quicksearch_value, '%') > 0) {
        // already has a wildcard character, so don't add another
	    $search = $quicksearch_field ." LIKE '" .addslashes($quicksearch_value) ."'";
    } else {
        if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $quicksearch_value, $regs )) {
            // strip pattern from string and use as the operator
            $quicksearch_value = substr($quicksearch_value, strlen($regs[0]));
            $quicksearch_value = str_replace('%', '', $quicksearch_value);  // strip wildcard character
            $search = $quicksearch_field .' ' .$regs[0] ." '" .addslashes($quicksearch_value) ."'";
        } else {
            $search = $quicksearch_field ." LIKE '" .addslashes($quicksearch_value) ."%'";
        } // if
    } // if

    return $search;

} // quickSearch

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
            // pick out the last entry on the stack
            $end           = end($page_stack);
        	$end_script_id = $end['script_id'];
        	$end_task_id   = key($page_stack);
        	if ($end_task_id == $task_id) {
        	    break;  // this is the last task in the stack
        	} else {
        	    if ($end_script_id == '/menu/menu.php') {
        	        // leave menus alone!
        	    } else {
        	    	// remove this script's variables from session details if required
                    cleanSavedPages ($end_script_id, $end_task_id);
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
function removeFromScriptSequence ($task_id=null)
// remove entries from $_SESSION['script_sequence']
{
    if (empty($_SESSION['script_sequence'])) {
    	return;
    } // if

    if (empty($task_id)) {
        // not supplied, so default to current task
    	$task_id = $GLOBALS['task_id'];
    } // if

    foreach ($_SESSION['script_sequence'] as $index => $entry) {
    	if (array_key_exists('inserted_by', $entry)) {
    		if ($entry['inserted_by'] == $task_id) {
    			unset($_SESSION['script_sequence'][$index]);
    		} // if
    	} // if
    } // foreach

    return;

} // removeFromScriptSequence

// ****************************************************************************
function restore_cookie_data ()
// moving between HTTP and HTTPS, so restore coookie data from $_SESSION array
{
	foreach ($_SESSION['cookie_data'] as $key => $value) {
		if (!empty($_SESSION['cookie_time'][$key])) {
			// permanent cookie
			setcookie($key, $value, $_SESSION['cookie_time'][$key], '/');
		} else {
			// temporary cookie, expires when session ends
			setcookie($key, $value, 0, '/');
		} // if

		//logstuff("cookie($key = $value)", __FUNCTION__, __LINE__);

	} // foreach

} // restore_cookie_data

// ****************************************************************************
function runInBackground ($task_array, $save_script_vars)
// run this task in a separate process in the background.
{
    if (!extension_loaded('curl')) {
        // CURL functions are not available
    	$errors[] = getLanguageText('sys0070', 'CURL');
        return $errors;
    } // if

    $dir = dirname($_SERVER['PHP_SELF']);

    $cwd = getcwd();
    if (basename(getcwd()) == $task_array['subsys_dir']) {
        $script_dir = $cwd;
    } else {
    	chdir('../'.$task_array['subsys_dir']);
        $script_dir = getcwd();
        $dir = dirname($dir);
        if ($dir == DIRECTORY_SEPARATOR) {
            $dir = '';
        } // if
    	$dir .= '/'.$task_array['subsys_dir'];
    } // if

    if (!$fp = @fopen($task_array['script_id'], 'r')) {
        // "File 'XX' does not exist"
        $errors[] = getLanguageText('sys0057', $task_array['script_id']);
        return $errors;
    } // if
    fclose($fp);
    chdir($cwd);

    $save_session_name   = session_name('batch');
    $save_session_id     = session_id();
    $save_session_search =& $_SESSION['search'];

    // generate a new session just for the batch process
    session_regenerate_id();

    // add variables to $_SESSION array for this script
    $script_id = $task_array['script_id'];
    if ($script_id == basename($script_id)) {
        // script name is not qualified, so insert directory name
        if (!empty($task_array['subsys_dir'])) {
            $script_id = '/' .$task_array['subsys_dir'] .'/' .$script_id;
        } // if
    } // if

    $script_vars = array();
    if (isset($task_array['selection'])) {
    	$script_vars['selection'] = $task_array['selection'];
    } // if
    if (isset($task_array['where'])) {
    	$script_vars['where'] = $task_array['where'];
    } // if
    if (isset($task_array['search'])) {
    	$script_vars['search'] = $task_array['search'];
    } // if
    if (isset($task_array['sql_orderby'])) {
    	$script_vars['orderby'] = $task_array['sql_orderby'];
    } // if
    if (isset($task_array['sql_orderby_seq'])) {
    	$script_vars['orderby_seq'] = $task_array['sql_orderby_seq'];
    } // if

    // load parameters into session data for the background script
    $task_id = $task_array['task_id'];
    $_SESSION['pages'][$script_id]['task_id']    = $task_id;
    $_SESSION['pages'][$script_id]['pattern_id'] = $task_array['pattern_id'];
    $_SESSION['pages'][$script_id][$task_id]     = $script_vars;
    $_SESSION['pages'][$script_id]['task_array'][$task_id] = TRUE;

    session_write_close();  // close session data before batch script launches

    if (preg_match('/^(linux|unix)/i', PHP_OS)) {
        // run this program in the background via the command line
        $session_id = session_id();
        $script_name = $script_dir.'/'.$task_array['script_id'];
        $command_line = "/usr/bin/php '$script_name' PHPSESSID $session_id >/dev/null &";
        $result = exec($command_line);

    } else {
        // build fully qualified URL
        if (strlen($GLOBALS['https_server']) > 0 AND (is_True($task_array['use_https']) OR is_True($GLOBALS['use_https']))) {
            $url = 'HTTPS://' .$GLOBALS['https_server'];
        } else {
            $url = 'HTTP://' .$_SERVER['HTTP_HOST'];
        } // if
        if (!empty($dir)) {
            $url .= $dir .'/';
        } // if
        $url .= $task_array['script_id'];
        $url .= '?session_name=batch&session_id=' .session_id();
        // launch this script in another server process, but let it run in parallel
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_TIMEOUT, 2);
        if (defined('CURL_HTTP_AUTH')) {
            curl_setopt($ch, CURLOPT_USERPWD, CURL_HTTP_AUTH);
        } // if
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);

        $content = curl_exec($ch);
        if ($content === FALSE) {
            $curl_errno = curl_errno($ch);
            if ($curl_errno == 28) {
                // timeout - ignore
            } else {
        	    $curl_error = curl_error($ch);
        	    $errors[] = "CURL error $curl_errno: $curl_error";
        	    return $errors;
            } // if
        } // if
        curl_close($ch);

        //$content = <<< EOD
//<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
//<html><head>
//<title>401 Authorization Required</title>
//</head><body>
//<h1>Authorization Required</h1>
//<p>This server could not verify that you
//are authorized to access the document
//requested.  Either you supplied the wrong

//credentials (e.g., bad password), or your
//browser doesn't understand how to supply
//the credentials required.</p>
//<hr>
//<address>Apache Server at santiago.cleverfactory.net Port 80</address>
//</body></html>
//EOD;

        if (empty($content)) {
            // no response so far, so assume no errors and continue
        } else {
            if (preg_match('/<p>\*\* started at/ims', $content)) {
                // this is a valid response
            } else {
                // this is an unexpected response
                if (preg_match('#(?=<title>).+(?<=</title>)#', $content, $regs)) {
                    // use the contents of the '<title' tag
                    $message = $regs[0];
                    $search   = array('#<title>#i','#</title>#i');
                    $replace  = array();
                    $message = preg_replace($search, $replace, $message);


                    $errors[] = "CURL error: $message";
                    return $errors;
                } else {
                    $search = array('#\<html\>#ims', '#\</html\>#ims');
                    $content = preg_replace($search, NULL, $content);
                    $content = "START runInBackground() ERROR =>><br />".$content."<br /><<= END runInBackground() ERROR";
                    trigger_error($content, E_USER_ERROR);
                } // if
            } // if
        } // if
    } // if

    // reinstate original session before jumping
    session_name($save_session_name);
    session_id($save_session_id);
    $handler = setSessionHandler();
    session_start();

    $GLOBALS['script_vars'] = $save_script_vars;
    $_SESSION['search'] = $save_session_search;

    // jump to the 'Show batch log file' task
    $errors = scriptNext('batch_log(filepicker)');

    return array();

} // runInBackground

// ****************************************************************************
function scriptNext ($task_id, $where=null, $selection=null, $task_array=array(), $search=null)
// proceed to a new script identified in $task_id.
{
    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        $errors[] = getLanguageText('sys0038'); // 'Not allowed in batch mode'
    	return $errors;
    } // if

    if (empty($task_id)) {
        // something is wrong, so go back to logon screen
        $task_id = 'logon';
        $task_array = null;
        //trigger_error(getLanguageText('sys0052'), E_USER_ERROR); // 'task id is not defined'
    } // if

    global $current_menu;
    global $current_menu_tab;   // task to be highlighted
    global $menu_buttons;
    global $messages;
    global $page_stack;
    global $script_vars;

    $parent_task = $GLOBALS['task_id'];

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    $role_id = $_SESSION['role_id'];

    // ensure that latest set of script variables is stored in $_SESSION array
    // for the current task (indexed under ['pages'][script_id][task_id])
    if (isset($_SESSION['pages'][$PHP_SELF]['task_id'])) {
        $page_task = $_SESSION['pages'][$PHP_SELF]['task_id'];
        if ($page_task == $parent_task) {
            // task is changing, so save variables for parent task
        	$_SESSION['pages'][$PHP_SELF][$page_task] = $script_vars;
            // do not save any search criteria set in childform() method
            unset($_SESSION['pages'][$PHP_SELF][$page_task]['search']);
        } else {
            // reload variables for new task
            $script_vars = $_SESSION['pages'][$PHP_SELF][$task_id];
        } // if
    } // if

    // remove saved pages which are no longer in page_stack
    foreach ($_SESSION['pages'] as $page => $page_data) {
        $test_task_id = $page_data['task_id'];
    	switch ($test_task_id) {
    		case 'logon':
    		case 'menu':
    		case $task_id:
    		    // leave these alone
    			break;

    		default:
                if (isset($page_stack[$test_task_id])) {
                	// leave this alone
                } else {
                    // check if data can be deleted
                    cleanSavedPages ($page, $test_task_id);
                } // if
    			break;
    	} // switch
    } // foreach

    // ensure all keywords are in UPPER case
    $selection = str_replace("\) or \(", ") OR (", $selection);
    $where     = str_replace("\) or \(", ") OR (", $where);

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
        if ($task_id == 'menu' AND empty($page_stack)) {
            // set this menu as first entry in page_stack so that when the script_sequence
            // has been exhausted it will return to this menu
            $array = where2array($query_string);
            $menu_id   = $array['selection'];
            $script_id = '/menu/menu.php';
            $page_stack[$menu_id] = array('script_id' => $script_id,
                                          'button_text' => 'Home');
            unset($array, $query_string);
            $_SESSION['pages'][$script_id]['task_id']              = $menu_id;
            $_SESSION['pages'][$script_id]['pattern_id']           = 'MENU';
            $_SESSION['pages'][$script_id][$menu_id]               = $page_stack;
            $_SESSION['pages'][$script_id][$menu_id]['keep_data']  = 'N';
            $_SESSION['pages'][$script_id][$menu_id]['page_stack'] = $page_stack;

        } else {
            $first = $_SESSION['script_sequence'][0];
            $last  = $_SESSION['script_sequence'][count($_SESSION['script_sequence'])-1];
            // check if requested task is at head of the array already
            if ($first['task_id'] <> $task_id) {
                // no it is not
                if (isset($first['script_id']) and $first['script_id'] == basename($PHP_SELF))  {
                    // first entry is current script, so new selection has been requested from this
                    // script. It therefore goes to the front of the array so it can return to the
                    // current script when it has completed.
                    $prepend['task_id'] = $task_id;
                    array_unshift($_SESSION['script_sequence'], $prepend);
                } elseif ($last['task_id'] == $task_id) {
            	    // this task has already been added to the end of the array, so do not do it again
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
                    $_SESSION['script_sequence'][] = $append;
                    $last = $append;
                } // if
            } // if
        } // if

        if (!isset($append) AND $last['task_id'] == $task_id) {
        	// obtain last entry in array and process it now
            $next = $last;
        } else {
            // obtain first entry in array and process it now
            $next = $_SESSION['script_sequence'][0];
        } // if
        $task_id = $next['task_id'];
        if (array_key_exists('query_string', $next)) {
            $query_string = $next['query_string'];
        } // if
        if (array_key_exists('where', $next)) {
            $where = $next['where'];
        } // if
        if (array_key_exists('selection', $next)) {
            $selection = $next['selection'];
        } // if
        if (array_key_exists('search', $next)) {
            $search = $next['search'];
        } // if
        if (array_key_exists('messages', $next)) {
            if (!empty($messages) AND is_array($messages)) {
            	$messages = array_merge($messages, $next['messages']);
            } else {
                $messages = $next['messages'];
            } // if
        } // if
        if (array_key_exists('previous', $next)) {
            $previous = $next['previous'];
        } // if
        if ($task_id == $first['task_id']) {
        	if (empty($first['action'])) {
        		// no action is required, so no need to keep this entry
        		$null = array_shift($_SESSION['script_sequence']);
        	} // if
        } // if
        // force script details for this task to be loaded
        unset($task_array['script_id']);
    } // if

    if (!isset($task_array['script_id'])) {
        // $script_id not supplied yet - so translate $task_id into $script_id
        $taskobj =& RDCsingleton::getInstance('mnu_task');
        $task_array = $taskobj->checkSelection($task_id);
        $errors = $taskobj->getErrors();
        if ($errors) {
            // cannot continue, so abort
            trigger_error("$task_id - {$errors[0]}", E_USER_ERROR);
        } // if
        if ($task_array['task_type'] == 'MENU') {
            $query_string = "selection={$task_array['task_id']}";
        } // if
//        if (!empty($_SESSION['script_sequence'])) {
//            if (empty($_SESSION['script_sequence'][0]['script_id'])) {
//            	$_SESSION['script_sequence'][0]['script_id'] = $task_array['script_id'];
//            } // if
//        } // if
    } // if

    // find out if this task has been set to be run at the end of an existing task
    foreach ($_SESSION['pages'] as $page_script => $page_data) {
    	foreach ($page_data['task_array'] as $page_task => $task_data) {
    		if (isset($page_data[$page_task]['task_id_run_at_end'])) {
    			if ($page_data[$page_task]['task_id_run_at_end'] == $task_id
    		    AND $page_data[$page_task]['task_id_run_at_end_context'] == $where) {
    		        // this task has been nominated, but is already being run, so...
    		        // remove it so that it is not run again autmatically
                    unset($_SESSION['pages'][$page_script][$page_task]['task_id_run_at_end']);
                    unset($_SESSION['pages'][$page_script][$page_task]['task_id_run_at_end_context']);
    			} // if
    		} // if
    	} // foreach
    } // foreach

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

    if ($script_id == $PHP_SELF and $task_id == $_SESSION['pages'][$script_id]['task_id']) {
        // new script/task is same as current script/task, so do nothing
    } else {
        $save_script_vars = $script_vars;
        // look for session variables associated with this script
        if (isset($_SESSION['pages'][$script_id])) {
            if (isset($_SESSION['pages'][$script_id][$task_id])) {
                $script_vars = $_SESSION['pages'][$script_id][$task_id];
                //unset($script_vars['where']);
                unset($script_vars['selection']);
                unset($script_vars['orderby']);
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
        $_SESSION['pages'][$script_id]['task_id']              = $task_id;
        $_SESSION['pages'][$script_id]['task_array'][$task_id] = TRUE;
        $_SESSION['pages'][$script_id]['pattern_id']           = $task_array['pattern_id'];

        if (isset($script_vars['script_count'])) {
            // script has already been executed, so do not load these variables
        } else {
            if (!empty($task_array['initial_passthru'])) {
                $script_vars['initial_passthru'] = $task_array['initial_passthru'];
            } // if
        } // if

        if (!empty($task_array['task_id_run_at_end'])) {
            $script_vars['task_id_run_at_end'] = $task_array['task_id_run_at_end'];
        } // if
        if (!empty($task_array['task_id_run_at_cancel'])) {
            $script_vars['task_id_run_at_cancel']         = $task_array['task_id_run_at_cancel'];
            $script_vars['task_id_run_at_cancel_context'] = $where;
        } // if

        if (!empty($task_array['task_desc'])) {
            $script_vars['title'] = $task_array['task_desc'];
        } // if

        //if (!empty($where)) {
            $script_vars['where'] = $where;
        //} // if

        if (!empty($task_array['selection_fixed'])) {
            $task_array['selection_fixed'] = str_replace('$logon_party_id', $_SESSION['logon_party_id'], $task_array['selection_fixed']);
            $script_vars['selection_fixed'] = $task_array['selection_fixed'];
            if (empty($script_vars['where'])) {
            	$script_vars['where'] = $task_array['selection_fixed'];
            } else {
                $where_array  = where2array($script_vars['where'], false, false);
                $select_array = where2array($script_vars['selection_fixed'], false, false);
                $where_array  = array_merge($where_array, $select_array);
                $script_vars['where'] = array2where($where_array);
            } // if
        } // if

        if (!empty($task_array['selection_temp'])) {
            $task_array['selection_temp'] = str_replace('$logon_party_id', $_SESSION['logon_party_id'], $task_array['selection_temp']);
            if (!isset($script_vars['script_count'])) {
                // script has not been executed yet, so load initial search string
                if (empty($script_vars['search'])) {
                	$script_vars['search'] = $task_array['selection_temp'];
                } else {
                    $script_vars['search'] = mergeWhere($script_vars['search'], $task_array['selection_temp']);
                } // if
            } // if
        } // if

        if (!empty($selection)) {
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

        if (!empty($current_menu_tab)) {
            $script_vars['current_menu_tab'] = $current_menu_tab;
        } // if

        //if (!empty($messages)) {
        //    $script_vars['messages'] = $messages;
        //} // if

        // look for sorting parameters from the previous script to be passed to the next script
        if (!empty($task_array['sql_orderby'])) {
            $script_vars['orderby']     = $task_array['sql_orderby'];
            $script_vars['orderby_seq'] = $task_array['sql_orderby_seq'];
        } elseif (!empty($task_array['orderby'])) {
            $script_vars['orderby']     = $task_array['orderby'];
        } // if

        if (!empty($task_array['order_by'])) {
            // defines sort order from the MNU_TASK entry
            $script_vars['task_orderby'] = $task_array['order_by'];
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

        if ($task_array['max_execution_time'] > 0) {
            $script_vars['max_execution_time'] = $task_array['max_execution_time'];
        } else {
            unset($script_vars['max_execution_time']);
        } // if
    } // if

    if (!empty($messages)) {
        $script_vars['messages'] = $messages;
    } // if

    if (preg_match('/batch/i', $task_array['pattern_id'], $regs)) {
        // this is to be run in the background as a batch process
        if (!empty($where)) {
        	$task_array['where'] = $where;
        } // if
        if (!empty($script_vars['search'])) {
        	$task_array['search'] = $script_vars['search'];
        } // if
        if (!empty($selection)) {
        	$task_array['selection'] = $selection;
        } // if
        $errors = runInBackground($task_array, $save_script_vars);
        return $errors;
	} // if

    // ensure that latest set of script variables is stored in $_SESSION array
    // (indexed under [script_id][task_id])
    $_SESSION['pages'][$script_id][$task_id] = $script_vars;

    if (is_True($_SERVER['HTTPS'])) {
        if (!empty($GLOBALS['https_server'])) {
            $location = 'HTTPS://' .$GLOBALS['https_server'];
        } else {
            $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
        } // if
    } else {
        $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
    } // if
    $location .= getParentDIR().$script_id;
    if (isset($query_string)) {
        $location .= '?' .adjustQueryString($query_string);
	} else {
		$location .= '?' .adjustQueryString();
    } // if

    logstuff("location: $location", __FUNCTION__, __LINE__);

    session_write_close();
    header('Location: ' .$location);
    exit;

} // scriptNext

// ****************************************************************************
function scriptPrevious($errors=null, $messages=NULL, $action=NULL, $instruction=NULL, $selection=null)
// go back to the previous script in the current hierarchy.
{
    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch']) OR isset($GLOBALS['web_server'])) {
    	return $errors;
    } // if

    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'

    if (isset($this)) {
        if (method_exists($this, 'commit')) {
            // if we are executing from within a class then commit any outstanding updates
            // before switching to another script.
            $errors = $this->commit();
        } // if
    } // if

    // retrieve task_id for current script
    if (isset($_SESSION['pages'][$PHP_SELF]['task_id'])) {
        $task_id = $_SESSION['pages'][$PHP_SELF]['task_id'];
    } else {
        $task_id = '*unknown*';
    } // if

    global $query_string;
    global $page_stack;

    // check if anything in $_SESSION['pages'] can be removed
    cleanSavedPages ($PHP_SELF, $task_id, $errors, $selection);

    // get id of the previous script (and optional query string)
    $prev_script = getPreviousScript($task_id);
    $prev_task   = getPreviousTask($prev_script);

    // 'script_sequence' identifies one or more scripts to be done in sequence
    if (!empty($_SESSION['script_sequence'])) {
        // obtain first entry in array and examine its details
        $first = $_SESSION['script_sequence'][0];
        $last  = $_SESSION['script_sequence'][count($_SESSION['script_sequence'])-1];
        if ($first['task_id'] == $task_id) {
            // current task is first task in list
            if (!empty($first['action'])) {
                if ($first['action'] <> $action) {
                    // current script did not terminate with required action,
                    // so it must be done again
                    $GLOBALS['messages'] = getLanguageText('sys0034');
                    $where =& $first['where'];
                    $errors = scriptNext($first['task_id'], $where);
                } // if
            } // if
            // script is done, so drop it from array
            $null = array_shift($_SESSION['script_sequence']);
            $first = $_SESSION['script_sequence'][0];
            $page_stack = reducePageStack($task_id);

        } elseif ($last['task_id'] == $task_id) {
            // current task is last task in list
            if (!empty($last['action'])) {
                if ($last['action'] <> $action) {
                    // current script did not terminate with required action,
                    // so it must be done again
                    $GLOBALS['messages'] = getLanguageText('sys0034');
                    $where =& $last['where'];
                    $errors = scriptNext($last['task_id'], $where);
                } // if
            } // if
            // script is done, so drop it from array
            $null = array_pop($_SESSION['script_sequence']);
            $last = $_SESSION['script_sequence'][count($_SESSION['script_sequence'])-1];
            $page_stack = reducePageStack($task_id);
        } // if

        if (empty($_SESSION['script_sequence'])) {
            // no more entries left, so clear this array
            unset($_SESSION['script_sequence']);
        } else {
            // is first entry same as last entry in current page stack?
            end($page_stack);
            $last_task  = key($page_stack);
            if ($first['task_id'] == $last_task) {
                // yes, so go back to previous script
                $yes = true;
            } elseif ($last['task_id'] == $last_task) {
                // yes, so go back to previous script
                $yes = true;
            } else {
                // no, so remove current task from $page_stack
                unset($page_stack[$task_id]);
                // now go forwards to a new script
                $where     =& $first['where'];
                $selection =& $first['selection'];
                $task_array = array();
                if (isset($first['settings'])) {
                    $task_array['settings'] = $first['settings'];
                } // if
                $errors    = scriptNext($first['task_id'], $where, $selection, $task_array);
                if (!empty($errors)) {
                    return $errors;
                } // if
            } // if
         } // if
    } // if

    if (isset($prev_script)) {
        // put any messages into session array
        if (!empty($messages)) {
            $_SESSION['pages'][$prev_script][$prev_task]['messages'] = $messages;
        } // if
        // put any errors into session array
        if (!empty($errors)) {
            $_SESSION['pages'][$prev_script][$prev_task]['errors'] = $errors;
        } // if
        // show which script we are leaving, and how ('ok' or 'quit')
        if (!empty($action)) {
            $_SESSION['pages'][$prev_script][$prev_task]['return_action'] = $action;
        } // if
        // pass optional instruction back to the previous script
        if (!empty($instruction)) {
            $_SESSION['pages'][$prev_script][$prev_task]['instruction'] = $instruction;
        } // if
        // identify where we are coming from
        $_SESSION['pages'][$prev_script][$prev_task]['return_from'] = $task_id;

        if (is_True($_SERVER['HTTPS'])) {
            if (!empty($GLOBALS['https_server'])) {
                $location = 'HTTPS://' .$GLOBALS['https_server'];
            } else {
                $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
            } // if
        } else {
            $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
        } // if
        $location .= getParentDIR()
                    .$prev_script
                    .'?session_name=' .session_name();
        if (isset($query_string)) {
            $location .= "&$query_string";
        } // if

        logstuff("location: $location", __FUNCTION__, __LINE__);

        session_write_close();
        header('Location: ' .$location);
        exit;
    } else {
        if (!empty($messages)) {
            $_SESSION['messages'] = $messages;
            session_write_close();
        } // if
        // no previous script, so go back to logon page
        if (is_True($_SERVER['HTTPS'])) {
            if (!empty($GLOBALS['https_server'])) {
                $location = 'HTTPS://' .$GLOBALS['https_server'];
            } else {
                $location = 'HTTPS://' .$_SERVER['HTTP_HOST'];
            } // if
        } else {
            $location = 'HTTP://' .$_SERVER['HTTP_HOST'];
        } // if
        $logon_screen =& $_COOKIE['logon_screen_'.session_name()];
        $location .= getParentDIR()
                   .$logon_screen
                   .'?session_id=' .session_id();

        logstuff("location: $location", __FUNCTION__, __LINE__);

        session_write_close();
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
    $errors = scriptNext($GLOBALS['task_id'], null, null, $task_array);

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
    $_SESSION['pages'][$PHP_SELF][$task_id] = $script_vars;

    if (!isset($_SESSION['pages'][$PHP_SELF]['task_id'])) {
        // make sure this is set
    	$_SESSION['pages'][$PHP_SELF]['task_id']              = $task_id;
    	$_SESSION['pages'][$PHP_SELF]['task_array'][$task_id] = TRUE;
    } // if

    return $script_vars;

} // updateScriptVars

// ****************************************************************************
?>
