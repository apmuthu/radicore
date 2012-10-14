<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_table.class.inc';
class dict_table_s01 extends dict_table
{
    // ****************************************************************************
    // this class is used to import existing table names for a selected database
    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause.
    {
        // get list of existing table names
        if (!is_string(key($fieldarray))) {
            $fieldarray = $fieldarray[0];
        } // if

    	$dbname  = $fieldarray['database_id'];
        // NOTE: name in dictionary may be different from name on server
    	list($dbprefix, $server_name) = dict_findDBPrefix($dbname);

        $fieldarray = array();
        $array = $this->_ddl_showTables($dbprefix.$server_name);

        // filter out those that already exist in DICT database
        $i = 0;
        foreach ($array as $tablename) {
            $tablename = strtolower($tablename);
            //if ($dbname == 'staging' AND preg_match('/^sym_entries_data/', $tablename)) {
            	// ignore these tables
            //} else {
            	$count = $this->getCount("database_id='$dbname' AND table_id='$tablename'");
                if ($count == 0) {
                    // insert details of new database table
                    $fieldarray[$i]['database_id'] = $dbname;
                    $fieldarray[$i]['table_id']    = $tablename;
                    $fieldarray[$i]['table_desc']  = ucwords(str_replace('_', ' ', $tablename));
                    $i++;
                } // if
            //} // if
        } // foreach

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_pre_insertMultiple ($rows)
    // perform custom processing before multiple database records are inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        if (empty($rows)) {
            $this->errors[] = getLanguageText('e0023'); // "There is no data to insert";
        } // if

        return $rows;

    } // _cm_pre_insertMultiple

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
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
