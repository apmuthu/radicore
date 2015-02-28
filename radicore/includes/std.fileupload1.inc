<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.fileupload1.inc

// type = fileupload1

// This will list files in a directory and allow the user to choose one

require_once 'include.general.inc';

// identify mode for XSL file
$mode = 'read';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

// load session variables
if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    scriptPrevious();
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['quit'] 	   = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['fileobject'])) {
    // use data from previous instance for this script
    $fileobject = unserialize($script_vars['fileobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $fileobject->restart($return_from, $return_action);
    } // if
} else {
    $fileobject = new $table_id;
    // indicate that this object was started from a page controller
    $fileobject->initiated_from_controller = true;
    // perform any initialisation
    $where = $fileobject->initialise($where, $selection);
    $where = $fileobject->initialiseFileUpload($where);
    if ($fileobject->errors) {
    	scriptPrevious($fileobject->getErrors());
    } // if
    unset($script_vars['files']);
} // if

$filename    = '';
$subdir      = $fileobject->upload_subdir;
$filetypes   = $fileobject->upload_filetypes;
$maxfilesize = $fileobject->upload_maxfilesize;
$blacklist   = $fileobject->upload_blacklist;

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
    $messages = array();
    // Check to see if a file has been included when the form was submitted
    if (strlen($_FILES['userfile']['name']) < 1 ) {
        $errors[] = getLanguageText('sys0131'); // 'filename is empty - nothing to upload';
    } else {
        $filename = $_FILES['userfile']['name'];
    } // if
    // check to see if file is of correct size
    if ($_FILES['userfile']['size'] > $maxfilesize) {
    	// The uploaded file exceeds $maxfilesize bytes
		$errors[] = getLanguageText('sys0129', $maxfilesize);
    } // if
    // Check to see if a file is the correct type
    if ($filetypes == '*') {
    	// any type is valid
    } elseif (is_array($filetypes)) {
        if (preg_match('/(\.[0-9a-z]+)$/i', $_FILES['userfile']['name'], $regs)) {
            $extension = substr($regs[0], 1);
            if (!in_array($extension, $filetypes)) {
                $errors[] = getLanguageText('sys0125'); // 'File is not of correct type';
            } // if
        } // if
    } elseif ($filetypes == 'image') {
        if (!preg_match('/^image/i', $_FILES['userfile']['type'])) {
        	$errors[] = getLanguageText('sys0125'); // 'File is not of correct type';
        } else {
            $imageinfo = getimagesize($_FILES['userfile']['tmp_name']);
            if (!preg_match('/^image/i', $imageinfo['mime'])) {
            	$errors[] = getLanguageText('sys0125'); // 'File is not of correct type';
            } // if
        } // if
    } // if
    // check that the file does not have an invalid extension
    //$blacklist = array("\.php.*", "\..*htm.*");
    if (is_array($blacklist)) {
        foreach ($blacklist as $item) {
            if (preg_match("/$item\$/i", $_FILES['userfile']['name'], $regs)) {
                // "The uploading of 'x' files is not allowed"
                $errors[] = getLanguageText('sys0136', $regs[0]);
            } // if
        } // if
    } // if
    //  Check to see if the directory specified in the store_dir input field is a valid directory
    if (!is_dir($subdir) ) {
       @unlink($_FILES['userfile']['tmp_name']);
       $errors[] = getLanguageText('sys0123', $subdir); // 'destination directory does not exist';
    } // if
    if (empty($errors)) {
        $uploadfile = $fileobject->fileUpload(basename($_FILES['userfile']['name']), $_FILES['userfile']['tmp_name']);
        $errors = $fileobject->getErrors();
    } // if
    if (empty($errors)) {
        if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
            $messages[] = getLanguageText('sys0126', $uploadfile); // "File uploaded into $uploadfile";
            if (!preg_match('/^WIN/i', PHP_OS)) {
            	$result = chmod($uploadfile, 0664);
            } // if
            if (!empty($fileobject->resize_array)) {
                foreach ($fileobject->resize_array as $key => $spec) {
                    if (isset($spec['directory']) AND isset($spec['width']) AND isset($spec['height'])) {
                        $destination = $spec['directory'];
                        $width       = $spec['width'];
                        $height      = $spec['height'];
                        $messages[]  = resizeImage($uploadfile, $destination, $width, $height);
                    } // if
                } // foreach
            } // if
            // allow uploaded file to be processed
            $result = $fileobject->post_fileUpload($uploadfile, $_FILES['userfile']['size']);
            if (!empty($result)) {
            	$uploadfile = $result;
            } // if
            $errors = $fileobject->getErrors();
            if (!empty($fileobject->messages)) {
                $messages = array_merge($messages, $fileobject->messages);
            } // if
            if (empty($errors)) {
                $info = new SplFileInfo($uploadfile);
                $file_array['url']           = realpath($uploadfile);
                $file_array['filename_orig'] = $info->getBasename();
                $file_array['filename']      = $info->getBasename('.'.$info->getExtension());
                $file_array['extension']     = $info->getExtension();
                $file_array['size']          = $_FILES['userfile']['size'];
                $script_vars['files'][] = $file_array;
                if (isset($_POST['submitstay'])) {
                    // redisplay current screen
                } else {
                	// send selection back to the previous script
                    $prev_script = getPreviousScript();
                    $prev_task   = getPreviousTask($prev_script);
                    if (!empty($script_vars['files'])) {
                        $_SESSION['pages'][$prev_script][$prev_task]['files'] = $script_vars['files'];
                    } // if
                    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $uploadfile;
                    $errors = scriptPrevious($errors, $messages, 'choose');
                } // if
            } else {
                @unlink($uploadfile);
            } // if
        } else {
        	$errors[] = getLanguageText('sys0127'); // "Failed to copy file into specified folder";
        } // if
    } // if
} // if

// copy data into a dummy object
$fieldarray['filename']    = $filename;
$fieldarray['maxfilesize'] = $maxfilesize;
$fieldarray['msg1']        = getLanguageText('sys0120');
if ($maxfilesize >= 1000000) {
	$fieldarray['msg2']    = getLanguageText('sys0121', $maxfilesize/1000000 .'M');  // megabytes
} elseif ($maxfilesize >= 1000) {
	$fieldarray['msg2']    = getLanguageText('sys0121', $maxfilesize/1000 .'K');     // kilobytes
} else {
    $fieldarray['msg2']    = getLanguageText('sys0121', $maxfilesize);               // bytes
} // if
if ($filetypes != '*') {
	if (is_array($filetypes)) {
    	$fieldarray['msg3']    = getLanguageText('sys0122', implode(',', $filetypes));   // array of values
    } else {
        $fieldarray['msg3']    = getLanguageText('sys0122', $filetypes);                 // single value
    } // if
} // if
$fileobject->setFieldArray($fieldarray);

if (!is_True($fileobject->allow_multiple)) {
    unset($act_buttons['submitstay']);  // remove this button
} // if

// save these variables for later in the same session
$script_vars['where']      = $where;
$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

$fileobject->fieldarray = $fieldarray;  // replace data lost during serialization

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
