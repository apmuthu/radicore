<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class pgsql
// this version is for PostgreSQL
{
    // member variables
    var $client_encoding;       // character encoding for client
    var $host_info;             // host info (connection)
    var $server_encoding;       // character encoding for server
    var $server_version;        // version number for server

    var $audit_logging;         // yes/no switch
    var $dbname;                // database name
    var $schema;                // schema name
    var $errors;                // array of errors
    var $error_string;          //
    var $fieldspec = array();   // field specifications (see class constructor)
    var $lastpage;              // last available page number in current query
    var $numrows;               // number of rows retrieved
    var $pageno;                // requested page number
    var $primary_key = array(); // array of primary key names
    var $rows_per_page;         // page size for multi-row forms
    var $row_locks;             // SH=shared, EX=exclusive
    var $row_locks_supp;        // supplemental lock type
    var $table_locks;           // array of tables to be locked
    var $transaction_level;     // transaction level
    var $unique_keys = array(); // array of canidate keys

    // the following are used to construct an SQL query
    var $sql_select;
    var $sql_from;
    var $sql_groupby;
    var $sql_having;
    var $sql_orderby;
    var $sql_orderby_seq;       // 'asc' or 'desc'
    var $query;                 // completed DML statement

    var $dbconnect;             // database connection resource

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function pgsql ($schema=null)
    {
        global $PGSQL_dbname;

        if (!empty($PGSQL_dbname)) {
            $result = $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);
        } else {
            trigger_error('No value supplied for $PGSQL_dbname', E_USER_ERROR);
        } // if

        if (!class_exists('audit_tbl')) {
    	    // obtain definition of the audit_tbl class
    		require_once 'classes/audit_tbl.class.inc';
    	} // if

        return $result;

    } // pgsql

    // ****************************************************************************
    function array2string ($array)
    // return an array of values (for an ARRAY datatype) as a string.
    {
        // return array as a comma-separated string inside curly braces
        $string = '{' .implode(',', $array) .'}';

        return $string;

    } // array2string

    // ****************************************************************************
    function buildKeyString ($fieldarray, $key)
    // build a string like "name1='value1' AND name2='value2'"
    // $fieldarray is an associative array of names and values
    // $key        is an indexed array of key fields
    {
        $where = null;

        foreach ($key as $fieldname) {
            if (array_key_exists($fieldname, $fieldarray)) {
            	$fieldvalue = pg_escape_string($fieldarray[$fieldname]);
            } else {
                $fieldvalue = '';
            } // if
            if (empty($where)) {
                $where  = "$fieldname='$fieldvalue'";
            } else {
                $where .= " AND $fieldname='$fieldvalue'";
            } // if
        } // foreach

        if (empty($where)) {
        	// *NO PRIMARY KEY HAS BEEN DEFINED*
        	$where = getLanguageText('sys0033');
        } // if

        return $where;

    } // buildKeyString

    // ****************************************************************************
    function commit ($schema)
    // commit this transaction
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $this->query = 'COMMIT';
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, 'COMMIT');
        $this->query = '';

        if (class_exists('audit_tbl')) {
            $auditobj =& singleton::getInstance('audit_tbl');
            $result = $auditobj->close();
        } // if

        return $result;

    } // commit

    // ****************************************************************************
    function connect ($schema=null)
    // establish a connection to the database
    {
        //DebugBreak();
        global $dbhost, $dbusername, $dbuserpass, $PGSQL_dbname;

        $this->errors = array();
        $this->query  = '';
        $this->dbname = $PGSQL_dbname;

        static $dbconn;

        if (!$dbconn) {
            $string = "host=$dbhost user=$dbusername password=$dbuserpass dbname=$PGSQL_dbname ";
            $dbconn = pg_connect($string);
            if ($dbconn) {
                $this->dbconnect = $dbconn;
                if (function_exists('pg_set_error_verbosity')) {
                	// set error reporting to verbose
                    pg_set_error_verbosity($dbconn, PGSQL_ERRORS_VERBOSE);
                } // if

                // use UTF8 for this connection
                if (function_exists('pg_set_client_encoding')) {
                	$result = pg_set_client_encoding($dbconn, 'UNICODE');
                } else {
                    $this->query = "SET client_encoding TO 'UNICODE'";
                    $result = pg_query($dbconn, $this->query) or trigger_error('SQL', E_USER_ERROR);
                    // write query to log file, if option is turned on
                    logSqlQuery ($schema, null, $this->query);
                } // if

                // retrieve current server settings
                $this->host_info       = pg_host($dbconn);
                $this->client_encoding = pg_client_encoding($dbconn);

                $this->query = 'SHOW server_encoding';
                $result = pg_query($dbconn, $this->query) or trigger_error('SQL', E_USER_ERROR);
                $data = pg_fetch_row($result);
                $this->server_encoding = $data[0];

                $this->query = 'SHOW server_version';
                $result = pg_query($dbconn, $this->query) or trigger_error('SQL', E_USER_ERROR);
                $data = pg_fetch_row($result);
                $this->server_version  = $data[0];
                $this->query = '';
            } // if
        } // if
        if (!$dbconn) {
            return FALSE;
        } elseif ($schema) {
            if (strtolower($schema) != 'public') {
                $schema = '"' .$schema .'", public';
            } // if
            $this->query = 'SET search_path TO ' .$schema;
            $result = pg_query($dbconn, $this->query) or trigger_error('SQL', E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery ($schema, null, $this->query);
            $this->query = '';
        } // if

        $this->schema = $schema;
        return TRUE;

    } // connect

    // ****************************************************************************
    function deleteRecord ($schema, $tablename, $fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        // build 'where' string using values for primary key
        $where = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (empty($where)) return;    // nothing to delete, so exit

        // build the query string and run it
        $this->query = "DELETE FROM $tablename WHERE $where";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = pg_affected_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($schema, $tablename, $this->fieldspec, $this->fieldspec, $this->fieldspec, $where, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteSelection ($schema, $tablename, $selection)
    // delete a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $this->query = "DELETE FROM $tablename WHERE $selection";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_affected_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($schema, $tablename, $this->fieldspec, $selection, array());
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $count;

    } // deleteSelection

    // ****************************************************************************
    function fetchRow ($schema, $result)
    // Fetch a row from the given result set (reated with getData_batch() method).
    {
        //DebugBreak();
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $row   = pg_fetch_assoc($result);
        if ($row) {
        	$array = array_change_key_case($row, CASE_LOWER);
        	return $array;
        } else {
            return false;
        } // if

    } // fetchRow

    // ****************************************************************************
    function getCount ($schema, $tablename, $where)
    // get count of records that satisfy selection criteria in $where.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        if (eregi('^(select )', $where)) {
            // $where starts with 'SELECT' so use it as a complete query
            $this->query = $where;
        } else {
            // does not start with 'SELECT' so it must be a 'where' clause
            $this->query = "SELECT count(*) FROM $tablename WHERE $where";
        } // if

        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);
        $query_data = pg_fetch_row($result);

        // if 'GROUP BY' was used then return the number of rows
        // (ignore GROUP BY if it is in a subselect)
        if (eregi("group by ", $this->query) == true AND !eregi("\(.+group by.+\)", $this->query)) {
            $count = pg_num_rows($result);
        } else {
            $count = $query_data[0];
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);
        $this->query = '';

        return $count;

    } // getCount

    // ****************************************************************************
    function getData ($schema, $tablename, $where)
    // get data from a database table using optional 'where' criteria.
    // Results may be affected by $where and $pageno.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $pageno         = (int)$this->pageno;
        $rows_per_page  = (int)$this->rows_per_page;
        $this->numrows  = 0;
        $this->lastpage = 0;

        $array = array();

        // look for optional SELECT parameters, or default to all fields
        if (empty($this->sql_select)) {
            // the default is all fields
            $select_str = '*';
        } else {
            $select_str = $this->sql_select;
        } // if

        // use specified FROM parameters, or default to current table name
        if (empty($this->sql_from)) {
            // the default is current table
            $from_str = $tablename;
        } else {
            $from_str = $this->sql_from;
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "WHERE $where";
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "GROUP BY $this->sql_groupby";
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            $having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        if ($rows_per_page > 0) {
            // count the rows that satisfy this query
            $this->query = "SELECT count(*) FROM $from_str $where_str $group_str $having_str";
            $this->numrows = $this->getCount($schema, $tablename, $this->query);

            if ($this->numrows <= 0) {
                $this->pageno = 0;
                return $array;
            } // if

            // calculate the total number of pages from this query
            $this->lastpage = ceil($this->numrows/$rows_per_page);
        } else {
            $this->lastpage = 1;
        } // if

        // ensure pageno is within range
        if ($pageno < 1) {
            $pageno = 1;
        } elseif ($pageno > $this->lastpage) {
            $pageno = $this->lastpage;
        } // if
        $this->pageno = $pageno;

        // set the limit and offset values to retrieve the specified page number
        if ($rows_per_page > 0) {
            $limit_str = 'LIMIT ' .$rows_per_page .' OFFSET ' .($pageno - 1) * $rows_per_page;
        } else {
            $limit_str = '';
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        $lock_str = null;
        if ($GLOBALS['transaction_has_started'] == TRUE) {
            if ($GLOBALS['lock_tables'] == FALSE) {
            	if (empty($this->row_locks)) {
                    // not defined locally, but may be defined globally
                	$this->row_locks = $GLOBALS['lock_rows'];
                } // if
                // deal with row locking (optional)
                switch ($this->row_locks){
                    case 'SH':
                        $lock_str = 'FOR UPDATE';
                        break;
                    case 'EX':
                        $lock_str = 'FOR UPDATE';
                        break;
                    default:
                        $count = preg_match_all("/\w+/", $from_str, $regs);
                        if ($count > 1) {
                            $lock_str = 'FOR UPDATE OF ' .$tablename;
                        } else {
                            $lock_str = 'FOR UPDATE';
                        } // if
                } // switch
                $this->row_locks = null;
            } // if
        } // if

        // build the query string and run it
        $this->query = "SELECT $select_str FROM $from_str $where_str $group_str $having_str $sort_str $limit_str $lock_str";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // convert result set into a simple associative array for each row
        while ($row = pg_fetch_assoc($result)) {
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        if ($rows_per_page == 0) {
            $this->numrows = pg_num_rows($result);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        pg_free_result($result);

        return $array;

    } // getData

    // ****************************************************************************
    function getData_batch ($schema, $tablename, $where)
    // Get data from a database table using optional 'where' criteria.
    // Return $result, not an array of data, so that individual rows can
    // be retrieved using the fetchRow() method.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        // look for optional SELECT parameters, or default to all fields
        if (empty($this->sql_select)) {
            // the default is all fields
            $select_str = '*';
        } else {
            $select_str = $this->sql_select;
        } // if

        // use specified FROM parameters, or default to current table name
        if (empty($this->sql_from)) {
            // the default is current table
            $from_str = $tablename;
        } else {
            $from_str = $this->sql_from;
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "WHERE $where";
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "GROUP BY $this->sql_groupby";
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            $having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        // build the query string and run it
        $this->query = "SELECT $select_str FROM $from_str $where_str $group_str $having_str $sort_str";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $this->numrows = pg_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        return $result;

    } // getData_batch

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function getErrorString ()
    // return string containing details of last error.
    {
        if (!empty($this->error_string)) {
            $string = $this->error_string;
            $this->error_string = null;
		} elseif ($this->dbconnect) {
            $string = 'PostgreSQL error: ' .pg_last_error($this->dbconnect);
        } else {
            $conerr = getLanguageText('sys0001', $this->dbname); // 'Cannot connect to database'
            $string = $conerr .pg_last_error($this->dbconnect);
        } // if

        return $string;

    } // getErrorString

    // ****************************************************************************
    function getErrorString2 ()
    // return additional information.
    {
        if ($this->dbconnect) {
        	$string  = 'Host Info: ' .$this->host_info ;
            $string .= ', Server Version: ' .$this->server_version;
            $string .= '<br>Client Encoding: ' .$this->client_encoding;
            $string .= ', Server Encoding: ' .$this->server_encoding;
            $string .= '<br>Database: ' .strtoupper($this->dbname);
            $string .= ', Schema: ' .strtoupper($this->schema);
        } else {
            $string = '';
        } // if

        return $string;

    } // getErrorString2

    // ****************************************************************************
    function getLastPage ()
    // return the last page number for retrieved rows.
    {
        return (int)$this->lastpage;

    } // getLastPage

    // ****************************************************************************
    function getNumRows ()
    // return the number of rows retrived for the current page.
    {
        return (int)$this->numrows;

    } // getNumRows

    // ****************************************************************************
    function getPageNo ()
    // get current page number to be retrieved for a multi-page display
    {
        if (empty($this->pageno)) {
            return 0;
        } else {
            return (int)$this->pageno;
        } // if

    } // getPageNo

    // ****************************************************************************
    function getQuery ()
    // return the last query string that was used
    {
        return $this->query;

    } // getQuery

    // ****************************************************************************
    function insertRecord ($schema, $tablename, $fieldarray)
    // insert a record using the contents of $fieldarray.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset ($fieldarray[$field]);
            } // if
        } // foreach

        foreach ($fieldspec as $field => $spec) {
            // look for fields with 'autoinsert' option set
            if (array_key_exists('autoinsert', $spec)) {
				switch ($spec['type']){
					case 'datetime':
						$fieldarray[$field] = getTimeStamp();
						break;
					case 'date':
						$fieldarray[$field] = getTimeStamp('date');
						break;
					case 'time':
						$fieldarray[$field] = getTimeStamp('time');
					    break;
					case 'string':
						$fieldarray[$field] = $_SESSION['logon_user_id'];
						break;
					default:
						// do nothing
				} // switch
            } // if
        } // foreach

        // find out if any field in the primary key has 'serial' (auto_increment) set
		$auto_increment = '';
		foreach ($this->primary_key as $pkey){
			if (isset($fieldspec[$pkey]['auto_increment'])) {
			    $auto_increment = $pkey ;                // save name of related sequence
				unset($fieldarray[$pkey]);	             // remove from data array
			} // if
		} // foreach

		if (empty($auto_increment)) {
	        // build 'where' string using values for primary key
	        $where = $this->buildKeyString ($fieldarray, $this->primary_key);

	        // find out if a record with this primary key already exists
	        $this->query = "SELECT count(*) FROM $tablename WHERE $where";
	        $count = $this->getCount($schema, $tablename, $this->query);

	        // Is this primary key taken?
	        if ($count <> 0) {
	            // set error message for each field within this key
	            foreach ($this->primary_key as $fieldname) {
	                $this->errors[$fieldname] = getLanguageText('sys0002'); // 'A record already exists with this ID.'
	            } // foreach
	            return $fieldarray;
	        } // if
	        $primary_key = $where;
		} // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where = $this->buildKeyString ($fieldarray, $key);
                $this->query = "SELECT count(*) FROM $tablename WHERE $where";
                $count = $this->getCount($schema, $tablename, $this->query);
                if ($count <> 0) {
                    // set error message for each field within this key
                    foreach ($key as $fieldname) {
                        $this->errors[$fieldname] = getLanguageText('sys0003'); // 'A record already exists with this key.'
                    } // foreach
                    return $fieldarray;
                } // if
            } // foreach
        } // if

        // insert this record into the database
        $cols = '';
        $vals = '';
        foreach ($fieldarray as $item => $value) {
            if ($fieldspec[$item]['type'] == 'array') {
            	// assume a one-dimensional array
            	$array1  = explode(',', $value);
            	$string1 = '';
            	foreach ($array1 as $value1) {
            		if (empty($string1)) {
            			$string1 = '"' .$value1 .'"';
            		} else {
            		    $string1 .= ', "' .$value1 .'"';
            		} // if
            	} // foreach
            	$value .= "$item='{" .$string1 ."}', ";
            } // if
            if (is_null($value) or strtoupper(trim($value)) == 'NULL') {
                // null entries are set to NULL, not '' (there is a difference!)
                $cols .= "$item, ";
                $vals .= "NULL, ";
            } else {
                $cols .= "$item, ";
                $vals .= "'" .pg_escape_string($value) ."', ";
            } // if
        } // foreach

        // remove trailing commas
        $cols = rtrim($cols, ', ');
        $vals = rtrim($vals, ', ');

        $this->query = 'INSERT INTO ' .$tablename .' (' .$cols .') VALUES (' .$vals .')';
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query);

		if (!empty($auto_increment)) {
			// obtain the last value used by auto_increment
			$this->query = "SELECT currval('" .$tablename .'_' .$auto_increment .'_seq' ."')";
            $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);
            $fieldarray[$auto_increment] = pg_fetch_result($result, 0, 0);
            $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);
            // write query to log file, if option is turned on
            logSqlQuery ($schema, $tablename, $this->query, $fieldarray[$auto_increment]);
		} // if

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditInsert($schema, $tablename, $this->fieldspec, $primary_key, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // insertRecord

    // ****************************************************************************
    function rollback ($schema)
    // rollback this transaction due to some sort of error.
    {
        $this->errors = array();

        if (!$this->dbconnect) {
            // not connected yet, so do nothing
            return FALSE;
        } // if

        $this->query = 'ROLLBACK';
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, 'ROLLBACK');
        $this->query = '';

        $auditobj =& singleton::getInstance('audit_tbl');
        $result = $auditobj->close();

        return $result;

    } // rollback

    // ****************************************************************************
    function selectDB ($schema)
    // select a different schema (database) via the current connection.
    {
        if ($this->connect($schema) or trigger_error('SQL', E_USER_ERROR)) {
            return TRUE;
        } else {
            return FALSE;
        } // if

    } // selectDB

    // ****************************************************************************
    function setErrorString ($string)
    // capture string from last non-fatal error.
    {
        $this->error_string = trim($string);

        return;

    } // setErrorString

    // ****************************************************************************
    function setOrderBy ($sql_orderby)
    // this allows a sort order to be specified (see getData)
    {
        $this->sql_orderby = trim($sql_orderby);

    } // setOrderBy

    // ****************************************************************************
    function setOrderBySeq ($sql_orderby_seq)
    // this allows a sort sequence ('asc' or 'desc') to be set (see getData)
    {
        $this->sql_orderby_seq = trim($sql_orderby_seq);

    } // setOrderBySeq

    // ****************************************************************************
    function setPageNo ($pageno='1')
    // this allows a particular page number to be selected (see getData)
    {
        $this->pageno = (int)$pageno;

    } // setPageNo

    // ****************************************************************************
    function setRowLocks ($level=null, $supplemental=null)
    // set row-level locks on next SELECT statement
    {
        // upshift first two characters
        $level = substr(strtoupper($level),0,2);

        switch ($level){
            case 'SH':
                $this->row_locks = 'SH';
                break;
            case 'EX':
                $this->row_locks = 'EX';
                break;
            default:
                $this->row_locks = null;
        } // switch

        $this->row_locks_supp = $supplemental;

        return;

    } // setRowLocks

    // ****************************************************************************
    function setRowsPerPage ($rows_per_page)
    // this allows the default value to be changed
    {
        if ($rows_per_page > 0) {
            $this->rows_per_page = (int)$rows_per_page;
        } // if

    } // setRowsPerPage

    // ****************************************************************************
    function setSqlSearch ($sql_search)
    // set additional criteria to be used in sql select
    {
        $this->sql_search = trim($sql_search);

    } // setSqlSearch

    // ****************************************************************************
    function startTransaction ($schema)
    // start a new transaction, to be terminated by either COMMIT or ROLLBACK.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $this->query = 'BEGIN TRANSACTION';
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, $this->query);
        $this->query = '';

        if (!empty($this->table_locks)) {
        	$result = $this->_setDatabaseLock($this->table_locks);
        } // if

        return $result;

    } // startTrasaction

    // ****************************************************************************
    function updateRecord ($schema, $tablename, $fieldarray, $oldarray, $where=null)
    // update a record using the contents of $fieldarray.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset ($fieldarray[$field]);
            } // if
        } // foreach

        if (strlen($where) == 0) {
            // build 'where' string using values for primary key
            $where = $this->buildKeyString ($oldarray, $this->primary_key);
        } else {
        	// use $where as supplied, and remove pkey specs so their values can be changed
        	$this->primary_key = array();
        } // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where1 = $this->buildKeyString ($oldarray, $key);
                $where2 = $this->buildKeyString ($fieldarray, $key);
                if ($where1 <> $where2) {
                    // key has changed, so check for uniqueness
                    $this->query = "SELECT count(*) FROM $tablename WHERE $where2";
                    $count = $this->getCount($schema, $tablename, $this->query);
                    if ($count <> 0) {
                        // set error message for each field within this key
                        foreach ($key as $fieldname) {
                            $this->errors[$fieldname] = getLanguageText('sys0003'); // 'A record already exists with this key.'
                        } // foreach
                        return $fieldarray;
                    } // if
                } // if
            } // foreach
        } // if

        // remove any values that have not changed
        $fieldarray = getChanges($fieldarray, $oldarray);

        if (empty($fieldarray)) {
            // nothing to update, so return now
            $this->numrows = 0;
            return $fieldarray;
        } // if

        if (isset($GLOBALS['mode']) and $GLOBALS['mode'] == 'logon' and $tablename == 'mnu_user') {
            // do not set these fields when logging in
        } else {
            foreach ($fieldspec as $field => $spec) {
                // look for fields with 'autoupdate' option set
                if (array_key_exists('autoupdate', $spec)) {
                    switch ($spec['type']){
    					case 'datetime':
    						$fieldarray[$field] = getTimeStamp();
    						break;
    					case 'date':
    						$fieldarray[$field] = getTimeStamp('date');
    						break;
    					case 'time':
						    $fieldarray[$field] = getTimeStamp('time');
						    break;
					    case 'string':
    						$fieldarray[$field] = $_SESSION['logon_user_id'];
    						break;
    					case 'integer':
					        $fieldarray[$field] = $oldarray[$field] +1;
					        break;
    					default:
    						// do nothing
    				} // switch
                } // if
            } // foreach
        } // if

        // build update string from non-pkey fields
        $update = '';
        foreach ($fieldarray as $item => $value) {
            // use this item if it IS NOT part of primary key
            if (!in_array($item, $this->primary_key)) {
                if (is_null($value) or strtoupper(trim($value)) == 'NULL') {
                    // null entries are set to NULL, not '' (there is a difference!)
                    $update .= "$item=NULL,";
                } else {
                    if (eregi('set|array|varray', $fieldspec[$item]['type'])) {
                    	// assume a one-dimensional array
                    	$array1  = explode(',', $value);
                    	$string1 = '';
                    	foreach ($array1 as $value1) {
                    	    $value1 = pg_escape_string($value1);
                    		if (empty($string1)) {
                    			$string1 = '"' .$value1 .'"';
                    		} else {
                    		    $string1 .= ', "' .$value1 .'"';
                    		} // if
                    	} // foreach
                    	// enclose array in curly braces
                    	$update .= "$item='{" .$string1 ."}', ";
                    } else {
                        // change to the new value
                        $update .= "$item='" .pg_escape_string($value) ."', ";
                    } // if
                } // if
            } // if
        } // foreach

        // strip trailing comma
        $update = rtrim($update, ', ');

        // append WHERE clause to SQL query
        $this->query = "UPDATE $tablename SET $update WHERE $where";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = pg_affected_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditUpdate($schema, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($schema, $tablename, $replace, $selection)
    // update a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $this->query = "UPDATE $tablename SET $replace WHERE $selection";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_affected_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        if ($count > 0) {
            if ($this->audit_logging) {
                $auditobj =& singleton::getInstance('audit_tbl');
                // add record details to audit database
                $auditobj->auditUpdateSelection($schema, $tablename, $this->fieldspec, $selection, $replace);
                $this->errors = array_merge($auditobj->getErrors(), $this->errors);
            } // if
        } // if

        return $count;

    } // updateSelection

    // ****************************************************************************
    // the following are DDL (Data Definition Language) methods
    // ****************************************************************************
    function ddl_getColumnSpecs ()
    // return the array of column specifications.
    {

        $colspecs['bigint']     = array('name' => 'BIGINT',
                                        'type' => 'integer',
                                        'minvalue' => '-9223372036854775808',
                                        'maxvalue' => '9223372036854775807',
                                        'size' => 20);
        $colspecs['bigserial']  = array('name' => 'BIGSERIAL',
                                        'type' => 'integer',
                                        'minvalue' => 1,
                                        'maxvalue' => '9223372036854775807',
                                        'auto_increment' => 'y');
        $colspecs['bit']        = array('name' => 'BIT',
                                        'type' => 'bit');
        $colspecs['varbit']     = array('name' => 'BIT VARYING',
                                        'type' => 'bit');
        $colspecs['boolean']    = array('name' => 'BOOLEAN',
                                        'type' => 'boolean');
        $colspecs['bytea']      = array('name' => 'BYTE ARRAY',
                                        'type' => 'byte');
        $colspecs['char']       = array('name' => 'CHAR',
                                        'type' => 'string',
                                        'size' => 4294967295);
        $colspecs['varchar']    = array('name' => 'CHARACTER VARYING',
                                        'type' => 'string',
                                        'size' => 4294967295);
        $colspecs['bytea']      = array('name' => 'BYTE ARRAY',
                                        'type' => 'byte');
        $colspecs['date']       = array('name' => 'DATE',
                                        'type' => 'date',
                                        'size' => 12);
        $colspecs['double']     = array('name' => 'DOUBLE PRECISION',
                                        'type' => 'float',
                                        'size' => 20);
        $colspecs['integer']    = array('name' => 'INTEGER',
                                        'type' => 'integer',
                                        'minvalue' => -2147483648,
                                        'maxvalue' => 2147483647,
                                        'size' => 10);
        $colspecs['interval']   = array('name' => 'INTERVAL',
                                        'type' => 'interval');
        $colspecs['money']      = array('name' => 'MONEY',
                                        'type' => 'numeric',
                                        'precision' => 10,
                                        'scale' => 2,
                                        'minvalue' => -21474836.48,
                                        'maxvalue' => 21474836.47);
        $colspecs['numeric']    = array('name' => 'NUMERIC',
                                        'type' => 'numeric');
        $colspecs['real']       = array('name' => 'REAL',
                                        'type' => 'float',
                                        'size' => 21);
        $colspecs['smallint']   = array('name' => 'SMALLINT',
                                        'type' => 'integer',
                                        'minvalue' => -32768,
                                        'maxvalue' => 32767,
                                        'size' => 5);
        $colspecs['serial']     = array('name' => 'SERIAL',
                                        'type' => 'integer',
                                        'minvalue' => 1,
                                        'maxvalue' => 2147483647,
                                        'auto_increment' => 'y');
        $colspecs['text']       = array('name' => 'TEXT',
                                        'type' => 'string',
                                        'size' => 1073741824);
        $colspecs['time']       = array('name' => 'TIME without time zone',
                                        'type' => 'time',
                                        'size' => 8);
        $colspecs['timestamp']  = array('name' => 'TIMESTAMP without time zone',
                                        'type' => 'datetime',
                                        'size' => 20);
        $colspecs['time_tz']     = array('name' => 'TIME with time zone',
                                        'type' => 'time',
                                        'size' => 8);
        $colspecs['timestamp_tz']= array('name' => 'TIMESTAMP with time zone',
                                        'type' => 'datetime',
                                        'size' => 20);
        $colspecs['array']      = array('name' => 'ARRAY',
                                        'type' => 'array');

        // these are computer adresses
        $colspecs['cidr']       = array('name' => 'CIDR',
                                        'type' => 'network address');
        $colspecs['inet']       = array('name' => 'INET',
                                        'type' => 'network address');
        $colspecs['macaddr']    = array('name' => 'MAC ADDRESS',
                                        'type' => 'mac address');

        // these are all shapes
        $colspecs['box']        = array('name' => 'BOX',
                                        'type' => 'shape');
        $colspecs['circle']     = array('name' => 'CIRCLE',
                                        'type' => 'shape');
        $colspecs['path']       = array('name' => 'PATH',
                                        'type' => 'shape');
        $colspecs['point']      = array('name' => 'POINT',
                                        'type' => 'shape');
        $colspecs['polygon']    = array('name' => 'POLYGON',
                                        'type' => 'shape');
        $colspecs['line']       = array('name' => 'LINE',
                                        'type' => 'shape');
        $colspecs['lseg']       = array('name' => 'LINE SEGMENT',
                                        'type' => 'shape');

        // these are here just for compatability with MySQL
        $colspecs['datetime']   = array('name' => 'DATETIME',
                                        'type' => 'datetime');
        $colspecs['set']        = array('name' => 'SET',
                                        'type' => 'array');
        $colspecs['enum']       = array('name' => 'ENUM',
                                        'type' => 'array');
        $colspecs['mediumint']  = array('name' => 'MEDIUMINT',
                                        'type' => 'integer');
        $colspecs['tinytext']   = array('name' => 'TINYTEXT',
                                        'type' => 'string');
        $colspecs['mediumtext'] = array('name' => 'MEDIUMTEXT',
                                        'type' => 'string');
        $colspecs['longtext']   = array('name' => 'LONGTEXT',
                                        'type' => 'string');

        return $colspecs;

    } // ddl_getColumnSpecs

    // ****************************************************************************
    function ddl_showColumns ($schema, $tablename)
    // obtain a list of column names within the selected database table.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $out_array = array();

        // build the query string and run it
        $this->query = "SELECT * FROM information_schema.columns WHERE table_schema='$schema' AND table_name='$tablename' ORDER BY ordinal_position";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        $colspecs = $this->ddl_getColumnSpecs();

        // identify primary and other unique keys
        $tablekeys = $this->ddl_showTableKeys($schema, $tablename);
        $pkey = array();  // primary key
        $ukey = array();  // candidate (unique) keys
        foreach ($tablekeys as $key => $spec) {
        	if (is_True($spec['is_primary'])) {
        	    $pkey[] = strtolower($spec['column_id']);
    	    } elseif (is_True($spec['is_unique'])) {
    	        $ukey[] = strtolower($spec['column_id']);
        	} // if
        } // foreach

        // convert result set into an associative array for each row
        while ($row = pg_fetch_assoc($result)) {
            // initialise all settings
            $columnarray = array();
            $columnarray['col_maxsize']         = NULL;
            $columnarray['col_unsigned']        = NULL;
            $columnarray['col_precision']       = NULL;
            $columnarray['col_scale']           = NULL;
            $columnarray['col_minvalue']        = NULL;
            $columnarray['col_maxvalue']        = NULL;
            $columnarray['col_auto_increment']  = NULL;
            $columnarray['col_key']             = NULL;

            foreach ($row as $item => $value) {
                $item = strtolower($item);
                switch ($item) {
                    case 'column_name':
                		$columnarray['column_id'] = $value;
                		if (in_array($value, $pkey)) {
                		    $columnarray['col_key'] = 'PRI';
                		} elseif (in_array($value, $ukey)) {
                		    $columnarray['col_key'] = 'UNI';
                		} // if
                		break;
                	case 'ordinal_position':
                	    $columnarray['column_seq'] = $value;
                	    break;
                	case 'column_default':
                	    // extract default which is enclosed in single quotes
                        if (preg_match("?\'[^\']+\'?", $value, $regs)) {
                            $value = substr($regs[0], 1, strlen($regs[0])-2); // strip first & last characters
                            $columnarray['col_default'] = $value;
                        } // if
                	    break;
                	case 'is_nullable':
                	    // is this column allowed to be NULL?
                		if (is_True($value)) {
                            $columnarray['col_null'] = 'Y';
                        } else {
                            $columnarray['col_null'] = 'N';
                        } // if
                	    break;
                	case 'data_type':
                	    switch ($value) {
                	    	case 'character':
                	            $columnarray['col_type'] = 'char';
                	            break;
                	    	case 'character varying':
                	    		$columnarray['col_type'] = 'varchar';
                	    		break;
                	        case 'double precision':
                	    		$columnarray['col_type'] = 'double';
                	    		break;
                	        case 'timestamp without time zone';
                	    	    $columnarray['col_type'] = 'timestamp';
                	            break;
                	    	case 'time without time zone';
                	    	    $columnarray['col_type'] = 'time';
                	            break;
                	    	case 'timestamp with time zone';
                	    	    $columnarray['col_type'] = 'timestamp_tz';
                	            break;
                	    	case 'time with time zone';
                	    	    $columnarray['col_type'] = 'time_tz';
                	            break;
                	    	case 'ARRAY';
                	    	    $columnarray['col_type']       = 'array';
                	    	    $columnarray['col_array_type'] = trim($row['udt_name'], '_');
                	    	    break;
                	    	default:
                	    	    $columnarray['col_type'] = $value;
                	    		break;
                	    } // switch

                	    unset($precision, $scale, $minvalue, $maxvalue);
                        $type  = $columnarray['col_type'];
                	    $specs = $colspecs[$type];

                	    if (isset($specs['size'])) {
                            $columnarray['col_maxsize'] = $specs['size'];
                        } // if
                        if (isset($specs['auto_increment'])) {
                            $columnarray['col_auto_increment'] = TRUE;
                        } // if

                        $columnarray['col_type_native'] = $columnarray['col_type'];

                        break;
                    case 'character_maximum_length':
                        if ($specs['type'] == 'string') {
                            if (!is_null($value)) {
                            	$columnarray['col_maxsize'] = $value;
                            } else {
                        	    $columnarray['col_maxsize'] = $specs['size'];
                            } // if
                        } // if
                        break;
                    case 'numeric_precision':
                        if ($specs['type'] == 'numeric') {
                            $precision                    = $value;
                            $columnarray['col_precision'] = $value;
                            $columnarray['col_maxsize']   = $value + 1;
                        } // if
                        break;
                    case 'numeric_precision_radix':

                        break;
                    case 'numeric_scale':
                        if ($specs['type'] == 'numeric') {
                            $scale                    = $value;
                            $columnarray['col_scale'] = $value;
                            if ($value > 0) {
                                $columnarray['col_maxsize'] = $columnarray['col_maxsize'] + 1;
                            } // if
                        } // if
                        break;
                    case 'datetime_precision':

                        break;
                    case 'interval_type':

                        break;
                    case 'interval_precision':

                        break;
                    default:
                		// ignore
                } // switch
            } // foreach

            // look for minimum value in $colspecs
            if (isset($specs['minvalue'])) {
                $minvalue = $specs['minvalue'];
            } else {
                if (isset($precision)) {
                    // minvalue includes negative sign
                    $minvalue = '-' . str_repeat('9', $precision);
                    if ($scale > 0) {
                        // adjust values to include decimal places
                        $minvalue = $minvalue / pow(10, $scale);
                    } // if
                } // if
            } // if
            if (isset($minvalue)) {
                $columnarray['col_minvalue'] = $minvalue;
            } // if

            // look for maximum value in $colspecs
            if (isset($specs['maxvalue'])) {
                $maxvalue = $specs['maxvalue'];
            } else {
                if (isset($precision)) {
                    // maxvalue has no positive sign
                    $maxvalue = str_repeat('9', $precision);
                    if ($scale > 0) {
                        // adjust values to include decimal places
                        $maxvalue = $maxvalue / pow(10, $scale);
                    } // if
                } // if
            } // if
            if (isset($maxvalue)) {
                $columnarray['col_maxvalue'] = (string)$maxvalue;
            } // if

            if ($columnarray['col_maxsize'] == 1) {
                // some columns have the option of being used as BOOLEAN
            	if ($columnarray['col_type'] == 'char') {
                    $columnarray['col_type'] = 'char,boolean';
                } // if
            } elseif ($columnarray['col_type'] == 'smallint') {
                $columnarray['col_type'] = 'smallint,boolean';
            } // if

            $columnarray['col_type_native'] = $columnarray['col_type'];

            if ($columnarray['col_type'] == 'numeric' AND $scale == 0) {
            	$columnarray['col_type'] = 'integer';
            } // if

            $out_array[] = $columnarray;
        } // while

        pg_free_result($result);

        return $out_array;

    } // ddl_showColumns

    // ****************************************************************************
    function ddl_showDatabases ()
    // obtain a list of existing database (schema in PostgreSQL) names.
    {
        // connect to database
        $this->connect() or trigger_error('SQL', E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SELECT nspname FROM pg_namespace WHERE nspname NOT LIKE 'pg\_%' AND nspname != 'information_schema' ORDER BY nspname";
        //$this->query = "SELECT * FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg\_%' AND schema_name != 'information_schema' ORDER BY schema_name";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery (nul, null, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = pg_fetch_assoc($result)) {
            $array[] = $row['nspname'];
        } // while

        pg_free_result($result);

        return $array;

    } // ddl_showDatabases

    // ****************************************************************************
    function ddl_showTables ($schema)
    // obtain a list of tables within the specified schema.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SELECT tablename AS table_name FROM pg_tables WHERE schemaname='" .$GLOBALS['dbprefix'] .$schema ."' ORDER BY tablename";
        //$this->query = "SELECT * FROM information_schema.tables WHERE table_schema='$schema' ORDER BY table_name";
        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, $this->query, $count);

        // convert result set into an associative array for each row
        while ($row = pg_fetch_assoc($result)) {
            $array[] = $row['table_name'];
        } // while

        pg_free_result($result);

        return $array;

    } // ddl_showTables

    // ****************************************************************************
    function ddl_showTableKeys ($schema, $tablename)
    // obtain a list of keys (indexes) for this table.
    {
        // connect to database
        $this->connect($schema) or trigger_error('SQL', E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SELECT c2.relname AS key_name, i.indisprimary AS is_primary, i.indisunique AS is_unique,
            pg_get_indexdef(i.indexrelid,1,true) AS column_id, c2.relnatts AS column_count, i.indexrelid
			FROM pg_namespace ns, pg_class c, pg_class c2, pg_index i
			WHERE ns.nspname = '{$schema}' AND c.relname = '{$tablename}' AND ns.oid = c.relnamespace AND c.oid = i.indrelid AND i.indexrelid = c2.oid
			ORDER BY i.indisprimary desc, i.indisunique desc, c2.relname";

//        $this->query = "SELECT key_column_usage.*,constraint_type  FROM information_schema.key_column_usage
//            LEFT JOIN information_schema.table_constraints USING (table_schema,table_name,constraint_name)
//            WHERE table_schema='$schema' and table_name='$tablename'
//            ORDER BY constraint_type, constraint_name, ordinal_position";

        $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);

        $count = pg_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = pg_fetch_assoc($result)) {
            if (is_true($row['is_primary'])) {
            	$row['key_name'] = 'PRIMARY';
            } // if
            $row['seq_in_index'] = 1;
            $array[] = $row;
            if ($row['column_count'] > 1) {
                // key has more than 1 column, so get details of all the other columns
                // and append them to the array
                $indexrelid = $row['indexrelid'];
                $max        = $row['column_count'];
                $count = 2;
                while ($count <= $max) {
                	$this->query = "SELECT pg_get_indexdef($indexrelid, $count, true) AS column_id";
                	$r2 = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);
                	$d2 = pg_fetch_assoc($r2);
                	$row['column_id']    = $d2['column_id'];
                	$row['seq_in_index'] = $count;
                	$array[] = $row;
                	$count++;
                } // while
            } // if
        } // while

        pg_free_result($result);

        return $array;

    } // ddl_showTableKeys

    // ****************************************************************************
    function _setDatabaseLock ($table_locks)
    // lock database tables identified in $string
    {
        foreach ($table_locks as $mode => $mode_array) {
            foreach ($mode_array as $table) {
                if (empty($string)) {
                    $string = "$table";
                } else {
                    $string .= ", $table";
                } // if
            } // foreach
        } // foreach

        // set locking level
        switch ($this->row_locks){
            case 'SH':
                switch (strtoupper($this->row_locks_supp)) {
                	case 'A':
                		$mode = 'ACCESS SHARE';
                		break;
                	case 'R':
                	    $mode = 'ROW SHARE';
                	    break;
                	case 'UE':
                	    $mode = 'SHARE UPDATE EXCLUSIVE';
                	    break;
                	case 'RE':
                	    $mode = 'SHARE ROW EXCLUSIVE';
                	    break;
                	default:
                	    $mode = 'SHARE';
                		break;
                } // switch
                break;
            case 'EX':
                switch (strtoupper($this->row_locks_supp)) {
                	case 'A':
                		$mode = 'ACCESS EXCLUSIVE';
                		break;
                	case 'R':
                	    $mode = 'ROW EXCLUSIVE';
                	    break;
                	default:
                	    $mode = 'EXCLUSIVE';
                		break;
                } // switch
                break;
            default:
                $mode = 'SHARE';
        } // switch

        if (!empty($string)) {
            $this->query = "LOCK TABLE $string IN $mode MODE";
            $result = pg_query($this->dbconnect, $this->query) or trigger_error('SQL', E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery (null, null, $this->query);
            $this->query = '';
            return true;
        } // if

        return true;

    } // _setDatabaseLock

    // ****************************************************************************
    function __sleep ()
    // perform object clean-up before serialization
    {

        // get associative array of class variables
        $object_vars = get_object_vars($this);

        // remove unwanted variables
        //unset($object_vars['data_raw']);

        // convert to indexed array
        $object_vars = array_keys($object_vars);

        return $object_vars;

    } // __sleep

// ****************************************************************************
} // end class
// ****************************************************************************

?>