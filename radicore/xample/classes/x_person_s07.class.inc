<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2013 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s07 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person(filepicker)video.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $fieldarray = parent::_cm_changeConfig($where, $fieldarray);

        //$this->fieldspec['file'] = $this->fieldspec['video_id'];
        //unset($this->fieldspec['file']['task_id']);
        //unset($this->fieldspec['file']['imagewidth']);
        //unset($this->fieldspec['file']['imageheight']);

        //$this->fieldspec['video'] = $this->fieldspec['picture'];
        //$this->fieldspec['video']['subtype'] = 'video';

        //$this->fieldspec['file'] = $this->fieldspec['picture'];
        //$this->fieldspec['file']['subtype'] = 'video';

        return $fieldarray;

    } // _cm_changeConfig
    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // customisable code goes here

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_initialiseFilePicker ($fieldarray, $search)
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        $this->picker_subdir      = 'videos';

        // identify the file types that may be picked
        //$this->picker_filetypes   = array('bmp', 'jpg', 'png', 'gif');

        return $fieldarray;

    } // _cm_initialiseFilePicker

// ****************************************************************************
} // end class
// ****************************************************************************

?>
