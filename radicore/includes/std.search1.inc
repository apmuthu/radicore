<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.search1.inc

// script of type search1

// This will show a blank detail screen and allow the user to specify search criteria
// that will then be returned to the previous screen for action.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'search';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['clear']  = 'clear';
$act_buttons['submit'] = 'submit';
$act_buttons['quit']   = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance of this script
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
} // if

if (isset($_POST['clear'])) {
    // clear previous search
    unset($_SESSION['search'][$dbobject->tablename]);
    // clear all data from current selection
    $dbobject->setFieldArray($_POST);
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET'
or isset($_POST['clear'])) {
    // check if we are returning from a child form
    if (!empty($return_from)) {
        if ($return_action == 'choose' AND !empty($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            $errors = array_merge($errors, $dbobject->getErrors());
        } // if
    } else {
        // get any data which may contain LOOKUP options
        $fieldarray = $dbobject->getExtraData($where);
        // get field specifications for current object
        $fieldspec = $dbobject->getFieldSpec();
        // insert any missing fields from $fieldspec
        foreach ($fieldspec as $fieldname => $spec) {
            if (!array_key_exists($fieldname, $fieldarray)) {
                $fieldarray[$fieldname] = null;
            } // if
        } // foreach
        // store updated array inside $dbobject
        $dbobject->setFieldArray($fieldarray);
        // save current settings
        $script_vars['where'] = $where;
    } // if
    $script_vars['dbobject'] = serialize($dbobject);
    $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
    $_SESSION[$PHP_SELF][$task_id] = $script_vars;
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // merge original data with user's input (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $fieldarray = array_update($fieldarray, $_POST);
    // check to see if a popup form has been called
    // look for an action which is another script
    $errors = childForm($_POST, $dbobject, 'dbobject', $where, $fieldarray);

    if (!$errors) {
        if (isset($_POST['submit'])) {
            // initialise search criteria
            $where = ''; // use empty string (''), not NULL
            // get current field specifications
            $fieldspec = $dbobject->getFieldSpec();
            // format POST data into SQL 'where' string
            $fieldarray = $_POST;
            require_once 'std.datevalidation.class.inc';
            $dateobj =& singleton::getInstance('date_class');
            foreach ($fieldarray as $field => $value) {
                // check that $field exists in $fieldspec array
                if (!array_key_exists($field, $fieldspec)) {
                    // it does not (like the SUBMIT button, for example), so remove it
                    unset ($fieldarray[$field]);
                } else {
                    // strip leading/trailing spaces
                    $value = trim($value);
                    // deal with non-empty fields only
                    if (strlen($value) > 0) {
                        $spec = $fieldspec[$field];

                        if ($spec['type'] == 'date') {
                            // if this is a complete and valid date then replace it
                            if ($internaldate = $dateobj->getInternalDate($value)) {
                                // value is a valid date
                                $value = $internaldate;
                            } else {
                                // not a complete/valid date, so append pattern symbol
                                $value .= '%';
                            } // if
                        } elseif ($spec['type'] == 'time') {
                            // if this is a complete and valid time replace it
                            if ($internaltime = $dateobj->getInternalTime($value)) {
                                $value = $internaltime;
                            } else {
                                // not a complete/valid date, so append pattern symbol
                                $value .= '%';
                            } // if
                        } elseif ($spec['type'] == 'boolean') {
                            // result from radiogroup/checkbox may be varied, so convert to TRUE or FALSE
                            // (where actual values are defined within $fieldspec)
                            if (is_true($value)) {
                                if (isset($spec['true'])) {
                                    $value = $spec['true'];
                                } // if
                            } else {
                                if (isset($spec['false'])) {
                                    $value = $spec['false'];
                                } // if
                            } // if
                        } // if
                        $value = addslashes($value);
                        if (!empty($where)) {
                            $where .= ' AND ';
                        } // if
                        if ($spec['type'] == 'enum') {
                            // ignore value 0 as this is same as NULL
                            if ($value > 0) {
                                // $value is index number, use exact match
                                $where .= "$field = $value";
                            } else {
                                $where = rtrim($where, ' AND');
                            } // if
                        } else {
                            if (preg_match('/^(is not null|is null)$/i', $value, $regs )) {
                                $where .= $field .' ' .strtoupper($regs[0]);
                            } else {
                                // value is text, use pattern match
                                $where .= "$field LIKE '$value'";
                            } // if
                        } // if
                    } // if
                } // if
            } // foreach
            if (empty($where)) {
                // clear saved search criteria
                unset($_SESSION['search'][$dbobject->tablename]);
            } else {
                // save this search criteria
                $_SESSION['search'][$dbobject->tablename] = $where;
            } // if
            // send search criteria back to the previous script
            $prev_script = getPreviousScript();
            $prev_task   = getPreviousTask($prev_script);
            $_SESSION[$prev_script][$prev_task]['search'] = $where;
            scriptPrevious(null, null, 'OK');
        } // if
    } // if
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
