<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class mysql
// this version is for MySQL (using the standard functions)
{
    // connection settings
    var $dbhost;
    var $dbusername;
    var $dbuserpass;
    var $dbprefix;

    // server settings
    var $client_info;                   // client info (version number)
    var $host_info;                     // host info (connection)
    var $server_info;                   // server info (version number)
    var $charset;                       // character set
    var $character_set_client;
    var $character_set_connection;
    var $character_set_database;
    var $character_set_server;

    var $allow_db_function = false;     // allow a field's value in a database insert/update to contain a function name
    var $audit_logging;                 // yes/no switch
    var $dbname;                        // database name
    var $errors;                        // array of errors
    var $error_string;                  //
    var $fieldspec = array();           // field specifications (see class constructor)
    var $lastpage;                      // last available page number in current query
    var $no_duplicate_error;            // if TRUE do not create an error when inserting a duplicate
    var $numrows;                       // number of rows retrieved
    var $pageno;                        // requested page number
    var $primary_key = array();         // array of primary key names
    var $retry_on_duplicate_key;        // field name to be incremented when insert fails
    var $rows_per_page;                 // page size for multi-row forms
    var $row_locks;                     // SH=shared, EX=exclusive
    var $row_locks_supp;                // supplemental lock type
    var $table_locks;                   // array of tables to be locked
    var $transaction_level;             // transaction level
    var $unique_keys = array();         // array of candidate keys
    var $update_on_duplicate_key;       // switch to 'update' if insert fails

    // the following are used to construct an SQL query
    var $sql_select;
    var $sql_from;
    var $sql_groupby;
    var $sql_having;
    var $sql_orderby;
    var $sql_orderby_seq;               // 'asc' or 'desc'
    var $sql_union;
    var $query;                         // completed DML statement

    var $dbconnect;                     // database connection resource

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mysql ($args=null)
    {
        if (is_string($args)) {
            $dbname           = $args;
        } else {
            $dbname           =& $args['dbname'];
            $this->dbhost     =& $args['dbhost'];
            $this->dbusername =& $args['dbusername'];
            $this->dbuserpass =& $args['dbuserpass'];
            $this->dbprefix   =& $args['dbprefix'];
            if (!empty($args['dbport'])) {
                $this->dbhost .= ':'.$args['dbport'];
            } elseif (!empty($args['dbsocket'])) {
                $this->dbhost .= ':'.$args['dbsocket'];
            } // if
        } // if

        if (!empty($dbname)) {
            $result = $this->connect($dbname) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = TRUE;
        } // if

    	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        	// do nothing
        } else {
            if (!class_exists('audit_tbl')) {
        	    // obtain definition of the audit_tbl class
        		require_once 'classes/audit_tbl.class.inc';
        	} // if
        } // if

        return $result;

    } // mysql

    // ****************************************************************************
    function adjustWhere ($string_in)
    // modify string which may have been altered by addslashes() as in some cases
    // '\\' (double backslash) must be doubled up to '\\\\'
    // - [name = 'value\\'] must be left alone
    // - [name LIKE 'value\\'] must be changed to [name LIKE 'value\\\\']
    {
        $string_out = $string_in;

        $modified = false;

        $array = where2indexedArray($string_out);   // convert string into indexed array

        $pattern = '/^('        // begins with
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . '\) OR'      // ') OR'
                 . '|'
                 . 'OR \('      // 'OR ('
                 . '|'
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\) AND'     // ') AND'
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '(\()+'      // one or more '('
                 . '|'
                 . '(\))+'      // one or more ')'
                 . ')$/i';      // ends with, case insensitive
        foreach ($array as $key => $value) {
            if (preg_match($pattern, $value, $regs)) {
            	// ignore this
            } else {
                list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($value);
                if (preg_match('/^like /i', $fieldvalue)) {
            	    if (preg_match('/\\\\/', $fieldvalue)) {
            	    	$fieldvalue = str_replace('\\\\', '\\\\\\\\', $fieldvalue);
            	    	$array[$key] = $fieldname.$operator.$fieldvalue;
                		$modified = true;
            	    } // if
            	} // if
            } // if
        } // foreach

        if ($modified) {
        	$string_out = implode(' ', $array);
        } // if

        return $string_out;

    } // adjustWhere

    // ****************************************************************************
    function array2string ($array)
    // return an array of values (for a SET datatype) as a string.
    {
        // return array as a comma-separated string
        $string = implode(',', $array);

        return $string;

    } // array2string

    // ****************************************************************************
    function buildKeyString ($fieldarray, $key)
    // build a string like "name1='value1' AND name2='value2'"
    // $fieldarray is an associative array of names and values
    // $key        is an indexed array of key fields
    {
        $where      = null;
        $null_count = 0;

        foreach ($key as $fieldname) {
            if (array_key_exists($fieldname, $fieldarray)) {
                if (is_null($fieldarray[$fieldname])) {
                    $fieldvalue = " IS NULL";
                    $null_count++;
                } else {
                    $fieldvalue = "='".mysql_real_escape_string($this->dbconnect, $fieldarray[$fieldname])."'";
                } // if
            } else {
                $fieldvalue = " IS NULL";
                $null_count++;
            } // if
            if (empty($where)) {
                $where  = "$fieldname$fieldvalue";
            } else {
                $where .= " AND $fieldname$fieldvalue";
            } // if
        } // foreach

        if (empty($where)) {
            // *NO PRIMARY KEY HAS BEEN DEFINED*
            $where = getLanguageText('sys0033');
        } elseif ($null_count == count($key)) {
            $where = null;  // every field is null, so there is nothing to lookup
        } // if

        return $where;

    } // buildKeyString

    // ****************************************************************************
    function commit ($dbname)
    // commit this transaction
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = 'COMMIT';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $this->query = 'UNLOCK TABLES';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $this->query = 'SET AUTOCOMMIT=1';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'COMMIT; UNLOCK TABLES; SET AUTOCOMMIT=1');
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        	// do nothing
	    } else {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            $result = $auditobj->close();
        } // if

        return $result;

    } // commit

    // ****************************************************************************
    function connect ($dbname=null)
    // establish a connection to the database
    {
        $this->errors = array();
        $this->query  = '';
        $this->dbname = $dbname;

        $dbconn = $this->dbconnect;

        if (!$dbconn) {
            $dbconn = mysql_connect($this->dbhost, $this->dbusername, $this->dbuserpass);
            if ($dbconn) {
                $this->dbconnect   = $dbconn;
                $this->server_info = mysql_get_server_info($dbconn);
                if (version_compare($this->server_info, '4.1', '>=')) {
                    $this->query = "SET names 'UTF8'";          // use UTF8 character set for this connection
                    $result = mysql_query($this->query, $dbconn) or trigger_error($this, E_USER_ERROR);
                    logSqlQuery ($dbname, null, $this->query);  // write query to log file, if option is turned on
                    $this->query = "SET SESSION sql_mode=CONCAT('ANSI_QUOTES,',@@sql_mode)";
                    $result = mysql_query($this->query, $dbconn) or trigger_error($this, E_USER_ERROR);
                    logSqlQuery ($dbname, null, $this->query);  // write query to log file, if option is turned on
                    $this->query = "SHOW VARIABLES LIKE 'character_set%'";
                    $result = mysql_query($this->query, $dbconn) or trigger_error($this, E_USER_ERROR);
                    while ($row = mysql_fetch_assoc($result)) {
                        $this->$row['Variable_name'] = $row['Value'];
                    } // while
                } // if
                $this->charset     = mysql_client_encoding($dbconn);
                $this->client_info = mysql_get_client_info();
                $this->host_info   = mysql_get_host_info($dbconn);
                if (version_compare($this->server_info, '4.0.6', '<')) {
                	trigger_error('Wrong version of MySQL - must be 4.0.6 or above', E_USER_ERROR);
                } // if
                $this->query = '';
            } // if
        } // if

        if (!$dbconn) {
            return FALSE;
        } // if

        if ($dbname) {
            if (!mysql_select_db($dbname, $dbconn)) {
                return FALSE;
            } // if
        } // if

        return TRUE;

    } // connect

    // ****************************************************************************
    function deleteRecord ($dbname, $tablename, $fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // build 'where' string using values for primary key
        $where = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (empty($where)) return;    // nothing to delete, so exit

        // build the query string and run it
        $this->query = "DELETE FROM $tablename WHERE $where";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = mysql_affected_rows($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $where, $fieldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        $this->query = '';

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteSelection ($dbname, $tablename, $selection)
    // delete a selection of records in a single operation.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = "DELETE FROM $tablename WHERE $selection";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_affected_rows($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $selection, array());
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        $this->query = '';

        return $count;

    } // deleteSelection

    // ****************************************************************************
    function fetchRow ($dbname, $result)
    // Fetch a row from the given result set (created with getData_serial() method).
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $row = mysql_fetch_assoc($result);
        if ($row) {
        	$array = array_change_key_case($row, CASE_LOWER);
        	return $array;
        } else {
            return false;
        } // if

    } // fetchRow

    // ****************************************************************************
    function free_result ($dbname, $resource)
    // release a resource created with getData_serial() method.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $result = mysql_free_result($resource);

        return $result;

    } // free_result

    // ****************************************************************************
    function getCount ($dbname, $tablename, $where)
    // get count of records that satisfy selection criteria in $where.
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        if (preg_match('/^(select )/ims', $where)) {
            // $where starts with 'SELECT' so use it as a complete query
            $this->query = $where;
        } else {
            // does not start with 'SELECT' so it must be a 'where' clause
            if (empty($where)) {
            	$this->query = "SELECT SQL_CALC_FOUND_ROWS * FROM $tablename LIMIT 1";
            } else {
                $where = $this->adjustWhere($where);
                $this->query = "SELECT SQL_CALC_FOUND_ROWS * FROM $tablename WHERE $where LIMIT 1";
            } // if
        } // if

        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        if (preg_match("/SQL_CALC_FOUND_ROWS /i", $this->query) == true) {
        	$result     = mysql_query('SELECT FOUND_ROWS()', $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $found_rows = mysql_fetch_row($result);
            $count      = $found_rows[0];
        } else {
            // if 'GROUP BY' was used then return the number of rows
            // (ignore GROUP BY if it is in a subselect)
            if (preg_match("/group by /i", $this->query) == true AND !preg_match("/\(.+group by.+\)/i", $this->query)) {
                $count = mysql_num_rows($result);
            } else {
                $query_data = mysql_fetch_row($result);
                $count = $query_data[0];
            } // if
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);
        $this->query = '';

        return $count;

    } // getCount

    // ****************************************************************************
    function getData ($dbname, $tablename, $where)
    // get data from a database table using optional 'where' criteria.
    // Results may be affected by $where and $pageno.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $pageno         = (int)$this->pageno;
        $rows_per_page  = (int)$this->rows_per_page;
        $this->numrows  = 0;
        if ($pageno < 1) {
        	$pageno = 1; // default to first page
        } // if
        $this->lastpage = $pageno;
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
            $search_array  = array(  "LEFT JOIN",   "RIGHT JOIN",   "CROSS JOIN");
            $replace_array = array("\nLEFT JOIN", "\nRIGHT JOIN", "\nCROSS JOIN");
            $from_str = str_replace($search_array, $replace_array, $from_str);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\n" .'WHERE ' .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "\n" ."GROUP BY $this->sql_groupby";
            if (preg_match("/ WITH ROLLUP/i", $this->sql_groupby)) {
            	$this->sql_orderby = null;
            } // if
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            $having_str = "\n" ."HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "\n" ."ORDER BY $this->sql_orderby $this->sql_orderby_seq";
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
                        $lock_str = 'LOCK IN SHARE MODE';
                        break;
                    case 'EX':
                        $lock_str = 'FOR UPDATE';
                        break;
                    default:
                        $lock_str = 'LOCK IN SHARE MODE';
                } // switch
                $this->row_locks = null;
            } // if
        } // if

        do {
            if ($pageno > $this->lastpage) {
                // requested page is out of range, so reset it
                $pageno = $this->lastpage;
            } // if

            // set the limit and offset values to retrieve the specified page number
            if ($rows_per_page > 0) {
                $limit_str = "\n" .'LIMIT ' .$rows_per_page .' OFFSET ' .($pageno - 1) * $rows_per_page;
            } else {
                $limit_str = '';
            } // if

            // build the query string and run it
            if (empty($this->sql_union)) {
                $this->query = "SELECT SQL_CALC_FOUND_ROWS $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str $limit_str $lock_str";
            } else {
                $this->query = "(SELECT SQL_CALC_FOUND_ROWS $select_str \nFROM $from_str $where_str $group_str $having_str $lock_str)"
                              ."\nUNION\n(".$this->sql_union.') '.unqualifyOrderBy($sort_str) .' ' .$limit_str;
                $this->sql_union = null;
            } // if
            //$result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $result = mysql_query($this->query, $this->dbconnect);
            if ($result === false) {
                if (mysql_errno($this->dbconnect) == 2006) {
                    // connection has been lost, so re-connect and retry
                    $this->dbconnect = false;
                    $save_query = $this->query;
                    $this->connect($dbname) or trigger_error($this, E_USER_ERROR);
                    $this->query = $save_query;
                    unset($save_query);
                    $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
                } else {
                    trigger_error($this, E_USER_ERROR);
                } // if
            } // if

            $result2    = mysql_query('SELECT FOUND_ROWS()', $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $found_rows = mysql_fetch_row($result2);
            $count      = $found_rows[0];

            $this->numrows = $count;

            if ($count == 0) {
                $this->lastpage = 0;
                $this->pageno   = 0;
            	break;
            } // if

            if ($rows_per_page > 0) {
                $this->lastpage = ceil($count/$rows_per_page);
                $this->pageno = $pageno;
            } else {
                $this->lastpage = 1;
                $this->pageno   = 1;
            } // if
        } while ($pageno > $this->lastpage); // requested page may be out of range

        // convert result set into a simple associative array for each row
        while ($row = mysql_fetch_assoc($result)) {
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        //$this->numrows = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        mysql_free_result($result);
        $this->query = '';

        return $array;

    } // getData

    // ****************************************************************************
    function getData_serial ($dbname, $tablename, $where, $rdc_limit=null, $rdc_offset=null)
    // Get data from a database table using optional 'where' criteria.
    // Return $result, not an array of data, so that individual rows can
    // be retrieved using the fetchRow() method.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $pageno         = (int)$this->pageno;
        $rows_per_page  = (int)$this->rows_per_page;
        $this->numrows  = 0;
        if ($pageno < 1) {
        	$pageno = 1; // default to first page
        } // if
        $this->lastpage = $pageno;

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
            $search_array  = array(  "LEFT JOIN",   "RIGHT JOIN",   "CROSS JOIN");
            $replace_array = array("\nLEFT JOIN", "\nRIGHT JOIN", "\nCROSS JOIN");
            $from_str = str_replace($search_array, $replace_array, $from_str);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\n" .'WHERE ' .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "\n" ."GROUP BY $this->sql_groupby";
            if (preg_match("/ WITH ROLLUP/i", $this->sql_groupby)) {
            	$this->sql_orderby = null;
            } // if
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            $having_str = "\n" ."HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "\n" ."ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        if (!is_null($rdc_limit) AND !is_null($rdc_offset)) {
        	$limit_str = "\n" .'LIMIT ' .$rdc_limit .' OFFSET ' .$rdc_offset;
        } elseif ($rows_per_page > 0) {
            $limit_str = "\n" .'LIMIT ' .$rows_per_page .' OFFSET ' .($pageno - 1) * $rows_per_page;
        } else {
            $limit_str = '';
        } // if

        // build the query string and run it
        $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str $limit_str";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $this->numrows = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        return $result;

    } // getData_serial

    // ****************************************************************************
    function getEnum ($dbname, $tablename, $fieldname)
    // get the contents of an ENUM field and return it as an array.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // obtain 'enum' values for the specified column
        $this->query = "SHOW COLUMNS FROM $tablename LIKE '$fieldname'";
        $result = mysql_query($this->query) or trigger_error($this, E_USER_ERROR);

        $query_data = mysql_fetch_array($result);

        // convert the 'enum' list into an array
        // 1st, extract everything between '(' and ')'
        if (preg_match("/('.*')/", $query_data['Type'], $enum)) {
            // 2nd, remove all single quotes
            $enum = str_replace("'", "", $enum[1]);
            // 3rd, insert dummy entry so that real entries start at 1
            $enum = ',' .$enum;
            // last, turn list into an indexed array
            $enum_array = explode(',', $enum);
        } // if

        mysql_free_result($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $enum);
        $this->query = '';

        return $enum_array;

    } // getEnum

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function getErrorNo ()
    // return number of last error.
    {
        $errno = mysql_errno();

        return $errno;

    } // getErrorNo

    // ****************************************************************************
    function getErrorString ()
    // return string containing details of last error
    {
        if (!empty($this->error_string)) {
            $string = $this->error_string;
            $this->error_string = null;
        } else {
            $string = mysql_error();
            if (!empty($string)) {
            	$string = 'MySQL: ' .$string;
            } // if
        } // if

        return $string;

    } // getErrorString

    // ****************************************************************************
    function getErrorString2 ()
    // return additional information.
    {
        if ($this->dbconnect) {
        	$string  = 'Host Info: ' .$this->host_info ;
            $string .= '<br>Server Version: ' .$this->server_info;
            $string .= '<br>Client Version: ' .$this->client_info;
            if (version_compare($this->server_info, '4.1', '>=')) {
                $string .= ', Character sets - client: '     .$this->character_set_client
                                         .', - connection: ' .$this->character_set_connection
                                         .', - database: '   .$this->character_set_database
                                         .', - server: '     .$this->character_set_server;
            } else {
                $string .= ', Client Encoding: ' .$this->charset;
            } // if
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
    function insertRecord ($dbname, $tablename, $fieldarray)
    // insert a record using the contents of $fieldarray.
    {
        $this->errors   = array();
        $this->warnings = array();

        $this->numrows = 0;  // record not inserted (yet)

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        foreach ($fieldspec as $field => $spec) {
            if (empty($fieldarray[$field])) {
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
            } // if
        } // foreach

        // find out if any field in the primary key has 'auto_increment' set
		$auto_increment = '';
		foreach ($this->primary_key as $pkey){
			if (isset($fieldspec[$pkey]['auto_increment'])) {
                $this->retry_on_duplicate_key = null;       // this feature cannot be used with auto_increment
			    if (!empty($fieldarray[$pkey]) AND $fieldarray[$pkey] > 0) {
			    	// value has been supplied manually, so do not auto-generate
			    } else {
    			    $auto_increment = $pkey;				// save name of field
    				unset($fieldarray[$auto_increment]);	// remove from data array
			    } // if
			} // if
		} // foreach
        if (empty($auto_increment)) {
            // not found in primary key, so look in other unique keys
            foreach ($this->unique_keys as $key) {
                foreach ($key as $ukey) {
                    if (isset($fieldspec[$ukey]['auto_increment'])) {
                        if (!empty($fieldarray[$ukey]) AND $fieldarray[$ukey] > 0) {
                            // value has been supplied manually, so do not auto-generate
                        } else {
                            $auto_increment = $ukey;                // save name of field
                            unset($fieldarray[$auto_increment]);    // remove from data array
                            break;
                        } // if
                    } // if
                } // foreach
            } // foreach
        } // if

		if (!empty($this->retry_on_duplicate_key)) {
            if (!array_key_exists($this->retry_on_duplicate_key, $fieldspec)) {
                // this field does not exist, so remove it
                $this->retry_on_duplicate_key = null;
            } // if
        } // if

        // build 'where' string using values for primary key
        $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (  empty($this->retry_on_duplicate_key)
        AND ( empty($auto_increment) AND empty($ukey)) OR (!empty($auto_increment) AND $auto_increment == $ukey)
           ) {
            // find out if a record with this primary key already exists
            $query = "SELECT count(*) FROM $tablename WHERE $primary_key";
            $count = $this->getCount($dbname, $tablename, $query);
            // is this primary key taken?
            if ($count <> 0) {
                if (is_True($this->no_duplicate_error)) {
                    // exit without setting an error
                    return $fieldarray;

                } elseif (is_True($this->update_on_duplicate_key)) {
                    // switch to 'update'
                    $old_array = where2array($primary_key);
                    $fieldarray = $this->updateRecord ($dbname, $tablename, $fieldarray, $old_array);
                    return $fieldarray;

                } else {
                    // set error message for each field within this key
                    foreach ($this->primary_key as $fieldname) {
                        $this->errors[$fieldname] = getLanguageText('sys0002'); // 'A record already exists with this ID.'
                    } // foreach
                    $this->query = $query;  // save this in case trigger_error() is called
                } // if
                return $fieldarray;
            } // if
        } // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where = $this->buildKeyString ($fieldarray, $key);
                if (!empty($where)) {
                    $query = "SELECT count(*) FROM $tablename WHERE $where";
                    $count = $this->getCount($dbname, $tablename, $query);
                    if ($count <> 0) {
                        if (is_True($this->no_duplicate_error)) {
    	                    // exit without setting an error
    	                    return $fieldarray;
    	                } else {
                            // set error message for each field within this key
                            foreach ($key as $fieldname) {
                                $this->errors[$fieldname] = getLanguageText('sys0003'); // 'A record already exists with this key.'
                            } // foreach
                            $this->query = $query;  // save this in case trigger_error() is called
                            return $fieldarray;
    	                } // if
                    } // if
                } // if
            } // foreach
        } // if

        $repeat       = false;
        $repeat_count = 0;
        $pattern1 = '/(integer|decimal|numeric|float|real|double)/i';
        $pattern2 = '/^\w+[ ]*\(.*\)$/imsx';  // function(...)
        do {
            // insert this record into the database
            $this->query = "INSERT INTO $tablename SET ";
            foreach ($fieldarray as $item => $value) {
                //if ((empty($fieldspec[$item]) OR !array_key_exists('required', $fieldspec[$item]))
                //AND (is_null($value) OR strlen($value) == 0 OR strtoupper(trim($value)) == 'NULL')) {
                if (is_null($value) OR strtoupper(trim($value)) == 'NULL') {
                    $this->query .= "`$item`=NULL, ";
                } elseif (strlen($value) == 0 AND isset($fieldspec[$item]['type']) AND preg_match($pattern1, $fieldspec[$item]['type'])) {
					$this->query .= "`$item`=NULL, ";  // cannot use empty string for numeric fields, so use NULL instead
                } elseif (is_array($this->allow_db_function) AND in_array($item, $this->allow_db_function) AND preg_match($pattern2, $value)) {
                    // this is a function, so change to the new value (without enclosing quotes)
                    $update .= "`$item`=$value, ";
                } else {
                    $this->query .= "`$item`='" .mysql_real_escape_string($this->dbconnect, $value) ."', ";
                } // if
            } // foreach

            // remove trailing comma
            $this->query = rtrim($this->query, ', ');
            if (substr($this->query, -4) == ' SET') {
                // no field list, so remove 'SET'
                $this->query = substr($this->query, 0, strlen($this->query)-4);
            } // if

            //$result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $result = mysql_query($this->query, $this->dbconnect);
            if ($result === false) {
                $errno = mysql_errno($this->dbconnect);
                if ($errno == 2006) {
                    // connection has been lost, so re-connect and try again
                    $this->dbconnect = false;
                    $this->connect($this->dbname) or trigger_error($this, E_USER_ERROR);
                    $repeat = true;

                } elseif ($errno == 1062 AND !empty($this->retry_on_duplicate_key)) {
                    // increment the specified field and try again
                    $fieldarray[$this->retry_on_duplicate_key]++;
                    $repeat = true;
                    $repeat_count++;
                    if ($repeat_count > 5) {
                        // too many retries, so turn this feature off
                        $this->retry_on_duplicate_key = null;
                    } // if

                } elseif ($errno == 1062 AND !empty($this->update_on_duplicate_key)) {
                    // switch to 'update'
                    $old_array = where2array($primary_key);
                    $fieldarray = $this->updateRecord ($dbname, $tablename, $fieldarray, $old_array);
                    return $fieldarray;

                } elseif ($errno == 1062 AND is_True($this->no_duplicate_error)) {
                    // this is a duplicate, but don't fail
                    $this->numrows = 0;

                } else {
                    trigger_error($this, E_USER_ERROR);
                } // if
            } else {
                $repeat = false;
                $this->numrows = 1;  // record has been inserted
            } // if
        } while ($repeat == true);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query);

		if (!empty($auto_increment)) {
			// obtain the last value used by auto_increment
			$fieldarray[$auto_increment] = mysql_insert_id($this->dbconnect);
			$primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);
		} // if

        if ($this->numrows > 0) {
            if ($this->audit_logging) {
            	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        			// do nothing
		        } else {
	                $auditobj =& RDCsingleton::getInstance('audit_tbl');
	                // add record details to audit database
	                $auditobj->auditInsert($dbname, $tablename, $this->fieldspec, $primary_key, $fieldarray);
	                $this->errors = array_merge($auditobj->getErrors(), $this->errors);
				} // if
            } // if
        } // if

        $this->numrows = 1;  // record has been inserted
        $this->query = '';

        return $fieldarray;

    } // insertRecord

    // ****************************************************************************
    function multiQuery ($dbname, $tablename, $query_array)
    // perform multiple queries in a single step
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $single_step = true;  // special code to debug each query separately
        if ($single_step) {
            // execute these statements one at a time
            foreach ($query_array as $query_part) {
                $this->query = $query_part;
                $result = mysql_query($this->query, $this->dbconnect);
                if (!$result) {
                    trigger_error($this, E_USER_ERROR);
                } // if
            } // foreach
            if (count($query_array) == 1) {
                // only a single query, so return result in full
                if (is_bool($result)) {
                    return $result;
                } else {
                    $array = array();
                    while ($row = mysql_fetch_assoc($result)) {
                        $array[] = array_change_key_case($row, CASE_LOWER);
                    } // while
                    mysql_free_result($result);
                    return $array;
                } // if
            } // if
            return true;
        } // if

        return $result;

    } // multiQuery

    // ****************************************************************************
    function rollback ($dbname)
    // rollback this transaction due to some sort of error.
    {
        $this->errors = array();

        if (!$this->dbconnect) {
            // not connected yet, so do nothing
            return FALSE;
        } // if

        $this->query = 'ROLLBACK';
        //$result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
        if (!$result = mysql_query($this->query, $this->dbconnect)) {
            if (mysql_errno($this->dbconnect) == 1196) {
                // Warning: Some non-transactional changed tables couldn't be rolled back
            } else {
                trigger_error($this, E_USER_ERROR);
            } // if
        } // if

        $this->query = 'UNLOCK TABLES';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'ROLLBACK; UNLOCK TABLES');
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        	// do nothing
	    } else {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            $result = $auditobj->close();
        } // if

        return $result;

    } // rollback

    // ****************************************************************************
    function selectDB ($dbname)
    // select a different database via the current connection.
    {

		if ($this->dbconnect) {
		    mysql_select_db($dbname, $this->dbconnect);
		} // if
        return true;

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
    function startTransaction ($dbname)
    // start a new transaction, to be terminated by either COMMIT or ROLLBACK.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = 'SET AUTOCOMMIT=0';

        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'START TRANSACTION (SET AUTOCOMMIT=0)');
        $this->query = '';

        if (!empty($this->table_locks)) {
        	$result = $this->_setDatabaseLock($this->table_locks);
        } // if

        return $result;

    } // startTrasaction

    // ****************************************************************************
    function updateRecord ($dbname, $tablename, $fieldarray, $oldarray, $where=null)
    // update a record using the contents of $fieldarray.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        $this->numrows = 0;

        if (strlen($where) == 0) {
            // build 'where' string using values for primary key
            $where = $this->buildKeyString ($oldarray, $this->primary_key);
        } else {
        	// use $where as supplied, and remove pkey specs so their values can be changed
        	$this->unique_keys[] = $this->primary_key;  // but still check for duplicate value
        	$this->primary_key = array();
        } // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where1 = $this->buildKeyString ($oldarray, $key);
                $where2 = $this->buildKeyString ($fieldarray, $key);
                if (strlen($where2) > 0 AND $where1 <> $where2) {
                    // key has changed, so check for uniqueness
                    $query = "SELECT count(*) FROM $tablename WHERE $where2";
                    $count = $this->getCount($dbname, $tablename, $query);
                    if ($count <> 0) {
                        // set error message for each field within this key
                        foreach ($key as $fieldname) {
                            $this->errors[$fieldname] = getLanguageText('sys0003'); // 'A record already exists with this key.'
                        } // foreach
                        $this->query = $query;  // save this in case trigger_error() is called
                        return $fieldarray;
                    } // if
                } // if
            } // foreach
        } // if

        // remove any values that have not changed
        $fieldarray = getChanges($fieldarray, $oldarray);

        if (empty($fieldarray)) {
            // nothing to update, so return now
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
                        case 'timestamp':
    					    if (empty($fieldarray[$field])) {
    						    $fieldarray[$field] = getTimeStamp();
    					    } // if
    						break;
    					case 'date':
    					    if (empty($fieldarray[$field])) {
    						    $fieldarray[$field] = getTimeStamp('date');
    					    } // if
    						break;
    					case 'time':
    					    if (empty($fieldarray[$field])) {
						        $fieldarray[$field] = getTimeStamp('time');
    					    } // if
						    break;
					    case 'string':
					        if (empty($fieldarray[$field])) {
    						    $fieldarray[$field] = $_SESSION['logon_user_id'];
					        } // if
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

        $repeat = false;
        $pattern1 = '/(integer|decimal|numeric|float|real|double)/i';
        $pattern2 = '/^\w+[ ]*\(.*\)$/ims';  // function(...)
        do {
            // build update string from non-pkey fields
            $update = '';
            foreach ($fieldarray as $item => $value) {
                // use this item if it IS NOT part of primary key
                if (!in_array($item, $this->primary_key)) {
                    if (is_null($value) OR strtoupper(trim($value)) == 'NULL') {
                        // null entries are set to NULL, not '' (there is a difference!)
                        $update .= "`$item`=NULL,";
                    } elseif (preg_match($pattern1, $fieldspec[$item]['type'], $match)) {
                        // do not enclose numbers in quotes (this also allows 'value=value+1'
                        if (strlen($value) == 0) {
                    	    $update .= "`$item`=NULL,";
                        } else {
                            $update .= "`$item`=$value,";
                        } // if
                    } elseif (is_array($this->allow_db_function) AND in_array($item, $this->allow_db_function) AND preg_match($pattern2, $value)) {
                        // this is a function, so change to the new value (without enclosing quotes)
                        //$update .= "`$item`=" .mysql_real_escape_string($value, $this->dbconnect) .", ";
                        $update .= "`$item`=$value, ";
                    } else {
                        // change to the new value (with enclosing quotes)
                        $update .= "`$item`='" .mysql_real_escape_string($value, $this->dbconnect) ."', ";
                    } // if
                } // if
            } // foreach

            // strip trailing comma
            $update = rtrim($update, ', ');

            // append WHERE clause to SQL query
            $this->query = "UPDATE $tablename SET $update WHERE $where";
            //$result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $result = mysql_query($this->query, $this->dbconnect);
            if ($result === false) {
                $errno = mysql_errno($this->dbconnect);
                if ($errno == 2006) {
                    // connection has been lost, so re-connect and try again
                    $this->dbconnect = false;
                    $this->connect($this->dbname) or trigger_error($this, E_USER_ERROR);
                    $repeat = true;
                } // if
            } // if
        } while ($repeat == true);

        // get count of affected rows as there may be more than one
        $this->numrows = mysql_affected_rows($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditUpdate($dbname, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        $this->query = '';

        return $fieldarray;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($dbname, $tablename, $replace, $selection)
    // update a selection of records in a single operation.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = "UPDATE $tablename SET $replace WHERE $selection";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_affected_rows($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        if ($count > 0) {
            if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        			// do nothing
		        } else {
	                $auditobj =& RDCsingleton::getInstance('audit_tbl');
	                // add record details to audit database
	                $auditobj->auditUpdateSelection($dbname, $tablename, $this->fieldspec, $selection, $replace);
	                $this->errors = array_merge($auditobj->getErrors(), $this->errors);
				} // if
            } // if
        } // if

        $this->query = '';

        return $count;

    } // updateSelection

    // ****************************************************************************
    // the following are DDL (Data Definition Language) methods
    // ****************************************************************************
    function ddl_getColumnSpecs ()
    // return the array of column specifications.
    {
        $colspecs['varchar']    = array('name' => 'VARCHAR',
                                        'type' => 'string',
                                        'size' => 255);
        $colspecs['char']       = array('name' => 'CHAR',
                                        'type' => 'string',
                                        'size' => 255);
        $colspecs['decimal']    = array('name' => 'DECIMAL',
                                        'type' => 'numeric');
        $colspecs['boolean']    = array('name' => 'BOOLEAN',
                                        'type' => 'boolean');
        $colspecs['tinyint']    = array('name' => 'TINYINT',
                                        'type' => 'integer',
                                        'minvalue' => -128,
                                        'maxvalue' => 127);
        $colspecs['smallint']   = array('name' => 'SMALLINT',
                                        'type' => 'integer',
                                        'minvalue' => -32768,
                                        'maxvalue' => 32767);
        $colspecs['mediumint']  = array('name' => 'MEDIUMINT',
                                        'type' => 'integer',
                                        'minvalue' => -8388608,
                                        'maxvalue' => 8388607);
        $colspecs['int']        = array('name' => 'INT',
                                        'type' => 'integer',
                                        'minvalue' => -2147483648,
                                        'maxvalue' => 2147483647);
        $colspecs['integer']    = array('name' => 'INTEGER',
                                        'type' => 'integer');
        $colspecs['bigint']     = array('name' => 'BIGINT',
                                        'type' => 'integer',
                                        'minvalue' => '-9223372036854775808',
                                        'maxvalue' => '9223372036854775807');
        $colspecs['float']      = array('name' => 'FLOAT',
                                        'type' => 'float',
                                        'size' => 22);
        $colspecs['double']     = array('name' => 'DOUBLE',
                                        'type' => 'float',
                                        'size' => 22);
        $colspecs['date']       = array('name' => 'DATE',
                                        'type' => 'date',
                                        'size' => 12);
        $colspecs['datetime']   = array('name' => 'DATETIME',
                                        'type' => 'datetime',
                                        'size' => 20);
        $colspecs['time']       = array('name' => 'TIME',
                                        'type' => 'time',
                                        'size' => 10);
        $colspecs['timestamp']  = array('name' => 'TIMESTAMP',
                                        'type' => 'timestamp',
                                        'size' => 20);
        $colspecs['year']       = array('name' => 'YEAR',
                                        'type' => 'numeric',
                                        'size' => 4,
                                        'minvalue' => 1901,
                                        'maxvalue' => 2155);
        $colspecs['tinytext']   = array('name' => 'TINYTEXT',
                                        'type' => 'string',
                                        'size' => 255);
        $colspecs['text']       = array('name' => 'TEXT',
                                        'type' => 'string',
                                        'size' => 65535);
        $colspecs['mediumtext'] = array('name' => 'MEDIUMTEXT',
                                        'type' => 'string',
                                        'size' => 16777215);
        $colspecs['longtext']   = array('name' => 'LONGTEXT',
                                        'type' => 'string',
                                        'size' => 4294967295);
        $colspecs['tinyblob']   = array('name' => 'TINYBLOB',
                                        'type' => 'blob',
                                        'size' => 255);
        $colspecs['blob']       = array('name' => 'BLOB',
                                        'type' => 'blob',
                                        'size' => 65535);
        $colspecs['mediumblob'] = array('name' => 'MEDIUMBLOB',
                                        'type' => 'blob',
                                        'size' => 16777215);
        $colspecs['longblob']   = array('name' => 'LONGBLOB',
                                        'type' => 'blob',
                                        'size' => 4294967295);
        $colspecs['enum']       = array('name' => 'ENUM',
                                        'type' => 'enum',
                                        'size' => 255);
        $colspecs['set']        = array('name' => 'SET',
                                        'type' => 'array',
                                        'size' => 255);
        $colspecs['varbinary']  = array('name' => 'VARBINARY',
                                        'type' => 'blob',
                                        'size' => 255);

        return $colspecs;

    } // ddl_getColumnSpecs

    // ****************************************************************************
    function ddl_showColumns ($dbname, $tablename)
    // obtain a list of column names within the selected database table.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $out_array = array();

        // build the query string and run it
        $this->query = 'SHOW COLUMNS FROM "' .$tablename .'" FROM "' .$dbname .'"';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        $colspecs = $this->ddl_getColumnSpecs();

        // convert result set into an associative array for each row
        while ($row = mysql_fetch_assoc($result)) {
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
                	case 'field':
                		$columnarray['column_id'] = $value;
                		break;
                	case 'type':
                        unset($precision, $scale, $minvalue, $maxvalue);
                        if (preg_match('/^(enum|set)/i', $value, $regs)) {
                            $columnarray['col_type'] = $regs[0];
                            $pos1 = strpos($value, '(');
                            $value = substr($value, $pos1);
                            // include a space after each comma otherwise the string is
                            // treated as a single word in the HTML output
                            $value = str_replace("','", "', '", $value);
                            $columnarray['col_values'] = trim($value, '()');
                        // look for 'type(n,m) other'
                        } elseif (preg_match('/\(.+\)/', $value, $regs)) {
                            list($type, $other) = explode($regs[0], $value);
                            $size               = trim($regs[0], '()');
                            $columnarray['col_type']    = $type;
                            $columnarray['col_maxsize'] = $size;

                            // look for 'unsigned' and 'zerofill' in $other
                            if (preg_match('/unsigned/i', $other)) {
                                $columnarray['col_unsigned'] = TRUE;
                            } // if
                            if (preg_match('/zerofill/i', $other)) {
                                $columnarray['col_zerofill_bwz'] = 'ZF';
                            } // if

                            if (strpos($size, ',')) {
                                // split $size into $precision and $scale
                                list($precision, $scale) = explode(',', $size);
                                $columnarray['col_precision'] = $precision;
                                $columnarray['col_scale']     = $scale;
                                $columnarray['col_maxsize']   = $precision + 1;
                                if ($scale > 0) {
                                    $columnarray['col_maxsize'] = $columnarray['col_maxsize'] + 1;
                                } // if
                            } // if

                            $specs = $colspecs[$type];
                            // look for minimum value in $colspecs
                            if (isset($specs['minvalue'])) {
                                $minvalue = $specs['minvalue'];
                            } else {
                                if (isset($precision)) {
                                    // minvalue includes negative sign
                                    if ($precision > 1) {
                                        $minvalue = '-' . str_repeat('9', $precision-1);
                                    } else {
                                        $minvalue = '-' . str_repeat('9', $precision);
                                    } // if
                                    if ($scale > 0) {
                                        // adjust values to include decimal places
                                        $minvalue = $minvalue / pow(10, $scale);
                                    } // if
                                } // if
                            } // if
                            if (isset($minvalue)) {
                                if (preg_match('/unsigned/i', $other)) {
                                    $minvalue = 0;
                                } // if
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
                                if (preg_match('/unsigned/i', $other)) {
                                    if ($specs['type']  == 'integer') {
                                        $maxvalue = ($specs['maxvalue'] * 2) +1;
                                        //$maxvalue = number_format(($specs['maxvalue'] * 2) +1, 0, '', '');
                                    } // if
                                } // if
                                $columnarray['col_maxvalue'] = $maxvalue;
                            } // if

                        } else {
                            // look for 'unsigned' and 'zerofill' after the type
                            if (preg_match('/unsigned/i', $value, $regs)) {
                                $value = str_replace($regs[0], '', $value);
                                $value = trim($value);
                                $columnarray['col_unsigned'] = TRUE;
                                $columnarray['col_minvalue'] = 0;
                            } // if
                            if (preg_match('/zerofill/i', $value, $regs)) {
                                $value = str_replace($regs[0], '', $value);
                                $value = trim($value);
                                $columnarray['col_zerofill_bwz'] = 'ZF';
                            } // if
                            // no size information, so output 'as-is'
                            $columnarray['col_type'] = $value;
                            if (isset($colspecs[$value]['size'])) {
                                // use default size for this column type
                                $columnarray['col_maxsize'] = $colspecs[$value]['size'];
                            } // if
                        } // if

                        if ($columnarray['col_type'] == 'char') {
                            if ($columnarray['col_maxsize'] == 1) {
                                // this can also be used as 'boolean'
                                $columnarray['col_type_native'] = $columnarray['col_type'].',boolean';
                            } // if
                        } elseif (preg_match('/int/i', $columnarray['col_type'])) {
                            // this can also be used as 'boolean'
                            $columnarray['col_type_native'] = $columnarray['col_type'].',boolean';
                        } // if

                        if (!isset($columnarray['col_type_native'])) {
                            $columnarray['col_type_native'] = $columnarray['col_type'];
                        } // if

                        if ($columnarray['col_type'] == 'decimal' AND $scale == 0) {
                        	$columnarray['col_type'] = 'integer';
                        } // if

                        break;
                    case 'null':
                        // is this column allowed to be NULL?
                		if (is_True($value)) {
                            $columnarray['col_null'] = 'Y';
                        } else {
                            $columnarray['col_null'] = 'N';
                        } // if
                        break;
                    case 'extra':
                        if (preg_match('/auto_increment/i', $value)) {
                            $columnarray['col_auto_increment'] = TRUE;
                        } // if;
                        break;
                	default:
                	    // default is to prefix column name with 'col_'
                		$columnarray['col_' .strtolower($item)] = $value;
                } // switch
            } // foreach
            if (!isset($columnarray['col_maxsize'])) {
            	if (isset($colspecs[$columnarray['col_type']]['size'])) {
            		$columnarray['col_maxsize'] = $colspecs[$columnarray['col_type']]['size'];
            	} // if
            } // if
            $out_array[] = $columnarray;
        } // while

        mysql_free_result($result);

        return $out_array;

    } // ddl_showColumns

    // ****************************************************************************
    function ddl_showDatabases ($dbprefix=null)
    // obtain a list of existing database names.
    {
        // connect to database
        $this->connect($this->dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        if (empty($dbprefix)) {
        	$this->query = 'SHOW DATABASES';
        } else {
            $this->query = "SHOW DATABASES LIKE '$dbprefix%'";
        } // if
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery (null, null, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = mysql_fetch_row($result)) {
            $array[] = $row[0];
        } // while

        mysql_free_result($result);

        return $array;

    } // ddl_showDatabases

    // ****************************************************************************
    function ddl_showTables ($dbname)
    // obtain a list of tables within the specified database.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it (enclose name in double quotes)
        $this->query = 'SHOW TABLES FROM "' .$dbname .'"';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = mysql_fetch_row($result)) {
            $array[] = $row[0];
        } // while

        mysql_free_result($result);

        return $array;

    } // ddl_showTables

    // ****************************************************************************
    function ddl_showTableKeys ($dbname, $tablename)
    // obtain a list of keys (indexes) for this table.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = 'SHOW INDEX FROM "' .$tablename .'"';
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = mysql_fetch_assoc($result)) {
            $keyarray = array();
            $row = array_change_key_case($row, CASE_LOWER);
            foreach ($row as $item => $value) {
                if ($item == 'column_name') {
                    $keyarray['column_id'] = strtolower($value);
                } elseif ($item == 'non_unique') {
                    if ($value == 0) {
                        $keyarray['is_unique'] = TRUE;
                    } else {
                        $keyarray['is_unique'] = FALSE;
                    } // if
                } else {
                    $keyarray[$item] = $value;
                } // if
            } // foreach
            $array[] = $keyarray;
        } // while

        mysql_free_result($result);

        return $array;

    } // ddl_showTableKeys

    // ****************************************************************************
    function _setDatabaseLock ($table_locks)
    // lock database tables identified in $string
    {
        foreach ($table_locks as $mode => $mode_array) {
            foreach ($mode_array as $table) {
                if (empty($string)) {
                    $string = "$table $mode";
                } else {
                    $string .= ", $table $mode";
                } // if
            } // foreach
        } // foreach

        if (!empty($string)) {
            $this->query = 'SET AUTOCOMMIT=0';
            $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            $this->query = "LOCK TABLES $string";
            $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery (null, null, $this->query);
            $this->query = '';
            return $result;
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
    function __toString()
    // this is for use by the error handler
    {
        return $this->getErrorString();
    } // __toString

// ****************************************************************************
} // end class
// ****************************************************************************

?>
