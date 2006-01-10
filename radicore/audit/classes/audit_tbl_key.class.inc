<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_tbl.class.inc';
class audit_tbl_key extends audit_tbl
{
    // ****************************************************************************
    // this class is for use by script: audit_dtl_list3.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // do not bother with primary key check
        $this->checkPrimaryKey = FALSE;

        // do not bother to read the database for sany data
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

        $this->fieldarray = array();

        $this->fieldarray[]['audit_dtl_key'] = $where;

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
