<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update3.inc

// type = update3

// This will allow multiple rows in a control table to be displayed and updated.
// A 'control' table contains columns labelled 'field_id' and 'field_value' and
// can contain any number of rows. These are presented to the user using the
// contents of these columns and therefore appear as a number of columns from
// a single database row.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//	// $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit'] = 'submit';
$act_buttons['quit']   = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    // get previous data
    $fieldarray = $dbobject->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    // perform any initialisation
    $where = $dbobject->initialise($where, $selection);
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors());
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
        } // if
    } else {
        // get data from the database
        $fieldarray = $dbobject->getData($where);
        if ($dbobject->errors) {
            // some sort of error - return to previous script
            scriptprevious($dbobject->getErrors(), $messages);
        } // if
        // get any extra data and merge with $fieldarray
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
        	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
        } // if
    } // if

    // save these variables for later in the same session
    $script_vars['where']    = $where;
    $script_vars['dbobject'] = serialize($dbobject);
    $script_vars = updateScriptVars ($script_vars);
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $fieldarray = array_update_associative($fieldarray, $_POST);
    // ensure that changes are stored inside relevant object
    $dbobject->setFieldArray($fieldarray);
    // look for an action which is another script
    $errors = childForm($_POST, array('dbobject' => $dbobject));
    if (empty($errors)) {
        $dbobject->startTransaction();
        // update this data in the database
        $msg = $dbobject->updateSelection($fieldarray, null);
        if ($dbobject->errors) {
			// errors are keyed by object name
		    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
		} // if
        if (empty($errors)) {
            $errors = $dbobject->commit();
            if (empty($errors)) {
                // update was OK - return to previous screen
                scriptPrevious(null, $msg, 'OK', $dbobject->getInstruction());
            } // if
        } else {
            $dbobject->rollback();
        } // if
    } // if
} // if

if (!empty($msg) AND !is_array($msg)) {
	$messages[] = $msg;
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
