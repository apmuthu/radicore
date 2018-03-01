<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output4.inc

// type = output4

// This will output the contents a database table to a CSV file, then download
// it to the client device.

// This will show the user which fields are available and get him to select the
// ones which are wanted, and only these will be output to the CSV file.

require_once 'include.general.inc';

$mode = 'csv';      // identify output mode

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    if (empty($where)) {
//    	// only use $selection if $where is empty
//        $where = $selection;
//        $selection = null;
//    } // if
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn'] = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['quit']      = 'cancel';

// create an instance for the header area
require_once "output4_header.class.inc";
if (isset($script_vars['dbouter'])) {
    $dbouter = unserialize($script_vars['dbouter']);
    $outer_data = $dbouter->getFieldArray(); // get data from this instance
    $dbouter->setFieldArray($outer_data);
} else {
    $dbouter = new output4_header;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->setRowsPerPage(1);
    //$null = $dbouter->initialise();  // perform any initialisation
    $outer_data = array();
    $outer_data = $dbouter->getExtraData($outer_data);
} //if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance for this script
    $dbinner = unserialize($script_vars['dbinner']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbinner->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $inner_data = $dbinner->getFieldArray();
    $dbinner->fieldspec = $dbinner->saved_fieldspec;
} else {
    $dbinner = new $table_id;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->sql_select                = &$sql_select;
    $dbinner->sql_from                  = &$sql_from;
    $dbinner->sql_where                 = &$sql_where;
    $dbinner->sql_groupby               = &$sql_groupby;
    $dbinner->sql_having                = &$sql_having;
    if (!empty($sql_orderby)) {
        $dbinner->setDefaultOrderby($sql_orderby);
    } elseif (isset($task_orderby)) {
        $dbinner->setDefaultOrderby($task_orderby);
    } // if

    // perform any initialisation
    $where = $dbinner->initialise($where, $selection, $search);
    if ($dbinner->errors) {
       	scriptPrevious($dbinner->getErrors());
    } // if

    // get any data for lookup lists
    $inner_data = $dbinner->getExtraData($where);

    // load optional criteria from search screen
    if (isset($search)) {
        $dbinner->setSqlSearch($search);
    } // if
    $inner_data = $dbinner->getColumnNames($where);
    if ($dbinner->errors) {
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } // if
} // if

$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND (!empty($popup_object) OR isset($selection))) {
        // merge previous saved variables with selection from popup form
        $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, null, $return_files);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button($act_buttons, $_POST);
    $task_button   = check_task_button($_POST);
    $custom_button = check_custom_button($_POST);
    if ($submit_button OR $task_button OR $custom_button) {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $inner_data = array_update_indexed($inner_data, $_POST, $dbinner->fieldspec);
        // ensure that changes are stored inside relevant object
        $dbinner->setFieldArray($inner_data);

    } else {
        // deal with a javascript 'submit()'.
        $outer_data = $dbouter->updateFieldArray($outer_data, $_POST);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        $inner_data = $dbinner->getFieldArray();  // inner data may have been rebuilt
    } // if

    if (empty($errors) AND !empty($task_button)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbinner' => $dbinner), $task_button);
        if (is_array($child_errors)) {
            $errors[$dbinner->getClassName()] = $child_errors;
        } // if

    } elseif (empty($errors) AND !empty($custom_button)) {
        // a custom button was pressed
        list($custom_btn, $btn_row, $btn_zone) = $custom_button;
        // save current data in case a custom button jumps to another script
        $script_vars['dbouter'] = serialize($dbouter);
        $outer_data = $dbouter->customButton($outer_data, $custom_btn, $_POST);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        unset($custom_button);

    } elseif (empty($errors) AND !empty($submit_button)) {
        // look for LIMIT and OFFSET values
        $rdc_limit  =& $_POST['rdc_limit'];
        $rdc_offset =& $_POST['rdc_offset'];
        if (strlen($rdc_limit) < 1 OR !is_numeric($rdc_limit) OR $rdc_limit < 1) {
            // LIMIT must be a number which is greater than or equal to 1
            $errors['rdc_limit'] = getLanguageText('sys0223');
        } // if
        if (strlen($rdc_offset) < 1 OR !is_numeric($rdc_limit) OR $rdc_limit < 0) {
            // OFFSET must be a number which is greater than or equal to 0
            $errors['rdc_offset'] = getLanguageText('sys0224');
        } // if

        // check that all data is valid before we continue
        foreach ($inner_data as $rownum => &$rowdata) {
            $rowdata = $dbinner->validateUpdate($rowdata, true, false);  // perform PRIMARY validation only
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()][$rownum] = $dbinner->getErrors();
            } // if
        } // foreach
        unset($rowdata);

        if (empty($errors)) {
            $dbinner->fieldspec = $dbinner->getFieldSpec_original();
            $dbinner->setRowsPerPage(0);  // allow ALL rows to be retrieved
            // get data from the database
            $resource = $dbinner->getData_serial($where, $rdc_limit, $rdc_offset);

            if ($dbinner->getNumRows() <= 0) {
                // 'Nothing retrieved from the database.'
                $errors[] = getLanguageText('sys0085');
            } // if

            if (empty($errors)) {
                if (empty($csvout)) {
                    // set default value
    	            $csvout = $table_id .'.csv';
                } // if

                // create an instance of the CSV object
                require_once 'std.csv.class.inc';
                $csv = new csv_class($dbinner);

                // transform output to CSV format
                $output = $csv->outputCSV($resource, $dbouter);
                if ($csv->errors) {
                    $string = format_array($csv->errors);
                    display_on_stdout($string);
                } // if

                if (!empty($output)) {
                    // remove spinner and re-enable submit button
                    setcookie('clean_up_screen_' . session_name(), $GLOBALS['task_id'], time()+30);
    	            // download to client browser
                    header("Content-type: text/comma-separated-values");
                    header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
                    header("Content-Disposition: attachment; filename=" .$csvout);
                    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
                    header('Pragma: public');
                    echo $output;
                    flush();
                    ob_flush();
                } // if
                //scriptPrevious($errors, $messages);
                exit;
            } // if
        } // if
    } // if
} // if

$mode = 'update';      // identify mode for building the screen

$messages = $dbouter->getMessages();
$messages = array_merge($messages, $dbinner->getMessages());

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbouter']  = serialize($dbouter);
$script_vars['dbinner']  = serialize($dbinner);
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray  = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray  = $inner_data;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;
?>
