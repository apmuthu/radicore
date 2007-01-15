<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
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

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit']     = 'submit';
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['copy']       = 'copy';
$act_buttons['quit']       = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    // get previous data
    $fieldarray = $dbobject->getFieldArray();
    if (!is_string(key($fieldarray))) {
        // indexed by row, so use row zero only
        $fieldarray = $fieldarray[key($fieldarray)];
    } // if
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    if (!empty($selection)) {
        // retrieve profile has been passed down from previous screen
        $where     = $selection;
        $selection = null;
    } // if
    // get initial data for a new record
    $fieldarray = $dbobject->getInitialData($where);
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors(), $messages);
    } // if
    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND $return_action == 'choose') {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
        } // if
    } // if
    if (empty($where)) {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = array_merge_nonkey($dbobject->fieldspec, $fieldarray, $_SESSION['data'][$table_id]);
        // redo any initialisation
        $fieldarray = $dbobject->getInitialData($fieldarray);
        $fieldarray = $dbobject->getExtraData($fieldarray);
    } elseif (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);
    } else {
        // merge original data with user's input (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);
        // look for an action which is another script
        $errors = childForm($_POST, array('dbobject' => $dbobject), $where);
		if (empty($errors)) {
            $dbobject->startTransaction();
            // add this data to the database
            $fieldarray = $dbobject->insertRecord($fieldarray);
            $messages   = array_merge($messages, $dbobject->getMessages());
            if ($dbobject->errors) {
				// errors are keyed by object name
			    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
			} // if
            if (empty($errors)) {
                $errors = $dbobject->commit();
                if (empty($errors)) {
                    if (isset($_POST['submitstay'])) {
                        $messages[] = getLanguageText('sys0080'); // 'Record inserted OK';
                        // re-initialise data for a new record
                        $fieldarray = $dbobject->getInitialData($where);
                        // get any extra data and merge with $fieldarray
                        $fieldarray = $dbobject->getExtraData($fieldarray);
                        if (isset($_SESSION['script_sequence'])) {
                            // do other tasks before returning to this one
                            scriptNext($task_id);
                        } // if
                    } else {
                        // update was OK - return to previous screen
                        scriptPrevious(null, $messages, 'OK', $dbobject->getInstruction());
                    } // if
                } // if
            } else {
                $dbobject->rollback();
            } // if
        } // if
    } // if
} // if

if (isset($_SESSION['data'][$table_id])) {
    // saved data exists, so allow a PASTE button
    $prepend = array('paste' => 'paste');
    $act_buttons = array_merge($prepend, $act_buttons);
} // if

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
