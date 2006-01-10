<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_table.class.inc';
class dict_table_s01 extends dict_table
{
    // ****************************************************************************
    // this class is used to import existing table names for a selected database
    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // get list of existing table names
        $dbname = $fieldarray['database_id'];
        $fieldarray = array();
        $array = $this->_ddl_showTables($dbname);

        // filter out those that already exist in DICT database
        $i = 0;
        foreach ($array as $tablename) {
        	$count = $this->getCount("database_id='$dbname' AND table_id='$tablename'");
            if ($count == 0) {
                // insert details of new database
                $fieldarray[$i]['database_id'] = $dbname;
                $fieldarray[$i]['table_id']    = $tablename;
                $fieldarray[$i]['table_desc']  = $tablename;
                $i++;
            } // if
        } // foreach

        if (empty($fieldarray)) {
            // do not fill empty array with null values
        	$this->ignore_empty_fields = TRUE;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        // remove any empty fields from the input array
        foreach ($fieldarray as $fieldname => $fieldvalue) {
        	if (strlen($fieldvalue) == 0) {
        	    unset($fieldarray[$fieldname]);
        	} // if
        } // foreach

        if (empty($fieldarray)) {
            $this->errors[] = getLanguageText('e0023'); // "There is no data to insert";
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
