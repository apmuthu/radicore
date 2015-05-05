<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add2.inc

// type = add2

// This will add an occurrence to the MANY entity in a ONE-to-MANY relationship
// with the ONE's identity passed in $where

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//    if (empty($where)) {
//    	// only use $selection if $where is empty
//        $where = $selection;
//        $selection = null;
//    } // if
//} // if

if (isset($_POST['quit']) OR isset($_GET['quit'])) {
    if (isset($script_vars['dbobject'])) {
        require_once "classes/$table_id.class.inc";
        $dbobject = unserialize($script_vars['dbobject']);
        $dbobject->quitButton();  // perform any QUIT processing
    } // if
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['copy']       = 'copy';
$act_buttons['quit']       = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $fieldarray = $dbobject->getFieldArray();
    // see if any configuration settings need to be changed
    $fieldarray = $dbobject->changeConfig($fieldarray);
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->setRowsPerPage(1);  // deal with one item at a time
    // get initial data for a new record
    $where = $dbobject->initialise($where, $selection);
    if (empty($dbobject->errors)) {
    	$fieldarray = $dbobject->getInitialData($where);
    } // if
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors(), $dbobject->getMessages());
    } // if
} // if

if (!empty($_POST)) {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button ($act_buttons, $_POST);
    if (empty($submit_button)) {
        // deal with a javascript 'submit()'.
        $fieldarray = $dbobject->updateFieldArray($fieldarray, $_POST);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
        } // if
    } else {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);
    } // if
    if (empty($errors)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbobject' => $dbobject));
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
    if (isset($_POST['copy'])) {
        // save current data so that it be be PASTed later
        $messages = copyForm($_POST, $dbobject);

    } elseif (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = pasteData($dbobject, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        // redo any initialisation
        $fieldarray = $dbobject->getInitialData($fieldarray);

    } elseif (empty($errors)) {
        if (!empty($submit_button)) {
            // this is a standard 'submit' button, so update the database
            $dbobject->startTransaction();
            $fieldarray = $dbobject->insertRecord($fieldarray);  // add this data to the database
            $messages   = array_merge($messages, $dbobject->getMessages());
            if ($dbobject->errors) {
                $errors = $dbobject->getErrors();
            } // if
            if (empty($errors)) {
                $errors = $dbobject->commit();
                if (empty($errors)) {
                    $messages[] = getLanguageText('sys0080'); // 'Record inserted OK';
                    if (is_True($dbobject->allow_scrolling) AND isset($scrolling)) {
                        $where = $scrolling[$dbobject->getClassName()]['where'];
                        $rows = splitWhereByRow($where);
                        // remove current item from selection
                        $curitem = $scrolling[$dbobject->getClassName()]['curitem'] - 1;
                        unset($rows[$curitem]);
                        if (empty($rows)) {
                            $messages = array_merge($messages, $dbobject->getMessages());
                            scriptPrevious(null, $messages, 'insert', $dbobject->getInstruction());
                        } else {
                            $scrolling[$dbobject->getClassName()]['where'] = joinWhereByRow($rows);
                            $dbobject->lastpage = count($rows);
                            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
                            if ($scrolling[$dbobject->getClassName()]['curitem'] > $scrolling[$dbobject->getClassName()]['lastitem']) {
                                $scrolling[$dbobject->getClassName()]['curitem'] = $scrolling[$dbobject->getClassName()]['lastitem'];
                            } // if
                        } // if
                    } elseif (isset($_POST['submitstay'])) {
                        // re-initialise data for a new record
                        $fieldarray = $dbobject->getInitialData($where);
                        // get any extra data and merge with $fieldarray
                        $fieldarray = $dbobject->getExtraData($fieldarray);
                        if (isset($_SESSION['script_sequence'])) {
                            $script_vars['dbobject'] = serialize($dbobject);
                            // do other tasks before returning to this one
                            scriptNext($task_id);
                        } // if
                    } else {
                        // update was OK - return to previous screen
                        $selection = array2where($fieldarray, $dbobject->getPkeyNames());
                        $prev_script = getPreviousScript();
                        $prev_task   = getPreviousTask($prev_script);
                        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
                        $messages = array_merge($messages, $dbobject->getMessages());
                        scriptPrevious(null, $messages, 'insert', $dbobject->getInstruction());
                    } // if
                } // if
            } else {
                $dbobject->rollback();
            } // if

        } else {
            // look for a custom button (a field which begins with 'button#')
            $button = false;
            foreach ($_POST as $postname => $postvalue) {
                if (preg_match('/^button#/i', $postname, $regs)) {
                    // strip off the prefix to leave the original field name
                    $button = str_replace($regs[0], '', $postname);
                    break;
                } // if
            } // foreach
            if ($button) {
                // a custom button was pressed
                $dbobject->startTransaction();
                $fieldarray = $dbobject->customButton($fieldarray, $button, $_POST);
                if ($dbobject->errors) {
                    $errors = $dbobject->getErrors();
                    $dbobject->rollback();
                } else {
                    $dbobject->commit();
                } // if
            } // if
        } // if
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form where something has been selected
    if (!empty($return_from) AND isset($selection)) {
        // merge previous saved variables with selection from previous form
        $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection, null, $return_files);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
        } // if
    } elseif (is_True($dbobject->allow_scrolling)) {
        if (isset($scrolling)) {
            // retrieve values from scrolling array
            $where = $scrolling[$dbobject->getClassName()]['where'];
            if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
                // set index number of item to be read from current $where list
                $dbobject->setPageNo($_GET['item']);
            } else {
                $dbobject->setPageNo($scrolling[$dbobject->getClassName()]['curitem']);
            } // if
            $where_array = where2array($where, $dbobject->pageno);
            $fieldarray = $dbobject->getInitialData($where_array);
        } // if
        // set variables to be included in XML output
        $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
        $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
        $scrolling[$dbobject->getClassName()]['where']    = $where;
    } // if
    if (empty($where)) {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if
    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
} // if

if (isset($_SESSION['data'][$table_id])) {
    // saved data exists, so allow a PASTE button
    $prepend = array('paste' => 'paste');
    $act_buttons = array_merge($prepend, $act_buttons);
} // if

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->getMessages());
} // if

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
if (is_True($dbobject->allow_scrolling)) {
    $script_vars['scrolling'] = $scrolling;
    unset($act_buttons['submitstay']);
} // if
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND !$button) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

if (!empty($errors)) {
    // all errors are associated with this table
	$errors = array($dbobject->getClassName() => $errors);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
