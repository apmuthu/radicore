<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_file extends Default_Table
{
    var $picker_subdir = 'unknown directory';
    var $picker_filetypes = array();

    var $upload_subdir = 'unknown directory';
    var $upload_filetypes = array();
    var $upload_blacklist = array();
    var $upload_maxfilesize = 1000000;
    var $return_uploaded_file = true;

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_file ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'mnu_file';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_file

    // ****************************************************************************
    function _cm_filePickerSelect ($selection)
    // Deal with selection from a filepicker screen.
    {
        // process selection with the DOWNLOAD task after this task terminates
        //$next['task_id'] = 'batch_log(filedownload)';
        //$next['where']   = "file_id='$selection'";
        //append2ScriptSequence($next);

        // process selection without terminating this task
        scriptNext('batch_log(filedownload)', "file_id='$selection'");

        return $selection;

    } // _cm_filePickerSelect

    // ****************************************************************************
    function _cm_getPkeyNames ($pkey_array, $task_id, $pattern_id)
    // return the list of primary key fields in this table before the selection string
    // is constructed and passed to another form.
    // $pkey_array contains the current list of primary key fields.
    // $task_id identifies the task to which the primary key(s) will be passed.
    // $pattern_id identifies the task's pattern.
    {
        $pkey_array = array('file');  // replace array

        return $pkey_array;

    } // _cm_getPkeyNames

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        // do not try to read any data as this table does not exist
        $this->skip_getdata = true;

        // identify the subdirectory which contains the files
        $where_array = where2array($where);
        if (isset($where_array['folder'])) {
            $this->picker_subdir = rtrim($where_array['folder'], '/');
        } else {
            $this->picker_subdir = '../logs';
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_initialiseFileDownload ($fieldarray)
    // perform any initialisation for the file download operation.
    {
        $this->download_filename = $fieldarray['file_id'];
        //$this->download_mode     = 'inline';  // disable option to save

        return;

    } // _cm_initialiseFileDownload

    // ****************************************************************************
    function _cm_initialiseFilePicker ($fieldarray, $search)
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        if (empty($this->picker_subdir)) {
            $this->picker_subdir      = '../logs';
        } // if

        // identify the file types that may be picked
        $this->picker_filetypes   = array('txt', 'html', 'htm', 'log', 'err', 'csv', 'pdf');
        $this->picker_filetypes   = array();  // default is ANY file extension

        // by default hyperlinks are opened directly in the browser
        $this->xsl_params['hyperlink_direct'] = 'y';

        // by default if a file is uoloaded it will be returned as if it was selected
        $this->return_uploaded_file = true;

        if (!empty($GLOBALS['settings']['download'])) {
        	if (is_True($GLOBALS['settings']['download'])) {
        	    // redirect hyperlinks to the download task
        		unset($this->xsl_params['hyperlink_direct']);
        	} // if
        } // if

        return $fieldarray;

    } // _cm_initialiseFilePicker

    // ****************************************************************************
    function _cm_pre_deleteRecord ($rowdata)
    // perform custom processing before database record is deleted.
    // if anything is placed in $this->errors the deletion will be terminated.
    {
        // this entry exists in the file system, not the database
        $filename = $this->picker_subdir .'/' .$rowdata['file'];

        $result = unlink($filename);

        return $rowdata;

    } // _cm_pre_deleteRecord

    // ****************************************************************************
    function _cm_restart ($pattern_id, $zone, $return_from, $return_action, $return_string, $return_files)
    // script is being restarted after running a child form, so check for further action.
    {
        if ($return_action == 'choose') {
            // can we return this file to the previous task?
            $prev_task = getPreviousTask();
            if ($prev_task == 'menu') {
                $this->return_uploaded_file = false;    // no
            } else {
                $this->return_uploaded_file = true;     // yes
            } // if
        } // if

        return;

    } // _cm_restart

// ****************************************************************************
} // end class
// ****************************************************************************

?>
