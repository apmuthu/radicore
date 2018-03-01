<?php
// *****************************************************************************
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// Author: Kyle Brost <http://www.softelephant.com>
// *****************************************************************************

// name = std.filedownload1.inc

// type = filedownload1

// This will read a record which was selected on the previous page, then
// download a file specified on that record.

// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';  // this scrit MAY update the database

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (empty($where)) {
    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
} // if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
$dbobject->sql_select  = &$sql_select;
$dbobject->sql_from    = &$sql_from;
$dbobject->sql_where   = &$sql_where;
$dbobject->sql_groupby = &$sql_groupby;
$dbobject->sql_having  = &$sql_having;
// return a single selection only
$dbobject->setRowsPerPage(1);
// perform any initialisation
$where = $dbobject->initialise($where, $selection);
if (empty($dbobject->errors)) {
    // get data from the database
    $fieldarray = $dbobject->initialiseFileDownload($where);
} // if
if ($dbobject->errors) {
    // some sort of error - return to previous script
    scriptPrevious($dbobject->getErrors(), $messages);
} // if
if ($dbobject->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

if (!is_True($dbobject->skip_getdata)) {
    // allow this record to be updated in the database
    $dbobject->startTransaction();
    $fieldarray = $dbobject->updateRecord($fieldarray, array());
    if ($dbobject->errors) {
        $dbobject->rollback();
        $errors = $dbobject->getErrors();
    } else {
        $errors = $dbobject->commit();
    } // if
} // if

$messages = $dbobject->getMessages();

if ($errors) {
	scriptPrevious($errors, $messages);
} // if

$file = $dbobject->download_filename;
$mode = strtolower($dbobject->download_mode);
$data =& $dbobject->download_data;

if (empty($data)) {
    $handle = fopen($file, "r");
    if (!$handle)  {
        scriptPrevious(getLanguageText('sys0056'), $file); // 'File XXX cannot be found'
    } // if
    $content_type = getContentType($file);  // determine the mime-type for the specified file
} else {
    if (!empty($dbobject->content_type)) {
        $content_type = $dbobject->content_type;
    } else {
        $content_type = 'application/octet-stream';
    } // if
} // if

// remove spinner and re-enable submit button
setcookie('clean_up_screen_' . session_name(), $GLOBALS['task_id'], time()+30);

// send file to client browser
header("Content-type: " . $content_type);
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
if (isset($mode) and $mode == 'inline') {
    header("Content-Disposition: inline; filename=\"" .basename($file) ."\"");
} else {
    header("Content-Disposition: attachment; filename=\"" .basename($file) ."\"");
} // if
header('Cache-Control: no-store, no-cache, must-revalidate, pre-check=0, post-check=0, max-age=0');
header('Pragma: public');

if (empty($data)) {
    // read data from file on disk
    while (!feof($handle)) {
        echo fgets($handle, 8192);
    } // while
    fclose($handle);
} else {
    echo $data;
} // if

// remove this task from session dataas it no longer exists
$task_id = $_SESSION['pages'][getSelf()]['task_id'];
unset($_SESSION['pages'][getSelf()]);
$_SESSION['page_stack'] = reducePageStack($task_id);

ob_clean();
exit;
?>
