<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_dataBase extends Default_Table
{
    // member variables

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_dataBase ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'dict_database';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // dict_dataBase

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if ($GLOBALS['mode'] != 'search') {
			// do not replace database id with textual description
		    unset($this->fieldspec['database_id']['control']);
		} // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_table';
                $lock_array[] = 'dict_table_key';
                $lock_array[] = 'dict_column';
                $lock_array[] = 'dict_relationship';
                $lock_array[] = 'dict_related_column';
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
		// get contents of this table and put into lookup data
		// (use another object so as to not change the values in this one)
		require_once 'classes/dict_table.class.inc';
        $dbobject =& singleton::getInstance('dict_table');
		$array = $dbobject->_cm_getValRep('database_id');
		$this->lookup_data['database_id'] = $array;

        // get contents of foreign table MNU_SUBSYSTEM and put into lookup_data
        require_once 'classes/mnu_subsystem.class.inc';
        $dbobject =& singleton::getInstance('mnu_subsystem');
        $array = $dbobject->getValRep('subsys_id');
        $this->lookup_data['subsys_id'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'database_id') {
            // get data from the database
            $this->sql_select     = 'database_id, database_desc';
            $this->sql_orderby    = 'database_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

			$this->sql_select     = '';
        	$this->sql_orderby    = '';

			// convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[0];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {
        // no logging for this 'erase'
        $this->audit_logging = false;

        return $fieldarray;

    } // _cm_pre_eraseRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
