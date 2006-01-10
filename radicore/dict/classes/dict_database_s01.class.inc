<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_database.class.inc';
class dict_dataBase_s01 extends dict_dataBase
{
    // ****************************************************************************
    // this class is used to import existing database names
    // ****************************************************************************
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
                $lock_array[] = 'dict_table';
               break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // get list of existing database names
        $array = $this->_ddl_showDatabases();

        // filter out those that already exist in DICT database
        $i = 0;
        foreach ($array as $dbname) {
        	$count = $this->getCount("database_id='$dbname'");
            if ($count == 0) {
                // insert details of new database
                $fieldarray[$i]['database_id']   = $dbname;
                $fieldarray[$i]['database_desc'] = $dbname;
                $fieldarray[$i]['subsys_id']     = '?';
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
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        // import tables from database just processed
        static $tableobj;
        if (!is_object($tableobj)) {
            require_once 'dict_table_s01.class.inc';
            $tableobj =& singleton::getInstance('dict_table_s01');
        } // if

        $array = $tableobj->getInitialData($fieldarray);
        $array = $tableobj->insertMultiple($array);
        if ($tableobj->getErrors()) {
            $errors = $tableobj->getErrors();
            foreach ($errors as $row => $error) {
            	$this->errors[] = 'From DICT_TABLE: ' .$error[key($error)];
            } // foreach
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
