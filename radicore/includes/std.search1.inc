<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
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
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    // get any initial values
    $where = $dbobject->initialise($where);
    $fieldarray = where2array($where);
} // if

if (isset($_POST['clear'])) {
    // clear previous search
    unset($_SESSION['search'][$dbobject->tablename]);
    // clear all editable data from current selection
    $fieldarray = $dbobject->clearEditableData($fieldarray);
    $where      = array2where($fieldarray);
    $_SERVER['REQUEST_METHOD'] = 'GET';
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
    // save these variables for later in the same session
    $script_vars['dbobject'] = serialize($dbobject);
    $script_vars = updateScriptVars ($script_vars);
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // merge original data with user's input (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $fieldarray = array_update_associative($fieldarray, $_POST);
    // ensure that changes are stored inside relevant object
    $dbobject->setFieldArray($fieldarray);
    // look for an action which is another script
    $errors = childForm($_POST, array('dbobject' => $dbobject));

    if (!$errors) {
        if (isset($_POST['submit'])) {
            // initialise search criteria
            $where = ''; // use empty string (''), not NULL
            // perform any custom validation
            $fieldarray = $dbobject->validateSearch($fieldarray);
            // get current field specifications
            $fieldspec = $dbobject->getFieldSpec();
            // format POST data into SQL 'where' string
            $dateobj =& singleton::getInstance('date_class');
            foreach ($fieldarray as $field => $value) {
                // check that $field exists in $fieldspec array
                if (!isset($fieldspec[$field]) OR isset($fieldspec[$field]['noedit'])) {
                    // it does not (like the SUBMIT button, for example), so ignore it
                    //unset($fieldarray[$field]);
                } else {
                    if (is_string($value)) {
                    	// strip leading/trailing spaces
                        $value = trim($value);
                    } // if
                    // deal with non-empty fields only
                    if (strlen($value) > 0) {
                        $spec     = $fieldspec[$field];
                        $operator = '=';
                        if (preg_match('/^(is not null|is null)$/i', $value, $regs )) {
                            $value = strtoupper($regs[0]);
                            $spec['type'] = 'string';
                            $operator = '';
                        } else {
                            switch ($spec['type']) {
                            	case 'date':
                            	    // if this is a complete and valid date then replace it
                                    if ($internaldate = $dateobj->getInternalDate($value)) {
                                        // value is a valid date
                                        $value = $internaldate;
                                    } else {
                                        $errors[$field] = getLanguageText('sys0040');  // this is not a valid date
                                    } // if
                            		break;
                            	case 'time':
                                    // if this is a complete and valid time replace it
                                    if ($internaltime = $dateobj->getInternalTime($value)) {
                                        $value = $internaltime;
                                    } else {
                                        $errors[$field] = getLanguageText('sys0041');  // this is not a valid TIME
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
                                    $locale = localeconv();
                                    // remove thousands separator before using in an sql SELECT statement
                                    $value = str_replace($locale['thousands_sep'], '', $value);
                                    // convert user's decimal point to '.'
                                    $value = str_replace($locale['decimal_point'], '.', $value);
                                    if (eregi('float|real',$spec['type'])) {
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
                                        $value = number_format($value, $decimal_places, '.', '');
                                    } // if
                            	    break;
                            	default:
                            	    if (substr_count($value, '%') > 0) {
                                    	$operator = 'LIKE';
                                    } else {
                                        if (isset($fieldspec[$field]['control'])) {
                                        	$operator = '=';
                                        } else {
                                            $operator = 'LIKE';
                                            $value .= '%';  // append wildcard character by default
                                        } // if
                                    } // if
                            		break;
                            } // switch
                        } // if

                        $value = addslashes($value);
                        if (!empty($where)) {
                            $where .= ' AND ';
                        } // if

                        switch ($spec['type']) {
                            case 'enum':
                                // ignore value 0 as this is same as NULL
                                if ($value > 0) {
                                    // $value is index number, use exact match
                                    $where .= "$field = $value";
                                } else {
                                    $where = rtrim($where, ' AND');
                                } // if
                                break;
                            case 'boolean':
                                if (preg_match('/^(true|false)$/i', $value, $regs )) {
                                    $where .= "$field=$value";
                                } else {
                                    $where .= "$field LIKE '$value'";
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
                                	$where .= "$field LIKE '$value'";
                                } else {
                                    $where .= $field.$operator.$value;
                                } // if
                                break;
                            default:
                                if (!empty($operator)) {
                                	$where .= "$field $operator '$value'";
                                } else {
                                    $where .= "$field $value";
                                } // if
                                break;
                        } // switch

                    } // if
                } // if
            } // foreach
            if (empty($errors)) {
            	if (empty($where)) {
                    if (isset($_SESSION['search'][$dbobject->tablename])) {
                    	// clear saved search criteria
                        unset($_SESSION['search'][$dbobject->tablename]);
                    } // if
                } else {
                    // save this search criteria
                    $_SESSION['search'][$dbobject->tablename] = $where;
                } // if
                // send search criteria back to the previous script
                $prev_script = getPreviousScript();
                $prev_task   = getPreviousTask($prev_script);
                $_SESSION[$prev_script][$prev_task]['search'] = $where;
                scriptPrevious(null, null, 'search');
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
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
