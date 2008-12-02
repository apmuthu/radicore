<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
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

if (!empty($selection) AND !isset($return_from)) {
    // $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
    if (empty($where)) {
    	// only use $selection if $where is empty
        $where = $selection;
        $selection = null;
    } // if
} // if

if (isset($_POST['quit']) OR isset($_GET['quit'])) {
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
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    // remove any fields which are auto_increment
    $where_array = where2array($where);
    foreach ($where_array as $fieldname => $fieldvalue) {
    	if (array_key_exists('auto_increment', $dbobject->fieldspec[$fieldname])) {
    		unset($where_array[$fieldname]);
    	} // if
    } // foreach
    $where = array2where($where_array);
    // get initial data for a new record
    $where = $dbobject->initialise($where, $selection);
    if (empty($dbobject->errors)) {
    	$fieldarray = $dbobject->getInitialData($where);
    } // if
    if ($dbobject->errors) {
        scriptPrevious($dbobject->errors, $messages);
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors[$dbobject->getClassName()] = $dbobject->errors;
            } // if
        } // if
    } // if
    if (empty($where)) {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if
    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
    if ($dbobject->errors) {
    	$errors[$dbobject->getClassName()] = $dbobject->errors;
    	scriptPrevious($dbobject->errors, $messages);
    } // if
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = pasteData($dbobject->fieldspec, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        // redo any initialisation
        $fieldarray = $dbobject->getInitialData($fieldarray);
        // get any extra data and merge with $fieldarray
        $fieldarray = $dbobject->getExtraData($fieldarray);
    } elseif (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);
    } else {
        // merge original data with user's input (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST);
        // get any extra data and merge with $fieldarray
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
        	$errors[$dbobject->getClassName()] = $dbobject->errors;
        } else {
            // look for an action which is another script
            $errors = childForm($_POST, array('dbobject' => $dbobject));
            if ($errors) {
            	$errors[$dbobject->getClassName()] = $errors;
            } // if
        } // if
		if (empty($errors)) {
		    $dbobject->startTransaction();
            // add this data to the database
            $fieldarray = $dbobject->insertRecord($fieldarray);
            if (!empty($dbobject->messages)) {
                $messages = array_merge($messages, $dbobject->messages);
            } // if
            if ($dbobject->errors) {
				$errors[$dbobject->getClassName()] = $dbobject->errors;
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
                        if (!empty($dbobject->messages)) {
                            $messages = array_merge($messages, $dbobject->messages);
                        } // if
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
                        scriptPrevious(null, $messages, 'insert', $dbobject->getInstruction());
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

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->messages);
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
