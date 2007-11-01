<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_schedule_hdr extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_schedule_hdr ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_schedule_hdr';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_schedule_hdr

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set schedule_id to next available number
        $count = $this->getCount("SELECT max(schedule_id) FROM $this->tablename");
        $fieldarray['schedule_id'] = $count + 1;

        $this->fieldspec['schedule_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $start_time = $fieldarray['start_time'];
        $end_time   = $fieldarray['end_time'];

        if ($start_time > $end_time) {
            $this->errors['start_time'] = getLanguageText('e0001'); // 'Start Time cannot be later than End Time';
            $this->errors['end_time']   = getLanguageText('e0002'); // 'End Time cannot be earlier than Start Time';
        } else {
            $pattern = '/(00|15|30|45)/';
            $start_minutes = substr($start_time, 3, 2);
            if (!preg_match($pattern, $start_minutes)) {
                $this->errors['start_time'] = getLanguageText('e0003'); // 'Start Time must be 00,15,30 or 45 minutes';
            } // if
            $end_minutes = substr($end_time, 3, 2);
            if (!preg_match($pattern, $end_minutes)) {
                $this->errors['end_time'] = getLanguageText('e0004'); // 'End Time must be 00,15,30 or 45 minutes';
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('day_no', $this->lookup_data)) {
            // get day number and add to lookup array
            $object =& singleton::getInstance('crs_schedule');
            $data = $object->getValRep('day_no');
            $this->lookup_data['day_no'] = $data;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        if (is_true($fieldarray['is_active'])) {
            // if this occurrence is active make all others inactive
            $this->updateSelection ("schedule_id !='{$fieldarray['schedule_id']}'", "is_active='N'");
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        //DebugBreak();
        if (is_true($fieldarray['is_active'])) {
            if ($fieldarray['is_active'] != $old_data['is_active']) {
                // if this occurrence is active make all others inactive
                $this->updateSelection ("schedule_id !='{$fieldarray['schedule_id']}'", "is_active='N'");
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
