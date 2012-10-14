<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class sqlsrv
// this version is for SQL Server
{
    // member variables
    var $client_info = '';              // output from sqlsrv_client_info()
    var $server_info = '';              // output from sqlsrv_server_info()

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
    var $query;                         // completed DML statement

    var $dbconnect;                     // database connection resource

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function sqlsrv ($dbname=null)
    {
        if (!empty($dbname)) {
            $result = $this->connect($dbname) or trigger_error($this, E_USER_ERROR);
        } else {
            $result = TRUE;
        } // if

        if (defined('TRANSIX_NO_AUDIT')) {
        	// do nothing
        } else {
            if (!class_exists('audit_tbl')) {
        	    // obtain definition of the audit_tbl class
        		require_once 'classes/audit_tbl.class.inc';
        	} // if
        } // if

        return $result;

    } // sqlsrv

    // ****************************************************************************
    function adjustData ($string_in)
    // modify string to escape any single quote with a second single quote
    // (do not use backslash as with MySQL)
    {
        $string_out = str_replace("'", "''", $string_in);

        return $string_out;

    } // adjustData

    // ****************************************************************************
    function adjustFrom ($from_str)
    // adjust 'JOIN dbname.tblname ON' to 'JOIN dbname.<schema>.tblname ON'.
    {
        global $SQLSRV_schema;

        $pattern1 = <<< END_OF_REGEX
/
(?<=join[ ])                # begins with 'join '
[ ]*                        # 0 or more spaces
["]?                        # optional quote
\w+                         # dbname
["]?                        # optional quote
\.\w+                       # .tblname
(?=[ ]+)                    # ends with 1 or more spaces
/xi
END_OF_REGEX;

        if ($count = preg_match_all($pattern1, $from_str, $regs)) {
        	foreach ($regs[0] as $string1) {
        		$array = array();
        		list($dbname, $tblname) = explode('.', $string1);
        		// insert schema name between the two
        		$string2 = "$dbname.$SQLSRV_schema.$tblname";

        		$from_str = str_replace($string1, $string2, $from_str);
        	} // foreach;
        } // if

        return $from_str;

    } // adjustFrom

    // ****************************************************************************
    function adjustGroupBy ($select_str, $group_str, $sort_str)
    // ensure GROUP_BY contains every field in the SELECT string, plus every field
    // in the ORDER_BY string.
    {
        if (preg_match('/WITH ROLLUP/i', $group_str, $regs)) {
            // this is not recognised, so remove it
        	$group_str = str_replace($regs[0], '', $group_str);
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
        $subquery   = "    SELECT $select_str\n    FROM $from_str $where_str $group_str";

        $select_str = '*';
        $from_str   = "(\n$subquery\n) AS x";
        $where_str  = "\nWHERE $having_str";
        $having_str = '';
        $group_str  = '';
        $sort_str   = unqualifyOrderBy($sort_str);

        return array($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str);

    } // adjustHaving

    // ****************************************************************************
    function adjustSelect ($input)
    // adjust for differences between MySQL and SQL Server.
    {
        $output = $input;

        $pattern1 = <<< END_OF_REGEX
/
(?<=concat\()                # 'concat('
(                            # start choice
 \w+[ ]*\([^\(\)]*\)         # 'FUNC(...)'
 |
 '(([^\\\']*(\\\.)?)*)'      # quoted string
 |
 \w+(\.\w+)?                 # 'word' or 'word.word'
 |
 ,                           # comma
 |
 [ ]*                        # 0 or more spaces
)                            # end choice
*                            # 0 or more times
[ ]*                         # 0 or more spaces
/xi
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
\w+[ ]*\([^\(\)]*\)         # 'FUNC(...)'
|
'(([^\\\']*(\\\.)?)*)'      # quoted string
|
\w+\.\w+                    # word dot word
|
\w+                         # word
/xi
END_OF_REGEX;

        // replace 'CONCAT(A, B, C)' with 'A + B + C'.
        if ($count = preg_match_all($pattern1, $output, $regs)) {
        	foreach ($regs[0] as $string1) {
        		$array = array();
        		$count = preg_match_all($pattern2, $string1, $regs2);
        		foreach ($regs2[0] as $value) {
        		    // trim leading and trailing spaces from each entry
        			$array[] = trim($value);
        		} // foreach
        		$string2 = implode('+', $array);     // rejoin with '+' as separator
        		// escape any '(' and ')' for use in a pattern
        		$string1 = str_replace('(', "\(", $string1);
        		$string1 = str_replace(')', "\)", $string1);
        		$output  = preg_replace('/concat\(' .$string1 .'\)/i', $string2, $output);
        	} // foreach;
        } // if

        // Replace TRUE/FALSE in CASE statements to 1/0.
        $search  = array('/THEN TRUE/i', '/ELSE TRUE/i', '/THEN FALSE/i', '/ELSE FALSE/i');
        $replace = array( 'THEN 1',       'ELSE 1',       'THEN 0',        'ELSE 0');
        $output  = preg_replace($search, $replace, $output);

        // Replace 'SUBSTR(...)' with 'SUBSTRING(...)'.
        $output  = preg_replace('/SUBSTR(?!ING)/i', 'SUBSTRING', $output);

        return $output;

    } // adjustSelect

    // ****************************************************************************
    function adjustWhere ($string_in)
    // certain MySQL expressions have to be converted as they are not valid, such as:
    // 'NOW()' to 'SYSDATETIME()'
    // 'DATE_ADD(field1 - INTERVAL $field2 unit)' to 'DATEADD(unit, +$field2, $field1)'
    // 'DATE_SUB(field1 - INTERVAL $field2 unit)' to 'DATEADD(unit, -$field2, $field1)'
    // [\'] (escaped quote) must be changed to [''] (double quote)
    {
        $string_out = $string_in;

        $string_out = preg_replace('/now\(\)/i', 'SYSDATETIME()', $string_out);

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
                if (preg_match("#\\\'#", $fieldvalue)) {
                    $fieldvalue = str_replace("\'", "''", $fieldvalue);
                    $array[$key] = $fieldname.$operator.$fieldvalue;
                	$modified = true;

                } elseif (preg_match('/^date_sub/i', $fieldname)) {
                    // contains 'DATE_SUB(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldname, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    $field3 = $fieldvalue;
                    // replace with 'DATEADD(unit, field2*-1, field1) op $field3'
                    $fieldname = "DATEADD($unit, $field2*-1, $field1)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($field3);
                    $modified = true;

            	} elseif (preg_match('/date_add/i', $fieldname)) {
                    // contains 'DATE_ADD(field1, INTERVAL field2 unit)', so extract 'field1, field2'
                    preg_match('/(?<=\().+(?=\))/', $fieldname, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    $field3 = $fieldvalue;
                    // replace with 'DATEADD(unit, field2, field1) op $field3'
                    $fieldname = "DATEADD($unit, $field2, $field1)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($field3);
                    $modified = true;

            	} elseif (preg_match('/^date_sub/i', $fieldvalue)) {
                    // contains 'DATE_SUB(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldvalue, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    // replace with 'fieldname op DATEADD(unit, field2*-1, field1)'
                    $fieldvalue = "DATEADD($unit, $field2*-1, $field1)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($fieldvalue);
                    $modified = true;

            	} elseif (preg_match('/^date_add/i', $fieldvalue)) {
                    // contains 'DATE_ADD(field1, INTERVAL field2 unit)', so extract 'field1, field2, unit'
                    preg_match('/(?<=\().+(?=\))/', $fieldvalue, $regs);
                    list($field1, $interval, $field2, $unit) = preg_split("/[\s,]+/", $regs[0]);
                    // replace with 'fieldname op DATEADD(unit, field2, field1)'
                    $fieldvalue = "DATEADD($unit, $field2, $field1)";
                    $array[$key] = $fieldname.' '.$operator.' '.trim($fieldvalue);
                    $modified = true;

            	} // if
            } // if
        } // foreach

        if ($modified) {
        	$string_out = implode(' ', $array);
        } // if

        // Replace TRUE/FALSE to 1/0.
        $search  = array('/=[ ]*TRUE/i', '/=[ ]*FALSE/i');
        $replace = array( '=1',           '=0');
        $string_out = preg_replace($search, $replace, $string_out);

        return $string_out;

    } // adjustWhere

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
    function commit ($dbname)
    // commit this transaction
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $result = sqlsrv_commit($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'COMMIT');
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT')) {
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
        global $serverName, $connectionInfo, $dbprefix;

        if (!empty($dbname) AND !empty($dbprefix)) {
			 if (!preg_match('/^(' .$dbprefix .')/i', $dbname)) {
    			// prefix may be different on different servers
                $dbname = $dbprefix .$dbname;
            } // if
        } // if

        $this->errors = array();
        $this->query  = '';
        //$this->dbname = $dbname;

        $dbconn = $this->dbconnect;

        if (!$dbconn) {
            // fill in default settings
            if (!isset($connectionInfo['CharacterSet'])) {
            	$connectionInfo['CharacterSet'] = 'UTF-8';
            } // if
            if (!isset($connectionInfo['ReturnDatesAsStrings'])) {
            	$connectionInfo['ReturnDatesAsStrings'] = true;
            } // if
            if (!empty($dbname)) {
            	$connectionInfo['Database'] = $dbname;
            	$this->dbname               = $dbname;
            } // if

            $dbconn = sqlsrv_connect($serverName, $connectionInfo) or trigger_error($this, E_USER_ERROR);
            if ($dbconn) {
                $this->dbconnect = $dbconn;

                $client_info = sqlsrv_client_info($dbconn);
                foreach ($client_info as $key => $value) {
                    if (empty($this->client_info)) {
                    	$this->client_info  =       $key.": ".$value;
                    } else {
                        $this->client_info .= ', ' .$key.": ".$value;
                    } // if
                } // if

                $server_info = sqlsrv_server_info($dbconn);
                foreach ($server_info as $key => $value) {
                    if (empty($this->server_info)) {
                        $this->server_info  =       $key.": ".$value;
                    } else {
                        $this->server_info .= ', ' .$key.": ".$value;
                    } // if
                } // if

                $this->query = '';
            } // if
        } // if
        if (!$dbconn) {
            return FALSE;
        } // if

        if (!empty($dbname) AND $dbname != $this->dbname) {
            $this->query = "USE [$dbname]";
            $result = sqlsrv_query($dbconn, $this->query) or trigger_error($this, E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery ($dbname, null, $this->query);
            $this->query = '';
            $this->dbname = $dbname;
        } // if

        return TRUE;

    } // connect

    // ****************************************************************************
    function deleteRecord ($dbname, $tablename, $fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        // build 'where' string using values for primary key
        $where = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (empty($where)) return;    // nothing to delete, so exit

        // build the query string and run it
        $this->query = "DELETE FROM $tablename WHERE $where";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $where, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteSelection ($dbname, $tablename, $selection, $from=null, $using=null)
    // delete a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $selection = $this->adjustWhere($selection);

        if (!empty($from) AND !empty($using)) {
            $this->query = "DELETE FROM $from USING $using WHERE $selection";
        } else {
            $this->query = "DELETE FROM $tablename WHERE $selection";
        } // if
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $selection, array());
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $count;

    } // deleteSelection

    // ****************************************************************************
    function fetchRow ($dbname, $result)
    // Fetch a row from the given result set (created with getData_serial() method).
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $row   = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
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

        $result = sqlsrv_free_stmt($resource);

        return $result;

    } // free_result

    // ****************************************************************************
    function getCount ($dbname, $tablename, $where)
    // get count of records that satisfy selection criteria in $where.
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

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

        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $query_data = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC);

        // if 'GROUP BY' was used then return the number of rows
        // (ignore GROUP BY if it is in a subselect)
        if (preg_match("/group by /", $this->query) == true AND !preg_match("/\(SELECT .+group by.+\)/i", $this->query)) {
            $count = sqlsrv_num_rows($result);
        } else {
            $count = $query_data[0];
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
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

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
            $from_str = $this->sql_from;
            $search_array  = array(  "LEFT JOIN",   "RIGHT JOIN",   "CROSS JOIN");
            $replace_array = array("\nLEFT JOIN", "\nRIGHT JOIN", "\nCROSS JOIN");
            $from_str = str_replace($search_array, $replace_array, $from_str);
            $from_str = $this->adjustFrom($from_str);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\nWHERE " .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "\nGROUP BY " .$this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
            //$group_str = "\nGROUP BY $this->sql_groupby";
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
            //$having_str = $this->sql_having;
        } else {
            $having_str = NULL;
        } // if

        if ($rows_per_page > 0) {
            // count the rows that satisfy this query
            $query = "SELECT count(*) FROM $from_str $where_str $group_str $having_str";
            $this->numrows = $this->getCount($dbname, $tablename, $query);

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

        $lock_str = null;
        if ($GLOBALS['transaction_has_started'] == TRUE) {
            if ($GLOBALS['lock_tables'] == FALSE) {
            	if (empty($this->row_locks)) {
                    // not defined locally, but may be defined globally
                	$this->row_locks = $GLOBALS['lock_rows'];
                } // if
                // deal with row locking (optional)
//                switch ($this->row_locks){
//                    case 'SH':
//                        $lock_str = 'FOR UPDATE';
//                        break;
//                    case 'EX':
//                        $lock_str = 'FOR UPDATE';
//                        break;
//                    default:
//                        $count = preg_match_all("/\w+/", $from_str, $regs);
//                        if ($count > 1) {
//                            $lock_str = 'FOR UPDATE OF ' .$tablename;
//                        } else {
//                            $lock_str = 'FOR UPDATE';
//                        } // if
//                } // switch
                $this->row_locks = null;
            } // if
        } // if

        // build the query string and run it
        if ($rows_per_page > 0) {
            // insert code for pagination ...

//            $limit  = $rows_per_page;
//            $offset = ($pageno - 1) * $rows_per_page;
//            $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str $lock_str";
//            $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);
//            // read first record starting at the specified offset
//            if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC, SQLSRV_SCROLL_ABSOLUTE, $offset)) {
//                $array[] = array_change_key_case($row, CASE_LOWER);
//                // read following rows until limit is reached
//                $offset = 1;
//            	while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC, SQLSRV_SCROLL_RELATIVE, $offset) AND count($array) < $limit) {
//                    $array[] = array_change_key_case($row, CASE_LOWER);
//                } // while
//            } // if

            $min_rows = (($pageno - 1) * $rows_per_page) +1;
            $max_rows = ($min_rows + $rows_per_page) -1;
            $this->query = "select * from ("
                         . "\nSELECT $select_str\n, ROW_NUMBER() OVER ($sort_str) AS rownum"
                         . "\nFROM $from_str $where_str $group_str $having_str $lock_str"
                         . "\n) AS x WHERE rownum BETWEEN $min_rows and $max_rows";

        } else {
            // read all available rows
            if (!empty($sort_str)) {
            	$sort_str = "\n$sort_str";
            } // if
            $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str $lock_str";
        } // if

        $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple associative array for each row
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        if ($rows_per_page == 0) {
            $this->numrows = sqlsrv_num_rows($result);
        } // if

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        sqlsrv_free_stmt($result);

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
            $select_str = $this->adjustSelect($this->sql_select);
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
            $from_str = $this->adjustFrom($from_str);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\nWHERE " .$this->adjustWhere($where);
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            $group_str = "\nGROUP BY " .$this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
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
            list($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str) = $this->adjustHaving($select_str, $from_str, $where_str, $group_str, $this->sql_having, $sort_str);
            //$having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        if (!is_null($rdc_limit) AND !is_null($rdc_offset)) {
        	//$limit_str = 'LIMIT ' .$rdc_limit .' OFFSET ' .$rdc_offset;
        	$min_rows = $rdc_offset;
        	$max_rows = $min_rows + $rdc_limit;
        } elseif ($rows_per_page > 0) {
            //$limit_str = 'LIMIT ' .$rows_per_page .' OFFSET ' .($pageno - 1) * $rows_per_page;
            $min_rows = (($pageno - 1) * $rows_per_page) +1;
            $max_rows = ($min_rows + $rows_per_page) -1;
        } // if

        // build the query string and run it
        if (isset($min_rows) AND isset($max_rows)) {
            // insert code for pagination ...
            $this->query = "select * from ("
                         . "\nSELECT $select_str\n, ROW_NUMBER() OVER ($sort_str) AS rownum"
                         . "\nFROM $from_str $where_str $group_str $having_str $lock_str"
                         . "\n) AS x WHERE rownum BETWEEN $min_rows and $max_rows";
            $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);
        } else {
            // read all available records
            if (!empty($sort_str)) {
            	$sort_str = "\n$sort_str";
            } // if
            $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str";
            $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);
        } // if

        $this->numrows = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        return $result;

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
        $errno = null;

        if ($errors = sqlsrv_errors()) {
            $errno  = $errors[0]['code'];
        } // if

        return $errno;

    } // getErrorNo

    // ****************************************************************************
    function getErrorString ()
    // return string containing details of last error.
    {
        $string = '';

        if (!empty($this->error_string)) {
            $string = $this->error_string;
            $this->error_string = null;

		} elseif ($errors = sqlsrv_errors()) {
            if (is_array($errors)) {
            	foreach ($errors as $error) {
                    if (empty($string)) {
                    	$string  = $error['message'];
                    } else {
                        $string .= "<br>\n" .$error['message'];
                    } // if
                } // foreach
            } // if

        } else {
            $conerr = getLanguageText('sys0001', $this->dbname); // 'Cannot connect to database'
            $string = $conerr;
        } // if

        return $string;

    } // getErrorString

    // ****************************************************************************
    function getErrorString2 ()
    // return additional information.
    {
        if ($this->dbconnect) {
        	$string  = 'Client Info: ' .$this->client_info ."<br>\n";
            $string .= 'Server Info: ' .$this->server_info;
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
        $this->errors = array();

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

		if (!empty($this->retry_on_duplicate_key)) {
        	if (!array_key_exists($this->retry_on_duplicate_key, $fieldspec)) {
        	    // this field does not exist, so remove it
        		$this->retry_on_duplicate_key = null;
        	} // if
        } // if

        // build 'where' string using values for primary key
	    $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);

        if (empty($auto_increment) AND empty($this->retry_on_duplicate_key)) {
	        // find out if a record with this primary key already exists
	        $query = "SELECT count(*) FROM $tablename WHERE $primary_key";
	        $count = $this->getCount($dbname, $tablename, $query);
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
		} // if

        // validate any optional unique/candidate keys
        if (!empty($this->unique_keys)) {
            // there may be several keys with several fields in each
            foreach ($this->unique_keys as $key) {
                $where = $this->buildKeyString ($fieldarray, $key);
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
            } // foreach
        } // if

        $repeat       = false;
        $repeat_count = 0;
        do {
            // insert this record into the database
            $cols = '';
            $vals = '';
            foreach ($fieldarray as $item => $value) {
                if (preg_match('/set|array|varray/i', $fieldspec[$item]['type'])) {
                    if (!empty($value)) {
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
                    	// enclose array in curly braces
                    	$value .= "$item='{" .$string1 ."}', ";
                    } // if
                } // if
                if (!array_key_exists('required',$fieldspec[$item])
                AND strlen($value) == 0 OR strtoupper(trim($value)) == 'NULL') {
                    // null entries are set to NULL, not '' (there is a difference!)
                    $cols .= "$item, ";
                    $vals .= "NULL, ";
                } else {
                    $cols .= "$item, ";
                    $vals .= "'" .$this->adjustData($value) ."', ";
                } // if
            } // foreach

            // remove trailing commas
            $cols = rtrim($cols, ', ');
            $vals = rtrim($vals, ', ');

            $this->query = 'INSERT INTO ' .$tablename .' (' .$cols .') VALUES (' .$vals .')';
            //$result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            $result = sqlsrv_query($this->dbconnect, $this->query);
            if ($result === false) {
                $errno = $this->getErrorNo();
                if ($errno == 23505 AND !empty($this->retry_on_duplicate_key)) {
                    // increment the specified field and try again
                    $fieldarray[$this->retry_on_duplicate_key]++;
                    $repeat = true;
                    $repeat_count++;
                    if ($repeat_count > 5) {
                        // too many retries, so turn this feature off
                    	$this->retry_on_duplicate_key = null;
                    } // if

                } elseif ($errno == 23505 AND is_True($this->no_duplicate_error)) {
                    // switch to 'update'
                    $old_array = where2array($primary_key);
                    $fieldarray = $this->updateRecord ($dbname, $tablename, $fieldarray, $old_array);
                    return $fieldarray;

                } elseif ($errno == 23505 AND is_True($this->no_duplicate_error)) {
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
			$this->query = "SELECT @@identity";
            $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            $identity = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC);
            $fieldarray[$auto_increment] = $identity[0];
            $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);
            // write query to log file, if option is turned on
            logSqlQuery ($dbname, $tablename, $this->query, $fieldarray[$auto_increment]);
		} // if

        if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditInsert($dbname, $tablename, $this->fieldspec, $primary_key, $fieldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        $this->numrows = 1;  // record has been inserted

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

        $result = sqlsrv_rollback($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'ROLLBACK');
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT')) {
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
        $this->query = "USE [$dbname]";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, $this->query);
        $this->query = '';

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

        $result = sqlsrv_begin_transaction($this->dbconnect);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'BEGIN TRANSACTION');
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

        // build update string from non-pkey fields
        $update = '';
        $pattern1 = '/(integer|decimal|numeric|float|real)/i';
        $pattern2 = '/^\w+[ ]*\(.+\)$/';  // function(...)
        foreach ($fieldarray as $item => $value) {
            // use this item if it IS NOT part of primary key
            if (!in_array($item, $this->primary_key)) {
                if (is_null($value) OR strtoupper(trim($value)) == 'NULL') {
                    // null entries are set to NULL, not '' (there is a difference!)
                    $update .= "$item=NULL,";
                } elseif (preg_match('/set|array|varray/i', $fieldspec[$item]['type'])) {
                    if (!empty($value)) {
                    	// assume a one-dimensional array
                    	$array1  = explode(',', $value);
                    	$string1 = '';
                    	foreach ($array1 as $value1) {
                    	    $value1 = $this->adjustData($value1);
                    		if (empty($string1)) {
                    			$string1 = '"' .$value1 .'"';
                    		} else {
                    		    $string1 .= ', "' .$value1 .'"';
                    		} // if
                    	} // foreach
                    	// enclose array in curly braces
                    	$update .= "$item='{" .$string1 ."}', ";
                    } // if
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
                    // change to the new value
                    $update .= "$item='" .$this->adjustData($value) ."', ";
                } // if
            } // if
        } // foreach

        // strip trailing comma
        $update = rtrim($update, ', ');

        // append WHERE clause to SQL query
        $this->query = "UPDATE $tablename SET $update WHERE $where";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        // get count of affected rows as there may be more than one
        $this->numrows = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows);

        if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            $auditobj =& RDCsingleton::getInstance('audit_tbl');
            // add record details to audit database
            $auditobj->auditUpdate($dbname, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
        } // if

        return $fieldarray;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($dbname, $tablename, $replace, $selection)
    // update a selection of records in a single operation.
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $this->query = "UPDATE $tablename SET $replace WHERE $selection";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        if ($count > 0) {
            if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
                $auditobj =& RDCsingleton::getInstance('audit_tbl');
                // add record details to audit database
                $auditobj->auditUpdateSelection($dbname, $tablename, $this->fieldspec, $selection, $replace);
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
        $colspecs['int']        = array('name' => 'INTEGER',
                                        'type' => 'integer',
                                        'minvalue' => -2147483648,
                                        'maxvalue' => 2147483647,
                                        'size' => 11);
        $colspecs['integer']    = array('name' => 'INTEGER',
                                        'type' => 'integer',
                                        'minvalue' => -2147483648,
                                        'maxvalue' => 2147483647,
                                        'size' => 11);
        $colspecs['smallint']   = array('name' => 'SMALLINT',
                                        'type' => 'integer',
                                        'minvalue' => -32768,
                                        'maxvalue' => 32767,
                                        'size' => 6);
        $colspecs['tinyint']    = array('name' => 'TINYINT',
                                        'type' => 'integer',
                                        'minvalue' => 0,
                                        'maxvalue' => 255,
                                        'size' => 3);
        $colspecs['decimal']    = array('name' => 'DECIMAL',
                                        'type' => 'numeric');
        $colspecs['numeric']    = array('name' => 'NUMERIC',
                                        'type' => 'numeric');

        $colspecs['money']      = array('name' => 'MONEY',
                                        'type' => 'numeric',
                                        'precision' => 19,
                                        'scale' => 4,
                                        'minvalue' => -922,337,203,685,477.5808,
                                        'maxvalue' => 922,337,203,685,477.5807);
        $colspecs['smallmoney'] = array('name' => 'SMALLMONEY',
                                        'type' => 'numeric',
                                        'precision' => 10,
                                        'scale' => 4,
                                        'minvalue' => -214748.3648,
                                        'maxvalue' => 214748.3647);
        $colspecs['bit']        = array('name' => 'BIT',
                                        'type' => 'bit');
        $colspecs['float']      = array('name' => 'FLOAT',
                                        'type' => 'float',
                                        'size' => 53);
        $colspecs['real']       = array('name' => 'REAL',
                                        'type' => 'float',
                                        'size' => 24);
        $colspecs['date']           = array('name' => 'DATE',
                                            'type' => 'date',
                                            'size' => 12);
        $colspecs['time']           = array('name' => 'TIME',
                                            'type' => 'time',
                                            'size' => 8);

        $colspecs['smalldatetime']  = array('name' => 'DATETIME',
                                            'type' => 'datetime',
                                            'size' => 20);
        $colspecs['datetime']       = array('name' => 'DATETIME',
                                            'type' => 'datetime',
                                            'size' => 24);
        $colspecs['datetime2']      = array('name' => 'DATETIME',
                                            'type' => 'datetime',
                                            'size' => 28);
        $colspecs['datetimeoffset'] = array('name' => 'DATETIMEOFFSET',
                                            'type' => 'datetime',
                                            'size' => 35);

        $colspecs['char']       = array('name' => 'CHAR',
                                        'type' => 'string',
                                        'size' => 8000);
        $colspecs['varchar']    = array('name' => 'CHARACTER VARYING',
                                        'type' => 'string',
                                        'size' => 2147483647);
        $colspecs['text']       = array('name' => 'TEXT',
                                        'type' => 'string',
                                        'size' => 2147483647);
        $colspecs['nchar']      = array('name' => 'NATIONAL CHAR',
                                        'type' => 'string',
                                        'size' => 4000);
        $colspecs['nvarchar']   = array('name' => 'NATIONAL CHARACTER VARYING',
                                        'type' => 'string',
                                        'size' => 2147483647);
        $colspecs['ntext']      = array('name' => 'NATIONAL TEXT',
                                        'type' => 'string',
                                        'size' => 1073741823);
        $colspecs['image']      = array('name' => 'IMAGE',
                                        'type' => 'blob',
                                        'size' => 2147483647);
        $colspecs['binary']     = array('name' => 'IMAGE',
                                        'type' => 'blob',
                                        'size' => 8000);
        $colspecs['varbinary']  = array('name' => 'IMAGE',
                                        'type' => 'blob',
                                        'size' => 2147483647);

        $colspecs['timestamp']  = array('name' => 'ROWVERSION',
                                        'type' => 'rowversion');
        $colspecs['rowversion'] = array('name' => 'ROWVERSION',
                                        'type' => 'rowversion');

        $colspecs['hierarchyid'] = array('name' => 'HIERARCHYID',
                                         'type' => 'string');
        $colspecs['sql_variant'] = array('name' => 'SQL_VARIANT',
                                         'type' => 'text',
                                         'size' => 900);
        $colspecs['table']       = array('name' => 'TABLE',
                                         'type' => 'string');
        $colspecs['xml']         = array('name' => 'XML',
                                         'type' => 'string');
        $colspecs['uniqueidentifier'] = array('name' => 'UNIQUEIDENTIFIER',
                                              'type' => 'string',
                                              'size' => 36);

        // these are spatial types
        $colspecs['geometry']   = array('name' => 'GEOMETRY',
                                        'type' => 'geometry',
                                        'size' => 2147483647);
        $colspecs['geography']  = array('name' => 'GEOGRAPHY',
                                        'type' => 'geography',
                                        'size' => 2147483647);

        // these are here just for compatability with MySQL
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
    function ddl_showColumns ($dbname, $tablename)
    // obtain a list of column names within the selected database table.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $out_array = array();

        // connect to the selected database
        $this->query = "USE [$dbname]";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        // build the query string and run it
        $this->query = "SELECT isc.*, sc.is_identity"
                     ." FROM sys.columns AS sc"
                     ." LEFT JOIN sys.tables AS st ON (st.object_id=sc.object_id)"
                     ." LEFT JOIN information_schema.columns AS isc ON (isc.table_catalog='$dbname' AND isc.table_name='$tablename' AND isc.column_name=sc.name)"
                     ." WHERE st.name='$tablename'"
                     ." ORDER BY ordinal_position";
        $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        $colspecs = $this->ddl_getColumnSpecs();

        // identify primary and other unique keys
        $tablekeys = $this->ddl_showTableKeys($dbname, $tablename);
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
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $row = array_change_key_case($row, CASE_LOWER);
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

            $columnarray['column_id'] = $row['column_name'];
            $columnarray['col_type']  = $row['data_type'];
            if (in_array($columnarray['column_id'], $pkey)) {
            	$columnarray['col_key'] = 'PRI';
            } elseif (in_array($columnarray['column_id'], $ukey)) {
                $columnarray['col_key'] = 'UNI';
            } // if
            $columnarray['column_seq'] = $row['ordinal_position'];
            if (is_True($row['is_nullable'])) {
                $columnarray['col_null'] = 'Y';
            } else {
                $columnarray['col_null'] = 'N';
            } // if
            // look for default enclosed in "('" and "')"
            if (preg_match("/(?<=\(').+(?='\))/", $row['column_default'], $regs)) {
                $columnarray['col_default'] = $regs[0];
            } // if
            if (is_True($row['is_identity'])) {
                $columnarray['col_auto_increment'] = TRUE;
            } // if

            unset($precision, $scale, $minvalue, $maxvalue);
            $type  = $columnarray['col_type'];
    	    $specs = $colspecs[$type];

    	    if (isset($specs['size'])) {
                $columnarray['col_maxsize'] = $specs['size'];
            } // if

            if ($specs['type'] == 'integer') {
                if ($row['numeric_precision'] > 0) {
                	$columnarray['col_maxsize'] = $row['numeric_precision'];
                } // if
            } // if

            if ($specs['type'] == 'string') {
                if (!is_null($row['character_maximum_length']) AND $row['character_maximum_length'] > 0) {
                	$columnarray['col_maxsize'] = $row['character_maximum_length'];
                } else {
            	    $columnarray['col_maxsize'] = $specs['size'];
                } // if
            } // if

            if ($specs['type'] == 'numeric') {
                $precision                    = $row['numeric_precision'];
                $columnarray['col_precision'] = $row['numeric_precision'];
                $columnarray['col_maxsize']   = $row['numeric_precision'] + 1;
            } // if
            if ($specs['type'] == 'numeric') {
                $scale                    = $row['numeric_scale'];
                $columnarray['col_scale'] = $row['numeric_scale'];
                if ($row['numeric_scale'] > 0) {
                    $columnarray['col_maxsize'] = $columnarray['col_maxsize'] + 1;
                } // if
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

        sqlsrv_free_stmt($result);

        return $out_array;

    } // ddl_showColumns

    // ****************************************************************************
    function ddl_showDatabases ($dbprefix=null)
    // obtain a list of existing database names.
    {
        // connect to database
        $this->connect() or trigger_error($this, E_USER_ERROR);

        $array = array();

        // build the query string and run it
        $this->query = "SELECT * FROM sys.databases WHERE name NOT IN ('master','model','msdb','tempdb') ORDER BY name";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery (null, null, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $array[] = $row['name'];
        } // while

        sqlsrv_free_stmt($result);

        return $array;

    } // ddl_showDatabases

    // ****************************************************************************
    function ddl_showTables ($dbname)
    // obtain a list of tables within the specified schema.
    {
        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $array = array();

        // connect to the selected database
        $this->query = "USE [$dbname]";
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);

        // build the query string and run it
        $this->query = "SELECT * FROM INFORMATION_SCHEMA.tables WHERE table_catalog = '$dbname' ORDER BY table_name";
        $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, $this->query, $count);

        // convert result set into an associative array for each row
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $array[] = $row['TABLE_NAME'];
        } // while

        sqlsrv_free_stmt($result);

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
        $this->query = "SELECT tc.table_name, constraint_type, column_name, ordinal_position
                          FROM INFORMATION_SCHEMA.table_constraints AS tc
                     LEFT JOIN INFORMATION_SCHEMA.key_column_usage AS kcu ON (kcu.CONSTRAINT_NAME=tc.CONSTRAINT_NAME)
                         WHERE tc.table_catalog='$dbname' AND tc.table_name='$tablename'
                      ORDER BY tc.TABLE_NAME, tc.CONSTRAINT_TYPE, kcu.ORDINAL_POSITION";

        $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);

        $count = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count);

        // convert result set into a simple indexed array for each row
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $row = array_change_key_case($row, CASE_LOWER);
            if ($row['constraint_type'] == 'PRIMARY KEY') {
            	$row['key_name']   = 'PRIMARY';
            	$row['is_primary'] = TRUE;
            	$row['is_unique']  = TRUE;
            } else {
                $row['key_name']   = $row['constraint_name'];
                $row['is_primary'] = FALSE;
                $row['is_unique']  = TRUE;
            } // if
            $row['column_id']    = $row['column_name'];
            $row['seq_in_index'] = $row['ordinal_position'];
            $array[] = $row;
        } // while

        sqlsrv_free_stmt($result);

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
//            $this->query = "LOCK TABLE $string IN $mode MODE";
//            $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
//            // write query to log file, if option is turned on
//            logSqlQuery (null, null, $this->query);
//            $this->query = '';
//            return true;
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
