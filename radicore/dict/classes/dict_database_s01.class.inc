<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_database.class.inc';
class dict_dataBase_s01 extends dict_dataBase
{
    // ****************************************************************************
    // this class is used to import existing database names
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $this->fieldspec['database_id']['control']    = 'dropdown';
        $this->fieldspec['database_id']['optionlist'] = 'database_id';

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
    // Perform custom processing prior to insertRecord().
    // $fieldarray contains data from the initial $where clause.
    {
        if (array_key_exists('database_id', $this->lookup_data)) {
            // already there, so don't build it again
        	return $fieldarray;
        } // if

        global $servers;

        $dbnames          = array();
        $dbprefix_exclude = array();
        $switch_dbnames   = array();

        if (!empty($servers)) {
            // there are different databases on different servers
        	foreach ($servers as $server) {
        		$dbprefix = $server['dbprefix'];
                if (!empty($server['switch_dbnames'])) {
                    // flip from 'dictName=serverName' to 'serverName=dictName'
                    $server['switch_dbnames'] = array_flip($server['switch_dbnames']);
                    // accumulate results
                    $switch_dbnames = array_merge($switch_dbnames, $server['switch_dbnames']);
                } // if
        		$dbnames = $this->_loadDatabases ($dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames);
                if (!empty($dbprefix)) {
                    $dbprefix_exclude[] = $dbprefix;
                } // if
        	} // foreach
        } else {
            // all databases are within the same server
            $dbprefix = $GLOBALS['dbprefix'];
            $dbnames = $this->_loadDatabases ($dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames);
            if (!empty($dbprefix)) {
                $dbprefix_exclude[] = $dbprefix;
            } // if
        } // if

        if (empty($dbnames)) {
            // 'There are no new database schemas to import'
        	$this->errors[] = getLanguageText('e0025');
            return $fieldarray;
        } // if

        asort($dbnames);  // sort into ascending sequence
        $this->lookup_data['database_id'] = $dbnames;

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        // import tables from database just processed
        $tableobj =& RDCsingleton::getInstance('dict_table_s01');

        $array = $tableobj->getInitialDataMultiple($fieldarray);
        $array = $tableobj->insertMultiple($array);
        if ($tableobj->getErrors()) {
            $errors = $tableobj->getErrors();
            foreach ($errors as $row => $error) {
            	$this->errors[] = 'From DICT_TABLE: ' .$error[key($error)];
            } // foreach
        } // if

        if (empty($this->errors)) {
        	$next['task_id'] = 'dict_table(list2)';
            $next['where']   = array2where($fieldarray, $this->getPkeyNames());
            append2ScriptSequence($next);
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _loadDatabases ($dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames)
    // find databases which have this $dbprefix and load their names into $dbnames.
    {
        // get list of all database names from the database server
        $array  = $this->_ddl_showDatabases($dbprefix);

        // filter out those databases that already exist in DICT database
        $i = 0;
        $prefix_len = strlen($dbprefix);
        foreach ($array as $row => $dbname) {
            $dbname = strtolower($dbname);
            if (!empty($dbprefix)) {
                // remove server prefix from dbname
                if (preg_match('/^(' .$dbprefix .')/i', $dbname)) {
        			$dbname = substr($dbname, $prefix_len);
                    $array[$row] = $dbname;
                } // if
            } else {
                foreach ($dbprefix_exclude as $e_dbprefix) {
                    // this prefix has already been processed, so exclude any entries which use it
                    if (substr($dbname, 0, strlen($e_dbprefix)) == $e_dbprefix) {
                        $dbname = substr($dbname, strlen($e_dbprefix));
                        $array[$row] = $dbname;
                        break;
                    } // if
                } // foreach
            } // if
            if (!empty($switch_dbnames)) {
                if (array_key_exists($dbname, $switch_dbnames)) {
                    // name in the dictionary is different from the name on the server
                    $dbname = $switch_dbnames[$dbname];
                } // if
            } // if
        	$count = $this->getCount("database_id='$dbname'");
            if ($count == 0) {
                if (!array_key_exists($dbname, $dbnames)) {
                    // this is new, so store details in return array
                    $dbnames[$dbname] = $dbprefix.$dbname;
                } // if
            } // if
        } // foreach

        return $dbnames;

    } // _loadDatabases

// ****************************************************************************
} // end class
// ****************************************************************************

?>
