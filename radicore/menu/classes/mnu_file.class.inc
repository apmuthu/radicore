<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_file extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_file ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
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
        $this->picker_subdir = '../logs';

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
    function _cm_initialiseFilePicker ($fieldarray)
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
} // end class
// ****************************************************************************

?>
