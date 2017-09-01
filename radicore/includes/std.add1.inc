<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add1.inc

// type = add1

// This will allow the user to add a single record to a database table.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

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
    // redo any configuration changes
    $fieldarray = $dbobject->getExtraData($fieldarray);
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->setRowsPerPage(1);  // scroll through one item at a time
    $dbobject->sql_where   = &$sql_where;
    // get initial data for a new record
    $where = $dbobject->initialise($where, $selection);
    if (empty($dbobject->errors)) {
        $fieldarray = $dbobject->getInitialData($where);
    } // if
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors(), $dbobject->getMessages(), 'fail');
    } // if
} // if

if (!empty($_POST)) {
    //if (isset($_POST['copy'])) {
    //    // save current data so that it be be PASTed later
    //    $messages = copyForm($_POST, $dbobject);

    //} elseif (isset($_POST['paste'])) {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = pasteData($dbobject, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        // redo any initialisation
        $fieldarray = $dbobject->getInitialData($fieldarray);

    } else {
        // identify if one of the 'submit' buttons has been pressed
        $submit_button = check_submit_button($act_buttons, $_POST);
        $task_button   = check_task_button($_POST);
        $custom_button = check_custom_button($_POST);
        if ($submit_button OR $task_button OR $custom_button OR isset($_POST['copy'])) {
            // merge original data with POSTed data (so that fields which were displayed
            // but not POSTed are sent back if any errors are displayed).
            $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
            // ensure that changes are stored inside relevant object
            $dbobject->setFieldArray($fieldarray);

        } else {
            // deal with a javascript 'submit()'.
            $fieldarray = $dbobject->updateFieldArray($fieldarray, $_POST);
            if ($dbobject->errors) {
                $errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
        } // if

        if (isset($_POST['copy'])) {
            // save current data so that it be be PASTed later
            $messages = copyForm($_POST, $dbobject);

        } elseif (empty($errors) AND !empty($task_button)) {
            // look for a navigation or popup button which jumps to another script
            $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
            if (is_array($child_errors)) {
                $errors[$dbobject->getClassName()] = $child_errors;
            } // if

        } elseif (empty($errors) AND !empty($custom_button)) {
            // a custom button was pressed
            list($custom_btn, $btn_row, $btn_zone) = $custom_button;
            // save current data in case a custom button jumps to another script
            $script_vars['dbobject'] = serialize($dbobject);
            $fieldarray = $dbobject->customButton($fieldarray, $custom_btn, $_POST);
            if ($dbobject->errors) {
                $errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
            unset($custom_button);

        } elseif (empty($errors) AND !empty($submit_button)) {
            // this is a standard 'submit' button, so update the database
            $dbobject->startTransaction();
            $fieldarray = $dbobject->insertRecord($fieldarray);  // add this data to the database
            $messages   = array_merge($messages, $dbobject->getMessages());
            if ($dbobject->errors) {
                $errors = $dbobject->getErrors();
            } // if
            if (empty($errors)) {
                // "N records were inserted in XXXX"
                $messages[] = getLanguageText('sys0005', $dbobject->numrows, strtoupper($dbobject->tablename));
                $errors = $dbobject->commit();
                if (empty($errors)) {
                    //$messages[] = getLanguageText('sys0080'); // 'Record inserted OK'
                    if (isset($_POST['submitstay'])) {
                        // re-initialise data for a new record
                        $fieldarray = $dbobject->getInitialData($where);
                        // get any extra data and merge with $fieldarray
                        $fieldarray = $dbobject->getExtraData($fieldarray, $where);
                        if (isset($_SESSION['script_sequence'])) {
                            $script_vars['dbobject'] = serialize($dbobject);
                            // do other tasks before returning to this one
                            scriptNext($task_id);
                        } // if
                    } else {
                        // update was OK - return to previous screen
                        $selection = array2where($fieldarray, $dbobject->getPkeyNamesAdjusted());
                        $prev_script = getPreviousScript();
                        if (!empty($prev_script)) {
                            $prev_task   = getPreviousTask($prev_script);
                            $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
                        } // if
                        $messages = array_merge($messages, $dbobject->getMessages());
                        scriptPrevious(null, $messages, 'insert', $dbobject->getInstruction(), $selection);
                    } // if
                } // if
            } else {
                $dbobject->rollback();
            } // if
        } // if
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form where something has been selected
    if (!empty($return_from) AND (!empty($popup_object) OR isset($selection))) {
        // merge previous saved variables with selection from popup form
        $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection, null, $return_files);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
        } // if
    } // if
    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
} // if

if (isset($_SESSION['data'][$table_id])) {
    // saved data exists, so allow a PASTE button
    $prepend = array('paste' => 'paste');
    $act_buttons = array_merge($prepend, $act_buttons);
} // if

$messages = array_merge($messages, $dbobject->getMessages());

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND !empty($_POST) AND empty($errors) AND !empty($submit_button)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

if (!empty($errors)) {
    // all errors are associated with this table
	$errors2[$dbobject->getClassName()] = $errors;
	$errors = $errors2;
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
