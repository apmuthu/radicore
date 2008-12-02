<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class audit_logon_errors extends Default_Table
{
    // ****************************************************************************
    function audit_logon_errors ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'audit';
        $this->tablename   = 'audit_logon_errors';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // audit_logon_errors

    // ***************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
            // add extra (non-database) fields to search screen
            $this->fieldspec['date_from'] = array('type' => 'date',
                                                  'size' => 12);
            $this->fieldspec['date_to']   = array('type' => 'date',
                                                  'size' => 12);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_search)) return $where;

        // convert from string to an associative array
        $fieldarray = where2array($this->sql_search);

        // deal with values which have ranges
        if (!empty($fieldarray['date_from']) OR !empty($fieldarray['date_to'])) {
        	$fieldarray['err_timestamp'] = rangeFromTo($fieldarray['date_from'], $fieldarray['date_to'], true);
            unset($fieldarray['date_from']);
            unset($fieldarray['date_to']);
        } // if

        $this->sql_search = array2where($fieldarray);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
