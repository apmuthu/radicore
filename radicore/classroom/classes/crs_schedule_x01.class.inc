<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'crs_schedule.class.inc';
class crs_schedule_x01 extends crs_schedule
{
    // ****************************************************************************
    // this is for use in 'schedule_multi.php'
    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // temporarily define a different primary key
        $this->primary_key = array('schedule_id', 'room_id', 'day_no');

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // this overrides the method in the parent class

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // do not bother with primary key check
        $this->checkPrimaryKey = FALSE;

        // do not bother to read any data
        $this->skip_getdata = TRUE;

        if (!empty($where)) {
            if (empty($this->scrollarray)) {
            	// store $where string in its component parts
                $where = $this->setScrollArray ($where);
            } // if
        } // if

        $where = $this->getScrollItem($this->pageno);

        // convert from string to an associative array
        $array = where2array($where);

        $this->fieldarray   = array();
        $this->fieldarray[] = array_merge($where_array, $array);

        $where = array2where($this->fieldarray[0]);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_setScrollArray ($where, $wherearray)
    // construct an array of primary keys to scroll through
    {
        //DebugBreak();
        // get array of day numbers
        $array = $this->getValRep('day_no');
        // remove blank entry
        unset($array['']);

        // get current schedule_id
        require_once 'crs_schedule_hdr.class.inc';
        $dbobject =& singleton::getInstance('crs_schedule_hdr');
        $dbobject->sql_select = 'schedule_id';
        $data = $dbobject->getData("is_active='Y'");
        if ($dbobject->numrows > 0) {
            $schedule_id = $data[0]['schedule_id'];
        } else {
            $schedule_id = 0;
        } // if

        // create array of WHERE clauses
        $array2 = array();
        $ix     = 0;
        foreach ($array as $dayno => $dayname) {
        	$array2[$ix]['day_no']      = $dayno;
            $array2[$ix]['schedule_id'] = $schedule_id;
            $ix++;
        } // foreach

        return $array2;

    } // _cm_setScrollArray

// ****************************************************************************
} // end class
// ****************************************************************************

?>
