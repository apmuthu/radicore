<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_database.class.inc';
class dict_dataBase_s01 extends dict_dataBase
{
    // ****************************************************************************
    // this class is used to import existing database names
    // ****************************************************************************

    var $database_names;			// an array of database names which can be imported [server_name=dict_name]

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
            // swap server name with dictionary name
            $fieldarray['database_id'] = $this->database_names[$fieldarray['database_id']];
        	return $fieldarray;
        } // if

        global $servers;

        $dbnames          = array();
        $dbprefix_exclude = array();
        $switch_dbnames   = array();

        if (!empty($servers)) {
            // there are different databases on different servers
        	foreach ($servers as $server) {
                if (!empty($server['switch_dbnames'])) {
                	$dbprefix = '';  // cannot use this option at the same time
                    // flip from 'dictName=serverName' to 'serverName=dictName'
                    $temp = array_flip($server['switch_dbnames']);
                    // accumulate results
                    $switch_dbnames = array_merge($switch_dbnames, $temp);
				} else {
					$dbprefix = $server['dbprefix'];
                } // if
        		$dbnames = $this->_loadDatabases ($server['dbhost'], $dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames);
                if (!empty($dbprefix)) {
                    $dbprefix_exclude[] = $dbprefix;
                } // if
        	} // foreach
        } else {
            // all databases are within the same server
            if (!empty($GLOBALS['switch_dbnames'])) {
                $dbprefix = '';  // cannot use this option at the same time
                // flip from 'dictName=serverName' to 'serverName=dictName'
                $temp = array_flip($GLOBALS['switch_dbnames']);
                // accumulate results
                $switch_dbnames = array_merge($switch_dbnames, $temp);
			} else {
				$dbprefix = $GLOBALS['dbprefix'];
            } // if
            $dbnames = $this->_loadDatabases (null, $dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames);
            if (!empty($dbprefix)) {
                $dbprefix_exclude[] = $dbprefix;
            } // if
        } // if

        if (empty($dbnames)) {
            // 'There are no new database schemas to import'
        	$this->errors[] = getLanguageText('e0025');
            return $fieldarray;
        } // if

        ksort($dbnames);  // sort into ascending sequence on server name
        $this->database_names = $dbnames;				// this is for internal use
        $this->lookup_data['database_id'] = $dbnames;	// this is for the dropdown list

        if (!empty($switch_dbnames)) {
        	foreach ($switch_dbnames as $dbname_server => $dbname_dict) {
                if (array_key_exists($dbname_server, $dbnames)) {
        		    // show that there is a difference between the server name and the dictionary name
        		    $this->lookup_data['database_id'][$dbname_server] = "$dbname_server ($dbname_dict)";
                } // if
        	} // foreach
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        // import tables from database just processed
        $tableobj = RDCsingleton::getInstance('dict_table_s01');

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
    function _loadDatabases ($dbhost, $dbnames, $dbprefix, $dbprefix_exclude, $switch_dbnames)
    // find databases which have this $dbprefix and load their names into $dbnames.
    {
    	if (!empty($dbhost)) {
    		$DDL =& $this->_getDBMSengineByHost($dbhost);
		} else {
			$DDL =& $this->_getDBMSengine($this->dbname);
    	} // if

        // get list of all database names from the database server
        //$array  = $this->_ddl_showDatabases($dbprefix);
        $array = $DDL->ddl_showDatabases($dbprefix);

        // filter out those databases that already exist in DICT database
        $i = 0;
        $prefix_len = strlen($dbprefix);
        foreach ($array as $row => $dbname_server) {
            $dbname_server = strtolower($dbname_server);
            $dbname_dict   = $dbname_server;
            if (preg_match('/(information_schema|mysql|performance_schema)/i', $dbname_server)) {
            	// ignore this entry
            } else {
	            if (!empty($dbprefix)) {
	                // remove server prefix from dbname
	                if (preg_match('/^(' .$dbprefix .')/i', $dbname_server)) {
        				$dbname_dict = substr($dbname_server, $prefix_len);
	                } // if
	            } else {
	                foreach ($dbprefix_exclude as $e_dbprefix) {
	                    // this prefix has already been processed, so exclude any entries which use it
	                    if (substr($dbname_server, 0, strlen($e_dbprefix)) == $e_dbprefix) {
	                        $dbname_dict = substr($dbname_server, strlen($e_dbprefix));
	                        break;
	                    } // if
	                } // foreach
	            } // if
	            if (!empty($switch_dbnames)) {
	                if (array_key_exists($dbname_server, $switch_dbnames)) {
	                    // name in the dictionary is different from the name on the server
	                    $dbname_dict = $switch_dbnames[$dbname_server];
	                } // if
	            } // if
	            // check to see if this dbname is already in the dictionary database
        		$count = $this->getCount("database_id='$dbname_dict'");
	            if ($count == 0) {
	                // not yet, so add it to list of databases which can be selected
	                $dbnames[$dbname_server] = $dbname_dict;
	            } // if
			} // if
        } // foreach

        return $dbnames;

    } // _loadDatabases

    // ****************************************************************************
    function &_getDBMSengineByHost ($dbhost)
    // obtain the object that deals with the database engine for this table.
    {
        $engine = null;
        //$args   = array('dbname' => $dbname);

        // multi-server option
        // find out which server deals with this dbhost
        foreach ($GLOBALS['servers'] as $servernum => $server) {
        	if (empty($server['dbnames'])) {
        	    // DBNAMES entry missing
        	    trigger_error($this->getLanguageText('sys0170', 'DBNAMES'), E_USER_ERROR);
        	} else {
        	    $dbname_array = explode(',', $server['dbnames']);
                $dbname_array = array_map('trim', $dbname_array);
        	} // if
            if (!empty($server['switch_dbnames']) AND is_array($server['switch_dbnames'])) {
                // database name in the class file may be switched to a different name on the server
                $switch_dbnames = $server['switch_dbnames'];
            } else {
                $switch_dbnames = array();
            } // if
            if ($server['dbhost'] == $dbhost) {
                if (!isset($server['dbengine'])) {
                    trigger_error($this->getLanguageText('sys0170', 'DBENGINE'), E_USER_ERROR);
                } else {
                    $engine = $server['dbengine'];
                } // if
                if (!isset($server['dbhost'])) {
                    trigger_error($this->getLanguageText('sys0170', 'DBHOST'), E_USER_ERROR);
                } else {
                    $args['dbhost'] = $server['dbhost'];
                } // if
                if (!isset($server['dbusername'])) {
                    trigger_error($this->getLanguageText('sys0170', 'DBUSERNAME'), E_USER_ERROR);
                } else {
                    $args['dbusername'] = $server['dbusername'];
                } // if
                if (!isset($server['dbuserpass'])) {
                    trigger_error($this->getLanguageText('sys0170', 'DBUSERPASS'), E_USER_ERROR);
                } else {
                    $args['dbuserpass'] = $server['dbuserpass'];
                } // if
                if (!empty($server['dbport'])) {
                    $args['dbport'] = $server['dbport'];
                } // if
                if (!empty($server['dbsocket'])) {
                    $args['dbsocket'] = $server['dbsocket'];
                } // if
                if (!isset($server['dbprefix'])) {
                    trigger_error($this->getLanguageText('sys0170', 'DBPREFIX'), E_USER_ERROR);
                } else {
                    $args['dbprefix'] = $server['dbprefix'];
                } // if
                if (!empty($server['ssl_key'])) {
                    $args['ssl_key'] = $server['ssl_key'];
                } // if
                if (!empty($server['ssl_cert'])) {
                    $args['ssl_cert'] = $server['ssl_cert'];
                } // if
                if (!empty($server['ssl_ca'])) {
                    $args['ssl_ca'] = $server['ssl_ca'];
                } // if
                if (!empty($server['ssl_capath'])) {
                    $args['ssl_capath'] = $server['ssl_capath'];
                } // if
                if (!empty($server['ssl_cipher'])) {
                    $args['ssl_cipher'] = $server['ssl_cipher'];
                } // if
                // these are options for non-MySQL databases
                if (isset($server['PGSQL_dbname'])) {
                    $args['PGSQL_dbname'] =& $server['PGSQL_dbname'];
                } // if
                if (isset($server['SQLSRV_schema'])) {
                    $args['SQLSRV_schema'] =& $server['SQLSRV_schema'];
                } // if
                if (isset($server['serverName'])) {
                    $args['serverName'] =& $server['serverName'];
                } // if
                if (isset($server['connectionInfo'])) {
                    $args['connectionInfo'] =& $server['connectionInfo'];
                } // if
                break; // so stop here
            } // if
        } // foreach
        if (empty($engine)) {
        	// "entry missing for database 'X'"
        	trigger_error($this->getLanguageText('sys0171', $dbname), E_USER_ERROR);
        } // if

        if (empty($engine)) {
        	trigger_error("No value has been supplied for DBMS engine", E_USER_ERROR);
        } // if

        if (!class_exists($engine)) {
            // load class definition for this database engine
            if ($engine == 'mysql') {
                if (extension_loaded('mysqli')) {
                    // use 'improved' mysql functions
                    require_once "dml.mysqli.class.inc";
                } else {
                    // use standard mysql functions
                    require_once "dml.mysql.class.inc";
                } // if
            } elseif ($engine == 'oracle') {
                if (version_compare(phpversion(), '5.0.0', '<')) {
                    // use old api's
                    require_once "dml.oracle.php4.class.inc";
                } else {
                    // use new api's
                    require_once "dml.oracle.php5.class.inc";
                } // if
            } else {
                require_once "dml.$engine.class.inc";
            } // if
        } // if

        if (isset($servernum)) {
            $DML = RDCsingleton::getInstance('server__' .$servernum .'__' .$engine, $args, true);
        } else {
            $DML = RDCsingleton::getInstance($engine, $args, true);
        } // if

        return $DML;

    } // _getDBMSengineByHost

// ****************************************************************************
} // end class
// ****************************************************************************

?>
