<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s01 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_filedownload.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_initialiseFileDownload ($fieldarray)
    // perform any initialisation for the file download operation.
    {
        if (empty($fieldarray['picture'])) {
            // "There is no file available for download"
            $this->errors['picture'] = getLanguageText('sys0254');
        } else {
            $this->download_filename = $fieldarray['picture'];
        } // if

        return;

    } // _cm_initialiseFileDownload

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive

        // update download details
        $rowdata['report_download'] = getTimeStamp();
        $rowdata['download_count']  = $rowdata['download_count'] +1;

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
