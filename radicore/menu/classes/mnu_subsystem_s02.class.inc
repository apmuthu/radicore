<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_subsystem.class.inc';
class mnu_subsystem_s02 extends mnu_subsystem
{
    // member variables
    var $text_out;          // to be written to a text file

    // ****************************************************************************
    // This subclass is used by: mnu_subsystem_build.php
    // Purpose: to build the subsystem's directory structure
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // obtain identity of target directory
        $dir_to = '../' .strtolower($rowdata[0]['subsys_dir']);

        if ($dh = @opendir($dir_to)) {
            // 'Directory already exists'
        	$this->errors[] = getLanguageText('e0050', $dir_to);
        	return array();
        } // if

        // get list of files to be excluded from copy process
        $filename = '../default/exclude-from-build.txt';
        if ($handle = fopen($filename, "r")) {
        	$contents = fread($handle, filesize($filename));
            fclose($handle);
            $exclude_array = preg_split("/[\s,]+/", $contents);
        } else {
            $exclude_array = array();
        } // if

        // copy all files (and subdirectories) from DEFAULT directory
        $this->_copyDirectory('../default', $dir_to, $exclude_array);

        // create a menu task for this subsystem
        $dbobject =& RDCsingleton::getInstance('mnu_task');
        $task_array['task_id']     = $rowdata[0]['subsys_id'];
        $task_array['task_desc']   = 'Main menu for ' .$rowdata[0]['subsys_id'] .' subsystem';
        $task_array['button_text'] = $rowdata[0]['subsys_id'];
        $task_array['task_type']   = 'MENU';
        $task_array['subsys_id']   = $rowdata[0]['subsys_id'];
        $task_array = $dbobject->insertRecord($task_array);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->getErrors());
        } // if

        // add this menu task to the main menu
        $dbobject =& RDCsingleton::getInstance('mnu_menu');
        $menu_array['menu_id']     = 'main_menu';
        $menu_array['task_id_jnr'] = $rowdata[0]['subsys_id'];
        $menu_array['button_text'] = $rowdata[0]['subsys_id'];
        $menu_array = $dbobject->insertRecord($menu_array);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->getErrors());
        } // if

        if (empty($his->errors)) {
            // 'Directory has been created'
        	$this->messages[] = getLanguageText('e0051', $dir_to);
        } // if

		// return an empty array as there is no database update
        return array();

    } // _cm_post_getData

    // ****************************************************************************
    function _copyDirectory ($dir_from, $dir_to, $exclude_array)
    // copy contents of $dir_from to $dir_to
    {
        // open $dir_from (source directory)
        if (!$handle = opendir($dir_from)) {
            // "Cannot open directory $dir_from";
        	$this->errors[] = getLanguageText('e0052', $dir_to);
        	return FALSE;
        } // if

        if (!mkdir($dir_to)) {
            // "Cannot create directory $dir_to"
    		$this->errors[] = getLanguageText('e0053', $dir_to);
    		return FALSE;
    	} // if

        while (false !== ($file = readdir($handle))) {
            if ($file != "." && $file != "..") {
                if (is_dir("$dir_from/$file")) {
                	// copy contents of sub-directory
                	if (!$this->_copyDirectory("$dir_from/$file", "$dir_to/$file", $exclude_array)) {
                		return FALSE;
                	} // if
                } else {
                    if (!in_array($file, $exclude_array)) {
                    	// copy file
                        if (!copy("$dir_from/$file", "$dir_to/$file")) {
                            // "Cannot create file $dir_from/$file";
                        	$this->errors[] = getLanguageText('e0054', "$dir_to/$file");
                        	return FALSE;
                        } // if
                    } // if
                } // if
            } // if
        } // while

        closedir($handle);

        return TRUE;

    } // _copyDirectory

// ****************************************************************************
} // end class
// ****************************************************************************

?>
