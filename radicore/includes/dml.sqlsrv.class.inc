<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class sqlsrv
// this version is for SQL Server
{
    // connection settings
    var $dbname;                        // database name
    var $dbname_prev='???';             // previous database name
    var $dbschema;                      // schema name
    var $dbprefix;
    var $serverName;
    var $connectionInfo;

    // server settings
    var $client_info = '';              // output from sqlsrv_client_info()
    var $server_info = '';              // output from sqlsrv_server_info()

    var $alias_names = array();         // array of 'alias=expression' clauses
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
    var $skip_offset;                   // force diferent offset after rows have been skipped
    var $table_locks;                   // array of tables to be locked
    var $temp_tables;                   // array of temporary table names
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
    var $sql_where_append;              // string which is too complex for where2array() function
    var $query;                         // completed DML statement

    var $dbconnect;                     // database connection resource

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ($args=null)
    {
        if (is_string($args)) {
            $dbname               = $args;
        } else {
            $this->dbschema       =& $args['SQLSRV_schema'];
            $dbname               =& $args['dbname'];
            $this->dbprefix       =& $args['dbprefix'];
            $this->serverName     =& $args['serverName'];
            $this->connectionInfo =& $args['connectionInfo'];
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

    } // __construct

    // ****************************************************************************
    function __destruct ()
    {
        if (is_resource($this->dbconnect)) {
            $res = sqlsrv_close ($this->dbconnect);
        } // if

    } // __destruct

    // ****************************************************************************
    function adjustData ($string_in)
    // modify string to escape any single quote with a second single quote
    // (do not use backslash as with MySQL)
    {
        $pattern = <<< END_OF_PATTERN
/
^                       # begins with
\w+[ ]*\(               # 'function('
(                       # start choice
\w+                     # word
|                       # or
\(.+?\)                 # '(...)' string inside parentheses
|,[ ]*                  # or ','
'(?P<quoted_string>.+)' # '<quoted_string>' named pattern
)+                      # end choice
/imsx
END_OF_PATTERN;

        $string_out = '';
        if (preg_match($pattern, $string_in, $regs, PREG_OFFSET_CAPTURE)) {
            // found "function(......)" so see if it contains a 'quoted_string'
            if (isset($regs['quoted_string'])) {
                $regs['quoted_string'][0] = trim($regs['quoted_string'][0]);
                if (!empty($regs['quoted_string'][0])) {
                    // a quoted string has been found, so escape any quotes within it
                    $quoted_string = $regs['quoted_string'][0];
                    $length1 = strlen($quoted_string);
                    $offset1 = $regs['quoted_string'][1];
                    $quoted_string = str_replace("'", "''", $quoted_string);
                    $string_out = substr_replace($string_in, $quoted_string, $offset1, $length1);
                } else {
                    $string_out = str_replace("'", "''", $string_in);
                } // if
            } else {
                $string_out = str_replace("'", "''", $string_in);
            } // if
        } else {
            $string_out = str_replace("'", "''", $string_in);
        } // if

        $string_out = preg_replace('/now\(\)/iu', 'SYSDATETIME()', $string_out);

        return $string_out;

    } // adjustData

    // ****************************************************************************
    function adjustCONCAT ($input)
    // replace 'CONCAT(A, B, C)' with 'A + B + C'.
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
/xims
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
/xims
END_OF_REGEX;

        if ($count = preg_match_all($pattern1, $input, $regs)) {
            foreach ($regs[0] as $string1) {
                $array = array();
                $count = preg_match_all($pattern2, $string1, $regs2);
                foreach ($regs2[0] as $value) {
                    // trim leading and trailing spaces from each entry
                    if (substr($value, 0, 1) == "'") {
                        // value is quoted so use as-is
                        $array[] = trim($value);
                    } else {
                        // this is a field, so cast it to string to avoid conversion errors
                        $array[] = "CAST(".trim($value)." AS NVARCHAR(MAX))";
                    } // if
                } // foreach
                $string2 = implode('+', $array);     // rejoin with '+' as separator
                // escape any '(' and ')' for use in a pattern
                $string1 = str_replace('(', "\(", $string1);
                $string1 = str_replace(')', "\)", $string1);
                $string1 = str_replace('[', "\[", $string1);
                $string1 = str_replace(']', "\]", $string1);
                $string1 = str_replace('.', "\.", $string1);
                $string1 = str_replace('?', "\?", $string1);
                $pattern = '#concat\(' .$string1 .'\)#iu';
                $output  = preg_replace($pattern, $string2, $output);
            } // foreach;
        } // if

        return $output;

    } // adjustCONCAT

    // ****************************************************************************
    function adjustFrom ($from_str, $where_str)
    // make any adjustments to the FROM string
    {
        // look for 'CROSS JOIN x ON (...)' and move 'ON (...)' to end of $where string
        if (preg_match('/CROSS[ ]JOIN[ ]+\w*[ ]+(?<on>ON[ ]+.*?)(?=(LEFT|RIGHT))/ims', $from_str, $regs)) {
            $on_str = $regs['on'];
            // remove ' ON (...)' from $from_str
            $from_str = str_ireplace($on_str, '', $from_str);
            // change ' ON ' to ' AND ' and append to $where_str
            $on_str = str_ireplace('ON ', ' AND ', $on_str);
            $where_str .= $on_str;
        } // if

        if (preg_match('/[ ]+AS[ ]+unsigned[ ]+int/i', $from_str)) {
            $from_str = preg_replace('/[ ]+AS[ ]+unsigned[ ]+int/iu', ' AS int', $from_str);
        } // if

        $from_str = $this->adjustCONCAT($from_str);

        if (!empty($this->temp_tables)) {
            $skip_errors = array();
            $from_str = $this->adjustTempTable ($from_str, $this->temp_tables, $skip_errors);
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
        $group_array       = preg_split('/, */', $group_str);
        $group_array_count = $group_array;

        list($field_alias, $field_orig) = extractFieldNamesIndexed ($select_str);
        foreach ($field_alias as $ix => $fieldname) {
        	if ($fieldname == $field_orig[$ix]) {
        	    // $fieldname is not an alias for an expression, so include in $group_array
        		if (!in_array($fieldname, $group_array)) {
        			$group_array[]       = $fieldname;
                    $group_array_count[] = $fieldname;
        		} // if
            } else {
                if (preg_match('/\([ ]*SELECT\b/i', $field_orig[$ix])) {
                    // this is a subquery, so ignore it
                } elseif (preg_match('/^\w+\s*\(/i', $field_orig[$ix])) {
                    // this is a function (word(...)), so ignore it
                } else {
                    // field name is aliased, but use the original name instead
                    list($original, $alias) = getFieldAlias3($field_orig[$ix]);
                    if (preg_match('/^\d/', $original)) {
                        // this begins with a number, so ignore it
                    } elseif (!in_array($original, $group_array)) {
                        $group_array[] = $original;
                    } // if
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
        $group_str       = implode(', ', $group_array);
        $group_str_count = implode(', ', $group_array_count);

        return array($group_str, $group_str_count);

    } // adjustGroupBy

    // ****************************************************************************
    function adjustHaving ($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str, $union)
    // make 'SELECT ... FROM ... WHERE ...' into a subquery so that the HAVING clause can
    // become the WHERE clause of the outer query.
    // This is because the HAVING clause cannot reference an expression by its alias name.
    {
        // Replace TRUE/FALSE to 1/0.
        $search  = array('/=[ ]*TRUE/iu', '/=[ ]*FALSE/iu');
        $replace = array( '=1',            '=0');
        $having_str = preg_replace($search, $replace, $having_str);

        $orderby_array = array();
        if (!empty($sort_str)) {
            $sort_str = preg_replace('/^ORDER BY /iu', '', $sort_str);
            $orderby_array = explode(',', $sort_str);
            $orderby_array = array_map("trim", $orderby_array);
        } // if

        // turn select string into an associative array of 'alias=expression' pairs
        $select_array = extractAliasNames($select_str);
        // convert to 'expression=alias'
        $select_array = array_flip($select_array);

        $seq_array = array();  // holds 'asc' or 'desc' for each field
        foreach ($orderby_array as $ix => &$fieldname) {
            if (preg_match('/( asc| desc)$/i', $fieldname, $regs)) {
                $seq_array[$ix] = $regs[0];
                $fieldname = trim(substr($fieldname, 0, -strlen($regs[0])));
            } // if
            if (array_key_exists($fieldname, $select_array)) {
                // replace name with alias
                $orderby_array[$ix] = $select_array[$fieldname];
            } // if
        } // foreach

        // put back any 'asc' or 'desc' sequences
        foreach ($seq_array as $ix => $seq) {
            $orderby_array[$ix] = $orderby_array[$ix].$seq;
        } // foreach

        if (!empty($orderby_array)) {
            $sort_str = 'ORDER BY '.implode(', ', $orderby_array);
            $sort_str = unqualifyOrderBy($sort_str);
        } // if

        // put current query into a subqery
        $subquery   = "    SELECT $select_str\n    FROM $from_str $where_str $group_str";

        if (!empty($union)) {
            $subquery .= "\nUNION ALL\n$union";
            $union     = '';
        } // if

        $select_str = '*';
        $from_str   = "(\n$subquery\n) AS x";
        $having_str = unqualifyWhere($having_str, '*');
        $where_str  = "\nWHERE $having_str";
        $having_str = '';
        $group_str  = '';

        return array($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str);

    } // adjustHaving

    // ****************************************************************************
    function adjustOrderBy ($orderby, $select)
    // adjust for differences between MySQL and SQL Server.
    {
        $orderby_array = explode(',', $orderby);
        $orderby_array = array_map("trim", $orderby_array);

        // turn select string into an associative array of 'alias=expression' pairs
        $select_array = extractFieldNamesAssoc($select);

        foreach ($orderby_array as $ix => $fieldname) {
            if (array_key_exists($fieldname, $select_array)) {
                // cannot use alias name, so use expression instead
                $orderby_array[$ix] = $select_array[$fieldname];
            } // if
        } // foreach

        // turn array back into a string
        $orderby = implode(', ', $orderby_array);

        return $orderby;

    } // adjustOrderBy

    // ****************************************************************************
    function adjustSelect ($input)
    // adjust for differences between MySQL and SQL Server.
    {
        $output = $input;

        // replace 'SELECT ... WHERE ... LIMIT 1' with 'SELECT TOP 1 ... WHERE ...'
        $pattern1 = <<< END_OF_REGEX
/
(?P<select>                     # named pattern
(,|\s|\()*[ ]*select\s[^0-9]{1} # 'SELECT x' (but not 'SELECT 1')
)                               # end named pattern
.*?                             # any characters, non-greedy
(                               # start choice
\)[ ]AS[ ]\w+                   # ') AS x'
|                               # or
(?P<limit>LIMIT[ ]\d+)          # 'LIMIT n', named pattern
)                               # end choice
/xims
END_OF_REGEX;

        $offset = 0;
        while ($count = preg_match($pattern1, $output, $regs, PREG_OFFSET_CAPTURE, $offset)) {
            // look for 'LIMIT 1' and replace with 'TOP 1'
            $string1 = $regs[0][0];
            $start   = $regs[0][1];
            $select  = $regs['select'][0];
            if (!empty($regs['limit'])) {
                $select  = substr($select, 0, -1);  // strip last character
                $digits  = trim(substr($regs['limit'][0], 5));
                $string2 = str_replace($regs['limit'][0], '', $string1);  // remove LIMIT
                $string3 = substr_replace($string2, "\n{$select}TOP $digits ", 0, strlen($select));
                $output  = substr_replace($output, $string3, $start, strlen($string1));
                $offset = $start +  strlen($string3);
            } else {
                $offset = $start +  strlen($string1);  // SELECT does not end with LIMIT
            } // if
        } // while

        // ********************************************************************

        // look for any '(expression) AS alias' clauses
        $alias_names = extractAliasNames($output);
        foreach ($alias_names as $alias => $expression) {
            // if an expression refers to an alias then replace that alias name with its corresponding expression
            foreach ($alias_names as $alias1 => $expression1) {
                if ($alias1 != $alias) {
                    $pattern = "/=[ ]*{$alias1}\b/imsu";
                    if (preg_match($pattern, $expression, $regs)) {
                        // found, so replace any '=alias1' with '=expression1'
                        $expression = preg_replace($pattern, '='.$expression1.' ', $expression);
                    } // if
                } // if
            } // foreach
            $alias_names[$alias] = $expression;
        } // foreach

        $this->alias_names = $alias_names;  // save for adjustWhere() method

        // search $output and replace any '=alias' with '=expression'
        foreach ($alias_names as $alias => $expression) {
            $pattern = "/=[ ]*{$alias}\b/imsu";
            if (preg_match($pattern, $output, $regs)) {
                $output = preg_replace($pattern, '='.$expression.' ', $output, -1, $count);
            } // endwhile
        } // foreach

        // ********************************************************************

        // replace: (SELECT GROUP_CONCAT(table.field ORDER BY .... SEPARATOR ',') FROM table WHERE a=b) AS alias
        // with   : alias=STUFF((SELECT ','+field FROM table WHERE user_id=mnu_user.user_id FOR XML PATH('')) , 1, 1, '' ),
        $pattern2 = <<< END_OF_REGEX
/
(                          # start choice
  \w+                      # word
  |                        # or
  '(([^\\\']*(\\\.)?)*)'   # quoted string
  |                        # or
  [ ]*,[ ]*                # [space]comma[space]
)                          # end choice
/xims
END_OF_REGEX;

        if ($count = preg_match_all("/(?<= group_concat\().+?(\)[ ]AS[ ]\w+)/ims", $output, $regs)) {
            foreach ($regs[0] as $string1) {
                $count = preg_match('/.+(?=[ ]order[ ]by)/i', $string1, $regs2);
                if ($count > 0) {
                    $part1 = trim($regs2[0]);
                } else {
                    $count = preg_match('/.+(?=[ ]separator)/i', $string1, $regs2);
                    $part1 = trim($regs2[0]);
                } // if
                $count = preg_match('/(?<=order[ ]by[ ]).+(?=[ ]separator)/i', $string1, $regs2);
                if ($count > 0) {
                    $orderby = trim($regs2[0]);
                } else {
                    preg_match('/\w+/', $part1, $regs3);  // extract first word in $part1
                    $orderby = $regs3[0];
                } // if
                $count = preg_match("/(?<=separator[ ])'.+?'/i", $string1, $regs2);
                $separator = trim($regs2[0]);
                $count = preg_match('/(?<=from[ ])(\w+[ ])+(\(\w+(\.\w+)?=\w+(\.\w+)?\))*(?=[ ]where[ ])?/i', $string1, $regs2);
                $from  = trim($regs2[0]);
                if (isset($regs2[1])) {
                    $search = rtrim($regs2[1]);
                    if (substr($from, -strlen($search)) == $search) {
                        $from = substr($from, 0, strlen($from)-strlen($search));
                    } // if
                } // if
                $count = preg_match('/(?<=where[ ])[^\)]*(?=[ ]order[ ]by)?/i', $string1, $regs2);
                $where = trim($regs2[0]);
                $count = preg_match('/(?<=\)[ ]as[ ])\w+/i', $string1, $regs2);
                $alias = trim($regs2[0]);

                $string1 = str_replace('(', "\(", $string1);
                $string1 = str_replace(')', "\)", $string1);
                $string1 = str_replace('[', "\[", $string1);
                $string1 = str_replace(']', "\]", $string1);
                $string1 = str_replace('.', "\.", $string1);
                $string1 = str_replace('?', "\?", $string1);

                $count = preg_match_all($pattern2, $part1, $regs);
                if ($count > 0) {
                    $part2 = null;
                    foreach ($regs[0] as $ix => $value) {
                        if (preg_match('/\w+/', $value)) {
                            // this is a word
                            $part2 .= "CAST($value AS VARCHAR)";
                        } elseif (preg_match("/'(([^\\\']*(\\\.)?)*)'/", $value)) {
                            // this is a quoted string
                            $part2 .= $value;
                        } elseif (preg_match('/[ ]*,[ ]*/', $value)) {
                            // this is a comma concatenator
                            $part2 .= ' + ';  // string concatenator
                        } // if
                    } // foreach
                    $part1 = $part2;
                } // if

                $string2 = "$alias=STUFF((SELECT $separator+$part1 FROM $from WHERE $where ORDER BY $orderby FOR XML PATH('')) , 1, 1, '' )";
                $output  = preg_replace('/\(select[ ]group_concat\(' .$string1 .'/iu', $string2, $output, 1);
            } // foreach
        } // if

        // ********************************************************************

        $output = $this->adjustCONCAT($output);

        // ********************************************************************

        // replace 'CONCAT_WS(',', A, B, C)' with "(COALESCE(A, '') + COALESCE(', ' + B, '') + COALESCE(', ' + C, ''))".
        $pattern3 = <<< END_OF_REGEX
/
(?<concat>concat_ws[ ]*\()   # 'concat_ws('
(                            # start choice
 \w+[ ]*\([^\(\)]*\)         # 'FUNC(...)'
 |
 (?<separator>'(([^\\\']*(\\\.)?)*)')      # quoted string
 |
 \w+(\.\w+)?                 # 'word' or 'word.word'
 |
 ,                           # comma
 |
 [ ]*                        # 0 or more spaces
)                            # end choice
*                            # 0 or more times
[ ]*                         # 0 or more spaces
/xims
END_OF_REGEX;

        $offset = 0;
        while ($count = preg_match($pattern3, $output, $regs, PREG_OFFSET_CAPTURE, $offset)) {
            $length    = strlen($regs[0][0]);
            $concat    = $regs['concat'];
            $separator = $regs['separator'][0];
            $field_string = substr($regs[0][0], strlen($regs['concat'][0])+strlen($separator)+1);
            $field_array  = explode(',', $field_string);
            $new_string = '(COALESCE('.array_shift($field_array).", '')";
            while (!empty($field_array)){
                $new_string .= " + COALESCE($separator + " .array_shift($field_array).", '')";
            } // while
            $output = substr_replace($output, $new_string, $regs['concat'][1], $length);
            $offset = $offset +$regs[0][1];
        } // while

        // ********************************************************************

        // look for any "CASE WHEN ... THEN ... ELSE ... END" clauses and replace
        // any alias names with their original expressions
        $pattern1 = <<<EOD
/
CASE[ ]+WHEN.+?[ ]END
/imsx
EOD;

$pattern2 = <<<EOD
/
(?<=[ ]when[ ])(?P<when>.+?)(?<=[ ]then[ ])(?P<then>.+?)
/imsx
EOD;

$pattern3 = <<<EOD
/
(?<=[ ]else[ ])(?P<else>.+?)END
/imsx
EOD;

        $offset = 0;
        while (preg_match($pattern1, $output, $regs1, PREG_OFFSET_CAPTURE, $offset)) {
            foreach ($regs1 as $result) {
                $case_string  = $result[0];
                $case_start   = $result[1];
                $case_length  = strlen($case_string);
                $offset2 = 0;
                $search  = array();
                $replace = array();
                while (preg_match($pattern2, $case_string, $regs2, PREG_OFFSET_CAPTURE, $offset2)) {
                    if (isset($regs2['when']) AND !empty($regs2['when'][0])) {
                        $when_string = $regs2['when'][0];
                        $when_start  = $regs2['when'][1];
                        $when_length = strlen($when_string);
                        $offset2 += $when_length+6;

                        $parts = preg_split('/[ ](AND|OR)[ ]/i', $when_string);
                        foreach ($parts as $part) {
                            list($name, $operator, $value) = splitNameOperatorValue($part);
                            if (array_key_exists($name, $alias_names)) {
                                $search[]  = $name;
                                $replace[] = $alias_names[$name];
                            } // if
                        } // if

                    } // if
                    if (isset($regs2['then']) AND !empty($regs2['then'][0])) {
                        $then_string = $regs2['then'][0];
                        $then_start  = $regs2['then'][1];
                        $then_length = strlen($then_string);
                        $offset2 += $then_length+6;

                        if (array_key_exists($then_string, $alias_names)) {
                            $search[]  = $then_string;
                            $replace[] = $alias_names[$then_string];
                        } // if
                    } // if
                } // while
                if (preg_match($pattern3, $case_string, $regs3, PREG_OFFSET_CAPTURE, $offset2)) {
                    if (isset($regs3['else']) AND !empty($regs3['else'][0])) {
                        $else_string = $regs3['else'][0];
                        $else_start  = $regs3['else'][1];
                        $else_length = strlen($else_string);

                        if (array_key_exists($else_string, $alias_names)) {
                            $search[]  = $else_string;
                            $replace[] = $alias_names[$else_string];
                        } // if
                    } // if
                } // if
                if (!empty($replace)) {
                    // found alias names which need to be replaced with original expressions
                    $case_string = str_replace($search, $replace, $case_string);
                    $output = substr_replace($output, $case_string, $case_start, $case_length);
                } // if
                $offset =+ $case_start + strlen($case_string);
            } // foreach
        } // while

        // ********************************************************************

        // Replace TRUE/FALSE in CASE statements to 1/0.
        $search  = array('/THEN TRUE/iu', '/ELSE TRUE/iu', '/THEN FALSE/iu', '/ELSE FALSE/iu');
        $replace = array( 'THEN 1',        'ELSE 1',        'THEN 0',         'ELSE 0');
        $output  = preg_replace($search, $replace, $output);

        // Replace 'SUBSTR(...)' with 'SUBSTRING(...)'.
        $output  = preg_replace('/SUBSTR(?!ING)/iu', 'SUBSTRING', $output);

        $output = $this->fixReservedWords($output);

        return $output;

    } // adjustSelect

    // ****************************************************************************
    function fixReservedWords($input)
    // find any reserved words and enclose them in double quotes
    {
        $pattern = <<<EOD
/
(?<=\W)         # not a word before
(percent|foo)   # reserved words
(?=\W)          # not a word after
/imsx
EOD;
        $output = '';

        while (preg_match($pattern, $input, $regs, PREG_OFFSET_CAPTURE)) {
            foreach ($regs as $ix => $found) {
                if ($ix == 0) {
                    $word  = $found[0];
                    $start = $found[1];
                    $output .= substr($input, 0, $start);               // copy string-before
                    $input   = substr($input, $start+strlen($word));    // remove string_before
                    $output .= '['.$word.']';
                    break;
                } // if
            } // foreach
        } // if

        $output .= $input;  // append what is left of input

        return $output;

    } // fixReservedWords

    // ****************************************************************************
    function adjustTempTable ($query, &$temp_tables, &$skip_errors)
    // convert from MySQL format to SQLSRV format.
    // $temp_tables is PASSED BY REFERENCE as it may be amended.
    // $skip_errors is PASSED BY REFERENCE as it may be amended.
    {
        $pattern1 = <<< END_OF_REGEX
/
^                           # begins with
DROP[ ]TEMPORARY[ ]TABLE[ ] #
(IF[ ]EXISTS[ ])?           # optional
(?<tblname>\w*)             # table name
/xism
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^                               # begins with
CREATE[ ]TEMPORARY[ ]TABLE[ ]   #
(IF[ ]NOT[ ]EXISTS[ ])?         # optional
(?<tblname>\w*)                 # table name
(                               # start choice
  [ ]LIKE[ ](?<tbllike>[^;]*)   # source table name
|                               # or
  [ ](?<other>[^;]*)            # something else
)                               # end choice
/xism
END_OF_REGEX;

        if (preg_match($pattern1, $query, $regs)) {
            $query = "DROP TABLE #{$regs['tblname']}";
            $skip_errors[] = 3701;

        } elseif (preg_match($pattern2, $query, $regs)) {
            if (!empty($regs['tbllike'])) {
                $query = "SELECT TOP 0 * INTO #{$regs['tblname']} FROM {$regs['tbllike']}";
            } else {
                $query = "CREATE TABLE #{$regs['tblname']} {$regs['other']}";
            } // if
            $temp_tables[] = $regs['tblname'];

        } else {
            // insert '#' in ront of each temp table name
            foreach ($temp_tables as $tblname) {
                $query = preg_replace("/\b{$tblname}\b/i", "#{$tblname}", $query);
            } // foreach
        } // if

        return $query;

    } // adjustTempTable

    // ****************************************************************************
    function adjustWhere ($string_in)
    // certain MySQL expressions have to be converted as they are not valid, such as:
    // 'NOW()' to 'SYSDATETIME()'
    // 'DATE_ADD(field1 - INTERVAL $field2 unit)' to 'DATEADD(unit, +$field2, $field1)'
    // 'DATE_SUB(field1 - INTERVAL $field2 unit)' to 'DATEADD(unit, -$field2, $field1)'
    // [\'] (escaped quote) must be changed to [''] (double quote)
    {
        $string_out = $string_in;

        $string_out = preg_replace('/now\(\)/iu', 'SYSDATETIME()', $string_out);

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
                    // replace [\'] (escaped quote) with [''] (double quote)
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

        // replace 'SELECT ... WHERE ... LIMIT 1' with 'SELECT TOP 1 ... WHERE ...'
        $pattern1 = <<< END_OF_REGEX
/
(?P<select>\([ ]*select[ ][0-9]?)   # 'SELECT ' or 'SELECT 1', named pattern
.*?                                 # any characters, non-greedy
(                                   # start choice
\)[ ]AS[ ]\w+                       # ') AS x'
|                                   # or
(?P<limit>LIMIT[ ]\d+)              # 'LIMIT n', named pattern
|                                   # or
(?P<subselect>select[ ])            # nested 'SELECT ', named pattern
)                                   # end choice
/xims
END_OF_REGEX;

        $offset = 0;
        while ($count = preg_match($pattern1, $string_out, $regs, PREG_OFFSET_CAPTURE, $offset)) {
            $string1 = $regs[0][0];
            $start   = $regs[0][1];
            $prefix  = $regs['select'][0];
            if (!empty($regs['subselect'])) {
                $offset = $start + 10;  // select contains subselect, so skip over first select
            } elseif (!empty($regs['limit'])) {
                $digits  = trim(substr($regs['limit'][0], 5));
                $string2 = str_replace($regs['limit'][0], '', $string1);  // remove LIMIT
                $string3 = substr_replace($string2, "(SELECT TOP $digits ", 0, strlen($prefix));
                $string_out  = substr_replace($string_out, $string3, $start, strlen($string1));
                $offset = $start +  strlen($string3);
            } else {
                $offset = $start +  strlen($string1);  // SELECT does not end with LIMIT
            } // if
        } // while

        // search $output and replace any '=alias' with '=expression'
        foreach ($this->alias_names as $alias => $expression) {
            $pattern = "/=[ ]*{$alias}\b/imsu";
            if (preg_match($pattern, $string_out, $regs)) {
                $string_out = preg_replace($pattern, '='.$expression.' ', $string_out, -1, $count);
            } // endwhile
        } // foreach


        // Replace TRUE/FALSE with 1/0.
        $search  = array('/=[ ]*TRUE/iu', '/=[ ]*FALSE/iu');
        $replace = array( '=1',            '=0');
        $string_out = preg_replace($search, $replace, $string_out);

        $string_out = $this->fixReservedWords($string_out);

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

        $start_time = getMicroTime();
        $result = sqlsrv_commit($this->dbconnect);
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'COMMIT', null, $start_time, $end_time);
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        	// do nothing
	    } else {
            $auditobj = RDCsingleton::getInstance('audit_tbl');
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
            $start_time = getMicroTime();

            // fill in default settings
            if (!isset($this->connectionInfo['CharacterSet'])) {
            	$this->connectionInfo['CharacterSet'] = 'UTF-8';
            } // if
            if (!isset($this->connectionInfo['ReturnDatesAsStrings'])) {
            	$this->connectionInfo['ReturnDatesAsStrings'] = true;
            } // if
            if (!empty($dbname)) {
            	$this->connectionInfo['Database'] = $dbname;
            	$this->dbname                     = $dbname;
            } // if

            //$dbconn = sqlsrv_connect($this->serverName, $this->connectionInfo) or trigger_error($this, E_USER_ERROR);
            $dbconn = sqlsrv_connect($this->serverName, $this->connectionInfo);
            if ($dbconn === false) {
                if (preg_match('/^(258)$/', $this->getErrorNo())) {
                    // timeout error, so try again
                    sleep(1);  // pause for 1 second
                    $dbconn = sqlsrv_connect($this->serverName, $this->connectionInfo);
                } // if
                if ($dbconn === false) {
                    trigger_error($this, E_USER_ERROR);
                } // if
            } // if
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

                $this->query = "SET IMPLICIT_TRANSACTIONS OFF";
                $result = sqlsrv_query($dbconn, $this->query) or trigger_error($this, E_USER_ERROR);

                $this->query = '';

                // write query to log file, if option is turned on
                $end_time = getMicroTime();
                logSqlQuery ($dbname, null, 'CONNECT', null, $start_time, $end_time);
            } // if
        } // if
        if (!$dbconn) {
            return FALSE;
        } // if

        //if (!empty($dbname) AND $dbname != $this->dbname_prev) {
        if (!empty($dbname)) {
            $start_time = getMicroTime();

            $this->query = "USE [$dbname]";
            $result = sqlsrv_query($dbconn, $this->query) or trigger_error($this, E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery ($dbname, null, $this->query);
            $this->query = '';
            $this->dbname = $dbname;

            // write query to log file, if option is turned on
            $end_time = getMicroTime();
            logSqlQuery ($dbname, null, $this->query, null, $start_time, $end_time);
        } // if

        $this->dbname_prev = $dbname;

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
        $this->query = "DELETE FROM {$this->dbname}.{$this->dbschema}.$tablename WHERE $where";
        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $end_time = getMicroTime();

        // get count of affected rows as there may be more than one
        $this->numrows = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows, $start_time, $end_time);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj = RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $where, $fieldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
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
            //$this->query = "DELETE FROM $from USING $using WHERE $selection";
            // multi-table delete does not work in this DBMS, so use standard delete with foreign keys
            $this->query = "DELETE FROM $tablename WHERE $selection";
        } else {
            $this->query = "DELETE FROM $tablename WHERE $selection";
        } // if
        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $end_time = getMicroTime();

        $count = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count, $start_time, $end_time);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj = RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditDelete($dbname, $tablename, $this->fieldspec, $selection, array());
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
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

        if (preg_match('/^(select )/ims', $where)) {
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

        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $query_data = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC);

        // if 'GROUP BY' was used then return the number of rows
        // (ignore GROUP BY if it is in a subselect)
        if (preg_match("/group[ ]by[ ]/im", $this->query) == true AND !preg_match("/\(SELECT[ ].+group by.+\)/im", $this->query)) {
            $count = sqlsrv_num_rows($result);
            if ($count === false) {  // BUG!! so have to count the rows manually
                $count = 0;
                if (!empty($query_data)) {
                    $count = 1;
                    while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                        $count++;
                    } // while
                } // if
            } // if
        } else {
            $count = $query_data[0];
        } // if
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count, $start_time, $end_time);
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
            // insert <newline> in front of every JOIN statement for readability
            $search_array  = array("/(?<!\n)LEFT JOIN/", "/(?<!\n)RIGHT JOIN/", "/(?<!\n)CROSS JOIN/", "/(?<!\n)INNER JOIN/");
            $replace_array = array(      "\nLEFT JOIN",        "\nRIGHT JOIN",        "\nCROSS JOIN",        "\nINNER JOIN");
            $from_str = preg_replace($search_array, $replace_array, $from_str);
            $from_str = $this->adjustFrom($from_str, $where);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\nWHERE " .$this->adjustWhere($where);
        } // if

        if (!empty($this->sql_where_append)) {
            if (empty($where_str)) {
                $where_str = "\nWHERE {$this->sql_where_append}";
            } else {
                $where_str .= " AND {$this->sql_where_append}";
            } // if
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            // note that there are two versions of $group_str
            list($group_str, $group_str_count) = $this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
            $group_str       = "\nGROUP BY " .$group_str;
            $group_str_count = "\nGROUP BY " .$group_str_count;
        } else {
            $group_str       = NULL;
            $group_str_count = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $this->sql_orderby = $this->adjustOrderBy($this->sql_orderby, $select_str);
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
        } else {
            $sort_str = '';
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            list($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str) = $this->adjustHaving ($select_str, $from_str, $where_str, $group_str, $this->sql_having, $sort_str, $this->sql_union);
            $group_str       = null;
            $having_str      = null;
            $this->sql_union = null;
            //$having_str = $this->sql_having;
        } else {
            $having_str = NULL;
        } // if

        if ($rows_per_page > 0) {
            // count the rows that satisfy this query
            if (empty($this->sql_union)) {
                $query = "SELECT count(*) FROM $from_str $where_str $group_str_count $having_str";
            } else {
                // build query
                $query = "SELECT count(*) FROM (\nSELECT $select_str FROM $from_str $where_str $group_str_count $having_str \nUNION ALL\n {$this->sql_union} \n) AS x";
            } // if
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
            if (!empty($this->skip_offset)) {
                $min_rows = $this->skip_offset;  // use pre-calculated value
            } else {
                $min_rows = (($pageno - 1) * $rows_per_page) +1;
            } // if
            $max_rows = ($min_rows + $rows_per_page) -1;
            if (empty($sort_str)) {
                // default sort sequence is via primary key
                $string = implode(',', $this->primary_key);
                $string = qualifyOrderby($string, $tablename, $this->fieldspec, $select_str, $from_str);
                $sort_str = "ORDER BY $string";
            } // if
            if (empty($this->sql_union)) {
                $this->query = "SELECT * FROM ("
                             . "\nSELECT $select_str\n, ROW_NUMBER() OVER ($sort_str) AS rownum"
                             . "\nFROM $from_str $where_str $group_str $having_str $lock_str"
                             . "\n) AS x WHERE rownum BETWEEN $min_rows and $max_rows";
            } else {
                $sort_str = preg_replace('/^ORDER BY /iu', '', $sort_str);  // remove leading 'ORDER BY'
                $sort_str = "ORDER BY ".unqualifyOrderBy($sort_str);
                $this->query = "SELECT * FROM ("
                             . "\nSELECT *, ROW_NUMBER() OVER ($sort_str) AS rownum FROM ("
                             . "\nSELECT $select_str"
                             . "\nFROM $from_str \n$where_str $group_str $having_str"
                             . "\nUNION ALL"
                             . "\n{$this->sql_union}"
                             . "\n) AS x) AS y"
                             . "\nWHERE rownum BETWEEN $min_rows and $max_rows $sort_str";
            } // if

        } else {
            // read all available rows
            if (!empty($sort_str)) {
            	$sort_str = "\n$sort_str";
            } // if
            if (empty($this->sql_union)) {
                $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str $sort_str";
            } else {
                $this->query = "SELECT $select_str \nFROM $from_str $where_str $group_str $having_str";
                $this->query .= "\nUNION ALL\n{$this->sql_union}";
                $this->query .= " $sort_str";
            } // if
        } // if

        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);

        // convert result set into a simple associative array for each row
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $array[] = array_change_key_case($row, CASE_LOWER);
        } // while

        if ($rows_per_page == 0) {
            $this->numrows = sqlsrv_num_rows($result);
        } // if
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows, $start_time, $end_time);

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
            // insert <newline> in front of every JOIN statement for readability
            $search_array  = array("/(?<!\n)LEFT JOIN/", "/(?<!\n)RIGHT JOIN/", "/(?<!\n)CROSS JOIN/", "/(?<!\n)INNER JOIN/");
            $replace_array = array(      "\nLEFT JOIN",        "\nRIGHT JOIN",        "\nCROSS JOIN",        "\nINNER JOIN");
            $from_str = preg_replace($search_array, $replace_array, $from_str);
            $from_str = $this->adjustFrom($from_str, $where);
        } // if

        // incorporate optional 'where' criteria
        $where = trim($where);
        if (empty($where)) {
            $where_str = '';
        } else {
            $where_str = "\nWHERE " .$this->adjustWhere($where);
        } // if

        if (!empty($this->sql_where_append)) {
            if (empty($where_str)) {
                $where_str = "\nWHERE {$this->sql_where_append}";
            } else {
                $where_str .= " AND {$this->sql_where_append}";
            } // if
        } // if

        // incorporate optional GROUP BY parameters
        if (!empty($this->sql_groupby)) {
            list($group_str, $group_str_count) = $this->adjustGroupBy ($select_str, $this->sql_groupby, $this->sql_orderby);
            $group_str       = "\nGROUP BY " .$group_str;
        } else {
            $group_str = NULL;
        } // if

        // incorporate optional sort order
        if (!empty($this->sql_orderby)) {
            $this->sql_orderby = $this->adjustOrderBy($this->sql_orderby, $select_str);
            //$this->sql_orderby = qualifyOrderby($this->sql_orderby, $tablename, $this->fieldspec, $select_str, $from_str);
            $sort_str = "ORDER BY $this->sql_orderby $this->sql_orderby_seq";
            $this->sql_orderby = null;
        } else {
            $sort_str = '';
        } // if

        // incorporate optional HAVING parameters
        if (!empty($this->sql_having)) {
            list($select_str, $from_str, $where_str, $group_str, $having_str, $sort_str) = $this->adjustHaving($select_str, $from_str, $where_str, $group_str, $this->sql_having, $sort_str, $this->sql_union);
            //$having_str = "HAVING $this->sql_having";
        } else {
            $having_str = NULL;
        } // if

        if (!is_null($rdc_limit) OR !is_null($rdc_offset)) {
        	$min_rows = $rdc_offset;
            if ($rdc_limit > 0) {
                $max_rows = $min_rows + $rdc_limit;
            } // if
        } elseif ($rows_per_page > 0) {
            //$limit_str = 'LIMIT ' .$rows_per_page .' OFFSET ' .($pageno - 1) * $rows_per_page;
            $min_rows = (($pageno - 1) * $rows_per_page) +1;
            $max_rows = ($min_rows + $rows_per_page) -1;
        } // if

        $lock_str = null;
        //$lock_str = 'NOLOCK';
        if ($GLOBALS['transaction_has_started'] === TRUE) {
            // for SQL SERVER all serial reads are done with a separate connection, and the following
            // statement MUST be issued if a transaction has already started with another connection
            $this->query = "SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED";
            $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            // write query to log file, if option is turned on
            logSqlQuery ($dbname, null, $this->query);
            $this->query = '';
        } // if

        // build the query string and run it
        if (isset($min_rows) OR isset($max_rows)) {
            if (isset($min_rows) AND isset($max_rows)) {
                $rownum = "rownum BETWEEN $min_rows and $max_rows";
            } else {
                $rownum = "rownum > $min_rows";
            } // if
            // default sort sequence is via primary key
            if (empty($sort_str)) {
                $keys = array();
                foreach ($this->primary_key as $value) {
                    $keys[] = "{$tablename}.{$value}";  // qualify each field name
                } // foreach
                $sort_str = "ORDER BY ".implode(',', $keys);
            } // if
            if (empty($this->sql_union)) {
                $this->query = "SELECT * FROM ("
                             . "\nSELECT $select_str\n, ROW_NUMBER() OVER ($sort_str) AS rownum"
                             . "\nFROM $from_str $lock_str $where_str $group_str $having_str"
                             . "\n) AS x WHERE $rownum";
            } else {
                $sort_str = substr($sort_str, 9);  // remove leading 'ORDER BY'
                $sort_str = "ORDER BY ".unqualifyOrderBy($sort_str);
                $this->query = "SELECT * FROM ("
                             . "\nSELECT *, ROW_NUMBER() OVER ($sort_str) AS rownum FROM ("
                             . "\nSELECT $select_str"
                             . "\nFROM $from_str $lock_str\n$where_str $group_str $having_str"
                             . "\nUNION ALL"
                             . "\n{$this->sql_union}"
                             . "\n) AS x) AS y"
                             . "\nWHERE $rownum $sort_str";
            } // if
            $start_time = getMicroTime();
            $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);
            $end_time = getMicroTime();
        } else {
            // read all available records
            if (!empty($sort_str)) {
            	$sort_str = "\n$sort_str";
            } // if
            if (empty($this->sql_union)) {
                $this->query = "SELECT $select_str \nFROM $from_str $lock_str $where_str $group_str $having_str $sort_str";
            } else {
                $this->query = "SELECT $select_str \nFROM $from_str $lock_str $where_str $group_str $having_str";
                $this->query .= "\nUNION ALL\n{$this->sql_union}";
                $this->query .= " $sort_str";
            } // if
            $start_time = getMicroTime();
            $result = sqlsrv_query($this->dbconnect, $this->query, array(), array('scrollable' => SQLSRV_CURSOR_STATIC)) or trigger_error($this, E_USER_ERROR);
            $end_time = getMicroTime();
        } // if

        $this->numrows = sqlsrv_num_rows($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows, $start_time, $end_time);

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
            //$conerr = getLanguageText('sys0001', $this->dbname); // 'Cannot connect to database'
            $conerr = $GLOBALS['php_errormsg'];
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
            $string .= 'Server Info: ';
            $server_info = sqlsrv_server_info($this->dbconnect);
            foreach ($server_info as $key => $value) {
                $string .= "$key: $value, ";
            } // if
            $string = rtrim($string, ', ');
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

        // find out if any field in the primary key has 'identity' (auto_increment) set
		$auto_increment  = '';
        $identity_insert = FALSE;
		foreach ($this->primary_key as $pkey){
			if (isset($fieldspec[$pkey]['auto_increment'])) {
			    $this->retry_on_duplicate_key = null;  // this feature cannot be used with auto_increment
			    if (!empty($fieldarray[$pkey]) AND $fieldarray[$pkey] > 0) {
			    	// value has been supplied manually, so set this to stop an error
                    $this->query = "SET IDENTITY_INSERT [{$tablename}] ON";
                    $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
                    logSqlQuery ($dbname, null, $this->query);
                    $identity_insert = TRUE;
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
        $pattern1 = '/(integer|decimal|numeric|float|real|double)/i';
        $pattern2 = '/^\w+[ ]*\(.*\)$/imsx';  // function(...)
        $start_time = getMicroTime();
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
                } elseif (strlen($value) == 0 AND isset($fieldspec[$item]['type']) AND preg_match($pattern1, $fieldspec[$item]['type'])) {
                    // cannot use empty string for numeric fields, so use NULL instead
                    $cols .= "$item, ";
                    $vals .= "NULL, ";
                } elseif ($fieldspec[$item]['type'] == 'blob' AND substr($value, 0, 2) == '0x') {
                    // this is a headecimal number, so don't enclose in quotes
                    $cols .= "$item, ";
                    $vals .= "$value, ";
                } elseif (is_array($this->allow_db_function) AND in_array($item, $this->allow_db_function) AND preg_match($pattern2, $value)) {
                    // this is a function, so change to the new value (without enclosing quotes)
                    $cols .= "$item, ";
                    $vals .= $this->adjustData($value) .", ";
                } else {
                    $cols .= "$item, ";
                    $vals .= "'" .$this->adjustData($value) ."', ";
                } // if
            } // foreach

            // remove trailing commas
            $cols = rtrim($cols, ', ');
            $vals = rtrim($vals, ', ');

            $cols = $this->fixReservedWords($cols);

            $this->query = 'INSERT INTO ' .$tablename .' (' .$cols .') VALUES (' .$vals .')';
            //$result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            $result = sqlsrv_query($this->dbconnect, $this->query);
            if ($result === false) {
                $errno = $this->getErrorNo();
                if ($errno == 2627) {
                    if (!empty($this->retry_on_duplicate_key)) {
                        // increment the specified field and try again
                        $fieldarray[$this->retry_on_duplicate_key]++;
                        $repeat = true;
                        $repeat_count++;
                        if ($repeat_count > 5) {
                            // too many retries, so turn this feature off
                    	    $this->retry_on_duplicate_key = null;
                        } // if

                    } elseif (is_True($this->update_on_duplicate_key)) {
                        // switch to 'update'
                        $old_array = where2array($primary_key);
                        $fieldarray = $this->updateRecord ($dbname, $tablename, $fieldarray, $old_array);
                        return $fieldarray;

                    } elseif (is_True($this->no_duplicate_error)) {
                        // this is a duplicate, but don't fail
                        $this->numrows = 0;

                    } else {
                        trigger_error($this, E_USER_ERROR);
                    } // if

                } else {
            	    trigger_error($this, E_USER_ERROR);
                } // if
            } else {
                $repeat = false;
                $this->numrows = 1;  // record has been inserted
            } // if
        } while ($repeat == true);
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, 1, $start_time, $end_time);

		if (!empty($auto_increment)) {
			// obtain the last value used by auto_increment
			//$this->query = "SELECT @@identity";
            $this->query = "SELECT SCOPE_IDENTITY()";
            $start_time = getMicroTime();
            $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            $identity = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC);
            $end_time = getMicroTime();
            $fieldarray[$auto_increment] = $identity[0];
            $primary_key = $this->buildKeyString ($fieldarray, $this->primary_key);
            // write query to log file, if option is turned on
            logSqlQuery ($dbname, $tablename, $this->query, $fieldarray[$auto_increment], $start_time, $end_time);

        } elseif ($identity_insert == TRUE) {
            $this->query = "SET IDENTITY_INSERT [{$tablename}] OFF";
            $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
            logSqlQuery ($dbname, null, $this->query);
            $identity_insert = FALSE;
		} // if

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj = RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditInsert($dbname, $tablename, $this->fieldspec, $primary_key, $fieldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
        } // if

        $this->numrows = 1;  // record has been inserted

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
            $temp_tables = array();  // list of names of temp tables
            foreach ($query_array as $query_part) {
                $this->query = $query_part;
                $skip_errors = array();  // list of allowable errors
                $this->query = $this->adjustTempTable($this->query, $temp_tables, $skip_errors);
                $result = sqlsrv_query($this->dbconnect, $this->query);
                if ($result === false) {
                    $errno  = $this->getErrorNo();
                    if (in_array($errno, $skip_errors)) {
                        // ignore this error
                    } else {
                        trigger_error($this, E_USER_ERROR);
                    } // if
                } // if
            } // foreach
            $this->temp_tables = $temp_tables;
            if (count($query_array) == 1) {
                // only a single query, so return result in full
                if (is_bool($result)) {
                    return $result;
                } elseif (preg_match('/^(INSERT|UPDATE|DELETE)/i', $this->query)) {
                    return sqlsrv_rows_affected ($result);
                } else {
                    $array = array();
                    while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                        $array[] = array_change_key_case($row, CASE_LOWER);
                    } // while
                    sqlsrv_free_stmt($result);
                    return $array;
                } // if
            } // if
            return true;
        } // if

        return $result;

    } // multiQuery

    // ****************************************************************************
    function prepareAndExecuteQuery ($dbname, $tablename, $query, $params, $output_type='string')
    // prepare and execute a single query, with an optional result
    {
        $this->errors = array();

        // connect to database
        $this->connect($dbname) or trigger_error($this, E_USER_ERROR);

        $stmnt = sqlsrv_query($this->dbconnect, $query, $params) or trigger_error($this, E_USER_ERROR);

        if (!empty($output_type)) {
            while ( sqlsrv_fetch( $stmnt)) {
                switch ($output_type) {
                    case 'string':
                        $result = sqlsrv_get_field( $stmnt, 0, SQLSRV_PHPTYPE_STRING ( SQLSRV_ENC_CHAR)) or trigger_error($this, E_USER_ERROR);
                        break;
                    default:
                        $result = sqlsrv_get_field( $stmnt, 0) or trigger_error($this, E_USER_ERROR);
                } // switch
            } // while
        } // if

        sqlsrv_free_stmt($stmnt);

        return $result;

    } // prepareAndExecuteQuery

    // ****************************************************************************
    function rollback ($dbname)
    // rollback this transaction due to some sort of error.
    {
        $this->errors = array();

        if (!$this->dbconnect) {
            // not connected yet, so do nothing
            return FALSE;
        } // if

        $start_time = getMicroTime();
        $result = sqlsrv_rollback($this->dbconnect);
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'ROLLBACK', null, $start_time, $end_time);
        $this->query = '';

        if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        	// do nothing
	    } else {
            $auditobj = RDCsingleton::getInstance('audit_tbl');
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

        $start_time = getMicroTime();
        $result = sqlsrv_begin_transaction($this->dbconnect);
        if (!$result) {
            $errors = sqlsrv_errors();
            trigger_error($errors[0]['code'], E_USER_ERROR);
        } // if
        $end_time = getMicroTime();

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, null, 'BEGIN TRANSACTION', null, $start_time, $end_time);
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
                //if (strlen($where2) > 0 AND $where1 <> $where2) {
                if (strlen($where2) > 0 AND strcasecmp($where1, $where2) <> 0) {
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
        $pattern2 = '/^\w+[ ]*\(.*\)$/imsx';  // function(...)
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
                } elseif ($fieldspec[$item]['type'] == 'blob' AND substr($value, 0, 2) == '0x') {
                    // this is a headecimal number, so don't enclose in quotes
                    $update .= "$item=$value";
                } elseif (is_array($this->allow_db_function) AND in_array($item, $this->allow_db_function) AND preg_match($pattern2, $value)) {
                    // this is a function, so change to the new value (without enclosing quotes)
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
        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $end_time = getMicroTime();

        // get count of affected rows as there may be more than one
        $this->numrows = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $this->numrows, $start_time, $end_time);

        if ($this->audit_logging) {
        	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        		// do nothing
	        } else {
	            $auditobj = RDCsingleton::getInstance('audit_tbl');
	            // add record details to audit database
	            $auditobj->auditUpdate($dbname, $tablename, $this->fieldspec, $where, $fieldarray, $oldarray);
	            $this->errors = array_merge($auditobj->getErrors(), $this->errors);
			} // if
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
        $start_time = getMicroTime();
        $result = sqlsrv_query($this->dbconnect, $this->query) or trigger_error($this, E_USER_ERROR);
        $end_time = getMicroTime();

        $count = sqlsrv_rows_affected($result);

        // write query to log file, if option is turned on
        logSqlQuery ($dbname, $tablename, $this->query, $count, $start_time, $end_time);

        if ($count > 0) {
            if ($this->audit_logging AND !defined('TRANSIX_NO_AUDIT')) {
            	if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
        			// do nothing
		        } else {
	                $auditobj = RDCsingleton::getInstance('audit_tbl');
	                // add record details to audit database
	                $auditobj->auditUpdateSelection($dbname, $tablename, $this->fieldspec, $selection, $replace);
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
                                        'type' => 'bit',
                                        'size' => 1);
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
        $colspecs['boolean']    = array('name' => 'BOOLEAN',
                                        'type' => 'boolean',
                                        'size' => 1);
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

            // some columns have the option of being used as BOOLEAN
//            if ($columnarray['col_maxsize'] == 1) {
//            	if ($columnarray['col_type'] == 'char') {
//                    $columnarray['col_type'] = 'char,boolean';
//                } // if
//            } elseif ($columnarray['col_type'] == 'smallint') {
//                $columnarray['col_type'] = 'smallint,boolean';
//            } // if

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
        $this->query = "SELECT tc.table_name, tc.constraint_type, tc.constraint_name, kcu.column_name, kcu.ordinal_position
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
    function __toString()
    // this is for use by the error handler
    {
        return $this->getErrorString();
    } // __toString

// ****************************************************************************
} // end class
// ****************************************************************************

?>
