<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require_once 'std.singleton.php4.inc';
} else {
    // PHP 5 uses different code
    require_once 'std.singleton.php5.inc';
} // if

// ****************************************************************************
if (!function_exists('add_days_to_date')) {
    function add_days_to_date ($date_in, $days, $exclude_saturday=false, $exclude_sunday=false)
    // add $days to $date, excluding Saturday and/or Sunday as appropriate.
    {
        if (!preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}/', $date_in)) {
            return false;  // not in format 'ccyy-mm-dd' or 'ccyy-mm-dd hh:mm:ss'
        } // if

        $date_out = $date_in;
        $days     = abs((int)$days);  // ensure this is a positive integer

        $timestamp = strtotime($date_out);
        while ($days > 0) {
            //$date_out = adjustDate($date_out, +1, 'days');
            $timestamp = strtotime('+1 day', $timestamp);
            $date_out = date('Y-m-d',$timestamp);

            // is this new date a Saturday or Sunday?
            //$timestamp = strtotime($date_out);
            $date_info = getdate($timestamp);
            if       ($exclude_saturday     AND $date_info['weekday'] == 'Saturday') {
                $skip = true;
            } elseif ($exclude_sunday       AND $date_info['weekday'] == 'Sunday') {
                $skip = true;
            } else {
                $days = $days - 1;  // this is a valid work day, so drop it
            } // if
        } // while

        return $date_out;

    } // add_days_to_date
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
            if (!$done) {
            	if (preg_match('/SRCH/i', $button_data['pattern_id'], $regs)) {
                    // found task_id with pattern 'search', so add an extra button
                    $buttons_out[] = array('task_id' => 'previous_search',
                                           'button_text' => 'Previous Search',
                                           'context_preselect' => 'N');
                    $done = true;
                } // if
            } // if
        } // foreach

        return $buttons_out;

    } // addPreviousSearchButton
} // if

// ****************************************************************************
if (!function_exists('adjustDate')) {
	function adjustDate ($date, $adjustment, $units='days')
    // adjust a date value by a specified number of units (days, weeks, months or years).
    // Note that the adjustment may be negative.
    {
        $dateobj =& RDCsingleton::getInstance('date_class');

        if (isset($GLOBALS['date_format'])) {
            $dateobj->date_format = $GLOBALS['date_format'];
        } // if

        switch (strtolower($units)) {
        	case 'days':
            case 'day':
            case 'd':
        		$out_date = $dateobj->addDays($date, $adjustment);
        		break;

        	case 'weeks':
            case 'week':
            case 'w':
        		$out_date = $dateobj->addWeeks($date, $adjustment);
        		break;

        	case 'months':
            case 'month':
            case 'm':
        		$out_date = $dateobj->addMonths($date, $adjustment);
        		break;

        	case 'years':
            case 'year':
            case 'y':
                $out_date = $dateobj->addYears($date, $adjustment);
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
if (!function_exists('adjustQueryString')) {
    function adjustQueryString ($query_string='', $include_session_id=false)
    // adjust query string so that it can be appended to a URL
    {
    	if (is_array($query_string)) {
    		$array = $query_string;
    	} else {
        	parse_str($query_string, $array);
		} // if

        $session_name = session_name();
        if (!empty($session_name)) {
        	$array['session_name'] = $session_name;
        } // if
        if ($include_session_id === false) {
            unset($array['session_id']);
        } else {
            $session_id = session_id();
            if (!empty($session_id)) {
        	    $array['session_id'] = $session_id;
            } // if
        } // if

        // this is redundant, so remove it
        unset($array['PHPSESSID']);

        $query_string = http_build_query($array, '', '&');

        return $query_string;

    } // adjustQueryString
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
    function append2ScriptSequence ($next, $prepend=false)
    // append/prepend details of next task to $_SESSION['script_sequence']
    {
        if (preg_match('/INTERNET/i', $_SESSION['logon_user_id'])) {
            return;
        } // if

        if (!is_array($next)) {
            return;
        } // if

        $next['inserted_by'] = $GLOBALS['task_id'];

        if (array_key_exists('settings', $next)) {
            if (is_array($next['settings'])) {
                // convert from array to a string
                $string = http_build_query($next['settings'], null, '&');
                $next['settings'] = $string;
            } // if
        } // if

        if ($prepend == true AND isset($_SESSION['script_sequence']) AND is_array($_SESSION['script_sequence'])) {
            // prepend to existing array
            $count = array_unshift($_SESSION['script_sequence'], $next);
        } else {
            // append
            $_SESSION['script_sequence'][] = $next;
        } // if

        return;

    } // append2ScriptSequence
} // if

// ****************************************************************************
if (!function_exists('array_reduce_to_named_list')) {
    function array_reduce_to_named_list ($array_in, $fieldspec=array())
    // remove entries from $array which do not exist in $fieldspec
    {
        $array_out = array();

        if (empty($fieldspec)) {
            return $array_out;
        } // if

        if (is_long(key($fieldspec))) {
            // array is indexed, so flip to turn the values into keys
            $fieldspec = array_flip($fieldspec);
        } // if

        if (is_array($array_in)) {
            foreach ($array_in as $name => $value) {
                if (is_string($name)) {
                    if (array_key_exists($name, $fieldspec)) {
                        $array_out[$name] = $value;
                    } // if
                } else {
                    $array_out[$name] = $value;
                } // if
            } // foreach
        } // if

        return $array_out;

    } // array_reduce_to_named_list
} // if

// ****************************************************************************
if (!function_exists('array_update_associative')) {
    function array_update_associative ($array1, $array2, $fieldspec=array())
    // update contents of $array1 from contents of $array2.
    // Note: this is different from a merge which will add new fields into $array1
    // if they did not previously exist, which is not what I want. This version
    // will not create any items in $array1 which did not previously exist.
    {
        reset($array1);  // fix for version 4.4.1
        if (!empty($array1) AND !is_string(key($array1))) {
            // indexed by row, so use row zero only
            $array1 = $array1[key($array1)];
        } // if

        reset($array2);  // fix for version 4.4.1
        if (!empty($array2) AND !is_string(key($array2))) {
            // indexed by row, so use row zero only
            $array2 = $array2[key($array2)];
        } // if

        foreach ($array2 as $fieldname => $fieldvalue) {
            if (array_key_exists($fieldname, $array1)) {
                if (isset($fieldspec[$fieldname])) {
                    $spec = $fieldspec[$fieldname];
                    if (preg_match('/(decimal|numeric|float|real|double|integer)/i', $spec['type'])) {
                        // this field in the POST array is numeric, so the value was formatted for display
                        // in the user's locale. It must be unformatted before it can be used internally.
                        if (is_array($array2[$fieldname])) {
                            foreach ($array2[$fieldname] as $key => $value) {
                                $array2[$fieldname][$key] = number_unformat($array2[$fieldname][$key]);
                            } // foreach
                        } else {
                            $array2[$fieldname] = number_unformat($array2[$fieldname]);
                        } // if
                    } // if
                } else {
                    $spec = array();
                } // if
                //if (is_array($array2[$fieldname]) AND is_array($array1[$fieldname])) {
				//if (is_array($array2[$fieldname]) AND (is_array($array1[$fieldname]) || empty($array1[$fieldname]))) {
                if (!empty($spec) AND ($spec['type'] == 'array' OR (isset($spec['control']) AND preg_match('/^(multidrop|m_checkbox|checkbox_multi)$/i', $spec['control'])) AND is_array($array2[$fieldname]))) {
                    $array1[$fieldname] = $array2[$fieldname];  // both arrays, so update
                } elseif (!is_array($array2[$fieldname]) AND !is_array($array1[$fieldname])) {
                    $array1[$fieldname] = $array2[$fieldname];  // both scalars, so update
                } else {
                    $msg = "type mismatch - data not copied";
                } // if
            } // if
        } // foreach

        return $array1;

    } // array_update_associative
} // if

// ****************************************************************************
if (!function_exists('array_update_empty')) {
    function array_update_empty ($array1, $array2, $extra=null, $fieldspec=null, $allow_null=false)
    // update contents of $array1 from contents of $array2.
    // Note: this is different from a merge which will overwrite $array1 with
    // contents of $array2, which is not what I want. This version will only update
    // $array1 if the key does not exist, or the value is empty.
    // $extra, if provided, will be appended to each entry copied from $array2 to $array1.
    // $allow_null will copy an empty field from array2 to array1 if it does not already exist in array1
    {
        reset($array1);  // fix for version 4.4.1
        if (!empty($array1) AND !is_string(key($array1))) {
            // indexed by row, so use row zero only
            $array1 = $array1[key($array1)];
        } // if

        reset($array2);  // fix for version 4.4.1
        if (!empty($array2) AND !is_string(key($array2))) {
            // indexed by row, so use row zero only
            $array2 = $array2[key($array2)];
        } // if

        foreach ($array2 as $fieldname => $fieldvalue) {
            if (empty($array1[$fieldname]) AND (is_True($allow_null) OR !empty($array2[$fieldname]))) {
                if (isset($fieldspec[$fieldname]['autoinsert']) OR isset($fieldspec[$fieldname]['autoupdate'])) {
                    // ignore this field
                } else {
                    if (is_array($fieldvalue) AND is_array($extra)) {
                        // append $extra before adding to $array1
                        $fieldvalue = array_merge($fieldvalue, $extra);
                    } // if
                    $array1[$fieldname] = $fieldvalue;
                } // if
            } // if
        } // foreach

        return $array1;

    } // array_update_empty
} // if

// ****************************************************************************
if (!function_exists('array_update_indexed')) {
    function array_update_indexed ($fieldarray, $postarray, $fieldspec=array())
    // update contents of $fieldarray from contents of $postarray.
    // Note: this is different from a merge which will add new fields into $fieldarray
    // if they did not previously exist, which is not what I want. This version
    // will not create any items in $fieldarray which did not previously exist.
    {
        $fieldarray_key = key($fieldarray);  // does index start at 0 or 1?

        // transfer values from $postarray to $fieldarray
        // each fieldname in $postarray should be an array of values (but may not be)
        foreach ($postarray as $fieldname => $valuearray) {
            if (isset($fieldspec[$fieldname])) {
                $spec = $fieldspec[$fieldname];
            } else {
                $spec = array();
            } // if
            if (is_array($valuearray)) {
                // copy row value from $postarray to $fieldarray for current $fieldname
                foreach ($valuearray as $rownum => $value) {
                    if (isset($spec['type']) AND preg_match('/(decimal|numeric|float|real|double|integer)/i', $spec['type'])) {
                        $value = number_unformat($value);
                    } // if
                    if ($fieldarray_key == 0) {
                        if (array_key_exists($fieldname, $fieldarray[$rownum-1])) {
                            // $fieldarray starts at 0, $postarray starts at 1
                            $fieldarray[$rownum-1][$fieldname] = $postarray[$fieldname][$rownum];
                        } // if
                    } else {
                        if (array_key_exists($fieldname, $fieldarray[$rownum])) {
                            // $fieldarray starts at 1, $postarray starts at 1
                            $fieldarray[$rownum][$fieldname] = $postarray[$fieldname][$rownum];
                        } // if
                    } // if
                } // foreach
            } else {
                // value is not an array, so insert it into every row
                if (isset($spec['type']) AND preg_match('/(decimal|numeric|float|real|double|integer)/i', $spec['type'])) {
                    $valuearray = number_unformat($valuearray);
                } // if
                foreach ($fieldarray as $rownum => $rowdata) {
                    $fieldarray[$rownum][$fieldname] = $valuearray;
                } // foreach
            } // if
        } // foreach

        return $fieldarray;

    } // array_update_indexed
} // if

// ****************************************************************************
if (!function_exists('array2range')) {
    function array2range ($input)
    // take an array of rows and put the values into an SQL range clause
    // fieldname IN ('value1','value2',...)
    {
        $range = '';
        foreach ($input as $row) {
            if (is_array($row)) {
            	foreach ($row as $value) {
                    if (empty($range)) {
                        $range = "'$value'";
                    } else {
                        $range .= ",'$value'";
                    } // if
                } // foreach
            } else {
                if (empty($range)) {
                    $range = "'$row'";
                } else {
                    $range .= ",'$row'";
                } // if
            } // if
        } // foreach

        return $range;

    } // array2range
} // if

// ****************************************************************************
if (!function_exists('array2rangeUnique')) {
    function array2rangeUnique ($input, &$array_full)
    // take an array of rows and put the values into an SQL range clause
    // fieldname IN ('value1','value2',...)
    // $array_full is an indexed array of all the values found so far, which can
    // be used to check that any new values aren't already there.
    // NOTE: $array_full is passed BY REFERENCE as it may be updated.
    {
        $range = '';
        foreach ($input as $row) {
            if (is_array($row)) {
            	foreach ($row as $value) {
            	    if (in_array($value, $array_full)) {
            	    	// already there, so ignore it
            	    } else {
            	        $array_full[] = $value;
                        if (empty($range)) {
                            $range = "'$value'";
                        } else {
                            $range .= ",'$value'";
                        } // if
            	    } // if
                } // foreach
            } else {
                if (in_array($row, $array_full)) {
        	    	// already there, so ignore it
        	    } else {
        	        $array_full[] = $row;
                    if (empty($range)) {
                        $range = "'$row'";
                    } else {
                        $range .= ",'$row'";
                    } // if
        	    } // if
            } // if
        } // foreach

        return $range;

    } // array2rangeUnique
} // if

// ****************************************************************************
if (!function_exists('array2where')) {
    function array2where ($inputarray, $fieldlist=array(), $dbobject=null, $no_operators=false, $add_table_name=false)
    // turn an array of 'name=value' pairs into an SQL 'where' clause.
    // $fieldlist (optional) may be in format 'n=name' (indexed) or 'name=value'
    // (associative), or even [rownum] string. It is usually a subset of $fieldspec.
    // $dbobject (optional) is the database object which provided $inputarray, to
    // provide unformatting rules and any uppercase/lowercase field specifications.
    // $no_operators (optional) indicates that the values in the input array are NOT to
    // be scanned for operators, thus '>ABC' is to be treated as ='>ABC' not >'ABC'
    // $add_table_name indicates if the table name may need to be added to the output string.
    {
        if (empty($inputarray)) return;

        if (is_object($dbobject)) {
        	$fieldspec   = $dbobject->getFieldSpec();
        	// flip from 'n=name' to 'name=n'
        	$primary_key = array_flip($dbobject->primary_key);
        } else {
            // this may be in same format as $fieldspec
            $fieldspec   = $fieldlist;
            $primary_key = array();
        } // if

        reset($inputarray);  // fix for version 4.4.1
        $key = key($inputarray);
        if (is_long($key)) {
            // indexed array
        	if (is_array($inputarray[$key])) {
        	    // this is an array within an array, so...
        	    if (!is_null($fieldlist)) {
        	    	// to be filtered by $fieldlist, so bring it to the top level
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

        if (is_object($dbobject)) {
            // undo any formatting of data values
        	$inputarray = $dbobject->unFormatData($inputarray);
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

        } else {
            // if $fieldlist is in format 'n=name' change it to 'name=n'
            if (count($fieldlist) > 0 AND !is_string(key($fieldlist))) {
                $fieldlist = array_flip($fieldlist);
            } // if

            if (count($fieldlist) > 1) {
                // sort $input_array in same sequence as $fieldlist
            	$sorted = array();
                foreach ($fieldlist as $fieldname => $value) {
                    if (array_key_exists($fieldname, $inputarray)) {
                    	$sorted[$fieldname] = $inputarray[$fieldname];
                    	unset($inputarray[$fieldname]);
                    } // if
                } // foreach
                if (!empty($inputarray)) {
                    // append the remainder
                	$sorted = array_merge($sorted, $inputarray);
                } // if
                $inputarray = $sorted;
            } // if
        } // if

        $where  = null;
        $prefix = null;
        foreach ($inputarray as $fieldname => $fieldvalue) {
            if (!is_string($fieldname)) {
                $string = trim($fieldvalue);
                // this is not a name, so assume it's a subquery
            	if (preg_match('/^(AND |OR |\) OR \(|\()/i', $string.' ', $regs)) {
            	    if (empty($where) AND $regs[0] != '(') {
            	    	// $where is empty, so do not save prefix
            	    } else {
                	    // save prefix for later
                        $prefix .= ' '.trim(strtoupper(trim($regs[0])));
            	    } // if
            	    // remove prefix from string
            	    $string = trim(substr($string, strlen($regs[0])));
                } // if
                if (!empty($string)) {
                    if ($string == ')') {
                    	$where .= $string;
                    } else {
                        if (!empty($where)) {
                        	if (empty($prefix)) {
                        	    $prefix = ' AND';  // default is 'AND'
                        	} elseif (trim($prefix) == '(') {
                                $prefix = ' AND (';  // default is 'AND'
                            } // if
                        } // if
                        if (substr($prefix, -1, 1) == '(') {
                        	$where .= $prefix.$string;
                        } else {
                            $where .= $prefix .' ' .$string;
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
                if (array_key_exists($fieldname_unq, $fieldlist)) {
                    $type = 'string';  // set to default
                    // does this field exist in $fieldspec?
                    if (is_array($fieldspec) AND array_key_exists($fieldname_unq, $fieldspec)) {
                        $type =& $fieldspec[$fieldname_unq]['type'];
                    	// check fieldspec for upper/lower case
                        if (is_array($fieldspec[$fieldname_unq])) {
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
                    } // if
                    // combine into <name operator value>
                    if ($no_operators === true) {
                    	// the value does not contain an operator, so always use '='
                    	$string = $fieldname ."='" .addslashes($fieldvalue) ."'";

                    } else {
                        // check to see if $value contains an operator or not
                        list($operator, $value, $delimiter) = extractOperatorValue($fieldvalue);
                        if (empty($operator)) {
                            // operator is not present, so assume it is '='
                            //if (is_null($fieldvalue) AND !array_key_exists($fieldname, $primary_key)) {
                            if (strlen($fieldvalue) == 0) {
                            	$string = $fieldname .' IS NULL';
                            } elseif (preg_match('/^\w+[ ]*\(\)$/i', $fieldvalue)) {
                                // value is 'function()', so output as-is
                                $string = $fieldname ."=" .$fieldvalue;
                            } elseif (preg_match('/^\(.*\)$/i', $fieldvalue)) {
                                // value is '(subquery)', so output as-is
                                $string = $fieldname ."=" .$fieldvalue;
                            } else {
                                // assume value is a quoted string, to be escaped
                            	$string = $fieldname ."='" .addslashes($fieldvalue) ."'";
                            } // if

                            // this condition applies to all remaining elements
                            //$no_operators = true;

                        } elseif (preg_match('/^[a-zA-Z_]+/', $operator)) {
                            // operator is alphabetic, so insert space after fieldname
                            $string = $fieldname.' '.ltrim($fieldvalue);

                        } elseif (preg_match('/(&|~|\^|<<|>>|\|)[ ]*[0-9]+/', $operator, $regs)) {
                            // contains bitwise operator, so insert spaces
                            $string = $fieldname.' '.$operator.' '.$value;

                        } elseif (preg_match('/^=/', $operator, $regs)) {
                            //if (is_numeric($value)) {
                            //    $delimiter = null;  // numeric values need not be delimited
                            //    $value = trim($value);
                            //} // if
                            $string = $fieldname.$operator.$delimiter.$value.$delimiter;

                        } elseif (preg_match('/^(<>|<=|<|>=|>)/', $operator, $regs)) {
                            if (is_numeric($value)) {
                                $delimiter = null;  // numeric values need not be delimited
                                $value = trim($value);
                            } // if
                            $string = $fieldname.' '.$operator.' '.$delimiter.$value.$delimiter;

                        } elseif (!array_key_exists($fieldname_unq, $fieldspec)) {
                            // field is not in fieldspec, so use 'as-is'
                            $string = $fieldname.' '.$fieldvalue;

                        } else {
                            if (empty($delimiter)) {
                                if (preg_match('/(int|decimal|numeric|float|double|real)/i', $type)) {
                                	// value is numeric, so value need not be enclosed in quotes
                                	$string = $fieldname.' '.$fieldvalue;
                                } else {
                                    // there is no delimiter, so operator is part of the value
                                    $string = $fieldname ."='" .addslashes($fieldvalue) ."'";
                                } // if
                            } else {
                            	// the operator and value are combined, so use 'as-is'
                            	$string = $fieldname.' '.$fieldvalue;
                            } // if
                        } // if
                    } // if

                    // append to $where string
                    if (empty($where)) {
                        $where .= $string;
                    } else {
                        $where .= ' AND ' .$string;
                    } // if
                } // if
            } // if
        } // foreach

        $where = trim($where);

        if ($add_table_name == true AND is_object($dbobject)) {
            $pkey_names = $dbobject->getPkeyNames();
            //if (count($pkey_names) == 1 AND in_array('id', $pkey_names)) {
            if (in_array('id', $pkey_names)) {
                // primary key is 'id', so include table name in WHERE
                $where_array = where2array($where);
                $where_array['rdc_table_name'] = get_class($dbobject);
                $where = array2where($where_array);
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
        if (empty($where_array)) {
        	return '';
        } elseif (count($where_array) == 1) {
            // this is for a single row
        	$where = $where_array[0];
        } else {
            // this is for mutiple rows, so set to '(row1) OR (row2) OR...'
            $where = '('.implode(') OR (', $where_array).')';
        } // if

        // remove any parenthesised expressions which are now empty
        $patterns[] = "/[ ]+AND[ ]*\([ ]*\)/iu";  // 'AND ()'
        $patterns[] = "/[ ]+OR[ ]*\([ ]*\)/iu";   // 'OR ()'
        $patterns[] = "/[ ]+\([ ]*\)/iu";         // '()'
        $patterns[] = "/^[ ]*AND[ ]+/iu";         // begins with 'AND'
        $patterns[] = "/^[ ]*OR[ ]+/iu";          // begins with 'OR'
        $where = preg_replace($patterns, '', $where);

        return $where;

    } // array2where2
} // if

// ****************************************************************************
if (!function_exists('array2xml')) {
    function array2xml ($array, $xml_doctype=null, $cdata_section_elements=null, $index_attribute=false)
    // convert an array to an XML string, with optional DOCTYPE.
    // $cdata_section_elements identifies elements to be enclosed in '<![CDATA[' and ']]>'
    {
        require_once('radicore.simplexmlelement.inc');

        $root = key($array);
        $xml_str = '<?xml version="1.0" encoding="UTF-8"?>'.$xml_doctype."<$root></$root>";
        try {
            $xml = new radicore_SimpleXMLElement($xml_str);
        } catch (Exception $e) {
            trigger_error($e->getMessage(), E_USER_ERROR);
        } // try

        $GLOBALS['cdata_section_elements'] = null;  // clear current settings
        if (!empty($cdata_section_elements)) {
            $xml->set_cdata_elements($cdata_section_elements);
        } // if
        $xml->set_index_attribute($index_attribute);
        $xml->addArray($xml, $array[$root]); // add all child elements for this root
        $xml_str = $xml->asXML();            // output XML as an unformatted string

        return $xml_str;

    } // array2xml
} // if

// ****************************************************************************
if (!function_exists('build_select_list')) {
    function build_select_list($fieldspec, $exclude=null)
    // build SQL 'select' list from contents of $fieldspec array, but exclude
    // anything in the $exclude array.
    {
        $array = array();

        if (!is_array($exclude)) {
            $exclude = array();
        } // if

        foreach ($fieldspec as $name => $spec) {
            if (!empty($spec['nondb'])) {
                // ignore this entry
            } elseif (in_array($name, $exclude)) {
                // ignore this entry
            } else {
                $array[] = $name;
            } // if
        } // foreach

        $string = implode(', ' , $array);

        return $string;

    } // build_select_list
} // if

// ****************************************************************************
if (!function_exists('calculate_age')) {
    function calculate_age ($dob, $as_at_date=null)
    // calculate age using Date Of Birth and a specified date.
    {
        $birthday = strtotime($dob);
        if ($birthday === false) {
            return '';
        } // if

        $date = date('Y-m-d', $birthday);
        list($dob_yy, $dob_mm, $dob_dd) = explode('-',$date);

        // set comparison date
        if (!empty($as_at_date)) {
            $date = strtotime($as_at_date);
        } else {
            $date = time();  // default is today
        } // if

        $year_diff = '';
        $year_diff = date('Y', $date) - $dob_yy;
        $month_diff = date('m', $date) - $dob_mm;
        $day_diff = date('d', $date) - $dob_dd;
        if ($day_diff < 0 OR $month_diff < 0) $year_diff--;

        return $year_diff;

    } // calculate_age
} // if

// ****************************************************************************
if (!function_exists('check_custom_button')) {
    function check_custom_button ($post)
    // check to see if a CUSTOM button was pressed.
    // (a field which begins with 'button#')
    {
        $button = false;
        // look for 'button#<zone>#name' where '<zone>#' is optional
        $pattern = '/^((?P<prefix>\w+\#)){1}(?P<zone>\w+\#)?/i';
        foreach ($_POST as $postname => $postvalue) {
            if (preg_match('/^(task#|favourite#)/i', $postname, $regs)) {
                // this is a navigation button, so ignore it
                $condition = true;
            } elseif (preg_match($pattern, $postname, $regs)) {
                // strip off the prefix to leave the original field name
                $zone   =& $regs['zone'];
                $button = str_replace($regs['prefix'].$zone, '', $postname);
                $zone   = str_replace('#', '', $zone);
                if (is_array($postvalue)) {
                    $button_row = key($postvalue);
                    return array($button, $button_row, $zone);
                } else {
                    return array($button, false, $zone);
                } // if
            } // if
        } // foreach

        return false;

    } // check_custom_button
} // if

// ****************************************************************************
if (!function_exists('check_memory_limit')) {
    function check_memory_limit ($quiet=false)
    // check memory usage and double it if too close to the limit
    {
        global $stdouth;  // handle for output file

        $mem_limit = return_bytes(ini_get('memory_limit'));
        $mem_curr = memory_get_usage(true);

        if (($mem_curr / $mem_limit)*100 > 90) {
            // greater than 90% used, so double it
            $new_limit = $mem_limit * 2;
            $result = ini_set('memory_limit',$new_limit);
            $output = "<p>MEMORY LIMIT INCREASED FROM $mem_curr TO $new_limit</p>\n";
            if ($quiet) {
                // no output
            } else {
                if (is_resource($stdouth)) {
                    $result = fwrite($stdouth, $output);
                } else {
                    echo $output;
                } // if
            } // if
            return true;
        } // if

        return false;

    } // check_memory_limit
} // if

// ****************************************************************************
if (!function_exists('check_submit_button')) {
    function check_submit_button ($act_buttons, $post)
    // check to see if a SUBMIT button was pressed.
    // $act_buttons is an array of possible buttons.
    // $post is the $_POST array which may contain one of those buttons.
    {
        foreach ($act_buttons as $act_button => $button_name) {
            // button must begin with "submit" (avoiding QUIT, RESET, COPY, PASTE, etc)
            if (preg_match('/^submit/i', $act_button)) {
                if (array_key_exists($act_button, $_POST)) {
                    return $act_button;
                } // if
            } // if
        } // foreach

        return false;

    } // check_submit_button
} // if

// ****************************************************************************
if (!function_exists('check_task_button')) {
    function check_task_button ($post)
    // check to see if a TASK button was pressed.
    // (a field which begins with 'task#' or 'favourite')
    {
        if (isset($post['rdc_selection_lock'])) {
            $_SESSION['selection_lock'] = $post['rdc_selection_lock'];
        } // if

        $button = false;
        foreach ($_POST as $postname => $postvalue) {
            if (preg_match('/^(task#|favourite#)/i', $postname, $regs)) {
                $button = $postname;
                break;
            } // if
        } // foreach

        return $button;

    } // check_task_button
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
if (!function_exists('convert_child_id_to_parent_id')) {
    function convert_child_id_to_parent_id($fieldarray, $tablename, $child_relations)
    // attempt to convert the column name of 'something' to 'id'
    {
        $child_table = $fieldarray['rdc_table_name'];

        if ($child_table == $tablename) {
            // table names are the same, so do nothing
        }  else {
            foreach ($child_relations as $relation) {
                if ($relation['child'] == $child_table) {
                    // matching table name found, look for related field
                    $new_array = array();
                    foreach ($relation['fields'] as $this_column => $child_column) {
                        if (isset($fieldarray[$child_column])) {
                            $new_array[$this_column] = $fieldarray[$child_column];
                        } // if
                    } // foreach
                    if (!empty($new_array)) {
                        $fieldarray = $new_array;
                    } // if
                    break;
                } // if
            } // foreach
        } // if

        return $fieldarray;

    } // convert_child_id_to_parent_id
} // if

// ****************************************************************************
if (!function_exists('convert_index_attribute_to_index_no')) {
    function convert_index_attribute_to_index_no ($input)
    // if ... $input is an array
    // and .. an entry contains an '@attribute'['index']' value
    // then . use this as the entry's index number
    {
        if (is_array($input)) {
            foreach ($input as $name => $value) {
                if (is_array($value)) {
                    if (array_key_exists('@attributes', $value) AND array_key_exists('index', $value['@attributes'])) {
                        // array has a single entry which is not indexed
                        $ix = $value['@attributes']['index'];
                        unset($value['@attributes']);
                        $output[$name][$ix] = $value;
                    } elseif (is_long(key($value))) {
                        // array has multiple entries which are indexed
                        foreach ($value as $ix2 => $value2) {
                            if (is_array($value2) AND array_key_exists('@attributes', $value2) AND array_key_exists('index', $value2['@attributes'])) {
                                $ix = $value2['@attributes']['index'];
                                unset($value2['@attributes']);
                                $output[$name][$ix] = $value2;
                            } else {
                                $output[$name][$ix2] = $value2;
                            } // if
                        } // foreach
                    } else {
                        $output[$name][$ix] = $value;
                    } // if
                } else {
                    $output[$name] = $value;
                } // if
            } // foreach
        } else {
            $output = $input;
        } // if

        return $output;

    } // convert_index_attribute_to_index_no
} // if

// ****************************************************************************
if (!function_exists('convert_parent_id_to_child_id')) {
    function convert_parent_id_to_child_id($fieldarray, $tablename, $parent_relations)
    // attaempt to convert the column name of 'id' to something else
    {
        $parent_table = $fieldarray['rdc_table_name'];

        if (preg_match('/_s[0-9]+$/i', $parent_table, $regs)) {
            // name ends in '_Snn', so remove it
            $suffix = $regs[0];
            $limit = strlen($parent_table) - strlen($suffix);
            $parent_table = substr($parent_table, 0, $limit);
        } // if

        if ($parent_table == $tablename) {
            // table names are the same, so do nothing
        }  else {
            if (isset($fieldarray['id'])) {
                foreach ($parent_relations as $relation) {
                    if ($relation['parent'] == $parent_table) {
                        // matching table name found, look for related field
                        if ($child_name = array_search('id', $relation['fields'])) {
                            $fieldarray[$child_name] = $fieldarray['id'];
                            unset($fieldarray['id']);
                            break;
                        } // if
                    } elseif (isset($relation['alias']) AND $relation['alias'] == $parent_table) {
                        $child_name = array_search('id', $relation['fields']);
                        if (array_key_exists('id', $fieldarray) AND array_key_exists($child_name, $fieldarray)) {
                            // use only the child name and ignore the ID value
                            unset($fieldarray['id']);
                        } // if
                    } // if
                } // foreach
            } // if
            unset($fieldarray['rdc_table_name']);
        } // if

        return $fieldarray;

    } // convert_parent_id_to_child_id
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
                $value = str_replace($currency, '', $value);
                // convert value back into home currency
                $value = round($value / $exchange_rate, 3);
            } else {
                // values displayed in home currency
                $value = str_replace($home_currency, '', $value);
            } // if
        } // if

        return $value;

    } // convertCurrencyInput
} // if

// ****************************************************************************
if (!function_exists('convertEncoding')) {
    function convertEncoding ($string, $to_encoding, $from_encoding=null)
    // convert string from one character encoding to another, if required.
    {
        if ($string) {
            if (function_exists('mb_convert_encoding')) {
                if (empty($from_encoding)) {
                    // not supplied, so find out what it is
                    $from_encoding = mb_detect_encoding($string);
                    //$check         = mb_check_encoding($string, $to_encoding);
                } // if
                if (!empty($from_encoding)) {
                    if (strtoupper($from_encoding) != strtoupper($to_encoding)) {
                        $string = mb_convert_encoding($string, $to_encoding, $from_encoding);
                    } // if
                } // if
            } elseif (function_exists('iconv')) {
                if (empty($from_encoding)) {
                    // not supplied, so find out what it is
                    $from_encoding = ini_get('default_charset');
                } // if
                if (strtoupper($from_encoding) != strtoupper($to_encoding)) {
                    $string = iconv($from_encoding, $to_encoding.'//TRANSLIT', $string);
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
            $datetimeOBJ = new DateTime($datetime, $timezone1);
            $result1 = date_format($datetimeOBJ, "Y-m-d H:i:s e T");
            // switch to output time zone
            try {
                $timezone2 = new DateTimeZone($tz_out);
            } catch (Exception $e) {
                // timezone is invalid somehow, so use input timezone
                // (this only fails with safari browser when using client-side XSL)
                $timezone2 = new DateTimeZone($tz_in);
            } // try

            $datetimeOBJ->setTimezone($timezone2);
            if (isset($_SESSION['user_language']) AND preg_match('/^TH/i', $_SESSION['user_language'])) {
                // alter year for Thai Buddist calendar
                $year = date_format($datetimeOBJ, "Y");
                if ($tz_in == $_SESSION['timezone_server']) {
                    $year += 543;
                } elseif ($tz_out == $_SESSION['timezone_server']) {
                    $year -= 543;
                } // if
                $result = $year.date_format($datetimeOBJ, "-m-d H:i:s");
                return $result;
            } // if
            $result2 = date_format($datetimeOBJ, "Y-m-d H:i:s e T");
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
        if (empty($date)) {
            return $date;  // no conversion possible
        } else {
            $dateobj =& RDCsingleton::getInstance('date_class');
            $date    = $dateobj->getInternalDate($date);
        } // if

        if (empty($tz_in) OR empty($tz_out)) {
            return $date;  // no conversion possible
        } // if

        if ($tz_in == $tz_out) {
            return $date;  // no conversion necessary
        } // if

        if (empty($time)) {
            //$time = date('H:i:s');  // default to current server time
            $time = '00:00:00';
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
        } else {
            $dateobj =& RDCsingleton::getInstance('date_class');
            $date    = $dateobj->getInternalDate($date);
        } // if

        $datetime = "$date $time";

        $datetime = convertTZ($datetime, $tz_in, $tz_out);

        $result = substr($datetime, 11, 8);

        return $result;

    } // convertTZtime
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
            $date = getTimeStamp('date');
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
if (!function_exists('dateDifference')) {
    function dateDifference ($date1, $date2)
    // calculate the difference between two dates in days
    {
        $dateobj =& RDCsingleton::getInstance('date_class');
        $date1 = $dateobj->getInternalDate($date1);
        $date2 = $dateobj->getInternalDate($date2);

        if (version_compare(phpversion(), '5.3.0', '<')) {
            $date1 = $dateobj->getInternalDate($date1);
            $julian1 = GregoriantoJD(substr($date1, 5, 2) , substr($date1, 8, 2) , substr($date1, 0, 4));

            $date2 = $dateobj->getInternalDate($date2);
            $julian2 = GregoriantoJD(substr($date2, 5, 2) , substr($date2, 8, 2) , substr($date2, 0, 4));

            $diff = $julian2-$julian1;
        } else {
            $datetime1 = new DateTime($date1);
            $datetime2 = new DateTime($date2);
            $interval = $datetime1->diff($datetime2);
            $diff = $interval->format('%R%a');
        } // if

        return (int)$diff;

    } // dateDifference
} // if

// ****************************************************************************
if (!function_exists('dateDiff_YYMM')) {
    function dateDiff_YYMM ($date1, $date2)
    // calculate the difference between two dates in years and months
    {
        $dateobj =& RDCsingleton::getInstance('date_class');
        $date1 = $dateobj->getInternalDate($date1);
        $date2 = $dateobj->getInternalDate($date2);

        $datetime1 = new DateTime($date1);
        $datetime2 = new DateTime($date2);
        $interval = $datetime1->diff($datetime2);
        $diff = $interval->format('%yy/%mm');

        return $diff;

    } // dateDiff_YYMM
} // if

// ****************************************************************************
if (!function_exists('display_on_stdout')) {
    function display_on_stdout ($message, $prefix="<p>", $suffix="</p>\n")
    // display message on stdout
    {
        global $stdout, $stdouth;

        $message = $prefix.$message.$suffix;

        if (empty($stdout)) {
            echo $message;
        } else {
            $result = fwrite($stdouth, $message);
        } // if

        return;

    } // display_on_stdout
} // if

// ****************************************************************************
if (!function_exists('errors2string')) {
    function errors2string ($errors, $before=null, $after=null, $recursive=false)
    // convert the $errors array into a string
    {
    	$string = '';

    	if (is_array($errors)) {
    		foreach ($errors as $key => $value) {
    			if (is_array($value)) {
    				$string .= errors2string($value, "{$before}[$key] ", $after, true);
				} elseif (is_int($key)) {
					$string .= $before.$value.$after."\n";
				} else {
					$string .= $before."$key = $value".$after."\n";
    			} // if
    		} // foreach
		} else {
    		$string = $errors;
    	} // if

    	return $string;

	} // errors2string
} // if

// ****************************************************************************
if (!function_exists('extractAliasNames')) {
    function extractAliasNames ($sql_select)
    // extract "expression AS alias" from $sql_select and return an associative array
    // in the format: "alias = expression"
    {
        if (empty($sql_select)) {
        	return array();
        } // if

        // split input string into an array of separate elements
        $select_array = extractSelectList($sql_select);

        $field_array = array();

        foreach ($select_array as $element) {
            // find out if this entry uses an alias
            list($expression, $alias) = getFieldAlias3($element);
            if ($expression != $alias) {
            	$field_array[$alias] = $expression;
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
            if (isset($field_array[$alias])) {
            	unset($field_array[$alias]);  // remove duplicate from its original position
            } // if
            $field_array[$alias] = $original;
        } // foreach

        return $field_array;

    } // extractFieldNamesAssoc
} // if

// ****************************************************************************
if (!function_exists('extractNamedFields')) {
    function extractNamedFields ($fieldarray, $old_name, $new_name=null)
    // iterate through $fieldarray looking for fields with $old_name, and return them.
    // if $new_name is defined then use this instead of $old_name
    {
        $output = array();

        foreach ($fieldarray as $name => $value) {
            if (preg_match("/$old_name/i", $name, $regs)) {
                if (!empty($new_name)) {
                    $name = str_replace($regs[0], $new_name, $name);
                } // if
                $output[$name] = $value;
            } // if
        } // foreach

        return $output;

    } // extractNamedFields
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
    // split string such as "='value'" or "=value" into "=" and "value"
    {
        $pattern1 = <<< END_OF_REGEX
/
^                            # begins with
(                       # start choice
 [ ]*                   # 0 or more spaces
 (&|~|\^|<<|>>|\|)      # bitwise operators
 [ ]*                   # 0 or more spaces
 [0-9]+                 # 1 or more digits
 [ ]*                   # 0 or more spaces
)?                      # end choice, 0 or 1 times
(                            # start choice
 <>|<=|<|>=|>|!=|=           # comparison operators
 |                           # or
 (NOT[ ]+)?(I|R)?LIKE[ ]+    # [NOT] [I|R]LIKE
 |                           # or
 (NOT[ ]+)?REGEXP[ ]+        # [NOT] REGEXP
 |                           # or
 IS[ ]+NOT[ ]+               # IS NOT
 |                           # or
 IS[ ]+                      # IS
 |                           # or
 (NOT[ ]+)?IN[ ]*(?=\()      # '[NOT] IN(' but without the '('
 |                           # or
 IN[^a-zA-Z0-9 _-]           # 'IN' not followed by an alphanumeric character, space, underscore or dash
 |                           # or
 (NOT[ ]+)?BETWEEN[ ]+       # [NOT] BETWEEN
 |                           # or
 (-|\+)                      # '-' or '+'
 [ ]*                        # 0 or more spaces
 (\w+(\.\w+)?[ ]*)+          # word [.word] 1 or more times
 (<>|<=|<|>=|>|!=|=)         # comparison operators
)                            # end choice
/xi
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^                            # begins with
[ ]*                         # any spaces
(                            # start choice
  \w+[ ]*\(\)                # word()
|                            # or
  \w+[ ]*\(.+?\)             # word(...)
|                            # or
  \w+(\.\w+)?$               # word[.word] with nothing after
|                            # or
  \([ ]*\w+                  # (word ..)
)                            # end choice
/xi
END_OF_REGEX;

        $input = ltrim($input);
        if (preg_match($pattern1, $input, $regs)) {
            $operator = $regs[0];
            // split operator from value
            $value = substr($input, strlen($operator));
            //$value = trim($value);

            if (preg_match('/\bbetween\b/i', $operator)) {
                // this has two values, so do not strip leading and trailing delimiters
            	$delimiter = null;
            } else {
                // the first  non-blank character is the delimiter (single or double quote)
                preg_match('/[^ ]/', $value, $regs);
                $delimiter = $regs[0];
            } // if
            if ($delimiter == '"' or $delimiter == "'") {
                // delimiter found, so remove from both ends of string
                $value = trim($value);
                $value = substr($value, 1);
                $value = substr($value, 0, -1);
            } else {
            	// no delimiter found
                $delimiter = null;
                if (preg_match('/^(<>|<=|<|>=|>|!=|=)/', $operator)) {
                    // these are operators only on numeric values
                    if (preg_match($pattern2, $value)) {
                        // contains 'word(...)' so leave operator
                        $value = trim($value);
                    } elseif (!is_numeric($value)) {
                        // not numeric, so should be part of the string value
                        $value = $operator.$value;
                        $operator = null;
                    } // if
                } // if
            } // if

            return array(trim($operator), $value, $delimiter);
        } // if

        return array(null, $input, null);

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
        	    $string .= $element;
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
        if (preg_match('/^\)[ ]*AND[ ]*\(/i', $where, $regs)) {
            $array[] = ') AND (';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^AND[ ]*[\(]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^AND[ ]+/i', $where, $regs)) {
            $array[] = 'AND';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^\)[ ]*OR[ ]*\(/i', $where, $regs)) {
            $array[] = ') OR (';
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^OR[ ]*[\(]+/i', $where, $regs)) {
            $array[] = $regs[0];
            $where = substr($where, strlen($regs[0]));
            $where = extractSeparator($where, $array);  // recursive
        } elseif (preg_match('/^OR[ ]+/i', $where, $regs)) {
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
                 . '"\w+"\.dbo\.\w+[ ]+AS[ ]+\w+'   // "db".dbo.table AS alias
                 . '|'                         // or
                 . '"\w+"\.\w+[ ]+AS[ ]+\w+'   // "db".table AS alias
                 . '|'                         // or
                 . '\w+\.\w+[ ]+AS[ ]+\w+'     // db.table AS alias
                 . '|'                         // or
                 . '"\w+"\.dbo\.\w+'           // "db".dbo.table
                 . '|'                         // or
                 . '"\w+"\.\w+'                // "db".table
                 . '|'                         // or
                 . '\w+\.\w+'                  // db.table
                 . '|'                         // or
                 . '\w+[ ]+AS[ ]+\w+'          // table AS alias
                 . '|'                         // or
                 . '\w+'                       // table
                 . '/is';                      // end delimiter, case insensitive, include newlines
        $count = preg_match($pattern, $sql_from, $regs);
        $tablename = $regs[0];
        if (substr_count($tablename, '.') == 1) {
            // remove 'dbname' from 'dbname.tablename'
        	list($dbname, $tablename) = explode('.', $tablename);
        } elseif (substr_count($tablename, '.') == 2) {
            // remove 'dbname.dbo' from 'dbname.dbo.tablename'
            list($dbname, $dbo, $tablename) = explode('.', $tablename);
        } // if
        list($original, $alias) = getTableAlias3($tablename);
        if (!empty($original)) {
        	$table_array[$alias]     = $original;
        } else {
            $table_array[$tablename] = $tablename;
        } // if

        // additional table names follow the word 'JOIN'
        $pattern = '/'                                        // start delimiter
                 . '(?<= join )[ ]*"\w+"\.dbo\.\w+[ ]+AS[ ]+\w+'   // JOIN "db".dbo.table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*"\w+"\.\w+[ ]+AS[ ]+\w+'   // JOIN "db".table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+\.\w+[ ]+AS[ ]+\w+'     // JOIN db.table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*"\w+"\.dbo\.\w+'                // JOIN "db".dbo.table
                 . '|'                                        // or
                 . '(?<= join )[ ]*"\w+"\.\w+'                // JOIN "db".table
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+\.\w+'                  // JOIN db.table
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+[ ]+AS[ ]+\w+'          // JOIN table AS alias
                 . '|'                                        // or
                 . '(?<= join )[ ]*\w+'                       // JOIN table
                 . '/is';                                      // end delimiter, case insensitive, include newlines

        if ($count = preg_match_all($pattern, $sql_from, $regs)) {
        	// examine extra table names which follow a JOIN
            foreach ($regs[0] as $tablename) {
                if (substr_count($tablename, '.') == 1) {
                    // remove 'dbname' from 'dbname.tablename'
                    list($dbname, $tablename) = explode('.', $tablename);
                } elseif (substr_count($tablename, '.') == 2) {
                    // remove 'dbname.dbo' from 'dbname.dbo.tablename'
                    list($dbname, $dbo, $tablename) = explode('.', $tablename);
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
            $screen_fields = getFieldsInScreen($screen_structure, $zone);
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

        // anything left in $array_in must be moved back into $errors
        foreach ($array_in as $key => $value) {
        	$errors[$key] = $value;
        } // foreach

        return $array_out;

    } // filterErrors
} // if

// ****************************************************************************
if (!function_exists('filterOrderBy')) {
    function filterOrderBy ($orderby, $fieldlist, $tablename=null)
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
    function filterWhere ($where, $fieldlist, $tablename, $extra=array(), $object=null)
    // filter out any fields in $where which do not belong in this table,
    // (valid fields are identified in the $fieldlist array, with other
    // fields identified in the $extra array).
    {
        // if input string is empty there is nothing to do
        if (empty($where)) return;

        // if $tablename is empty there is nothing to do
        if (empty($tablename)) return $where;

        reset($fieldlist);  // fix for version 4.4.1
        if (!is_string(key($fieldlist))) {
            // flip indexed array so that the values become keys
            $fieldlist = array_flip($fieldlist);
        } // if

        if (is_array($extra) AND !empty($extra)) {
            if (!is_string(key($extra))) {
                // flip indexed array so that the values become keys
                $extra = array_flip($extra);
            } // if
            // append extra names to $fieldlist
        	$fieldlist = array_merge($fieldlist, $extra);
        } // if

        $fieldlist = array_change_key_case($fieldlist, CASE_LOWER);

        // convert from string to indexed array
        $array1 = where2indexedArray($where);

        if ($array1[key($array1)] == '(' AND end($array1) == ')') {
        	// array begins with '(' and ends with ')', but does it have right number of 'OR's?
        	$count = array_count_values($array1);
            if ($count['('] == $count[')'] AND $count['OR'] == $count['(']-1) {
                // set $array2 to hold multiple rows
            	$array2 = splitWhereByRow($array1);
            } else {
                // set $array2 to hold a single row
                $array2[] = $where;
            } // if
            unset($count);
        } else {
            // set $array2 to hold a single row
            $array2[] = $where;
        } // if

        $pattern1 = <<< END_OF_REGEX
/
^
(                            # start choice
 NOT[ ]+[a-zA-Z_]+           # 'NOT <something>'
 |                           # or
 [a-zA-Z_]+                  # '<something>'
)                            # end choice
[ ]*                         # 0 or more spaces
\(                           # begins with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # any characters
 )                           # end choice
\)                           # end with ')'
/xis
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^
\([^\(\)]*\)                 # '(...)'
[ ]*                         # 0 or more spaces
(<>|<=|<|>=|>|!=|=|IN)       # comparison operators
[ ]*                         # 0 or more spaces
(ANY|ALL|SOME)?              # 'ANY' or 'ALL' or 'SOME' (0 or 1 times)
[ ]*                         # 0 or more spaces
\(                           # starts with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # anything else
 )                           # end choice
 +                           # 1 or more times
 \)                          # end with ')'
/xis
END_OF_REGEX;

        $pattern3 = <<< END_OF_REGEX
/
^
\(SELECT [^\(\)]* .*\)         # '(SELECT ...)'
[ ]*                           # 0 or more spaces
(<>|<=|<|>=|>|!=|=)            # comparison operators
[ ]*                           # 0 or more spaces
(                              # start choice
 '(([^\\\']*(\\\.)?)*)'        # quoted string
 |                             # or
 [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
)                              # end choice
/xis
END_OF_REGEX;

        $pattern4 = <<< END_OF_REGEX
/
^
(?P<bitwise>           # start named pattern
[ ]*                   # 0 or more spaces
(&|~|\^|<<|>>|\|)      # bitwise operators
[ ]*                   # 0 or more spaces
[0-9]+                 # 1 or more digits
[ ]*                   # 0 or more spaces
)                      # end named pattern
(                      # start choice
<>|<=|<|>=|>|!=|=      # comparison operators
){1}                   # end choice, occurs once
/xis
END_OF_REGEX;

        $array_out = array();
        foreach ($array2 as $rownum => $rowdata) {
            // look for 'rdc_table_name' and change name of 'id' column if necessary
            $arrayX = where2array($rowdata);
            $arrayX = array_change_key_case($arrayX, CASE_LOWER);
            if (!empty($arrayX['rdc_table_name'])) {
                if ($arrayX['rdc_table_name'] == $tablename AND is_object($object)) {
                    // names are the same, so lose redundant reference
                    unset($arrayX['rdc_table_name']);
                    $rowdata = array2where($arrayX);
                } else {
                    // convert 'id' from parent name to 'other_id' on this table
                    $arrayX = convert_parent_id_to_child_id($arrayX, $tablename, $object->parent_relations);
                    if (!isset($arrayX['rdc_table_name'])) {
                        $object->checkPrimaryKey = false;
                    } else {
                        $arrayX = convert_child_id_to_parent_id($arrayX, $tablename, $object->child_relations);
                    } // if
                    $rowdata = array2where($arrayX);
                } // if
            } // if
            // split array into its component parts
            $array3 = where2indexedArray($rowdata);
            $prev_separator = null;
            $array4 = array();
            foreach ($array3 as $ix => $string) {
                $string = trim($string);
                if (preg_match('/^(AND|OR)$/i', $string, $regs)) {
                    if (end($array4) == '(') {
                        // cannot use 'AND' or 'OR' immediately after a '('
                    	$prev_separator = null;
                    } else {
                        // store this as it may be used later
                    	$prev_separator = ' '.strtoupper(trim($regs[0])).' ';
                    } // if

                } elseif ($string == '(') {
                    if (!empty($prev_separator) AND !empty($array4)) {
                    	// insert this separator before this '('
                	    $array4[] = $prev_separator;
                    } // if
                    $prev_separator = null;  // this is no longer required
                    $array4[] = $string;

                } elseif ($string == ')') {
                    if (end($array4) == '(') {
                    	// nothing since opening parenthesis, so this is redundant
                    	$null = array_pop($array4);
                    } else {
                        $array4[] = $string;
                    } // if

                } elseif (preg_match($pattern1, $string)) {
                    // format is: 'func(...)', so do not filter out
                    if (!empty($prev_separator)) {
                        if (!empty($array4)) {
                        	// this array has other entries, so output the separator as well
                    		$array4[] = $prev_separator;
                        } // if
                		$prev_separator = null;
                	} // if
                	$array4[] = $string;

                } elseif (preg_match($pattern2, $string)) {
                    // format is: '(col1,col2)=(...)', so do not filter out
                    if (!empty($prev_separator)) {
                	    if (!empty($array4)) {
                        	// this exists, so output it as well
                    		$array4[] = $prev_separator;
                        } // if
                		$prev_separator = null;
                	} // if
                	$array4[] = $string;

                } elseif (preg_match($pattern3, $string)) {
                    // format: '(SELECT ...) = <something>', so do not filter out
                    if (!empty($prev_separator)) {
                	    if (!empty($array4)) {
                        	// this exists, so output it as well
                    		$array4[] = $prev_separator;
                        } // if
                		$prev_separator = null;
                	} // if
                	$array4[] = $string;

                } elseif (preg_match('/^\(/', $string)) {
                    // begins with '(', so do not filter out
                    if (!empty($prev_separator)) {
                	    if (!empty($array4)) {
                        	// this exists, so output it as well
                    		$array4[] = $prev_separator;
                        } // if
                		$prev_separator = null;
                	} // if
                	$array4[] = $string;

                } else {
            	    // split element into its component parts
            		list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
            		$fieldname = strtolower($fieldname);
                    // if $fieldname is qualified with current $tablename, then unqualify it
                    $qualified = false;
                	$namearray = explode('.', $fieldname);
                	if (count($namearray) > 1) {
                	    if ($namearray[0] == $tablename) {
                	    	$fieldname = $namearray[1];
                	    	$qualified = true;
                	    } // if
                    } // if
                    // check if $fieldname exists in $fieldlist array or $extra array.
                    // (if it contains multiple words then assume it's an expression)
                    if (preg_match('/\w+ \w+/', $fieldname)
                    OR (array_key_exists($fieldname, $fieldlist) AND !isset($fieldlist[$fieldname]['nondb']))) {
                        // field is valid, so copy to output array
                        if (!empty($prev_separator) AND !empty($array4)) {
                    	    // insert this separator before the field value
                    	    $array4[] = $prev_separator;
                    	    $prev_separator = null;
                        } // if
                        if (preg_match($pattern4, $operator, $regs)) {
                            $bitwise = $regs['bitwise'];
                            $operator = ' '.$operator;  // insert leading space
                        } // if
                        $operator = trim($operator);
                        if (!preg_match('/^[ ]*=[ ]*$/', $operator)) {
                            $operator = ' '.$operator.' ';  // not '=', so put spaces either side
                        } // if
                        if ($qualified === true) {
                        	$array4[] = "{$namearray[0]}.{$fieldname}{$operator}{$fieldvalue}";
                        } else {
                            $array4[] = "{$fieldname}{$operator}{$fieldvalue}";
                        } // if
                    } else {
                        // field is not valid, so previous separator is not required
                        $prev_separator = null;
                    } // if
                } // if
            } // foreach
            if (preg_match('/^( AND | OR )$/i', end($array4))) {
            	// cannot end with a separator, so remove it
            	$null = array_pop($array4);
            } // if
            if (empty($array4)) {
            	return '';
            } else {
                $array_out[] = implode($array4);
            } // if
        } // foreach

        $where_out = array2where2($array_out);

        return trim($where_out);

    } // filterWhere
} // if

// ****************************************************************************
if (!function_exists('filterWhere1Where2')) {
    function filterWhere1Where2 ($where1, $where2, $tablename=null)
    // remove entries from $where2 that already exist in $where1
    {
        if (strlen($where1) == 0) {
            return $where2;
        } elseif (strlen($where2) == 0) {
            return $where1;
        } // if

        // convert both input strings to arrays
        $array1 = where2array($where1, false, false);   // this will be untouched
        $array2 = where2indexedArray($where2);          // this may be modified

        $pattern1 = <<< END_OF_REGEX
/
^
(                            # start choice
 NOT[ ]+[a-zA-Z_]+           # 'NOT <something>'
 |                           # or
 [a-zA-Z_]+                  # '<something>'
)                            # end choice
[ ]*                         # 0 or more spaces
\(                           # begins with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # any characters
 )                           # end choice
\)                           # end with ')'
/xis
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^
\([^\(\)]*\)                 # '(...)'
[ ]*                         # 0 or more spaces
(<>|<=|<|>=|>|!=|=|IN)       # comparison operators
[ ]*                         # 0 or more spaces
(ANY|ALL|SOME)?              # 'ANY' or 'ALL' or 'SOME' (0 or 1 times)
[ ]*                         # 0 or more spaces
\(                           # starts with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # anything else
 )                           # end choice
 +                           # 1 or more times
 \)                          # end with ')'
/xis
END_OF_REGEX;

        $pattern3 = <<< END_OF_REGEX
/
^
\(SELECT [^\(\)]* .*\)         # '(SELECT ...)'
[ ]*                           # 0 or more spaces
(<>|<=|<|>=|>|!=|=)            # comparison operators
[ ]*                           # 0 or more spaces
(                              # start choice
 '(([^\\\']*(\\\.)?)*)'        # quoted string




 |                             # or
 [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
)                              # end choice
/xis
END_OF_REGEX;

        $array4         = array();
        $prev_separator = null;
        foreach ($array2 as $ix => $string) {
            $string = trim($string);
            if (preg_match('/^(AND|OR)$/i', $string, $regs)) {
                if (end($array4) == '(') {
                    // cannot use 'AND' or 'OR' immediately after a '('
                	$prev_separator = null;
                } else {
                    // store this as it may be used later
                	$prev_separator = ' '.strtoupper(trim($regs[0])).' ';
                } // if

            } elseif ($string == '(') {
                if (!empty($prev_separator) AND !empty($array4)) {
                	// insert this separator before this '('
            	    $array4[] = $prev_separator;
                } // if
                $prev_separator = null;  // this is no longer required
                $array4[] = $string;

            } elseif ($string == ')') {
                $array4[] = $string;

            } elseif (preg_match($pattern1, $string)) {
                // format is: 'func(...)', so copy across untouched
                if (!empty($prev_separator)) {
            	    // this exists, so output it as well
            		$array4[] = $prev_separator;
            		$prev_separator = null;
            	} // if
            	$array4[] = $string;

            } elseif (preg_match($pattern2, $string)) {
                // format is: '(col1,col2)=(...)', so copy across untouched
                if (!empty($prev_separator)) {
            	    // this exists, so output it as well
            		$array4[] = $prev_separator;
            		$prev_separator = null;
            	} // if
            	$array4[] = $string;

            } elseif (preg_match($pattern3, $string)) {
                // format: '(SELECT ...) = <something>', so copy across untouched
                if (!empty($prev_separator)) {
            	    // this exists, so output it as well
            		$array4[] = $prev_separator;
            		$prev_separator = null;
            	} // if
            	$array4[] = $string;

            } else {
                // split element into its component parts
                list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
                // if $fieldname is qualified with current $tablename, then unqualify it
                $fieldname_unq = $fieldname;
            	$namearray = explode('.', $fieldname);
            	if (count($namearray) > 1) {
            	    if ($namearray[0] == $tablename) {
            	    	$fieldname_unq = $namearray[1];
            	    } // if
                } // if
                $ignore = false;
                // does this fieldname exist in $array1?
                if (array_key_exists($fieldname, $array1)) {
                	// does it have the same expression?
                	$expression = ltrim($operator).$fieldvalue;
                    if ($expression == $array1[$fieldname]) {
                        $ignore = true;
                    } // if
                } elseif (array_key_exists($fieldname_unq, $array1)) {
                	// does it have the same expression?
                	$expression = ltrim($operator).$fieldvalue;
                    if ($expression == $array1[$fieldname_unq]) {
                        $ignore = true;
                    } // if
                } // if
                if (!$ignore) {
                    // this entry is not to be ignored, so add to output array
                    if (!empty($prev_separator)) {
                    	$array4[] = $prev_separator;
                    } // if
                    $operator = trim($operator);
                    if (!preg_match('/^[ ]*=[ ]*$/', $operator)) {
                        $operator = ' '.$operator.' ';  // not '=', so put spaces either side
                    } // if
                	$array4[] = "{$fieldname}{$operator}{$fieldvalue}";
                } // if
                $prev_separator = null;
            } // if
        } // foreach

        if (empty($array4)) {
        	$where2 = null;
        } else {
            // convert $array_out back into a string
            $array5[] = implode('', $array4);
            $where2  = array2where2($array5);
        } // if

        return $where2;

    } // filterWhere1Where2
} // if

// ****************************************************************************
if (!function_exists('findClosingEnd')) {
    function findClosingEnd(&$string)
    // an expression starts with 'CASE', so look for the closing 'END',
    // but ignore any nested 'CASE ... END)'.
    {


        $pattern3b = <<< END_OF_REGEX
/
.*?
(?P<keyword>\bCASE\b|\bEND\b)       # 'CASE' or 'END'
/xis
END_OF_REGEX;

        $fieldvalue = '';
		$count = 1;  // 1st CASE has already been found, so start count at 1
		while ($count > 0) {
			if ($result = preg_match($pattern3b, $string, $regs)) {
                $fieldvalue = rtrim($fieldvalue);
                $fieldvalue .= $regs[0];  // append to current value
                if (preg_match('/case/i', $regs['keyword'])) {
                    $count++;  // nested CASE found
                } else {
                    $count--;  // END found
                } // if
            } else {
                trigger_error("Cannot find matching END in: '$string'", E_USER_ERROR);
			} // if
			$string = substr($string, strlen($regs[0]));   // remove value from string
			if (strlen($string) == 0 AND $count > 0) {
				$count = 0;  // nothing left to extract, so force exit
			} // if
		} // while

        return $fieldvalue;

    } // findClosingEnd
} // if

// ****************************************************************************
if (!function_exists('findClosingParenthesis')) {
    function findClosingParenthesis(&$string, $found='(')
    // an expression starts with '(', so look for the closing ')', but ignore
    // any nested '(...)', or ')' inside quoted strings.
    // NOTE: $found may contain more than one '(', so look for same number of ')'
    {
        $lookup = str_replace('(', ')', $found);  // look for closing braces

        $pattern3b = <<< END_OF_REGEX
/
^                        # starts with
(                        # start choice
  (?<function>             # start pattern
   (
   \([ ]*\*[ ]*\)          # (*)
   |                       # or
   \([ ]*\w+(\.\w+)?[ ]*\) # (word[.word])
   )
)                        # end pattern
|                        # or
  (                      # start choice
  [^\(\)']+              # anything except '(', ')' and single quote
  '(([^\\\']*(\\\.)?)*)' # quoted string
  )+                     # 1 or more times
  [^\(\)']*              # anything except '(', ')' and single quote
|                        # or
  [^\(\)']+              # anything except '(', ')' and single quote
|                        # or
  ('(([^\\\']*(\\\.)?)*)'[ ]*(,)?[ ]*)+  # quoted string [, ] one or more times
|                        # or
  [\(\)]+                # '(' or ')' one or more
)                        # end choice
/xis
END_OF_REGEX;

        $fieldvalue = '';
        //$count = 1;  // 1st opening brace has already been found, so start count at 1
        $count = strlen($lookup);  // set to count of opening braces
        while ($count > 0) {
            if ($result = preg_match($pattern3b, $string, $regs)) {
                $string = substr($string, strlen($regs[0]));   // remove value from string
                $found = trim($regs[0]);
                if (!empty($regs['function'])) {
                    $found = str_replace(' ', '', $found);  // strip spaces
                } elseif (substr($found, 0, 1) == ')') {
                    // closing brace(s) found
                    $count = $count - strlen($found); // increment count
                } elseif (substr($found, 0, 1) == '(') {
                    // opening brace(s) found
                    $count = $count + strlen($found); // increment count
                } // if
                if (!empty($fieldvalue)) {
                    $fieldvalue = rtrim($fieldvalue);
                    if (!empty($regs['function'])) {
                        // do nothing
                    } elseif (preg_match('/\w+$/', $fieldvalue)) {
                        if (preg_match('/\b(AND|OR|WHEN|THEN|ELSE|ON|IN)$/i', $fieldvalue)) {
                            $fieldvalue .= ' ';  // insert space before next word
                        } else {
                            // do nothing
                        } // if
                    } elseif (substr($fieldvalue, -1, 1) != '(' AND substr($found, 0, 1) != ')') {
                        $fieldvalue .= ' ';  // insert space before next word
                    } // if
                } // if
                $fieldvalue .= $found;  // append to current value
            } else {
                trigger_error("Cannot extract token from: '$string'", E_USER_ERROR);
            } // if
            if (strlen($string) == 0 AND $count > 0) {
                $count = 0;  // nothing left to extract, so force exit
            } // if
        } // while

        return $fieldvalue;

    } // findClosingParenthesis
} // if

// ****************************************************************************
if (!function_exists('findDBConfig')) {
    function findDBConfig($dbname)
    // find out if the configuration of the database for this table has changed.
    // It may have been given a prefix, or switched to another name.
    {
        $switch_dbnames = array();
        $dbschema       = null;

        if (empty($GLOBALS['servers'])) {
            // use same settings for all databases
            $dbengine =& $GLOBALS['dbms'];
            $dbprefix =& $GLOBALS['dbprefix'];
            if (!empty($GLOBALS['switch_dbnames']) AND is_array($GLOBALS['switch_dbnames'])) {
                $switch_dbnames = array_merge($switch_dbnames, $GLOBALS['switch_dbnames']);
            } // if
            if ($dbengine == 'sqlsrv') {
                $dbschema = $GLOBALS['SQLSRV_schema'];
            } // if
        } else {
            // different settings for each entry in $servers array
            foreach ($GLOBALS['servers'] as $server) {
                if ($server['dbnames'] == '*') {
                    // any dbname not previously specified
                    $dbengine =& $server['dbengine'];
                    $dbprefix =& $server['dbprefix'];
                    if (!empty($server['switch_dbnames']) AND is_array($server['switch_dbnames'])) {
                        $switch_dbnames = array_merge($switch_dbnames, $server['switch_dbnames']);
                    } // if
                    if ($dbengine == 'sqlsrv') {
                        $dbschema = $server['SQLSRV_schema'];
                    } // if
                    break;
                } else {
                    // convert list of dbnames into an array
                    $dbname_array = explode(',', $server['dbnames']);
                    $dbname_array = array_map('trim', $dbname_array);
                    if (in_array($dbname, $dbname_array)) {
                        $dbengine = $server['dbengine'];
                        $dbprefix = $server['dbprefix'];
                        if (!empty($server['switch_dbnames']) AND is_array($server['switch_dbnames'])) {
                            $switch_dbnames = array_merge($switch_dbnames, $server['switch_dbnames']);
                        } // if
                        if ($dbengine == 'sqlsrv') {
                            $dbschema = $server['SQLSRV_schema'];
                        } // if
                        break;
                    } // if
                } // if
            } // foreach
        } // if

        if (!empty($switch_dbnames)) {
            if (array_key_exists($dbname, $switch_dbnames)) {
                // dbname in the data dictionary is different from the name on the server
                $dbname = $switch_dbnames[$dbname];
            } // if
        } // if

        return array($dbname, $dbprefix, $dbengine, $dbschema);

    } // findDBConfig
} // if

// ****************************************************************************
if (!function_exists('findDBName')) {
    function findDBName ($target_db, $this_db=null)
    // find the correct name for this database in the current server.
    // $databasename = the name as it is known by in the Data Dictionary.
    // The name may be changed in the CONFIG.INC file either:
    // a) by using the 'switch_dbnames' option, or
    // b) by using the 'dbprefix' option.
    {
        // check if the name has been prefixed or switched in the config file.
        list($target_db_new, $target_dbprefix, $target_dbms_engine, $target_dbschema) = findDBConfig($target_db);
        $target_db_new = $target_dbprefix.$target_db_new;

        if (empty($this_db)) {
            // cannot compare with $this_db, so output qualified name
            $output = '"'.$target_db_new.'".';
        } else {
            // check if the name has been prefixed or switched in the config file.
            list($this_db_new, $this_dbprefix, $this_dbms_engine, $target_dbschema) = findDBConfig($this_db);
            $this_db_new = $this_dbprefix.$this_db_new;
            if ($target_db_new == $this_db_new) {
                // target dbname is the same, so does not need to be specified
                $output = '';
            } else {
                // target dbname needs to be specified and enclosed in double quotes
                $output = '"'.$target_db_new.'".';
            } // if
        } // if

        if (!empty($target_dbschema)) {
            $output .= $target_dbschema.'.';  // this is for SQL Server
        } // if

        return $output;

    } // findDBName
} // if

// ****************************************************************************
if (!function_exists('findDBPrefix')) {
    function findDBPrefix($dbname)
    // find the prefix which is to be used with this database name.
    {
        if (!empty($GLOBALS['servers'])) {
    	    foreach ($GLOBALS['servers'] as $server) {
    	        if ($server['dbnames'] == '*') {
    	            // any dbname not previously specified
    	        	$dbprefix = $server['dbprefix'];
    	        	break;
    	        } else {
    	            // convert list of dbnames into an array
    	            $dbname_array = explode(',', $server['dbnames']);
                    $dbname_array = array_map('trim', $dbname_array);
                    if (in_array($dbname, $dbname_array)) {
                    	$dbprefix = $server['dbprefix'];
    	        	    break;
                    } // if
    	        } // if
    	    } // foreach
        } // if

        if (!isset($dbprefix)) {
            if (!empty($GLOBALS['dbprefix'])) {
                $dbprefix =& $GLOBALS['dbprefix'];  // default to global setting
            } else {
                $dbprefix = '';                     // no setting defined
            } // if
        } // if

        return $dbprefix;

    } // findDBPrefix
} // if

// ****************************************************************************
if (!function_exists('fixTrueFalseArray')) {
    function fixTrueFalseArray($lookup, $spec)
    // update the $lookup array so that the keys 'true' and 'false' are changed
    // to the values for $spec['true'] and $spec['false'].
    // For example, the input array of: 'true' => 'Yes', 'false' => 'No'
    // could be changed to:             'Y'    => 'Yes', 'N'     => 'No'
    //                  or:             '1'    => 'Yes', '0'     => 'No'
    {
        $true  =& $spec['true'];
        $false =& $spec['false'];

        if (!is_array($lookup)) {
            $lookup = array();
        } // if

        if (strlen($true) > 0) {
        	if (!array_key_exists($true, $lookup)) {
                if (!empty($lookup['true'])) {
                    $value = $lookup['true'];
                    unset($lookup['true']);
                } else {
                    $value = $true;
                } // if
            	$lookup[$true] = $value;
            } // if
        } // if

        if (strlen($false) > 0) {
            if (!array_key_exists($false, $lookup)) {
                if (!empty($lookup['false'])) {
                    $value = $lookup['false'];
                    unset($lookup['false']);
                } else {
                    $value = $false;
                } // if
            	$lookup[$false] = $value;
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

        if (is_True($string) AND !is_null($true)) {
        	$string = $true;
        } elseif (!is_null($false)) {
            $string = $false;
        } // if

        return $string;

    } // fixTrueFalseString
} // if

// ****************************************************************************
if (!function_exists('format_array')) {
    function format_array ($input, $prefix=null)
    // an alternative to print_r()
    {
        $output = '';

        if (is_string($input)) {
        	$output .= $input;
            if (!empty($prefix)) {
                $output = $prefix.' '.$output;
            } // if
        } elseif (is_bool($input)) {
            if ($input) {
            	$output .=  'True';
            } else {
                $output .=  'False';
            } // if
            if (!empty($prefix)) {
                $output = $prefix.' '.$output;
            } // if
        } elseif (is_array($input) OR is_object($input)) {
            foreach ($input as $key => $value) {
                if ($value === $input) {
                    break;  // this is a reference back to itself, so ignore it
                } // if
                if (is_object($value)) {
                	$value = object2array($value);
                } // if
            	if (is_array($value)) {
            		$output .=  format_array($value, $prefix.'['.$key.']');
            		$output .=  '<br>';
            	} else {
            	    if (empty($prefix)) {
            	    	$output .=               $key .' = ' .$value .'<br>';
            	    } else {
            	        $output .= $prefix .' ' .$key .' = ' .$value .'<br>';
            	    } // if
            	} // if
            } // foreach
        } else {
            $output .= $input;
            if (!empty($prefix)) {
                $output = $prefix.' '.$output;
            } // if
        } // if

        return $output;

    } // format_array
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
        if (strlen($input) == 0) return;

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
if (!function_exists('fullGroupBy')) {
    function fullGroupBy ($groupby, $select)
    // ensure that GROUP BY clause contains every column in the SELECT list.
    // (this is required by some database engines)
    {
        $group_array = explode(',', $groupby);
        $group_array = array_map("trim", $group_array);

        // turn select string into an associative array of 'name=alias' pairs
        $select_array = extractFieldNamesAssoc($select);

        // append to $group_array anything in $select_array which is not already there
        foreach ($select_array as $fieldname => $alias) {
            if (preg_match('/\(.+\)/i', $alias)) {
                // contains '(...)' so this is not a proper name and can be ignored
            } else {
                if (!in_array($alias, $group_array)) {
                    $group_array[] = $alias;
                } // if
            } // if
        } // foreach

        // turn array bac into a string
        $groupby = implode(', ', $group_array);

        return $groupby;

    } // fullGroupBy
} // if

// ****************************************************************************
if (!function_exists('format_xml_document')) {
    function format_xml_document ($input)
    // take an unformatted XML document and add line breaks and indentation.
    // $input may be a string or a file path.
    {
        libxml_use_internal_errors(true);

        if (is_object($input)) {
            $doc    = $input;
            $errors = array();
        } elseif (preg_match('/^\<\?xml /i', $input)) {
            // load string
            $doc = new DOMDocument();
            $doc->preserveWhiteSpace = false;
            try {
                $doc->loadXML($input);
            } catch (Exception $e) {
                trigger_error($e->getMessage(), E_USER_ERROR);
            } // try
        } elseif (file_exists($input)) {
            // load contents of file
            $doc = new DOMDocument();
            $doc->preserveWhiteSpace = false;
            $doc->load($path_to_file);
        } else {
            return "**INPUT IS NOT VALID XML!!**\n".$input;
        } // if

        $errors = libxml_get_errors();
        if (!empty($errors)) {
            // construct a string from the first entry
            $everything = libxml_display_errors($errors);
            trigger_error($everything, E_USER_ERROR);
        } // if

        $doc->formatOutput       = true;
        try {
            $string_out = $doc->saveXML();
        } catch (Exception $e) {
            trigger_error($e->getMessage(), E_USER_ERROR);
        } // try

        libxml_use_internal_errors(false);

        return $string_out;

    } // format_xml_document
} // if

// ****************************************************************************
if (!function_exists('generateGUID')) {
    function generateGUID ($include_braces=false)
    // generate a GUID (Global Unique IDentifier).
    {
        if (function_exists('com_create_guid')){
            $guid = com_create_guid();
        } else {
            mt_srand((double)microtime()*10000);  //optional for php 4.2.0 and up.
            $charid = strtoupper(md5(uniqid(rand(), true)));
            $hyphen = chr(45); // "-"
            $guid = '{'.substr($charid, 0, 8).$hyphen
                       .substr($charid, 8, 4).$hyphen
                       .substr($charid,12, 4).$hyphen
                       .substr($charid,16, 4).$hyphen
                       .substr($charid,20,12)
                   .'}';
        } // if

        if (!is_True($include_braces)) {
            $guid = trim($guid, '{}');
        } // if

        return $guid;

    } // generateGUID
} // if

// ****************************************************************************
if (!function_exists('getBrowserVersion')) {
    function getBrowserVersion ()
    // get the name and verson number of the user's browser.
    {
        $result = '';

        if (ini_get('browscap') AND $browser = get_browser(null, true)) {
            $result = $browser['browser'].$browser['majorver'];
        } else {
            include_once('browser_detection.inc');
            if (function_exists('browser_detection')) {
                $browser = browser_detection('full');
                $result = $browser[0].(int)$browser[1];
            } // if
        } // if

        return strtolower($result);

    } // getBrowserVersion
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
                //if ($value === $oldarray[$item]) {
                if ($value == $oldarray[$item]) {
                    unset($newarray[$item]);
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
            $finfo = finfo_open(FILEINFO_MIME);
            $mimetype = finfo_file($finfo, $filename);
            finfo_close($finfo);
            if (empty($mimetype)) {
                $mimetype = "application/octet-stream";
            } // if
            return $mimetype;

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
        	    	if ($array[$i]['object'] instanceof $classname) {
            	    	$method = $array[$i]['function'];
            	    	break;
            	    } // if
            	    if ($array[$i]['object'] instanceof $parentclass) {
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
                 . '/is';           // end delimiter, case insensitive, include newlines

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
if (!function_exists('')) {
    function getFieldsInScreen ($structure, $zone)
    // return a list of fields which exist in the current screen structure
    {
        $fields = array();

        if (empty($zone)) {
            $zone = 'main';
        } // if

        if (!empty($structure[$zone]) AND array_key_exists('fields', $structure[$zone])) {
            foreach ($structure[$zone]['fields'] as $array) {
                if (is_string(key($array))) {
                    // array is associative
                    $fields[] = key($array);
                } else {
                    // this is an array within an array, so step through each sub-array
                    foreach ($array as $array4) {
                        if (array_key_exists('field', $array4)) {
                            $fields[] = $array4['field'];
                        } // if
                    } // foreach
                } // if
            } // foreach
        } // if

        return $fields;

    } // getFieldsInScreen
} // if

// ****************************************************************************
if (!function_exists('getLanguageArray')) {
    function getLanguageArray ($id)
    // get named array from the language file.
    {
        static $array1;         // for sys.language_array.inc
        static $array2;         // for language_array.inc
        static $language;       // current language
        static $curr_dir;       // current directory used for $array2 contents

        $dir_script = dirname($_SERVER['SCRIPT_FILENAME']);
        if (substr(getcwd(), 0, strlen($_SERVER['DOCUMENT_ROOT'])) != $_SERVER['DOCUMENT_ROOT']) {
            //$res = chdir($dir_script);  // force cwd() to be same as current script (a bug somewhere changes this!!!)
        } // if
        $cwd = getcwd();

        if (!empty($GLOBALS['classdir'])) {
            if ($curr_dir != $GLOBALS['classdir']) {
                $curr_dir  = $GLOBALS['classdir'];
            } // if
        } elseif (defined('TEXT_DIRECTORY')) {
            if ($curr_dir != TEXT_DIRECTORY) {
                $curr_dir  = TEXT_DIRECTORY;
            } // if
        } elseif ($curr_dir != $dir_script) {
            $curr_dir = $dir_script;
        } // if
        if (!empty($curr_dir) AND $curr_dir != $cwd) {
            $cwd = $curr_dir;
            $res = chdir($curr_dir);
            $array2   = false;  // cause this to be reloaded
        } else {
            $curr_dir = $cwd;
        } // if
        if (basename($curr_dir) == 'text') {
            $curr_dir = dirname($curr_dir);  // remove 'text' directory
        } // if

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

        if (!is_array($array1)) {
            $array1 = array();
            // find file in a language subdirectory
            if (isDirectoryValid($curr_dir.'/../menu/text')) {
                $dir = realpath($curr_dir.'/../menu/text');
            } else {
                $dir = realpath('./text');
            } // if
            $fname = getLanguageFile('sys.language_array.inc', $dir);
            $array1 = require $fname;  // import contents of disk file
            if (empty($array1)) {
            	//trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
                trigger_error("File $fname is empty", E_USER_ERROR);
            } // if
            unset($array);
        } // if

        if (!is_array($array2)) {
            $array2 = array();
            // find file in a language subdirectory
            $dir = realpath($curr_dir.'/text');
            $fname = getLanguageFile('language_array.inc', $dir);
            $array2 = require $fname;  // import contents of disk file
            if (empty($array2)) {
            	// 'File $fname is empty'
                trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
            } // if
            unset($array);
        } // if

        if (!empty($GLOBALS['project_code'])) {
            // now look for a file of custom messages
            $dir = realpath($curr_dir.'/text/custom-processing/'.$GLOBALS['project_code']);
            if (!empty($dir)) {
                $fname = getLanguageFile('language_array.inc', $dir, true);
                if ($fname) {
                    $array3 = require $fname;  // import contents of disk file
                    // custom values replace standard values
                    $array1 = array_merge($array1, $array3);
                    $array2 = array_merge($array2, $array3);
                    unset($array3);
                } // if
            } // if
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

        return $result;

    } // getLanguageArray
} // if

// ****************************************************************************
if (!function_exists('getLanguageFile')) {
    function getLanguageFile ($filename, $directory, $ignore_if_not_found=false)
    // look for '$directory/$language/$filename' where $language is variable.
    {
        if (empty($directory)) {
            $directory = 'text';  // default value
        } // if

        $language_array = array();  // a list of possible language options

        if (!empty($GLOBALS['party_language'])) {
        	$language_array[] = $GLOBALS['party_language'];
        } // if

        if (!empty($_SESSION['user_language'])) {
            $language_array[] = $_SESSION['user_language'];
        } // if

        if (!function_exists('getBrowserLanguage')) {
            require('language_detection.inc');
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
            // change hyphen to underscore before file system lookup
            $language = str_replace('-', '_', strtolower($language));
        	$fname = "$directory/$language/$filename";
        	if (file_exists($fname)) {
        	    break;
        	} // if
        } // foreach

        if (!file_exists($fname)) {
            if (is_True($ignore_if_not_found)) {
                return false;
            } else {
                if (preg_match('/^sys/i', $filename)) {
                    // cannot find 'sys' file, so use literal as translation is not possible
                	trigger_error("File $fname cannot be found", E_USER_ERROR);
                } else {
                    trigger_error(getLanguageText('sys0056', $fname), E_USER_ERROR);
                } // if
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
        static $array1;         // for sys.language_text.inc (global messages)
        static $array2;         // for language_text.inc (subsystem messages)
        static $language;       // current language
        static $curr_dir;       // current directory used for $array2 contents

        $dir_script = dirname($_SERVER['SCRIPT_FILENAME']);
        if (substr(getcwd(), 0, strlen($_SERVER['DOCUMENT_ROOT'])) != $_SERVER['DOCUMENT_ROOT']) {
            //$res = chdir($dir_script);  // force cwd() to be same as current script (a bug somewhere changes this!!!)
        } // if
        $cwd = getcwd();
        if (!empty($GLOBALS['classdir'])) {
            if ($curr_dir != $GLOBALS['classdir']) {
                $curr_dir  = $GLOBALS['classdir'];
            } // if
        } elseif (defined('TEXT_DIRECTORY')) {
            if ($curr_dir != TEXT_DIRECTORY) {
                $curr_dir  = TEXT_DIRECTORY;
            } // if
        } elseif ($curr_dir != $dir_script) {
            $curr_dir = $dir_script;
        } // if
        if (!empty($curr_dir) AND $curr_dir != $cwd) {
            $cwd = $curr_dir;
            $res = chdir($cwd);
            $array2   = false;  // cause this to be reloaded
        } else {
            $curr_dir = $cwd;
        } // if
        if (basename($curr_dir) == 'text') {
            $curr_dir = dirname($curr_dir);  // remove 'text' directory
        } // if

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

        if (!is_array($array1)) {
            $array1 = array();
            // find file in a language subdirectory
            if (isDirectoryValid($curr_dir.'/../menu/text')) {
                $dir = realpath($curr_dir.'/../menu/text');
            } else {
                $dir = realpath('./text');
            } // if
            if (defined('RDC_WITHIN_ERROR_HANDLER')) {
                // do not fail if this file is not found
                $fname = getLanguageFile('sys.language_text.inc', $dir, true);
            } else {
                $fname = getLanguageFile('sys.language_text.inc', $dir);
            } // if
            if ($fname) {
            	$array1 = require $fname;  // import contents of disk file
                if (empty($array1)) {
                    //trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
                    trigger_error("File $fname is empty", E_USER_ERROR);
                } // if
                unset($array);
                // extract identity of language subdirectory
                $language = basename(dirname($fname));
                // use this language in the XSL transformation
            	$GLOBALS['output_language'] = $language;
            } else {
                $array1 = array();
            } // if
            if (!empty($GLOBALS['project_code'])) {
                // now look for a file of custom messages
                $dir = realpath($dir.'/custom-processing/'.$GLOBALS['project_code']);
                if (!empty($dir)) {
                    $fname = getLanguageFile('sys.language_text.inc', $dir, true);
                    if ($fname) {
                        $array3 = require $fname;  // import contents of disk file
                        // custom values replace standard values
                        $array1 = array_merge($array1, $array3);
                        unset($array3);
                    } // if
                } // if
            } // if
        } // if

        if (!is_array($array2)) {
            $array2 = array();
            // find file in a language subdirectory
            $dir = realpath($curr_dir.'/text');
            if (defined('RDC_WITHIN_ERROR_HANDLER')) {
    	        // do not fail if this file is not found
                $fname = getLanguageFile('language_text.inc', $dir, true);
    	    } else {
    	        $fname = getLanguageFile('language_text.inc', $dir);
    	    } // if
    	    if ($fname) {
    	    	$array2 = require $fname;  // import contents of disk file
                if (empty($array2)) {
                	// 'File $fname is empty'
                    trigger_error(getLanguageText('sys0124', $fname), E_USER_ERROR);
                } // if
                unset($array);
    	    } else {
    	        $array2 = array();
    	    } // if
            if (!empty($GLOBALS['project_code'])) {
                // now look for a file of custom messages
                $dir = realpath($curr_dir.'/text/custom-processing/'.$GLOBALS['project_code']);
                if (!empty($dir)) {
                    $fname = getLanguageFile('language_text.inc', $dir, true);
                    if ($fname) {
                        $array4 = require $fname;  // import contents of disk file
                        // custom values replace standard values
                        $array2 = array_merge($array2, $array4);
                        unset($array4);
                    } // if
                } // if
            } // if
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

        return $string;

    } // getLanguageText
} // if

// ****************************************************************************
if (!function_exists('getMicroTime')) {
    function getMicroTime ()
    // get the current time in microseconds
    {
        list($usec, $sec) = explode(' ', microtime());
        $time = (float) $sec + (float) $usec;

        return $time;

    } // getMicroTime
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

        if (isset($GLOBALS['https_server_suffix']) AND strlen($GLOBALS['https_server_suffix']) > 0) {
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

        if (!preg_match('/(\.php)$/i', $script_id)) {
        	// does not end in '.php', so it is a task_id
        	$dbobject =& RDCsingleton::getInstance('mnu_task');
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
                if (isset($_SESSION['pages'][$script_id]) AND isset($_SESSION['pages'][$script_id]['pattern_id'])) {
            	    $pattern_id = $_SESSION['pages'][$script_id]['pattern_id'];
                } else {
                    $pattern_id = 'unknown';
                } // if
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
    function getPostArray ($post, $fieldlist, $multiple=false)
    // extract all the entries in $post array which are named in $fieldlist.
    // $post contains the entire $_POST array.
    // $fieldlist identifies the fields that belong to a particular database table.
    // $multiple identifies that POST array should be examined for entries which are indexed by row number.
    {
        $array_out = array();

        foreach ($post as $key => $value) {
            if (preg_match('/^(button#)/i', $key, $regs)) {
            	// strip prefix from field name
            	$key = str_replace($regs[0], '', $key);
            } // if
            if (is_True($multiple)) {
                if (is_array($value)) {
                    $array_out[$key] = $value; // only accept values which are indexed by row
                } // if
            } else {
        	    if (array_key_exists($key, $fieldlist)) {
        		    $array_out[$key] = $value;
        	    } // if
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
if (!function_exists('getForeignKeyValues')) {
    function getForeignKeyValues ($parentOBJ, $childOBJ)
    // identify any mapping between the column names for the foreign key on the
    // CHILD object and the corresponding primary/unique key on the PARENT object.
    {
        if (!is_object($parentOBJ)) {
            // "1st argument must be an object"
            trigger_error(getLanguageText('sys0227'), E_USER_ERROR);
        } // if

        if (!is_object($childOBJ)) {
            // "2rd argument must be an object"
            trigger_error(getLanguageText('sys0228'), E_USER_ERROR);
        } // if

        $parent_table = $parentOBJ->getClassName(); // may be a sub-class providing an alias name
        $child_table  = $childOBJ->tablename;       // use actual name
        $parent_data  = $parentOBJ->getFieldArray();
        if (is_long(key($parent_data))) {
            $parent_data = array_shift($parent_data);
        } // if

        $found = false;
        // first look for alias names
        foreach ($childOBJ->parent_relations as $reldata) {
            if (isset($reldata['alias']) AND $reldata['alias'] == $parent_table) {
                $found = true;
                break;
            } // if
        } // foreach

        if (!$found) {
            reset($childOBJ->parent_relations);
            // now look for a non-aliased name
            foreach ($childOBJ->parent_relations as $reldata) {
                if ($reldata['parent'] == $parent_table) {
                    $found = true;
                    break;
                } // if
            } // foreach
        } // if

        $fkeyvalues  = array();

        if ($found) {
            foreach ($reldata['fields'] as $child_field => $parent_field) {
                // swap the field names between the PARENT and CHILD tables
                if (array_key_exists($parent_field, $parent_data)) {
                    $fkeyvalues[$child_field] = $parent_data[$parent_field];
                } // if
            } // foreach
        } else {
            // no relationship found, so default to primary key of parent
            $pkeynames = $parentOBJ->getPkeyNamesAdjusted();
            foreach ($pkeynames as $fieldname) {
                if (array_key_exists($fieldname, $parent_data)) {
                    $fkeyvalues[$fieldname] = $parent_data[$fieldname];
                } // if
            } // foreach
        } // if

        return $fkeyvalues;

    } // getForeignKeyValues
} // if

// ****************************************************************************
if (!function_exists('getRealIPAddress')) {
    function getRealIPAddress ()
    // obtain client's IP address from the relevant source.
    {
        // these names may be used by proxy servers
        $names[] = 'HTTP_CLIENT_IP';
        $names[] = 'HTTP_X_FORWARDED_FOR';
        $names[] = 'HTTP_X_FORWARDED';
        $names[] = 'HTTP_X_CLUSTER_CLIENT_IP';
        $names[] = 'HTTP_FORWARDED_FOR';
        $names[] = 'HTTP_FORWARDED';

        foreach ($names as $name) {
            if (array_key_exists($name, $_SERVER)) {
                foreach (explode(',', $_SERVER[$name]) as $ip){
                    $ip = trim($ip);
                    if (validate_ip($ip) === true) {
                        return $ip;
                    } // if
                } // foreach
            } // if
        } // foreach

        $ip = $_SERVER['REMOTE_ADDR'];  // this is always the default

        return $ip;

    } // getRealIPAddress
} // if

// ****************************************************************************
if (!function_exists('getSelf')) {
    function getSelf ($path=null)
    // reduce $path to '/dir/file.php' to exclude all leading directory names.
    {
        if (empty($path)) {
            $path = ($_SERVER['PHP_SELF']);
        } // if

        if (basename(dirname($path)) != null) {
        	$PHP_SELF = '/' .basename(dirname($path))
                       .'/' .basename($path);
        } else {
            $PHP_SELF = '/' .basename($path);
        } // if

        return strtolower($PHP_SELF);

    } // getSelf
} // if

// ****************************************************************************
if (!function_exists('getSwiftMailerTransport')) {
    function getSwiftMailerTransport ($config)
    // select SwiftMailer transport object using contents of $config
    // (this assumes that the relevant SwiftMailer code has already been loaded)
    {
        switch ($config['transport']) {
            case 'mail':
                $transport = Swift_MailTransport::newInstance();
                break;

            case 'sendmail':
                $command   = $config['commandline'];
                $transport = Swift_SendmailTransport::newInstance($command);
                break;

            case 'smtp':
                $server     = $config['server'];
                $port       = $config['port'];
                $encryption = $config['encryption'];
                $username   = $config['username'];
                $password   = $config['password'];
                $transport  = Swift_SmtpTransport::newInstance();
                $transport->setHost($server);
                if (!empty($port)) {
                	$transport->setPort($port);
                } // if
                if (!empty($encryption)) {
                	$transport->setEncryption($encryption);
                } // if
                if (!empty($username)) {
                	$transport->setUsername($username);
                	$transport->setPassword($password);
                } // if
                break;

            default:
                $transport = false;
        } // switch

        return $transport;

    } // getSwiftMailerTransport
} // if

// ****************************************************************************
if (!function_exists('getTableAlias1')) {
    function getTableAlias1 ($alias, $string)
    // look for 'original AS alias' in $string and return 'original'
    {
        // build array of words which come before ' as ' in string
        $count = preg_match_all('/\w+[ ]*(?= as )/is', $string, $regs);
        $array1 = array_map('trim', $regs[0]);

        // build array of words which come after ' as ' in string
        $count = preg_match_all('/(?<= as )[ ]*\w+/is', $string, $regs);
        $array2 = array_map('trim', $regs[0]);

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
        $count = preg_match_all('/\w+[ ]*(?= as )/is', $string, $regs);
        $array1 = array_map('trim', $regs[0]);

        // build array of words which come after ' as ' in string
        $count = preg_match_all('/(?<= as )[ ]*\w+/is', $string, $regs);
        $array2 = array_map('trim', $regs[0]);

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
        if ($count = preg_match('/\w+\.\w+[ ]*(?= as )|\w+[ ]*(?= as )/is', $string, $regs) > 0) {
        	$array[0] = trim($regs[0]);  // original
        	$count = preg_match('/(?<= as )[ ]*\w+/is', $string, $regs);
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
    function getTimeDiff ($start, $end, $return_seconds=false)
    // calculate the difference between two times
    {
        $time1 = strtotime($start);     // convert to seconds
        $time2 = strtotime($end);       // convert to seconds

        if ($return_seconds === true) {
            $result = $time2 - $time1;
        } else {
            $result = ceil(($time2 - $time1) / 60); // convert to minutes
        } // if

        return $result;

    } // geTimeDiff
} // if

// ****************************************************************************
if (!function_exists('getTimeStamp')) {
    function getTimeStamp ($type=null)
    // get timestamp in 'CCYY-MM-DD HH:MM:SS' format
    {
        if (empty($GLOBALS['server_timezone'])) {
            // this uses now() which is the server time
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
        } else {
            // get override server time zone from config.inc
            $server_timezone = $GLOBALS['server_timezone'];
            switch (strtolower($type)) {
                case 'date':
                    $output = convertTZdate(gmdate('Y-m-d'), gmdate('H:i:s'), 'UTC', $server_timezone);
                    break;
                case 'time':
                    $output = convertTZtime(gmdate('Y-m-d'), gmdate('H:i:s'), 'UTC', $server_timezone);
                    break;
                default:
                    $output = convertTZ(gmdate('Y-m-d H:i:s'), 'UTC', $server_timezone);
            } // switch
        } // if

        return $output;

    } // getTimeStamp
} // if

// ****************************************************************************
if (!function_exists('html2text')) {
    function html2text ($input, $charset='iso-8859-1')
    // convert HTML document to plain text.
    {
        if (preg_match('/(?<=charset=)[-0-9a-zA-Z]+/i', $input, $regs)) {
            // use charset which was defined in the HTML document
            $charset = $regs[0];
        } // if

        if ($charset == 'iso-8859-1') {
            // continue
        } elseif ($charset == 'us-ascii') {
            $charset='iso-8859-1';
        } elseif ($charset == 'unicode') {
            $charset = 'utf-8';
        } // if

        $output = iconv($charset, 'UTF-8//TRANSLIT', $input);
        $output = convertEncoding ($input, 'UTF-8', $charset);

        // convert non-breaking spaces (UTF-8 encoding is 0xC2 0xA0)
        $nbsp = chr(194).chr(160);
        $output = str_replace('&nbsp;', $nbsp, $output);

        // decode such things as '&lt;' into '<'
        $output = htmlspecialchars_decode($output, ENT_QUOTES);

        // remove all line breaks
        $output = str_replace(array("\r\n", "\r", "\n"), '', $output);

        // convert all '<BR>' tags to line breaks
        $output = preg_replace('#([ ]*<BR[ ]*[/]?>[ ]*)#imsu', "\n", $output);

        // remove any spaces between tags
        $output = preg_replace('#>[ \n\r\t]+<#imsu', '><', $output);

        // convert all '<p>' tags to double line breaks
        $output = preg_replace('#(<p[ ]*)#imsu', "\n\n<p ", $output);

        // convert all '</p>' tags to double line breaks
        $output = preg_replace('#(</p>)#imsu', "</p>\n\n", $output);

        // insert line break after each '</DIV>'
        $output = preg_replace('#</DIV>#imsu', "</DIV>\n", $output);

        // insert line break after each '</LI>'
        $output = preg_replace('#</LI>#imsu', "</LI>\n", $output);

        // insert line break after each '</TR>'
        $output = preg_replace('#</TR>#imsu', "</TR>\n", $output);

        // insert comma after each '</TD>'
        $output = preg_replace('#</TD>#imsu', "</TD>,", $output);

        // remove or replace all other HTML tags and special characters
        $output = preg_replace('#<title>.*</title>#imsu', '', $output);
        $output = preg_replace('#<style[ ]*.*</style>#imsu', '', $output);
        $output = preg_replace('#<meta[ ]*.*/>#imsu', '', $output);
        $output = preg_replace('#<table[ ].*?>#imsu', '', $output);
        $output = strip_tags($output);

        $output = preg_replace('#\n'.$nbsp.'#imsu', '', $output);  // remove <newline>+nbsp
        $output = preg_replace('#\n,#imsu', '', $output);  // remove <newline>+comma
        $output = preg_replace('#\n'.$nbsp.',#imsu', '', $output);  // remove <newline>+nbsp+comma

        // replace 'comma+nbsp+comma' with 'comma'
        $output = preg_replace('#,'.$nbsp.'[ ]?,#imsu', ',', $output);
        $output = preg_replace('#,'.$nbsp.'[ ]?,#imsu', ',', $output);
        $output = preg_replace('#,'.$nbsp.'[ ]?,#imsu', ',', $output);

        // replace 'comma+comma' with 'comma'
        $output = preg_replace('#,[,]+#imsu', ',', $output);

        // convert all quadruple line breaks to double line breaks
        $output = preg_replace('#\n\n[\n]+#imsu', "\n\n", $output);

        //$output = htmlspecialchars_decode($output, ENT_QUOTES);
        $output = html_entity_decode($output, ENT_QUOTES, 'UTF-8');

        // remove leading/trailing spaces
        $output = trim($output);

        return $output;

    } // html2text
} // if

// ****************************************************************************
if (!function_exists('includeSubsystemPath')) {
    function includeSubsystemPath ($project_code=null)
    // look for an optional INCLUDE file for the current subsystem
    {
        $attempt = array();
        if (!empty($project_code)) {
            $attempt[] = "./include.subsystem.$project_code.inc";
        } // if
        $attempt[] = './include.subsystem.inc';
        $attempt[] = './include.subsystem.inc.default';
        if (!empty($project_code)) {
            $attempt[] = "./project/$project_code/include.subsystem.inc";
        } // if
        foreach ($attempt as $fn) {
            if (file_exists($fn)) {
                require($fn);
                unset($attempt, $fn);
                break;
            } // if
        } // foreach

        if (!empty($attempt)) {
            if (getcwd() != $_SERVER['DOCUMENT_ROOT']) {
                // not found in working directory, so look in document root
                $save_cwd = getcwd();
                chdir($_SERVER['DOCUMENT_ROOT']);
                foreach ($attempt as $fn) {
                    if (file_exists($fn)) {
                        require($fn);
                        break;
                    } // if
                } // foreach
                chdir($save_cwd);
            } // if
        } // if

        return true;

    } // includeSubsystemPath
} // if

// ****************************************************************************
if (!function_exists('includeTransixPath')) {
    function includeTransixPath ()
    // modify INCLUDE_PATH for standard TRANSIX subsystems
    {
        $include_path = ini_get('include_path');
        if (is_dir('./transix/menu')) {
            $include_path .= PATH_SEPARATOR .realpath('./transix/menu');
            $include_path .= PATH_SEPARATOR .realpath('./transix/audit');
            $include_path .= PATH_SEPARATOR .realpath('./transix/workflow');

        } elseif (is_dir($_SERVER['DOCUMENT_ROOT'].'/transix/menu')) {
            $include_path .= PATH_SEPARATOR .$_SERVER['DOCUMENT_ROOT'].'/transix/menu';
            $include_path .= PATH_SEPARATOR .$_SERVER['DOCUMENT_ROOT'].'/transix/audit';
            $include_path .= PATH_SEPARATOR .$_SERVER['DOCUMENT_ROOT'].'/transix/workflow';

        } elseif (isDirectoryValid('../radicore/menu')) {
            $include_path .= PATH_SEPARATOR .realpath('../radicore/menu');
            $include_path .= PATH_SEPARATOR .realpath('../radicore/audit');
            $include_path .= PATH_SEPARATOR .realpath('../radicore/workflow');

        } elseif (isDirectoryValid('../menu')) {
            $include_path .= PATH_SEPARATOR .realpath('../menu');
            $include_path .= PATH_SEPARATOR .realpath('../audit');
            $include_path .= PATH_SEPARATOR .realpath('../workflow');

        } elseif (isDirectoryValid('../../radicore/menu')) {
            $include_path .= PATH_SEPARATOR .realpath('../../radicore/menu');
            $include_path .= PATH_SEPARATOR .realpath('../../radicore/audit');
            $include_path .= PATH_SEPARATOR .realpath('../../radicore/workflow');

        } elseif (isDirectoryValid('../../../radicore/menu')) {
            $include_path .= PATH_SEPARATOR .realpath('../../../radicore/menu');
            $include_path .= PATH_SEPARATOR .realpath('../../../radicore/audit');
            $include_path .= PATH_SEPARATOR .realpath('../../../radicore/workflow');
        } // if
        ini_set('include_path', $include_path);

        return $include_path;

    } // includeTransixPath
} // if

// ****************************************************************************
if (!function_exists('indexed2assoc')) {
    function indexed2assoc ($array_in, $use_latest=false)
    // turn an indexed array (created by where2indexedArray) into an associative array.
    // $use_latest identifies which of multiple entries to use (default is 'first')
    {
        $array_out = array();

        $pattern1 = <<< END_OF_REGEX
/
^
(                            # start choice
 NOT[ ]+[a-zA-Z_]+           # 'NOT <something>'
 |                           # or
 [a-zA-Z_]+                  # '<something>'
)                            # end choice
[ ]*                         # 0 or more spaces
\(                           # starts with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # any characters
 )                           # end choice
\)                           # end with ')'
/xis
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^
\([ ]*SELECT [^\(\)]* .*\)     # '(SELECT ...)'
[ ]*                           # 0 or more spaces
(<>|<=|<|>=|>|!=|=)            # comparison operators
[ ]*                           # 0 or more spaces
(                              # start choice
 '(([^\\\']*(\\\.)?)*)'        # quoted string
 |                             # or
 [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
)                              # end choice
/xis
END_OF_REGEX;

        $prev_separator = null;
        $paren_count    = 0;  // parentheses count: '('= +1, ')'= -1
        $paren_string   = null;
        foreach ($array_in as $index => $string) {
        	$string = trim($string);
        	if ($paren_count > 0) {
            	// parenthesised string has not yet been closed, so append to it
            	if (preg_match('/^(AND|OR)$/i', $string)) {
            	    $string = strtoupper($string);
            		$paren_string .= " $string ";
            	} else {
            	    $paren_string .= $string;
            	} // if
            	if (preg_match('/^(\()$/i', $string)) {
                	$paren_count++;  // '(' encountered, so increment count
                } elseif (preg_match('/^(\))$/i', $string)) {
                    $paren_count--;  // ')' encountered, so decrement count
                    $string = null;
                } // if
                if ($paren_count <= 0) {
                	// closing parenthesis found, so output this string as an indexed entry
                	if (empty($prev_separator)) {
                	    // no separator available, so revert to default
                        if (empty($array_out)) {
                            $array_out[] = $paren_string;
                        } else {
                		    $array_out[] = 'AND '.$paren_string;
                        } // if
                	} else {
                	    $array_out[] = $prev_separator.' '.$paren_string;
                	} // if
                	$paren_string = null;
                	$prev_separator = null;
                } // if

        	} elseif ($string == '(') {
        	    // start a string in parentheses - '( something )'
        	    $paren_string .= $string;
        	    $paren_count++;

        	} elseif (preg_match('/^(AND|OR)$/i', $string)) {
            	$string = strtoupper($string);
            	if (trim($string) == 'AND') {
            		// this is the default separator, so lose it
            		$prev_separator = null;
            	} else {
            	    // save this for later
            	    $prev_separator = $string;
            	} // if

            } elseif (preg_match($pattern1, $string, $regs)) {
                // format: '[NOT] something (...)', so cannot be split
                if (empty($prev_separator)) {
                    if (empty($array_out)) {
                        $array_out[] = $string;
                    } else {
                    	// no separator available, so revert to default
                		$array_out[] = 'AND '.$string;
                    } // if
            	} else {
            	    $array_out[] = $prev_separator.' '.$string;
            	} // if
            	$prev_separator = null;

            } elseif (preg_match($pattern2, $string, $regs)) {
                // format: '(...) = <something>', so cannot be split
                if (empty($prev_separator)) {
                    if (empty($array_out)) {
                        $array_out[] = $string;
                    } else {
                	    // no separator available, so revert to default
                		$array_out[] = 'AND '.$string;
                    } // if
            	} else {
            	    $array_out[] = $prev_separator.' '.$string;
            	} // if
            	$prev_separator = null;

            } elseif (substr($string, 0,1) == '(' AND substr($string, -1, 1) == ')') {
                // begins with '(' and ends with ')', so cannot be split
                if (empty($prev_separator)) {
                    if (empty($array_out)) {
                        $array_out[] = $string;
                    } else {
                	    // no separator available, so revert to default
                		$array_out[] = 'AND '.$string;
                    } // if
            	} else {
            	    $array_out[] = $prev_separator.' '.$string;
            	} // if
            	$prev_separator = null;
            } else {
                while (!empty($string)){
                    $duff = array();
            	    // split element into its component parts
            		list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
                    $operator = trim($operator);
                    if (!preg_match('/^[ ]*=[ ]*$/', $operator)) {
                        $operator = ' '.$operator.' ';  // not '=', so put spaces either side
                    } // if
            		if (!empty($prev_separator)) {
            			$array_out[] = "{$prev_separator} {$fieldname}{$operator}{$fieldvalue}";
            		    $prev_separator = null;

            		} else {
                        if ($use_latest === true) {
            		        // add to array, overwriting any previous entry
            			    $array_out[$fieldname] = ltrim($operator).$fieldvalue;

            		    } elseif (!array_key_exists($fieldname, $array_out)) {
                    	    // $fieldname is not in $array_out, so add it
                    	    $array_out[$fieldname] = ltrim($operator).$fieldvalue;
            		    } // if
                    } // if
            		if (!empty($string)) {
            			// extract any separator between each element
            		    $string = extractSeparator($string, $duff);
            		} // if
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
        $errors = array();

        if (is_string($where)) {
            // convert string into array
            $fieldarray = where2indexedArray($where);
        } else {
            // $where is already an array
            reset($where);  // fix for version 4.4.1
            if (is_long(key($where))) {
                $key = key($where);
                if (is_array($where[$key])) {
                    // indexed by row, so use first row only
                    $fieldarray = $where[key($where)];
                } else {
                    $string = trim($where[$key]);
                    if (preg_match('/^(OR|AND)[ ]*\(/i', $string, $regs)) {
                        $string = substr($string, strlen($regs[0]));
                        $string = substr($string, 0, -1);  // drop trailing ')'
                    } // if
                    $fieldarray = where2array($string);
                } // if
            } else {
                $fieldarray = $where;  // this is an associative array
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
            $fieldspec = $object->fieldspec;
        } else {
            $tablename = null;
            $fieldspec = array();
        } // if

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
            $where = array2where($fieldarray, $pkey);
            return array($where, $errors);
        } // if

        if (!empty($candidate_keys)) {
            // look to see if any candidate keys have been supplied
            foreach ($candidate_keys as $ukey) {
                $yes_count = 0;
            	foreach ($ukey as $fieldname) {
            	    if (array_key_exists($fieldname, $fieldarray)) {
                	    // value must NOT contain wildcard character
                        if (strpos($fieldarray[$fieldname], '%') === false) {
                            $yes_count ++;  // field is valid, so continue
                        } // if
                    } elseif (array_key_exists($fieldname, $fieldspec) AND empty($fieldspec[$fieldname]['is_required'])) {
                        if ($yes_count > 0) {  // if at least one part has been supplied
                            $yes_count ++;  // field is missing, but it is optional, so continue
                        } // if
            	    } // if
            	} // foreach
            	if ($yes_count == count($ukey)) {
            		// all required components of this unique key have been supplied
            		$where = array2where($fieldarray, $ukey);
                    return array($where, $errors);
            	} // if
            } // foreach
        }

        foreach ($pkey as $fieldname) {
            $errors[] = getLanguageText('sys0018', $fieldname); // "Primary key ($fieldname) is not complete - check selection"
        } // foreach

        return array(null, $errors);

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
if (!function_exists('isDirectoryValid')) {
    function isDirectoryValid ($dir)
    // check that directory $dir is valid and exists.
    {
        $temp = realpath($dir);
        if (ini_get('open_basedir') == false) {
            if (is_dir($temp)) {
                return TRUE;
            } // if
        } else {
            // check that target directory is not outside restricted area
            $temp = realpath($dir);
            $array = explode(PATH_SEPARATOR, ini_get('open_basedir'));
            while (!empty($temp)){
                if (in_array($temp, $array)) {
                    if (is_dir($dir)) {
                        return TRUE;
                    } else {
                        return FALSE;
                    } // if
                } else {
                    $temp = dirname($temp);
                } // if
            } // while
        } // if

        return FALSE;

    } // isDirectoryValid
} // if

// ****************************************************************************
if (!function_exists('libxml_display_errors')) {
	function libxml_display_errors($errors=null)
	// convert XML errors from last XML operation into a string that can be displayed.
	{
		$string = '';
		if (empty($errors)) {
			$errors = libxml_get_errors();
		} // if
		foreach ($errors as $error) {
			if (!empty($string)) {
				$string .= '<br>';
			} // if
		 	switch ($error->level) {
		         case LIBXML_ERR_WARNING:
		             $string .= "Warning $error->code: ";
		             break;
		         case LIBXML_ERR_ERROR:
		             $string .= "Error $error->code: ";
		             break;
		         case LIBXML_ERR_FATAL:
		             $string .= "Fatal Error $error->code: ";
		             break;
		     } // switch
		     $string .= trim($error->message);
		     if ($error->file) {
		         $string .=    " in $error->file";
		     } // if
		     if ($error->line > 0) {
		     	 $string .= " on line $error->line\n";
			 } // if
			 if ($error->column > 0) {
		     	 $string .= " column $error->column\n";
			 } // if

		} // foreach
		libxml_clear_errors();

		return $string;

	} // libxml_display_errors
} // if
// ****************************************************************************
if (!function_exists('logStuff')) {
    function logStuff ($string, $function=null, $line=null)
    // write $string out to a log file for debugging
    {
    	if (!defined('LOGSTUFF')) {
    		// this function has not been turned on, so do nothing
    		return;
        } // if

        if (empty($function)) {
        	$function = getSelf();
        } // if

        if (defined('ERROR_LOG')) {
            $logfile = ERROR_LOG;  // write into specified file
        } elseif (defined('ERROR_LOG_DIR')) {
            $logfile = ERROR_LOG_DIR.'/errorlog.html';  // write into specified directory
        } else {
            $logfile = $_SERVER['DOCUMENT_ROOT'].'/error_logs/errorlog.html';  // write into default file
        } // if

        if (is_bool($string)) {
            if ($string) {
                $string = 'TRUE';
            } else {
                $string = 'FALSE';
            } // if
        } // if

        $header = "\r\n<p>********** " .date('Y-m-d H:i:s') .' ';
        $header .= "function: " .$function .", line: " .$line ."</p>\r\n";
        $result = error_log("$header $string", 3, $logfile);

        return;

    } // logStuff
} // if

// ****************************************************************************
if (!function_exists('logElapsedTime')) {
    function logElapsedTime ($start_time, $function)
    // calculate the elapsed time and write it to the log file
    {
        if (defined('PAGE_PROFILING')) {
            $end_time = getMicroTime();
            $elapsed  = number_format($end_time - $start_time, 5, '.', '');

            $string = "\"function: $function:\",\"$elapsed\"\r\n";
            $logfile = $_SERVER['DOCUMENT_ROOT'].'/elapsed_time.csv';
            $result = error_log($string, 3, $logfile);
        } // if

        return;

    } // logElapsedTime
} // if

// ****************************************************************************
if (!function_exists('logSqlQuery')) {
    function logSqlQuery ($dbname, $tablename, $query, $result=null, $start_time=null, $end_time=null)
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
            if (!empty($start_time) AND !empty($end_time)) {
                $elapsed = number_format($end_time - $start_time, 5, '.', '');
                list($number, $decimal) = explode('.', $start_time);
                $start   = date('H:i:s', (float)$number).".$decimal";
                list($number, $decimal) = explode('.', $end_time);
                $end     = date('H:i:s', (float)$number).".$decimal";
                $timings = "[S=$start, F=$end, E=$elapsed]";
            } else {
                $timings = null;
            } // if
            $query = str_replace("\n", " ", $query);
            if (empty($result)) {
                if (empty($timings)) {
                    $string = $query;
                } else {
            	    $string = "{$query} =>{$timings}";
                } //if
            } else {
                $string = "{$query} =>Count={$result} {$timings}";
            } // if
            $script_name = basename($_SERVER['PHP_SELF']);
            if (!is_dir('./sql/logs')) {
                mkdir('./sql/logs');
            } // if
            $fn = "./sql/logs/{$script_name}.{$_SESSION['logon_user_id']}.sql";
        	error_log("$string\r\n", 3, $fn);
        } // if

        return;

    } // logSqlQuery
} // if

// ****************************************************************************
if (!function_exists('makeColor')) {
    function makeColor($image, $color)
    // convert image colour codes from hex to decimal
    {
        $red   = hexdec(substr($color, 1, 2));
        $green = hexdec(substr($color, 3, 2));
        $blue  = hexdec(substr($color, 5, 2));

        $out   = ImageColorAllocate($image, $red, $green, $blue);

        return($out);

    } // makeColor
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
        if ($thousands_sep == chr(160)) {   // replace non-breaking space
           $thousands_sep = chr(32);        // with ordinary space
        } // if

        $number = $input;
        if (strlen($thousands_sep) > 0) {
        	$number = str_replace($thousands_sep, '', $number);
        } // if
        $number = str_replace($decimal_point, '.', $number);

        // strip any non-numeric characters from the end of the number
        //$number = preg_replace('/[^0-9]*$/u', '', $number);

        return $number;

    } // number_unformat
} // if

// ****************************************************************************
if (!function_exists('object2array')) {
    function object2array ($input)
    // convert an object's variables to an array.
    {
        if (is_array($input) OR is_object($input)) {
            // continue
        } else {
        	return $input;
        } // if

        $array = array();

        if (is_object($input)) {
        	if (isset($input->xmlrpc_type)) {
        		if (isset($input->scalar)) {
        			$array = $input->scalar;
        			return $array;
        		} // if
        	} // if
        } // if

        foreach ($input as $key => $value) {
        	if (is_object($value) OR is_array($value)) {
        	    if (!is_string($key) AND count($input) == 1) {
        	        // only one indexed entry, so lose the index
        	    	$array2 = object2array($value);
        	    	if (empty($array)) {
        	    		$array = $array2;
        	    	} else {
        	    	    $array = array_merge($array, $array2);
        	    	} // if
        	    } else {
        		    $array[$key] = object2array($value);
        	    } // if
        	} else {
        	    if (is_bool($value)) {
        	    	if ($value === true) {
        	    		$value = 'True';
        	    	} else {
        	    	    $value = 'False';
        	    	} // if
        	    } // if
        	    $array[$key] = $value;
        	} // if
        } // foreach

        return $array;

    } // object2array
} // if

// ****************************************************************************
if (!function_exists('pasteData')) {
    function pasteData ($dbobject, $array1, $array2)
    // update the contents of $array1 with saved data in $array2.
    // Observe the following rules:
    // - do not copy into $array1 unless the field exists in $fieldspec.
    // - if a non-null field in $array1 is a primary key then do not update it.
    // - if a field is marked as 'noedit' in $fieldspec then do not update it.
    // - if a field is marked as 'autoinsert' in $fieldspec then do not update it.
    // - if a field is marked as 'autoupdate' in $fieldspec then do not update it.
    // - if a field is a date then do not replace value with an earlier date
    {
        if (!is_object($dbobject)) {
            return $array1;  // not an object, so cannot do anything
        } // if

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

        $fieldspec =& $dbobject->fieldspec;

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
            } elseif (isset($fieldspec[$fieldname]['password'])) {
                $reason = 7; // field marked as 'password', so do not copy
            } elseif ($fieldspec[$fieldname]['type'] == 'date' AND $array1[$fieldname] > $array2[$fieldname]) {
                $reason = 8; // do not overwrite with an earlier date
            } else {
                $array1[$fieldname] = $array2[$fieldname];
                // now look for parent relationships where this field is the foreign key
                if (isset($dbobject->parent_relations)) {
                    foreach ($dbobject->parent_relations as $parent) {
                        foreach ($parent['fields'] as $fk_name => $pk_name) {
                            // found, so initialise any fields obtained from the foreign table
                            // so that they can be refreshed from the new parent record
                            if ($fk_name == $fieldname AND !empty($parent['parent_field'])) {
                                $array3 = explode(',', $parent['parent_field']);
                                foreach ($array3 as $fname) {
                                    $fname = trim($fname);
                                    list($expression, $alias) = getFieldAlias3($fname);
                                    $array1[$alias] = null;
                                } // foreach
                            } // if
                        } // foreach
                    } // foreach
                } // if
            } // if
        } // foreach

        return $array1;

    } // pasteData
} // if

// ****************************************************************************
if (!function_exists('print_Trace')) {
    function print_Trace ($level, $string, $indent=null)
    // output a segment of the array produced by debug_backrace()
    {
        $trace = '';
        $indent .= '  ';    // increase indent by 2 spaces
        foreach ($string as $level2 => $string2) {
            $pattern = '/'                      // begin pattern
                     . '^(HTTP_[a-z]+_VARS)$'   // HTTP_xxxx_VARS
                     . '|'                      // or
                     . '^(HTTP_[a-z]+_FILES)$'  // HTTP_xxxx_FILES
                     . '|'                      // or
                     . '^(_[a-z]+)$'            // _xxxx
                     . '|'                      // or
                     . '^GLOBALS$'              // GLOBALS
                     . '/i';                    // end pattern, case insensitive
            if (preg_match($pattern, $level2, $regs)) {
                // ignore
            } else {
            	if (is_array($string2)) {
                    if (isset($string2['this'])) {
                        // output class name, but no class properties
                        $class = get_class($string2['this']);
                        $trace .= $indent ."$level2: object = $class\n";
                    } else {
                        $trace .= $indent ."$level2: array =\n";
                        $trace .= print_Trace($level2, $string2, $indent);
                    } // if
            	} elseif (is_object($string2)) {
            	    // do nothing
                } else {
                    if (is_null($string2)) {
                    	$trace .= $indent ."$level2: string = null\n";
                    } else {
                        $trace .= $indent ."$level2: " .gettype($string2) ." = $string2\n";
                    } // if
                } // if
            } // if
        } // foreach

        return $trace;

    } // print_Trace
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
            if ($count = preg_match("/\w+ as \w+/is", $sql_search_table, $regs)) {
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
            } elseif (preg_match('/^(true|false)$/i', $fieldname, $regs)) {
                // this is "TRUE=..." or "FALSE=...", so it cannot be qualified
                $output_array[] = $fieldname.$fieldvalue;
            } elseif (preg_match("/^'.*'$/i", $fieldname, $regs)) {
                // this is a quoted string so it cannot be qualified
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
                    if (is_array($select_alias) AND array_key_exists($fieldname, $select_alias)) {
            	    	// fieldname is an alias of something, so move it to the HAVING clause
                        if (array_key_exists($fieldname, $having_array)) {
                            // name already exists, so add it as an index entry
                            $having_array[] = 'OR '.$fieldname.$fieldvalue;
                        } else {
            	    	    $having_array[$fieldname] = $fieldvalue;
                        } // if
            	    } elseif (empty($table_array)) {
            	        // if $fieldspec is supplied does it contain fieldname?
            	    	if (empty($fieldspec) or (array_key_exists($fieldname, $fieldspec)) AND !isset($fieldspec[$fieldname]['nondb'])) {
                            if (preg_match('/curr_or_hist/i', $fieldname)) {
                                // this is a reserved word, so leave fieldname unqualified
                                $output_array[$fieldname] = $fieldvalue;
                            } else {
                                // field is in current table, so insert qualified name
                                $output_array["$tablename.$fieldname"] = $fieldvalue;
                            } // if
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
                                	$dbobject =& RDCsingleton::getInstance($array_tablename, null, false);
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
            $value = strtolower(trim($value));
            // find out if fieldname is qualified with tablename
            $namearray = explode('.', $value);
            if (isset($namearray[1])) {
                // fieldname is qualified but, ...
                // does fieldname have an alias?
                if (array_key_exists($namearray[1], $alias_array)) {
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
                if (array_key_exists($value, $alias_array)) {
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
                        if (preg_match('/(coalesce)/i', $parts[0])) {
                            $element = $original .' AS ' .$alias;  // do not alter
                        } else {
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
    function qualifyWhere ($where, $tablename, $fieldspec=null, $sql_from=null, $sql_search_table=null, $select_alias=null, &$having_array=null)
    // add table names to field names in 'where' string.
    // Some values may be moved from WHERE to HAVING (if the name appears in the select list as an alias).
    {
        // if $where is empty do nothing
        if (empty($where)) return;

        // if $tablename is empty do nothing
        if (empty($tablename)) return $where;

        $tablename = strtolower($tablename);

        if ($count = preg_match("/\w+[ ]+as[ ]+\w+/is", $sql_search_table, $regs)) {
            // entry contains 'table AS alias', so use original table table
        	list($original, $alias) = preg_split('/ as /i', $regs[0]);
        	$sql_search_table = $alias;
        } // if

        if (!empty($sql_from)) {
            $table_array = extractTableNames($sql_from);
            $table_array = array_change_key_case($table_array, CASE_LOWER);
            if (!empty($sql_search_table) AND !array_key_exists($sql_search_table, $table_array)) {
            	$sql_search_table = null;
            } // if
        } else {
            $table_array = array();
        } // if

        // convert $where string to an array
        $array1 = where2indexedArray($where);

        if ($array1[key($array1)] == '(' AND end($array1) == ')') {
        	// array begins with '(' and ends with ')', but does it have right number of 'OR's?
        	$count = array_count_values($array1);
            if (isset($count['OR']) AND $count['('] == $count[')'] AND $count['OR'] == $count['(']-1) {
                // set $array2 to hold multiple rows
            	$array2 = splitWhereByRow($array1);
            } else {
                // set $array2 to hold a single row
                $array2[] = $where;
            } // if
            unset($count);
        } else {
            // set $array2 to hold a single row
            $array2[] = $where;
        } // if

        $pattern1 = <<< END_OF_REGEX
/
^
(                            # start choice
 NOT[ ]+[a-zA-Z_]+           # 'NOT <something>'
 |                           # or
 [a-zA-Z_]+                  # '<something>'
)                            # end choice
[ ]*                         # 0 or more spaces
\(                           # begins with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # any characters
 )                           # end choice
\)                           # end with ')'
/xis
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^
\(.+\)                       # '(...)'
[ ]*                         # 0 or more spaces
(<>|<=|<|>=|>|!=|=|IN|NOT IN|BETWEEN)       # comparison operators
[ ]*                         # 0 or more spaces
.+                           # any characters
/xis
END_OF_REGEX;

        $pattern3 = <<< END_OF_REGEX
/
^
(                           # start choice
 \w+(\.\w+)?                # word [.word]
 |                          # or
 \([^\(\)]*\)               # '(...)'
)                           # end choice
[ ]*                        # 0 or more spaces
(<>|<=|<|>=|>|!=|=)         # comparison operators
[ ]*                        # 0 or more spaces
(ANY|ALL|SOME)?             # 'ANY' or 'ALL' or 'SOME' (0 or 1 times)
[ ]*                        # 0 or more spaces
\(                          # starts with '('
 (                          # start choice
  \([^\(\)]*\)              # '(...)'
  |                         # or
  '(([^\\\']*(\\\.)?)*)'    # quoted string
  |                         # or
  .*?                       # anything else
 )                          # end choice
 +                          # 1 or more times
\)                          # end with ')'
/xis
END_OF_REGEX;

        foreach ($array2 as $rownum => $rowdata) {
            $array3 = where2indexedArray($rowdata);
            foreach ($array3 as $ix => $string) {
                $string = trim($string);
                if (preg_match('/^(AND|OR)$/i', $string, $regs)) {
                    // put back with leading and trailing spaces
                    $array3[$ix] = ' '.strtoupper($regs[0]) .' ';
                } elseif ($string == '(') {
                    // do not modify
                } elseif ($string == ')') {
                    // do not modify
                } elseif (preg_match($pattern1, $string)) {
                    // format is: 'func(...)', so do not modify
                    $result = 'pattern1';
                } elseif (preg_match($pattern2, $string)) {
                    // format is: '(....)=...', so do not modify
                    $result = 'pattern2';
                } elseif (preg_match($pattern3, $string)) {
                    // format: 'col = [ANY,ALL,SOME] (...)', so do not modify
                    $result = 'pattern3';
                } elseif (substr($string, 0, 1) == '(' AND substr($string, -1, 1) == ')') {
                    // begins with '(' and ends with ')', so do not modfy
                } else {
            	    // split element into its component parts
            		list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
                    if (preg_match("/^\(.*\)$/i", $fieldname)) {
                        // fieldname begins with '(' and ends with ')', so leave it alone
                    } elseif (preg_match("/^'.*'$/i", $fieldname)) {
                        // fieldname is a quoted string, so leave it alone
                    } else {
            		    $array4 = array();
            		    $array4[$fieldname] = "{$operator} {$fieldvalue}";
            		    $array5 = qualifyField ($array4, $tablename, $fieldspec, $table_array, $sql_search_table, $select_alias, $having_array);
                        if (empty($array5)) {
                            unset($array3[$ix]);  // remove this entry
                        } else {
                            $key = key($array5);
                            $array3[$ix] = $key.$array5[$key];
                        } // if
                    } // if
                } // if
            } // foreach
            // remove any stray 'AND/OR' separators from the array
            $array3 = removeStrayAndOrs($array3);
            // convert array back into a string for a single row
            $where1 = implode('', $array3);
            if (!empty($where1)) {
                $array2[$rownum] = $where1;
            } else {
                unset($array2[$rownum]);
            } // if
        } // foreach

        // convert strings for multiple rows into '(row1) OR (row2) OR (row3) ....'
        $where = array2where2($array2);

        return $where;

    } // qualifyWhere
} // if

// ****************************************************************************
if (!function_exists('rangeFromTo')) {
    function rangeFromTo ($from, $to, $is_date=false)
    // if FROM and TO values exist then set FIELD to 'BETWEEN $from AND $to'.
    // IS_DATE is TRUE for date fields, FALSE for other fields
    {
        $field = null;
        $from = trim($from);
        $to   = trim($to);

        $pattern = <<<EOP
/
(?P<date>[0-9]{4}-[0-9]{2}-[0-9]{2})?     # YYYY-MM-DD (0 or 1 times)
(?P<time>[0-9]{2}:[0-9]{2}(:[0-9]{2})?)?  # HH:MM[:SS] (0 or 1 times)
/imsx
EOP;

        $search  = "/[^\d\.: -]/u";  // strip anything except digits, hyphens, colons, periods and spaces
        $replace = null;

        if (strlen($from) > 0) {
            $from = preg_replace($search, $replace, $from);
            if ($is_date) {
                preg_match_all($pattern, $from, $regs);
                if (empty($regs['date'])) {
                    return $field;  // there is no date, so this is invalid
                } // if
                foreach ($regs['date'] as $from_date) {
                    if (!empty($from_date)) break;
                } // foreach
                if (!empty($regs['time'])) {
                    foreach ($regs['time'] as $from_time) {
                        if (!empty($from_time)) break;
                    } // foreach
                } // if
                if (empty($from_time)) {
                    $from_time = '00:00:00';  // not supplied, so use earliest possible time
                } // if
                $from = $from_date.' '.$from_time;
            } // if
        } // if

        if (strlen($to) > 0) {
            $to = preg_replace($search, $replace, $to);
            if ($is_date) {
                preg_match_all($pattern, $to, $regs);
                foreach ($regs['date'] as $to_date) {
                    if (!empty($to_date)) break;
                } // foreach
                if (empty($to_date)) $to_date = $from_date;  // default to FROM_DATE
                if (!empty($regs['time'])) {
                    foreach ($regs['time'] as $to_time) {
                        if (!empty($to_time)) break;
                    } // foreach
                } // if
                if (empty($to_time)) {
                    $to_time = '23:59:59';  // not supplied, so use latest possible time
                } // if
                $to = $to_date.' '.$to_time;
            } // if
        } // if

        if (!empty($from)) {
            if (!empty($to)) {
                if ($from == $to) {
                    $field = "= '$from'";  // values are the same, so use '='
                } else {
                    $field = "BETWEEN '$from' AND '$to'";
                } // if
            } else {
                $field = ">= '$from'";
            } // if
        } elseif (!empty($to)) {
            $field = "<= '$to'";
        } // if

        return $field;

    } // rangeFromTo
} // if

// ****************************************************************************
if (!function_exists('removeBOM')) {
    function removeBOM($string="")
    // remove Byte Order Mark from a UTF8 string
    {
        if(substr($string, 0,3) == pack("CCC",0xef,0xbb,0xbf)) {
            $string=substr($string, 3);
        }  // if
        return $string;
    } // removeBOM
} // if

// ****************************************************************************
if (!function_exists('removeTimeFromDateTime')) {
    function removeTimeFromDateTime($datetime)
    // remove the TIME portion from a DATETIME string.
    {
        $datetime = trim($datetime);

        // look for a time portion (ends with '99:99' or '99:99:99')
        if (preg_match('/([0-9]{2}:[0-9]{2}){1}(:[0-9]{2})?$/', $datetime, $regs)) {
            $time = $regs[0];
            $date = substr($datetime, 0, -strlen($time));
        } else {
            $date = $datetime;
            $time = null;
        } // if

        return $date;

    } // removeTimeFromDateTime
} // if

// ****************************************************************************
if (!function_exists('removeDuplicateFromSelect')) {
    function removeDuplicateFromSelect ($sql_select)
    // remove duplicated field names from the select string.
    {
        $select_array     = extractFieldNamesAssoc($sql_select);
        $expression_array = extractAliasNames($sql_select);  // alias = epression

        $select_keys = array_keys($select_array);   // array of field names, which may be qualified
        $select_keys_unq = $select_keys;            // array of field names, which will be unqualified

        foreach ($select_array as $alias => $original) {
            if ($alias == $original) {
                $key1 = array_search($alias, $select_keys);
                if ($substring = strrchr($alias, '.')) {
                    $alias = ltrim($substring, '.');    // contains 'table.field', so remove the tablename
                    // see if this unqualified name already exists in the array
                    $key2 = array_search($alias, $select_keys_unq);
                    if ($key2 === false) {
                        // not found
                    } else {
                        $qname = $select_keys[$key2];   // found, so find the qualified name
                        unset($select_array[$qname]);   // remove it from $select_array
                    } // if
                    $select_keys_unq[$key1] = $alias;   // replace qualified name with unqualified version
                } // if
                if (array_key_exists($alias, $expression_array)) {
                    // fieldname exists as an expression, so remove fieldname
                    unset($select_array[$alias]);
                } // if
            } // if
        } // foreach

        // rebuild SELECT string using amended array
        $sql_select = '';
        foreach ($select_array as $alias => $original) {
        	if (!empty($sql_select)) {
        		$sql_select .= ', ';
        	} // if
        	if ($alias == $original) {
        		$sql_select .= $original;
        	} else {
        	    $sql_select .= $original .' AS ' .$alias;
        	} // if
        } // foreach

        return $sql_select;

    } // removeDuplicateFromSelect
} // if

// ****************************************************************************
if (!function_exists('removeDuplicateNameFromSelect')) {
    function removeDuplicateNameFromSelect ($select_array, $name)
    // if $name exists in $select_array (from sql_select) then remove it
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

    } // removeDuplicateNameFromSelect
} // if

// ****************************************************************************
if (!function_exists('remove_directory')) {
    function remove_directory ($directory)
    // remove/delete the specified directory.
    {
        if (empty($directory) OR !is_dir($directory)) {
            return FALSE;
        } // if

        $iterator = new DirectoryIterator ( $directory );
        foreach ( $iterator as $info ) {
            if ($info->isDot ()) {
                // do nothing
            } elseif ($info->isFile ()) {
                $res = unlink($info->getPathname());
            } elseif ($info->isDir ()) {
                // remove subdirectory
                $res = remove_directory ($info->getPathname());
            } // if
        } // foreach

        $res = rmdir($directory);

        return $res;

    } // remove_directory
} // if

// ****************************************************************************
if (!function_exists('reduceOrderBy')) {
    function reduceOrderBy ($orderby)
    // reduce 'table.column1, table.column2, ...' to 'column1'
    {
        if (preg_match('/,/', $orderby)) {
            // convert from 'column,column' to just 'column'
            list($column) = preg_split('/,/', $orderby);
            $orderby = $column;
        } // if
        if (preg_match('/\./', $orderby)) {
            // convert from 'table.column' to just 'column'
            list($table, $column) = preg_split('/\./', $orderby);
            // remove any trailing ASCENDING/DESCENDING
            $pattern = '/( asc| ascending| desc| descending)$/i';
            if (preg_match($pattern, $column, $regs)) {
                $column = substr_replace($column, '', -strlen($regs[0]));
            } // if
            $orderby = $column;
        } // if

        return $orderby;

    } // reduceOrderBy
} // if

// ****************************************************************************
if (!function_exists('removeStrayAndOrs')) {
    function removeStrayAndOrs ($array, $size=null)
    // remove stray 'AND' or 'OR' separators from an array
    {
        // remove any stray 'AND/OR' separators from the array
        $separator_allowed = false;
        $opening_paren_ix  = null;  // index to last opening parenthesis
        reset($array);
        foreach ($array as $ix => $value) {
            $value = trim($value);
            if (empty($value)) {
                unset($array[$ix]);
            } else {
                if (preg_match('/^(AND|OR)$/i', trim($value))) {
                    if ($separator_allowed) {
                        // this is allowed, but any more are not
                        $separator_allowed = false;
                    } else {
                        unset($array[$ix]);
                    } // if
                } else {
                    if (preg_match('/^\($/i', trim($value))) {
                        // this is an opening parenthesis, so a separator cannot follow
                        $separator_allowed = false;
                        $opening_paren_ix  = $ix;
                    } elseif (preg_match('/^\)$/i', trim($value))) {
                        if (!is_null($opening_paren_ix)) {
                            // we have a pair of parentheses with nothing in between, so remove them both
                            unset($array[$opening_paren_ix]);
                            unset($array[$ix]);
                            $separator_allowed = true;
                        } // if
                    } else {
                        // this is not a separator, but one is allowed to follow
                        $separator_allowed = true;
                        $opening_paren_ix  = null;
                    } // if
                } // if
            } // if
        } // foreach
        $test = array_pop($array);
        if (preg_match('/^(AND|OR)$/i', trim($test))) {
            // cannot terminate with a separator
        } else {
            // this is not a separator, so put it back
            $array[] = $test;
        } // if

        if (is_null($size)) {
            // repeat until nothing else is removed
            do {
                $size1  = count($array);
                $array2 = removeStrayAndOrs ($array, $size1);
                $size2  = count($array2);
                if ($size1 == $size2) {
                    // nothing else removed, so stop
                    break;
                } else {
                    $array = $array2;
                } // if
            } while (0);
        } // if

        return $array;

    } // removeStrayAndOrs
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
                    $headings[$col][$fieldname] = $replace_array[$fieldname];
                } // if
            } // foreach
        } // foreach

        $screen_structure[$zone]['fields'] = $headings;

        return TRUE;

    } // replaceScreenHeadings
} // if

// ****************************************************************************
if (!function_exists('replaceScreenLabels')) {
    function replaceScreenLabels ($replace_array, $zone='main')
    // replace column labels in vertical section of current screen structure.
    // $replace_array is associative in format 'field => label'
    {
        global $screen_structure;

        if (!array_key_exists('fields', $screen_structure[$zone])) {
            return FALSE;
        } // if

        $labels = $screen_structure[$zone]['fields'];

        foreach ($labels as $row => $elements) {
            if (is_array($elements)) {
                foreach ($elements as $ix => $element) {
                    if (is_array($element) AND array_key_exists('field', $element)) {
                        if (array_key_exists($element['field'], $replace_array)) {
                            // the 'label' entry may be either before or after the 'field' entry
                            $prev = $ix-1;
                            $next = $ix+1;
                            if (array_key_exists('label', $elements[$prev])) {
                                $labels[$row][$prev]['label'] = $replace_array[$element['field']];
                            } elseif (array_key_exists('label', $elements[$next])) {
                                $labels[$row][$next]['label'] = $replace_array[$element['field']];
                            } // if
                        } // if
                    } elseif (is_string($element)) {
                        // $ix = column name, $element = column label
                        if (array_key_exists($ix, $replace_array) ) {
                            $labels[$row][$ix] = $replace_array[$ix];
                        } // if
                    } // if
                } // foreach
            } // if
        } // foreach

        $screen_structure[$zone]['fields'] = $labels;

        return TRUE;

    } // replaceScreenLabels
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
    function resizeImage ($source, $destination, $to_width, $to_height, $stretch_to_fit=true)
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

        $to_width  = (int)$to_width;
        $to_height = (int)$to_height;
        if ($to_width <= 0 OR $to_height <= 0) {
            // "Cannot resize image - dimensions are invalid"
        	return getLanguageText('sys0138', $to_width, $to_height);
        } // if

        // get dimensions (and other info) of source image
        $dim = GetImageSize($source);
        $orig_w = $dim[0];
        $orig_h = $dim[1];

        // build dimensions of destination image
        // NOTE: the dimensions of the original image will be maintained,
        // which may cause blank areas in the new image

        //$stretch_to_fit = false;
        //$to_width = $to_width*1.5;

        if ($stretch_to_fit == true) {
            // if either the new width or height is too small, then stretch the image to fit.
            $offset_x = 0;
            $offset_y = 0;
        } else {
            // if either the new width or height is too small, then ...
            // create an image with the proper dimensions and fill the extra with blank space.
            $ratio_w = $orig_w / $to_width;
            $ratio_h = $orig_h / $to_height;
            if ($ratio_w < $ratio_h) {
                $offset_y    = 0;
                $true_height = $to_height;
                // new size is wider, so calculate difference
                $true_width = $orig_w / $ratio_h;
                $diff_width = $to_width - $true_width;
                if ($diff_width < 2) {
                    $diff_width = 0;
                } // if
                $offset_x = $diff_width;

            } elseif ($ratio_w < $ratio_h) {
                $offset_x    = 0;
                $true_width = $to_width;
                // new size is taller, so calculate difference
                $true_height = $orig_h / $ratio_w;
                $diff_height = $to_height - $true_height;
                if ($diff_height < 2) {
                    $diff_height = 0;
                } // if
                $offset_y = $diff_height;
            } else {
                // ratios are the same, so no borders needed
                $true_width  = $to_width;
                $true_height = $to_height;
                $offset_x = 0;
                $offset_y = 0;
            } // if
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
    	$thumb = imagecreatetruecolor($to_width, $to_height);
    	// set background to white, full transparency
    	imagesavealpha($thumb, true);
    	$bgc = imagecolorallocatealpha($thumb, 255, 255, 255, 127);
    	imagefill($thumb, 0, 0, $bgc);
        // copy 'old' image to the 'new' image, with adjusted dimensions
    	imagecopyresampled($thumb, $from, $offset_x, $offset_y, 0, 0, $to_width, $to_height, $orig_w, $orig_h);

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
     	    $msg = getLanguageText('sys0126', $destination ." ($to_width x $to_height)");
     	    if (!preg_match('/^WIN/i', PHP_OS)) {
            	$result = chmod($uploadfile, 0664);
            } // if
    	} else {
    	    // "Image NOT resized"
    	    $msg = getLanguageText('sys0139', $to_width, $to_height);
    	} // if

    	ImageDestroy($from);
    	ImageDestroy($thumb);

        return $msg;

    } // resizeImage
} // if

// ****************************************************************************
if (!function_exists('return_bytes')) {
    function return_bytes ($value)
    // convert a shorthand value such a 1K, 1M, 1G into an integer.
    // used to change the output of "ini_get('memory_limit')"
    {
    	$value = trim($value);
	    $last = strtoupper($value[strlen($value)-1]);
    	switch($last) {
            case 'T':
                $value *= 1024;
            // The 'G' modifier is available since PHP 5.1.0
            case 'G':
                $value *= 1024;
            case 'M':
                $value *= 1024;
            case 'K':
                $value *= 1024;
        } // switch

        return $value;

    } // return_bytes
} // if

// ****************************************************************************
if (!function_exists('selectAllColumns')) {
    function selectAllColumns ($sql_select, $fieldspec, $tablename)
    // replace '*' (all columns) with a list of columns names for the specifiedl table.
    // $fieldspec identifies the column names.
    // $tablename identifies the table name (which may be an alias)
    {
        $pattern = <<< END_OF_REGEX
/
(                       # start choice
(?P<count>\(\*\))       # '(*)', named pattern
|                       # or
^\*                     # begins with '*'
|                       # or
\w+\.\*                 # contains 'tablename.*'
)                       # end choice
/xism
END_OF_REGEX;

        if (!preg_match($pattern, $sql_select, $regs, PREG_OFFSET_CAPTURE)) {
            return $sql_select;  // nothing to change
        } // if

        if (isset($regs['count'])) {
            return $sql_select;  // found 'COUNT (*)' so ignore it
        } // if

        $found  = $regs[0][0];
        $offset = $regs[0][1];
        $namearray = explode('.', $found);
        if (count($namearray) > 0) {
            // $namearray[0] contains a table name
        } // if

        $fieldnames = array_keys($fieldspec);
        foreach ($fieldnames as &$fieldname) {
            $fieldname = $tablename.'.'.$fieldname;  // qualify each field with the tablename
        } // foreach
        reset($fieldnames);

        // build string of column name from $fieldspec
        $list = implode(', ', $fieldnames);

        $sql_select = substr_replace($sql_select, $list, $offset, strlen($found));

        return $sql_select;

    } // selectAllColumns
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
                    if (is_null($fieldvalue)) {
                    	$fieldvalue = ' IS NULL';
                    } else {
                        $fieldvalue = "='".addslashes($fieldvalue)."'";
                    } // if
                    if (empty($where2)) {
                        $where2 = "$fieldname$fieldvalue";
                    } else {
                        $where2 .= " AND $fieldname$fieldvalue";
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
                if (is_null($fieldvalue)) {
                	$fieldvalue = ' IS NULL';
                } else {
                    $fieldvalue = "='".addslashes($fieldvalue)."'";
                } // if
                if (empty($where)) {
                    $where = "$fieldname$fieldvalue";
                } else {
                    $where .= " AND $fieldname$fieldvalue";
                } // if
            } // foreach
        } // if

        return $where;

    } // selection2where
} // if

// ****************************************************************************
if (!function_exists('send_email')) {
    function send_email ($from, $to, $subject, $msg, $attachments=null, $extra_headers=null)
    // send an email, with optional attachments.
    // NOTE: format can be either 'T' (plain text) or 'H' (HTML)
    {
        $msg = str_replace("\r\n", "\n", $msg);

        $message_id = date('YmdHis').uniqid().'@'.$_SERVER['HTTP_HOST'];

        if (!empty($attachments)) {
        	if (is_string(key($attachments))) {
        	    // turn this into an indexed array
            	$attachments = array($attachments);
            } // if
        } // if

        if (defined('MAIL_FROM_OVERRIDE')) {
            $from = MAIL_FROM_OVERRIDE;
        } // if
        if (defined('MAIL_TO_REDIRECT')) {
            $to = MAIL_TO_REDIRECT;
        } // if

        if (defined('USE_SWIFTMAILER')) {
            require_once('include.swiftmailer.inc');
            require('SwiftMailer/swift_required.php');
            $message = Swift_Message::newInstance();
            $message->setSubject($subject);
            $from = SWIFT_email_address2array($from);
            $message->setFrom($from);
            $to = SWIFT_email_address2array($to);
            $message->setTo($to);
            if (defined('MAIL_RETURN_PATH')) {
                $message->setReturnPath(MAIL_RETURN_PATH);
            } // if

            if (preg_match('/^<\?xml/i', trim($msg))) {
                // this is an XML file, so send as plain text
                $message->setBody($msg, 'text/plain');
            } elseif (preg_match('/^<(.+)>$/is', trim($msg))) {
                // this is an HTML message, so send a plain text version as well
                $message->setBody( html2text($msg), 'text/plain');
                $message->addPart($msg, 'text/html');
            } else {
                $message->setBody($msg, 'text/plain');
            } // if

            //$attachments[] = array('filename' => 'file1.txt', 'filebody' => html2text($msg));  // TEST
            //$attachments[] = array('filename' => 'file2.txt', 'filebody' => html2text($msg));  // TEST

            if (!empty($attachments)) {
                foreach ($attachments as $ix => $attachment) {
                    $filename = trim($attachment['filename']);
                    if (!empty($attachment['filepath'])) {
                        $filepath = trim($attachment['filepath']);
                        $filebody = file_get_contents($filepath);
                    } else {
                        $filebody = $attachment['filebody'];
                    } // if
                    $mime_type = 'application/octet-stream';
                    $attachment = Swift_Attachment::newInstance($filebody, $filename, $mime_type);
                    $message->attach($attachment);
                } // foreach
            } // if

            $headers = $message->getHeaders();
            $headers->removeAll('Message-ID');
            $headers->addIdHeader('Message-ID', $message_id);
            if (!empty($extra_headers)) {
                foreach ($extra_headers as $extra_header) {
                    list($key, $value) = explode(':', $extra_header, 2);
                    if (preg_match('/^Reply-To/i', $key)) {
                        $value = SWIFT_email_address2array($value);
                        $message->setReplyTo($value);
                    } else {
                        $headers->addIdHeader($key, trim($value));
                    } // if
                } // foreach
            } // if
            $stuff = $headers->toString();

            if (defined('SWIFTMAILER_CONFIG')) {
                require(SWIFTMAILER_CONFIG);
                if (strtolower($transport) == 'smtp') {
                    $transport = Swift_SmtpTransport::newInstance($server_id, $port);
                    if (!empty($username)) {
                        // with authentication option
                        $transport->setUsername($username);
                        if (!empty($username)) {
                            $transport->setPassword($password);
                        } // if
                    } // if
                    if (!empty($encryption)) {
                        // with authentication option
                        $transport->setEncryption($encryption);
                    } // if
                } // if
            } else {
                // default
                $transport = Swift_MailTransport::newInstance();
            } // if

            $mailer = Swift_Mailer::newInstance($transport);
            $failures = array();
            $result = $mailer->send($message, $failures);

            if (!empty($failures)) {
                $string = implode(',', $failures);
                trigger_error("COULD NOT DELIVER EMAIL TO THE FOLLOWING RECIPIENTS: $string", E_USER_ERROR);
            } // if

            if ($result) {
                return $message_id;
            } else {
                return FALSE;
            } // if
        } // if

        // ALTERNATIVE TO SWIFTMAILER

        $parameters = '';
        $headers    = '';
        $headers .= "Message-ID: <$message_id>"."\n";
        $headers .= "Date: ".date('r')."\n";
        $headers .= "From: $from"."\n";
        if (!empty($extra_headers)) {
            foreach ($extra_headers as $extra_header) {
                $headers .= $extra_header."\n";
            } // foreach
        } // if

        //$attachments[] = array('filename' => 'file1.txt', 'filebody' => html2text($msg));  // TEST
        //$attachments[] = array('filename' => 'file2.txt', 'filebody' => html2text($msg));  // TEST
        //$msg = "Hello,\n\nThis is a plain text message.\n\nI hope you like it.";

        if (preg_match('/^<\?xml/i', trim($msg))) {
            // this is an XML file, so send as plain text
            $format = 'T';
        } elseif (preg_match('/^<(.+)>$/is', trim($msg))) {
            // message contains HTML tags
            $format = 'H';
        } else {
            $format = 'T';
        } // if

        $message = "";

        if (!empty($attachments) OR $format == 'H') {
            $headers .= "MIME-Version: 1.0\n";
            // Generate boundary strings
            $semi_rand = md5(time());
            $mult_boundary = "__Multipart_Boundary_x{$semi_rand}x__";
            $alt_boundary  = "__Alternative_Boundary_x{$semi_rand}x__";
        } // if

        if (!empty($attachments)) {
            $headers .= "Content-Type: multipart/mixed; boundary=\"{$mult_boundary}\""."\n";
            $message .= "\n--{$mult_boundary}\n";
        } // if

        if ($format == 'H') {
            if (empty($message)) {
                $headers .= "Content-Type: multipart/alternative; boundary=\"{$alt_boundary}\""."\n\n";
            } else {
                $message .= "Content-Type: multipart/alternative; boundary=\"{$alt_boundary}\""."\n\n";
            } // if
        } // if

        // message may be plain text, or HTML with plain text version
        if ($format == 'H') {
            // here is the plain text version
            $message .= "\n--{$alt_boundary}\n";
            $message .= "Content-Type: text/plain; charset=utf-8\n";
            $message .= "Content-Transfer-Encoding: 7bit\n\n";
            $message .= html2text($msg) ."\n";
            // here is the HTML version
            $message .= "\n--{$alt_boundary}\n";
            $message .= "Content-Type: text/html; charset=utf-8\n";
            $message .= "Content-Transfer-Encoding: 7bit\n\n";
            $message .= $msg."\n";
            // here is the closing boundary
            $message .= "\n--{$alt_boundary}--\n";
        } else {
            // plain text without any HTML version
            if (empty($mult_boundary)) {
                $headers .= "MIME-Version: 1.0\n";
                $headers .= "Content-Type: text/plain; charset=utf-8\n";
                $headers .= "Content-Transfer-Encoding: 7bit\n\n";
            } else {
                $message .= "Content-Type: text/plain; charset=utf-8\n";
                $message .= "Content-Transfer-Encoding: 7bit\n\n";
                //$message .= "\n\n--{$mult_boundary}\n";
            } // if
            $message .= $msg."\n";
        } // if

        if (!empty($attachments)) {
            foreach ($attachments as $ix => $attachment) {
                $filename = trim($attachment['filename']);
                if (!empty($attachment['filepath'])) {
                	$filepath = trim($attachment['filepath']);
                	$filebody = file_get_contents($filepath);
                } else {
                    $filebody = $attachment['filebody'];
                } // if
                // Add file attachment to the message
                $message .= "\n\n--{$mult_boundary}\n";
                $message .= "Content-Type: application/octet-stream; name=\"$filename\"\n";
                $message .= "Content-Disposition: attachment; filename=\"$filename\"\n";
                $message .= "Content-Transfer-Encoding: base64\n\n";
                // format $data using RFC 2045 semantics
                $message .= chunk_split(base64_encode($filebody));
                $filebody = null;
            } // foreach
            // here is the closing boundary
            $message .= "\n--{$mult_boundary}--\n";
        } // if

        if (defined('MAIL_RETURN_PATH')) {
            if (MAIL_RETURN_PATH != 'NONE') {
                // use hard-coded address
        	    $parameters = '-f' .MAIL_RETURN_PATH;
            } // if
        } else {
            $pattern = "/(?<=<)(.)+(?=>)/";
            if (preg_match($pattern, $from, $regs)) {
                // extract 'foo@bar.com' from "foobar <foo@bar.com>"
                $parameters = '-f' .$regs[0];
            } else{
                // use complete FROM address
                $parameters = '-f' .$from;
            } // if
        } // if

        if (preg_match('/^(UTF-8|UTF8)$/i', mb_detect_encoding($subject))) {
            // I don't know why this is necessary, but it works!
            $subject = convertEncoding($subject, 'iso-8859-1', 'UTF-8');
            $subject = convertEncoding($subject, 'UTF-8', 'iso-8859-1');
        } // if

        // now send it
        $result = mail($to, $subject, $message, $headers, $parameters);

        if (!$result) {
        	return false;
        } // if

        // return the message-id to identify this outgoing email
        return $message_id;

    } // send_email
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
                                if (preg_match('/(width|align)/i', $attr_name)) {
                                    $screen_structure[$zone]['columns'][$col][$attr_name] = $attr_value;
                                } else {
                			        $screen_structure[$zone]['fields'][$col][$attr_name] = $attr_value;
                                } // if
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
        $handler =& RDCsingleton::getInstance('php_session');
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
        $pattern1 = <<< END_OF_REGEX
~
^                            # begins with
[ ]*                         # 0 or more spaces
(                            # start choice - fieldname
 \w+                         # word(...)
 [ ]*                        # 0 or more spaces
 \(                          # '(' followed by
 (?>                         # start atomic group
  (                          # start choice
   [\w ,\./*:+-]             # word or ',. /*:+-'
   |                         # or
   \(\)                      # ()
   |                         # or
   \(\w+\)                   # (word)
   |                         # or
   '(([^\\\']*(\\\.)?)*)'    # quoted string
  )                          # end choice
 )                           # end atomic group
 ++                          # 1 or more times (possessive quantifier)
 \)                          # ending with ')'
|                            # or
 \w+(\.\w+)?                 # word [.word]
|                            # or
 \([^\(\)]*\)                # '(...)'
|                            # or
 '(([^\\\']*(\\\.)?)*)'      # quoted string
|                            # or
\(CASE[ ]+                   # '(CASE '
)                            # end choice
~xi
END_OF_REGEX;

        $pattern2a = <<< END_OF_REGEX
/
^                      # begins with
[ ]*                   # 0 or more spaces
(&|~|\^|<<|>>|\|)      # bitwise operators
[ ]*                   # 0 or more spaces
[0-9]+                 # 1 or more digits
[ ]*                   # 0 or more spaces
(<>|<=|<|>=|>|!=|=)    # comparison operators
/xi
END_OF_REGEX;

        $pattern2b = <<< END_OF_REGEX
/
^                            # begins with
[ ]*                         # 0 or more spaces
(                            # start choice - operator
 <>|<=|<|>=|>|!=|=           # comparison operators
 |                           # or
 NOT[ ]+LIKE|LIKE            # [NOT] LIKE
 |                           # or
 NOT[ ]+RLIKE|RLIKE          # [NOT] RLIKE
 |                           # or
 NOT[ ]+REGEXP|REGEXP        # [NOT] REGEXP
 |                           # or
 NOT[ ]+IN|IN                # [NOT] IN
 |                           # or
 NOT[ ]+BETWEEN|BETWEEN      # [NOT] BETWEEN
 |                           # or
 IS[ ]+NOT|IS                # IS [NOT]
 |                           # or
 (-|\+)                      # '-' or '+'
 [ ]*                        # 0 or more spaces
 (\w+(\.\w+)?[ ]*)+          # word [.word] 1 or more times
 (<>|<=|<|>=|>|!=|=)         # comparison operators
)                            # end choice
/xi
END_OF_REGEX;

        $pattern3a = <<< END_OF_REGEX
/
^                               # begins with
[ ]*                            # 0 or more spaces
(                               # start choice - operator
  '(([^\\\']*(\\\.)?)*)'        # quoted string
  |                             # or
  [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
)                               # end choice
 [ ]*AND[ ]*                    # 'AND'
(                               # start choice
  '(([^\\\']*(\\\.)?)*)'        # quoted string
  |                             # or
  [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
)                               # end choice
/xi
END_OF_REGEX;

        $pattern3b = <<< END_OF_REGEX
/
^                            # begins with
[ ]*                         # 0 or more spaces
\(                           # begins with '('
/xi
END_OF_REGEX;

        $pattern3c = <<< END_OF_REGEX
/
^                              # begins with
[ ]*                           # 0 or more spaces
(                              # start choice - operator
 '(([^\\\']*(\\\.)?)*)'        # quoted string
 |                             # or
 [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
 |                             # or
 NULL                          # NULL
)                              # end choice
/xis
END_OF_REGEX;

        // extract 'name' from 'name|operator|value'
        $result = preg_match($pattern1, $where, $regs);
        if (empty($regs)) {
            $fieldname = null;
        } else {
        	$fieldname = $regs[0];
            $where = substr($where, strlen($fieldname));    // remove name from string

            if (substr($fieldname, 0, 1) == '(' AND substr($fieldname, -1, 1) == ')') {
                // string begins with '(' and ends with ')', so leave it alone
            } elseif (preg_match('/^\(?[ ]*(\bCASE\b)/i', $fieldname , $regs)) {
                // full expression is '(CASE ... END) operator value'
                $fieldname .= findClosingEnd($where);  // extract '(CASE ... END)'
                if (substr($regs[0], 0, 1) == '(') {
                    $fieldname .= ')';  // begins with '(' so must end with ')'
                    if (substr($where, 0, 1) == ')') {
                        $where = substr($where, 1);  // remove leading ')'
                    } // if
                } // if
            } else {
                $fieldname = strtolower($fieldname);
                if (preg_match('/(NOT[ ]+EXISTS|EXISTS)/i', $fieldname)) {
            	    // expression is 'EXISTS (SELECT ....), so cannot be split
            	    $where = null;
            	    return array(null, null, null);
                } // if

                if (is_numeric($fieldname) AND $fieldname == (int)$fieldname) {
                    // convert this into a quoted string so that it does not get confused with an index in array2where()
            	    $fieldname = "'$fieldname'";
                } // if
            } // if
        } // if

        // extract 'operator' from 'name|operator|value'
        $result = preg_match($pattern2a, $where, $regs);  // look for bitwise operators
        if (!$result) {
            $result = preg_match($pattern2b, $where, $regs);  // look for other operators
        } // if
        if (!$result) {
            $operator = null;
        } else {
            $operator = $regs[0];
            $where = substr($where, strlen($operator));     // remove operator from string

            $operator = trim(strtoupper($operator));
            if (preg_match('/[a-zA-Z_]+[ ]*[a-zA-Z_]*/', trim($operator))) {
            	$operator = " {$operator} ";  // operator is alphabetic, so enclose in spaces
            } // if
        } // if

        // extract 'value' from 'name|operator|value'
        if       ($result = preg_match($pattern3b, $where, $regs)) {
            // begins with '(', so look for matching ')'
            $fieldvalue = $regs[0];
        	$where = substr($where, strlen($regs[0]));   // remove value from string
            $fieldvalue .= findClosingParenthesis($where);

        } elseif ($result = preg_match($pattern3a, $where, $regs)) {
            // format: '...' AND '...' or 'ddd AND ddd'
        	$fieldvalue = $regs[0];
        	$where = substr($where, strlen($regs[0]));   // remove value from string

        } elseif ($result = preg_match($pattern3c, $where, $regs)) {
            // format: quoted string or digits or NULL
        	$fieldvalue = $regs[0];
        	$where = substr($where, strlen($regs[0]));   // remove value from string

        } else {
            // whoops! nothing found, so use remainder of string
            $fieldvalue = $where;
            $where = null;
        } // if

        // return all three elements in the output array
        return array(trim($fieldname), $operator, trim($fieldvalue));

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

        $array2       = array();
        $array_out    = array();
        $paren_count  = 0;  // parentheses count: '('= +1, ')'= -1
        $paren_string = '';
        $string2      = '';
        foreach ($array1 as $key => $string) {
            if ($paren_count > 0) {
            	// parenthesised string has not yet been closed, so append to it
            	if (preg_match('/^(AND|OR)$/i', $string)) {
            	    $string = strtoupper($string);
            		$paren_string .= " $string ";
            	} else {
            	    $paren_string .= $string;
            	} // if
            	if ($string == '(') {
                	$paren_count++;  // '(' encountered, so increment count

                } elseif ($string == ')') {
                    $paren_count--;  // ')' encountered, so decrement count
                    $string = null;
                    $paren_string = substr($paren_string, 1);      // strip leading '('
                    $paren_string = substr($paren_string, 0, -1);  // strip trailing ')'
                } // if

                if ($paren_count <= 0) {
                	// closing parenthesis found, so output this string
                	$array_out[]  = $paren_string;
                	$paren_string = null;
                } // if

        	} elseif ($string == '(') {
        	    // start a string in parentheses - '( a='a', b='b', ... )'
        	    $paren_string .= $string;
        	    $paren_count++;

        	} else {
        	    // this part does not follow '(', so save it as a string
        	    $string2 .= $string .' ';

        	} // if

        } // foreach

        //if (!empty($string2)) {
        if (empty($array_out) AND !empty($string2)) {
            // use this string as a single row
        	$array_out[] = trim($string2);
        } // if

        return $array_out;

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
                if (!is_string($fieldname)) {
                	// this is not a field name, so ignore it
                } else {
                    $fieldvalue = stripOperators_ex($fieldvalue);
                    if (is_null($fieldvalue) OR empty($fieldvalue)) {
                    	$fieldarray[$fieldname] = $fieldvalue;
                    } else {
                        $fieldarray[$fieldname] = stripslashes($fieldvalue);
                    } // if
                } // if
            } // foreach
            return $fieldarray;
        } // if

        if (is_string($fieldarray)) {
            // no fieldname, so strip any operators from the value
            $fieldvalue = stripOperators_ex($fieldarray);
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
        list($operator, $value, $delimiter) = extractOperatorValue($input);

        if (preg_match('/^(null)$/i', $value)) {
            // change 'null' (string) into null value
        	$value = null;
        } // if

        return $value;

    } // stripOperators_ex
} // if

// ****************************************************************************
if (!function_exists('strip_quotes')) {
    function strip_quotes ($string)
    // strip any single or double quotes from a string
    {
        $string = str_replace(array("'", '"'), null, $string);

        return $string;

    } // strip_quotes
} // if

// ****************************************************************************
if (!function_exists('text2image')) {
    function text2image ($text, $fontheight=6, $bgcolour='#FFFF99', $textcolour='#FF0000')
    // convert a text string to an image
    {
        // calculate size of image needed to contain current text
        $fontH  = imagefontheight($fontheight);
        $fontW  = imagefontwidth($fontheight);
        $imageH = $fontH + 6;
        $imageW = (strlen($text) * $fontW) + 8;

        $image = @imagecreate ($imageW, $imageH)
            or trigger_error("Cannot Initialize new GD image stream", E_USER_ERROR);

        $background_color = makeColor($image, $bgcolour);
        if ($bgcolour == $textcolour) {
            $text_color = imagecolortransparent($image, $background_color);
            $text_color = $background_color;
        } else {
            $text_color = makeColor($image, $textcolour);
        } // if

        // insert text into image
        imagestring ($image, 5, 5, 3, $text, $text_color);

        return $image;

    } // text2image
} // if

// ****************************************************************************
if (!function_exists('timeDifference')) {
    function timeDifference ($datetime1, $datetime2)
    // calculate the difference between two date+times
    {
        if (version_compare(phpversion(), '5.3.0', '<')) {
            $time1 = strtotime($datetime1);
            $time2 = strtotime($datetime2);
            $diff = $time2 - $time1;
        } else {
            $datetime1 = new DateTime($datetime1);
            $datetime2 = new DateTime($datetime2);
            $interval = $datetime1->diff($datetime2);
            $diff = $interval->format('%R%s');
        } // if

        return (int)$diff;

    } // timeDifference
} // if

// ****************************************************************************
if (!function_exists('truncateNumber')) {
    function truncateNumber ($input, $decimal_places=2)
    // truncate a number after N decimal places.
    // This is the equivalent of rounding DOWN instead of UP.
    {
        if (strlen($input) == 0) return;

        $factor = $decimal_places * 10;

        $integer = $input * $factor;    // put number to the left of the decimal point
        $integer = floor($integer);     // drop all decimal places
        $output = $integer / $factor;   // put decimal point in correct place

        return $output;

    } // truncate
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
    function unqualifyWhere ($where, $tablename=null)
    // remove any table names from field names in 'where' string
    {
        // if $where is empty do nothing
        if (empty($where)) return;

        // convert $where string to an array
        $array1 = where2indexedArray($where);

        if ($array1[key($array1)] == '(' AND end($array1) == ')') {
        	// array begins with '(' and ends with ')', but does it have right number of 'OR's?
        	$count = array_count_values($array1);
            if ($count['('] == $count[')'] AND $count['OR'] == $count['(']-1) {
                // set $array2 to hold multiple rows
            	$array2 = splitWhereByRow($array1);
            } else {
                // set $array2 to hold a single row
                $array2[] = $where;
            } // if
            unset($count);
        } else {
            // set $array2 to hold a single row
            $array2[] = $where;
        } // if

        $pattern1 = <<< END_OF_REGEX
/
^
(                            # start choice
 NOT[ ]+[\w]+                # 'NOT <something>'
 |                           # or
 [\w]+                       # '<something>'
)                            # end choice
[ ]*                         # 0 or more spaces
\(                           # begins with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # any characters
 )                           # end choice
\)                           # end with ')'
/xis
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
/
^
\([^\(\)]*\)                 # '(...)'
[ ]*                         # 0 or more spaces
(<>|<=|<|>=|>|!=|=)          # comparison operators
[ ]*                         # 0 or more spaces
(ANY|ALL|SOME)?              # 'ANY' or 'ALL' or 'SOME' (0 or 1 times)
[ ]*                         # 0 or more spaces
\(                           # starts with '('
 (                           # start choice
  \([^\(\)]*\)               # '(...)'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
  |                          # or
  .*?                        # anything else

 )                           # end choice
 +                           # 1 or more times
 \)                          # end with ')'
/xis
END_OF_REGEX;

        $pattern3 = <<< END_OF_REGEX
/
^
(                           # start choice
 \w+(\.\w+)?                # word [.word]
 |                          # or
 \([^\(\)]*\)               # '(...)'
)                           # end choice
[ ]*                        # 0 or more spaces
(<>|<=|<|>=|>|!=|=)         # comparison operators
[ ]*                        # 0 or more spaces
(ANY|ALL|SOME)?             # 'ANY' or 'ALL' or 'SOME' (0 or 1 times)
[ ]*                        # 0 or more spaces
\(                          # starts with '('
 (                          # start choice
  \([^\(\)]*\)              # '(...)'
  |                         # or
  '(([^\\\']*(\\\.)?)*)'    # quoted string
  |                         # or
  .*?                       # anything else
 )                          # end choice
 +                          # 1 or more times
\)                          # end with ')'
/xis
END_OF_REGEX;

        if (!isset($tablename)) {
            $tablename = '';
        } // if
        foreach ($array2 as $rownum => $rowdata) {
            $array3 = where2indexedArray($rowdata);
            foreach ($array3 as $ix => $string) {
                $string = trim($string);
                if (preg_match('/^(AND|OR)$/i', $string, $regs)) {
                    // put back with leading and trailing spaces
                    $array3[$ix] = ' '.strtoupper($regs[0]) .' ';
                } elseif ($string == '(') {
                    // do not modify
                } elseif ($string == ')') {
                    // do not modify
                } elseif (preg_match($pattern1, $string)) {
                    // format is: 'func(...)', so do not modify
                } elseif (preg_match($pattern2, $string)) {
                    // format is: '(col1,col2)=(...)', so do not modify
                } elseif (preg_match($pattern3, $string)) {
                    // format: 'col = [ANY,ALL,SOME] (...)', so do not modify
                } else {
            	    // split element into its component parts
            		list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
            		$fieldname = strtolower($fieldname);
            		// if $fieldname is qualified with current $tablename, then unqualify it
                	$namearray = explode('.', $fieldname);
                	if (!empty($namearray[1])) {
                	    if ($namearray[0] == $tablename OR $tablename == '*') {
                	    	$fieldname = $namearray[1];
                            $operator = trim($operator);
                            if (!preg_match('/^[ ]*=[ ]*$/', $operator)) {
                                $operator = ' '.$operator.' ';  // not '=', so put spaces either side
                            } // if
                	    	$array3[$ix] = "{$fieldname}{$operator}{$fieldvalue}";
                	    } // if
                    } // if
                } // if
            } // foreach
            // remove any stray 'AND/OR' separators from the array
            $array3 = removeStrayAndOrs($array3);
            // convert array back into a string for a single row
            $where1 = implode('', $array3);
            $array2[$rownum] = $where1;
        } // foreach

        // convert strings for multiple rows into '(row1) OR (row2) OR (row3) ....'
        $where = array2where2($array2);

        return $where;

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
if (!function_exists('validate_ip')) {
    function validate_ip($ip)
    // validate an IP address (if PHP version is 5.2.0 or greater)
    {
        if (version_compare(phpversion(), '5.2.0', '>=')) {
            if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) === false) {
                //return false;
            } // if
            if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_RES_RANGE) === false) {
                return false;
            } // if
            if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4) === false AND filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6) === false) {
                return false;
            } // if
        } // if

        return true;

    } // validate_ip
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

        $fieldspec       = $dbobject->getFieldSpec();     // get fieldspecs for current dbobject
        $tablename = $dbobject->getTableName();
        if (preg_match('/^'.$tablename.'[ ]/i', $dbobject->sql_from)) {
            // FROM clause starts with this table, so don't look for any aliases
        } else {
            $alias_tablename = getTableAlias2($dbobject->tablename, $dbobject->sql_from);
            if (!empty($alias_tablename)) {
                $tablename = $alias_tablename;
            } // if
        } // if
        $orderby_table   = $dbobject->sql_orderby_table;  // get name of alternate sort table

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
                $array2[] = $tablename .'.' .$field;
            } else {
                // carry forward to next step
                $array3[] = $field;
            } // if
        } // foreach

        // look for fields which exist within the current screen
        // (usually obtained from a different table via a JOIN)
        foreach ($array3 as $sortfield) {
            $screen_fields = getFieldsInScreen($structure, $zone);
            if (!empty($zone) AND !empty($structure[$zone]) AND array_key_exists('fields', $structure[$zone])) {
            	foreach ($structure[$zone]['fields'] as $array) {
                    if (is_string(key($array))) {
                        // array is associative
                    	if (array_key_exists($sortfield, $array)) {
                    	    if (isset($orderby_table)) {
                    	    	$array2[] = $orderby_table .'.' .$sortfield;
                    	    	break;
                    	    } else {
                		        $array2[] = $sortfield;
                		        break;
                    	    } // if
                	    } // if
                    } else {
                        // this is an array within an array, so step through each sub-array
                        foreach ($array as $array4) {
                        	if (array_key_exists('field', $array4)) {
                        		if ($array4['field'] == $sortfield) {
                        			if (isset($orderby_table)) {
                            	    	$array2[] = $orderby_table .'.' .$sortfield;
                            	    	break;
                            	    } else {
                        		        $array2[] = $sortfield;
                        		        break;
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
        	if ($substring = strrchr($key, '.')) {
                // now remove the tablename and put amended entry back
                $key = ltrim($substring, '.');
            } // if
            $select_array_unq[$key] = $value;
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
if (!function_exists('validate_XML_schema')) {
    function validate_XML_schema ($xml, $schema)
    // validate an XML document against its XSD schema
    {
		libxml_use_internal_errors(true);

		$dom = new DOMDocument();
		$dom->loadXML($xml);

		if (preg_match('/^<\?xml/i', $schema)) {
			$result = $dom->schemaValidateSource($schema);
		} else {
			$result = $dom->schemaValidate($schema);
		} // if

		if ($result === false) {
			$string = libxml_display_errors();
 			return $string;
		} // if

 		libxml_use_internal_errors(false);

		return true;

    } // _validateXML
} // if

// ****************************************************************************
if (!function_exists('where2array')) {
    function where2array ($where, $pageno=null, $strip_operators=true)
    // change an SQL 'where' string into an association array of field names and values.
    // this function has the following steps:
    // 1 - convert string into an indexed array
    // 2 - convert indexed array into an associative array
    // 3 - strip operators from the associative array (optional)
    {
        // if input string is empty there is nothing to do
        if (empty($where)) return array();

        $array1 = where2indexedArray($where);   // convert string into indexed array

        if ($array1[key($array1)] == '(' AND end($array1) == ')') {
        	// array begins with '(' and ends with ')', but does it have right number of 'OR's?
        	$count = array_count_values($array1);
            if ($count['('] == $count[')'] AND (!empty($count['OR']) AND $count['OR'] == $count['(']-1)) {
                $array1 = splitWhereByRow($array1);
            	if (is_null($pageno) OR $pageno === FALSE) {
            	    // do nothing
            	} else {
            	    $pageno = (int)$pageno;
                	if ($pageno <= 0) $pageno = 1;
                	if ($pageno > 0) {
                        // extract a single row to remove duplicate field names
                    	$where1 = $array1[$pageno-1];
                    	$array1 = where2indexedArray($where1);
                    } // if
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
    // or possibly: (name='something=\'this\'' AND somethingelse=\'that\'')
    // or possibly: name='value' AND (condition1 OR condition2)
    // or possibly: (name BETWEEN 'value1' AND 'value2' AND name='value') ...
    // or possibly: [NOT] EXISTS (subquery)
    // or possibly: name [NOT] LIKE 'value'
    // or possibly: name [NOT] IN (1,2,...,99)
    // or possibly: name=(subquery)
    // or possibly: (name1, name2)=(subquery)
    // or possibly: (SELECT COUNT(*) FROM ...) = 0
    // or possibly: function(name) = 'value'
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

        $pattern1 = <<< END_OF_REGEX
~
^
(                            # start choice
 [\(]{2,}                    # two or more '('
|                            # or
 [ ]*AND(?=\()               # 'AND(' but without the '(' - see pattern 2
|                            # or
 [ ]*AND[ ]+                 # 'AND' followed by 1 or more spaces
|                            # or
 [ ]*OR(?=\()                # 'OR(' but without the '(' - see pattern 2
|                            # or
 [ ]*OR[ ]+                  # 'OR' followed by 1 or more spaces
|                            # or
 NOT[ ]*\(                   # 'NOT (' - see pattern 2
|                                   # or
 \([ ]*SELECT[ ]+COUNT\(.+\).+\)    # (select count(*) from ...)
|                            # or
 \([ ]*(SELECT|CASE)[ ]+     # '(select ' or '(case '
|                            # or
 (NOT[ ]+)?EXISTS            # [NOT] EXISTS
 [ ]*                        # 0 or more spaces
 \(                          # starts with '(' - see pattern 2
|                            # or
 \w+(\.\w+)?                 # word[.word]
 [ ]+                        # 1 or more spaces
 (IS[ ]+NOT|IS)              # 'IS [NOT]
 [ ]+                        # 1 or more spaces
 NULL                        # NULL
|                            # or
 (                           # start choice
 \w+(\.\w+)?                 # word [.word]
 |                           # or
 \w+\(\w+(\.\w+)?\)          # function(word [.word])
 )                           # end choice
 [ ]+                        # 1 or more spaces
 (NOT[ ]+)?(I|R)?LIKE        # [NOT] [I|R]LIKE
 [ ]*                        # 0 or more spaces
 '(([^\\\']*(\\\.)?)*)'      # quoted string
|                            # or
 \w+(\.\w+)?                 # word [.word]
 [ ]+                        # 1 or more spaces
 (NOT[ ]+)?REGEXP            # [NOT] REGEXP
 [ ]*                        # 0 or more spaces
 '(([^\\\']*(\\\.)?)*)'      # quoted string
|                            # or
 \w+(\.\w+)?                 # word [.word]
 [ ]+                        # 1 or more spaces
 (NOT[ ]+)?BETWEEN           # [NOT] BETWEEN
 [ ]+                        # 1 or more spaces
 (                           # start choice
  '(([^\\\']*(\\\.)?)*)'        # quoted string
  |                             # or
  [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
 )                           # end choice
 [ ]*AND[ ]*                 # AND
 (                           # start choice
  '(([^\\\']*(\\\.)?)*)'        # quoted string
  |                             # or
  [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
 )                           # end choice
|                            # or
 \w+(\.\w+)?                 # word [.word]
 [ ]+                        # 1 or more spaces
 (NOT[ ]+IN|IN)              # [NOT] IN
 [ ]*                        # 0 or more spaces
 \(                          # '(' followed by
|                            # or
 (                           # start choice
  \w+(\.\w+)?                # word[.word]
  |                          # or
  \w+(\.\w+)?                # word[.word] followed by
  [ ]*                       # 0 or more spaces
  \(                         # '(' followed by
  (?>                        # start atomic group
  (                          # start choice
   [\w ,\./*:+-]                 # word or ',. /*:+-'
   |                             # or
   \(\)                          # ()
   |                             # or
   \(\w+\)                       # (word)
   |                             # or
   '(([^\\\']*(\\\.)?)*)'        # quoted string
   |                             # or
   [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
  )                          # end choice
  )                          # end atomic group
  ++                         # 1 or more times (possessive quantifier)
  \)                         # ending with ')'
  |                          # or
  \(                         # '(' followed by
  (?>                        # start atomic group
  (                          # start choice
   [\w ,\./*+-]                  # word or ',. /*+-'
   |                             # or
   '(([^\\\']*(\\\.)?)*)'        # quoted string
   |                             # or
   [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
  )                          # end choice
  )                          # end atomic group
  ++                         # 1 or more times (possessive quantifier)
  \)                         # ending with ')'
  |                          # or
  '(([^\\\']*(\\\.)?)*)'     # quoted string
 )                           # end choice
 [ ]*                        # 0 or more spaces
 (?P<operator>               # pattern name
  (<>|<=|<|>=|>|!=|=|LIKE)    # comparison operators
 )                           # end pattern
 [ ]*                        # 0 or more spaces
 (                           # start choice
  (ANY|ALL|SOME)             # 'ANY' or 'ALL' or 'SOME'
  [ ]*                       # 0 or more spaces
  \(                         # starts with '(' - see pattern 2
  |                          # or
  CASE[ ]+WHEN[ ]+.+?END     # CASE WHEN ... END
  |                          # or
  (\w+(\.\w+)?)?             # optional word[.word] followed by
  [ ]*                       # 0 or more spaces
  \(                         # '(' followed by
  (?![ ]*(select|case)[ ]+)  # anything but 'select ' or 'case '
  (?>                        # start atomic group
  (                          # start choice
   [\w ,\./*+-]                  # word or ',. /*+-'
   |                             # or
   \(\)                          # ()
   |                             # or
   \(\w+\)                       # (word)
   |                             # or
   '(([^\\\']*(\\\.)?)*)'        # quoted string
   |                             # or
   [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
  )                          # end choice
  )                          # end atomic grouping
  ++                         # 1 or more times (possessive quantifier)
  \)                         # ending with ')'
  |                             # or
  \w+(\.\w+)?                   # word[.word]
  [ ]*                          # optional space(s))
  (\+|-)[ ]*[0-9]+              # +/- digits
  |                             # or
  \w+(\.\w+)?                   # word[.word]
  (\(\))?                       # optional '()'
  |                             # or
  '(([^\\\']*(\\\.)?)*)'        # quoted string
  |                             # or
  [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
  |                             # or
  \(                            # '('
 )                           # end choice
|                            # or
  \(                         # '(' followed by
  (?>                        # start atomic group
  (                          # start choice
   [\w ,\./*+-]                  # word or ',. /*+-'
   |                             # or
   '(([^\\\']*(\\\.)?)*)'        # quoted string
   |                             # or
   [-+]?\d*\.?\d+([eE][-+]?\d+)? # number (decimal, floating point)
  )                          # end choice
  )                          # end atomic group
  ++                         # 1 or more times (possessive quantifier)
  \)                         # ending with ')'
|                            # or
  \w+(\.\w+)?                # word [.word]
  [ ]*                       # any spaces
  \(                         # '('
|
  \(                         # begins with '(' - see pattern 2
)                            # end choice
~xism
END_OF_REGEX;

        $pattern1a = <<< END_OF_REGEX
/
^
\w+(\.\w+)?             # word[.word]
[ ]*                    # 0 or more spaces
(&|~|\^|<<|>>|\|)       # bitwise operators
[ ]*                    # 0 or more spaces
[0-9]+                  # 1 or more digits
[ ]*                    # 0 or more spaces
(<>|<=|<|>=|>|!=|=)     # comparison operators
[ ]*                    # 0 or more spaces
[0-9]+                  # 1 or more digits
/imsx
END_OF_REGEX;

        $pattern1b = <<< END_OF_REGEX
~
^                            # begins with
(                            # start choice
 [ ]*AND(?=\()               # 'AND(' but without the '(' - see pattern 2
|                            # or
 [ ]*AND[ ]+                 # 'AND' followed by 1 or more spaces
|                            # or
 [ ]*OR(?=\()                # 'OR(' but without the '(' - see pattern 2
|                            # or
 [ ]*OR[ ]+                  # 'OR' followed by 1 or more spaces
|                            # or
 NOT[ ]*\(                   # 'NOT (' - see pattern 2
|                            # or
 \([ ]*(SELECT|CASE)[ ]+     # '(select ' or '(case '
|                            # or
 COUNT\(.+\).+               # 'count(*) ...'
|                            # or
 \(                          # begins with '(' - see pattern 2
)                            # end choice
~xism
END_OF_REGEX;

        $pattern1c = <<< END_OF_REGEX
~
^
(               # start group
 (              # start choice
  \w+\(\)       # function()
  |             # or
  \w+(\.\w+)?   # word [.word]
 )              # end choice
 [ ]*           # optional space
 [-,\+]*        # optional minus,comma,plus
 [ ]*           # optional space
)+              # end group, 1 or more times
~xism
END_OF_REGEX;

        $pattern1d = <<< END_OF_REGEX
~
^
(,|\))          # ',' or ')'
~xi
END_OF_REGEX;

        $pattern2a = <<< END_OF_REGEX
/
^                              # begins with
[ ]*                           # 0 or more spaces
(<>|<=|<|>=|>|!=|=)            # comparison operators
[ ]*                           # 0 or more spaces
\([ ]*select[ ]+               # '(SELECT ...'
/xism
END_OF_REGEX;

        $pattern2b = <<< END_OF_REGEX
/
^                              # begins with
[ ]*                           # 0 or more spaces
(?P<operator>                  # pattern name
  (<>|<=|<|>=|>|!=|=|(I|R)?LIKE|IN)   # comparison operators
)                              # end pattern
[ ]*                           # 0 or more spaces
(                              # start choice
  \(                           # '('
  |                            # or
  (?P<value>                     # pattern name
    (                              # start choice
     \w+(\.\w+)?                   # word[.word]
     ([ ]*\(\))?                   # '()' optional
     |                             # or
     '(([^\\\']*(\\\.)?)*)'        # quoted string
     |                             # or
     [-+]?\d*\.?\d+([eE][-+]?\d+)? # digits (with or without decimals)
    )                              # end choice
  )                              # end pattern
)                              #end choice
/xism
END_OF_REGEX;

        $pattern2c = <<< END_OF_REGEX
/
^                              # begins with
\(                             # (
[ ]*                           # 0 or more spaces
\w+(\.\w+)?                    # word[.word]
[ ]*                           # 0 or more spaces
(NOT)?                         # optional NOT
[ ]*                           # 0 or more spaces
(?P<operator>                  # pattern name
  (<>|<=|<|>=|>|!=|=|(I|R)?LIKE|IN|BETWEEN)   # comparison operators
)                              # end pattern
[ ]*                           # 0 or more spaces
/xism
END_OF_REGEX;

        $input = $where;
        $where = trim(preg_replace("/\s+/u", " ", $where));  // replace tabs and newlines with ' '
        $output = array();
        while (!empty($where)) {
            $where = trim($where);
            if (!$result = preg_match($pattern1, $where, $regs)) {
            	if (!$result = preg_match($pattern1a, $where, $regs)) {
	                if (!$result = preg_match($pattern1b, $where, $regs)) {
                        if (!$result = preg_match($pattern1c, $where, $regs)) {
	                        if (!$result = preg_match($pattern1d, $where, $regs)) {
	                            trigger_error("Cannot extract token from: '$where'", E_USER_ERROR);
	                        } // if
                        } // if
	                } // if
	        	} // if
            } // if
            $found = $regs[0];
            $where = trim(substr($where, strlen($found)));

            //if (strlen($found) == 1 AND $found == '(') {
            if (!empty($regs['operator'])) {
                // contains name-operator-value so continue
                if (substr($found, -1, 1) == '(') {
                    $found .= findClosingParenthesis($where);  // opening '(' found, find closing ')'
                } // if
            } elseif (substr($found, 0, 1) == '(') {
                if (preg_match('/^\([ ]*(SELECT|CASE)\b/i', $found , $regs)) {
                    // full expression is '(word ...) operator value'
                    if (substr($found, -1 , 1) != ')') {
                        $found .= findClosingParenthesis($where);  // extract '(word ...)'
                    } // if
                    // now look for 'operator value'
                    if ($result = preg_match($pattern2a, $where, $regs)) {
                        // found '= (SELECT ...', so this is part of same expression
                        $found .= ' '.findClosingParenthesis($where);

                    } elseif ($result = preg_match($pattern2b, $where, $regs)) {
                        $found .= ' '.$regs['operator'].' '.$regs['value'];
                        $where = trim(substr($where, strlen($regs[0])));
                    } else {
                        trigger_error("Cannot extract token (operator+value) from: '$where'", E_USER_ERROR);
                    } // if

                } elseif (substr($found, 0, 1) == '(' AND substr($found, -1, 1) == ')') {
                    if ($result = preg_match($pattern2c, $found, $regs)) {
                        // found '(word = ....)', so explode contents
                        $output[] = '(';
                        $found = substr($found, 1);          // strip leading ')'
                        $found = substr($found, 0, -1);      // strip trailing ')'
                        $output2 = where2indexedArray($found);
                        $output = array_merge($output, $output2);
                        $found = ')';
                    } elseif ($result = preg_match($pattern2b, $where, $regs)) {
                        if (!empty($regs['value'])) {
                            $found .= ' '.$regs['operator'].' '.$regs['value'];
                            $where = trim(substr($where, strlen($regs[0])));
                        } elseif (substr($regs[0], -1, 1) == '(') {
                            $found .= ' '.$regs[0];
                            $where = trim(substr($where, strlen($regs[0])));
                            $found .= findClosingParenthesis($where);
                        } // if
                    } // if

               } elseif (substr_count($found, '(') == 1) {
                    // single '(' character, so search for matching ')'
                    $output[] = '(';     // output leading '(' on its own
                    $found = findClosingParenthesis($where, '(');
                    if (substr($found, -1, 1) == ')') {
                        // does this contain multiple 'name=value' substrings?
                        $found = substr($found, 0, -1);          // strip trailing ')'
                        $output2 = where2indexedArray($found);
                        $output = array_merge($output, $output2);
                        $found = ')';               // output trailing ')' on its own
                    } // if

                } elseif (preg_match('/^\([ ]*(SELECT COUNT\()/i', $found , $regs)) {
                    // found '(SELECT COUNT(*) FROM ...)'
                    if ($result = preg_match($pattern2b, $where, $regs)) {
                        $found .= ' '.$regs[0];  // append operator and value
                        $where = trim(substr($where, strlen($regs[0])));
                    } // if

                } else {
                    // multiple '(' found, so search for matching ')'
                    $prepend = $found;
                    $found = findClosingParenthesis($where, $found);
                    $output[] = $prepend.$found;
                    $found = null;
                } // if

            } elseif (strlen($found) > 1  AND substr($found, -1, 1) == '(') {
                // multiple characters ending in '(', so search for matching ')'
                $found = trim($found);
                $found .= findClosingParenthesis($where);
                if ($result = preg_match($pattern2b, $where, $regs)) {
                    $found .= ' '.$regs['operator'].' '.$regs['value'];
                    $where = trim(substr($where, strlen($regs[0])));
                } // if
            } // if

            if (trim($found) == ',') {
                // this is a comma separator, so ignore it
            } elseif (!empty($found)) {
                // expression is complete, so add to output array
                $output[] = trim($found);
            } // if
        } // while

        reset($output);

        return $output;

    } // where2indexedArray
} // if

// ****************************************************************************
if (!function_exists('xml2array')) {
    function xml2array ($contents)
    // convert an entire XML document into an array.
    // Note that if there are any errors then a string will be returned instead.
    {
        if (!$contents) return array();

        libxml_use_internal_errors(true);

        require_once('radicore.xmlreader.inc');
        $xml = new radicore_XMLReader();
        $xml->xml($contents);
        $everything = $xml->xml_to_array();

        $errors = libxml_get_errors();
        if (!empty($errors)) {
            // return $errors array as a formatted string
            $everything = libxml_display_errors($errors);
        } // if

        libxml_use_internal_errors(false);

        return $everything;

    } // xml2array
} // if

// ****************************************************************************

?>
