<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions

if (file_exists('include.subsystem.inc')) {
    // process optional includes from current subsystem directory
	include('include.subsystem.inc');
} // if

// modify INCLUDE_PATH
$include_path = ini_get('include_path');
$include_path .= PATH_SEPARATOR .'../menu';
$include_path .= PATH_SEPARATOR .'../audit';
$include_path .= PATH_SEPARATOR .'../workflow';
ini_set('include_path', $include_path);

unset($include_path);

$transaction_has_started = false;
if (!isset($use_HTTPS)) {
	$use_HTTPS = false;
} // if

// try to find a copy of CONFIG.INC
if (@fopen('config.inc', 'r', true)) {
    // found in current include_path
	require_once 'config.inc';
} else if (@fopen('../../INCLUDES/config.inc', 'r')) {
    // found in a higher directory
    require_once '../../INCLUDES/config.inc';
} else {
    // not found, so this should error
    require_once 'config.inc';
} // if

require_once 'error.inc';
require_once 'language_detection.inc';

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require_once 'std.singleton.php4.inc';
    require_once 'include.xml.php4.inc';
} else {
    // PHP 5 uses different code
    require_once 'std.singleton.php5.inc';
    require_once 'include.xml.php5.inc';
} // if

if (ini_get('precision') < 15) {
	$precision = ini_set('precision', 15);
} // if
unset($precision);

if (extension_loaded('mbstring')) {
	ini_set('mbstring.internal_encoding', 'UTF-8');
} // if

// ****************************************************************************
if (!function_exists('addPreviousSearchButton')) {
	function addPreviousSearchButton ($buttons_in)
    // add 'previous search' button to current array of buttons
    {
        $done = false;  // add 'previous search' button only once
        foreach ($buttons_in as $button_data) {
            // copy from input to output area
            $buttons_out[] = $button_data;
            if (preg_match('/SRCH/i', $button_data['pattern_id'], $regs) AND !$done) {
                // found task_id with pattern 'search', so add an extra button
                $buttons_out[] = array('task_id' => 'previous_search',
                                       'button_text' => 'Previous Search',
                                       'context_preselect' => 'N');
                $done = true;
            } // if
        } // foreach

        return $buttons_out;

    } // addPreviousSearchButton
} // if

// ****************************************************************************
if (!function_exists('adjustDate')) {
	function adjustDate ($date, $adjustment, $units='days')
    // adjust a date value by a specified number of units (days, weeks or months).
    {
        $dateobj =& singleton::getInstance('date_class');

        switch (strtolower($units)) {
        	case 'days':
        		$out_date = $dateobj->addDays($date, $adjustment);
        		break;

        	case 'weeks':
        		$out_date = $dateobj->addWeeks($date, $adjustment);
        		break;

        	case 'months':
        		$out_date = $dateobj->addMonths($date, $adjustment);
        		break;

        	default:
        	    // "Unknown units in call to adjustDate()"
        	    trigger_error(getLanguageText('sys0118'), E_USER_ERROR);
        		break;
        } // switch

        return $out_date;

    } // adjustDate
} // if

// ****************************************************************************
if (!function_exists('adjustDateTime')) {
    function adjustDateTime ($datetime, $adjustment)
    // adjust a date/time value by a specified amount.
    {
        if (is_string($datetime)) {
        	// remove any internal dashes and colons
            $time = str_replace('-:', '', $datetime);
            // convert time into a unix timestamp
        	$time1 = mktime(substr($time,0,2), substr($time,2,2), 0, 2, 2, 2005);
        } else {
            $time1 = $datetime;
        } // if

        // make the adjustment
        $new1 = strtotime($adjustment, $time1);
        // convert unix timstamp into display format
        $new2 = date('Y-m-d H:i:s', $new1);

        return $new2;

    } // adjustDateTime
} // if

// ****************************************************************************
if (!function_exists('adjustTime')) {
    function adjustTime ($time, $adjustment)
    // adjust a time value by a specified amount.
    {
    	// remove any internal colons
        $time = str_replace(':', '', $time);
        // convert time into a unix timestamp
    	$time1 = mktime(substr($time,0,2), substr($time,2,2), 0, 2, 2, 2005);
        // make the adjustment
        $new1 = strtotime($adjustment, $time1);
        // convert unix timstamp into display format
        $new2 = date('H:i:s', $new1);

        return $new2;

    } // adjustTime
} // if

// ****************************************************************************
if (!function_exists('append2ScriptSequence')) {
    function append2ScriptSequence ($next)
    // append details of next task to $_SESSION['script_sequence']
    {
        if (preg_match('/INTERNET|BATCH/i', $_SESSION['logon_user_id'])) {
        	return;
        } // if

        if (!is_array($next)) {
        	return;
        } // if

        $next['inserted_by'] = $GLOBALS['task_id'];

        $_SESSION['script_sequence'][] = $next;

        return;

    } // append2ScriptSequence
} // if

// ****************************************************************************
if (!function_exists('array2range')) {
    function array2range ($input)
    // take an array of rows and put the values into an SQL range clause
    // fieldname IN ('value1','value2',...)
    {
        $range = '';
        foreach ($input as $row) {
            foreach ($row as $value) {
                if (empty($range)) {
                    $range = "'$value'";
                } else {
                    $range .= ",'$value'";
                } // if
            } // foreach
        } // foreach

        return $range;

    } // array2range
} // if

// ****************************************************************************
if (!function_exists('array2where')) {
    function array2where ($inputarray, $fieldlist=array(), $dbobject=null, $no_operators=false)
    // turn an array of 'name=value' pairs into an SQL 'where' clause.
    // $fieldlist (optional) may be in format 'n=name' (indexed) or 'name=value'
    // (associative), or even [rownum] string.
    // $dbobject (optional) is the database object which provided $inputarray, to
    // provide unformatting rules and any uppercase/lowercase field specifications.
    // $no_operators (optional) indicates that the values in the input array are NOT to
    // be scanned for operators, thus '>ABC' is to be treated as ='>ABC' not >'ABC'
    {
        if (empty($inputarray)) return;

        if (is_object($dbobject)) {
        	$fieldspec = $dbobject->getFieldSpec();
        } else {
            // this may be in same format as $fieldspec
            $fieldspec = $fieldlist;
        } // if

        reset($inputarray);  // fix for version 4.4.1
        $key = key($inputarray);
        if (is_long($key)) {
            // indexed array
        	if (is_array($inputarray[$key])) {
        	    // this is an array within an array, so...
        	    if (!is_null($fieldlist)) {
        	    	// to be filtered by $fieldlst, so bring it to the top level
                    $inputarray = $inputarray[$key];
        	    } else {
                    // so convert each 2nd-level array into a string
                    foreach ($inputarray as $rownum => $rowarray) {
                    	$rowstring = array2where($rowarray);
                    	$inputarray[$rownum] = $rowstring;
                    } // foreach
        	    } //if
            } // if
        } // if

        // if $fieldlist is empty use $inputarray
        if (empty($fieldlist)) {
            $fieldlist = $inputarray;
            foreach ($fieldlist as $key => $value) {
            	if (is_long($key) AND !is_array($value)) {
            	    // this is a subquery, so delete it
                    unset($fieldlist[$key]);
            	} // if
            } // foreach
            reset($fieldlist);
        } // if

        // if $fieldlist is in format 'n=name' change it to 'name=n'
        if (!is_string(key($fieldlist))) {
            $fieldlist = array_flip($fieldlist);
        } // if
        if (is_object($dbobject)) {
            // undo any formatting of data values
        	$inputarray = $dbobject->unFormatData($inputarray);
        } // if

        $where = null;
        $prefix = null;
        foreach ($inputarray as $fieldname => $fieldvalue) {
            if (!is_string($fieldname)) {
                $string = trim($fieldvalue);
                // this is not a name, so assume it's a subquery
            	if (preg_match('/^(AND |OR |\) OR \(|\( |\) )/i', $string.' ', $regs)) {
            	    if (empty($where)) {
            	    	// $where is empty, so do not save prefix
            	    } else {
                	    // save prefix for later
                        $prefix .= $regs[0];
            	    } // if
            	    // remove prefix from string
            	    $string = trim(substr($string, strlen($regs[0])));
                } // if
                if ($string) {
                    if (!empty($where)) {
                    	if (empty($prefix)) {
                    	    $prefix = 'AND';  // default is 'AND'
                    	} // if
                    } // if
                    $prefix = ltrim($prefix, '( ');
                    $prefix = rtrim($prefix, ') ');
                    // look for "EXISTS (...)", "NOT EXISTS (...)", "MATCH (...)" or "function(...)"
                    if (preg_match('/^(EXISTS|NOT EXISTS|MATCH|\w+)[ ]*\(/i', $string, $regs)) {
                    	$where .= ' ' .$prefix .' ' .$string .' ';
                    } else {
                        if (substr($string, 0,1) == '(' AND substr($string,-1,1) == ')') {
                            // string is already enclosed in '(' and ')', so don't add any more
                            $where .= ' ' .$prefix .' ' .$string;
                        } else {
                            $where .= ' ' .$prefix .' (' .$string .') ';
                        } // if
                    } // if
                    $prefix = null;
                } // if
            } else {
                // see if field is qualified with table name
                $fieldname_unq = $fieldname;
                $namearray = explode('.', $fieldname);
                if (!empty($namearray[1])) {
                    if (is_object($dbobject)) {
                    	if ($namearray[0] == $dbobject->tablename) {
                    	    // table names match, so unqualify this field name
                    		$fieldname_unq = $namearray[1];
                    	} // if
                    } // if
                } // if
                // exclude fields not contained in $fieldlist (such as SUBMIT button)
                if (array_key_exists($fieldname_unq, $fieldlist) AND (!array_key_exists($fieldname_unq, $fieldspec) OR !array_key_exists('nondb', $fieldspec[$fieldname_unq]))) {
                    // check fieldspec for upper/lower case
                    if (array_key_exists($fieldname, $fieldspec)) {
                    	if (array_key_exists('uppercase', $fieldspec[$fieldname_unq])) {
                    	    if (function_exists('mb_strtoupper')) {
                    	    	$fieldvalue = mb_strtoupper($fieldvalue);
                    	    } else {
                        		$fieldvalue = strtoupper($fieldvalue);
                    	    } // if
                    	} elseif (array_key_exists('lowercase', $fieldspec[$fieldname_unq])) {
                    	    if (function_exists('mb_strtolower')) {
                        	    $fieldvalue = strtolower($fieldvalue);
                    	    } else {
                        	    $fieldvalue = strtolower($fieldvalue);
                    	    } // if
                    	} // if
                    } // if
                    // combine into <name operator value>
                    if ($no_operators === true) {
                    	// do not search for an operator in the value, it is always '='
                    	$operator   = '=';
                    	$fieldvalue = "'" .addslashes($fieldvalue) ."'";
                    } else {
                        $operators = "/^(<>|<=|<|>=|>|!=|=|NOT LIKE |LIKE |IS NOT |IS |NOT IN[ ]* |IN[ ]* |BETWEEN )/i";
                        // does $fieldvalue start with a valid operator?
                        if (!preg_match($operators, ltrim($fieldvalue), $regs)) {
                            // no, so assume operator is '='
                        	$string = $fieldname ."='" .addslashes($fieldvalue) ."'";
                        } else {
                            // operator is present, but is it part of the value?
                            if (array_key_exists($fieldname_unq, $fieldspec)) {
                                $type =& $fieldspec[$fieldname]['type'];
                                if ($type == 'string') {
                                    // remove operator from front of string
                                	$value2 = substr($fieldvalue, strlen($regs[0]));
                                	if (preg_match('/^\w/', ltrim($value2))) {
                                		// next character is a word character, so operator is part of the value
                                		$string = $fieldname ."='" .addslashes($fieldvalue) ."'";
                                	} else {
                                	    // operator is not part of the value
                                	    $string = $fieldname .' ' .$fieldvalue;
                                	} // if
                                } else {
                                    $string = $fieldname .' ' .$fieldvalue;
                                } // if
                            } else {
                                // operator is not part of the value
                                $string = $fieldname .' ' .$fieldvalue;
                            } // if
                        } // if
                	    list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
                    } // if

                    // now join them together again
                    if ($operator == '=' AND $fieldvalue == "''") {
                    	$namevalue = $fieldname.' IS NULL';
                    } else {
                        $namevalue = $fieldname.$operator.$fieldvalue;
                    } // if

                    // append to $where string
                    if (empty($where)) {
                        $where .= $namevalue;
                    } else {
                        $where .= ' AND ' .$namevalue;
                    } // if
                } // if
            } // if
        } // foreach

        $where = trim($where);
        if (substr_count($where, '(') == 1) {
            if (substr($where, 0, 1) == '(') {
            	$where = trim($where, '() ');
            } // if
        } // if

        if (empty($where)) {
        	if (is_object($dbobject) AND !empty($dbobject->unique_keys)) {
        	    // nothing found using pkey, so try candidate keys
        	    foreach ($dbobject->unique_keys as $ukey) {
        	    	$where = array2where($inputarray, $ukey);
        	    	if (!empty($where)) {
        	    		break;
        	    	} // if
        	    } // foreach
        	} // if
        } // if

        return $where;

    } // array2where
} // if

// ****************************************************************************
if (!function_exists('array2where2')) {
    function array2where2 ($where_array)
    // turn a $where_array back into a string
    {
        $pattern = '/^('        // begins with
                 . 'OR \('      // 'OR ('
                 . '|'
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . ')$/i';      // ends with, case insensitive

        $where = '';
        foreach ($where_array as $key => $value) {
            $value = trim($value);
            if (preg_match($pattern, $value, $regs)) {
                $where .= $value .' ';
            } else {
                $where .= $value .' ';
            } // if
        } // foreach

        // look for any conditions in parentheses which have had their contents removed
        $search = array('(  )', '( )');
        $where = str_replace($search, '()', $where);        // remove spaces between '(' and ')'
        //$search = array(' AND ()', ') OR ()', ' OR ()', '()');
        $search = array(' AND ()', ' OR ()', '()');
        $where = trim(str_replace($search, '', $where));

        // remove any leading 'AND ' or 'OR '
        if (preg_match('/^(AND |OR )/i', $where, $regs)) {
        	$where = substr($where, strlen($regs[0]));
        } // if

        return trim($where);

    } // array2where2
} // if

// ****************************************************************************
if (!function_exists('array_update_associative')) {
    function array_update_associative ($array1, $array2)
    // update contents of $array1 from contents of $array2.
    // Note: this is different from a merge which will add new fields into $array1
    // if they did not previously exist, which is not what I want. This version
    // will not create any items in $array1 which did not previously exist.
    {
        reset($array1);  // fix for version 4.4.1
        if (!is_string(key($array1))) {
            // indexed by row, so use row zero only
            $array1 = $array1[key($array1)];
        } // if

        reset($array2);  // fix for version 4.4.1
        if (!is_string(key($array2))) {
            // indexed by row, so use row zero only
            $array2 = $array2[key($array2)];
        } // if

        foreach ($array2 as $fieldname => $fieldvalue) {
            if (array_key_exists($fieldname, $array1)) {
                $array1[$fieldname] = $array2[$fieldname];
            } // if
        } // foreach

        return $array1;

    } // array_update_associative
} // if

// ****************************************************************************
if (!function_exists('array_update_empty')) {
    function array_update_empty ($array1, $array2, $extra=null)
    // update contents of $array1 from contents of $array2.
    // Note: this is different from a merge which will overwrite $array1 with
    // contents of $array2, which is not what I want. This version will only update
    // $array1 if the key does not exist, or the value is empty.
    // $extra, if provided, will be appended to each entry copied from $array2 to $array1.
    {
        reset($array1);  // fix for version 4.4.1
        if (!is_string(key($array1))) {
            // indexed by row, so use row zero only
            $array1 = $array1[key($array1)];
        } // if

        reset($array2);  // fix for version 4.4.1
        if (!is_string(key($array2))) {
            // indexed by row, so use row zero only
            $array2 = $array2[key($array2)];
        } // if

        foreach ($array2 as $fieldname => $fieldvalue) {
            if (empty($array1[$fieldname]) AND !empty($array2[$fieldname])) {
                if (is_array($fieldvalue) AND is_array($extra)) {
                    // append $extra before adding to $array1
                	$fieldvalue = array_merge($fieldvalue, $extra);
                } // if
                $array1[$fieldname] = $fieldvalue;
            } // if
        } // foreach

        return $array1;

    } // array_update_empty
} // if

// ****************************************************************************
if (!function_exists('array_update_indexed')) {
    function array_update_indexed ($fieldarray, $postarray)
    // update contents of $fieldarray from contents of $postarray.
    // Note: this is different from a merge which will add new fields into $fieldarray
    // if they did not previously exist, which is not what I want. This version
    // will not create any items in $fieldarray which did not previously exist.
    {
        // transfer values from $postarray to $fieldarray
        // each fieldname in $postarray should be an array of values (but may not be)
        foreach ($postarray as $fieldname => $valuearray) {
            if (is_array($valuearray)) {
                // copy row value from $postarray to $fieldarray for current $fieldname
                foreach ($valuearray as $row => $value) {
                    if (array_key_exists($fieldname, $fieldarray[$row-1])) {
                    	// $fieldarray starts at 0, $postarray starts at 1
                        $fieldarray[$row-1][$fieldname] = $postarray[$fieldname][$row];
                    } // if
                } // foreach
            } else {
                // value is not an array, so insert it into every row
                foreach ($fieldarray as $rownum => $rowdata) {
                	$fieldarray[$rownum][$fieldname] = $valuearray;
                } // foreach
            } // if
        } // foreach

        return $fieldarray;

    } // array_update_indexed
} // if

// ****************************************************************************
if (!function_exists('convertEncoding')) {
    function convertEncoding ($string, $to_encoding, $from_encoding=null)
    // convert string from one character encoding to another, if required.
    {
        if ($string) {
            if (function_exists('mb_convert_encoding')) {
                if (!$from_encoding) {
                    // not supplied, so find out what it is
                    $from_encoding = mb_detect_encoding($string);
                    //$check         = mb_check_encoding($string, $to_encoding);
                } // if
                if ($from_encoding != $to_encoding) {
                    $string = mb_convert_encoding($string, $to_encoding, $from_encoding);
                } // if
            } elseif (function_exists('iconv')) {
                if (!$from_encoding) {
                    // not supplied, so find out what it is
                    $from_encoding = ini_get('default_charset');
                } // if
                if ($from_encoding != $to_encoding) {
                    $string = iconv($from_encoding, $to_encoding, $string);
                } // if
            } // if
        } // if

        return $string;

    } // convertEncoding
} // if

// ****************************************************************************
if (!function_exists('convertTZ')) {
    function convertTZ ($datetime, $tz_in, $tz_out)
    // convert datetime from one time zone to another
    {
        if (empty($datetime) OR empty($tz_in) OR empty($tz_out)) {
        	return $datetime;  // no conversion possible
        } // if
        if ($tz_in == $tz_out) {
        	return $datetime;  // no conversion necessary
        } // if

        if (version_compare(phpversion(), '5.2.0', '>=')) {
            // define datetime in input time zone
            $timezone1 = new DateTimeZone($tz_in);
            $dateobj = new DateTime($datetime, $timezone1);
            $result1 = date_format($dateobj, "Y-m-d H:i:s e T");
            // switch to output time zone
            $timezone2 = new DateTimeZone($tz_out);
            $dateobj->setTimezone($timezone2);
            $result2 = date_format($dateobj, "Y-m-d H:i:s e T");
            // strip off timezone details
            $result = substr($result2, 0, 19);
        } else {
            $timestamp = strtotime($datetime);
            $offset    = 0;
//            if ($tz_in == 'America/Los_Angeles') {
//                $offset = 28800;
//            } else {
//                $offset = -28800;
//            } // if
//            $result = strftime('%Y-%m-%d %H:%M:%S', $timestamp+$offset);
            $result = $timestamp;
        } // if

        return $result;

    } // convertTZ
} // if

// ****************************************************************************
if (!function_exists('convertTZdate')) {
    function convertTZdate ($date, $time, $tz_in, $tz_out)
    // convert datetime from one time zone to another
    {
        if (empty($date) OR empty($tz_in) OR empty($tz_out)) {
            return $date;  // no conversion possible
        } // if
        if ($tz_in == $tz_out) {
            return $date;  // no conversion necessary
        } // if

        if (empty($time)) {
            $time = date('H:i:s');  // default to current server time
        } // if

        $datetime = "$date $time";

        $datetime = convertTZ($datetime, $tz_in, $tz_out);

        $result = substr($datetime, 0, 10);

        return $result;

    } // convertTZdate
} // if

// ****************************************************************************
if (!function_exists('convertTZtime')) {
    function convertTZtime ($date, $time, $tz_in, $tz_out)
    // convert datetime from one time zone to another
    {
        if (empty($time) OR empty($tz_in) OR empty($tz_out)) {
            return $time;  // no conversion possible
        } // if
        if ($tz_in == $tz_out) {
            return $time;  // no conversion necessary
        } // if

        if (empty($date)) {
            $date = date('Y-m-d');  // default to current server date
        } // if

        $datetime = "$date $time";

        $datetime = convertTZ($datetime, $tz_in, $tz_out);

        $result = substr($datetime, 11, 8);

        return $result;

    } // convertTZtime
} // if

// ****************************************************************************
if (!function_exists('checkFileExists')) {
    function checkFileExists ($fname)
    // check that file $fname exists on current include_path, and abort if it doesn't.
    {
        if (!fopen($fname, 'r', true)) {
            $message = getLanguageText('sys0076', $fname);
            trigger_error($message, E_USER_ERROR);
        } // if

        return true;

    } // checkFileExists
} // if

// ****************************************************************************
if (!function_exists('convertCurrencyInput')) {
    function convertCurrencyInput ($value, $currency, $home_currency, $exchange_rate)
    // deal with value which may be input in either home or foreign currency.
    {
        // field can be changed, so look for currency code
        if (empty($currency) OR $currency == $home_currency) {
            // no currency code appended, so stop here
        } else {
            // strip currency name from value
            if (isset($_SESSION['display_foreign_currency']) AND $_SESSION['display_foreign_currency'] === true) {
                // values displayed in foreign currency
                $value = str_replace($currency_code, '', $value);
                // convert value back into home currency
                $value = $value / $exchange_rate;
            } else {
                // values displayed in home currency
                $value = str_replace($home_currency, '', $value);
            } // if
        } // if

        return $value;

    } // convertCurrencyInput
} // if

// ****************************************************************************
if (!function_exists('currentOrHistoric')) {
    function currentOrHistoric ($string, $start_date, $end_date)
    // convert the string 'current/historic/future' into a date range.
    // NOTE: defaults to fields named START_DATE and END_DATE, but this may be changed.
    {
        if (empty($start_date)) {
        	$start_date = 'start_date';
        } // if
        if (empty($end_date)) {
        	$end_date = 'end_date';
        } // if

        // convert search string into an indexed array
        $search = where2array($string, false, false);

        if (isset($search['curr_or_hist'])) {
            // replace Current/Historic/Future with a range of dates
            $search1 = stripOperators($search);
            $date = date('Y-m-d');
            switch ($search1['curr_or_hist']) {
                case 'C':
                    // search for records with CURRENT dates
                    $search[$start_date] = "<='$date 23:59:59'";
                    $search[$end_date]   = ">='$date 00:00:00'";
                    break;
                case 'H':
                    // search for records with HISTORIC dates
                    $search[$end_date] = "<'$date 00:00:00'";
                    break;
                case 'F':
                    // search for records with FUTURE dates
                    $search[$start_date] = ">'$date 23:59:59'";
                default:
                    ;
            } // switch
            // rebuild search string without 'curr_or_hist' flag
            unset($search['curr_or_hist']);
            $string = array2where($search);
        } // if

        return $string;

    } // currentOrHistoric
} // if

// ****************************************************************************
if (!function_exists('extractAliasNames')) {
    function extractAliasNames ($sql_select)
    // extract "... AS alias" from $sql_select and return alias names in an
    // indexed array.
    {
        if (empty($sql_select)) {
        	return array();
        } // if

        // split input string into an array of separate elements
        $select_array = extractSelectList($sql_select);

        $field_array = array();

        foreach ($select_array as $element) {
            // find out if this entry uses an alias
            list($original, $alias) = getFieldAlias3($element);
            if ($original != $alias) {
            	$field_array[] = $alias;
            } // if
        } // foreach

        return $field_array;

    } // extractAliasNames
} // if

// ****************************************************************************
if (!function_exists('extractFieldNamesAssoc')) {
    function extractFieldNamesAssoc ($sql_select)
    // extract field names from $sql_select and return an associative array in
    // the format 'alias = original' (or 'name = name' if there is no alias).
    {
        if (empty($sql_select)) {
        	return array();
        } // if

        if (is_array($sql_select)) {
        	$elements = $sql_select;
        } else {
            // split input string into an array of separate elements
            $elements = extractSelectList($sql_select);
        } // if

        $field_array = array();
        foreach ($elements as $element) {
            list($original, $alias) = getFieldAlias3($element);
            $field_array[$alias] = $original;
        } // foreach

        return $field_array;

    } // extractFieldNamesAssoc
} // if

// ****************************************************************************
if (!function_exists('extractFieldNamesIndexed')) {
    function extractFieldNamesIndexed ($sql_select)
    // extract field names from $sql_select and return an indexed array in
    // the format 'index = alias' (or 'index = name' if there is no alias).
    {
        if (empty($sql_select)) {
        	return array();
        } // if

        // split input string into an array of separate elements
        $field_array = extractSelectList($sql_select);

        $alias_array = array();
        foreach ($field_array as $element) {
            list($original, $alias) = getFieldAlias3($element);
            $alias_array[] = $alias;
        } // foreach

        return array($alias_array, $field_array);

    } // extractFieldNamesIndexed
} // if

// ****************************************************************************
if (!function_exists('extractOperatorValue')) {
    function extractOperatorValue ($input)
    // turn string from "='value'" or "=value" to "value"
    {
        if (preg_match('/^(<=|>=|!=|=|<|>|NOT LIKE |LIKE |NOT IN |IN )/i', ltrim($input), $regs)) {
            $operator = $regs[0];
            $output = substr($input, strlen($operator));
            $output = trim($output);

            // the next character is the delimiter (single or double quote)
            $delimiter = substr($output, 0, 1);
            if ($delimiter == '"' or $delimiter == "'") {
                // delimiter found, so remove from both ends of string
                $output = substr($output, 1);
                $output = substr($output, 0, -1);
            } else {
            	// no delimiter found, so use whole string
                $output = $output;
            } // if

            return array($operator, $output);
        } // if

        return array(null, $input);

    } // extractOperatorValue
} // if

// ****************************************************************************
if (!function_exists('extractSelectList')) {
    function extractSelectList ($sql_select)
    // extract field names from $sql_select and return an indexed array.
    // elements are separated by ',' except where ',' occurs within '(' and ')'.
    {
        $select_array = array();

        $pattern = '/('     // start
                 . '\('     // '('
                 . '|'      // or
                 . '\)'     // ')'
                 . '|'      // or
                 . ','      // ','
                 . ')/';    // end

        $count  = 0;  // count of expressions between '(' and ')' (may be nested)
        $string = '';
        $elements = preg_split($pattern, $sql_select, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);

        foreach ($elements as $element) {
        	if ($element == '(') {
        		$count ++;
        		$string .= $element;
        	} elseif ($element == ')') {
        	    $count --;
        	    $string .= $element .' ';  // insert ' ' after ')'
        	} elseif ($element == ',') {
        	    if ($count > 0) {
        	    	$string .= $element;
        	    } else {
        	        // this ',' does not occur within '(' and ')', so it is a separator
        	        $select_array[] = trim($string);
        	        $string = '';
        	    } // if
        	} else {
        	    $string .= trim($element);
        	} // if
        } // foreach

        if (!empty($string)) {
            // last element is not delimited by ','
        	$select_array[] = trim($string);
        } // if

        return $select_array;

    } // extractSelectList
} // if

// ****************************************************************************
if (!function_exists('extractSeparator')) {
    function extractSeparator ($where, &$array)
    // extract separator (AND, OR, '(' and ')') from $where string and add to $array.
    // ($array is passed by reference so that it can be updated).
    {
        $where = ltrim($where);
        if (preg_match('/^\) +AND +\(/i', $where, $regs)) {
            $array[] = ') AND (';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^AND +[\(]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^AND +/i', $where, $regs)) {
            $array[] = 'AND';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^\) +OR +\(/i', $where, $regs)) {
            $array[] = ') OR (';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^OR +[\(]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^OR +/i', $where, $regs)) {
            $array[] = 'OR';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^[\(]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^[\)]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } // if

        return ltrim($where);

    } // extractSeparator
} // if

// ****************************************************************************
if (!function_exists('extractTableNames')) {
    function extractTableNames ($sql_from)
    // extract table names from $sql_from
    {
        // extract first table name (may be '[database.]table AS alias')
        $pattern = '/'                         // start delimiter
                 . '"\w+"\.\w+[ ]+AS[ ]+\w+'   // "db".table AS alias
                 . '|'                         // or
                 . '\w+\.\w+[ ]+AS[ ]+\w+'     // db.table AS alias
                 . '|'                         // or
                 . '"\w+"\.\w+'                // "db".table
                 . '|'                         // or
                 . '\w+\.\w+'                  // db.table
                 . '|'                         // or
                 . '\w+[ ]+AS[ ]+\w+'          // table AS alias
                 . '|'                         // or
                 . '\w+'                       // table
                 . '/i';                       // end delimiter, case insensitive
        $count = preg_match($pattern, $sql_from, $regs);
        $tablename = $regs[0];
        if (strpos($tablename, '.') > 0) {
        	// remove 'dbname' from 'dbname.tablename'
        	list($dbname, $tablename) = explode('.', $tablename);
        } // if
        list($original, $alias) = getTableAlias3($tablename);
        if (!empty($original)) {
        	$table_array[$alias]     = $original;
        } else {
            $table_array[$tablename] = $tablename;
        } // if

        // additional table names follow the word 'JOIN'
        $pattern = '/'                                        // start delimiter
                 . '(?<= join )[ ]*"\w+"\.\w+[ ]+AS[ ]+\w+'   // JOIN "db".table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+\.\w+[ ]+AS[ ]+\w+'     // JOIN db.table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*"\w+"\.\w+'                // JOIN "db".table
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+\.\w+'                  // JOIN db.table
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+[ ]+AS[ ]+\w+'          // JOIN table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+'                       // JOIN table
                 . '/i';                                      // end delimiter, case insensitive

        if ($count = preg_match_all($pattern, $sql_from, $regs)) {
        	// examine extra table names which follow a JOIN
            foreach ($regs[0] as $tablename) {
                if (strpos($tablename, '.') > 0) {
                	// remove 'dbname' from 'dbname.tablename'
                	list($dbname, $tablename) = explode('.', $tablename);
                } // if
                list($original, $alias) = getTableAlias3($tablename);
                if (!empty($original)) {
                	$table_array[$alias]     = $original;
                } else {
                    $table_array[$tablename] = $tablename;
                } // if
            } // foreach
        } // if

        return $table_array;

    } // extractTableNames
} // if

// ****************************************************************************
if (!function_exists('extractValue')) {
    function extractValue (&$where)
    // extract value from a WHERE string where the value is delimited by either
    // single or double quotes.
    // WARNING: any ending delimiter which is escaped must be ignored.
    // NOTE: $where is passed by reference so that it can be modified
    {
        // the first character is the delimiter (single or double quote), or even '('
        $delimiter = substr($where, 0, 1);
        if ($delimiter == '"' or $delimiter == "'" or $delimiter == ' ' or $delimiter == '(') {
            // delimiter is valid
        } else {
            // no valid delimiter found, so use a space instead
            $delimiter = ' ';
        } // if

        if ($delimiter == "'" or $delimiter == '"') {
            // look for next delimiter, but not if is escaped with preceeding '\'
            $pattern = "/("             // begin
                     . "\\\\"           // '\\' - escaped backslash
                     . "|"              // or
                     . "\\$delimiter"   // escaped delimiter
                     . "|"              // or
                     . $delimiter       // unescaped delmiter
                     . ")/";            // end
            if (preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, 1)) {
                $found  = $regs[0][0];
                $endpos = $regs[0][1];
                while ($found != $delimiter) {
                    // ignore escaped character
                	preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, $endpos+2);
                	$found  = $regs[0][0];
                    $endpos = $regs[0][1];
                } // if
            } else {
                // no end delimiter found, so use whole string
                if (function_exists('mb_strlen')) {
                	$endpos = mb_strlen($where);
                } else {
                    $endpos = strlen($where);
                } // if
            } // if

        } elseif ($delimiter == '(') {
        	// look for next ')', but not if it is preceded by another '('
        	$nested_count = 1; // start with first '('
        	if (preg_match('/\(|\)/', $where, $regs, PREG_OFFSET_CAPTURE, 1)) {
        	    $found  = $regs[0][0];
                $endpos = $regs[0][1];
                if ($found == '(') {
                	$nested_count++;
                } elseif ($found == ')') {
                	$nested_count--;
                } // if
                while ($nested_count > 0) {
                	preg_match('/\(|\)/', $where, $regs, PREG_OFFSET_CAPTURE, $endpos+1);
                	$found  = $regs[0][0];
                    $endpos = $regs[0][1];
                    if ($found == '(') {
                    	$nested_count++;
                    } elseif ($found == ')') {
                        $nested_count--;
                    } elseif (is_null($found)) {
                        // end of string, so terminate
                        $nested_count = 0;
                    } // if
                } // while
        	} // if
        } else {
            // delimiter is ' ', so look for next ' ' character
            if (preg_match('/[ ]{1}/', $where, $regs, PREG_OFFSET_CAPTURE, 1)) {
                $found  = $regs[0][0];
                $endpos = $regs[0][1];
            } else {
                // no end delimiter found, so use whole string
                if (function_exists('mb_strlen')) {
                	$endpos = mb_strlen($where);
                } else {
                    $endpos = strlen($where);
                } // if
            } // if
        } // if

        // extract the string portion which exists between the two delimiters
        $fieldvalue = rtrim(substr($where, 0, $endpos +1));

        if (substr($fieldvalue, -1) == ')') {
            // last character is ')' so look for a prior '('
            if (strpos($fieldvalue, '(') === false) {
            	// no match found, so remove ALL trailing ')'
            	while (substr($fieldvalue, -1) == ')') {
            		$fieldvalue = substr($fieldvalue, 0, -1);
            	} // while
            } // if
        } // if

        // remove $fieldvalue from the front of the string
        $where = substr($where, strlen($fieldvalue));

        return $fieldvalue;

    } // extractValue
} // if

// ****************************************************************************
if (!function_exists('filterErrors')) {
    function filterErrors ($array_in, $objectname, &$errors, $screen_structure)
    // deal with errors for fields which are not actually displayed.
    // $array_in      = errors for current object
    // $objectname    = name of current object
    // $errors        = errors to be displayed in message area (may be updated)
    // $screen_structure = identifies which tables and columns are in current screen
    {
        if (empty($array_in)) {
        	return $array_in;
        } // if

        if (!is_array($array_in)) {
        	$array_in = (array)$array_in;
        } // if

        if (!is_array($errors)) {
        	$errors = (array)$errors;
        } // if

        $array_out = array();

        // 1st, locate the zone being used for this table
        $zone = null;
        foreach ($screen_structure['tables'] as $key => $tablename) {
            $tablename = removeTableSuffix($tablename);
        	if ($tablename == $objectname) {
        		$zone = $key;
        		break;
        	} // if
        } // foreach

        if (isset($zone)) {
            foreach ($screen_structure[$zone]['fields'] as $array) {
                if (is_string(key($array))) {
                    // array is associative
                    foreach ($array as $field => $value) {
                    	if (array_key_exists($field, $array_in)) {
                    		// move to array_out
                    		$array_out[$field] = $array_in[$field];
                    		unset($array_in[$field]);
                    	} // if
                    } // foreach
                } else {
                    // this is an array within an array, so step through each sub-array
                    foreach ($array as $array4) {
                        if (array_key_exists('field', $array4)) {
                            $field = $array4['field'];
                            if (array_key_exists($field, $array_in)) {
                                // move to array_out
                        		$array_out[$field] = $array_in[$field];
                        		unset($array_in[$field]);
                            } // if
                        } // if
                    } // foreach
                } // if
            } // foreach
        } // if

        // anything left in $array_in must be moved to $errors
        if (!empty($array_in)) {
        	$errors = array_merge($errors, $array_in);
        } // if

        return $array_out;

    } // filterErrors
} // if

// ****************************************************************************
if (!function_exists('filterOrderBy')) {
    function filterOrderBy ($orderby, $fieldlist, $tablename)
    // filter out any fields in $orderby which do not belong in this table,
    // (valid fields are identified in the $fieldlist array).
    {
        // if input string is empty there is nothing to do
        if (empty($orderby)) return;

        // split string into an array of fieldnames
        $array1 = explode(',', $orderby);

        $string = null;
        foreach ($array1 as $fieldname) {
            if (strpos($fieldname, '.')) {
                // split into $tablename and $fieldname
                list($table, $fieldname) = explode('.', $fieldname);
            } else {
                $table = null;
            } // if
            if (array_key_exists($fieldname, $fieldlist)) {
                // field is valid, so copy to output string
                if (empty($string)) {
                    $string = $fieldname;
                } else {
                    $string .= ', ' .$fieldname;
                } // if
            } // if
        } // foreach

        return $string;

    } // filterOrderBy
} // if

// ****************************************************************************
if (!function_exists('filterWhere')) {
    function filterWhere ($where, $fieldlist, $tablename, $extra=array())
    // filter out any fields in $where which do not belong in this table,
    // (valid fields are identified in the $fieldlist array, with other
    // fields identified in the $extra array).
    {
        // if input string is empty there is nothing to do
        if (empty($where)) return;

        // if $tablename is empty there is nothing to do
        if (empty($tablename)) return $where;

        if (!is_array($extra)) {
        	$extra = array();
        } // if

        // convert from string to indexed array
        $array1 = where2indexedArray($where);

        reset($fieldlist);  // fix for version 4.4.1
        if (!is_string(key($fieldlist))) {
            // flip indexed array so that the values become keys
            $fieldlist = array_flip($fieldlist);
        } // if

        $pattern = '/^('        // begins with
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . ')$/i';      // ends with, case insensitive

        reset($array1);  // fix for version 4.4.1
        $array_out = array();
        $last_separator = null;
        $start_condition = true;
        foreach ($array1 as $ix => $string) {
            $string = trim($string);
            if (preg_match($pattern, $string, $regs)) {
                // this is a separator, not a field
                $last_separator = strtoupper($regs[0]);
                if ($last_separator == '(') {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == ')') {
                	$start_condition = false;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == ') OR (') {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } // if
            } else {
                if (preg_match('/^(EXISTS|NOT EXISTS|MATCH|\w+)[ ]*\(/i', $string, $regs)) {
        	        if ($last_separator) {
                    	$array_out[] = $last_separator;
                    	$last_separator = null;
                    } // if
        	        $array_out[] = $string;
        	        $start_condition = false; // this is not the start of a new condition
//        	    } elseif (preg_match('/^MATCH[ ]*\(/i', $string, $regs)) {
//        	        if ($last_separator) {
//                    	$array_out[] = $last_separator;
//                    	$last_separator = null;
//                    } // if
//        	        $array_out[] = $string;
//        	        $start_condition = false; // this is not the start of a new condition
        	    } else {
        	        $fieldarray2 = where2indexedArray($string);
        	        foreach ($fieldarray2 as $rownum => $rowdata) {
                    	list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($rowdata);
                    	// if $fieldname is qualified with current $tablename, then unqualify it
                    	$namearray = explode('.', $fieldname);
                    	if (!empty($namearray[1])) {
                    	    if ($namearray[0] == $tablename) {
                    	    	$fieldname = $namearray[1];
                    	    } // if
                        } // if
                        $fieldname = str_replace("$tablename.", '', trim($fieldname));
                        $fieldname = strtolower($fieldname);
                        // check if $fieldname exists in $fieldlist array or $extra array.
                        // (if it contains multiple words then assume it's an expression)
                        if (preg_match('/\w+ \w+/', $fieldname)
                        OR in_array($fieldname, $extra)
                        OR (array_key_exists($fieldname, $fieldlist) AND !isset($fieldlist[$fieldname]['nondb']))) {
                            // field is valid, so copy to output array
                            if ($last_separator) {
                        	    if (preg_match('/^(OR|AND)/i', $last_separator)) {
                        	        if ($start_condition) {
                        	        	// cannot have AND/OR at the start of a conditional statement
                        	        } else {
                        	            // insert this separator before the field value
                        	            $array_out[] = $last_separator;
                        	        } // if
                                	$last_separator = null;
                        	    } // if
                            } // if
                            $array_out[] = $fieldname .$operator .$fieldvalue;
                            $start_condition = false;
                        } else {
                            if (preg_match('/^(OR|AND)/i', $last_separator)) {
                            	// field has been dropped, so this separator is no longer valid
                            	$last_separator = null;
                            } // if
                        } // if
        	        } // foreach
        	    } // if
            } // if
        } // foreach

        // convert back into string
        $where2 = array2where2($array_out);

        return trim($where2);

    } // filterWhere
} // if

// ****************************************************************************
if (!function_exists('filterWhere1Where2')) {
    function filterWhere1Where2 ($where1, $where2)
    // remove entries from $where2 that already exist in $where1
    {
        if (strlen($where1) == 0) {
            return $where2;
        } elseif (strlen($where2) == 0) {
            return $where1;
        } // if

        //$where2 .= ' AND ' .$where1 .' AND 1=1'; // TEST

        // convert both input strings to arrays
        $array1 = where2array($where1, false, false);
        $array2 = where2indexedArray($where2);

        $pattern = '/^('        // begins with
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . ')$/i';      // ends with, case insensitive

        // remove any entries in $array2 that already exist in $array1
        $array_out = array();
        $last_separator = null;
        foreach ($array2 as $ix => $string) {
            if (preg_match($pattern, ltrim($string), $regs)) {
                // this is a separator, not a field, so save it for later
                $last_separator = $regs[0];
            } else {
                list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
                $ignore = false;
                if (empty($fieldname)) {
                	// empty fieldname, so this is an expression
                	$expression = ltrim($operator).$fieldvalue;
                    foreach ($array1 as $key1 => $value1) {
                    	if (is_long($key1)) {
                    		if ($value1 == $expression) {
                    			$ignore = true;
                    		} else {
                                if ($value1 == $last_separator .' ' .$expression) {
                                	$ignore = true;
                                } // if
                    		} // if
                    	} // if
                    } // foreach
                } else {
                    if (array_key_exists($fieldname, $array1)) {
                        // field name is duplicated, but are operators the same?
                        $test_string = $fieldname .$array1[$fieldname];
                        list($fieldname1, $operator1, $fieldvalue1) = splitNameOperatorValue($test_string);
                        if ($operator1 == $operator) {
                        	$ignore = true;
                        } // if
                    } else {
                        // if fieldname is 'table.field' then remove table name and try again
                        $namearray = explode('.', $fieldname);
                        if (!empty($namearray[1])) {
                            $fieldname_unq = $namearray[1];
                            if (array_key_exists($fieldname_unq, $array1)) {
                                // field name is duplicated, but are operators the same?
                                $test_string = $fieldname .$array1[$fieldname_unq];
                                list($fieldname1, $operator1, $fieldvalue1) = splitNameOperatorValue($test_string);
                                if ($operator1 == $operator) {
                                	$ignore = true;
                                } // if
                            } // if
                        } // if
                    } // if
                } // if
                if ($ignore == true) {
                	// do not copy to $array_out
                	if (preg_match('/^(OR|AND)/i', $last_separator)) {
                    	// field is not wanted, so this separator is no longer valid
                    	$last_separator = null;
                    } // if
                } else {
                    // field is not duplicated, so copy to output array
                    if ($last_separator) {
                    	$array_out[] = $last_separator;
                    	$last_separator = null;
                    } // if
                    $array_out[] = $fieldname .$operator .$fieldvalue;
                } // if
                $last_separator = null;
            } // if
        } // foreach

        if ($last_separator) {
            if (count($array_out) > 0) {
            	$array_out[] = $last_separator;
            } // if
        } // if

        // convert $array_out back into a string
        $where2 = array2where2($array_out);

        return $where2;

    } // filterWhere1Where2
} // if

// ****************************************************************************
if (!function_exists('fixTrueFalseArray')) {
    function fixTrueFalseArray($lookup, $spec)
    // update the $lookup array so that the keys 'true' and 'false' are changed
    // to the values for $spec['true'] and $spec['false'].
    // For example, the input array of: 'true' => 'Yes', 'false' => 'No'
    // could be changed to:             'Y'    => 'Yes', 'N'     => 'No'
    {
        $true  =& $spec['true'];
        $false =& $spec['false'];

        if (!empty($true)) {
        	if (!array_key_exists($true, $lookup)) {
            	$value = $lookup['true'];
            	$lookup[$true] = $value;
            	unset($lookup['true']);
            } // if
        } // if

        if (!empty($false)) {
            if (!array_key_exists($false, $lookup)) {
            	$value = $lookup['false'];
            	$lookup[$false] = $value;
            	unset($lookup['false']);
            } // if
        } // if

        return $lookup;

    } // fixTrueFalseArray
} // if

// ****************************************************************************
if (!function_exists('fixTrueFalseString')) {
    function fixTrueFalseString($string, $spec)
    // update $string so that the keys 'true' and 'false' are changed
    // to the values for $spec['true'] and $spec['false'].
    {
        $true  =& $spec['true'];
        $false =& $spec['false'];

        if (is_True($string) AND !empty($true)) {
        	$string = $true;
        } elseif (!empty($false)) {
            $string = $false;
        } // if

        return $string;

    } // fixTrueFalseString
} // if

// ****************************************************************************
if (!function_exists('formatCurrency')) {
    function formatCurrency ($amount, $exchange_rate, $language='en')
    // format number from home currency to foreign currency.
    {
        $amount = $amount * $exchange_rate;

    	// get locale for the specified language language
    	$user_language_array = get_languages($language);
    	$locale = rdc_setLocale($user_language_array[0][2]);
    	$localeconv = localeconv();

    	// format amount for this locale
    	$amount  = number_format($amount, 2, $localeconv['decimal_point'], $localeconv['thousands_sep']);

    	// reset locale to default
    	$locale = rdc_setLocale("English (United Kingdom) [en_GB]");

        return $amount;

    } // formatCurrency
} // if

// ****************************************************************************
if (!function_exists('formatNumber')) {
    function formatNumber ($input, $decimal_places=2, $strip_trailing_zero=false)
    // format number according to current locale settings.
    {
        if (empty($input)) return;

        $decimal_point  = $GLOBALS['localeconv']['decimal_point'];
        $thousands_sep  = $GLOBALS['localeconv']['thousands_sep'];

        if ($thousands_sep == chr(160)) {
            // change non-breaking space into ordinary space
            $thousands_sep = chr(32);
        } // if

        $output = number_format($input, $decimal_places, $decimal_point, $thousands_sep);

        if (is_True($strip_trailing_zero)) {
            $output = rtrim($output, '0');
            if (substr($output, -1, 1) == $decimal_point) {
                // last character is a decimal point, so it needs a trailing zero
                $output .= '0';
            } // if
            if (empty($output)) {
                $output = '0'.$decimal_point.'0';
            } // if
        } // if

        return $output;

    } // formatNumber
} // if

// ****************************************************************************
if (!function_exists('formatTelephoneNumber')) {
    function formatTelephoneNumber($input_string)
    // format a telephone number for dialling by:
    // - remove leading '+' from country code
    // - remove leading '0' from area code
    {
        list($country_code, $area_code, $number) = explode(' ', $input_string);

        if (empty($number)) {
            // only 2 parts, so country code is missing
        	$number       = $area_code;
        	$area_code    = $country_code;
        	$country_code = '44';  // default to UK
        } // if

        $country_code = ltrim($country_code, '+');
        if (substr($area_code, 0, 1) == '0') {
        	$area_code = substr($area_code, 1);
        } // if

        $output_string = $country_code .$area_code .$number;

        return $output_string;

    } // formatTelephoneNumber
} // if

// ****************************************************************************
if (!function_exists('getBrowserLanguage')) {
    function getBrowserLanguage ($directory)
    // find a subdirectory which corresponds with a language defined in the browser.
    {
        $found = array();
        if (is_dir($directory)) {
            // build an array of subdirectory names for specified $directory
            $dir = dir($directory);
            while (false !== ($entry = $dir->read())) {
                if ($entry == '.' or $entry == '..') {
                    // ignore
                } else {
                    if (is_dir("$directory/$entry")) {
                	   $found[] = $entry;
                    } // if
                } // if
            } // if
            $dir->close();
        } // if

        if (!empty($found)) {
            if (isset($_SESSION['user_language_array'])) {
            	// scan $user_language_array looking for a matching entry
            	$found_lang = matchBrowserLanguage ($_SESSION['user_language_array'], $found);
            	if (!empty($found_lang)) {
            		return $found_lang;
            	} // if
            } // if
        } // if

        return FALSE;

    } // getBrowserLanguage
} // if

// ****************************************************************************
if (!function_exists('getChanges')) {
    function getChanges ($newarray, $oldarray)
    // compare two arrays of 'name=value' pairs and remove items from $newarray
    // which have the same value in $oldarray.
    {
        // step through each 'item=value' entry in $newarray
        foreach ($newarray as $item => $value) {
            // remove if item with same value exists in $oldarray
            if (array_key_exists($item, $oldarray)) {
                if ($value == $oldarray[$item]) {
                    unset ($newarray[$item]);
                } // if
            } // if
        } // foreach

        return $newarray;

    } // getChanges
} // if

// ****************************************************************************
if (!function_exists('getColumnHeadings')) {
    function getColumnHeadings ()
    // get column headings from horizontal section of current screen structure.
    //
    // DEPRECATED - USE replaceScreenHeadings() INSTEAD
    {
        global $screen_structure;

        if (array_key_exists('fields', $screen_structure['inner'])) {
        	$headings = $screen_structure['inner']['fields'];
        	$headings['zone'] = 'inner';
        } elseif (array_key_exists('fields', $screen_structure['main'])) {
            $headings = $screen_structure['main']['fields'];
            $headings['zone'] = 'main';
        } else {
            $headings = array();
        } // if

        return $headings;

    } // getColumnHeadings
} // if

// ****************************************************************************
if (!function_exists('getContentType')) {
    function getContentType ($filename)
    // determine the mime-type for the specified file
    {
        if (function_exists('finfo_file')) {
        	$magic = ini_get('mime_magic.magicfile');
        	if ($finfo = finfo_open(FILEINFO_MIME, $magic)) {
        		$content_type = finfo_file($finfo, $filename);
        	    finfo_close($finfo);
        	} else {
        	    $content_type = "application/octet-stream";
        	} // if
        } elseif (function_exists ('mime_content_type')) {
            // this requires <mime_magic.magicfile = "/path/to/magic.mime"> directive in php.ini file
            $content_type = mime_content_type($file);
            //logstuff("content_type: " .$content_type, __FUNCTION__, __LINE__);
        } else {
            $content_type = "application/octet-stream";
        } // if

        return $content_type;

    } // getContentType
} // if

// ****************************************************************************
if (!function_exists('getEntryPoint')) {
    function getEntryPoint ($object)
    // get the name of the first method that was used to access the specified object.
    {
        if (is_object($object)) {
            // get class name for the current object
            $classname   = get_class($object);
            $parentclass = get_parent_class($object);
        } else {
            // assume input is a string
            $classname   = $object;
            $parentclass = '';
        } // if

        $method = null;                 // initialise
        $array  = debug_backtrace();    // get trace data

        // start at the end of the array and move backwards
        for ($i = count($array)-1; $i >= 0; $i--) {
            // is this entry for a method call?
        	if (isset($array[$i]['type'])) {
        	    if ($array[$i]['class'] == $classname) {
        	        $method = $array[$i]['function'];
                    break;
        	    } // if
        	    if ($array[$i]['class'] == $parentclass) {
        	        $method = $array[$i]['function'];
                    break;
        	    } // if
        	    if (isset($array[$i]['object'])) {
        	    	if (is_a($array[$i]['object'], $classname)) {
            	    	$method = $array[$i]['function'];
            	    	break;
            	    } // if
            	    if (is_a($array[$i]['object'], $parentclass)) {
            	    	$method = $array[$i]['function'];
            	    	break;
            	    } // if
        	    } // if
    //    	    if ($array[$i]['class'] != 'Default_Table') {
    //    	    	if (is_subclass_of($object, $array[$i]['class'])) {
    //        	        $method = $array[$i]['function'];
    //                    break;
    //        	    } // if
    //    	    } // if
        	} // if
        } // for

        return $method;

    } // getEntryPoint
} // if

// ****************************************************************************
if (!function_exists('getFieldAlias3')) {
    function getFieldAlias3 ($string)
    // look for 'original AS alias' in $string and return both 'original' and 'alias'
    {
        // look for words in front of (last) ' as ' in $string
        $pattern = '/'              // start delimiter
                 . '.*(?= as )'     // everything before ' as '
                 . '/i';            // end delimiter, case insensitive

        // there may be more than one, so get details of all of them
        $count = preg_match_all($pattern, $string, $regs, PREG_OFFSET_CAPTURE);
        if ($count > 0) {
        	$array[0] = trim($regs[0][0][0]);   // original (before ' as ')
	        $offset   = $regs[0][$count-1][1];  // offset to last match
        	$count = preg_match('/(?<= as )\w+/i', $string, $regs, null, $offset);
        	$array[1] = trim($regs[0]);         // alias (after ' as ')
        } else {
            // no alias, so return same value in both parts
            $array[0] = $string;
            $array[1] = $string;
        } // if

        return $array;

    } // getFieldAlias3
} // if

// ****************************************************************************
if (!function_exists('getFieldArray')) {
    function getFieldArray ($sql_select)
    // extract field names from $sql_select and return an indexed array in
    // the format 'index = alias' (or 'index = name' if there is no alias).
    {
        // NOTE: this is now performed in a different function
        list($array1, $array2) = extractFieldNamesIndexed($sql_select);

        return $array1;

    } // getFieldArray
} // if

// ****************************************************************************
if (!function_exists('getLanguageArray')) {
    function getLanguageArray ($id)
    // get named array from the language file.
    {
        static $array1;
        static $array2;
        static $language;

        // if language has changed then reload contents of both arrays
        if (!empty($GLOBALS['party_language'])) {
            if ($GLOBALS['party_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $GLOBALS['party_language'];
            } // if
        } elseif (!empty($_SESSION['user_language'])) {
            if ($_SESSION['user_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $_SESSION['user_language'];
            } // if
        } elseif (!empty($_SESSION['default_language'])) {
            if ($_SESSION['default_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $_SESSION['default_language'];
            } // if
        } // if

        if (!empty($GLOBALS['classdir'])) {
            if (substr($GLOBALS['classdir'], -4, 4) == '.inc') {
                // remove filename to leave a directory name
            	$GLOBALS['classdir'] = dirname(dirname($GLOBALS['classdir']));
            } // if
            // compare directories of current class and current script
        	if ($GLOBALS['classdir'] != getcwd()) {
        	    // change to directory of current class to obtain error message
        		chdir($GLOBALS['classdir']);
        	} // if
        } // if

        if (!is_array($array1)) {
            $array1 = array();
            // find file in a language subdirectory
            $fname = getLanguageFile('sys.language_array.inc', '../menu/text');
            $array1 = require $fname;  // import contents of disk file
            if (empty($array1)) {
            	// 'File $fname is empty'
                //trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
                trigger_error("File $fname is empty", E_USER_ERROR);
            } // if
            unset($array);
        } // if

        if (!is_array($array2)) {
            $array2 = array();
            // find file in a language subdirectory
            $fname = getLanguageFile('language_array.inc', './text');
            $array2 = require $fname;  // import contents of disk file
            if (empty($array2)) {
            	// 'File $fname is empty'
                trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
            } // if
            unset($array);
        } // if

        // perform lookup for specified $id ($array2 first, then $array1)
        if (isset($array2[$id])) {
        	$result = $array2[$id];
        } elseif (isset($array1[$id])) {
        	$result = $array1[$id];
        } else {
            $result = null;
        } // if
        if (empty($result)) {
        	// nothing found, so return original input as an array
            $result = array($id => $id);
        } // if

        foreach ($result as $key => $value) {
            $value2 = array();
            if (is_array($value)) {
            	foreach ($value as $key1 => $value1) {
            		$value2[$key1] = convertEncoding($value1, 'UTF-8');
            	} // foreach
            } else {
                $value2 = convertEncoding($value, 'UTF-8');
            } // if
            $result[$key] = $value2;
        } // foreach

        $cwd = getcwd();
        if (DIRECTORY_SEPARATOR == '\\') {
         	$cwd = str_replace('\\', '/', $cwd);
         	$_SERVER['SCRIPT_FILENAME'] = str_replace('\\', '/', $_SERVER['SCRIPT_FILENAME']);
        } // if
        if ($cwd != dirname($_SERVER['SCRIPT_FILENAME'])) {
    	    // change back to working directory of the current script
    		chdir(dirname($_SERVER['SCRIPT_FILENAME']));
    		$array2 = false;  // cause this to be reloaded
    	} // if

        return $result;

    } // getLanguageArray
} // if

// ****************************************************************************
if (!function_exists('getLanguageFile')) {
    function getLanguageFile ($filename, $directory, $ignore_if_not_found=false)
    // look for '$directory/$language/$filename' where $language is variable.
    {
        $language_array = array();

        if (!empty($GLOBALS['party_language'])) {
        	// change hyphen to underscore before file system lookup
            $language_array[] = str_replace('-', '_', strtolower($GLOBALS['party_language']));
        } // if

        $browser_language = getBrowserLanguage($directory);
        if (!empty($browser_language)) {
        	$language_array[] = $browser_language;
        } // if

        // last possible entries are the application default, then 'English'
        if (!empty($_SESSION['default_language'])) {
        	$language_array[] = $_SESSION['default_language'];
        } // if
        $language_array[] = 'en';

        // search directories in priority order and stop when the file is found
        foreach ($language_array as $language) {
        	$fname = "$directory/$language/$filename";
        	if (file_exists($fname)) {
        	    break;
        	} // if
        } // foreach

        if (!file_exists($fname)) {
            if (is_True($ignore_if_not_found)) {
                return false;
            } else {
            	// 'File $fname cannot be found'
                trigger_error(getLanguageText('sys0056', $fname), E_USER_ERROR);
            } // if
        } // if

        return $fname;

    } // getLanguageFile
} // if

// ****************************************************************************
if (!function_exists('getLanguageText')) {
    function getLanguageText ($id, $arg1=null, $arg2=null, $arg3=null, $arg4=null, $arg5=null)
    // get text from the language file and include up to 5 arguments.
    {
        static $array1;
        static $array2;
        static $language;

        // if language has changed then reload contents of both arrays
        if (!empty($GLOBALS['party_language'])) {
            if ($GLOBALS['party_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $GLOBALS['party_language'];
            } // if
        } elseif (!empty($_SESSION['user_language'])) {
            if ($_SESSION['user_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $_SESSION['user_language'];
            } // if
        } elseif (!empty($_SESSION['default_language'])) {
            if ($_SESSION['default_language'] != $language) {
            	$array1 = false;
            	$array2 = false;
            	$language = $_SESSION['default_language'];
            } // if
        } // if

        if (!empty($GLOBALS['classdir'])) {
            if (substr($GLOBALS['classdir'], -4, 4) == '.inc') {
                // remove filename to leave a directory name
            	$GLOBALS['classdir'] = dirname(dirname($GLOBALS['classdir']));
            } // if
            // compare directories of current class and current script
        	if ($GLOBALS['classdir'] != getcwd()) {
        	    // change to directory of current class to obtain error message
        		chdir($GLOBALS['classdir']);
        		$array2 = false;  // cause this to be reloaded
        	} // if
        } // if

        if (!is_array($array1)) {
            $array1 = array();
            // find file in a language subdirectory
            $fname = getLanguageFile('sys.language_text.inc', '../menu/text');
            $array1 = require $fname;  // import contents of disk file
            if (empty($array1)) {
            	// 'File $fname is empty'
                //trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
                trigger_error("File $fname is empty", E_USER_ERROR);
            } // if
            unset($array);
            // extract identity of language subdirectory
            $language = basename(dirname($fname));
            // use this language in the XSL transformation
        	$GLOBALS['output_language'] = $language;
        } // if

        if (!is_array($array2)) {
            $array2 = array();
            // find file in a language subdirectory
            $fname = getLanguageFile('language_text.inc', './text');
            $array2 = require $fname;  // import contents of disk file
            if (empty($array2)) {
            	// 'File $fname is empty'
                trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
            } // if
            unset($array);
        } // if

        // perform lookup for specified $id ($array2 first, then $array1)
        if (isset($array2[$id])) {
        	$string = $array2[$id];
        } elseif (isset($array1[$id])) {
        	$string = $array1[$id];
        } else {
            $string = null;
        } // if
        if (empty($string)) {
        	// nothing found, so return original $id
            $string = trim($id ." $arg1 $arg2 $arg3 $arg4 $arg5");
        } // if

        $string = convertEncoding($string, 'UTF-8');

        if (!is_null($arg1)) {
            // insert argument(s) into string
        	$string = sprintf($string, $arg1, $arg2, $arg3, $arg4, $arg5);
        } // if

        $cwd = getcwd();
        if (DIRECTORY_SEPARATOR == '\\') {
         	$cwd = str_replace('\\', '/', $cwd);
         	$_SERVER['SCRIPT_FILENAME'] = str_replace('\\', '/', $_SERVER['SCRIPT_FILENAME']);
        } // if
        if ($cwd != dirname($_SERVER['SCRIPT_FILENAME'])) {
    	    // change back to working directory of the current script
    		chdir(dirname($_SERVER['SCRIPT_FILENAME']));
    		$array2 = false;  // cause this to be reloaded
    	} // if

        return $string;

    } // getLanguageText
} // if

// ****************************************************************************
if (!function_exists('getParentDIR')) {
    function getParentDIR ($filename=null)
    // get name of parent directory.
    {
        if (empty($filename)) {
        	$dir = dirname(dirname($_SERVER['PHP_SELF']));
        } else {
            $dir = dirname(dirname($filename));
        } // if

        if (strlen($GLOBALS['https_server_suffix']) > 0) {
            // if directory starts with https_server_suffix it must be stripped off
        	if (substr($dir, 0, strlen($GLOBALS['https_server_suffix'])) == $GLOBALS['https_server_suffix']) {
        		$dir = substr($dir, strlen($GLOBALS['https_server_suffix']));
        	} // if
        } // if

        // if result is '\' or '/' (due to PHP bug) then replace with null
        if ($dir == '\\' or $dir == '/') $dir = null;

        return $dir;

    } // getParentDIR
} // if

// ****************************************************************************
if (!function_exists('getPatternId')) {
    function getPatternId ($script_id=null)
    // get the pattern_id of the specified script (default is current script).
    {
        if (isset($_SESSION['logon_user_id'])) {
        	if (preg_match('/INTERNET|BATCH/i', $_SESSION['logon_user_id'])) {
            	return $_SESSION['logon_user_id'];
            } // if
        } // if

        if (empty($script_id)) {
            $script_id = getSelf();
        } // if

        if (!preg_match('/\.php/i', $script_id)) {
        	// does not end in '.php', so it is a task_id
        	$dbobject =& singleton::getInstance('mnu_task');
        	$data = $dbobject->getData("task_id='$script_id'");
        	unset($dbobject);
        	if (empty($data)) {
        		return false;
        	} else {
        	    return $data[0]['pattern_id'];
        	} // if
        } // if

        if (isset($GLOBALS['mode']) AND $GLOBALS['mode'] == 'batch') {
        	$pattern_id = 'batch';
        } else {
            if (!empty($_SESSION) AND !empty($_SESSION['pages'])) {
            	$pattern_id = $_SESSION['pages'][$script_id]['pattern_id'];
            } else {
                $pattern_id = 'unknown';
            } // if
        } // if

        return $pattern_id;

    } // getPatternId
} // if

// ****************************************************************************
if (!function_exists('getPdfColumnHeadings')) {
    function getPdfColumnHeadings ()
    // get column headings from horizontal section of current report structure.
    {
        global $report_structure;

        $headings = $report_structure['body']['fields'];

        return $headings;

    } // getPdfColumnHeadings
} // if

// ****************************************************************************
if (!function_exists('getPostArray')) {
    function getPostArray ($post, $fieldlist)
    // extract all the entries in $post array which are named in $fieldlist.
    // $post contains the entire $_POST array.
    // $fieldlist identifies the fields that belong to a particular database table.
    {
        $array_out = array();

        foreach ($post as $key => $value) {
        	if (array_key_exists($key, $fieldlist)) {
        		$array_out[$key] = $value;
        	} // if
        } // foreach

        return $array_out;

    } // getPostArray
} // if

// ****************************************************************************
if (!function_exists('getFileStructure')) {
    function getFileStructure ($filename, $directory)
    // load the contents of the $structure variable from a disk file.
    {
        if (!empty($GLOBALS['project_code'])) {
        	// see if a customised version of this file exists for this project
        	$custom_dir = $directory .'/custom-processing/' .$GLOBALS['project_code'];
        	$fname = getLanguageFile('cp_'.$filename, $custom_dir, true);
        } // if

        if (empty($fname)) {
        	// locate file in subdirectory which matches user's language code
            $fname = getLanguageFile($filename, $directory);
        } // if

        require $fname;              // import contents of disk file
        if (empty($structure)) {
        	// 'File $fname is empty'
            trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
        } // if

        return $structure;

    } // getFileStructure
} // if

// ****************************************************************************
if (!function_exists('getHelpText')) {
    function getHelpText ($filename, $directory)
    // load the contents of the $array variable from a disk file.
    {
        // locate file in subdirectory which matches user's language code
        $fname = getLanguageFile($filename, $directory, true);

        if (file_exists($fname)) {
    	    $contents = file_get_contents($fname);
    	    return $contents;
    	} // if

        return FALSE;

    } // getHelpText
} // if

// ****************************************************************************
if (!function_exists('getSelf')) {
    function getSelf ()
    // reduce PHP_SELF to '/dir/file.php' to exclude all leading directory names.
    {

        $PHP_SELF = '/' .basename(dirname($_SERVER['PHP_SELF']))
                   .'/' .basename($_SERVER['PHP_SELF']);

        return strtolower($PHP_SELF);

    } // getSelf
} // if

// ****************************************************************************
if (!function_exists('getShutDownStatus')) {
    function getShutDownStatus ()
    // find out if the system has a scheduled shutdown time
    {
        $errors   = array();
        $messages = array();

        $dbobject =& singleton::getInstance('mnu_control');
        $shutdown_data = $dbobject->getControlData('shutdown');
        unset($dbobject);

        $time = getTimeStamp('time');
        $dow  = date('l', time()); // get day of week (full name)
        $fieldname = 'shutdown_' .strtolower($dow);

        if (is_True($shutdown_data[$fieldname])) {
        	// converts times from server timezone to client timezone
    	    $shutdown_start = getTimeStamp('date').' '.$shutdown_data['shutdown_start'];
    	    $shutdown_end   = getTimeStamp('date').' '.$shutdown_data['shutdown_end'];
    	    if (!empty($_SESSION['timezone_server']) AND !empty($_SESSION['timezone_client'])) {
    	    	$shutdown_start = convertTZ($shutdown_start, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
    	    	$shutdown_end   = convertTZ($shutdown_end,   $_SESSION['timezone_server'], $_SESSION['timezone_client']);
    	    } // if
    	    // there is a shutdown scheduled for this day...
        	if ($shutdown_data['shutdown_warning'] <= $time AND $shutdown_data['shutdown_start'] >= $time) {
        	    // System will be shutting down between X and Y
        		$messages[] = getLanguageText('sys0140', substr($shutdown_start, 11, 5), substr($shutdown_end, 11, 5));
        	} // if
            if ($shutdown_data['shutdown_start'] <= $time AND $shutdown_data['shutdown_end'] >= $time) {
        	    // System has been shut down. It will be available at X
        		$errors[] = getLanguageText('sys0141', substr($shutdown_end, 11, 5));
        	} // if
        } // if

        $result[] = $errors;
        $result[] = $messages;

        return $result;

    } // getShutDownStatus
} // if

// ****************************************************************************
if (!function_exists('getTableAlias1')) {
    function getTableAlias1 ($alias, $string)
    // look for 'original AS alias' in $string and return 'original'
    {
        // build array of words which come before ' as ' in string
        $count = preg_match_all('/\w+[ ]*(?= as )/i', $string, $regs);
        $array1 = trim($regs[0]);

        // build array of words which come after ' as ' in string
        $count = preg_match_all('/(?<= as )[ ]*\w+/i', $string, $regs);
        $array2 = trim($regs[0]);

        $index = array_search($alias, $array2);
        if ($index === false) {
            return false;
        } else {
            $original = $array1[$index];
            return $original;
        } // if

        return false;

    } // getTableAlias1
} // if

// ****************************************************************************
if (!function_exists('getTableAlias2')) {
    function getTableAlias2 ($original, $string)
    // look for 'original AS alias' in $string and return 'alias'
    {
        // build array of words which come before ' as ' in string
        $count = preg_match_all('/\w+[ ]*(?= as )/i', $string, $regs);
        $array1 = trim($regs[0]);

        // build array of words which come after ' as ' in string
        $count = preg_match_all('/(?<= as )[ ]*\w+/i', $string, $regs);
        $array2 = trim($regs[0]);

        $index = array_search($original, $array1);
        if ($index === false) {
            return false;
        } else {
            $alias = $array2[$index];
            return $alias;
        } // if

        return false;

    } // getTableAlias2
} // if

// ****************************************************************************
if (!function_exists('getTableAlias3')) {
    function getTableAlias3 ($string)
    // look for 'original AS alias' in $string and return both 'original' and 'alias'
    {
        // look for words either side of ' as ' in $string
        if ($count = preg_match('/\w+\.\w+[ ]*(?= as )|\w+[ ]*(?= as )/i', $string, $regs) > 0) {
        	$array[0] = trim($regs[0]);  // original
        	$count = preg_match('/(?<= as )[ ]*\w+/i', $string, $regs);
        	$array[1] = trim($regs[0]);  // alias
        } else {
            $array[0] = '';
            $array[1] = '';
        } // if

        return $array;

    } // getTableAlias3
} // if

// ****************************************************************************
if (!function_exists('getTimeDiff')) {
    function getTimeDiff ($start, $end)
    // calculate the difference between two times
    {
        $time1 = strtotime($start);     // convert to seconds
        $time2 = strtotime($end);       // convert to seconds

        $minutes = ceil(($time2 - $time1) / 60); // convert to minutes

    //    $hours   = '';
    //    $days    = '';
    //    if ($minutes > 60) {
    //    	$hours = floor($minutes / 60);
    //    } // if
    //    if ($hours > 24) {
    //    	$days  = floor($hours / 24);
    //    } // if
    //
    //    $diff = $minutes;

        return $minutes;

    } // geTimeDiff
} // if

// ****************************************************************************
if (!function_exists('getTimeStamp')) {
    function getTimeStamp ($type=null)
    // get timestamp in 'CCYY-MM-DD HH:MM:SS' format
    {
        switch (strtolower($type)) {
            case 'date':
                $output = date('Y-m-d');
                break;
            case 'time':
                $output = date('H:i:s');
                break;
            default:
                $output = date('Y-m-d H:i:s');
        } // switch

        return $output;

    } // getTimeStamp
} // if

// ****************************************************************************
if (!function_exists('indexed2assoc')) {
    function indexed2assoc ($array_in, $use_latest=false)
    // turn an indexed array (created by where2indexedArray) into an associative array.
    // $use_latest identifies which of multiple entries to use (default is 'first')
    {
        $array_out = array();

        $pattern = '/^('        // begins with
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . ')$/i';      // ends with, case insensitive

        $last_string = null;
        foreach ($array_in as $index => $string) {
            if (preg_match('/^(NOT EXISTS|EXISTS)[ ]*\(/i', ltrim($string), $regs)) {
                // this is a subquery
                if (strlen($last_string) > 1) {
                	$array_out[] = $last_string .' ' .$string;
                } else {
                    $array_out[] = ltrim($string);
                } // if
                $last_string = null;
            } elseif (preg_match('/^MATCH[ ]*\(/i', ltrim($string), $regs)) {
                // this is a MATCH (...) AGAINST (...) string
                $array_out[] = ltrim($string);
            } elseif (preg_match($pattern, ltrim($string), $regs)) {
                // ignore this entry
                $last_string = trim($string);
            } else {
                $last_string = null;
                $duff = array();
                while (!empty($string)) {
            	    // split element into its component parts
            		list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
            		if ($use_latest === true) {
            		    // add to array, overwriting any previous entry
            			$array_out[$fieldname] = $operator .$fieldvalue;
            		} else {
                    	if (!array_key_exists($fieldname, $array_out)) {
                    	    // $fieldname is not in $array_out, so add it
                    		$array_out[$fieldname] = $operator .$fieldvalue;
                    	} // if
            		} // if
            		// extract any separator between each element
            		$string = extractSeparator($string, $duff);
            	} // while
            } // if
        } // foreach

        return $array_out;

    } // indexed2assoc
} // if

// ****************************************************************************
if (!function_exists('isPkeyComplete')) {
    function isPkeyComplete ($where, $pkey, $candidate_keys=null, $object=null)
    // check that $where contains all fields for the primary key.
    {
        if (is_string($where)) {
            // convert string into array
            $fieldarray = where2indexedArray($where);
        } else {
            // $where is already an array
            reset($where);  // fix for version 4.4.1
            if (is_array(key($where))) {
                // indexed by row, so use first row only
                $fieldarray = $where[key($where)];
            } else {
                // use whole array
                $fieldarray = $where;
            } // if
        } // if

        reset($fieldarray);  // fix for version 4.4.1
        $key = key($fieldarray);
        if (!is_string($key)) {
            // convert array from indexed to associative with fieldnames as the key
            $fieldarray = indexed2assoc($fieldarray);
        } // if

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        if (is_object($object)) {
        	$tablename = $object->tablename;
        } else {
            $tablename = null;
        } // if

        $errors = array();

        $yes_count = 0;
        foreach ($pkey as $fieldname) {
            if (array_key_exists($fieldname, $fieldarray)) {
                // value must NOT contain wildcard character
                if (strpos($fieldarray[$fieldname], '%') === false) {
                    // field is valid, so continue
                    $yes_count ++;
                } else {
                    $errors[$fieldname] = getLanguageText('sys0017'); // 'Must not use wildcard character (%) in primary key'
                } // if
            } elseif (!empty($tablename) AND array_key_exists("$tablename.$fieldname", $fieldarray)) {
                // try with table name as the prefix
                if (strpos($fieldarray["$tablename.$fieldname"], '%') === false) {
                    // field is valid, so continue
                    $yes_count ++;
                } else {
                    $errors[$fieldname] = getLanguageText('sys0017'); // 'Must not use wildcard character (%) in primary key'
                } // if
            } // if
        } // foreach

        if ($yes_count == count($pkey)) {
            // all components of this primary key have been supplied
            return $errors;
        } // if

        if (!empty($candidate_keys)) {
            // look to see if any candidate keys have been supplied
            foreach ($candidate_keys as $ukey) {
                $yes_count = 0;
            	foreach ($ukey as $fieldname) {
            	    if (array_key_exists($fieldname, $fieldarray)) {
                	    // value must NOT contain wildcard character
                        if (strpos($fieldarray[$fieldname], '%') === false) {
                            // field is valid, so continue
                            $yes_count ++;
                        } // if
            	    } // if
            	} // foreach
            	if ($yes_count == count($ukey)) {
            		// all components of this unique key have been supplied
            		return $errors;
            	} // if
            } // foreach
        }

        foreach ($pkey as $fieldname) {
            $errors[] = getLanguageText('sys0018', $fieldname); // "Primary key ($fieldname) is not complete - check selection"
        } // foreach

        return $errors;

    } // isPkeycomplete
} // if

// ****************************************************************************
if (!function_exists('isPrimaryObject')) {
    function isPrimaryObject ($object)
    // Find out is this is the first object to be called in the current script.
    // (ie: is the object called from a controller and not another object?)
    {
        if (is_True($object->initiated_from_controller)) {
        	return true;
        } else {
            return false;
        } // if

    //    if (is_object($object)) {
    //        // get class name for the current object
    //        $classname   = get_class($object);
    //        $parentclass = get_parent_class($object);
    //    } else {
    //        // assume input is a string
    //        $classname   = $object;
    //        $parentclass = '';
    //    } // if
    //
    //    $array  = debug_backtrace();    // get trace data
    //
    //    // start at the end of the array and move backwards
    //    for ($i = count($array)-1; $i >= 0; $i--) {
    //        // is this entry for a method call?
    //    	if (isset($array[$i]['type'])) {
    //    	    if (isset($array[$i]['class'])) {
    //    	        // class found - now examine it
    //    	        if ($classname == $array[$i]['class']) {
    //    	        	return true;
    //    	        } else {
    //    	            return false;
    //    	        } // if
    //                break;
    //    	    } // if
    //    	} // if
    //    } // for

        return false;

    } // isPrimaryObject
} // if

// ****************************************************************************
if (!function_exists('joinWhereByRow')) {
    function joinWhereByRow ($input)
    // convert indexed array of WHERE strings into a single string with each
    // array element separated by ' OR '.
    // EXAMPLE: 3 entries results in "(...) OR (...) OR (...)" .
    // (this is the opposite of splitWhereByRow)
    {
        if (!is_array($input)) {
        	return FALSE;  // this is not an array
        } // if

        if (!is_int(key($input))) {
        	return FALSE;  // this is not an indexed array
        } // if

        if (count($input) == 1) {
        	$output = $input[key($input)];
        } else {
            // more than 1 row, so separate each one with ' OR '
            $output = '';
            foreach ($input as $rownum => $string) {
                if (empty($output)) {
                	$output = "($string)";
                } else {
                    $output .= " OR ($string)";
                } // if
            } // foreach
        } // if

        return $output;

    } // joinWhereByRow
} // if

// ****************************************************************************
if (!function_exists('is_True')) {
    function is_True ($value)
    // test if a value is TRUE or FALSE
    {
        if (is_bool($value)) return $value;

        // a string field may contain several possible values
        if (preg_match('/^(Y|YES|T|TRUE|ON|1)$/i', $value)) {
            return true;
        } // if

        return false;

    } // is_True
} // if

// ****************************************************************************
if (!function_exists('logStuff')) {
    function logStuff ($string, $function=null, $line=null)
    // write $string out to a log file for debugging
    {
        if ($_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
            // this is my IP address, so continue
        } elseif (preg_match('/^(localhost|desktop|laptop/i)$', $_SERVER['SERVER_NAME'])) {
            // this is one my PCs, so continue
        } else {
        	return;
        } // if

        if (empty($function)) {
        	$function = getSelf();
        } // if

        $header = "\r\n<p>********** " .date('Y-m-d H:i:s') .' ';
        $header .= "function: " .$function .", line: " .$line ."</p>\r\n";
        $logfile = '../errorlog.html';
        $result = error_log("$header $string", 3, $logfile);

        return;

    } // logStuff
} // if

// ****************************************************************************
if (!function_exists('logSqlQuery')) {
    function logSqlQuery ($dbname, $tablename, $query, $result=null)
    // write last SQL query out to a log file as a debugging aid
    {
        if ($dbname == 'audit') {
            // are we running one of the AUDIT enquiry screens?
            $dir = ltrim(dirname(getSelf()), '\\/');
            if (strtolower($dir) == 'audit') {
                if ($tablename == 'php_session') {
            	   return;
                } // if
            	// continue
            } else {
        	    return;
            } // if
        } // if

        if (isset($GLOBALS['log_sql_query']) and is_true($GLOBALS['log_sql_query'])) {
            $query = str_replace("\n", " ", $query);
            if (is_null($result)) {
            	$string = $query;
            } else {
                $string = $query .'=>Count=' .$result;
            } // if
            $fn = './sql/' . basename($_SERVER['PHP_SELF']) . '.sql';
        	error_log("$string\r\n", 3, $fn);
        } // if

        return;

    } // logSqlQuery
} // if

// ****************************************************************************
if (!function_exists('matchBrowserLanguage')) {
    function matchBrowserLanguage ($browser_array, $language_array)
    // match browser language with an entry in $language_array
    {
        foreach ($browser_array as $browser_language) {
        	// look for full language abbreviation (after replacing hyphen with underscore)
        	$test_language = str_replace('-', '_', strtolower($browser_language[0]));
        	foreach ($language_array as $supported_language) {
        	    $supported_language = str_replace('-', '_', $supported_language);
        		if ($test_language == strtolower($supported_language)) {
        			return $test_language;
        		} // if
        	} // foreach
        	// look for primary language (after replacing hyphen with underscore)
        	$test_language = str_replace('-', '_', strtolower($browser_language[1]));
        	foreach ($language_array as $supported_language) {
        	    $supported_language = str_replace('-', '_', $supported_language);
        		if ($test_language == strtolower($supported_language)) {
        			return $test_language;
        		} // if
        	} // foreach
        } // foreach

        return false;

    } // matchBrowserLanguage
} // if

// ****************************************************************************
if (!function_exists('mergeSettings')) {
    function mergeSettings ($string1, $string2)
    // take 2 $settings strings and merge them into 1.
    {
        if (empty($string1) and empty($string2)) {
        	return ''; // nothing to do
        } elseif (empty($string1)) {
            return $string2;
        } elseif (empty($string2)) {
            return $string1;
        } // if

        // convert 2 strings to arrays, then merge them
        parse_str($string1, $array1);
        parse_str($string2, $array2);
        $array3 = array_merge($array1, $array2);

        $string_out = '';
        // convert merged array into a new string
        foreach ($array3 as $key => $value) {
        	if (empty($string_out)) {
        		$string_out = "$key=$value";
        	} else {
        	    $string_out .= "&$key=$value";
        	} // if
        } // foreach

        return $string_out;

    } // mergeSettings
} // if

// ****************************************************************************
if (!function_exists('mergeWhere')) {
    function mergeWhere ($where1, $where2)
    // merge 2 sql where clauses into a single clause, removing duplicate references
    {
        if (strlen($where1) == 0) {
            return $where2;
        } elseif (strlen($where2) == 0) {
            return $where1;
        } // if

        // convert both input strings to arrays
        $array1 = where2array($where1, false, false);
        $array2 = where2array($where2, false, false);

        // remove any entries in $array2 that already exist in $array1
        foreach ($array2 as $field2 => $value2) {
            if (array_key_exists($field2, $array1)) {
                // corresponding entry exists, so remove it
            	unset($array2[$field2]);
            } else {
                $namearray = explode('.', $field2);
                if (!empty($namearray[1])) {
                    // remove table qualifier
                    $fieldname_unq = $namearray[1];
                } else {
                    $fieldname_unq = $namearray[0];
                } // if
                if (array_key_exists($fieldname_unq, $array1)) {
                    // corresponding entry exists, so remove it
                	unset($array2[$field2]);
                } // if
            } // if
        } // foreach

        if (empty($array2)) {
            // second string is now enpty, so return first string on its own
            return $where1;
        } else {
        	// convert $array2 back into a string and append it to $where1
            $where3 = array2where($array2);
            if (preg_match('/^(AND |OR )/i', ltrim($where2).' ', $regs)) {
                // join operator was pre-defined so use it
                $where1 = "$where1 $regs[0] $where3";
            } else {
                // use default join operator
                $where1 = "$where1 AND $where3";
            } // if
        } // if

        return $where1;

    } // mergeWhere
} // if

// ****************************************************************************
if (!function_exists('number_unformat')) {
    function number_unformat ($input, $decimal_point=null, $thousands_sep=null)
    // convert number to internal format (decimal = '.', thousands = '').
    {
        if (empty($decimal_point)) {
        	$decimal_point  = $GLOBALS['localeconv']['decimal_point'];
            $thousands_sep  = $GLOBALS['localeconv']['thousands_sep'];
        } // if
        if ($thousands_sep == chr(160)) {
           $thousands_sep = chr(32);
        } // if

        $number = $input;
        if (strlen($thousands_sep) > 0) {
        	$number = str_replace($thousands_sep, '', $number);
        } // if
        $number = str_replace($decimal_point, '.', $number);

        return $number;

    } // number_unformat
} // if

// ****************************************************************************
if (!function_exists('pasteData')) {
    function pasteData ($fieldspec, $array1, $array2)
    // update the contents of $array1 with saved data in $array2.
    // Observe the following rules:
    // - do not copy into $array1 unless the field exists in $fieldspec.
    // - if a non-null field in $array1 is a primary key then do not update it.
    // - if a field is marked as 'noedit' in $fieldspec then do not update it.
    // - if a field is marked as 'autoinsert' in $fieldspec then do not update it.
    // - if a field is marked as 'autoupdate' in $fieldspec then do not update it.
    // - if a field is a date then do not replace value with an earlier date
    {
        reset($array1);  // fix for version 4.4.1
        if (!is_string(key($array1))) {
            // indexed by row, so use row zero only
            $array1 = $array1[0];
        } // if

        reset($array2);  // fix for version 4.4.1
        if (!is_string(key($array2))) {
            // indexed by row, so use row zero only
            $array2 = $array2[0];
        } // if

        foreach ($array2 as $fieldname => $fieldvalue) {
            if (!array_key_exists($fieldname, $fieldspec)) {
            	$reason = 1; // field not in $fieldspec, so do not copy;
            } elseif (isset($fieldspec[$fieldname]['pkey']) AND !empty($array1[$fieldname])) {
                $reason = 2; // primary key field is not empty, so do not copy
            } elseif (isset($fieldspec[$fieldname]['noedit'])) {
                $reason = 3; // field marked as 'noedit', so do not copy
            } elseif (isset($fieldspec[$fieldname]['auto_increment'])) {
                $reason = 4; // field marked as 'auto_increment', so do not copy
            } elseif (isset($fieldspec[$fieldname]['autoinsert'])) {
                $reason = 5; // field marked as 'autoinsert', so do not copy
            } elseif (isset($fieldspec[$fieldname]['autoupdate'])) {
                $reason = 6; // field marked as 'autoupdate', so do not copy
            } elseif ($fieldspec[$fieldname]['type'] == 'date' AND $array1[$fieldname] > $array2[$fieldname]) {
                $reason = 7; // do not overwrite with an earlier date
            } else {
                $array1[$fieldname] = $array2[$fieldname];
            } // if
        } // foreach

        return $array1;

    } // pasteData
} // if

// ****************************************************************************
if (!function_exists('qualifyField')) {
    function qualifyField ($fieldarray, $tablename, $fieldspec, $table_array, $sql_search_table, $select_alias, &$having_array)
    // Examine each field in $fieldarray and ensure that it is qualified with a table name.
    // If it is already qualified then ensure that its table name exists in $table_array.
    // (NOTE: $table_array is in format 'alias = original')
    // If it is not already qualified then find out which table it belongs to.
    // If the field name appears as an alias in the select string then it is
    // NOTE: $having_array is passed BY REFERENCE as it may be modified
    {
        if (!empty($sql_search_table)) {
            // $sql_search_table may contain 'original AS alias', so split into two
            if ($count = preg_match("/\w+ as \w+/i", $sql_search_table, $regs)) {
                // entry contains 'table AS alias', so use original table table
            	list($search_table_orig, $search_table_alias) = preg_split('/ as /i', $regs[0]);
            } else {
                $search_table_orig  = $sql_search_table;
                $search_table_alias = $sql_search_table;
            } // if
            // rebuild $table_array with $sql_search_table at the front
            $table_array = array_merge(array($search_table_alias => $search_table_orig), $table_array);
        } // if

        $output_array = array();
        foreach ($fieldarray as $fieldname => $fieldvalue) {
            if (is_integer($fieldname)) {
            	// this must be a subquery, so it cannot be qualified
            	$output_array[] = $fieldvalue;
            } elseif (preg_match('/\w+\(.*\)/', $fieldname, $regs)) {
                // this is in format "function(...)", so it cannot be qualified
                $output_array[] = $fieldname.$fieldvalue;
            } elseif (preg_match('/\w+( )+/', $fieldname, $regs)) {
                // this is an expression with multiple words, so it cannot be qualified
                $output_array[] = $fieldname.$fieldvalue;
            } else {
                $namearray = explode('.', $fieldname);
            	if (isset($namearray[1])) {
            	    // fieldname is qualified, but does tablename exist in $table_array?
            	    if (array_key_exists($namearray[0], $table_array)) {
            	        // yes, so copy to $output_array
            	    	$output_array[$fieldname] = $fieldvalue;
            	    } else {
            	        // look for match with original name
            	        if (in_array($namearray[0], $table_array)) {
            	        	$alias = array_search($namearray[0], $table_array);
            	        	$output_array["$alias.$namearray[1]"] = $fieldvalue;
            	        } // if
            	    } // if
            	} else {
            	    // fieldname is not qualified, but does it need to be?
            	    if (in_array($fieldname, $select_alias)) {
            	    	// fieldname is an alias of something, so move it to the HAVING clause
            	    	$having_array[$fieldname] = $fieldvalue;
            	    } elseif (empty($table_array)) {
            	        // if $fieldspec is supplied does it contain fieldname?
            	    	if (empty($fieldspec) or (array_key_exists($fieldname, $fieldspec)) AND !isset($fieldspec[$fieldname]['nondb'])) {
                            // field is in current table, so insert qualified name
                            $output_array["$tablename.$fieldname"] = $fieldvalue;
                        } else {
                            // no other tables is $table_array, so leave fieldname unqualified
                        	$output_array[$fieldname] = $fieldvalue;
                        } // if
            	    } else {
                        // find out if it belongs in one of the other tables in $table_array
                        foreach ($table_array as $array_table_alias => $array_tablename) {
                            if ($array_tablename == $tablename) {
                            	$table_fieldspec = $fieldspec;
                            } else {
                                $class = "classes/$array_tablename.class.inc";
                			    if ($fp = fopen($class, 'r', true)) {
                                	fclose($fp);
                                	// class exists, so inspect it
                                	$dbobject =& singleton::getInstance($array_tablename, null, false);
                                	$table_fieldspec = $dbobject->fieldspec;
                                	unset($dbobject);
                			    } else {
                			        $table_fieldspec = array();
                			    } // if
                            } // if
                            if (array_key_exists($fieldname, $table_fieldspec) AND !isset($table_fieldspec[$fieldname]['nondb'])) {
            					// field is in this table, so insert qualified name
            					$output_array["$array_table_alias.$fieldname"] = $fieldvalue;
            					break;
                            } else {
                                // field does not exist, so it is not carried forward
            				} // if
                        } // foreach
            	    } // if
            	} // if
            } // if
        } // foreach

        return $output_array;

    } // qualifyField
} // if

// ****************************************************************************
if (!function_exists('qualifyOrderby')) {
    function qualifyOrderby ($input, $tablename, $fieldspec, $sql_select, $sql_from)
    // qualify field names in input string with table names.
    {
        if (empty($input)) return;

        if (!empty($sql_from)) {
            $table_array = extractTableNames($sql_from);
        } else {
            $table_array = array();
        } // if

        if (!empty($sql_select)) {
            list($qual_array, $array2) = extractFieldNamesIndexed($sql_select);
            $alias_array = extractAliasNames($sql_select);
        } else {
            $qual_array  = array();
            $alias_array = array();
        } // if

        if (!array_key_exists($tablename, $table_array) AND !in_array($tablename, $table_array)) {
            // for some reason $tablename is missing from $table_array, so do nothing
        	return $input;
        } // if

        // split into substrings separated by comma
        $array = explode(',', $input);

        $output = null;
        foreach ($array as $key => $value) {
            // strip off any trailing 'asc' or 'desc' before testing field name
            $pattern = '/( asc| ascending| desc| descending)$/i';
            if (preg_match($pattern, $value, $regs)) {
                $value    = substr_replace($value, '', -strlen($regs[0]));
                $sequence = trim($regs[0]);
            } else {
                $sequence = '';
            } // if
            $value = trim($value);
            // find out if fieldname is qualified with tablename
            $namearray = explode('.', $value);
            if (isset($namearray[1])) {
                // fieldname is qualified but, ...
                // does fieldname have an alias?
                if (in_array($namearray[1], $alias_array)) {
                    // yes, so it needs no qualification
                    $value = $namearray[1];
                } else {
                    // does tablename have an alias?
                    if (array_key_exists($namearray[0], $table_array)) {
                        // tablename is already aliased, so use it as-is
                        $value = $namearray[0] .'.' .$namearray[1];
                    } elseif (in_array($namearray[0], $table_array)) {
                        // tablename has an alias, so use that instead
            	        $namearray[0] = array_search($namearray[0], $table_array);
            	        $value = $namearray[0] .'.' .$namearray[1];
                    } else {
                        // tablename does not exist in array, so drop this entry
                        $value = '';
                    } // if
                } // if
            } else {
                // fieldname is not qualified
                if (in_array($value, $alias_array)) {
                    // found as alias name in SELECT string, so leave unqualified
                } else {
                    foreach ($qual_array as $tablefield) {
                        if (strpos($tablefield, '.')) {
                        	list($select_table, $select_field) = explode('.', $tablefield);
                        	if ($value == $select_field) {
                        	    // fieldname is qualified in $sql_select, so keep that qualification
                        		$value = $tablefield;
                        		break;
                        	} // if
                        } // if
                    } // foreach
                    if (array_key_exists($value, $fieldspec) AND !isset($fieldspec[$value]['nondb'])) {
                        // it exists within current table, so qualify it with that tablename
                        if (in_array($tablename, $table_array)) {
                            // tablename has an alias, so use that instead
                	        $tablename = array_search($tablename, $table_array);
                        } // if
                    	$value = $tablename .'.' .$value;
                    } // if
                } // if
            } // if
            if (!empty($value)) {
                if (!empty($sequence)) {
                    // append 'asc' or 'desc' which was present on input
                	$value .= ' ' .$sequence;
                } // if
                if (empty($output)) {
                	$output  = $value;
                } else {
                    $output .= ', ' .$value;
                } // if
            } // if
        } // foreach

        return $output;

    } // qualifyOrderby
} // if

// ****************************************************************************
if (!function_exists('qualifySelect')) {
    function qualifySelect ($input, $tablename, $fieldspec)
    // add table names to field names in input string, but only for those fields
    // which exist in $fieldspec.
    {
        if (empty($input)) return;

        // split input string into an array of separate elements
        $elements = extractSelectList($input);

        $output   = null;
        // if fieldname exists in fieldspec it must be qualified with $tablename
        foreach ($elements as $element) {
            // look for 'fieldname AS alias'
            list($original, $alias) = getFieldAlias3($element);
            if ($original != $alias) {
                if (array_key_exists($original, $fieldspec)) {
                    $element = $tablename .'.' .$element;
                } elseif (preg_match("/^\(select /i", $original, $regs)) {
                    // do not qualify anything inside this string
                } else {
                    // look for "function(field1, field2, ...)"
                    if (preg_match('/^\w*\(.*\)/', $original, $regs)) {
                    	$parts = preg_split("/(,)|( )|(\()|(\))/", $original, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
                    	$new = '';
                    	foreach ($parts as $part) {
                    	    if (!empty($part)) {
                    	    	if (array_key_exists($part, $fieldspec)) {
                    	    	    // this is a field within this table, so qualify it with tablename
                                    $part = $tablename .'.' .$part;
                        		} // if
                    	    } // if
                    		$new .= $part;
                    	} // foreach
                    	$element = $new .' AS ' .$alias;
                    } // if
                } // if
            } else {
                if (array_key_exists($element, $fieldspec)) {
                    $element = $tablename .'.' .$element;
                } // if
            } // if
            if (empty($output)) {
            	$output = $element;
            } else {
                $output .= ', ' .$element;
            } // if
        } // foreach

        return $output;

    } // qualifySelect
} // if

// ****************************************************************************
if (!function_exists('qualifyWhere')) {
    function qualifyWhere ($where, $tablename, $fieldspec=null, $sql_from=null, $sql_search_table=null, $select_alias=null, &$having_array)
    // add table names to field names in 'where' string.
    // Some values may be moved from WHERE to HAVING (if the name appears in the select list as an alias).
    {
        // if $where is empty do nothing
        if (empty($where)) return;

        // if $tablename is empty do nothing
        if (empty($tablename)) return $where;

        $tablename = strtolower($tablename);

        if (is_array($where)) {
            $fieldarray = $where;
        } else {
            // convert $where string to $fieldarray
            $fieldarray = where2indexedArray($where);
        } // if

        if ($count = preg_match("/\w+[ ]+as[ ]+\w+/i", $sql_search_table, $regs)) {
            // entry contains 'table AS alias', so use original table table
        	list($original, $alias) = preg_split('/ as /i', $regs[0]);
        	$sql_search_table = $alias;
        } // if

        if (!empty($sql_from)) {
            $table_array = extractTableNames($sql_from);
            if (!array_key_exists($sql_search_table, $table_array)) {
            	$sql_search_table = null;
            } // if
        } else {
            $table_array = array();
        } // if

        $pattern = '/^('        // begins with
                 . 'OR [\(]+'   // 'OR ('
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'OR'         // 'OR'
                 . '|'
                 . 'AND [\(]+'  // 'AND ('
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . '|'
                 . '\)\)'       // '))'
                 . ')$/i';      // ends with, case insensitive

        $array_out = array();
        $last_separator = null;
        $start_condition = true;
        foreach ($fieldarray as $key => $string) {
            $string = trim($string);
        	if (preg_match($pattern, $string, $regs)) {
        	    // this is a separator, not a field
                $last_separator = strtoupper($regs[0]);
                if ($last_separator == '(') {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == ')') {
                	$start_condition = false;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == '))') {
                	$start_condition = false;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == ') OR (') {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == ') AND (') {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } elseif ($last_separator == 'OR') {
                	//$start_condition = true;
                	//$array_out[] = $last_separator;
                	$x = 'do nothing';
                } elseif ($last_separator == 'AND') {
                	//$start_condition = true;
                	//$array_out[] = $last_separator;
                	$x = 'do nothing';
                } elseif (preg_match('/OR [\(]+/i', $string)) {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } elseif (preg_match('/AND [\(]+/i', $string)) {
                	$start_condition = true;
                	$array_out[] = $last_separator;
                } // if
        	} else {
        	    // look for "EXISTS (...)", "NOT EXISTS (...)", "MATCH (...)" or "function(...)"
        	    if (preg_match('/^(exists|not exists|match|\w+)[ ]*\(/i', $string, $regs)) {
        	        $start_condition = false;
        	        if ($last_separator) {
                    	if ($last_separator != '(') {
        	            	$array_out[] = $last_separator;
        	            } // if
                    	$last_separator = null;
                    } // if
        	        $array_out[] = $string;
        	    } else {
                    $fieldarray2 = where2indexedArray($string);
                    foreach ($fieldarray2 as $rownum => $rowdata) {
                        // create a separate array for this row
                        $array1 = where2array($rowdata, false, false);
                        $array2 = qualifyField ($array1, $tablename, $fieldspec, $table_array, $sql_search_table, $select_alias, $having_array);
                        if (empty($array2)) {
                            // nothing to add
                            if (preg_match('/^(OR|AND)/i', $last_separator)) {
                                $last_separator = null;  // this is now invalid
                            } // if
                        } else {
                        	// put modified details back into $fieldarray
                        	if ($last_separator) {
                        	    if (preg_match('/^(OR|AND)/i', $last_separator)) {
                        	        if ($start_condition) {
                        	        	// cannot have AND/OR at the start of a conditional statement
                        	        } else {
                        	            // insert this separator before the field value
                        	            $array_out[] = $last_separator;
                        	        } // if
                                	$last_separator = null;
                        	    } // if
                            } // if
                            // add these details to the output array
                            $array_out[] = array2where($array2);
                            $start_condition = false;
                        } // if
                    } // foreach
        	    } // if
        	} // if
        } // foreach

        if (is_array($where)) {
            // return output as array
            return $array_out;
        } //if

        // convert output array to a string
        $where1 = array2where2($array_out);

        return $where1;

    } // qualifyWhere
} // if

// ****************************************************************************
if (!function_exists('rangeFromTo')) {
    function rangeFromTo (&$from, &$to, $is_date=false)
    // if FROM and TO values exist then set FIELD to 'BETWEEN $from AND $to'.
    // IS_DATE is TRUE for date fields, FALSE for other fields
    {
        $field = null;

        if (!empty($from)) {
            $from = stripOperators($from);
            if (substr($from, -1) == '%') {
            	$from = substr($from, 0, -1);  // remove trailing '%'
            } // if
            if (!empty($to)) {
                $to = stripOperators($to);
                if (substr($to, -1) == '%') {
                	$to = substr($to, 0, -1);  // remove trailing '%'
                } // if
                if ($is_date) {
                	$field = "BETWEEN '$from 00:00:00' AND '$to 23:59:59'";
                } else {
                    if ($from == $to) {
                        // values are the same, so use '='
                	    $field = $from;
                    } else {
                        $field = "BETWEEN '$from' AND '$to'";
                    } // if
                } // if
            } else {
                if ($is_date) {
                    $field = ">= '$from 00:00:00'";
                } else {
                    $field = ">= '$from'";
                } // if
            } // if
            $from = null;
            $to   = null;
        } // if

        if (!empty($to)) {
            $to = stripOperators($to);
            if ($is_date) {
                $field = "<= '$to 23:59:59'";
            } else {
                $field = "<= '$to'";
            } // if
            $to = null;
        } // if

        return $field;

    } // rangeFromTo
} // if

// ****************************************************************************
if (!function_exists('removeDuplicateFromSelect')) {
    function removeDuplicateFromSelect ($select_array, $name)
    // if $name exists in $sql_select then remove it
    {
        foreach ($select_array as $ix => $element) {
            if ($name == $element) {
                unset($select_array[$ix]);  // match found, so remove this entry
            } else {
                // find out if this element contains an alias
                list($original, $alias) = getFieldAlias3($element);
            	if ($original != $alias) {
                    if ($name == $alias) {
                    	unset($select_array[$ix]);  // match found, so remove this entry
                    } // if
            	} else {
                    $namearray = explode('.', $element);
                    if (!empty($namearray[1])) {
                        // name is in format 'table.field', so lose the 'table'
                        $target = $namearray[1];
                    } else {
                        $target = $element;
                    } // if
                	if ($target == $name) {
                        // remove previous entry which uses this name
                    	unset($select_array[$ix]);
                    } // if
            	} // if
            } // if
        } // foreach

        return $select_array;

    } // removeDuplicateFromSelect
} // if

// ****************************************************************************
if (!function_exists('removeTableSuffix')) {
    function removeTableSuffix ($tablename)
    // if $tablename has a suffix of '_snn' it must be removed
    {
        $pattern = '/([_])'         // underscore
                 . '([Ss])'         // upper or lowercase 'S'
                 . '([0-9]{2}$)/';  // 2 digits

        if (preg_match($pattern, $tablename, $regs)) {
            // $tablename ends in $pattern, so remove it
            $tablename = substr($tablename, 0, strlen($tablename)-4);
        } // if

        return $tablename;

    } // removeTableSuffix
} // if

// ****************************************************************************
if (!function_exists('replaceReportHeadings')) {
    function replaceReportHeadings ($replace_array)
    // replace column headings in horizontal section of current report structure.
    // $replace_array is associative in format 'field => label'
    {
        global $report_structure;

        if (array_key_exists('fields', $report_structure['body'])) {
            $headings = $report_structure['body']['fields'];
        } else{
            return FALSE;
        } // if

        foreach ($headings as $col => $column) {
            foreach ($column as $fieldname => $label) {
                if (array_key_exists($fieldname, $replace_array)) {
                    $headings[$col][$fieldname] = $replace_array[$fieldname];
                } // if
            } // foreach
        } // foreach

        $report_structure['body']['fields'] = $headings;

        return TRUE;

    } // replaceReportHeadings
} // if

// ****************************************************************************
if (!function_exists('replaceScreenColumns')) {
    function replaceScreenColumns ($replace_array)
    // replace column name & heading in horizontal section of current screen structure.
    // $replace_array is associative in format 'field = array(field => label)'
    {
        global $screen_structure;

        if (is_array($screen_structure)) {
        	if (array_key_exists('fields', $screen_structure['inner'])) {
            	$zone = 'inner';
            } elseif (array_key_exists('fields', $screen_structure['main'])) {
                $zone = 'main';
            } else {
                return FALSE;
            } // if
        } else {
            return FALSE;
        } // if

        $headings = $screen_structure[$zone]['fields'];

        foreach ($headings as $col => $column) {
            foreach ($column as $fieldname => $label) {
                if (array_key_exists($fieldname, $replace_array)) {
                    // replace old column details with the new one
                    $headings[$col] = $replace_array[$fieldname];
                } // if
            } // foreach
        } // foreach

        $screen_structure[$zone]['fields'] = $headings;

        return TRUE;

    } // replaceScreenColumns
} // if

// ****************************************************************************
if (!function_exists('replaceScreenHeadings')) {
    function replaceScreenHeadings ($replace_array)
    // replace column headings in horizontal section of current screen structure.
    // $replace_array is associative in format 'field => label'
    {
        global $screen_structure;

        if (array_key_exists('fields', $screen_structure['inner'])) {
        	$zone = 'inner';
        } elseif (array_key_exists('fields', $screen_structure['main'])) {
            $zone = 'main';
        } else {
            return FALSE;
        } // if

        $headings = $screen_structure[$zone]['fields'];

        foreach ($headings as $col => $column) {
            foreach ($column as $fieldname => $label) {
                if (array_key_exists($fieldname, $replace_array)) {
                    $headings[$col][$fieldname] = $replace_array[$fieldname];
                } // if
            } // foreach
        } // foreach

        $screen_structure[$zone]['fields'] = $headings;

        return TRUE;

    } // replaceScreenHeadings
} // if

// ****************************************************************************
if (!function_exists('requalifyOrderBy')) {
    function requalifyOrderBy ($string, $sql_select, $link_table, $inner_table, $parent_relations)
    // if the 'orderby' string is qualified with the $link_table name it may need
    // to be changed to the $inner_table name instead.
    {
        if (empty($string)) return;

        if (substr_count($string, '.') < 1) {
        	return $string;  // fieldname not qualified, so do nothing
        } // if

        list($tablename, $fieldname) = explode('.', $string);

        $alias = getTableAlias1 ($fieldname, $sql_select);
        if ($alias) {
        	return $fieldname;  // return alias name as it does not need to be qualified
        } // if

        if ($tablename != $link_table) {
        	return $string;     // fieldname not qualified with $link_table, so do nothing
        } // if

        // find details of relationship between $link_table and $inner_table
        $found = false;
        foreach ($parent_relations as $parent) {
        	if ($parent['parent'] == $inner_table) {
        		$found = true;
        		break;
        	} // if
        	if (isset($parent['alias']) AND $parent['alias'] == $inner_table) {
        		$found = true;
        		break;
        	} // if
        } // foreach
        if (!$found) {
        	return $string;
        } // if

        foreach ($parent['fields'] as $fldchild => $fldparent) {
        	if ($fldchild == $fieldname) {
        	    // this field is part of relationship, so switch table names
        		return $inner_table .'.' .$fieldname;
        	} // if
        } // foreach

        return $string;

    } // requalifyOrderBy
} // if

// ****************************************************************************
if (!function_exists('resizeImage')) {
    function resizeImage ($source, $destination, $width, $height)
    // resize an image according to the specs in $resize_array
    {
        if (!file_exists($source)) {
        	// "File X does not exist"
        	return getLanguageText('sys0057', $source);
        } // if

        if (!is_dir($destination) ) {
            // 'destination directory does not exist'
            return getLanguageText('sys0123', $destination);
        } // if

        $width  = (int)$width;
        $height = (int)$height;
        if ($width <= 0 OR $height <= 0) {
            // "Cannot resize image - dimensions are invalid"
        	return getLanguageText('sys0138', $width, $height);
        } // if

        // get dimensions of source image
        $dim = GetImageSize($source);

        // build dimensions of destination image
        // NOTE: the dimensions of the original image will be maintained,
        // which may cause blank areas in the new image
        if ($dim[0] > $dim[1]) {
        	$to_w = $width;
        	$to_h = round($dim[1]*($height/$dim[0]));
        	$to_x = 0;
        	$to_y = round($width-$to_h)/2;
        } else {
        	$to_h = $height;
        	$to_w = round($dim[0]*($width/$dim[1]));
        	$to_y = 0;
        	$to_x = round($height-$to_w)/2;
        } // if

        switch ($dim['mime']) {
        	case 'image/jpeg':
        		$from = ImageCreateFromJPEG($source);
        		break;

        	case 'image/gif':
        		$from = ImageCreateFromGIF($source);
        		break;

        	case 'image/png':
        		$from = ImageCreateFromPNG($source);
        		break;

        	default:
        	    // "Cannot resize image - MIME type (x) is unsupported"
        	    return getLanguageText('sys0137', $dim['mime']);
        		break;
        } // switch

        // create a new image
    	$thumb = imagecreatetruecolor($width, $height);
    	// set background to white, full transparency
    	imagesavealpha($thumb, true);
    	$bgc = imagecolorallocatealpha($thumb, 255, 255, 255, 127);
    	imagefill($thumb, 0, 0, $bgc);
        // copy 'old' image to the 'new' image, with adjusted dimensions
    	imagecopyresampled($thumb, $from, $to_x, $to_y, 0, 0, $to_w, $to_h, $dim[0], $dim[1]);

    	// copy the 'new' image to disk using the correct MIME type
    	list($fname, $ext) = explode('.', basename($source));

     	switch ($dim['mime']) {
        	case 'image/jpeg':
        	    $destination .= '/' .$fname .'.jpg';
        	    if (file_exists($destination)) unlink($destination);
        		$result = ImageJPEG($thumb, $destination, 100);
        		break;

        	case 'image/gif':
        	    $destination .= '/' .$fname .'.gif';
        	    if (file_exists($destination)) unlink($destination);
        		$result = ImageGIF($thumb, $destination, 100);
        		break;

        	case 'image/png':
        	    $destination .= '/' .$fname .'.png';
        	    if (file_exists($destination)) unlink($destination);
        		$result = ImagePNG($thumb, $destination, 100);
        		break;

        	default:
        	    $result = false;
        		break;
        } // switch

     	if ($result) {
     	    // "File uploaded into $destination";
     	    $msg = getLanguageText('sys0126', $destination ." ($width x $height)");
     	    if (!preg_match('/^WIN/i', PHP_OS)) {
            	$result = chmod($uploadfile, 0664);
            } // if
    	} else {
    	    // "Image NOT resized"
    	    $msg = getLanguageText('sys0139', $width, $height);
    	} // if

    	ImageDestroy($from);
    	ImageDestroy($thumb);

        return $msg;

    } // resizeImage
} // if

// ****************************************************************************
if (!function_exists('selection2null')) {
    function selection2null ($pkeyarray)
    // create WHERE clause with each pkey field set to NULL.
    {
        $where = null;
        foreach ($pkeyarray as $fieldname) {
            if (empty($where)) {
                $where = "$fieldname=''";
            } else {
                $where .= " AND $fieldname=''";
            } // if
        } // foreach

        return $where;

    } // selection2null
} // if

// ****************************************************************************
if (!function_exists('saveLocaleFormat')) {
    function saveLocaleFormat ($language)
    // store locale data based on user's preferred language.
    {
        $user_language_array = get_languages($language);

        $locale = rdc_setLocale($user_language_array[0][2]);

        $localeconv = localeconv();
        if ($localeconv['thousands_sep'] == chr(160)) {
            // change non-breaking space into ordinary space
            $localeconv['thousands_sep'] = chr(32);
        } // if

        $GLOBALS['localeconv']['decimal_point'] = $localeconv['decimal_point'];
        $GLOBALS['localeconv']['thousands_sep'] = $localeconv['thousands_sep'];
        $GLOBALS['localeconv']['p_cs_precedes'] = $localeconv['p_cs_precedes'];
        $GLOBALS['localeconv']['n_cs_precedes'] = $localeconv['n_cs_precedes'];
        //$GLOBALS['localeconv']['currency_symbol'] = $localeconv['currency_symbol'];

        // set to locale where decimal point is '.' (as used internally)
        $internal_locale = rdc_setLocale("English (United Kingdom) [en_GB]");

        return $locale;

    } // saveLocaleFormat
} // if

// ****************************************************************************
if (!function_exists('selection2where')) {
    function selection2where ($pkeyarray, $select)
    // turn selection into SQL 'where' criteria.
    // $pkeyarray is an array of primary key name/value pairs for each row.
    // $select identifies which row(s) have been selected.
    {
        if (is_array($select)) {
            $where_array = array();
            // for each row that has been selected...
            foreach ($select as $rownum => $on) {
                // add associated pkey string into 'where' clause
                $where2 = null;
                foreach ($pkeyarray[$rownum] as $fieldname => $fieldvalue) {
                    $fieldvalue = addslashes($fieldvalue);
                    if (empty($where2)) {
                        $where2 = "$fieldname='$fieldvalue'";
                    } else {
                        $where2 .= " AND $fieldname='$fieldvalue'";
                    } // if
                } // foreach
                // put into an indexed array
                $where_array[] = $where2;
            } // foreach
            // convert indexed array into a string
            $where = joinWhereByRow($where_array);
        } else {
            // $select is a string containing a single selection
            $where = null;
            foreach ($pkeyarray[$select] as $fieldname => $fieldvalue) {
                $fieldvalue = addslashes($fieldvalue);
                if (empty($where)) {
                    $where = "$fieldname='$fieldvalue'";
                } else {
                    $where .= " AND $fieldname='$fieldvalue'";
                } // if
            } // foreach
        } // if

        return $where;

    } // selection2where
} // if

// ****************************************************************************
if (!function_exists('setColumnAttributes')) {
    function setColumnAttributes ($zone, $input_data)
    // set column attributes in a zone within the current screen structure.
    {
        global $screen_structure;

        if (is_array($screen_structure)) {
        	foreach ($screen_structure[$zone]['fields'] as $col => $col_data) {
            	$field = key($col_data);
            	if (is_int($field)) {
                    // this is an array of fields
                    foreach ($col_data as $col2 => $col_data2) {
                    	$type  = key($col_data2);
                    	if ($type == 'field') {
                    		$field = $col_data2[$type];
                        	foreach ($input_data as $input_field => $input_array) {
                        		if ($input_field == $field) {
                        			foreach ($input_array as $attr_name => $attr_value) {
                        			    // set the field to 'nodisplay' and the label is automatically blanked out
                        			    $screen_structure[$zone]['fields'][$col][$col2][$attr_name] = $attr_value;
                        				//$screen_structure[$zone]['columns'][$col2][$attr_name] = $attr_value;
                        			} // foreach
                        		} // if
                        	} // foreach
                    	} // if
                    } // foreach
            	} else {
            	    // array is keyed by field name
                	foreach ($input_data as $input_field => $input_array) {
                		if ($input_field == $field) {
                			foreach ($input_array as $attr_name => $attr_value) {
                			    $screen_structure[$zone]['fields'][$col][$attr_name] = $attr_value;
                				$screen_structure[$zone]['columns'][$col][$attr_name] = $attr_value;
                			} // foreach
                		} // if
                	} // foreach
            	} // if
            } // foreach
        } // if

        return true;

    } // setColumnAttributes
} // if

// ****************************************************************************
if (!function_exists('setColumnHeadings')) {
    function setColumnHeadings ($headings)
    // replace column headings in horizontal section of current screen structure.
    // (must have been first obtained using getColumnHeadings() method)
    //
    // DEPRECATED - USE replaceScreenHeadings() INSTEAD
    {
        global $screen_structure;

        if (array_key_exists('zone', $headings)) {
            $zone = $headings['zone'];
            unset($headings['zone']);
            $screen_structure[$zone]['fields'] = $headings;
        } // if

        return $headings;

    } // setColumnHeadings
} // if

// ****************************************************************************
if (!function_exists('setSessionHandler')) {
    function setSessionHandler ()
    // custom session handler uses a database table, not disk files.
    {
        $handler =& singleton::getInstance('php_session');
        session_set_save_handler(array(&$handler, 'open'),
                                 array(&$handler, 'close'),
                                 array(&$handler, 'read'),
                                 array(&$handler, 'write'),
                                 array(&$handler, 'destroy'),
                                 array(&$handler, 'gc'));

        return $handler;

    } // setSessionHandler
} // if

// ****************************************************************************
if (!function_exists('splitNameOperatorValue')) {
    function splitNameOperatorValue (&$where)
    // split a 'name|operator|value' string into its component parts.
    // ($where is passed by reference so that it can be amended)
    {
        // construct list of possible operators between fieldname and fieldvalue
        $operators = "/(<>|<=|<|>=|>|!=|=| NOT LIKE | LIKE | IS NOT | IS | NOT IN[ ]*\(| IN[ ]*\(| BETWEEN | NOT EXISTS[ ]*\(| EXISTS[ ]*\(|MATCH[ ]*\()/i";

        $where = ltrim($where);
        if (preg_match('/^[a-z]/i', $where, $regs)) {
            // $where starts with an alphabetic character, so insert a single leading space
            $where = ' '.$where;
        } // if

        if (preg_match($operators, $where, $regs, PREG_OFFSET_CAPTURE)) {
            $operator = $regs[0][0];    // found an operator
            $startpos = $regs[0][1];    // start position of this operator

            if (preg_match('/^(NOT IN|IN|NOT EXISTS|EXISTS)/i', ltrim($operator))) {
                if (substr($operator, -1, 1) == '(') {
                    // strip trailing '('
                	$operator = substr($operator, 0, strlen($operator)-1);
                } // if
            } // if

            if (preg_match('/^MATCH/i', $operator)) {
            	// format = "match(field1, field2, ...) against('string' [in boolean mode])"
            	// note that this terminates on the first ')'
            	$count = preg_match("/AGAINST\('.+'.+[^\)]\)/i", $where, $regs, PREG_OFFSET_CAPTURE);
            	$endpos = $regs[0][1] + strlen($regs[0][0]);
            	$operator   = substr($where, 0, $endpos);
            	$fieldname  = '';
            	$fieldvalue = '';
            	$where = substr($where, $endpos);
            } else {
                // everything in front is a fieldname
                $fieldname = trim(substr($where, 0, $startpos));
                // strip off any leading parenthesis
                $fieldname = ltrim($fieldname, '(');
                // calculate length of $fieldname + operator
                $endpos = $startpos + strlen($operator);
                // remove this bit from the front of the string
                $where = ltrim(substr($where, $endpos));

                $fieldvalue = extractValue($where);
            } // if

            // are we dealing with an operator of BETWEEN?
            if (preg_match('/BETWEEN/i', trim($operator))) {
                // yes, so include the following " AND 'x'"
                if (preg_match('/ AND /i', $where)) {
                    $where = ltrim($where, ' ANDand');      // remove separator
                    $fieldvalue2 = extractValue($where);    // find second value
                    $fieldvalue .= ' AND ' .$fieldvalue2;   // recombine
                } else {
                    trigger_error(getLanguageText('sys0019'), E_USER_ERROR); // "Missing 'AND' after 'BETWEEN' in WHERE clause"
                } // if
            } // if

        } else {
            // no operator found
            if (substr_count($where, ' ') == 0) {
            	$fieldname  = $where;
            	$operator   = '=';
            	$fieldvalue = '';
            	$where      = null;
            } else {
                list($fieldname, $fieldvalue) = explode(' ', $where, 2);
                if (empty($fieldname)) {
                	$fieldname = 'NULL';
                	$where     = null;
                } // if
                if (strpos($fieldvalue, '%') === false) {
                    // use default operator
                    $operator = '=';
                } else {
                    // wildcard character found, so use LIKE
                    $operator = 'LIKE';
                } // if
            } // if
            // enclose value in single quotes (ensuring it hasn't been done already)
            $fieldvalue = "'" .addslashes($fieldvalue) ."'";
        } // if

        $operator = trim($operator);
        if (preg_match('/^[a-z]/i', $operator, $regs)) {
            // operator starts with alphabetic character (IS, LIKE, BETWEEN, MATCH), so ...
            if (empty($fieldname)) {
            	// no fieldname, so insert a trailing space only
                $operator = $operator .' ';
            } else {
                // insert a leading and trailing space
                $operator = ' ' .$operator .' ';
            } // if
            if (preg_match('/^match/i', $operator, $regs)) {
            	$operator = strtoupper($operator);
            } // if
        } // if

        // put all three elements into the output array
        $array[] = $fieldname;
        $array[] = $operator;
        $array[] = trim($fieldvalue);

        return $array;

    } // splitNameOperatorValue
} // if

// ****************************************************************************
if (!function_exists('splitWhereByRow')) {
    function splitWhereByRow ($input)
    // convert $input into an array with ' OR ' being used to create a new row.
    // EXAMPLE: "(...) OR (...) OR (...)" results in 3 entries.
    // (this is the opposite of joinWhereByRow)
    {
        if (is_array($input)) {
        	$array1 = $input;
        } else {
            // convert string into an array
            $array1 = where2indexedArray($input);
        } // if

        $array2  = array();
        $string = '';
        foreach ($array1 as $key => $value) {
        	if (preg_match('/^(\) OR \()$/i', $value, $regs)) {
                // add current string as a separate entry to output array
                $array2[] = trim($string, '() ');
                $string  = '';
            } else {
                // append to current string
            	$string .= $value .' ';
            } // if
        } // foreach

        if (!empty($string)) {
            $string = trim($string, ' ');
            if (substr($string, 0, 1) == '(') {
                // remove leading '('
            	$string = substr($string, 1);
            	if (substr($string, -1) == ')') {
            	    // remove trailing ')'
            		$string = substr($string, 0, -1);
            	} // if
            } // if
            if (substr($string, -1) == ')') {
                // string has trailing ')', but does it have an earlier '('?
                $count_left  = substr_count($string, '(');
                $count_right = substr_count($string, ')');
                if ($count_left < $count_right) {
                	// too many ')', so remove the last one
                    $string = substr($string, 0, -1);
                } elseif ($count_left > $count_right) {
                    // not enough ')', so append one
                    $string .= ')';
                } // if
            } // if
            $array2[] = trim($string, ' ');
        } // if

        return $array2;

    } // splitWhereByRow
} // if

// ****************************************************************************
if (!function_exists('stripOperators')) {
    function stripOperators ($fieldarray)
    // change an array containing 'name=value' pairs so that the value portion
    // does not contain any comparison operators or enclosing single quotes.
    {
        if (is_array($fieldarray)) {
            foreach ($fieldarray as $fieldname => $fieldvalue) {
                $fieldvalue             = stripOperators_ex($fieldvalue);
                $fieldarray[$fieldname] = stripslashes($fieldvalue);
            } // foreach
            return $fieldarray;
        } // if

        if (is_string($fieldarray)) {
            $fieldvalue = stripOperators_ex($fieldarray);
            $fieldvalue = stripslashes($fieldvalue);
            return $fieldvalue;
        } // if

        return $fieldarray;

    } // stripOperators
} // if

// ****************************************************************************
if (!function_exists('stripOperators_ex')) {
    function stripOperators_ex ($input)
    // turn string from "='value'" or "=value" to "value"
    {
        if (preg_match('/^(<=|>=|!=|=|<|>|NO LIKE |LIKE )/i', ltrim($input), $operator)) {
            $output = substr($input, strlen($operator[0]));
            $output = trim($output);

            // the next character is the delimiter (single or double quote)
            $delimiter = substr($output, 0, 1);
            if ($delimiter == '"' or $delimiter == "'") {
                // delimiter found, so remove from both ends of string
                $output = substr($output, 1);
                $output = substr($output, 0, -1);
            } else {
            	// no delimiter found, so use whole string
                $output = $output;
            } // if

            return $output;
        } // if

        return $input;

    } // stripOperators_ex
} // if

// ****************************************************************************
if (!function_exists('unqualifyFieldArray')) {
    function unqualifyFieldArray ($fieldarray)
    // turn any key which is 'table.field' into 'field'.
    {
        if (!is_array($fieldarray)) {
        	return $fieldarray;
        } // if

        foreach ($fieldarray as $fieldname => $fieldvalue) {
        	if ($substring = strrchr($fieldname, '.')) {
        	    unset($fieldarray[$fieldname]);
                // now remove the tablename and put amended entry back into the array
                $fieldname = ltrim($substring, '.');
                $fieldarray[$fieldname] = $fieldvalue;
            } // if
        } // foreach

        return $fieldarray;

    } // unqualifyFieldArray
} // if

// ****************************************************************************
if (!function_exists('unqualifyOrderBy')) {
    function unqualifyOrderBy ($string)
    // remove any table names from field names in 'order by' string
    {
        if (empty($string)) return;

        // split into substrings separated by comma or space
        $array = preg_split('(( )|(,))', $string, -1, PREG_SPLIT_DELIM_CAPTURE);

        $newstring = '';
        foreach ($array as $key => $value) {
        	if ($substring = strrchr($value, '.')) {
                // now remove the tablename and put amended entry back
                $value = ltrim($substring, '.');
            } // if
            $newstring .= $value;
        } // foreach

        return $newstring;

    } // unqualifyOrderBy
} // if

// ****************************************************************************
if (!function_exists('unqualifyWhere')) {
    function unqualifyWhere ($where)
    // remove any table names from field names in 'where' string
    {
        if (empty($where)) return;

        // convert $where string to $fieldarray
        $fieldarray = where2indexedArray($where);

        $pattern = '/^('        // begins with
                 . 'OR'         // 'OR'
                 . '|'
                 . '\) OR \('   // ') OR ('
                 . '|'
                 . 'AND \('     // 'AND ('
                 . '|'
                 . 'AND'        // 'AND'
                 . '|'
                 . '\) AND \('  // ') AND ('
                 . '|'
                 . '\('         // '('
                 . '|'
                 . '\)'         // ')'
                 . ')$/i';      // ends with, case insensitive

        $where_array = array();
        foreach ($fieldarray as $key => $string) {
            $string = trim($string);
        	if (preg_match($pattern, $string, $regs)) {
        	    $where_array[] = $regs[0];
        	} else {
        	    if (preg_match('/^(EXISTS|NOT EXISTS|MATCH)[ ]*\(/i', $string, $regs)) {
        	        $where_array[] = $string;
        	    } else {
        	        list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
        	        if ($substring = strrchr($fieldname, '.')) {
                        // now remove the tablename and put amended entry back into the array
                        $fieldname = ltrim($substring, '.');
                    } // if
        	        $where_array[] = $fieldname .$operator .$fieldvalue;
        	    } // if
        	} // if
        } // foreach

        if (is_array($where)) {
            // return output as array
            return $where_array;
        } //if

        // convert output array to a string
        $where1 = array2where2($where_array);

        return $where1;

    } // unqualifyWhere
} // if

// ****************************************************************************
if (!function_exists('unsetColumnAttributes')) {
    function unsetColumnAttributes ($zone, $input_data)
    // unset column attributes in a zone within the current screen structure.
    {
        global $screen_structure;

        foreach ($screen_structure[$zone]['fields'] as $col => $col_data) {
        	$field = key($col_data);
        	foreach ($input_data as $key => $input_array) {
        		if ($key == $field) {
        			foreach ($input_array as $attr_name => $attr_value) {
        				unset($screen_structure[$zone]['fields'][$col][$attr_name]);
        				unset($screen_structure[$zone]['columns'][$col][$attr_name]);
        			} // foreach
        		} // if
        	} // foreach
        } // foreach

        return true;

    } // unsetColumnAttributes
} // if

// ****************************************************************************
if (!function_exists('validateSortItem')) {
    function validateSortItem ($zone, $sortfield, $dbobject, $structure=array())
    // check that the sort field actually exists in the current screen or dbobject.
    // this stops a naughty user from manually altering the URL to point to
    // a field name that does not exist, thus causing an SQL error.
    {
        $sortfield = strtolower(unqualifyOrderBy($sortfield));

        if ($sortfield == 'selectbox') {
        	return FALSE; // cannot sort on this field
        } // if

        $fieldspec     = $dbobject->getFieldSpec();     // get fieldspecs for current dbobject
        $orderby_table = $dbobject->sql_orderby_table;  // get name of alternate sort table

        $array1 = explode(",", $sortfield);     // convert input string to array of field names
        $array2 = array();                      // array of valid field names
        $array3 = array();                      // carry forward to next step

        // look for fields which exist within the current table
        foreach ($array1 as $field) {
            $field = trim($field);
            // strip off any trailing 'asc' or 'desc' before testing field name
            $pattern = '/( asc| ascending| desc| descending)$/i';
            if (preg_match($pattern, $field, $regs)) {
                $test_field = substr_replace($field, '', -strlen($regs[0]));
            } else {
                $test_field = $field;
            } // if
            // ignore field if 'nondb' option (not in database) is set
            if (array_key_exists($test_field, $fieldspec) AND !isset($fieldspec[$test_field]['nondb'])) {
                // field exists in this table, so qualify the name
                $array2[] = $dbobject->getTableName() .'.' .$field;
            } else {
                // carry forward to next step
                $array3[] = $field;
            } // if
        } // foreach

        // look for fields which exist within the current screen
        // (usually obtained from a different table via a JOIN)
        foreach ($array3 as $sortfield) {
            if (!empty($zone) AND array_key_exists('fields', $structure[$zone])) {
            	foreach ($structure[$zone]['fields'] as $array) {
                    if (is_string(key($array))) {
                        // array is associative
                    	if (array_key_exists($sortfield, $array)) {
                    	    if (isset($orderby_table)) {
                    	    	$array2[] = $orderby_table .'.' .$sortfield;
                    	    } else {
                		        $array2[] = $sortfield;
                    	    } // if
                	    } // if
                    } else {
                        // this is an array within an array, so step through each sub-array
                        foreach ($array as $array4) {
                        	if (array_key_exists('field', $array4)) {
                        		if ($array4['field'] == $sortfield) {
                        			if (isset($orderby_table)) {
                            	    	$array2[] = $orderby_table .'.' .$sortfield;
                            	    } else {
                        		        $array2[] = $sortfield;
                            	    } // if
                        		} // if
                        	} // if
                        } // foreach
                    } // if
                } // foreach
            } else {
                if ($GLOBALS['mode'] == 'csv') {
                    // assume that it is valid
                	$array2[] = $sortfield;
                } // if
            } // if
        } // foreach

        $output = implode(",", $array2);    // convert from array to string

        return $output;

    } // validateSortItem
} // if

// ****************************************************************************
if (!function_exists('validateSortItem2')) {
    function validateSortItem2 ($sortfield, $sql_select, $fieldspec)
    // check that the sort field actually exists in the $sql_select string,
    // otherwise it may cause an error.
    {
        $select_array = extractFieldNamesAssoc ($sql_select);

        // create a 2nd array with unqualified names
        $select_array_unq = array();
        foreach ($select_array as $key => $value) {
        	if ($substring = strrchr($value, '.')) {
                // now remove the tablename and put amended entry back
                $value = ltrim($substring, '.');
            } // if
            $select_array_unq[$value] = $value;
        } // foreach

        $array1 = explode(",", $sortfield);     // convert input string to array of field names
        $array2 = array();                      // array of valid field names

        // look for fields which exist within the current table
        foreach ($array1 as $field) {
            $field = trim($field);
            // strip off any trailing 'asc' or 'desc' before testing field name
            $pattern = '/( asc| ascending| desc| descending)$/i';
            if (preg_match($pattern, $field, $regs)) {
                $test_field = substr_replace($field, '', -strlen($regs[0]));
            } else {
                $test_field = $field;
            } // if
            if (array_key_exists($test_field, $select_array)) {
            	$array2[] = $field;  // this is valid
            } elseif (array_key_exists($test_field, $select_array_unq)) {
            	$array2[] = $field;  // this is valid
            } else {
                if (array_key_exists($test_field, $fieldspec) AND !isset($fieldspec[$test_field]['nondb'])) {
                	$array2[] = $field;  // this is valid
            	} elseif ($substring = strrchr($test_field, '.')) {
                    // remove table name from front of field name
                    $test_field_unq = ltrim($substring, '.');
                    if (array_key_exists($test_field_unq, $select_array_unq)) {
                    	$array2[] = $field;  // this is valid
                    } elseif (array_key_exists($test_field_unq, $fieldspec) AND !isset($fieldspec[$test_field_unq]['nondb'])) {
                    	$array2[] = $field;  // this is valid
                    } // if
            	} // if
            } // if
        } // foreach

        $output = implode(",", $array2);    // convert from array to string

        return $output;

    } // validateSortItem2
} // if

// ****************************************************************************
if (!function_exists('where2array')) {
    function where2array ($where, $pageno=null, $strip_operators=true)
    // change an SQL 'where' string into an association array of field names and values.
    // this function has the following steps:
    // 1 - convert string into an indexed array
    // 2 - convert index array into an associative array
    // 3 - strip operators from the associative array (optional)
    {
        // if input string is empty there is nothing to do
        if (empty($where)) return array();

        $array1 = where2indexedArray($where);   // convert string into indexed array

        if (in_array(') or (', $array1) OR in_array(') OR (', $array1)) {
            // $where contains multiple selections in the format "(...) OR (...)" so...
            // split into separate selections (rows)
        	$array1 = splitWhereByRow($array1);
        	if (is_null($pageno) or $pageno === FALSE) {
        	    // do nothing
        	} else {
        		$pageno = (int)$pageno;
            	if ($pageno <= 0) $pageno = 1;
            	if ($pageno > 0) {
                    // extract a single row to remove duplicate field names
                	$array1 = array($array1[$pageno-1]);
                	$array1 = where2indexedArray($array1);
                } // if
        	} // if
        } // if

        $array2 = indexed2assoc($array1);       // convert indexed array to associative
        if (is_True($strip_operators)) {
        	$array3 = stripOperators($array2);  // strip operators in front of values
        	return $array3;
        } // if

        return $array2;

    } // where2array
} // if

// ****************************************************************************
if (!function_exists('where2indexedArray')) {
    function where2indexedArray ($where)
    // change an SQL 'where' clause into an array of field names and values
    // $where is in the format: (name='value' AND name='value' AND ...)
    // or possibly: (name='value' AND name='value') OR (name='value' AND name='value') OR ...
    // or possibly: (name BETWEEN 'value1' AND 'value2' AND name='value') ...
    // or possibly: (name='something=\'this\'' AND somethingelse=\'that\'')
    // or possible: [NOT] EXISTS (subquery)
    {
        // if input string is empty there is nothing to do
        if (empty($where)) return array();

        if (is_array($where)) {
            reset($where);  // fix for version 4.4.1
        	if (!is_string(key($where))) {
        	    // this is a indexed array, so extract first string value
            	$where = $where[key($where)];
            } // if
        } // if

        $array = array();
        while (!empty($where)) {
            // start by looking for words or symbols which appear between name=value pairs
            $where = extractSeparator($where, $array);
            if (!empty($where)) {
                list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($where);
                // add this $fieldname/$fieldvalue pair to the output array
                $array[] = $fieldname .$operator .$fieldvalue;
            } // if
        } // while

        return $array;

    } // where2indexedArray
} // if

// ****************************************************************************

if (isset($_SERVER['SERVER_PROTOCOL'])) {
    $protocol = 'HTTP://';
    require_once 'include.session.inc';
} else {
    // this is being run in batch/cli mode, not from a web server
    $protocol = '';
} // if

$handler = setSessionHandler();
unset($handler);

?>
