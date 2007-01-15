<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.fileupload1.inc

// type = fileupload1

// This will list files in a directory and allow the user to choose one

require_once 'include.general.inc';

// identify mode for XSL file
$mode = 'read';

// load session variables
initSession();

// load session variables
if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    scriptPrevious(getLanguageText('sys0087')); // 'Nothing selected from fileupload screen.'
} // if

// define action buttons
$act_buttons['submit']  = 'submit';
$act_buttons['quit'] 	= 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['fileobject'])) {
    // use data from previous instance for this script
    $fileobject = unserialize($script_vars['fileobject']);
} else {
    $fileobject = new $table_id;
    // perform any initialisation
    if (!empty($selection)) {
        $selection = $fileobject->initialiseFileUpload($selection);
    } else {
        $where = $fileobject->initialiseFileUpload($where);
    } // if
    if ($fileobject->errors) {
    	scriptPrevious($fileobject->errors);
    } // if
} // if

$filename    = '';
$subdir      = $fileobject->upload_subdir;
$filetypes   = $fileobject->upload_filetypes;
$maxfilesize = $fileobject->upload_maxfilesize;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_FILES['userfile']['error'])) {
	    $result = $_FILES['userfile']['error'];
    } else {
        // this error causes $_POST and $_FILES to be empty
        $result = UPLOAD_ERR_INI_SIZE;
    } // if
	switch ($result) {
	    case 0:
	        break; // no error

		case UPLOAD_ERR_INI_SIZE:
		    // The uploaded file exceeds the upload_max_filesize directive in php.ini
			$errors[] = getLanguageText('sys0128');
			break;

		case UPLOAD_ERR_FORM_SIZE:
		    // The uploaded file exceeds $maxfilesize bytes
			$errors[] = getLanguageText('sys0129', $maxfilesize);
			break;

		case UPLOAD_ERR_PARTIAL:
			// The uploaded file was only partially uploaded
			$errors[] = getLanguageText('sys0130');
			break;

		case UPLOAD_ERR_NO_FILE:
            // No file was uploaded
            $errors[] = getLanguageText('sys0131');
			break;

		case UPLOAD_ERR_NO_TMP_DIR:
            // Temporary folder is missing
            $errors[] = getLanguageText('sys0132');
			break;

		case UPLOAD_ERR_CANT_WRITE:
            // Failed to write file to disk
            $errors[] = getLanguageText('sys0133');
			break;

		default:
			break;
	} // switch
} // if

if (!empty($_FILES) and empty($errors)) {
    //  Check to see if a file has been included when the form was submitted
    if (strlen($_FILES['userfile']['name']) < 1 ) {
        $errors[] = getLanguageText('sys0131'); // 'filename is empty - nothing to upload';
    } else {
        $filename = $_FILES['userfile']['name'];
    } // if
    //  Check to see if a file is the correct type
    if (!in_array($_FILES['userfile']['type'], $filetypes)) {
        $errors[] = getLanguageText('sys0125'); // 'File is not of correct type';
    } // if
    //  Check to see if the directory specified in the store_dir input field is a valid directory
    if (!is_dir($subdir) ) {
       @unlink($_FILES['userfile']['tmp_name']);
       $errors[] = getLanguageText('sys0123', $subdir); // 'destination directory does not exist';
    } // if
    if (empty($errors)) {
        $uploadfile = $fileobject->fileUpload(basename($_FILES['userfile']['name']), $_FILES['userfile']['tmp_name']);
        $errors = $fileobject->errors;
    } // if
    if (empty($errors)) {
        if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
            $messages[] = getLanguageText('sys0126', $uploadfile); // "File uploaded into $uploadfile";
        	// send selection back to the previous script
            $prev_script = getPreviousScript();
            $prev_task   = getPreviousTask($prev_script);
            $_SESSION[$prev_script][$prev_task]['selection'] = "$uploadfile";
            scriptPrevious(null, $messages, 'choose');
        } else {
        	$errors[] = getLanguageText('sys0127'); // "Failed to copy file into specified folder";
        } // if
    } // if
} // if

// copy data into a dummy object
$fieldarray['filename']    = $filename;
$fieldarray['maxfilesize'] = $maxfilesize;
$fieldarray['msg1']        = getLanguageText('sys0120');
$fieldarray['msg2']        = getLanguageText('sys0121', $maxfilesize);
$fieldarray['msg3']        = getLanguageText('sys0122', $filetype);
$fileobject->setFieldArray($fieldarray);

// save these variables for later in the same session
$script_vars['where']      = $where;
$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>