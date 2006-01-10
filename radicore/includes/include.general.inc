<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic functions

// create a constant for the default character encoding
define('DEFAULT_CHARSET', ini_get('default_charset'));

require_once 'config.inc';
require 'error.inc';

if (isset($_SERVER['SERVER_PROTOCOL'])) {
	if (preg_match('/^HTTPS/i', $_SERVER['SERVER_PROTOCOL'])) {
        $protocol = 'HTTPS://';
    } else {
        $protocol = 'HTTP://';
    } // if
    require 'include.jump.inc';
    require 'include.session.inc';
} else {
    $protocol = '';
} // if

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require 'include.xml.php4.inc';
    // this does not exist in PHP 4, so define it manually
    define('E_STRICT', 2048);
} else {
    // PHP 5 uses different code
    require 'include.xml.php5.inc';
} // if

// ****************************************************************************
class singleton
// ensure that only a single instance exists for each class.
{
    function &getInstance ($class, $arg1=null)
    // implements the 'singleton' design pattern.
    {
        static $instances = array();  // array of instance names

        if (array_key_exists($class, $instances)) {
            // instance exists in array, so use it
            $instance =& $instances[$class];
        } else {
            // instance does not exist, so create it
            $instances[$class] = new $class($arg1);
            $instance =& $instances[$class];
        } // if

        return $instance;

    } // getInstance

} // singleton

// ****************************************************************************
function addPreviousSearchButton ($buttons_in)
// add 'previous search' button to current array of buttons
{
    //DebugBreak();
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
function adjustTime ($time, $adjustment)
// adjust a time value by a specified amount.
{
	//DebugBreak();
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
    // DebugBreak();
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
// $fieldlist may be in format 'n=name' (indexed) or 'name=value' (associative),
// or even [rownum] string.
// $dbobject (optional) identifies the database object which provided $inputarray.
{
    if (empty($inputarray)) return;

    if (version_compare(phpversion(), '4.4.1', '=')) {
        foreach ($inputarray as $key => $value) {   // fix for version 4.4.1
            $inputarray[$key] = $value;             // fix for version 4.4.1
        } // foreach                                // fix for version 4.4.1
    } // if
    $key = key($inputarray);
    if (is_long($key)) {
        // indexed array
    	if (is_array($inputarray[$key])) {
    	    // this s an array within an array, so...
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
        // exclude fields not contained in $fieldlist (such as SUBMIT button)
        if (array_key_exists($fieldname, $fieldlist)) {
            if (strlen($fieldvalue) > 0) {
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
                    $where .= ' AND '.$namevalue;
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
    // DebugBreak();
    // // This version will not create any items in $array1 which did not previously exist.
    // foreach ($array1 as $fieldname => $fieldvalue) {
    //  if (array_key_exists($fieldname, $array2)) {
    //      if (!isset($fieldspec[$fieldname]['pkey'])) {
    //      // this is not a primary key item, so overwrite it
    //      $array1[$fieldname] = $array2[$fieldname];
    //      } // if
    //  } // if
    // } // foreach

    if (!is_string(key($array1))) {
        // indexed by row, so use row zero only
        $array1 = $array1[0];
    } // if

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
function array_update ($array1, $array2)
// update contents of $array1 from contents of $array2.
// Note: this is different from a merge which will add new fields into $array1
// if they did not previously exist, which is not what I want. This version
// will not create any items in $array1 which did not previously exist.
{
    if (!is_string(key($array1))) {
        // indexed by row, so use row zero only
        $array1 = $array1[key($array1)];
    } // if

    if (!is_string(key($array2))) {
        // indexed by row, so use row zero only
        $array2 = $array2[key($array2)];
    } // if

    foreach ($array1 as $fieldname => $fieldvalue) {
        if (array_key_exists($fieldname, $array2)) {
            $array1[$fieldname] = $array2[$fieldname];
        } // if
    } // foreach

    return $array1;

} // array_update

// ****************************************************************************
function buildPkeyArray ($rowdata, $pkeynames)
// build an array of primary keys using:
// $rowdata = array of data (multiple rows) obtained from the database
// $pkeynames = array of fieldnames which form the primary key
{
    //DebugBreak();
    $pkeyarray = array();

    if (!is_array($rowdata[key($rowdata)])) {
        // array is one level deep - convert to 2 levels
        $rowdata2[0] = $rowdata;
        $rowdata = $rowdata2;
    } // if

    $rowcount = 0;

    // step through each row
    foreach ($rowdata as $row) {
        // note that $rowcount starts at 1, not 0
        $rowcount++;
        foreach ($pkeynames as $fieldname) {
            // add 'name=value' to array
            $pkeyarray[$rowcount][$fieldname] = $row[$fieldname];
        } // foreach
    } // foreach

    return $pkeyarray;

} // buildPkeyArray

// ****************************************************************************
function buildPkeyRow ($rowdata, $pkeynames)
// build an array of primary keys using:
// $rowdata = array of data (single row) obtained from the database
// $pkeynames = array of fieldnames which form the primary key
{
    $pkeyarray = array();

    foreach ($pkeynames as $fieldname) {
        // add 'name=value' to array
        $pkeyarray[$fieldname] = $rowdata[$fieldname];
    } // foreach

    return $pkeyarray;

} // buildPkeyRow

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
    //DebugBreak();
    // convert search string into an indexed array
    $search = where2indexedArray($string);
    // convert into an associative array
    $search = indexed2assoc($search);

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
            default: ;
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
    } // if
    if (strtoupper(substr($where, 0, 3)) == 'OR ') {
        $array[] = 'OR';
        $where = substr($where, 3);
        $where = extractSeparator($where, $array);  // recursive
    } // if
    if (substr($where, 0, 1) == '(') {
        $array[] = '(';
        $where = substr($where, 1);
        $where = extractSeparator($where, $array);  // recursive
    } // if
    if (substr($where, 0, 1) == ')') {
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
// NOTE: $where is passed by reference sp that it can be modified
{
    // the first character is the delimiter (single or double quote)
    $delimiter = substr($where, 0, 1);
    if ($delimiter == '"' or $delimiter == "'" or $delimiter == ' ') {
        // delimiter is valid
    } else {
        // no valid delimiter found, so use a space instead
        $delimiter = ' ';
    } // if

    // look for ending delimiter
    if ($delimiter == "'" or $delimiter == '"') {
        // delimiter may be escaped with preceeding '\'
        $pattern = '/(\\\\' .$delimiter .'|' .$delimiter .')/';
    } else {
        $pattern = "/ /";
    } // if

    if (preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, 1)) {
        $found  = $regs[0][0];
        $endpos = $regs[0][1];
        while (strlen($found) > 1) {
            // found an escaped delimiter, so ignore it
            preg_match($pattern, $where, $regs, PREG_OFFSET_CAPTURE, $endpos+2);
            $found = $regs[0][0];
            $endpos = $regs[0][1];
        } // while
    } else {
        // not found so use remainder of string
        $endpos = strlen($where);
    } // if

    // extract the string portion which exists between the two delimiters
    $fieldvalue = substr($where, 0, $endpos +1);
    // remove $fieldvalue from the front of the string
    $where = substr($where, $endpos + 1);

    return $fieldvalue;

} // extractValue

// ****************************************************************************
function getChanges ($newarray, $oldarray)
// compare two arrays of 'name=value' pairs and remove items from $newarray
// which have the same value in $oldarray.
{
    // step through each 'item=value' entry in $newarray
    foreach ($newarray as $item => $value) {
        // remove if item with same value exists in $oldarray
        if (array_key_exists($item, $oldarray)) {
            if (stripslashes($value) == $oldarray[$item]) {
                unset ($newarray[$item]);
            } // if
        } // if
    } // foreach

    return $newarray;

} // getChanges

// ****************************************************************************
function fixTrueFalse($lookup, $true, $false)
// update the $lookup array so that the keys 'true' and 'false' are changed
// to the values passed in $true and $false.
// For example, the input array of: 'true' => 'Yes', 'false' => 'No'
// could be changed to:             'Y'    => 'Yes', 'N'     => 'No'
{
    if (!array_key_exists($true, $lookup)) {
    	$value = $lookup['true'];
    	$lookup[$true] = $value;
    	unset($lookup['true']);
    } // if

    if (!array_key_exists($false, $lookup)) {
    	$value = $lookup['false'];
    	$lookup[$false] = $value;
    	unset($lookup['false']);
    } // if

    return $lookup;

} // fixTrueFalse

// ****************************************************************************
function getArrayInner ($array_in)
// $array contains elements from both the OUTER and INNER entities from a form,
// so return only those elements from the INNER entity.
// (INNER has multiple occurrences, so the values are arrays)
{
    $array_out = array();

    foreach ($array_in as $key => $value) {
    	if (is_array($value)) {
    	    $array_out[$key] = $value;
    	} else {
    		// ignore this entry
    	} // if
    } // foreach

    return $array_out;

} // getArrayInner

// ****************************************************************************
function getArrayOuter ($array_in)
// $array contains elements from both the OUTER and INNER entities from a form,
// so return only those elements from the OUTER entity.
// (OUTER has a single occurrence, so the values are arrays)
{
    $array_out = array();

    foreach ($array_in as $key => $value) {
    	if (is_array($value)) {
    		// ignore this entry
    	} else {
    		$array_out[$key] = $value;
    	} // if
    } // foreach

    return $array_out;

} // getArrayOuter

// ****************************************************************************
function getEntryPoint ($class)
// get the name of the first method that was used to access the specified class.
{
    if (is_object($class)) {
        // get class name for this object
        $classname   = get_class($class);
        $parentclass = get_parent_class($class);
    } else {
        // assume input is a string
        $classname   = $class;
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
    	    if (is_subclass_of($class, $array[$i]['class'])) {
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
        //$encoding = mb_detect_encoding($value);
        $value2 = convertEncoding($value, 'latin1', 'UTF-8');
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
        return $id ." $arg1 $arg2 $arg3 $arg4 $arg5";
    } // if

    $string = convertEncoding($string, 'latin1', 'UTF-8');

    if (!is_null($arg1)) {
        // insert argument(s) into string
    	$string = sprintf($string, $arg1, $arg2, $arg3, $arg4, $arg5);
    } // if

    return $string;

} // getLanguageText

// ****************************************************************************
function getMenuButtons ($task_id)
// return current menu buttons as an array.
{
    // DebugBreak();
    $role_id = $_SESSION['role_id'];

    // identify extra parameters for a JOIN, as follows:-
    // MNU_MENU identifies list of tasks which are attached to the current menu,
    // MNU_ROLE_TASK identifies which taks the members of the current role may access,
    // (this is ignored if GLOBAL_ACCESS is TRUE).
    // MNU_TASK holds task descriptions, and whether a particular task has ben disabled
    // (in which case it must also be removed from he selection)
    $dbmenu_sql_select = 'mnu_task.task_id, mnu_task.task_desc, mnu_menu.button_text, global_access, '
                        .'CASE WHEN mnu_role_task.role_id IS NOT NULL THEN 1 ELSE 0 END AS access_allowed';
    $dbmenu_sql_from   = 'mnu_menu '
                        .'LEFT JOIN mnu_task '
                        .'ON (mnu_task.task_id=mnu_menu.task_id_jnr) '
                        .'LEFT JOIN mnu_role_task '
                        ."ON (mnu_role_task.task_id=mnu_menu.task_id_jnr AND mnu_role_task.role_id='$role_id') "
                        .'LEFT JOIN mnu_role '
                        ."ON (mnu_role.role_id='$role_id')";
    $dbmenu_sql_where  = "(mnu_role_task.role_id IS NOT NULL or mnu_role.global_access='Y') "
                        ."AND (mnu_task.is_disabled='N')";

    require_once 'classes/mnu_menu.class.inc';
    $dbmenu =& singleton::getInstance('mnu_menu');
    $dbmenu->sql_select = $dbmenu_sql_select;
    $dbmenu->sql_from   = $dbmenu_sql_from;
    $dbmenu->sql_where  = $dbmenu_sql_where;

    $dbmenu_data = $dbmenu->getData("menu_id='$task_id'");

    $menu_buttons = array();
    foreach ($dbmenu_data as $data) {
        $menu_buttons[$data['task_id']] = $data['button_text'];
    } // foreach

    return $menu_buttons;

} // getMenuBttons

// ****************************************************************************
function getPreviousScript ($curr_task=null)
// return the name of the previous script in the current page stack
// (the one that called the current script).
{
    //DebugBreak();
    $page_stack = $GLOBALS['page_stack'];

    if (empty($curr_task)) {
        $PHP_SELF = getSelf();
        if (isset($_SESSION[$PHP_SELF]['task_id'])) {
            // default to task_id of current script
            $curr_task = $_SESSION[$PHP_SELF]['task_id'];
        } else {
            return; // nothing to return
        } // if
    } // if

    if (array_key_exists($curr_task, $page_stack)) {
        // look for the current task in the page stack
        // (starting at the end and work backwards)
        $end = end($page_stack);
        while (key($page_stack) != $curr_task) {
            // not found, so go back one entry
            $previous = prev($page_stack);
        } // while
        // pointer is now at current, so go back one more
        $previous = prev($page_stack);
    } //if

    // get script_id of this entry
    if (isset($previous)) {
        $script_id = $previous['script_id'];
        if (basename($script_id) == 'menu.php') {
            global $query_string;
            $query_string = 'selection=' .key($page_stack);
        } // if
    } else {
        $script_id = null;
    } // if

    return $script_id;

} // getPreviousScript

// ****************************************************************************
function getPreviousTask ($script_id=null)
// get the task identity associated with the previous script.
{
    //DebugBreak();
    if (empty($script_id)) {
        $script_id = getPreviousScript();
    } // if

    $task_id = $_SESSION[$script_id]['task_id'];

    return $task_id;

} // getPreviousTask

// ****************************************************************************
function getSelf ()
// reduce PHP_SELF to '/dir/file.php' to exclude all leading directory names.
{

    $PHP_SELF = '/' .basename(dirname($_SERVER['PHP_SELF']))
               .'/' .basename($_SERVER['PHP_SELF']);

    return $PHP_SELF;

} // getSelf

// ****************************************************************************
function getParentDIR ()
// get name of parent directory.
{

    $dir = dirname(dirname($_SERVER['PHP_SELF']));

    // if result is '\' or '/' (due to PHP bug) then replace with null
    if ($dir == '\\' or $dir == '/') $dir = null;

    return $dir;

} // getSelf

// ****************************************************************************
function getTimeStamp ($type=null)
// get timestamp in 'CCYY-MM-DD HH:MM:SS' format
{
    switch ($type) {
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
    //DebugBreak();
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
    //DebugBreak();
    if (is_string($where)) {
        // convert string into array
        $fieldarray = where2indexedArray($where);
    } else {
        // $where is already an array
        if (is_array(key($where))) {
            // indexed by row, so use first row only
            $fieldarray = $where[key($where)];
        } else {
            // use whole array
            $fieldarray = $where;
        } // if
    } // if

    if (version_compare(phpversion(), '4.4.1', '=')) {
        foreach ($fieldarray as $key => $value) {   // fix for version 4.4.1
            $fieldarray[$key] = $value;             // fix for version 4.4.1
        } // foreach                                // fix for version 4.4.1
    } // if
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
function mergeSettings ($string1, $string2)
// take 2 $settings strings and merge them into 1.
{
    if (empty($string1) and empty($string2)) {
    	return ''; // nothing to do
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
    //DebugBreak();
    if (strlen($where1) == 0) {
        return $where2;
    } elseif (strlen($where2) == 0) {
        return $where1;
    } // if

    // convert both clauses to arrays
    $array1 = where2indexedArray($where1);
    $array1 = indexed2assoc($array1);

    $array2 = where2indexedArray($where2);
    $array2 = indexed2assoc($array2);

    // merge the 2 arrays and convert the result back into a string
    $array3 = array_merge($array1, $array2);
    $where3 = array2where($array3);

    return $where3;

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

    //DebugBreak();
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
    foreach ($fieldspec as $fieldname => $spec) {
        // check if this fieldname exists in the string
        if (substr_count($input, "$fieldname") > 0) {
            // check to see if it is already qualified with the table name
            if (substr_count($input, ".$fieldname") == 0) {
                // no, so add tablename as a prefix
                $input = str_replace("$fieldname", "$tablename.$fieldname", $input);
            } // if
        } // if
    } // foreach

    return $input;

} // qualifyOrderby

// ****************************************************************************
function qualifyWhere (&$where, $tablename, $fieldspec=null)
// add table names to field names in 'where' string.
// ($where is passed by reference as it may be overwritten).
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

    $where1 = null;

    if (in_array('or', $fieldarray) or in_array('OR', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($where);
    	// process each row separately
        foreach ($fieldarray as $rownum => $rowdata) {
            // create an array for this row
            $array1 = where2array($rowdata);
            $array2 = array();
            foreach ($array1 as $fieldname => $fieldvalue) {
            	if (!strchr($fieldname, '.')) {
                    // if $fieldspec is supplied it must contain fieldname
                    if (empty($fieldspec) or array_key_exists($fieldname, $fieldspec)) {
                        // field is in current table, so insert qualified name
                        $array2["$tablename.$fieldname"] = $fieldvalue;
                    } else {
                        // field is not in current table, so leave it alone
                        $array2[$fieldname] = $fieldvalue;
                    } // if
                } else {
                    $array2[$fieldname] = $fieldvalue;
                } // if
            } // foreach
            // put modified details back into array
            $fieldarray[$rownum] = $array2;
        } // foreach

    } else {
        if (!is_string(key($fieldarray))) {
        	$fieldarray = indexed2assoc($fieldarray);       // convert indexed array to associative
            //$fieldarray = stripOperators($fieldarray);      // strip operators in front of values
        } // if
        // there may be more than one row in this array
        foreach ($fieldarray as $fieldname => $fieldvalue) {
            if (is_string($fieldname)) {
                // ignore if $fieldname is already qualified
                if (!strchr($fieldname, '.')) {
                    // if $fieldspec is supplied it must contain fieldname
                    if (empty($fieldspec) or array_key_exists($fieldname, $fieldspec)) {
                        // field is in current table, so insert qualified name
                        $array2["$tablename.$fieldname"] = $fieldvalue;
                    } else {
                        // field is not in current table, so leave it alone
                        $array2[$fieldname] = $fieldvalue;
                    } // if
                } else {
                    $array2[$fieldname] = $fieldvalue;
                } // if
            } else {
                $array2[] = $fieldvalue;
            } // if
        } // foreach
        $fieldarray = $array2;
    } // if

    if (is_array($where)) {
        // overwrite original with the new
        $where = $fieldarray;
    } //if

    $where1 = array2where($fieldarray);

    return $where1;

} // qualifyWhere

// ****************************************************************************
function selection2where ($pkeyarray, $select)
// turn selection into SQL 'where' criteria.
// $pkeyarray is an array of primary key name/value pairs for each row.
// $select identifies which row(s) have been selected.
{
    //DebugBreak();
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
    //DebugBreak();
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
        list($fieldname, $fieldvalue) = explode(' ', $where, 2);
        if (strpos($fieldvalue, '%') === false) {
            // use default operator
            $operator = '=';
        } else {
            // wildcard character found, so use LIKE
            $operator = 'LIKE';
        } // if
        // enclose value in single quotes (ensuring it hasn't been done already)
        $fieldvalue = "'" .addslashes(stripslashes($fieldvalue)) ."'";
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
function splitWhereByRow ($where)
// convert $where into an array with ' OR ' being used to create a new row.
{
    //DebugBreak();
    // convert string into an array
    $array1 = where2indexedArray($where);

    $array2  = array();
    $string2 = '';
    foreach ($array1 as $rownum => $string) {
    	if (eregi('^OR$', $string, $regs)) {
            // write current details out as a string in its own row
            $array2[] = $string2;
            $string2  = '';
        } else {
            if ($string == '(' or $string == ')' ) {
                // ignore
            } else {
            	// append to current string
        	    $string2 .= $string .' ';
            } // if
        } // if
    } // foreach

    if (!empty($string2)) {
        $array2[] = $string2;
    } // if

    //$array3 = array2where($array2);

    return $array2;

} // splitWhereByRow

// ****************************************************************************
function stripOperators ($fieldarray)
// change an array containing 'name=value' pairs so that the value portion
// does not contain any comparison operators or enclosing single quotes.
{
    if (is_array($fieldarray)) {
        foreach ($fieldarray as $fieldname => $fieldvalue) {
            //if (preg_match('/^(=|LIKE |IS )/i', ltrim($fieldvalue), $operator)) {
            if (preg_match('/^(=|LIKE )/i', ltrim($fieldvalue), $operator)) {
                $fieldvalue = ltrim($fieldvalue, $operator[0]);
                $fieldvalue = trim($fieldvalue);

                // the next character is the delimiter (single or double quote)
                $delimiter = substr($fieldvalue, 0, 1);
                if ($delimiter == '"' or $delimiter == "'") {
                    // delimiter found, so remove from both ends of string
                    $fieldvalue = substr($fieldvalue, 1);
                    $fieldvalue = substr($fieldvalue, 0, -1);
                } // if

                $fieldarray[$fieldname] = stripslashes($fieldvalue);
            } // if
        } // foreach
    } // if

    return $fieldarray;

} // stripOperators

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
    if (in_array('or', $fieldarray) or in_array('OR', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($where);
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
function validateSortItem ($zone, $sortfield, $screen)
// check that the sort field actually exists in the current screen.
// this stops a naughty user from manually altering the URL to point to
// a field name that does not exist, thus causing an error.
{
    $sortfield = strtolower($sortfield);

    if ($sortfield == 'selectbox') {
    	return FALSE; // cannot sort on this field
    } // if

    // get subdirectory which matches user's language code
    $subdir = getLanguageSubDir ('./screens');

    $screen = "$subdir/$screen";  // look in subirectory for this screen name
    if (!file_exists($screen)) {
        // 'File $screen cannot be found'
        trigger_error(getLanguageText('sys0056', $screen), E_USER_ERROR);
    } // if

    require $screen;              // import contents of disk file

    foreach ($structure[$zone]['fields'] as $array) {
    	if (array_key_exists($sortfield, $array)) {
    		return TRUE;
    	} // if
    } // foreach

    return FALSE;

} // validateSortItem

// ****************************************************************************
function where2array ($where, $pageno=null)
// change an SQL 'where' string into an association array of field names and values.
// this function has the following steps:
// 1 - convert string into an indexed array
// 2 - convert index array into an associative array
// 3 - strip operators from the associative array
{
    // if input string is empty there is nothing to do
    if (empty($where)) return array();

    $array1 = where2indexedArray($where);   // convert string into indexed array

    if (in_array('or', $array1) or in_array('OR', $array1)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$array1 = splitWhereByRow($where);
    	if ($pageno > 0) {
            // $pageno starts at 1, but array starts at 0
            $pageno = $pageno -1;
            // set to selected row (as signified in $pageno)
        	$array1 = array($array1[$pageno]);
        	$array1 = where2indexedArray($array1);
        } // if
    } // if

    $array2 = indexed2assoc($array1);       // convert indexed array to associative
    $array3 = stripOperators($array2);      // strip operators in front of values

    return $array3;

} // where2array

// ****************************************************************************
function where2indexedArray ($where)
// change an SQL 'where' clause into an array of field names and values
// $where is in the format: (name='value' AND name='value' AND ...)
// or possibly: (name='value' AND name='value') OR (name='value' AND name='value') OR ...
// or possibly: (name BETWEEN 'value1' AND 'value2' AND name='value') ...
// or possibly: (name='something=\'this\'' AND somethingelse=\'that\'')
{
    //DebugBreak();
    // if input string is empty therealue is nothing to do
    if (empty($where)) return array();

    if (is_array($where)) {
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

            $lastchar = substr($fieldvalue, -1);
            if ($lastchar == ')') {
                // remove trailing parenthesis
                $fieldvalue = substr($fieldvalue, 0, -1);
            } // if

            // add this $fieldname/$fieldvalue pair to the output array
            $array[] = $fieldname .$operator .$fieldvalue;

            if ($lastchar == ')') {
                $array[] = $lastchar;
            } // if

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

    if (version_compare(phpversion(), '4.4.1', '=')) {
        foreach ($fieldlist as $key => $value) {   // fix for version 4.4.1
            $fieldlist[$key] = $value;             // fix for version 4.4.1
        } // foreach                               // fix for version 4.4.1
    } // if
    if (!is_string(key($fieldlist))) {
        // flip indexed array so that the values become keys
        $fieldlist = array_flip($fieldlist);
    } // if

    if (in_array('or', $fieldarray) or in_array('OR', $fieldarray)) {
        // $where contains multiple selections in the format "(...) OR (...)" so...
        // split into separate selections (rows)
    	$fieldarray = splitWhereByRow($where);
    	// process each row separately
    	$array2 = array();
        foreach ($fieldarray as $rownum => $rowdata) {
        	$array1 = where2array($rowdata);
        	foreach ($array1 as $fieldname => $fieldvalue) {
        		// if $fieldname is qualified with current $tablename, then unqualify it
                $fieldname = str_replace("$tablename.", '', trim($fieldname));
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
        if (!is_string(key($fieldarray))) {
        	$fieldarray = indexed2assoc($fieldarray);       // convert indexed array to associative
            $fieldarray = stripOperators($fieldarray);      // strip operators in front of values
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

} // WhereFilter

// ****************************************************************************
?>
