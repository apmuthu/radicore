<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class mysql
// this version is for MySQL (using the standard functions)
{
    // member variables
    var $client_info;           // client info (version number)
    var $host_info;             // host info (connection)
    var $server_info;           // server info (version number)
    var $charset;               // character set

    var $audit_logging;         // yes/no switch
    var $dbname;                // database name
    var $errors;                // array of errors
    var $error_string;          //
    var $fieldspec = array();   // field specifications (see class constructor)
    var $lastpage;              // last available page number in current query
    var $numrows;               // number of rows retrieved
    var $pageno;                // requested page number
    var $primary_key = array(); // array of primary key names
    var $rows_per_page;         // page size for multi-row forms
    var $row_locks;             // SH=shared, EX=exclusive
    var $table_locks;           // array of tables to be locked
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
    function mysql ($dbname=null)
    {
        if (!empty($dbname)) {
            $result = $this->connect($dbname) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = TRUE;
        } // if

    	if (!class_exists('audit_tbl')) {
    	    // obtain definition of the audit_tbl class
    		require_once 'classes/audit_tbl.class.inc';
    	} // if

        return $result;

    } // mysql

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

        if (class_exists('audit_tbl')) {
        	$auditobj =& singleton::getInstance('audit_tbl');
            $result = $auditobj->close();
        } // if

        return $result;

    } // commit

    // ****************************************************************************
    function connect ($dbname)
    // establish a connection to the database
    {
        //DebugBreak();
        global $dbhost, $dbusername, $dbuserpass, $dbprefix;

        if (!empty($dbprefix)) {
			// prefix may be different on different servers
            $dbname = $dbprefix .$dbname;
        } // if

        static $dbconn;

        $this->errors = array();
        $this->dbname = $dbname;

        if (!$dbconn) {
            $dbconn = mysql_connect($dbhost, $dbusername, $dbuserpass);
            if ($dbconn) {
                $this->charset     = mysql_client_encoding($dbconn);
                $this->client_info = mysql_get_client_info();
                $this->host_info   = mysql_get_host_info($dbconn);
                $this->server_info = mysql_get_server_info($dbconn);
            } // if
        } // if

        if (!$dbconn) {
            return FALSE;
        } elseif (!mysql_select_db($dbname)) {
            return FALSE;
        } else {
            $this->dbconnect = $dbconn;
            return TRUE;
        } // if

    } // connect

    // ****************************************************************************
    function deleteRecord ($dbname, $tablename, $fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // build 'where' string using values for primary key
        $where = array2where($fieldarray, $this->primary_key);

        if (empty($where)) return;    // nothing to delete, so exit

        // build the query string and run it
        $this->query = "DELETE FROM $tablename WHERE $where";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = mysql_affected_rows($this->dbconnect);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $where, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteSelection ($dbname, $tablename, $selection)
    // delete a selection of records in a single operation.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = "DELETE FROM $tablename WHERE $selection";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_affected_rows($this->dbconnect);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $selection, array());
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $count;

    } // deleteSelection

    // ****************************************************************************
    function fetchRow ($dbname, $result)
    // Fetch a row from the given result set (reated with getData_batch() method).
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $row   = mysql_fetch_assoc($result);
        $array = array_change_key_case($row, CASE_LOWER);

        return $array;

    } // fetchRow

    // ****************************************************************************
    function getCount ($dbname, $tablename, $where)
    // get count of records that satisfy selection criteria in $where.
    {
        //DebugBreak();
        if (eregi('^(select )', $where)) {
            // $where starts with 'SELECT' so use it as a complete query
            $this->query = $where;
        } else {
            // does not start with 'SELECT' so it must be a 'where' clause
            $this->query = "SELECT count(*) FROM $tablename WHERE $where";
        } // if

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);
        $query_data = mysql_fetch_row($result);

        // if 'GROUP BY' was used then return the number of rows
        if (eregi("group by ", $this->query)) {
            return mysql_num_rows($result);
        } else {
            return $query_data[0];
        } // if

    } // getCount

    // ****************************************************************************
    function getData ($dbname, $tablename, $where)
    // get data from a database table using optional 'where' criteria.
    // Results may be affected by $where and $pageno.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $pageno         = $this->pageno;
        $rows_per_page  = $this->rows_per_page;
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
            $this->numrows = $this->getCount($dbname, $tablename, $this->query);

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
        if ($pageno == '' OR $pageno <= '1') {
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
                        $lock_str = 'LOCK IN SHARE MODE';
                        break;
                    case 'EX':
                        $lock_str = 'FOR UPDATE';
                        break;
                    default:
                        $lock_str = null;
                } // switch
                $this->row_locks = null;
            } // if
        } // if

        // build the query string and run it
        $this->query = "SELECT $select_str FROM $from_str $where_str $group_str $having_str $sort_str $limit_str $lock_str";
        if (!$result = mysql_query($this->query, $this->dbconnect)) {
            trigger_error($this, E_USER_ERROR);
        } // if

        // convert result set into a simple associative array for each row
        while ($row = mysql_fetch_assoc($result)) {
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        if ($rows_per_page == 0) {
            $this->numrows = mysql_num_rows($result);
        } // if

        mysql_free_result($result);

        return $array;

    } // getData

    // ****************************************************************************
    function getData_batch ($dbname, $tablename, $where)
    // Get data from a database table using optional 'where' criteria.
    // Return $result, not an array of data, so that individual rows can
    // be retrieved using the fetchRow() method.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

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
        if (!$result = mysql_query($this->query, $this->dbconnect)) {
            trigger_error($this, E_USER_ERROR);
        } // if

        $this->numrows = mysql_num_rows($result);

        return $result;

    } // getData_batch

    // ****************************************************************************
    function getEnum ($dbname, $tablename, $fieldname)
    // get the contents of an ENUM field and return it as an array.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // obtain 'enum' values for the specified column
        $this->query = "SHOW COLUMNS FROM $tablename LIKE '$fieldname'";
        $result = mysql_query($this->query) or trigger_error($this, E_USER_ERROR);

        $query_data = mysql_fetch_array($result);

        // convert the 'enum' list into an array
        // 1st, extract everything between '(' and ')'
        if (eregi("('.*')", $query_data['Type'], $enum)) {
            // 2nd, remove all single quotes
            $enum = ereg_replace("'", "", $enum[1]);
            // 3rd, insert dummy entry so that real entries start at 1
            $enum = ',' .$enum;
            // last, turn list into an indexed array
            $enum = explode(',', $enum);
        } // if

        mysql_free_result($result);

        return $enum;

    } // getEnum

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function getErrorString ()
    // return string containing details of last error
    {
        if (!empty($this->error_string)) {
            $string = $this->error_string;
            $this->error_string = null;
        } else {
            $string = 'MySQL error: ' .mysql_errno() .' : ' .mysql_error();
        } // if

        return $string;

    } // getErrorString

    // ****************************************************************************
    function getFunctionID ()
    // return the function identifier for this class.
    {
        return 'mysql';

    } // getFunctionID

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
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

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

        // find out if any field in the primary key has 'auto_increment' set
		$auto_increment = '';
		foreach ($this->primary_key as $pkey){
			if (isset($fieldspec[$pkey]['auto_increment'])) {
			    $auto_increment = $pkey;				// save name of field
				unset($fieldarray[$auto_increment]);	// remove from data array
			} // if
		} // foreach

		if (empty($auto_increment)) {
		    // build 'where' string using values for primary key
	        $where = NULL;
	        foreach ($fieldarray as $item => $value) {
	            // require this item if it IS part of primary key
	            if (in_array($item, $this->primary_key)) {
	                $where .= "$item='$value' AND ";
	            } // if
	        } // foreach

	        // remove trailing ' AND '
	        $where = rtrim($where, ' AND ');

	        // find out if a record with this primary key already exists
	        $this->query = "SELECT count(*) FROM $tablename WHERE $where";
	        $count = $this->getCount($dbname, $tablename, $this->query);

	        $pkey = $where;

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
                $where = NULL;
                foreach ($key as $fieldname) {
                    if (empty($where)) {
                        $where  = "$fieldname='{$fieldarray[$fieldname]}'";
                    } else {
                        $where .= " AND $fieldname='{$fieldarray[$fieldname]}'";
                    } // if
                } // foreach
                $this->query = "SELECT count(*) FROM $tablename WHERE $where";
                $count = $this->getCount($dbname, $tablename, $this->query);
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
        $this->query = "INSERT INTO $tablename SET ";
        foreach ($fieldarray as $item => $value) {
            if (isset($value)) {
                $this->query .= "$item='$value', ";
            } else {
                $this->query .= "$item=NULL, ";
            } // if
        } // foreach

        // remove trailing comma
        $this->query = rtrim($this->query, ', ');
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

		if (!empty($auto_increment)) {
			// obtain the last value used by auto_increment
			$fieldarray[$auto_increment] = mysql_insert_id($this->dbconnect);
			$primary_key = $auto_increment .'=' .$fieldarray[$auto_increment];
		} // if

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditInsert($dbname, $tablename, $this->fieldspec, $primary_key, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // insertRecord

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

        $auditobj =& singleton::getInstance('audit_tbl');
        $result = $auditobj->close();

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
    function setRowLocks ($level=null)
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

        if (!empty($this->table_locks)) {
        	$result = $this->_setDatabaseLock($this->table_locks);
        } // if

        $this->query = 'SET AUTOCOMMIT=0';

        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        return $result;

    } // startTrasaction

    // ****************************************************************************
    function updateRecord ($dbname, $tablename, $fieldarray, $oldarray)
    // update a record using the contents of $fieldarray.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

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

        // build 'where' string using values for primary key
        $where = array2where($oldarray, $this->primary_key);

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where1 = NULL;   // for original values
                $where2 = NULL;   // for changed values
                foreach ($key as $fieldname) {
                    if (empty($where1)) {
                        $where1  = "$fieldname='" .addslashes(stripcslashes($oldarray[$fieldname])) ."'";
                        $where2  = "$fieldname='" .addslashes(stripslashes($fieldarray[$fieldname])) ."'";
                    } else {
                        $where1 .= " AND $fieldname='" .addslashes(stripcslashes($oldarray[$fieldname])) ."'";
                        $where2 .= " AND $fieldname='" .addslashes(stripslashes($fieldarray[$fieldname])) ."'";
                    } // if
                } // foreach
                if ($where1 <> $where2) {
                    // key has changed, so check for uniqueness
                    $this->query = "SELECT count(*) FROM $tablename WHERE $where2";
                    $count = $this->getCount($dbname, $tablename, $this->query);
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
    					default:
    						// do nothing
    				} // switch
                } // if
            } // foreach
        } // if

        // build update string from non-pkey fields
        $update = NULL;
        foreach ($fieldarray as $item => $value) {
            // require this item if it IS NOT part of primary key
            if (!in_array($item, $this->primary_key)) {
                if (is_null($value)) {
                    // null entries are set to NULL, not '' (there is a difference!)
                    $update .= "$item=NULL,";
                } else {
                    // change to the new value
                    $update .= "$item='$value', ";
                } // if
            } // if
        } // foreach

        // strip trailing comma
        $update = rtrim($update, ', ');

        // append WHERE clause to SQL query
        $this->query = "UPDATE $tablename SET $update WHERE $where";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = mysql_affected_rows($this->dbconnect);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditUpdate($dbname, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($dbname, $tablename, $replace, $selection)
    // update a selection of records in a single operation.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = "UPDATE $tablename SET $replace WHERE $selection";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $count = mysql_affected_rows($this->dbconnect);

        if ($this->audit_logging) {
            $auditobj =& singleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditUpdateSelection($dbname, $tablename, $this->fieldspec, $selection, $replace);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $count;

    } // updateSelection

    // ****************************************************************************
    // the following are DDL (Data Definition Language) methods
    // ****************************************************************************
    function ddl_getColumnSpecs ()
    // return the array of column specifications.
    {
        //DebugBreak();
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
        $colspecs['bigint']     = array('name' => 'BIGINT',
                                        'type' => 'integer',
                                        'minvalue' => -9223372036854775808,
                                        'maxvalue' => 9223372036854775807);
        $colspecs['float']      = array('name' => 'FLOAT',
                                        'type' => 'float',
                                        'size' => 21);
        $colspecs['double']     = array('name' => 'DOUBLE',
                                        'type' => 'float',
                                        'size' => 21);
        $colspecs['date']       = array('name' => 'DATE',
                                        'type' => 'date',
                                        'size' => 12);
        $colspecs['datetime']   = array('name' => 'DATETIME',
                                        'type' => 'datetime',
                                        'size' => 20);
        $colspecs['time']       = array('name' => 'TIME',
                                        'type' => 'time',
                                        'size' => 8);
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
                                        'type' => 'enum');
        $colspecs['set']        = array('name' => 'SET',
                                        'type' => 'set');
        $colspecs['varbinary']  = array('name' => 'VARBINARY',
                                        'type' => 'blob',
                                        'size' => 255);

        return $colspecs;

    } // ddl_getColumnSpecs

    // ****************************************************************************
    function ddl_showColumns ($dbname, $tablename)
    // obtain a list of column names within the selected database table.
    {
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SHOW COLUMNS FROM $tablename FROM $dbname";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        $colspecs = $this->ddl_getColumnSpecs();

        // convert result set into an associative array for each row
        while ($row = mysql_fetch_assoc($result)) {
            // initialise all settings
            $columnarray = array();
            $columnarray['col_maxsize']         = NULL;
            $columnarray['col_unsigned']        = NULL;
            $columnarray['col_zerofill_bwz']    = NULL;
            $columnarray['col_precision']       = NULL;
            $columnarray['col_scale']           = NULL;
            $columnarray['col_minvalue']        = NULL;
            $columnarray['col_maxvalue']        = NULL;
            $columnarray['col_auto_increment']  = NULL;

            foreach ($row as $item => $value) {
                $item = strtolower($item);
                switch ($item) {
                	case 'field':
                		$columnarray['column_id'] = $value;
                		break;
                	case 'type':
                        unset($precision, $scale, $minvalue, $maxvalue);
                        if (eregi('^(enum|set)', $value, $regs)) {
                            $columnarray['col_type'] = $regs[0];
                            $pos1 = strpos($value, '(');
                            $value = substr($value, $pos1);
                            // include a space after each comma otherwise the string is
                            // treated as a single word in the HTML output
                            $value = str_replace("','", "', '", $value);
                            $columnarray['col_values'] = $value;
                        // look for 'type(n,m) stuff'
                        } elseif (strpos($value, '(')) {
                            $pos1 = strpos($value, '(');
                            $type = substr($value, 0, $pos1);
                            $pos2 = strpos($value, ')', $pos1);
                            $pos1++;
                            $size = substr($value, $pos1, $pos2 - $pos1);
                            $stuff = substr($value, $pos2+1);
                            $columnarray['col_type']    = $type;
                            $columnarray['col_maxsize'] = $size;

                            // look for 'unsigned' and 'zerofill' in $stuff
                            if (eregi('unsigned', $stuff)) {
                                $columnarray['col_unsigned'] = TRUE;
                            } // if
                            if (eregi('zerofill', $stuff)) {
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
                                if (eregi('unsigned', $stuff)) {
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
                                if (eregi('unsigned', $stuff)) {
                                    if ($specs['type']  == 'integer') {
                                        $maxvalue = ($specs['maxvalue'] * 2) +1;
                                    } // if
                                } // if
                                $columnarray['col_maxvalue'] = $maxvalue;
                            } // if

                        } else {
                            // look for 'unsigned' and 'zerofill' after the type
                            if (eregi('unsigned', $value, $regs)) {
                                $value = str_replace($regs[0], '', $value);
                                $columnarray['col_unsigned'] = TRUE;
                                $columnarray['col_minvalue'] = 0;
                            } // if
                            if (eregi('zerofill', $value, $regs)) {
                                $value = str_replace($regs[0], '', $value);
                                $columnarray['col_zerofill_bwz'] = 'ZF';
                            } // if
                            // no size information, so output 'as-is'
                            $columnarray['col_type'] = $value;
                            if (isset($colspecs[$value]['size'])) {
                                // use default size for this column type
                                $columnarray['col_maxsize'] = $colspecs[$value]['size'];
                            } // if
                        } // if

                        break;
                    case 'null':
                        // is this column allowd to be NULL?
                		if (is_True($value)) {
                            $value = 'YES';
                        } else {
                            $value = 'NO';
                            $columnarray['is_required'] = TRUE;
                        } // if
                        $columnarray['col_null'] = substr($value, 0);
                		break;
                    case 'extra':
                        if (eregi('auto_increment', $value)) {
                            $columnarray['col_auto_increment'] = TRUE;
                        } // if;
                        break;
                	default:
                		$columnarray['col_' .strtolower($item)] = $value;
                } // switch
            } // foreach
            $array[] = $columnarray;
        } // while

        mysql_free_result($result);

        return $array;

    } // ddl_showColumns

    // ****************************************************************************
    function ddl_showDatabases ()
    // obtain a list of existing database names.
    {
        //DebugBreak();
        // connect to database
        $this->connect($this->dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SHOW DATABASES";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

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
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SHOW TABLES FROM $dbname";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

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
        //DebugBreak();
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SHOW INDEX FROM $tablename";
        $result = mysql_query($this->query, $this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple indexed array for each row
        while ($row = mysql_fetch_assoc($result)) {
            $keyarray = array();
            foreach ($row as $item => $value) {
                $item = strtolower($item);
                if ($item == 'column_name') {
                    $keyarray['column_id'] = $value;
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
        //unset($object_vars['data_unformatted']);

        // convert to indexed array
        $object_vars = array_keys($object_vars);

        return $object_vars;

    } // __sleep

// ****************************************************************************
} // end class
// ****************************************************************************

?>