<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class oracle
// this version is for Oracle
{
    // connection settings
    var $dbhost;
    var $schema;                        // schema name
    var $dbusername;
    var $dbuserpass;
    var $dbprefix;

    // server settings
    var $client_encoding;               // character encoding for client
    var $host_info;                     // host info (connection)
    var $server_encoding;               // character encoding for server
    var $server_version;                // version number for server

    var $audit_logging;                 // yes/no switch
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
    var $stmt;                          // sql statement resource
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
    var $query;                         // completed DML statement

    var $dbconnect;                     // database connection resource

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function oracle ($args=null)
    {
        if (is_string($args)) {
            $schema           = $args;
        } else {
            $schema           =& $args['dbname'];
            $this->dbhost     =& $args['dbhost'];
            $this->dbusername =& $args['dbusername'];
            $this->dbuserpass =& $args['dbuserpass'];
            $this->dbprefix   =& $args['dbprefix'];
        } // if

        if (!empty($schema)) {
            $result = $this->connect($schema) or trigger_error($this, E_USER_ERROR);
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

    } // oracle

    // ****************************************************************************
    function adjustData ($string_in)
    // modify string to escape any single quote with a second single quote
    // (do not use backslash as with MySQL)
    {
        $string_out = str_replace("'", "''", $string_in);

        return $string_out;

    } // adjustData

    // ****************************************************************************
    function adjustGroupBy ($select_str, $group_str, $sort_str)
    // ensure GROUP_BY contains every field in the SELECT string, plus every field
    // in the ORDER_BY string.
    {
        if (preg_match('/WITH ROLLUP/i', $group_str, $regs)) {
            // convert 'field1 field2 WITH ROLLUP' to 'ROLLUP (field1, field2)'
        	$group_str = str_replace($regs[0], '', $group_str);
        	$group_str = "ROLLUP ($group_str)";
        } // if

        // turn $group_str into an array (delimiter is ',' followed by zero or more spaces)
        $group_array = preg_split('/, */', $group_str);

        list($field_alias, $field_orig) = extractFieldNamesIndexed ($select_str);
        foreach ($field_alias as $ix => $fieldname) {
        	if ($fieldname == $field_orig[$ix]) {
        	    // $fieldname is not an alias for an expression, so include in $group_array
        		if (!in_array($fieldname, $group_array)) {
        			$group_array[] = $fieldname;
        		} // if
        	} // if
        } // foreach

        if (!empty($sort_str)) {
        	// turn $sort_str into an array
            $sort_array = preg_split('/, */', $sort_str);
            foreach ($sort_array as $fieldname) {
                $ix = array_search($fieldname, $field_alias);
                if ($ix !== false) {
                	// check that this is not an alias name
                	if ($fieldname == $field_orig[$ix]) {
                	    if (!in_array($fieldname, $group_array)) {
                			$group_array[] = $fieldname;
                		} // if
                	} // if
                } else {
                	if (!in_array($fieldname, $group_array)) {
            			$group_array[] = $fieldname;
            		} // if
                } // if
            } // foreach
        } //  if

        // convert amended array back into a string
        $group_str = implode(', ', $group_array);

        return $group_str;

    } // adjustGroupBy

    // ****************************************************************************
    function adjustHaving ($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str)
    // make 'SELECT ... FROM ... WHERE ...' into a subquery so that the HAVING clause can
    // become the WHERE clause of the outer query.
    // This is because the HAVING clause cannot reference an expression by its alias name.
    {
        // Replace TRUE/FALSE to 1/0.
        $search  = array('/=[ ]*TRUE/i', '/=[ ]*FALSE/i');
        $replace = array( '=1',           '=0');
        $having_str = preg_replace($search, $replace, $having_str);

        // put current query into a subqery
        $subquery = "SELECT $select_str FROM $from_str $where_str $group_str";

        // extract SELECT list (with alias names for any expressions)
        list($select_alias, $select_orig) = extractFieldNamesIndexed ($select_str);

        $select_str = '';
        foreach ($select_alias as $fieldname) {
            if ($substring = strrchr($fieldname, '.')) {
        	    // now remove the tablename and put amended entry back into the array
                $fieldname = ltrim($substring, '.');
            } // if
            if (empty($select_str)) {
            	$select_str = "$fieldname";
            } else {
                $select_str .= ", $fieldname";
            } // if
        } // foreach

        $from_str = "(\n    $subquery\n)";
        $where_str  = "WHERE $having_str";
        $having_str = '';
        $group_str  = '';
        $sort_str   = unqualifyOrderBy($sort_str);

        return array($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str);

    } // adjustHaving

    // ****************************************************************************
    function adjustSelect ($input)
    // adjust for differences between MySQL and Oracle.
    {
        $output = $input;

        // replace 'CONCAT(A, B, C)' with 'A || B || C' as Oracle will only accept two
        // arguments with the CONCAT function, but any number with '||'.
        if ($count = preg_match_all("/(?<=concat\()[a-z_\., ']*/i", $output, $regs)) {
        	foreach ($regs[0] as $string1) {
        		$array = array();
        		$pattern  = '/';          // start pattern
        		$pattern .= "'.+'";       // any string enclosed in single quotes
        		$pattern .= '|';          // or
        		$pattern .= '\w+\.\w+';   // word dot word
        		$pattern .= '|';          // or
        		$pattern .= '\w+';        // word
        		$pattern .= '/';          // end pattern
        		$count = preg_match_all($pattern, $string1, $regs2);
        		foreach ($regs2[0] as $value) {
        		    // trim leading and trailing spaces from each entry
        			$array[] = trim($value);
        		} // foreach
        		$string2 = implode('||', $array);     // rejoin with '||' as separator
        		$output  = preg_replace('/concat\(' .$string1 .'\)/i', $string2, $output);
        	} // foreach;
        } // if

        // Replace TRUE/FALSE in CASE statements to 1/0.
        $search  = array('/THEN TRUE/i', '/ELSE TRUE/i', '/THEN FALSE/i', '/ELSE FALSE/i');
        $replace = array( 'THEN 1',       'ELSE 1',       'THEN 0',        'ELSE 0');
        $output  = preg_replace($search, $replace, $output);

        return $output;

    } // adjustSelect

    // ****************************************************************************
    function adjustSqlFrom ($string_in)
    // adjust SQL 'from' string just for Oracle
    {
        $string_out = $string_in;

        // remove the ' AS ' in 'table AS alias'
        $string_out = preg_replace('/ as /i', ' ', $string_out);

        // look for any words enclosed in double quotes
        $count = preg_match_all('/"\w+"/', $string_in, $regs);
        if ($count > 0) {
            // make sure they are all in upper case
        	foreach ($regs[0] as $entry) {
        		$string_out = str_replace($entry, strtoupper($entry), $string_out);
        	} // foreach
        } // if

        return $string_out;

    } // adjustSqlFrom

    // ****************************************************************************
    function adjustWhere ($string_in)
    // adjust for differences between MySQL and Oracle.
    // 'NOW()' to 'SYSTIMESTAMP'
    // 'DATE_ADD(field1 - INTERVAL $field2 unit)' to "field1 + $field2"
    // 'DATE_SUB(field1 - INTERVAL $field2 unit)' to "field1 - $field2"
    {
        $string_out = $string_in;

        $string_out = preg_replace('/now\(\)/i', 'SYSTIMESTAMP', $string_out);

        $modified = false;

        $array = where2indexedArray($string_out);   // convert string into indexed array

        $pattern = <<< END_OF_REGEX
/
^               # begins with
(               # start choice
 \) OR \(       # ') OR ('
 |
 \) OR'         # ') OR'
 |
 OR \(          # 'OR ('
 |
 OR             # 'OR'
 |
 \) AND \(      # ') AND ('
 |
 \) AND         # ') AND'
 |
 AND \(         # 'AND ('
 |
 AND            # 'AND'
 |
 (\()+          # one or more '('
 |
 (\))+          # one or more ')'
)               # end choice
$               # ends with
/xi
END_OF_REGEX;

        foreach ($array as $key => $value) {
            if (preg_match($pattern, $value, $regs)) {
            	// ignore this
            } else {
                list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($value);
                $fieldvalue = trim($fieldvalue);
                if (preg_match('/^date_sub/i', $fieldname)) {
                    // contains 'DATE_SUB(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldname, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    $field3 = $fieldvalue;
                    // replace with 'field1 - field2 op $field3'
                    $fieldname = "($field1 - $field2)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($field3);
                    $modified = true;

                } elseif (preg_match('/date_add/i', $fieldname)) {
                    // contains 'DATE_ADD(field1, INTERVAL field2 unit)', so extract 'field1, field2'
                    preg_match('/(?<=\().+(?=\))/', $fieldname, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    $field3 = $fieldvalue;
                    // replace with 'field1 + field2 op $field3'
                    $fieldname = "($field1 + $field2)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($field3);
                    $modified = true;

                } elseif (preg_match('/^date_sub/i', $fieldvalue)) {
                    // contains 'DATE_SUB(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldvalue, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    // replace with 'fieldname op field1 - field2'
                    $fieldvalue = "($field1 - $field2)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($fieldvalue);
                    $modified = true;

                } elseif (preg_match('/^date_add/i', $fieldvalue)) {
                    // contains 'DATE_ADD(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldvalue, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    // replace with 'fieldname op field1 + field2'
                    $fieldvalue = "($field1 + $field2)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($fieldvalue);
                    $modified = true;

                } // if
            } // if
        } // foreach

        if ($modified) {
        	$string_out = implode(' ', $array);
        } // if

        // modify string which may have been altered by addslashes() as Oracle does not
        // use backslash as its escape character. If a string contains a single quote
        // it must be escaped with another single quote, so ...
        // - replace 'backslash+char' with 'char' (i.e. remove the backslash)
        // - replace [\'] (backslash+quote) with [''] (quote+quote)
        // - replace [\\\'] with ['''']
        $search  = array('\\\\\\\'', '\\\''); // [\\\'], [\']
        $replace = array('\'\'\'\'', '\'\''); // [''''], ['']
        $string_out = str_replace($search, $replace, $string_out);

        $pattern = '/(?<=\\\)./'; // backslash followed by any character
        $offset  = 0;
        while (preg_match($pattern, $string_out, $regs, PREG_OFFSET_CAPTURE, $offset)) {
            $offset    = $regs[0][1];
            $remainder = strlen($string_out) - $offset;
            // remove the backslash and keep all remaining characters
            $string_out = substr_replace($string_out, '', $offset-1, -$remainder);
            $offset ++;
        } // while

        // Replace TRUE/FALSE to 1/0.
        $search  = array('/=[ ]*TRUE/i', '/=[ ]*FALSE/i');
        $replace = array( '=1',           '=0');
        $string_out = preg_replace($search, $replace, $string_out);

        return $string_out;

    } // adjustWhere

    // ****************************************************************************
    function array2string ($array)
    // return an array of values (for a VARRAY datatype) as a string.
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
        $where = null;

        foreach ($key as $fieldname) {
            if (array_key_exists($fieldname, $fieldarray)) {
            	$fieldvalue = $this->adjustData($fieldarray[$fieldname]);
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
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $result = oci_commit($this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, 'COMMIT');
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
    function connect ($schema=null)
    // establish a connection to the database
    {
        if (!empty($schema) AND !empty($this->dbprefix)) {
             if (!preg_match('/^(' .$this->dbprefix .')/i', $schema)) {
                // prefix may be different on different servers
                $schema = $this->dbprefix .$schema;
            } // if
        } // if

        $this->errors = array();
        $this->query  = '';
        $this->schema = $schema;

        $dbconn = $this->dbconnect;

        if (!$dbconn) {
            //$dbconn = oci_pconnect($this->dbusername, $this->dbuserpass, $this->dbhost, 'UTF8');
            $dbconn = oci_connect($this->dbusername, $this->dbuserpass, $this->dbhost, 'UTF8');
            if ($dbconn) {
                $this->server_info = oci_server_version ($dbconn);
                // get name of current database
                $this->query = "SELECT * FROM global_name";
                $this->stmt  = oci_parse($dbconn, $this->query);
                $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
                $row = oci_fetch_array ($this->stmt, OCI_NUM);
                $this->dbname = $row[0];
                // change format for DATE datatype
                $this->query = "ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'";
                $this->stmt  = oci_parse($dbconn, $this->query);
                $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
                // change format for TIMESTAMP datatype
                $this->query = "ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS'";
                $this->stmt  = oci_parse($dbconn, $this->query);
                $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
                // set CASE INSENSITIVE
//                $this->query = "ALTER SESSION SET NLS_COMP=LINGUISTIC";
//                $this->stmt  = oci_parse($dbconn, $this->query);
//                $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
                // set CASE INSENSITIVE
//                $this->query = "ALTER SESSION SET NLS_SORT=BINARY_CI";
//                $this->stmt  = oci_parse($dbconn, $this->query);
//                $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
            } // if
        } // if
        if (!$dbconn) {
            return FALSE;
        } //

        if (!empty($schema)) {
            $this->query = 'ALTER SESSION SET CURRENT_SCHEMA = "' .strtoupper($schema) .'"';
            $this->stmt  = oci_parse($dbconn, $this->query);
            if (!$result = oci_execute($this->stmt)) {
            	$error_array = oci_error($this->stmt);
            	if ($error_array['code'] == 2421) {
            	    // try again, but this time unquoted in lower case
            	    $this->query = 'ALTER SESSION SET CURRENT_SCHEMA = ' .$schema;
            		$this->stmt  = oci_parse($dbconn, $this->query);
                    $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
            	} else {
            	    trigger_error($this, E_USER_ERROR);
            	} // if
            } // if
            // write query to log file, if option is turned on
            logSqlQuery ($schema, null, $this->query);
        } // if

        $this->query     = '';
        $this->dbconnect = $dbconn;
        $this->schema    = $schema;
        return TRUE;

    } // connect

    // ****************************************************************************
    function deleteRecord ($schema, $tablename, $fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        // build 'where' string using values for primary key
        $where = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (empty($where)) return;    // nothing to delete, so exit

        // get count of affected rows as there may be more than one
        $query = "SELECT count(*) FROM $tablename WHERE $where";
        $this->numrows = $this->getCount($schema, $tablename, $query);

        // build the query string and run it
        $this->query = "DELETE FROM $tablename WHERE $where";
        $this->stmt  = oci_parse($this->dbconnect, $this->query);
        if (is_True($GLOBALS['transaction_has_started'])) {
        	$result = oci_execute($this->stmt, OCI_DEFAULT) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = oci_execute($this->stmt, OCI_COMMIT_ON_SUCCESS) or trigger_error($this, E_USER_ERROR);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($schema, $tablename, $this->fieldspec, $where, $fieldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteSelection ($schema, $tablename, $selection, $from=null, $using=null)
    // delete a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $selection = $this->adjustWhere($selection);

        if (!empty($from) AND !empty($using)) {
            $count = 1;
            //$this->query = "DELETE FROM $from USING $using \nWHERE $selection";
            return $count;
        } else {
            // get count of affected rows as there may be more than one
            $query = "SELECT count(*) FROM $tablename WHERE $selection";
            $count = $this->getCount($schema, $tablename, $query);
            $this->query = "DELETE FROM $tablename WHERE $selection";
        } // if
        $this->stmt  = oci_parse($this->dbconnect, $this->query);
        if (is_True($GLOBALS['transaction_has_started'])) {
        	$result = oci_execute($this->stmt, OCI_DEFAULT) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = oci_execute($this->stmt, OCI_COMMIT_ON_SUCCESS) or trigger_error($this, E_USER_ERROR);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($schema, $tablename, $this->fieldspec, $selection, array());
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        return $count;

    } // deleteSelection

    // ****************************************************************************
    function fetchRow ($schema, $statement)
    // Fetch a row from the given result set (created with getData_serial() method).
    {
        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $this->stmt = $statement;

        $row = oci_fetch_array ($statement, OCI_ASSOC+OCI_RETURN_NULLS+OCI_RETURN_LOBS);
        if ($row) {
        	$array = array_change_key_case($row, CASE_LOWER);
        	return $array;
        } // if

        if ($error_array = oci_error($statement)) {
            $this->query = $error_array['sqltext'];
            trigger_error($this, E_USER_ERROR);
        } // if

        return false;

    } // fetchRow

    // ****************************************************************************
    function free_result ($dbname, $resource)
    // release a resource created with getData_serial() method.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $result = oci_free_statement($resource);

        return $result;

    } // free_result

    // ****************************************************************************
    function getCount ($schema, $tablename, $where)
    // get count of records that satisfy selection criteria in $where.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        if (preg_match('/^(select )/i', $where)) {
            // $where starts with 'SELECT' so use it as a complete query
            $this->query = $where;
        } else {
            // does not start with 'SELECT' so it must be a 'where' clause
            if (empty($where)) {
            	$this->query = "SELECT count(*) FROM $tablename";
            } else {
                $where = $this->adjustWhere($where);
                $this->query = "SELECT count(*) FROM $tablename WHERE $where";
            } // if
        } // if

        $this->stmt = oci_parse($this->dbconnect, $this->query);
        $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);

        // if 'GROUP BY' was used then return the number of rows
        // (ignore GROUP BY if it is in a subselect)
        if (preg_match("/group by /i", $this->query) == true AND !preg_match("/\(SELECT .+group by.+\)/i", $this->query)) {
            oci_fetch_all($this->stmt, $row, null, null, OCI_NUM);
            $count = count($row[0]);
        } else {
            $row = oci_fetch_array ($this->stmt, OCI_NUM);
            if (count($row) > 0) {
            	$count = $row[0];
            } else {
                $count = 0;
            } // if
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
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

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
            $select_str = $this->adjustSelect($this->sql_select);
        } // if

        // use specified FROM parameters, or default to current table name
        if (empty($this->sql_from)) {
            // the default is current table
            $from_str = $tablename;
        } else {
            $from_str = $this->adjustSqlFrom($this->sql_from);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = 'WHERE ' .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "GROUP BY " .$this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
            //$group_str = "GROUP BY $this->sql_groupby";
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            list($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str) = $this->adjustHaving ($select_str, $from_str, $where_str, $group_str, $this->sql_having, $sort_str);
            //$having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
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
//                        $count = preg_match_all("/\w+/", $from_str, $regs);
//                        if ($count > 1) {
//                            $lock_str = 'FOR UPDATE OF ' .$tablename;
//                        } else {
                            $lock_str = 'FOR UPDATE';
//                        } // if
                } // switch
                $this->row_locks = null;

                foreach ($this->fieldspec as $field => $spec) {
                    if ($spec['type'] == 'string' AND $spec['size'] > 4000) {
                        // turn off when reading a table which contains LOBs
                        $lock_str = null;
                        break;
                    } // if
                } // foreach

            } // if
        } // if

        if ($rows_per_page > 0) {
            // count the rows that satisfy this query
            $query = "SELECT count(*) FROM $from_str $where_str $group_str $having_str";
            $this->numrows = $this->getCount($schema, $tablename, $query);

            if ($this->numrows <= 0) {
                $this->pageno = 0;
                return $array;
            } // if

            // calculate the total number of pages from this query
            $this->lastpage = ceil($this->numrows/$rows_per_page);
        } else {
            $this->lastpage = 1;
            $this->numrows  = null;
        } // if

        // ensure pageno is within range
        if ($pageno < 1) {
            $pageno = 1;
        } elseif ($pageno > $this->lastpage) {
            $pageno = $this->lastpage;
        } // if
        $this->pageno = $pageno;

        // build the query string and run it
        $this->query = "SELECT $select_str FROM $from_str $where_str $group_str $having_str $sort_str $lock_str";
        if ($rows_per_page > 0) {
            // insert code for pagination
            $min_rows = (($pageno - 1) * $rows_per_page) +1;
            $max_rows = ($min_rows + $rows_per_page) -1;
            $this->query = 'select * from ( select a.*, rownum as rnum from ( '
                         . $this->query
                         . ") a where rownum <= $max_rows ) where rnum >= $min_rows";
        } // if

        $this->stmt = oci_parse($this->dbconnect, $this->query);
        $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple associative array for each row
        while ($row = oci_fetch_array ($this->stmt, OCI_ASSOC+OCI_RETURN_NULLS+OCI_RETURN_LOBS)) {
            // adjust certain fields before passing them back to the application
            foreach ($row as $fieldname => $fieldvalue) {
            	if (array_key_exists(strtolower($fieldname), $this->fieldspec)) {
                	switch ($this->fieldspec[strtolower($fieldname)]['type']) {
                		case 'date':
                			$row[$fieldname] = substr($fieldvalue, 0, 10);
                			break;
                		case 'time':
                            if (strlen($fieldvalue) > 8) {
                                // this is a DATETIME column, so extract TIME portion
                                $row[$fieldname] = substr($fieldvalue, 11, 8);
                            } // if
                			break;
                		case 'string':
                		    // replace '\r\n' with carriage return + new line
                        	$row[$fieldname] = str_replace('\r\n', "\015\012", $row[$fieldname]);
                		default:
                			break;
                	} // switch
                } // if
            } // foreach
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        if ($error_array = oci_error($this->stmt)) {
            if ($error_array['code'] == 1002) {
            	// ORA-01002: fetch out of sequence - IGNORE
            } else {
        	    trigger_error($this, E_USER_ERROR);
            } // if
        } // if

        if (is_null($this->numrows)) {
        	$this->numrows = count($array);
        } // if
        oci_free_statement($this->stmt);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        return $array;

    } // getData

    // ****************************************************************************
    function getData_serial ($schema, $tablename, $where, $rdc_limit=null, $rdc_offset=null)
    // Get data from a database table using optional 'where' criteria.
    // Return $result, not an array of data, so that individual rows can
    // be retrieved using the fetchRow() method.
    {
        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

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
            $select_str = $this->adjustSelect($this->sql_select);
        } // if

        // use specified FROM parameters, or default to current table name
        if (empty($this->sql_from)) {
            // the default is current table
            $from_str = $tablename;
        } else {
            $from_str = $this->adjustSqlFrom($this->sql_from);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = 'WHERE ' .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "GROUP BY " .$this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
            //$group_str = "GROUP BY $this->sql_groupby";
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            list($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str) = $this->adjustHaving ($select_str, $from_str, $where_str, $group_str, $this->sql_having, $sort_str);
            //$having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        // get number of rows which match this selection criteria
        $query = "SELECT count(*) FROM $from_str $where_str $group_str $having_str";
        $this->numrows = $this->getCount($schema, $tablename, $query);

        // build the query string and run it
        $this->query = "SELECT $select_str FROM $from_str $where_str $group_str $having_str $sort_str $lock_str";
        if (!is_null($rdc_limit) AND !is_null($rdc_offset)) {
        	$min_rows = $rdc_limit;
        	$max_rows = $min_rows + $rdc_offset;
        	$this->query = 'select * from ( select a.*, rownum as rnum from ( '
                         . $this->query
                         . ") a where rownum <= $max_rows ) where rnum >= $min_rows";
        } elseif ($rows_per_page > 0) {
            // insert code for pagination
            $min_rows = (($pageno - 1) * $rows_per_page) +1;
            $max_rows = ($min_rows + $rows_per_page) -1;
            $this->query = 'select * from ( select a.*, rownum as rnum from ( '
                         . $this->query
                         . ") a where rownum <= $max_rows ) where rnum >= $min_rows";
        } // if

        $this->stmt  = oci_parse($this->dbconnect, $this->query);
        $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        return $this->stmt;

    } // getData_serial

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function getErrorNo ()
    // return number of last error.
    {
        if (isset($this->stmt)) {
        	$array = oci_error($this->stmt);
        } else {
            $array = oci_error();
        } // if

        if (!empty($array)) {
            $errno = $array['code'];
            if (!empty($array['message']) AND empty($this->error_string)) {
            	$this->error_string = $array['message'];
            } // if
        } else {
            $errno = null;
        } // if

        return $errno;

    } // getErrorNo

    // ****************************************************************************
    function getErrorString ()
    // return string containing details of last error.
    {
        if (!empty($this->error_string)) {
            $string = $this->error_string;
            $this->error_string = null;
		} else {
		    $array = oci_error($this->stmt);
        	$string = $array['message'];
        	if (!empty($string)) {
        		$string = 'ORACLE: ' .$string;
        	} // if
		} // if

        return $string;

    } // getErrorString

    // ****************************************************************************
    function getErrorString2 ()
    // return additional information.
    {
        if ($this->dbconnect) {
        	$string  = "Server Version: " .$this->server_info;
        	$string .= "<br>Database: " .strtoupper($this->dbname);
        	$string .= ", Schema: " .strtoupper($this->schema);
        } else{
            $string  = "Database: " .$GLOBALS['dbhost'];
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

        $this->numrows = 0;  // record not inserted (yet)

        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        $lob_names = array();
        $lob_array = array();
        foreach ($fieldspec as $field => $spec) {
            // look for fields with 'autoinsert' option set
            if (array_key_exists('autoinsert', $spec)) {
                if (empty($fieldarray[$field])) {
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
            } else {
                if ($spec['type_native'] == 'datetime') {
                    // this column requires both date and time
                    if ($spec['type'] == 'date') {
                        // only date input, so append dummy time
                        $fieldarray[$field] .= ' 00:00:00';
                    } elseif ($spec['type'] == 'time') {
                        // only time input, so prepend dummy date
                        $fieldarray[$field] = '2000-01-01 '.$fieldarray[$field];
                    } // if
                } elseif ($spec['type'] == 'string' AND $spec['size'] > 4000) {
                    // special processing required for LOBs (large objects)
                    if (isset($fieldarray[$field])) {
                    	//$lob_names[$field] = $this->adjustData($fieldarray[$field]);
                    	$lob_names[$field] = $fieldarray[$field];
                        $fieldarray[$field] = 'EMPTY_CLOB()';
                    } // if
                } // if
            } // if
        } // foreach

        // find out if any field in the primary key has 'serial' (auto_increment) set
		$auto_increment = '';
		foreach ($this->primary_key as $pkey){
			if (isset($fieldspec[$pkey]['auto_increment'])) {
			    $this->retry_on_duplicate_key = null;  // this feature cannot be used with auto_increment
			    if (!empty($fieldarray[$pkey]) AND $fieldarray[$pkey] > 0) {
			    	// value has been supplied manually, so do not auto-generate
			    } else {
    			    $auto_increment = $pkey;                // save name of related sequence
    				unset($fieldarray[$auto_increment]);    // remove from data array
			    } // if
			} // if
		} // foreach

        // build 'where' string using values for primary key
        $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);

		if (empty($auto_increment) AND empty($this->retry_on_duplicate_key)) {
	        // find out if a record with this primary key already exists
	        $query = "SELECT count(*) FROM $tablename WHERE $primary_key";
	        $count = $this->getCount($schema, $tablename, $query);

	        // Is this primary key taken?
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
	        $primary_key = $where;
		} // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where = $this->buildKeyString ($fieldarray, $key);
                $query = "SELECT count(*) FROM $tablename WHERE $where";
                $count = $this->getCount($schema, $tablename, $query);
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
            } // foreach
        } // if

        // construct query string to insert this record into the database
        if (!empty($auto_increment)) {
            $cols = "$auto_increment, ";
            $vals = $tablename .'_seq.nextval, ';
        } else {
            $cols = '';
            $vals = '';
        } // if
        foreach ($fieldarray as $item => $value) {
            if (array_key_exists($item, $lob_names)) {
            	$cols .= "$item, ";
            	$vals .= "EMPTY_CLOB(), ";
            } else {
                if (!array_key_exists('required',$fieldspec[$item])
                AND strlen($value) == 0 OR strtoupper(trim($value)) == 'NULL') {
                    $cols .= "$item, ";
                    $vals .= "NULL, ";
                } else {
                    $cols .= "$item, ";
                    $vals .= "'" .$this->adjustData($value) ."', ";
                } // if
            } // if
        } // foreach

        // remove trailing commas
        $cols = rtrim($cols, ', ');
        $vals = rtrim($vals, ', ');

        $this->query = 'INSERT INTO ' .$tablename .' (' .$cols .') VALUES (' .$vals .')';
        if (empty($lob_names)) {
            $this->stmt = oci_parse($this->dbconnect, $this->query);
        } else {
            // convert array of names into a string and append to SELECT statement
            $lob_string = implode(', ', array_keys($lob_names));
            $this->query .= ' RETURNING ' .$lob_string;
            $lob_string = str_replace(', ', ', :', $lob_string);
            $this->query .= ' INTO :' .$lob_string;
            $this->stmt = oci_parse($this->dbconnect, $this->query);
            foreach ($lob_names as $lob_name => $lob_value) {
            	$lob_array[$lob_name] = oci_new_descriptor($this->dbconnect, OCI_D_LOB);
                oci_bind_by_name($this->stmt, ':'.$lob_name, $lob_array[$lob_name], -1, OCI_B_CLOB);
            } // foreach
        } // if

        $repeat       = false;
        $repeat_count = 0;
        do {
            //$result = oci_execute($this->stmt, OCI_DEFAULT) or trigger_error($this, E_USER_ERROR);
            $result = oci_execute($this->stmt, OCI_DEFAULT);
            if ($result == false) {
            	$error_array = oci_error($this->stmt);
            	if ($error_array['code'] == 1 AND !empty($this->retry_on_duplicate_key)) {
            	    // increment the specified field and try again
                    $fieldarray[$this->retry_on_duplicate_key]++;
                    $repeat = true;
                    $repeat_count++;
                    if ($repeat_count > 5) {
                        // too many retries, so turn this feature off
                    	$this->retry_on_duplicate_key = null;
                    } // if

            	} elseif ($error_array['code'] == 1 AND is_True($this->update_on_duplicate_key)) {
                    // switch to 'update'
                    $old_array = where2array($primary_key);
                    $fieldarray = $this->updateRecord ($dbname, $tablename, $fieldarray, $old_array);
                    return $fieldarray;

                } elseif ($error_array['code'] == 1 AND is_True($this->no_duplicate_error)) {
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

        if (!empty($lob_names)) {
            foreach ($lob_names as $lob_name => $lob_value) {
            	$lob_array[$lob_name]->save($lob_value);
            } // foreach
        } // if

        if (!is_True($GLOBALS['transaction_has_started'])) {
            $this->commit($schema);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query);

        if (!empty($auto_increment)) {
            $this->query = "SELECT $tablename" .'_seq.currval FROM DUAL';
            $this->stmt  = oci_parse($this->dbconnect, $this->query);
            $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);
            $row = oci_fetch_array ($this->stmt, OCI_NUM);
            $fieldarray[$auto_increment] = $row[0];
            $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);
            // write query to log file, if option is turned on
            logSqlQuery ($schema, $tablename, $this->query, $fieldarray[$auto_increment]);
        } // if

        if ($this->numrows > 0) {
            if ($this->audit_logging) {
            	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        			// do nothing
		        } else {
	                $auditobj =& RDCsingleton::getInstance('audit_tbl');
	                // add record details to audit database
	                $auditobj->auditInsert($schema, $tablename, $this->fieldspec, $primary_key, $fieldarray);
	                $this->errors = array_merge($auditobj->getErrors(), $this->errors);
				} // if
            } // if
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

        $result = oci_rollback($this->dbconnect) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, null, 'ROLLBACK');
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
    function selectDB ($schema)
    // select a different schema (database) via the current connection.
    {
        if ($this->connect($schema) or trigger_error($this, E_USER_ERROR)) {
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
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $result = true;

        if (!empty($this->transaction_level)) {
        	$this->query = $this->transaction_level;
            $this->stmt  = oci_parse($this->dbconnect, $this->query);
            $result = oci_execute($this->stmt) or trigger_error($this, E_USER_ERROR);

            // write query to log file, if option is turned on
            logSqlQuery ($schema, null, $this->query);
            $this->query = '';
        } // if

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
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

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
                if ($where1 <> $where2) {
                    // key has changed, so check for uniqueness
                    $query = "SELECT count(*) FROM $tablename WHERE $where2";
                    $count = $this->getCount($schema, $tablename, $query);
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

        $lob_names = array();
        $lob_array = array();
        if (isset($GLOBALS['mode']) and $GLOBALS['mode'] == 'logon' and $tablename == 'mnu_user') {
            // do not set these fields when logging in
        } else {
            foreach ($fieldspec as $field => $spec) {
                // look for fields with 'autoupdate' option set
                if (array_key_exists('autoupdate', $spec)) {
                    switch ($spec['type']){
    					case 'datetime':
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
                } else {
                    if ($spec['type_native'] == 'datetime') {
                        // this column requires both date and time
                        if ($spec['type'] == 'date') {
                            // only date input, so append dummy time
                            $fieldarray[$field] .= ' 00:00:00';
                        } elseif ($spec['type'] == 'time') {
                            // only time input, so prepend dummy date
                            $fieldarray[$field] = '2000-01-01 '.$fieldarray[$field];
                        } // if
                    } elseif ($spec['type'] == 'string' AND $spec['size'] > 4000) {
                        // special processing required for LOBs (large objects)
                        if (isset($fieldarray[$field])) {
                        	//$lob_names[$field] = $this->adjustData($fieldarray[$field]);
                        	$lob_names[$field] = $fieldarray[$field];
                        	$fieldarray[$field] = 'EMPTY_CLOB()';
                        } // if
                    } // if
                } // if
            } // foreach
        } // if

        // build update string from non-pkey fields
        $update = '';
        $pattern1 = '/(integer|decimal|numeric|float|real)/i';
        $pattern2 = '/^\w+[ ]*\(.+\)$/';  // function(...)
        foreach ($fieldarray as $item => $value) {
            // use this item if it IS NOT part of primary key
            if (!in_array($item, $this->primary_key)) {
                if (array_key_exists($item, $lob_names)) {
                	$update .= "$item = EMPTY_CLOB(), ";
                } elseif (is_null($value)) {
                    // null entries are set to NULL, not '' (there is a difference!)
                    $update .= "$item=NULL,";
                } elseif (preg_match($pattern1, $fieldspec[$item]['type'], $match)) {
                    // do not enclose numbers in quotes (this also allows 'value=value+1'
                    if (strlen($value) == 0) {
                    	$update .= "$item=NULL,";
                    } else {
                        $update .= "$item=$value,";
                    } // if
                } elseif (preg_match($pattern2, $value)) {
                    // change to the new value (without enclosing quotes)
                    $update .= "$item=" .$this->adjustData($value) .", ";
                } else {
                    // change to the new value (with enclosing quotes)
                    $update .= "$item='" .$this->adjustData($value) ."', ";
                } // if
            } // if
        } // foreach

        // strip trailing comma
        $update = rtrim($update, ', ');

        // append WHERE clause to SQL query
        $this->query = "UPDATE $tablename SET $update WHERE $where";
        if (empty($lob_names)) {
            $this->stmt = oci_parse($this->dbconnect, $this->query);
        } else {
            // convert array of names into a string and append to SELECT statement
            $lob_string = implode(', ', array_keys($lob_names));
            $this->query .= ' RETURNING ' .$lob_string;
            // put colon in front of all names
            $lob_string = str_replace(', ', ', :', $lob_string);
            $this->query .= ' INTO :' .$lob_string;
            $this->stmt  = oci_parse($this->dbconnect, $this->query);
            foreach ($lob_names as $lob_name => $lob_value) {
            	$lob_array[$lob_name] = oci_new_descriptor($this->dbconnect, OCI_D_LOB);
                oci_bind_by_name($this->stmt, ':'.$lob_name, $lob_array[$lob_name], -1, OCI_B_CLOB);
            } // foreach
        } // if

        $result = oci_execute($this->stmt, OCI_DEFAULT) or trigger_error($this, E_USER_ERROR);

        if (!empty($lob_names)) {
            foreach ($lob_names as $lob_name => $lob_value) {
            	$lob_array[$lob_name]->save($lob_value);
            } // foreach
        } // if

        if (!is_True($GLOBALS['transaction_has_started'])) {
            $this->commit($schema);
        } // if

        // get count of affected rows as there may be more than one
        $query = "SELECT count(*) FROM $tablename WHERE $where";
        $this->numrows = $this->getCount($schema, $tablename, $query);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj =& RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditUpdate($schema, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        return $fieldarray;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($schema, $tablename, $replace, $selection)
    // update a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $query = "SELECT count(*) FROM $tablename WHERE $selection";
        $count = $this->getCount($schema, $tablename, $query);

        $this->query = "UPDATE $tablename SET $replace WHERE $selection";
        $this->stmt  = oci_parse($this->dbconnect, $this->query);
        if (is_True($GLOBALS['transaction_has_started'])) {
        	$result = oci_execute($this->stmt, OCI_DEFAULT) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = oci_execute($this->stmt, OCI_COMMIT_ON_SUCCESS) or trigger_error($this, E_USER_ERROR);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        if ($count > 0) {
            if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        			// do nothing
		        } else {
	                $auditobj =& RDCsingleton::getInstance('audit_tbl');
	                // add record details to audit database
	                $auditobj->auditUpdateSelection($schema, $tablename, $this->fieldspec, $selection, $replace);
	                $this->errors = array_merge($auditobj->getErrors(), $this->errors);
				} // if
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

        $colspecs['char']           = array('name' => 'CHAR',
                                            'type' => 'string',
                                            'size' => 2000);
        $colspecs['nchar']          = array('name' => 'NCHAR',
                                            'type' => 'string',
                                            'size' => 2000);
        $colspecs['varchar2']       = array('name' => 'VARCHAR2',
                                            'type' => 'string',
                                            'size' => 4000);

        $colspecs['nvarchar2']      = array('name' => 'NVARCHAR2',
                                            'type' => 'string',
                                            'size' => 4000);

        $colspecs['number']         = array('name' => 'NUMBER',
                                            'type' => 'numeric',
                                            'size' => 20,
                                            'precision' => 38,
                                            'scale' => 126);
        $colspecs['decimal']        = array('name' => 'DECIMAL',
                                            'type' => 'numeric');
        $colspecs['integer']        = array('name' => 'INTEGER',
                                            'type' => 'integer',
                                            'size' => 20,
                                            'precision' => 38,
                                            'scale' => 0);
        $colspecs['float']          = array('name' => 'FLOAT',
                                            'type' => 'numeric',
                                            'size' => 22);
        $colspecs['clob']           = array('name' => 'CLOB',
                                            'type' => 'string',
                                            'size' => 4294967295);
        $colspecs['nclob']          = array('name' => 'NCLOB',
                                            'type' => 'string',
                                            'size' => 4294967295);
        $colspecs['blob']           = array('name' => 'BLOB',
                                            'type' => 'binary',
                                            'size' => 4294967295);
        $colspecs['varray']         = array('name' => 'VARRAY',
                                            'type' => 'array');

        // allow DATE type to be re-specfied as DATE, TIME or DATETIME
        $colspecs['date']           = array('name' => 'DATE',
                                            'type' => 'date',
                                            'size' => 19);
        $colspecs['time']           = array('name' => 'TIME',
                                            'type' => 'time',
                                            'size' => 8);
        $colspecs['datetime']       = array('name' => 'DATETIME',
                                            'type' => 'datetime',
                                            'size' => 19);

        // miscellaneous data types
        $colspecs['long']           = array('name' => 'LONG',
                                            'type' => 'string',
                                            'size' => 2147483647);
        $colspecs['raw']            = array('name' => 'RAW',
                                            'type' => 'binary',
                                            'size' => 2000);
        $colspecs['bfile']          = array('name' => 'BFILE',
                                            'type' => 'bfile',
                                            'size' => 255);
        $colspecs['binary_double']  = array('name' => 'BINARY_DOUBLE',
                                            'type' => 'numeric',
                                            'size' => 20,
                                            'precision' => 38,
                                            'scale' => 126);
        $colspecs['binary_float']   = array('name' => 'BINARY_FLOAT',
                                            'type' => 'float',
                                            'size' => 20,
                                            'minvalue' => 1.17549E-38,
                                            'maxvalue' => 3.40282E+38);
        $colspecs['timestamp']      = array('name' => 'TIMESTAMP without time zone',
                                            'type' => 'datetime',
                                            'size' => 20);
        $colspecs['timestamp_tz']   = array('name' => 'TIMESTAMP with time zone',
                                            'type' => 'datetime',
                                            'size' => 20);
        $colspecs['timestamp_ltz']  = array('name' => 'TIMESTAMP with local time zone',
                                            'type' => 'datetime',
                                            'size' => 20);
        $colspecs['interval_day']   = array('name' => 'INTERVAL DAY',
                                            'type' => 'interval',
                                            'size' => 20,
                                            'minvalue' => '0.0',
                                            'maxvalue' => '999999999.999999999');
        $colspecs['interval_year']  = array('name' => 'INTERVAL YEAR',
                                            'type' => 'interval',
                                            'size' => 13,
                                            'minvalue' => '0.0',
                                            'maxvalue' => '999999999.999');

        // these are here just for compatability with MySQL
        $colspecs['boolean']    = array('name' => 'BOOLEAN',
                                        'type' => 'boolean');
        $colspecs['datetime']   = array('name' => 'DATETIME',
                                        'type' => 'datetime');
        $colspecs['time']       = array('name' => 'TIME',
                                        'type' => 'time');
        $colspecs['set']        = array('name' => 'SET',
                                        'type' => 'array');
        $colspecs['enum']       = array('name' => 'ENUM',
                                        'type' => 'array');
        $colspecs['varchar']    = array('name' => 'VARCHAR',
                                        'type' => 'string');
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
        $colspecs['bigint']     = array('name' => 'BIGINT',
                                        'type' => 'integer',
                                        'minvalue' => '-9223372036854775808',
                                        'maxvalue' => '9223372036854775807');
        $colspecs['tinytext']   = array('name' => 'TINYTEXT',
                                        'type' => 'string');
        $colspecs['text']       = array('name' => 'TEXT',
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
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $out_array = array();

        $schema    = strtoupper($schema);
        $tablename = strtoupper($tablename);

        // build the query string and run it
        $query = "SELECT count(*) FROM sys.all_tab_cols WHERE owner='$schema' AND table_name='$tablename' ORDER BY column_id";
        $count = $this->getcount($schema, $tablename, $query);

        $this->query = "SELECT * FROM sys.all_tab_cols WHERE owner='$schema' AND table_name='$tablename' ORDER BY column_id";
        $statement  = oci_parse($this->dbconnect, $this->query);
        $this->stmt = $statement;
        $result = oci_execute($statement) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        $colspecs = $this->ddl_getColumnSpecs();

        // identify primary and other unique keys
        $tablekeys = $this->ddl_showTableKeys($schema, $tablename);
        $pkey = array();  // primary key
        $ukey = array();  // candidate (unique) keys
        foreach ($tablekeys as $key => $spec) {
        	if ($spec['key_name'] == 'PRIMARY') {
        	    $pkey[] = strtolower($spec['column_id']);
    	    } elseif ($spec['uniqueness'] == 'UNIQUE') {
    	        $ukey[] = strtolower($spec['column_id']);
        	} // if
        } // foreach

        $this->stmt = $statement;

        // convert result set into an associative array for each row
        while ($row = oci_fetch_array ($statement, OCI_ASSOC+OCI_RETURN_NULLS)) {
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
                if (preg_match('/\(.+\)/', $value, $regs)) {
                    // remove any number in parentheses '(n)'
                	$value = str_replace($regs[0], '', $value);
                } // if
                switch ($item) {
                    case 'column_name':
                        $value = strtolower($value);
                		$columnarray['column_id'] = $value;
                		if (in_array($value, $pkey)) {
                		    $columnarray['col_key'] = 'PRI';
                		} elseif (in_array($value, $ukey)) {
                		    $columnarray['col_key'] = 'UNI';
                		} // if
                		break;
                	case 'column_id':
                	    $columnarray['column_seq'] = $value;
                	    break;
                	case 'data_default':
                	    // extract default which is enclosed in single quotes
                        if (preg_match("?\'[^\']+\'?", $value, $regs)) {
                            $value = substr($regs[0], 1, strlen($regs[0])-2); // strip first & last characters
                            $columnarray['col_default'] = $value;
                        } // if
                	    break;
                	case 'nullable':
                	    // is this column allowed to be NULL?
                		if (is_True($value)) {
                            $columnarray['col_null'] = 'Y';
                        } else {
                            $columnarray['col_null'] = 'N';
                        } // if
                	    break;
                	case 'data_type':
                	    switch ($value) {
                            case 'DATE';
                                // default is 'datetime', but can be used as 'date' only or 'time' only
                	    	    $columnarray['col_type_native'] = 'datetime,date,time';
                                $columnarray['col_type'] = 'date';
                	    	    break;
                            case 'TIME';
                                $columnarray['col_type'] = 'time';
                                break;
                            case 'DATETIME';
                                $columnarray['col_type'] = 'datetime';
                                break;
                            case 'TIMESTAMP';
                                $columnarray['col_type'] = 'timestamp';
                                break;
                            case 'TIMESTAMP WITH TIME ZONE';
                	    	    $columnarray['col_type'] = 'timestamp_tz';
                	            break;
                	    	case 'TIMESTAMP WITH LOCAL TIME ZONE';
                	    	    $columnarray['col_type'] = 'timestamp_ltz';
                	            break;
                	    	case 'INTERVAL DAY':
                	    		$columnarray['col_type'] = 'interval_day';
                	    		break;
                	        case 'INTERVAL YEAR';
                	    	    $columnarray['col_type'] = 'interval_year';
                	            break;

                	    	default:
                	    	    $columnarray['col_type'] = strtolower($value);
                	    	    if (!empty($row['DATA_TYPE_OWNER'])) {
                	    	    	$columnarray['col_type']       = 'varray';
                	    	    	$columnarray['col_array_type'] = $value;
                	    	    	$columnarray['col_maxsize']    = $row['DATA_LENGTH'];
                	    	    } // if
                	    		break;
                	    } // switch

                	    unset($precision, $scale, $minvalue, $maxvalue);
                        $type  = $columnarray['col_type'];
                	    $specs = $colspecs[$type];

                	    if (isset($specs['size'])) {
                            $columnarray['col_maxsize'] = $specs['size'];
                        } // if

                        // find out if the primary key is to be filled from a sequence
                        if (count($pkey) == 1) {
                            if ($columnarray['column_id'] == $pkey[0] AND $type = 'number') {
                                $query = "SELECT count(*) FROM sys.all_sequences WHERE sequence_owner='$schema' AND sequence_name='{$tablename}_SEQ'";
                                $count = $this->getcount($schema, $tablename, $query);
                            	if ($count > 0) {
                            		$columnarray['col_auto_increment']  = 'Y';
                            	} // if
                            } // if
                        } // if
                        break;
                    case 'char_length':
                        if ($specs['type'] == 'string' OR $specs['type'] == 'binary') {
                            if ($value > 0) {
                            	$columnarray['col_maxsize'] = $value;
                            } else {
                        	    $columnarray['col_maxsize'] = $specs['size'];
                            } // if
                        } // if
                        break;
                    case 'data_precision':
                        if ($specs['type'] == 'numeric') {
                            $precision = $value;
                        } // if
                        break;
                    case 'data_scale':
                        if ($specs['type'] == 'numeric') {
                            $scale = $value;
                        } // if
                        break;
                    default:
                		// ignore
                } // switch
            } // foreach

            if ($columnarray['col_type'] == 'number') {
                // the generic NUMBER can be converted into INTEGER, DECIMAL or FLOAT
            	if (strlen($precision) == 0 AND empty($precision) AND strlen($scale) == 0 AND empty($scale)) {
                	$columnarray['col_type']      = 'float';
                	$specs                        = $colspecs['float'];
                	$precision                    = $specs['precision'];
                	$columnarray['col_precision'] = $precision;
                	// allow for minus sign
                    $columnarray['col_maxsize']   = $precision + 1;

            	} elseif ($scale > 0) {
            	    $columnarray['col_type']      = 'decimal';
            	    $specs                        = $colspecs['decimal'];
            	    if (empty($precision)) {
            	    	$precision                = $specs['precision'];
            	    } // if
            	    $columnarray['col_precision'] = $precision;
            	    $columnarray['col_scale']     = $scale;
            	    // allow for minus sign
                    $columnarray['col_maxsize']   = $precision + 1;
            	    // allow for decimal point
                    $columnarray['col_maxsize']   = $columnarray['col_maxsize'] + 1;

            	} else {
            	    $columnarray['col_type']      = 'integer';
            	    $columnarray['col_precision'] = $precision;
            	    // allow for minus sign
                    $columnarray['col_maxsize']   = $precision + 1;
                } // if
            } // if

            if ($columnarray['col_type'] == 'char') {
                if ($columnarray['col_maxsize'] == 1) {
                    // this can also be used as 'boolean'
                    $columnarray['col_type_native'] = $columnarray['col_type'].',boolean';
                } // if
            } // if

            if (!isset($columnarray['col_type_native'])) {
                $columnarray['col_type_native'] = $columnarray['col_type'];
            } // if

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

            if ($columnarray['col_type'] == 'float') {
                // the numbers are too large to store, so don't bother
                $columnarray['col_minvalue'] = null;
                $columnarray['col_maxvalue'] = null;
            } // if

            $out_array[] = $columnarray;
        } // while

        oci_free_statement($statement);

        return $out_array;

    } // ddl_showColumns

    // ****************************************************************************
    function ddl_showDatabases ($dbprefix=null)
    // obtain a list of existing database ('user' in Oracle) names.
    {
        // connect to database
        $this->connect() or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SELECT username FROM sys.all_users WHERE username NOT IN ('APEX_040000','CTXSYS','DBSNMP','FLOWS_020100','FLOWS_FILES','MDSYS','OUTLN','SYS','SYSTEM','TSMSYS','XDB') AND EXISTS (SELECT * FROM sys.all_tables WHERE all_tables.owner=all_users.username) ORDER BY username";
        $statement  = oci_parse($this->dbconnect, $this->query);
        $this->stmt = $statement;
        $result = oci_execute($statement) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple indexed array for each row
        while ($data = oci_fetch_array ($statement, OCI_ASSOC+OCI_RETURN_NULLS)) {
            $array[] = $data['USERNAME'];
        } // while

        $count = count($array);

        // write query to log file, if option is turned on
        logSqlQuery (null, null, $this->query, $count);

        oci_free_statement($statement);

        return $array;

    } // ddl_showDatabases

    // ****************************************************************************
    function ddl_showTables ($schema)
    // obtain a list of tables within the specified schema.
    {
        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $array = array();

        $schema = strtoupper($schema);

        // build the query string and run it
        $this->query = "SELECT table_name FROM sys.all_tables WHERE owner='$schema' ORDER BY table_name";
        $statement  = oci_parse($this->dbconnect, $this->query);
        $this->stmt = $statement;
        $result = oci_execute($statement) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple indexed array for each row
        while ($data = oci_fetch_array ($statement, OCI_ASSOC+OCI_RETURN_NULLS)) {
            $array[] = $data['TABLE_NAME'];
        } // while

        $count = count($array);

        // write query to log file, if option is turned on
        logSqlQuery (null, null, $this->query, $count);

        oci_free_statement($statement);

        return $array;

    } // ddl_showTables

    // ****************************************************************************
    function ddl_showTableKeys ($schema, $tablename)
    // obtain a list of keys (indexes) for this table.
    {
        // connect to database
        $this->connect($schema) or trigger_error($this, E_USER_ERROR);

        $array = array();

        $schema    = strtoupper($schema);
        $tablename = strtoupper($tablename);

        // build the query string and run it
        $this->query = "SELECT all_indexes.table_owner, all_indexes.table_name,
            CASE WHEN all_constraints.constraint_type='P' THEN 'PRIMARY' ELSE all_indexes.index_name END AS key_name,
            CASE WHEN all_indexes.uniqueness='UNIQUE' THEN 'T' ELSE 'F' END AS is_unique,
            LOWER(all_ind_columns.column_name) AS column_id,
            all_ind_columns.column_position AS seq_in_index
	        FROM sys.all_indexes
	        LEFT JOIN sys.all_ind_columns ON (all_ind_columns.index_owner=all_indexes.owner AND all_ind_columns.index_name=all_indexes.index_name)
	        LEFT JOIN sys.all_constraints ON (all_constraints.owner=all_indexes.table_owner AND all_constraints.index_name=all_indexes.index_name)
	        WHERE all_indexes.table_owner='$schema' AND all_indexes.table_name='$tablename'
	        ORDER BY key_name, seq_in_index, column_id";
        $statement = oci_parse($this->dbconnect, $this->query);
        $this->stmt = $statement;
        $result = oci_execute($statement) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($schema, $tablename, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($data = oci_fetch_array($statement, OCI_ASSOC+OCI_RETURN_NULLS)) {
            $array[] = array_change_key_case($data, CASE_LOWER);
        } // while

        $count = count($array);

        // write query to log file, if option is turned on
        logSqlQuery (null, null, $this->query, $count);

        oci_free_statement($statement);

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

        // look for any words enclosed in double quotes (user names, schema names)
        if ($count = preg_match_all('/"\w+"/', $string, $regs)) {
            foreach ($regs[0] as $word) {
                // now upshift them to make them valid
                $string = str_replace($word, strtoupper($word), $string);
            } // foreach
        } // if

        // set locking level
        switch ($this->row_locks){
            case 'SH':
                switch (strtoupper($this->row_locks_supp)) {
                	case 'R':
                	    $mode = 'ROW SHARE';
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
            $statement  = oci_parse($this->dbconnect, $this->query);
            $this->stmt = $statement;
            $result = oci_execute($statement) or trigger_error($this, E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery (null, null, $this->query);
            $this->query = '';
            oci_free_statement($statement);
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
    function __toString()
    // this is for use by the error handler
    {
        return $this->getErrorString();
    } // __toString

// ****************************************************************************
} // end class
// ****************************************************************************

?>
