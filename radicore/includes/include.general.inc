<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions

// create a constant for the default character encoding
define('DEFAULT_CHARSET', ini_get('default_charset'));

require_once 'config.inc';
require_once 'error.inc';

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require 'std.singleton.php4.inc';
    require 'include.xml.php4.inc';
    // these do not exist in PHP 4, so define them manually
    define('E_STRICT', 2048);
    define('E_RECOVERABLE_ERROR', 4096);
} else {
    // PHP 5 uses different code
    require 'std.singleton.php5.inc';
    require 'include.xml.php5.inc';
    if (version_compare(phpversion(), '5.2.0', '<')) {
        // this does not exist in PHP 5.0 and 5.1, so define it manually
        define('E_RECOVERABLE_ERROR', 4096);
    } // if
} // if

if (isset($_SERVER['SERVER_PROTOCOL'])) {
	$protocol = 'HTTP://';
    require 'include.jump.inc';
    require 'include.session.inc';
} else {
    // this is being run in batch/cli mode, not from a web server
    $protocol = '';
} // if

$transaction_has_started = false;
$use_HTTPS = false;

// ****************************************************************************
function addPreviousSearchButton ($buttons_in)
// add 'previous search' button to current array of buttons
{
    foreach ($buttons_in as $button_data) {
        // copy from input to output area
        $buttons_out[] = $button_data;
        if (preg_match('/\(search\)/i', $button_data['task_id'], $regs)) {
            // found task_id containing (search'), so add an extra button
            $buttons_out[] = array('task_id' => 'previous_search',
                                   'button_text' => 'Previous Search',
                                   'context_preselect' => 'N');
        } // if
    } // foreach

    return $buttons_out;

} // addPreviousSearchButton

// ****************************************************************************
function adjustDate ($date, $adjustment)
// adjust a date value by a specified number of days.
{
    $dateobj =& singleton::getInstance('date_class');

    $out_date = $dateobj->addDays($date, $adjustment);

    return $out_date;

} // adjustDate

// ****************************************************************************
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

// ****************************************************************************
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

// ****************************************************************************
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

// ****************************************************************************
function array2where ($inputarray, $fieldlist=null, $dbobject=null)
// turn an array of 'name=value' pairs into an SQL 'where' clause.
// $fieldlist (optional) may be in format 'n=name' (indexed) or 'name=value'
// (associative), or even [rownum] string.
// $dbobject (optional) is the database object which provided $inputarray, to
// provide unformatting rules and any uppercase/lowercase field specifications.
{
    if (empty($inputarray)) return;

    if (is_object($dbobject)) {
    	$fieldspec = $dbobject->getFieldSpec();
    } else {
        $fieldspec = array();
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

    $where = null;
    if (!is_string(key($inputarray))) {
        // array is indexed, not associative
        foreach ($inputarray as $index => $string) {
            if (empty($where)) {
                // add space as prefix and suffix
                $where = "($string)";
            } else {
        	    $where .= " OR ($string)";
            } // if
        } // foreach
        return $where;
    } // if

    // array is associative
    // if $fieldlist is empty use $inputarray
    if (empty($fieldlist)) {
        $fieldlist = $inputarray;
    } // if
    // if $fieldlist is in format 'n=name' change it to 'name=n'
    if (!is_string(key($fieldlist))) {
        $fieldlist = array_flip($fieldlist);
    } // if
    if (is_object($dbobject)) {
        // undo any formatting of data values
    	$inputarray = $dbobject->unFormatData($inputarray);
    } // if
    foreach ($inputarray as $fieldname => $fieldvalue) {
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
        if (array_key_exists($fieldname, $fieldlist) or array_key_exists($fieldname_unq, $fieldlist)) {
            if (strlen($fieldvalue) > 0) {
                // check fieldspec for upper/lower case
                if (array_key_exists($fieldname, $fieldspec)) {
                	if (array_key_exists('uppercase', $fieldspec[$fieldname])) {
                		$fieldvalue = strtoupper($fieldvalue);
                	} elseif (array_key_exists('lowercase', $fieldspec[$fieldname])) {
                	    $fieldvalue = strtolower($fieldvalue);
                	} // if
                } // if
                // combine into <name operator value>
                $operators = "/^(<>|<=|<|>=|>|!=|=|LIKE |IS NOT |IS |IN |BETWEEN )/i";
                // does $fieldvalue start with a valid operator?
                if (!preg_match($operators, ltrim($fieldvalue), $regs)) {
                    // no, so assume operator is '='
                	$string = $fieldname ."='" .addslashes($fieldvalue) ."'";
                } else {
                    // operator is already present
                    $string = $fieldname .' ' .$fieldvalue;
                } // if
        	    list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);

                // now join them together again
                $namevalue = $fieldname.$operator.$fieldvalue;

                // append to $where string
                if (empty($where)) {
                    $where .= $namevalue;
                } else {
                    $where .= ' AND ' .$namevalue;
                } // if
            } // if

        } // if
    } // foreach

    return $where;

} // array2where

// ****************************************************************************
function array_merge_nonkey ($fieldspec, $array1, $array2)
// update contents of $array1 with non-key items from $array2.
// this will not overwrite any items designated as primary key in $fieldspec.
// Note: this is different from a merge which will add new fields into $array1
// if they did not previously exist, which is not what I want.
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
        if (!isset($fieldspec[$fieldname]['pkey'])) {
            // this is not a primary key item, so overwrite it
            $array1[$fieldname] = $array2[$fieldname];
        } // if
    } // foreach

    return $array1;

} // array_merge_nonkey

// ****************************************************************************
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

// ****************************************************************************
function array_update_indexed ($fieldarray, $postarray)
// update contents of $fieldarray from contents of $postarray.
// Note: this is different from a merge which will add new fields into $fieldarray
// if they did not previously exist, which is not what I want. This version
// will not create any items in $fieldarray which did not previously exist.
{
    // transfer values from $postarray to $fieldarray
    // each fieldname in $postarray is an array of values
    foreach ($postarray as $fieldname => $valuearray) {
        if (is_array($valuearray)) {
            // copy row value from $postarray to $fieldarray for current $fieldname
            foreach ($valuearray as $row => $value) {
                if (array_key_exists($fieldname, $fieldarray[$row-1])) {
                	// $fieldarray starts at 0, $postarray starts at 1
                    $fieldarray[$row-1][$fieldname] = $postarray[$fieldname][$row];
                } // if
            } // foreach
        } // if
    } // foreach

    return $fieldarray;

} // array_update_indexed

// ****************************************************************************
function convertEncoding ($string, $from_encoding, $to_encoding)
// convert string from one character encoding to another, if required.
{
    if ($string) {
        if (function_exists('mb_convert_encoding')) {
            if (!$from_encoding) {
                // not supplied, so find out what it is
                $from_encoding = mb_detect_encoding($string);
            } // if
            if ($from_encoding != $to_encoding) {
                $string = mb_convert_encoding($string, $to_encoding, $from_encoding);
            } // if
        } // if
    } // if

    return $string;

} // convertEncoding

// ****************************************************************************
function currentOrHistoric ($string)
// convert the string 'current/historic/future' into a date range.
{
    // convert search string into an indexed array
    $search = where2array($string, false, false);
    //$search = where2indexedArray($string);
    //$search = indexed2assoc($search);

    if (isset($search['curr_or_hist'])) {
        // replace Current/Historic/Future with a range of dates
        $search1 = stripOperators($search);
        $date = date('Y-m-d');
        $time = date('H:i:s');
        switch ($search1['curr_or_hist']) {
            case 'C':
                // search for records with CURRENT dates
                $search['start_date'] = "<='$date $time'";
                $search['end_date']   = ">='$date $time'";
                break;
            case 'H':
                // search for records with HISTORIC dates
                $search['end_date'] = "<'$date $time'";
                break;
            case 'F':
                // search for records with FUTURE dates
                $search['start_date'] = ">'$date $time'";
            default:
                ;
        } // switch
        // rebuild search string without 'curr_or_hist' flag
        unset($search['curr_or_hist']);
        $string = array2where($search);
    } // if

    return $string;

} // currentOrHistoric

// ****************************************************************************
function extractSeparator ($where, &$array)
// extract separator (AND, OR, '(' and ')') from $where string and add to $array.
// ($where is passed by reference so that it can be updated).
{
    $where = ltrim($where);
    if (strtoupper(substr($where, 0, 4)) == 'AND ') {
        $array[] = 'AND';
        $where = substr($where, 4);
        $where = extractSeparator($where, $array);  // recursive
    } elseif (strtoupper(substr($where, 0, 6)) == ') OR (') {
        $array[] = ') OR (';
        $where = substr($where, 6);
        $where = extractSeparator($where, $array);  // recursive
    } elseif (strtoupper(substr($where, 0, 3)) == 'OR ') {
        $array[] = 'OR';
        $where = substr($where, 3);
        $where = extractSeparator($where, $array);  // recursive
    } elseif (substr($where, 0, 1) == '(') {
        $array[] = '(';
        $where = substr($where, 1);
        $where = extractSeparator($where, $array);  // recursive
    } elseif (substr($where, 0, 1) == ')') {
        $array[] = ')';
        $where = substr($where, 1);
        $where = extractSeparator($where, $array);  // recursive
    } // if

    return ltrim($where);

} // extractSeparator

// ****************************************************************************
function extractValue (&$where)
// extract value from a WHERE string where the value is delimited by either
// single or double quotes.
// WARNING: any ending delimiter which is escaped must be ignored.
// NOTE: $where is passed by reference so that it can be modified
{
    // the first character is the delimiter (single or double quote)
    $delimiter = substr($where, 0, 1);
    if ($delimiter == '"' or $delimiter == "'" or $delimiter == ' ' or $delimiter == '(') {
        // delimiter is valid
    } else {
        // no valid delimiter found, so use a space instead
        $delimiter = ' ';
    } // if

    // look for ending delimiter
    if ($delimiter == "'" or $delimiter == '"') {
        // delimiter may be escaped with preceeding '\'
        $pattern = '/\\\\*' .$delimiter .'|' .$delimiter .'/';
    } elseif ($delimiter == ' ') {
        $pattern = "/ /";
    } else {
        // look for closing parenthesis
        $pattern = "/\)/";
    } // if

    $backslash_count = 0;
    if (preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, 1)) {
        $found  = $regs[0][0];
        $endpos = $regs[0][1];
        $backslash_count = substr_count($found, "\\");

        while ($backslash_count % 2) {  // look for an odd number of backslashes
            // found an escaped delimiter, so ignore it
            preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, $endpos+2);
            $found = $regs[0][0];
            $endpos = $regs[0][1];
            $backslash_count = substr_count($found, "\\");
        } // while
    } else {
        // not found so....
        if ($delimiter == '(') {
            // add missing delimiter
        	$where .= ')';
        } // if
        // extract remainder of string
        $endpos = strlen($where);
    } // if

    // extract the string portion which exists between the two delimiters
    $fieldvalue = rtrim(substr($where, 0, $endpos +$backslash_count +1));

    if (substr($fieldvalue, -1) == ')') {
        // last character is ')' so first character must be '('
        if (substr($fieldvalue, 0, 1) != '(') {
        	// no match found, so remove trailing ')'
            $fieldvalue = substr($fieldvalue, 0, -1);
        } // if
    } // if
    // remove $fieldvalue from the front of the string
    $where = substr($where, strlen($fieldvalue));

    return $fieldvalue;

} // extractValue

// ****************************************************************************
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

// ****************************************************************************
function fixTrueFalse($lookup, $spec)
// update the $lookup array so that the keys 'true' and 'false' are changed
// to the values for $spec['true'] and $pec['false'].
// For example, the input array of: 'true' => 'Yes', 'false' => 'No'
// could be changed to:             'Y'    => 'Yes', 'N'     => 'No'
{
    $true  =& $spec['true'];
    $false =& $spec['false'];

    if (!is_null($true)) {
    	if (!array_key_exists($true, $lookup)) {
        	$value = $lookup['true'];
        	$lookup[$true] = $value;
        	unset($lookup['true']);
        } // if
    } // if

     if (!is_null($false)) {
        if (!array_key_exists($false, $lookup)) {
        	$value = $lookup['false'];
        	$lookup[$false] = $value;
        	unset($lookup['false']);
        } // if
     } // if

    return $lookup;

} // fixTrueFalse

// ****************************************************************************
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

// ****************************************************************************
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
    	    if (is_subclass_of($object, $array[$i]['class'])) {
    	        $method = $array[$i]['function'];
                break;
    	    } // if
    	} // if
    } // for

    return $method;

} // getEntryPoint

// ****************************************************************************
function getLanguageArray ($id)
// get named array from the language file.
{
    static $array1;
    static $array2;

    if (!is_array($array1)) {
        $array1 = array();
        // get name of current directory
        $dir = basename(dirname($_SERVER['PHP_SELF']));
        if ($dir == 'menu') {
            $dir = './text';
        } else {
        	$dir = '../menu/text';
        } // if
        // include standard text from menu subdirectory
        $subdir = getLanguageSubDir ($dir);
        $fname = "$subdir/sys.language_array.inc";
        if (!file_exists($fname)) {
            // filename does not exist
        	trigger_error(getLanguageText('sys0057', $fname), E_USER_ERROR);
        } // if
        $array1 = require_once $fname;
        unset ($array);
    } // if

    if (!is_array($array2)) {
        $array2 = array();
        // include application text from current directory
        $subdir = getLanguageSubDir ('./text');
        $fname = "$subdir/language_array.inc";
        if (!file_exists($fname)) {
            // filename does not exist
        	trigger_error(getLanguageText('sys0057', $fname), E_USER_ERROR);
        } // if
        $array2 = require_once $fname;
        unset ($array);
    } // if

    // perform lookup for specified $id ($array2 first, then $array1)
    if (isset($array2[$id])) {
    	$result = $array2[$id];
    } elseif (isset($array1[$id])) {
    	$result = $array1[$id];
    } else {
        // nothing found, so return original input as an array
        $result = array($id => $id);
    } // if

    foreach ($result as $key => $value) {
        $value2 = array();
        if (is_array($value)) {
        	foreach ($value as $key1 => $value1) {
        		$value2[$key1] = convertEncoding($value1, 'latin1', 'UTF-8');
        	} // foreach
        } else {
            //$encoding = mb_detect_encoding($value);
            $value2 = convertEncoding($value, 'latin1', 'UTF-8');
        } // if
        $result[$key] = $value2;
    } // foreach

    return $result;

} // getLanguageArray

// ****************************************************************************
function getLanguageSubDir ($path)
// get subdirectory which corresponds with user's language code.
// Whatever is found is set in $_SESSION['output_language'] to be used during XSL transformation
{
    // if user has specified a language then use it
    if (isset($_SESSION['user_language'])) {
        $fname = $path .'/' .$_SESSION['user_language'];
        if (file_exists($fname)) {
            $_SESSION['output_language'] = $_SESSION['user_language'];
        } else {
            $fname = $path .'/' .$_SESSION['default_language'];
            if (file_exists($fname)) {
                $_SESSION['output_language'] = $_SESSION['default_language'];
            } else {
                $fname = $path .'/en';
                $_SESSION['output_language'] = 'en';
            } // if
        } // if
    	return $fname;
    } // if

    $found = array();
    if (is_dir($path)) {
        // build an array of subdirectory names for specified $path
        $dir = dir($path);
        while (false !== ($entry = $dir->read())) {
            if ($entry == '.' or $entry == '..') {
                // ignore
            } else {
                if (is_dir("$path/$entry")) {
            	   $found[] = $entry;
                } // if
            } // if
        } // if
        $dir->close();
    } // if

    if (!empty($found)) {
        if (isset($_SESSION['user_language_array'])) {
        	// scan $user_language_array looking for a matching entry
            foreach ($_SESSION['user_language_array'] as $language) {
            	// look for full language abbreviation (after replacing dash with underscore)
            	$lang = str_replace('-', '_', strtolower($language[0]));
            	foreach ($found as $found_lang) {
            		if ($lang == strtolower($found_lang)) {
            			return "$path/$found_lang";
            		} // if
            	} // foreach
            	// look for primary language (after replacing dash with underscore)
            	$lang = str_replace('-', '_', strtolower($language[1]));
            	foreach ($found as $found_lang) {
            		if ($lang == strtolower($found_lang)) {
            			return "$path/$found_lang";
            		} // if
            	} // foreach
            } // foreach
        } // if
    } // if

    if (isset($_SESSION['default_language'])) {
    	// none found, so use the default language
        return $path .'/' .$_SESSION['default_language'];
    } else {
        // no default language specified, so use English
        return $path .'/en';
    } // if

} // getLanguageSubDir

// ****************************************************************************
function getLanguageText ($id, $arg1=null, $arg2=null, $arg3=null, $arg4=null, $arg5=null)
// get text from the language file and include up to 5 arguments.
{
    static $array1;
    static $array2;

    if (!is_array($array1)) {
        $array1 = array();
        // get name of current directory
        $dir = basename(dirname($_SERVER['PHP_SELF']));
        if ($dir == 'menu') {
            $dir = './text';
        } else {
        	$dir = '../menu/text';
        } // if
        // include standard text from menu subdirectory
        $subdir = getLanguageSubDir ($dir);
        $fname = "$subdir/sys.language_text.inc";
        if (!file_exists($fname)) {
            // filename does not exist
        	trigger_error(getLanguageText('sys0057', $fname), E_USER_ERROR);
        } // if
        $array1 = require_once $fname;
        unset ($array);
    } // if

    if (!is_array($array2)) {
        $array2 = array();
        // include application text from current directory
        $subdir = getLanguageSubDir ('./text');
        $fname = "$subdir/language_text.inc";
        if (!file_exists($fname)) {
            // filename does not exist
        	trigger_error(getLanguageText('sys0057', $fname), E_USER_ERROR);
        } // if
        $array2 = require_once $fname;
        unset ($array);
        // use this language code for the HTML output
        $pos = strrpos($subdir, '/');
        $GLOBALS['language'] = substr($subdir, $pos +1);
    } // if

    // perform lookup for specified $id ($array2 first, then $array1)
    if (isset($array2[$id])) {
    	$string = $array2[$id];
    } elseif (isset($array1[$id])) {
    	$string = $array1[$id];
    } else {
        // nothing found, so return original $id
        return trim($id ." $arg1 $arg2 $arg3 $arg4 $arg5");
    } // if

    $string = convertEncoding($string, 'latin1', 'UTF-8');

    if (!is_null($arg1)) {
        // insert argument(s) into string
    	$string = sprintf($string, $arg1, $arg2, $arg3, $arg4, $arg5);
    } // if

    return $string;

} // getLanguageText

// ****************************************************************************
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

} // getSelf

// ****************************************************************************
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

// ****************************************************************************
function getSelf ()
// reduce PHP_SELF to '/dir/file.php' to exclude all leading directory names.
{

    $PHP_SELF = '/' .basename(dirname($_SERVER['PHP_SELF']))
               .'/' .basename($_SERVER['PHP_SELF']);

    return $PHP_SELF;

} // getSelf

// ****************************************************************************
function getShutDownStatus ()
// find out if the system has a scheduled shutdown time
{
    $errors   = array();
    $messages = array();

    $dbobject =& singleton::getInstance('mnu_control');
    $shutdown_data = $dbobject->getControlData('shutdown');

    $time = getTimeStamp('time');
    $dow  = date('l', time()); // get day of week (full name)
    $fieldname = 'shutdown_' .strtolower($dow);

    if (is_True($shutdown_data[$fieldname])) {
    	// there is a shutdown scheduled for this day...
    	if ($shutdown_data['shutdown_warning'] <= $time AND $shutdown_data['shutdown_start'] >= $time) {
    	    // System will be shutting down between X and Y
    		$messages[] = getLanguageText('sys0140', substr($shutdown_data['shutdown_start'], 0, 5), substr($shutdown_data['shutdown_end'], 0, 5));
    	} // if
        if ($shutdown_data['shutdown_start'] <= $time AND $shutdown_data['shutdown_end'] >= $time) {
    	    // System has been shut down. It will be available at X
    		$errors[] = getLanguageText('sys0141', substr($shutdown_data['shutdown_end'], 0, 5));
    	} // if
    } // if

    $result[] = $errors;
    $result[] = $messages;

    return $result;

} // getShutDownStatus

// ****************************************************************************
function getTableAlias1 ($alias, $string)
// look for 'original AS alias' in $string and return 'original'
{
    // build array of words which come before ' as ' in string
    $count = preg_match_all('/\w+(?= as )/i', $string, $regs);
    $array1 = $regs[0];

    // build array of words which come after ' as ' in string
    $count = preg_match_all('/(?<= as )\w+/i', $string, $regs);
    $array2 = $regs[0];

    $index = array_search($alias, $array2);
    if ($index === false) {
        return false;
    } else {
        $original = $array1[$index];
        return $original;
    } // if

    return false;

} // getTableAlias1

// ****************************************************************************
function getTableAlias2 ($original, $string)
// look for 'original AS alias' in $string and return 'alias'
{
    // build array of words which come before ' as ' in string
    $count = preg_match_all('/\w+(?= as )/i', $string, $regs);
    $array1 = $regs[0];

    // build array of words which come after ' as ' in string
    $count = preg_match_all('/(?<= as )\w+/i', $string, $regs);
    $array2 = $regs[0];

    $index = array_search($original, $array1);
    if ($index === false) {
        return false;
    } else {
        $alias = $array2[$index];
        return $alias;
    } // if

    return false;

} // getTableAlias2

// ****************************************************************************
function getTableAlias3 ($string)
// look for 'original AS alias' in $string and return both 'original' and 'alias'
{
    // look for words either side of ' as ' in $string
    if ($count = preg_match('/\w+(?= as )/i', $string, $regs) > 0) {
    	$array[0] = $regs[0];  // original
    	$count = preg_match('/(?<= as )\w+/i', $string, $regs);
    	$array[1] = $regs[0];  // alias
    } else {
        $array[0] = '';
        $array[1] = '';
    } // if

    return $array;

} // getTableAlias3

// ****************************************************************************
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

// ****************************************************************************
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

// ****************************************************************************
function indexed2assoc ($array_in)
// turn an indexed array (created by where2indexedArray) into an associative array.
{
    $array_out = array();

    $separators = '/^('     // beginning with
                 .'AND'     // AND
                 .'|'
                 .'OR'      // OR
                 .'|'
                 .'\('      // ( - left parenthesis
                 .'|'
                 .'\)'      // ) - right parenthesis
                 .')$/i';   // ending with, case insensitive

    foreach ($array_in as $index => $string) {
        if (preg_match($separators, $string, $regs)) {
            // ignore this entry
        } else {
            // split string into its component parts
        	list($fieldname, $operator, $fieldvalue) = splitNameOperatorValue($string);
        	if (!array_key_exists($fieldname, $array_out)) {
        		$array_out[$fieldname] = $operator .$fieldvalue;
        	} // if
        } // if
    } // foreach

    return $array_out;

} // indexed2assoc

// ****************************************************************************
function isPkeyComplete ($where, $pkey)
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

    $errors = array();

    foreach ($pkey as $fieldname) {
        if (array_key_exists($fieldname, $fieldarray)) {
            // value must NOT contain wildcard character
            if (strpos($fieldarray[$fieldname], '%') === false) {
                // not found, so continue
            } else {
                $errors[$fieldname] = getLanguageText('sys0017'); // 'Must not use wildcard character (%) in primary key'
            } // if
        } else {
            $errors[] = getLanguageText('sys0018', $fieldname); // "Primary key ($fieldname) is not complete - check selection"
        } // if
    } // foreach

    return $errors;

} // isPkeycomplete

// ****************************************************************************
function isPrimaryObject ($object)
// Find out is this is the first object to be called in the current script.
// (ie: is the object called from a controller and not another object?)
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

    $array  = debug_backtrace();    // get trace data

    // start at the end of the array and move backwards
    for ($i = count($array)-1; $i >= 0; $i--) {
        // is this entry for a method call?
    	if (isset($array[$i]['type'])) {
    	    if (isset($array[$i]['class'])) {
    	        // class found - now examine it
    	        if ($classname == $array[$i]['class']) {
    	        	return true;
    	        } else {
    	            return false;
    	        } // if
                break;
    	    } // if
    	} // if
    } // for

    return false;

} // isPrimaryObject

// ****************************************************************************
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

// ****************************************************************************
function logStuff ($string, $function=null, $line=null)
// write $string out to a log file for debugging
{
    if ($_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
        // this is my IP address, so continue
    } elseif (eregi('^(localhost|desktop|laptop)$', $_SERVER['SERVER_NAME'])) {
        // this is one my PCs, so continue
    } else {
    	return;
    } // if

    $header = "\r\n<p>********** " .date('Y-m-d H:i:s') .' ';
    $header .= "function: " .$function .", line: " .$line ."</p>\r\n";
    $logfile = '../errorlog.html';
    $result = error_log("$header $string", 3, $logfile);

    return;

} // logStuff

// ****************************************************************************
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

// ****************************************************************************
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

// ****************************************************************************
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
    foreach ($array2 as $field1 => $value1) {
        if (array_key_exists($field1, $array1)) {
            // corresponding entry exists, so remove it
        	unset($array2[$field1]);
        } else {
            $namearray = explode('.', $field1);
            if (!empty($namearray[1])) {
                // remove table qualifier
                $fieldname_unq = $namearray[1];
            } else {
                $fieldname_unq = $namearray[0];
            } // if
            if (array_key_exists($fieldname_unq, $array1)) {
                // corresponding entry exists, so remove it
            	unset($array2[$fieldname_unq]);
            } // if
        } // if
    } // foreach

    if (!empty($array2)) {
    	// convert $array2 back into a sring and append to $where 1
        $where3 = array2where($array2);
        $where1 .= ' AND ' .$where3;
    } // if

    return $where1;

} // mergeWhere

// ****************************************************************************
function number_unformat ($input)
// convert input string into a number using settings from localeconv()
{
    $locale = localeconv();
    $decimal_point  = $locale['decimal_point'];
    $thousands_sep  = $locale['thousands_sep'];
    if ($thousands_sep == chr(160)) {
       $thousands_sep = chr(32);
    } // if

    $count = count_chars($input, 1);
    if ($count[ord($decimal_point)] > 1) {
        // too many decimal places
    	return $input;
    } // if

    // split number into 2 distinct parts
    list($integer, $fraction) = explode($decimal_point, $input);

    // remove thousands separator
    $integer = str_replace($thousands_sep, NULL, $integer);

    // join the two parts back together again
    $number = $integer .'.' .$fraction;

    return $number;

} // number_unformat

// ****************************************************************************
function orderbyFilter ($orderby, $fieldlist, $tablename)
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

} // OrderbyFilter

// ****************************************************************************
function qualifyOrderby ($input, $tablename, $fieldspec)
// add table names to field names in input string, but only for those fields
// which exist in $fieldspec.
{
    if (empty($input)) return;

    // split into substrings separated by comma or space
    $array = preg_split('(( )|(,))', $input, -1, PREG_SPLIT_DELIM_CAPTURE);

    $output = null;
    foreach ($array as $key => $value) {
        if (array_key_exists($value, $fieldspec)) {
        	$value = $tablename .'.' .$value;
        } // if
        $output .= $value;
    } // foreach

    return $output;

} // qualifyOrderby

// ****************************************************************************
function qualifyField ($fieldarray, $tablename, $fieldspec, $table_array, $sql_search_table)
// Examine each field in $fieldarray and ensure that it is qualified with a table name.
// If it is already qualified then ensure that its table name exists in $table_array.
// (NOTE: $table_array is in format 'alias = original')
// If it is not already qualified then find out which table it belongs to.
{
    // $tablename may contain 'original AS alias', so split into two
    if ($count = preg_match("/\w+ as \w+/i", $sql_search_table, $regs)) {
        // entry contains 'table AS alias', so use original table table
    	list($search_table_orig, $search_table_alias) = preg_split('/ as /i', $regs[0]);
    } else {
        $search_table_orig  = $sql_search_table;
        $search_table_alias = $sql_search_table;
    } // if

    $output_array = array();
    foreach ($fieldarray as $fieldname => $fieldvalue) {
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
            // if $fieldspec is supplied it must contain fieldname
            if (empty($fieldspec) or (array_key_exists($fieldname, $fieldspec)) AND !isset($fieldspec[$fieldname]['nondb'])) {
                // field is in current table, so insert qualified name
                $output_array["$tablename.$fieldname"] = $fieldvalue;
            } else {
                // field is not in current table
                if (empty($table_array)) {
                    // no other tables is $sql_from, so leave it alone
                	$output_array[$fieldname] = $fieldvalue;
                } else {
                    // find out if it belongs in one of the tables in $sql_from
                    foreach ($table_array as $array_tablename) {
                    	if ($array_tablename != $tablename) {
                    	    $class = "classes/$array_tablename.class.inc";
            			    if ($fp = fopen($class, 'r', true)) {
                            	fclose($fp);
                            	// class exists, so inspect it
                            	$object =& singleton::getInstance($array_tablename);
                                if (array_key_exists($fieldname, $object->fieldspec) AND !isset($object->fieldspec[$fieldname]['nondb'])) {
                					// field is in this other table, so insert qualified name
                					if ($array_tablename == $search_table_orig) {
                					    // use alias name, not original
                						$output_array["$search_table_alias.$fieldname"] = $fieldvalue;
                					} else {
                					    $output_array["$array_tablename.$fieldname"] = $fieldvalue;
                					} // i
                					break;
                				} // if
                            } // if
                    	} // if
                    } // foreach
                } // if
            } // if
        } // if
    } // foreach

    return $output_array;

} // qualifyField

// ****************************************************************************
function qualifySelect ($input, $tablename, $fieldspec)
// add table names to field names in input string, but only for those fields
// which exist in $fieldspec.
{

    if (empty($input)) return;

    $pattern = '/'          // start delimiter
              .'(,)'        // comma
              .'|( as )'    // or ' as '
              .'|( )'       // or space
              .'|(\()'      // or '('
              .'|(\))'      // or ')'
              .'/i';        // end delimiter, case-insensitive
    // split into substrings separated by comma or space or left/right parentheseis, or ' AS '
    $array = preg_split($pattern, $input, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);

    $output   = null;
    $previous = null;
    foreach ($array as $key => $value) {
        if (array_key_exists($value, $fieldspec)) {
            if (strtoupper($previous) == ' AS ') {
                // previous word is ' as ', so do not prefix this name
            } else {
            	// substring exists in $fieldspec array, so prefix with supplied tablename
            	$value = $tablename .'.' .$value;
            } // if
        } // if
        if ($value != ' ') {
        	$previous = $value; // store previous value (except space)
        } // if
        $output .= $value;
    } // foreach

    return $output;

} // qualifySelect

// ****************************************************************************
function qualifyWhere ($where, $tablename, $fieldspec=null, $sql_from=null, $sql_search_table=null)
// add table names to field names in 'where' string.
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

    if (!empty($sql_from)) {
    	// extract first tablename from $sql_from
        $count = preg_match("/\w+/", $sql_from, $regs);
        $table_array[] = $regs[0];

        // append any other tablenames (which may be qualified with a database name) which follow the word ' JOIN '
        if ($count = preg_match_all("/(?<= join )\w+\.\w+|(?<= join )\w+/i", $sql_from, $regs)) {
        	$table_array = array_merge($table_array, $regs[0]);
        } // if
        if ($count = preg_match_all("/(?<= join )\w+\.\w+/i", $sql_from, $regs)) {
            // remove any database name which may prefix a table name
            foreach ($regs[0] as $database_table) {
                // remove 'database.table' entry
                $key = array_search($database_table, $table_array);
            	unset($table_array[$key]);
            	// replace entry with table name only
            	list($database, $table) = explode('.', $database_table);
            	$table_array[] = $table;
            } // foreach
        } // if
        // look for any 'table AS alias' entries
        if ($count = preg_match_all("/\w+ as \w+/i", $sql_from, $regs)) {
            foreach ($regs[0] as $entry) {
            	list($original, $alias) = preg_split('/ as /i', $entry);
            	$index = array_search($original, $table_array);
            	if ($index === false) {
            		// not found, so ignore it
            	} else {
            	    // replace 'index = table' with 'alias = table'
            	    $table_array[$alias] = $original;
            	    // remove original indexed entry
            	    unset($table_array[$index]);
            	} // if
            } // foreach
        } // if
        // replace 'index = table' with 'table = table'
        foreach ($table_array as $key => $value) {
        	if (!is_string($key)) {
        		$table_array[$value] = $value;
        		unset($table_array[$key]);
        	} // if
        } // foreach
    } else {
        $table_array = array();
    } // if

    $where1 = null;

    if (in_array(') or (', $fieldarray) or in_array(') OR (', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so ...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($fieldarray);
    	// process each row separately
        foreach ($fieldarray as $rownum => $rowdata) {
            // create a separate array for this row
            $array1 = where2array($rowdata);
            $output_array = qualifyField ($array1, $tablename, $fieldspec, $table_array, $sql_search_table);
            // put modified details back into $fieldarray
            $fieldarray[$rownum] = $output_array;
        } // foreach

    } else {
        reset($fieldarray);  // fix for version 4.4.1
        if (!is_string(key($fieldarray))) {
        	$fieldarray = indexed2assoc($fieldarray);       // convert indexed array to associative
        } // if
        $output_array = qualifyField ($fieldarray, $tablename, $fieldspec, $table_array, $sql_search_table);
        // put modified details back into $fieldarray
        $fieldarray = $output_array;
    } // if

    if (is_array($where)) {
        // return output as array
        return $fieldarray;
    } //if

    // convert output array to a string
    $where1 = array2where($fieldarray);

    return $where1;

} // qualifyWhere

// ****************************************************************************
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

// ****************************************************************************
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

} // selection2ull

// ****************************************************************************
function selection2where ($pkeyarray, $select)
// turn selection into SQL 'where' criteria.
// $pkeyarray is an array of primary key name/value pairs for each row.
// $select identifies which row(s) have been selected.
{
    if (is_array($select)) {
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
            if (empty($where)) {
                $where = "($where2)";
            } else {
                // details for multiple rows are separated by OR
                $where .= " OR ($where2)";
            } // if
        } // foreach
    } else {
        // $select is a string containing a single selection
        $where = null;
        foreach ($pkeyarray[$select] as $fieldname => $fieldvalue) {
            if (empty($where)) {
                $where = "$fieldname='$fieldvalue'";
            } else {
                $where .= " AND $fieldname='$fieldvalue'";
            } // if
        } // foreach
    } // if

    return $where;

} // selection2where

// ****************************************************************************
function splitNameOperatorValue (&$where)
// split a 'name|operator|value' string into its component parts.
// ($where is passed by reference so that it can be amended)
{
    // construct list of possible operators between fieldname and fieldvalue
    $operators = "/(<>|<=|<|>=|>|!=|=| LIKE | IS NOT | IS | IN | BETWEEN )/i";

    if (preg_match($operators, $where, $regs, PREG_OFFSET_CAPTURE)) {
        $operator = $regs[0][0];    // found an operator
        $startpos = $regs[0][1];    // start position of this operator
        // everything in front is a fieldname
        $fieldname = trim(substr($where, 0, $startpos));
        // strip off any leading parenthesis
        $fieldname = ltrim($fieldname, '(');
        // calculate length of $fieldname + operator
        $endpos = $startpos + strlen($operator);
        // remove this bit from the front of the string
        $where = ltrim(substr($where, $endpos));

        $fieldvalue = extractValue($where);

        // are we dealing with an operator of BETWEEN?
        if (eregi('BETWEEN', trim($operator))) {
            // yes, so inclcude the following " AND 'x'"
            if (eregi(' AND ', $where)) {
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
        // operator starts with alphabetic character (IS, LIKE, BETWEEN)
        // so insert a leading space and trailing space
        $operator = ' '.strtoupper($operator) .' ';
    } // if

    // put all three elements into the output array
    $array[] = $fieldname;
    $array[] = $operator;
    $array[] = trim($fieldvalue);

    return $array;

} // splitNameOperatorValue

// ****************************************************************************
function splitWhereByRow ($input)
// convert $input into an array with ' OR ' being used to create a new row.
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
    	if (eregi('^) OR \($', $value, $regs)) {
            // add current string as a separate entry to output array
            $array2[] = trim($string, '() ');
            $string  = '';
        } else {
            // append to current string
        	$string .= $value .' ';
        } // if
    } // foreach

    if (!empty($string)) {
        $array2[] = trim($string, '() ');
    } // if

    return $array2;

} // splitWhereByRow

// ****************************************************************************
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

// ****************************************************************************
function stripOperators_ex ($input)
// turn string from "='value'" to "value"
{
    if (preg_match('/^(=|LIKE )/i', ltrim($input), $operator)) {
        $output = ltrim($input, $operator[0]);
        $output = trim($output);

        // the next character is the delimiter (single or double quote)
        $delimiter = substr($output, 0, 1);
        if ($delimiter == '"' or $delimiter == "'") {
            // delimiter found, so remove from both ends of string
            $output = substr($output, 1);
            $output = substr($output, 0, -1);
        } // if

        return $output;
    } // if

    return $input;

} // stripOperators_ex

// ****************************************************************************
function unqualifyOrderBy ($string)
// remove any table names from field names in 'order by' string
{
    // if $where is empty do nothing
    if (empty($string)) return;

    // split into substrings spearated by comma or space
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

// ****************************************************************************
function unqualifyWhere ($where)
// remove any table names from field names in 'where' string
{
    // if $where is empty do nothing
    if (empty($where)) return;

    // convert $where string to $fieldarray
    $fieldarray = where2indexedArray($where);

    $array1 = array();
    if (in_array(') or (', $fieldarray) or in_array(') OR (', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($fieldarray);
        foreach ($fieldarray as $rownum => $rowdata) {
        	// create an array for this row
            $array2 = where2array($rowdata);
            $array3 = array();
            foreach ($array2 as $fieldname => $fieldvalue) {
                if ($substring = strrchr($fieldname, '.')) {
                    // now remove the tablename and put amended entry back into the array
                    $fieldname = ltrim($substring, '.');
                } // if
                $array3[$fieldname] = $fieldvalue;
            } // foreach
            $array1[] = $array3;
        } // foreach
    } else {
        reset($fieldarray);  // fix for version 4.4.1
        if (!is_string(key($fieldarray))) {
        	$fieldarray = indexed2assoc($fieldarray);       // convert indexed array to associative
            $fieldarray = stripOperators($fieldarray);      // strip operators in front of values
        } // if
        // there may be more than one row in this array
        foreach ($fieldarray as $fieldname => $fieldvalue) {
            if ($substring = strrchr($fieldname, '.')) {
                // now remove the tablename and put amended entry back into the array
                $fieldname = ltrim($substring, '.');
            } // if
            $array1[$fieldname] =  $fieldvalue;
        } // foreach
    } // if

    $where1 = array2where($array1);

    return $where1;

} // unqualifyWhere

// ****************************************************************************
function validateSortItem ($zone, $sortfield, $dbobject, $structure=array())
// check that the sort field actually exists in the current screen or dbobject.
// this stops a naughty user from manually altering the URL to point to
// a field name that does not exist, thus causing an error.
{
    $sortfield = strtolower(unqualifyOrderBy($sortfield));

    if ($sortfield == 'selectbox') {
    	return FALSE; // cannot sort on this field
    } // if

    $fieldspec     = $dbobject->getFieldspec();     // get fieldspecs for current dbobject
    $orderby_table = $dbobject->sql_orderby_table;  // get name of alternate sort table

    $array1 = explode(",", $sortfield);     // convert input string to array of field names
    $array2 = array();                      // array of valid field names
    $array3 = array();                      // carry forward to next step

    // look for fields which exist within the current table
    foreach ($array1 as $field) {
        // ignore field if 'nondb' option (not in database) is set
        if (array_key_exists($field, $fieldspec) and !isset($fieldspec[$field]['nondb'])) {
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

// ****************************************************************************
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

    if (in_array(') or (', $array1) or in_array(') OR (', $array1)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$array1 = splitWhereByRow($array1);
    	$pageno = (int)$pageno;
    	if ($pageno <= 0) $pageno = 1;
    	if ($pageno > 0) {
            // extract a single row to remove duplicate field names
        	$array1 = array($array1[$pageno-1]);
        	$array1 = where2indexedArray($array1);
        } // if
    } // if

    $array2 = indexed2assoc($array1);       // convert indexed array to associative
    if (is_True($strip_operators)) {
    	$array3 = stripOperators($array2);  // strip operators in front of values
    	return $array3;
    } // if

    return $array2;

} // where2array

// ****************************************************************************
function where2indexedArray ($where)
// change an SQL 'where' clause into an array of field names and values
// $where is in the format: (name='value' AND name='value' AND ...)
// or possibly: (name='value' AND name='value') OR (name='value' AND name='value') OR ...
// or possibly: (name BETWEEN 'value1' AND 'value2' AND name='value') ...
// or possibly: (name='something=\'this\'' AND somethingelse=\'that\'')
{
    // if input string is empty therealue is nothing to do
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

// ****************************************************************************
function whereFilter ($where, $fieldlist, $tablename)
// filter out any fields in $where which do not belong in this table,
// (valid fields are identified in the $fieldlist array).
{
    // if input string is empty there is nothing to do
    if (empty($where)) return;

    if (is_array($where)) {
        $fieldarray = $where;
    } else {
        // convert from string to indexed array
        $fieldarray = where2indexedArray($where);
    } // if

    reset($fieldlist);  // fix for version 4.4.1
    if (!is_string(key($fieldlist))) {
        // flip indexed array so that the values become keys
        $fieldlist = array_flip($fieldlist);
    } // if

    if (in_array(') or (', $fieldarray) or in_array(') OR (', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so ...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($fieldarray);
    	// process each row separately
    	$array2 = array();
        foreach ($fieldarray as $rownum => $rowdata) {
        	$array1 = where2array($rowdata);
        	foreach ($array1 as $fieldname => $fieldvalue) {
        		// if $fieldname is qualified with current $tablename, then unqualify it
                $fieldname = strtolower(str_replace("$tablename.", '', trim($fieldname)));
                // check if $fieldname exists in $fieldlist array
                if (array_key_exists($fieldname, $fieldlist)) {
                    // field is valid, so copy to output array
                    $array2[$fieldname] = $fieldvalue;
                } // if
        	} // foreach
        	if (!empty($array2)) {
        		// update original array with changed data
            	$fieldarray[$rownum] = array2where($array2);
        	} // if
        } // foreach
        $array2 = $fieldarray;

    } else {
        reset($fieldarray);  // fix for version 4.4.1
        if (!is_string(key($fieldarray))) {
        	$fieldarray = indexed2assoc($fieldarray);       // convert indexed array to associative
        } // if
        $array2 = array();
        foreach ($fieldarray as $fieldname => $fieldvalue) {
    		// if $fieldname is qualified with current $tablename, then unqualify it
            $fieldname = str_replace("$tablename.", '', trim($fieldname));
            // check if $fieldname exists in $fieldlist array
            if (array_key_exists($fieldname, $fieldlist)) {
                // field is valid, so copy to output array
                $array2[$fieldname] = $fieldvalue;
            } // if
    	} // foreach
    } // if

    // convert back into string
    $where2 = array2where($array2);

    if (is_array($where)) {
        // replace input array with updated version
        $where = $array2;
    } // if

    return $where2;

} // whereFilter

// ****************************************************************************
function whereFilterWhere ($where1, $where2)
// remove entries from $where2 that already exist in $where1
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
    foreach ($array2 as $field1 => $value1) {
        if (array_key_exists($field1, $array1)) {
            // corresponding entry exists, so remove it
        	unset($array2[$field1]);
        } else {
            $namearray = explode('.', $field1);
            if (!empty($namearray[1])) {
                // remove table qualifier
                $fieldname_unq = $namearray[1];
            } else {
                $fieldname_unq = $namearray[0];
            } // if
            if (array_key_exists($fieldname_unq, $array1)) {
                // corresponding entry exists, so remove it
            	unset($array2[$fieldname_unq]);
            } // if
        } // if
    } // foreach

    // convert $array2 back into a sring
    $where2 = array2where($array2);

    return $where2;

} // whereFilterWhere

// ****************************************************************************
?>
