<?php
// *****************************************************************************
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// Author: Kyle Brost <http://www.softelephant.com>
// *****************************************************************************

// name = std.filedownload1.inc

// type = filedownload1

// This will read a record which was selected on the previous page, then
// download a file specified on that record.

// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

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

// get data from the database
$fieldarray = $dbobject->initialiseFileDownload($where);
if ($dbobject->errors) {
    // some sort of error - return to previous script
    scriptPrevious($dbobject->getErrors(), $messages);
} // if
if ($dbobject->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// allow this record to be updated in the database
$dbobject->startTransaction();
$fieldarray = $dbobject->updateRecord($fieldarray, array());
if ($dbobject->errors) {
    $dbobject->rollback();
    $errors = $dbobject->getErrors();
} else {
    $errors = $dbobject->commit();
} // if

$messages = $dbobject->getMessages();

if ($errors) {
	scriptPrevious($errors, $messages);
} // if

$file = $dbobject->download_filename;
$mode = strtolower($dbobject->download_mode);

$handle = fopen($file, "r");
if (!$handle)  {
    scriptPrevious(getLanguageText('sys0056'), $file); // 'File XXX cannot be found'
} // if

// determine the mime-type for the specified file
$content_type = getContentType($file);

header("Content-type: " . $content_type);
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
if (isset($mode) and $mode == 'inline') {
    header("Content-Disposition: filename=\"" .basename($file) ."\"");
} else {
    header("Content-Disposition: attachment; filename=\"" .basename($file) ."\"");
} // if
header('Cache-Control: no-store, no-cache, must-revalidate, pre-check=0, post-check=0, max-age=0');
header('Pragma: public');
while (!feof($handle)) {
    echo fgets($handle, 8192);
} // while
fclose($handle);

unset($_SESSION['pages'][getSelf()]);
exit;
?>
