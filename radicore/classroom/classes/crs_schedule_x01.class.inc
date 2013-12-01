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

        // display day name in a separate field
        unset($this->fieldspec['day_no']['control']);
        $this->fieldspec['day_name']        = array('type' => 'numeric',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'day_no');

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    {
        $fieldarray['day_name'] = $fieldarray['day_no'];

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this overrides the method in the parent class

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if (!empty($where)) {
        	// store $where string in its component parts
            $where = $this->setScrollArray($where);
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // this overrides the method in the parent class

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // do not bother to read any data
        $this->skip_getdata = TRUE;

//        if (!empty($where)) {
//            if (empty($this->scrollarray)) {
//            	// store $where string in its component parts
//                $where = $this->setScrollArray($where);
//            } // if
//        } // if

        // retrieve a single entry from the constructed array
        $where = $this->getScrollItem($this->pageno);

        // convert from string to an associative array
        $array = where2array($where);

        $this->fieldarray   = array();
        // merge with $where passed down from parent object
        $this->fieldarray[] = array_merge($where_array, $array);

        // create $where string for child object
        $where = array2where($this->fieldarray[0]);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_setScrollArray ($where, $wherearray)
    // construct an array of primary keys to scroll through
    {
        // get array of day numbers
        $array = $this->getValRep('day_no');

        if (isset($_SESSION['crs_schedule_id'])) {
            // use schedule_id that has already been chosen
        	$schedule_id = $_SESSION['crs_schedule_id'];
        } else {
            // get current schedule_id
            $dbobject =& RDCsingleton::getInstance('crs_schedule_hdr');
            $dbobject->sql_select = 'schedule_id';
            $data = $dbobject->getData("is_active='" .$dbobject->fieldspec['is_active']['true'] ."'");
            if ($dbobject->numrows > 0) {
                $schedule_id = $data[0]['schedule_id'];
            } else {
                $schedule_id = 0;
            } // if
        } // if

        // create array of WHERE clauses, one for each day of the week
        $array2 = array();
        foreach ($array as $dayno => $dayname) {
        	$array2[$dayno]['day_no']      = $dayno;
            $array2[$dayno]['schedule_id'] = $schedule_id;
        } // foreach

        //$this->pageno = 7;  // just a test

        return $array2;

    } // _cm_setScrollArray

// ****************************************************************************
} // end class
// ****************************************************************************

?>
