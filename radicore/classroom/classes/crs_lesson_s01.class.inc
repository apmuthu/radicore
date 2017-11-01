<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'crs_lesson.class.inc';
class crs_lesson_s01 extends crs_lesson
{
    // ****************************************************************************
    // this is for use in forms of type LIST2
    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {

        return $rowdata;

    } // _cm_post_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
