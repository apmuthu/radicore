<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_tbl.class.inc';
class audit_tbl_key extends audit_tbl
{
    // ****************************************************************************
    // this class is for use by script: audit_dtl_list3.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if (!empty($where)) {
            // do not allow contents of $where to be filtered out
        	$this->where = $where;
        } // if

        //$this->pageno = 7;  // this is a test

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain contents of current record in the parent object.
    {
        // do not bother with primary key check
        $this->checkPrimaryKey = FALSE;

        // do not bother to read the database for any data - it will be constructed here
        $this->skip_getdata = TRUE;

        // remove RESET key
        unset($GLOBALS['act_buttons']['reset']);

        if (!empty($where)) {
            if (empty($this->scrollarray)) {
            	// store $where string in its component parts
                $where = $this->setScrollArray ($where);
            } // if
        } // if

        $where = $this->getScrollItem($this->pageno);

        // convert from string to an associative array
        $array = where2array($where);

        // allow this value to be extracted into the XML file so that it can appear in the screen
        $array['audit_dtl_key'] = $where;

        $this->fieldarray = array();

        $this->fieldarray[] = $array;

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_setScrollArray ($where, $where_array)
    // construct an array of primary keys to scroll through
    {
        $array = array();

        $array = splitWhereByRow($where);    // default - replace with custom code

        return $array;

    } // _cm_setScrollArray

// ****************************************************************************
} // end class
// ****************************************************************************

?>
