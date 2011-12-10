<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add3.inc

// type = add3

// This will add one or more records to the database using data in $where (supplied by
// the previous screen) plus data selected by a popup screen which will be called next.
// Note that there is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;

// perform initialisation, check workflow, etc
//$where = $dbobject->initialise($where, $selection);
$where = $dbobject->initialise($where);
if ($dbobject->errors) {
    $messages = array_merge($messages, $dbobject->getMessages());
    $batch_errors = scriptPrevious($dbobject->getErrors(), $messages);
    return $batch_errors;
} // if

if (!isset($popup_task)) {
	$popup_task =& $popup_screen;
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (basename($return_from) <> $popup_task) {
        // have not been to popup screen yet, so go there now
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $script_vars = $_SESSION['pages'][$PHP_SELF][$task_id];
        $fieldarray  = where2array($where);
        $settings    = null;
        // may need to adjust contents of $where and $settings
        $where       = $dbobject->popupCall($popup_task, $where, $script_vars, $fieldarray, $settings);
        $task_array['settings'] = $settings;
        $batch_errors = scriptNext($popup_task, $where, null, $task_array);
        return $batch_errors;
    } else {
        if (empty($selection)) {
            if (empty($errors)) {
            	// 'Nothing selected from popup screen'
                $errors[] = getLanguageText('sys0083');
            } // if
            $batch_errors = scriptprevious($errors, null, 'quit');
            return $batch_errors;
        } // if
    } // if

    // We now have some data in $where (from the previous screen)
    // and some in $selection (from the popup screen).
    // First, convert from SQL 'where' format to arrays
    $where  = unqualifyWhere($where);
    $array1 = where2array($where, false, false);

    // split $selection into one or more rows using ') OR (' separator
    $array2 = splitWhereByRow($selection);

    $dbobject->startTransaction();

    $count = 0;

    foreach ($array2 as $row) {
        // convert row string into an array
        $array3 = where2array($row, false, false);
        // merge into a single array
        $fieldarray = array_merge($array1, $array3);
        // strip operators from field values
        $fieldarray = stripOperators($fieldarray);
        // get any extra data that may be needed
        $fieldarray = $dbobject->getExtraData($fieldarray);
        // now add combined values to the database
        $fieldarray = $dbobject->insertRecord($fieldarray);
        $count = $count + $dbobject->getNumRows();
        $messages   = array_merge($messages, $dbobject->getMessages());
        if ($dbobject->errors) {
            // reduce array to primary key for error message
            $where2 = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
            $errors[] = getLanguageText('sys0084', $where2); // "Cannot insert where $where2"
            $errors = array_merge($errors, array_unique($dbobject->getErrors()));
        } // if
    } // foreach

    $errors2 = $dbobject->commit();
    $errors  = array_merge($errors, $errors2);

    // return a count of affected rows
    $messages[] = getLanguageText('sys0005', $count, strtoupper($dbobject->getTableName())); // 'N records were inserted'

    if (empty($errors)) {
    	$action = 'OK';
    } else {
        $action = null;
    } // if

    // last, return to previous screen
    $batch_errors = scriptPrevious($errors, $messages, $action);
    return $batch_errors;
} // if

?>
