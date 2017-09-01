<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
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
$act_buttons['submitBtn'] = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['clear']     = 'clear';
$act_buttons['quit']      = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance of this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $fieldarray = $dbobject->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    $dbobject->sql_search_table = &$sql_search_table;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->setRowsPerPage(1);  // only one row at a time
//    if (!empty($selection)) {
//    	$dbobject->sql_selection = $selection;
//    } // if
    //$dbobject->no_foreign_data = TRUE;  // do not look up data for foreign keys
    $dbobject->no_foreign_data = FALSE;
    // get any initial values
    $null = null;
    $where = $dbobject->initialise($where, $selection, $task_selection);
    $fieldarray = $dbobject->fieldarray;
    if ($dbobject->errors) {
        scriptPrevious($dbobject->errors);
    } // if
} // if

if (isset($_POST['clear'])) {
    if (is_array($_SESSION['search'])) {
        // clear previous search
        unset($_SESSION['search'][$dbobject->tablename]);
    } // if
    // clear all editable data from current selection
    $fieldarray = $dbobject->clearEditableData($fieldarray);
    $where      = array2where($fieldarray);
    $_SERVER['REQUEST_METHOD'] = 'GET';
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND (!empty($popup_object) OR isset($selection))) {
        // merge previous saved variables with selection from popup form
        $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection, null, $return_files);
        if ($dbobject->errors) {
            $errors[$dbobject->getClassName()] = $dbobject->getErrors();
        } // if
        // get any data which may contain LOOKUP options
        $fieldarray = $dbobject->getExtraData($fieldarray);
    } else {
        // get any data which may contain LOOKUP options
        $fieldarray = $dbobject->getExtraData($fieldarray);
        // get field specifications for current object
        $fieldspec = $dbobject->getFieldSpec();
        // insert any missing fields from $fieldspec
        foreach ($fieldspec as $fieldname => $fieldspec) {
            if (!isset($fieldarray[$fieldname])) {
                $fieldarray[$fieldname] = null;
            } // if
        } // foreach
        // store updated array inside $dbobject
        $dbobject->setFieldArray($fieldarray);
        // save current settings
        $script_vars['where'] = $where;
    } // if
    if (!empty($dbobject->errors)) {
        $errors = array_merge($errors, $dbobject->errors);
    } // if
    // save these variables for later in the same session
    $script_vars['dbobject'] = serialize($dbobject);
    $script_vars = updateScriptVars ($script_vars);

    $dbobject->fieldarray = $fieldarray;  // replace data lost during serialization
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button($act_buttons, $_POST);
    $task_button   = check_task_button($_POST);
    if (!empty($submit_button) OR !empty($task_button)) {
        // merge original data with user's input (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
        // get any data which may contain LOOKUP options
        $fieldarray = $dbobject->getExtraData($fieldarray);

        if (!empty($task_button)) {
            // look for a navigation or popup button which jumps to another script
            $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
            if (is_array($child_errors)) {
                $errors[$dbobject->getClassName()] = $child_errors;
            } // if
        } // if
    } // if

    if (empty($errors) AND !empty($submit_button)) {
        // initialise search criteria
        $search = ''; // use empty string (''), not NULL
        $search = $task_selection;  // fixed selection criteria
        // format data for internal use
        $fieldarray = $dbobject->unFormatData($fieldarray);
        // perform any custom validation
        $fieldarray = $dbobject->validateSearch($fieldarray);
        $errors = $dbobject->getErrors();
        // get current field specifications
        $fieldspec = $dbobject->getFieldSpec();
        // format POST data into SQL 'where' string
        $dateobj = RDCsingleton::getInstance('date_class');
        foreach ($fieldarray as $field => $value) {
            // check that $field exists in $fieldspec array
            if (!isset($fieldspec[$field]) OR isset($fieldspec[$field]['noedit']) OR isset($fieldspec[$field]['nosearch'])) {
                // it does not (like the SUBMIT button, for example), so ignore it
                //unset($fieldarray[$field]);
            } else {
                if ($field == 'curr_or_hist') {
                    if (!array_key_exists($field, $_POST)) {
                    	// not submitted, so ignore default value
                    	$value = '';
                    } // if
                } // if
                if (is_string($value)) {
                    // strip leading/trailing spaces
                    $value = trim($value);
                } // if
                // deal with non-empty fields only
                if ((is_string($value) AND strlen($value) > 0) OR (is_array($value) AND count($value) > 0)) {
                    $spec     = $fieldspec[$field];
                    if (!isset($spec['type'])) {
                        $spec['type'] = 'string';  // not specified so default to 'string'
                    } // if
                    $operator = '=';
                    if (is_string($value) AND preg_match('/^(is not null|is null)$/i', $value, $regs )) {
                        $value = strtoupper($regs[0]);
                        $spec['type'] = 'string';
                        $operator = '';
                    } else {
                        switch ($spec['type']) {
                            case 'date':
                            	if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $value, $regs )) {
                                    $operator = $regs[0];
                                    $value = ltrim($value, $operator);
                                } // if
                            	// if this is a complete and valid date then replace it
                                if ($internaldate = $dateobj->getInternalDate($value)) {
                                    // value is a valid date
                                    $value = $internaldate;
                                } else {
                                    //$errors[$field] = getLanguageText('sys0040');  // this is not a valid date
                                    $errors[$dbobject->getClassName()][$field] = $dateobj->errors;
                                } // if
                            	break;
                            case 'time':
                            	if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $value, $regs )) {
                                    $operator = $regs[0];
                                    $value = ltrim($value, $operator);
                                } // if
                                // if this is a complete and valid time replace it
                                if ($internaltime = $dateobj->getInternalTime($value)) {
                                    $value = $internaltime;
                                } else {
                                    //$errors[$field] = getLanguageText('sys0041');  // this is not a valid TIME
                                    $errors[$field] = $dateobj->errors;
                                } // if
                                break;
                            case 'datetime':
                            case 'timestamp':
                            	if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $value, $regs )) {
                                    $operator = $regs[0];
                                    $value = ltrim($value, $operator);
                                } // if
                                // if this is a complete and valid date then replace it
                                if ($internaldatetime = $dateobj->getInternalDateTime($value)) {
                                    // value is a valid date
                                    $value = $internaldatetime;
                                    if (!empty($_SESSION['timezone_server']) AND !empty($_SESSION['timezone_client'])) {
                                	    $value = convertTZ($value, $_SESSION['timezone_client'], $_SESSION['timezone_server']);
                                	} // if
                                } else {
                                    //$errors[$field] = getLanguageText('sys0048');  // this is not a valid date/time
                                    $errors[$field] = $dateobj->errors;
                                } // if
                            	break;
                            case 'boolean':
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
                                break;
                            case 'set':
                            case 'array':
                            case 'varray':
                                // convert array to string with comma separator (MySQL)
                                $value = $dbobject->array2string($value);
                                break;
                            case 'decimal':
                            case 'numeric':
                            case 'integer':
                            case 'double':
                            case 'float':
                            case 'real':
                                if (substr_count($value, '%') > 0) {
                                    $operator = 'LIKE';
                                } else {
                                    if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $value, $regs )) {
                                        $operator = $regs[0];
                                        $value = ltrim($value, $operator);
                                    } // if
                                } // if
                                // replace foreign decimal point and thousands separator
                                $value = number_unformat($value);
                                if (preg_match('/(float|real)/i',$spec['type'])) {
                                    $value = sprintf('%f', $value);
                                    // remove trailing zeroes after any decimal point
                                    $value = rtrim($value,'0');
                                    // remove any trailing decimal point
                                    $value = rtrim($value, '.');
                                } else {
                                    if (isset($fieldspec[$field]['scale'])) {
                                       $decimal_places = $fieldspec[$field]['scale'];
                                    } else {
                                       $decimal_places = 0;
                                    } // if
                                    $value = number_format((double)$value, $decimal_places, '.', '');
                                } // if
                            	break;
                            default:  // type = 'string'
                            	if (is_string($value) AND substr_count($value, '%') > 0) {
                                    // value already contains a wildcard character
                                    $operator = 'LIKE';
                            	} else {
                                    if (isset($fieldspec[$field]['control'])) {
                                        if (isset($fieldspec[$field]['allow_input'])) {
                                            $operator = 'LIKE';
                                            if (substr_count($value, '%') == 0) {
                                                // no wildcard character, so append one by default
                                                $value .= '%';
                                            } // if
                                        } elseif ($fieldspec[$field]['control'] == 'multidrop' AND is_array($value)) {
                                            foreach ($value as $key => $entry) {
                                                $value[$key] = addslashes($entry);
                                            } // foreach
                                            $value = "IN ('" .implode("','", $value) ."')";
                            	            $operator = '';
                                        } else {
                                        	$operator = '=';
                                        } // if
                                    } else {
                                        $operator = 'LIKE';
                                        $value .= '%';  // append wildcard character by default
                                    } // if
                                } // if
                            	break;
                        } // switch
                    } // if

                    //$value = addslashes($value);
                    if (!empty($search)) {
                        $search .= ' AND ';
                    } // if

                    switch ($spec['type']) {
                        case 'enum':
                            $enum = true;
                            if (!is_numeric($value) AND !empty($spec['values']) AND is_array($spec['values'])) {
                                $flip = array_flip($spec['values']);
                                if (array_key_exists($value, $flip)) {
                                    $search .= "$field = '$value'";  // value is a string, so enclose in quotes
                                } // if
                            } elseif (is_numeric($value) AND $value > 0) {  // ignore value 0 as this is same as NULL
                                $search .= "$field = $value";  // $value is index number, so do NOT enclose in quotes
                            } else {
                                $search = rtrim($search, ' AND');  // this is no longer needed
                            } // if
                            break;
                        case 'boolean':
                            if (preg_match('/^(true|false)$/i', $value, $regs )) {
                                $search .= "$field=$value";
                            } else {
                                $search .= "$field LIKE '$value'";
                            } // if
                            break;
                        case 'numeric':
                        case 'decimal':
                        case 'integer':
                        case 'double':
                        case 'float':
                        case 'real':
                            // include specified operator (which is variable)
                            if ($operator == 'LIKE') {
                                $search .= "$field LIKE '$value'";
                            } else {
                                $search .= $field.$operator.$value;
                                //$search .= $field.$operator."'$value'";
                            } // if
                            break;
                        default:
                            if (!empty($operator)) {
                                $search .= "$field $operator '" .addslashes($value) ."'";
                            } else {
                                $search .= "$field $value";
                            } // if
                            break;
                    } // switch

                } // if
            } // if
        } // foreach
        if (empty($errors)) {
            if (!empty($dbobject->sql_search_table)) {
                $search_table = $dbobject->sql_search_table;
            } else {
                $search_table = $dbobject->tablename;
            } // if
            if (empty($search)) {
                if (isset($_SESSION['search']) AND is_array($_SESSION['search']) AND isset($_SESSION['search'][$search_table])) {
                    // clear saved search criteria
                    unset($_SESSION['search'][$search_table]);
                } // if
            } else {
                // save this search criteria
                $_SESSION['search'][$search_table] = $search;
            } // if
            // perform any final processing
            $search = $dbobject->post_search($search, $dbobject->sql_selection);
            $errors = array_merge($errors, $dbobject->getErrors());
        } // if
        if (empty($errors)) {
            // send search criteria back to the previous script
            $prev_script = getPreviousScript();
            $prev_task   = getPreviousTask($prev_script);
            $_SESSION['pages'][$prev_script][$prev_task]['search'] = $search;
            scriptPrevious($errors, $messages, 'search');
        } else {
            foreach ($errors as $key => $value) {
                if ($key != $dbobject->getClassName()) {
                	$errors[$dbobject->getClassName()][$key] = $value;
                	unset($errors[$key]);
                } // if
            } // foreach
        } // if
    } // if
} // if

$fieldarray = $dbobject->setFieldArray($fieldarray);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
