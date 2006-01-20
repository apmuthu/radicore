<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_tbl.class.inc';
class audit_tbl_s01 extends audit_tbl
{
    // ****************************************************************************
    // this class is for use by script: audit_dtl_list3.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //$this->fieldspec['date']    = array('type' => 'date');

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        if (empty($where)) {
            // obtain $where string from $fieldarray which has just been loaded
            $where = array2where($this->fieldarray[1]);
        } // if

        $where = trim($where, ' ()');

        // are we looking for 'similar' or 'exact'?
        $pattern =& $GLOBALS['settings']['pattern'];
        if ($pattern == 'exact') {
            // pkey must match $where exactly
            $where = "pkey='" . addslashes($where) . "'";
        } else {
            // pkey may contain other values as well as what is in $where
            $where = "pkey LIKE '%" . addslashes($where) . "%'";
        } // if

        // remove this so that it doesnot allow 'date' to appear in the order by clause
        unset($this->fieldspec['date']);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
