<?php
// ******************************************************************************
// Copyright 1999-2015 by Geoprise Technologies Corporation, All Rights Reserved.
// ******************************************************************************

// name = std.fileupload2.inc

// type = fileupload2

// This will allow the user to choose a single or multiple files for uploading.

require_once 'include.general.inc';

require_once 'ImageUploaderPHP/Uploader.class.php';

$mode = 'read';  // identify mode for XSL file

initSession();  // load session variables

if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // remove any partially uploaded file or directory
    if (isset($script_vars['upload_directory'])) {
        $res = remove_directory($script_vars['upload_directory']);
    } elseif (isset($script_vars['upload_file'])) {
        $res = unlink($script_vars['upload_file']);
    } // if
    // clear this script from session details and return to previous page
    scriptPrevious();
} // if

if (isset($_REQUEST['UploadComplete'])) {
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    if (!empty($script_vars['files'])) {
        $_SESSION['pages'][$prev_script][$prev_task]['files'] = $script_vars['files'];
    } // if
    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = '-selection-';
    $errors = null;
    $messages = null;
    $errors = scriptPrevious($errors, $messages, 'uploaded');
} // if

// define action buttons
// $act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['quit'] 	   = 'cancel';

//create a class instance for the main database table
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

//$subdir  = $fileobject->upload_subdir;
$subdir  = $fileobject->getUploadSubdir();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    require_once 'gallery_helper.php';
    require_once 'ImageUploaderPHP/UploadHandler.class.php';

    $handler = new UploadHandler();
    $handler->setFileUploadedCallback('onFileUploaded');
    $handler->setAllFilesUploadedCallback("saveAllUploadedFiles");
    $handler->processRequest();

} // if

if (isset($_POST['RequestComplete'])) {
    $script_vars = updateScriptVars ($script_vars);
    exit;  // ajax request completed
} // if

// copy data into a dummy object
//$fieldarray['foldercontrol'] = 'ACTIVEX UPLOADER CONTROL';
$fileobject->primary_key[] = 'foldercontrol';
if (isset($fileobject->fieldspec['foldercontrol']['javascript'])) {
    $fieldarray['foldercontrol'] = $fileobject->fieldspec['foldercontrol']['javascript'];
    unset($fileobject->fieldspec['foldercontrol']['javascript']);
    $fileobject->setFieldArray($fieldarray);
} else {
    $fieldarray = $fileobject->getFieldarray();
} // if
$fileobject->fieldspec['foldercontrol']['xml'] = 'CDATA';  // turn on output escaping

// save these variables for later in the same session
$script_vars['where']      = $where;
$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

$fileobject->fieldarray = $fieldarray;  // replace data lost during serialization

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

// ****************************************************************************
function moveFileAndFolder($sourceDir, $destinationDir)
{
$result ='';
//
$dir = opendir($destinationDir);
   @mkdir($dst);
   while(false !== ( $file = readdir($dir)) ) {
       if (( $file != '.' ) && ( $file != '..' )) {
           if ( is_dir($src . '/' . $file) ) {
               $copy_done = recurse_copy($src . '/' . $file,$dst . '/' . $file);
           }
           else {
               $copy_done = copy($src . '/' . $file,$dst . '/' . $file);
           }
       }
   }
   closedir($dir);

   return $copy_done;

} // moveFileAndFolder

// ******************************************************************************
function onFileUploaded($uploadedFile)
{

} // onFileUploaded

// ******************************************************************************
function saveAllUploadedFiles($uploadedFiles)
{

    global $subdir;
    global $script_vars;

    $absGalleryPath = realpath($subdir) . DIRECTORY_SEPARATOR;
    $absThumbnailsPath = $absGalleryPath . 'Thumbnails' . DIRECTORY_SEPARATOR;

    $first_root_dir = '';
    $first_filename = '';
    $first_main_filename = '';

    foreach ($uploadedFiles as $uploadedFile)
    {
        // loop through uploaded files to determine if folder or file upload
        // and determine the first root folder or file

        $originalFileName = $uploadedFile->getSourceName();
        //$originalFilePath = str_replace('\\', '/', $uploadedFile->getRelativePath());
        $originalFilePath = str_replace('\\', DIRECTORY_SEPARATOR, $uploadedFile->getRelativePath());

        // set the name and path of the main file if description exists
        $originalDescription = $uploadedFile->getDescription();
        $mainFileURL = '';
        if (strlen($originalDescription) > 0) {
            $mainFileURL = $originalFilePath .DIRECTORY_SEPARATOR .$originalFileName;
        } // if

        if (strlen($originalFilePath) > 0) {
            // this file belongs to a folder
            $path = explode(DIRECTORY_SEPARATOR, $originalFilePath);
            if (strlen($first_root_dir) < 1 ) {
                // identify the first root directory found
                $first_root_dir = $path[0];
            } // if
            if (strlen($originalDescription) > 0 ) {
                if (strlen($first_main_filename) < 1) {
                    // identify the first main file found
                    $first_main_filename = $mainFileURL;
                    if ($path[0] != $first_root_dir) {
                        // make its root directory the first root directory
                        // if the root directory of the first main file differs from the first root directory found
                        $first_root_dir = $path[0];
                    } // if

                } // if
            } // if
        } else {
            // this file does not belong to a folder
            if (strlen($first_filename) < 1 ) {
                $first_filename = $originalFileName;
            } // if
        } // if
    } // foreach

    $packageFields = $uploadedFiles[0]->getPackage()->getPackageFields();
    $userdir = $packageFields["userdir"];
    $absXmlFilePath = $absGalleryPath. $userdir .DIRECTORY_SEPARATOR;
    //$userdir = '';

//    $xml_doc = new DOMDocument('1.0', 'utf-8');
//    $root = $xml_doc->createElement('root');  // add root node
//    $xml_root = $xml_doc->appendChild($root);
    //$absXmlFilePath = $absXmlFilePath;

    foreach ($uploadedFiles as $uploadedFile)
    {
        //$myfile = fopen("..\Info.txt", "w") or die("Unable to open file!");
        //fwrite($myfile, 'Start.....');
        //fwrite($myfile, $absGalleryPath);
        //fwrite($myfile, 'End.....');
        //fclose($myfile);

        // initialize gallery
        if ($uploadedFile->getPackage()->getPackageIndex() == 0 && $uploadedFile->getIndex() == 0) {
            list($xml_doc, $xml_root) = initGallery($absGalleryPath, $absThumbnailsPath, $absXmlFilePath);
        }

        // loop through uploaded files again to save them

        $originalFileName = $uploadedFile->getSourceName();
        $originalFilePath = str_replace('\\', DIRECTORY_SEPARATOR, $uploadedFile->getRelativePath());
        $originalURL = $originalFilePath .DIRECTORY_SEPARATOR .$originalFileName;

        if (strlen($first_root_dir) > 0) {
            // if at least one folder was uploaded then ...
            // the folder upload takes precedence over any file upload

            $path = explode(DIRECTORY_SEPARATOR, $originalFilePath);

            if (isset($path[0]) && strlen($path[0]) > 0 && $path[0] == $first_root_dir) {
                // save the file only if its root directory is the same as the first root directory found

                $convertedFilePath = str_replace('\\', DIRECTORY_SEPARATOR, setGUID($originalFilePath));

                //if (empty($userdir)) {
                //    $userdir = $convertedFilePath;
                //    $absXmlFilePath = $absGalleryPath. $userdir;
                //} // if

                $path = explode(DIRECTORY_SEPARATOR, $convertedFilePath);
				$converted_root_folder = $path[0];
                $dirName = '';
                for ($j = 0; $j < count($path); $j++) {
                    // $dirName .= preg_replace('/[^a-z0-9_\-\.()\[\]{}]/iu', '_', $path[$j]) . '/';
                    $dirName = $dirName . $path[$j] . DIRECTORY_SEPARATOR;
                    //$dirName = $dirName .$path[$j];
                    if (!is_dir($absGalleryPath . $dirName)) {
                        $res = mkdir($absGalleryPath . $dirName, 0777);
                    } // if
                } // for

                $path = rtrim($dirName, "/\\") . DIRECTORY_SEPARATOR;

                $files = $uploadedFile->getConvertedFiles();

                //save source file
                $sourceFile = $files[0];
                /* @var $sourceFile ConvertedFile */
                // $sourceFileName = '';
                if ($sourceFile) {
                    // $sourceFileName = getSafeFileName($absGalleryPath . $path, $originalFileName);
                    $sourceFile->moveTo($absGalleryPath . $path . $originalFileName);

                    // save file details so that they can be passed back to the calling script
                    $uploadfile = $absGalleryPath . $path . $originalFileName;

					if (!isset($first_main_filename) || strlen($first_main_filename) < 1) {
						$info = new SplFileInfo($uploadfile);
						$file_array['url']           = $absGalleryPath.$converted_root_folder.DIRECTORY_SEPARATOR;
						$file_array['filename_orig'] = $first_root_dir;
						$file_array['filename']      = '';
						$file_array['extension']     = '';
						$file_array['size']          = '';
						$script_vars['files'][]      = $file_array;
					} elseif ($originalURL == $first_main_filename) {
						$info = new SplFileInfo($uploadfile);
						$file_array['url']           = $uploadfile;
						$file_array['filename_orig'] = $info->getBasename();
						$file_array['filename']      = $info->getBasename('.'.$info->getExtension());
						$file_array['extension']     = $info->getExtension();
						$file_array['size']          = $info->getSize();
						$script_vars['files'][]      = $file_array;
					} // if
                } // if

                //Save file info.
                $filename = '';
                $extension = '';
                $pos = strrpos($originalFileName,'.');
                if ($pos !== false) {
                    if ($pos > 0) {
                        $filename = substr($originalFileName, 0, $pos);
                        $extension = substr($originalFileName, $pos + 1);
                    } else {
                        $extension = $originalFileName;
                    } // if
                } else {
                    $filename = $originalFileName;
                } // if
                //$descriptions = new DOMDocument('1.0', 'utf-8');
                //$descriptions->load($absXmlFilePath . 'files.xml');
                $xmlFile = $xml_doc->createElement('file');
                $originalFilePath = empty($originalFilePath) ? $originalFilePath : $originalFilePath . '/';
                if (strlen($first_main_filename) > 0) {
                    if ($originalURL == $first_main_filename) {
                        $xmlFile->setAttribute('main', 'true');
                    } else {
                        $xmlFile->setAttribute('main', 'false');
                    } // if
                } else {
                    $xmlFile->setAttribute('main', 'false');
                } // if
                if (strlen($extension) > 0) {
                    $xmlFile->setAttribute('extension', $extension);
                } // if
                if (strlen($filename) > 0) {
                    $xmlFile->setAttribute('name', $filename);
                } // if
                $xmlFile->setAttribute('source', $path . $originalFileName);
                //$descriptions->documentElement->appendChild($xmlFile);
                $xml_root->appendChild($xmlFile);
                //$res = $descriptions->save($absXmlFilePath . 'files.xml');

                $script_vars['upload_directory'] = $subdir .$converted_root_folder;
            } // if

        } else {

            if (strlen($uploadedFile->getRelativePath()) < 1) {

                if ($originalFileName == $first_filename) {
                    // save the file only if its name is the same as the first file found

                    $filename = '';
                    $extension = '';
                    $pos = strrpos($originalFileName,'.');
                    if ($pos !== false) {
                        if ($pos > 0) {
                            $filename = substr($originalFileName, 0, $pos);
                            $extension = substr($originalFileName, $pos + 1);
                        } else {
                            $extension = $originalFileName;
                        } // if
                    } else {
                        $filename = $originalFileName;
                    } // if

                    $files = $uploadedFile->getConvertedFiles();

                    //save source file
                    $sourceFile = $files[0];
                    /* @var $sourceFile ConvertedFile */
                    if ($sourceFile) {
                        // $sourceFileName = getSafeFileName($absGalleryPath, generateGUID($originalFileName));
                        $sourceFileName = generateGUID($filename) . '.' . $extension;
                        $sourceFile->moveTo($absGalleryPath . $sourceFileName);

                        // save file details so that they can be passed back to the calling script
                        $uploadfile = $absGalleryPath . $sourceFileName;
                        $info = new SplFileInfo($uploadfile);
                        $file_array['url']           = $uploadfile;
                        $file_array['filename_orig'] = $originalFileName;
                        $file_array['filename']      = $filename;
                        $file_array['extension']     = $info->getExtension();
                        $file_array['size']          = $info->getSize();
                        $script_vars['files'][]      = $file_array;

                    } // if

                    //Save file info.
                    //$descriptions = new DOMDocument('1.0', 'utf-8');
                    //$descriptions->load($absXmlFilePath . 'files.xml');
                    $xmlFile = $xml_doc->createElement('file');
                    $originalFilePath = empty($originalFilePath) ? $originalFilePath : $originalFilePath . '/';
                    $xmlFile->setAttribute('main', 'true');
                    if (strlen($extension) > 0) {
                        $xmlFile->setAttribute('extension', $extension);
                    } // if
                    if (strlen($filename) > 0) {
                        $xmlFile->setAttribute('name', $filename);
                    } // if
                    $xmlFile->setAttribute('source', $absGalleryPath . $sourceFileName);
                    $xml_root->appendChild($xmlFile);
                    //$res = $descriptions->save($absXmlFilePath . 'files.xml');

                    $script_vars['upload_file'] = $subdir .$sourceFileName;
                } // if

            } // if

        } // if
    } // foreach

    $res = $xml_doc->save($absXmlFilePath . 'files.xml');

} // saveAllUploadedFiles

// ******************************************************************************
function setGUID ($relative_path)
{
    global $rootGUID;
    $output_path = $relative_path;
    if (strlen($output_path) > 0) {
        //$relative_path_arr = explode('/', $relative_path);
        $relative_path_arr = explode(DIRECTORY_SEPARATOR, $relative_path);
        if (!$rootGUID || empty($rootGUID) || strlen($rootGUID) < 1) {
            $rootGUID = generateGUID($rootGUID);
        } // if
        $relative_path_arr[0] = $rootGUID;
        $output_path = '';
        for ($j = 0; $j < count($relative_path_arr); $j++) {
            //$output_path = $output_path . $relative_path_arr[$j] . '/';
            $output_path = $output_path . $relative_path_arr[$j] . DIRECTORY_SEPARATOR;
        } // for
    } // if
    return $output_path;
} // setGUID

// ******************************************************************************
function generateGUID ($input_name)
{
    $output_name = $input_name;
    if (function_exists('com_create_guid')){
        $output_name = trim(com_create_guid(), '{}');
    } else {
        mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $hyphen = chr(45);// "-"
        $output_name = substr($charid, 0, 8).$hyphen
                     .substr($charid, 8, 4).$hyphen
                     .substr($charid,12, 4).$hyphen
                     .substr($charid,16, 4).$hyphen
                     .substr($charid,20,12);
    } // if
    return $output_name;
} // generateGUID

// ******************************************************************************
?>
