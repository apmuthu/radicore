<?php
// *****************************************************************************
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.filedownload2.inc

// type = filedownload2

// This will read a record which was selected on the previous page, then
// download (using FTP) a remote file specified on that record.

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

$remote_file = $dbobject->download_filename;
$mode = strtolower($dbobject->download_mode);

// check that temp folder exists for ftp download
$temp_folder = $dbobject->temp_folder;
if (empty($temp_folder)) {
    scriptPrevious(getLanguageText('sys0213')); // 'Temporary folder has not been defined.'
} // if
if (!is_dir($temp_folder)) {
    scriptPrevious(getLanguageText('sys0077', $temp_folder)); // 'Directory 'X' does not exist.'
} // if

// connect to FTP server
$ftp_server    = $dbobject->ftp_server;
$ftp_user_name = $dbobject->ftp_user_name;
$ftp_user_pass = $dbobject->ftp_user_pass;
$conn_id = ftp_connect($ftp_server);
$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);
ftp_pasv($conn_id, true);
// check connection
if ((!$conn_id) OR (!$login_result)) {
    $errors[] = "Cannot connect to '$ftp_server' for user '$ftp_user_name'";
    scriptPrevious($errors);
} // if

$local_file = $temp_folder.'/'.basename($remote_file);
$result = ftp_get($conn_id, $local_file, $remote_file, FTP_BINARY);

// determine the mime-type for the specified file
$content_type = getContentType($local_file);

header("Content-type: " . $content_type);
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
if (isset($mode) and $mode == 'inline') {
    header("Content-Disposition: filename=\"" .basename($local_file) ."\"");
} else {
    header("Content-Disposition: attachment; filename=\"" .basename($local_file) ."\"");
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
