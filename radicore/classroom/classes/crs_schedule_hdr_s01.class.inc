<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'crs_schedule_hdr.class.inc';
class crs_schedule_hdr_s01 extends crs_schedule_hdr
{
    // ****************************************************************************
    // this version is for schedule_hdr_choose.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (isset($_SESSION['crs_schedule_id'])) {
            // id has been previously chosen, so show it on the screen
        	$schedule_id = $_SESSION['crs_schedule_id'];
        	$this->instruction['select']['schedule_id'] = $schedule_id;
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple rows in a single operation.
    {
        // this is the default code, which may be replaced if necessary
        //$count = $this->_dml_updateSelection($selection, $replace);

        // '$count records were updated in $tablename'
        //return getLanguageText('sys0006', $count, strtoupper($this->tablename));

        $array = where2array($selection);

        if (array_key_exists('schedule_id', $array)) {
        	$_SESSION['crs_schedule_id'] = $array['schedule_id'];
        } else {
            unset($_SESSION['crs_schedule_id']);
        } // if

        return;

    } // _cm_updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
