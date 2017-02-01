<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class validation_class
{
    // member variables
    var $caller;                    // details of calling object
    var $dateobj;                   // date object
    var $errors;                    // array of error messages
    var $fields_not_for_trimming;   // array of field names which are not to be trimmed
    var $unique_keys;               // array of candidate (unique) keys

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {

    } // __construct

    // ****************************************************************************
    function getErrors ()
    // return the array of error messages.
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function validateCustom ($fieldname, $fieldvalue, $fieldspec)
    // standard function for invoking custom validation.
    {
        $errors = array();

        $custom_validation = $fieldspec['custom_validation'];

        $translated_fieldname = getLanguageText($fieldname);

        // split $custom_validation into its component parts
        list($file, $class, $method) = explode('/', $custom_validation);

        if (!$fp = fopen($file, 'r', true)) {
            $file = 'classes/' .$file;
            if (!$fp = fopen($file, 'r', true)) {
            	// 'custom validation - File X does not exist'
                $this->errors[$fieldname] = getLanguageText('sys0157', $file);
                return $fieldvalue;
            } // if
        } // if
        fclose($fp);
        require_once($file);

        if (!class_exists($class)) {
        	// 'custom validation - Class X does not exist'
        	$errors[$fieldname] = getLanguageText('sys0158', $class);
        } // if
        $object =& RDCsingleton::getInstance($class);

        if (!method_exists($object, $method)) {
        	// 'custom validation - Method X does not exist'
        	$errors[$fieldname] = getLanguageText('sys0159', $method);
        } // if

        if (empty($errors)) {
            // call specified method in custom validation object
        	$failure = $object->$method($fieldvalue, $fieldspec);
            if ($failure) {
                $errors[$fieldname] = $failure;
            } // if
        } // if

        if ($errors) {
        	$this->errors = array_merge($this->errors, $errors);
        } // if

        return $fieldvalue;

    } // validateCustom

    // ****************************************************************************
    function validateEmail ($fieldname, $fieldvalue)
    // standard function for validating email addresses.
    {
        // there may be multiple addresses separated by ',' (comma)
        $addresses = explode(',', $fieldvalue);

        if (version_compare(phpversion(), '5.2.0', '>=')) {
            // use the new function
            foreach ($addresses as $entry) {
                if (filter_var($entry, FILTER_VALIDATE_EMAIL) === false) {
                    // 'Invalid format for e-mail address.'
                    $this->errors[$fieldname] = getLanguageText('sys0039');
                    return;
                } // if
            } // foreach
            return;
        } // if

        // look for 'user@hostname.domain'
        $pattern1 = <<< END_OF_REGEX
/
^                     # begins with
[a-z0-9_-]+           # valid chars (at least once)
(\.[a-z0-9_-]+)*      # dot valid chars (0-n times)
@                     # at
[a-z0-9][a-z0-9-]*    # valid chars (at least once)
(\.[a-z0-9-]+)*       # dot valid chars (0-n times)
\.([a-z]{2,6})$       # ends with dot valid chars
/xi
END_OF_REGEX;

        $pattern2 = <<< END_OF_REGEX
;                                  # start pattern
^                                  # begins with
[a-z0-9!#$%&'*+/=?^_`{|}~-]+       # valid chars (at least once)
(\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*  # dot valid chars (0-n times)
@                                  # at
[a-z0-9][a-z0-9-]*                 # valid chars (at least once)
(\.[a-z0-9-]+)*                    # dot valid chars (0-n times)
\.([a-z]{2,})$                     # ends with dot valid chars
;xi
END_OF_REGEX;

        foreach ($addresses as $entry) {
        	// look for 'name <user@hostname.domain>'
            if (preg_match('/(?<=<).*(?=>)/', $entry, $regs)) {
                // extract everything between '<' and >'
            	$address = $regs[0];
            } else{
                $address = $entry;
            } // if

            if (!preg_match($pattern2, trim($address), $regs)) {
                // 'Invalid format for e-mail address.'
                $this->errors[$fieldname] = getLanguageText('sys0039');
                return;
            } // if
        } // foreach

        return;

    } // validateEmail

    // ****************************************************************************
    function validateField ($fieldname, $fieldvalue, $fieldspec)
    // standard function for validating database fields.
    {
        $classdir = $GLOBALS['classdir'];   // save

        $errors = array();

        // find user-friendly version of $fieldname
        $callingOBJ =& $this->caller;
        $GLOBALS['classdir'] = dirname($callingOBJ->dirname);
        $translated_fieldname = $callingOBJ->getLanguageText($fieldname);
        $this->dateobj =& RDCsingleton::getInstance('date_class');

        $GLOBALS['classdir'] = $classdir;   // restore

        $allow_db_function =& $callingOBJ->allow_db_function;

        if (!is_array($this->fields_not_for_trimming)) {
            if (is_string($this->fields_not_for_trimming)) {
                $this->fields_not_for_trimming = array($this->fields_not_for_trimming);
            } else {
                $this->fields_not_for_trimming = array();
            } // if
        } // if
        // ensure all names are in lower case
        foreach ($this->fields_not_for_trimming as $key => $value) {
        	$this->fields_not_for_trimming[$key] = strtolower($value);
        } // foreach

        if (isset($fieldspec['type']) AND $fieldspec['type'] == 'enum') {
            // get enum array for this field
            $enum = $callingOBJ->getValRep($fieldname);
            // if we already have the value do not replace it
            if (!in_array($fieldvalue, $enum)) {
                // replace index number with text value
                $fieldvalue = $enum[$fieldvalue];
            } // if
        } // if

        if (isset($fieldspec['type']) AND preg_match('/(set|array|varray)/i', $fieldspec['type'])) {
            // convert $fieldvalue array into a string with comma separator
            if (is_array($fieldvalue)) {
                foreach ($fieldvalue as $key => $value) {
                	if (strlen(trim($value)) == 0) {
                		unset($fieldvalue[$key]);
                	} // if
                } // foreach
            	$fieldvalue = implode($fieldvalue, ',');
            } // if
        } // if

        if (in_array($fieldname, $this->fields_not_for_trimming)) {
            // do not trim() this field
        } else {
            if (strlen($fieldvalue) > 0) {
                // trim any leading or trailing spaces
                $fieldvalue = trim($fieldvalue);
            } // if
        } // if

        if (strlen($fieldvalue) == 0) {
            // value is empty, but is there a default which can be inserted?
            if ($fieldname == 'rdcaccount_id') {
            	// this table is split by account, so insert user's account_id
            	if (isset($_SESSION['rdcaccount_id']) AND $_SESSION['rdcaccount_id'] > 1) {
            	    $fieldvalue = $_SESSION['rdcaccount_id'];
            	} elseif ($callingOBJ->tablename == 'mnu_account') {
            	    // value will be generated automatically
            	} elseif ($callingOBJ->tablename == 'mnu_user') {
            	    // value is optional
            	} else {
            	    // default to the shared account
            	    $fieldvalue = 1;
            	} // if
            } elseif (isset($fieldspec['default'])) {
                if (isset($fieldspec['autoinsert'])
                 or isset($fieldspec['auto_increment'])) {
                    // value will be filled in later
                    unset($fieldspec['required']);

                } elseif (isset($fieldspec['optionlist'])) {
                    // get list of options for this field
                    $optionlist =& $callingOBJ->lookup_data[$fieldspec['optionlist']];
                    if (empty($optionlist)) {
                        // no options found, so use default value
                    	$fieldvalue = $fieldspec['default'];
                    } elseif (array_key_exists($fieldspec['default'], $optionlist)) {
                        // default value found in list, so use it
                    	$fieldvalue = $fieldspec['default'];
                    } // if

                } elseif (isset($fieldspec['control']) and $fieldspec['control'] == 'popup') {
                    // only use default value if it is non-zero
                    if (is_string($fieldspec['control']) AND $fieldspec['control'] == '0') {
                        // ignore this value
                    } elseif (is_numeric($fieldspec['control']) AND $fieldspec['control'] == 0) {
                        // ignore this value
                    } else {
                    	$fieldvalue = $fieldspec['default'];
                    } // if

                } elseif ($fieldspec['type'] == 'timestamp' AND $fieldspec['default'] == 'CURRENT_TIMESTAMP') {
                    // value will be filled in later, so continue
                    unset($fieldspec['required']);

                } else {
                    // load default value
                    $fieldvalue = $fieldspec['default'];
                } // if
			} elseif (isset($fieldspec['type']) AND preg_match('/(decimal|numeric|integer|float|real|double)/i', $fieldspec['type'])) {
				$fieldvalue = null;  // numeric fields cannot be set to an empty string, so use NULL instead
            } // if
        } // if

        if (isset($fieldspec['type']) AND $fieldspec['type'] == 'boolean' AND is_bool($fieldvalue)) {
            // convert BOOLEAN to correct values
            if (isset($fieldspec['true']) AND $fieldvalue === true) {
                $fieldvalue = $fieldspec['true'];
            } elseif (isset($fieldspec['false']) AND $fieldvalue === false) {
                $fieldvalue = $fieldspec['false'];
            } // if
        } // if

        if (strlen($fieldvalue) == 0 AND !is_bool($fieldvalue)) {
            // field is empty - is it allowed to be?
            if (isset($fieldspec['required'])) {
                if (isset($fieldspec['autoinsert'])
                 or isset($fieldspec['auto_increment'])) {
                    // value will be filled in later, so continue
                } else {
                    // '$fieldname cannot be blank'
                    $errors[$fieldname] = $callingOBJ->getLanguageText('sys0020', $translated_fieldname);
                } // if
            } // if
            if (isset($fieldspec['type'])) {
                if (preg_match('/(date)/i', $fieldspec['type'])) {
                    if (isset($fieldspec['infinityisnull'])) {
                        $fieldvalue = '9999-12-31';
                    } // if
                } // if
                if (preg_match('/(datetime)/i', $fieldspec['type'])) {
                    if (isset($fieldspec['infinityisnull'])) {
                        $fieldvalue = '9999-12-31 23:59:59';
                    } // if
                } // if
                if ($fieldspec['type'] == 'boolean') {
                    if (isset($fieldspec['false'])) {
                	    $fieldvalue = $fieldspec['false'];
                    } else {
                        $fieldvalue = false;
                    } // if
                } // if
            } // if
            // nothing left to validate, so return now
            $this->errors = array_merge($this->errors, $errors);
            return $fieldvalue;
        } // if

        // field is not empty - check field size
        if (isset($fieldspec['size'])) {
            if (preg_match('/(set|array|varray|datetime|timestamp)/i', $fieldspec['type'])) {
                // ignore size on these datatypes
            } else {
                if (is_array($allow_db_function) AND in_array($fieldname, $allow_db_function)) {
                    // this is a function call, not a value, so leave it alone
                } else {
                    $size = (double)$fieldspec['size'];
                    if (preg_match('/(decimal|numeric|float|real|double)/i', $fieldspec['type'])) {
                        // remove thousands separator and ensure decimal point is '.'
                        $fieldvalue = number_unformat($fieldvalue, '.', ',');
                        if (preg_match("/^$fieldname"."[+-][1-9]+/i", $fieldvalue)) {
                            // assume value is in format 'field+1', so let it through
                        } elseif (array_key_exists('scale', $fieldspec)) {
                            if (is_numeric($fieldvalue)) {
                                // round to the correct number of decimal places
                                $fieldvalue = number_format($fieldvalue, $fieldspec['scale'], '.', '');
                            } // if
                        } // if
                    } // if
                    if (preg_match('/(float|real|double)/i', $fieldspec['type'])) {
                	    if (is_numeric($fieldvalue) AND strlen($fieldvalue) > $size) {
                	        // reduce huge number to scientific notation
                		    $fieldvalue = sprintf('%e', $fieldvalue);
                	    } // if
                    } // if
                    if (strlen($fieldvalue) > $size) {
                        if (preg_match('/(decimal|numeric|integer|float|real|double)/i', $fieldspec['type']) AND preg_match("/^$fieldname"."[+-][1-9]+/i", $fieldvalue)) {
                            // assume value is in format 'field+1', so let it through
                        } elseif (function_exists('mb_strlen')) {
                            $encoding = mb_detect_encoding($fieldvalue);
                            if (mb_strlen($fieldvalue, $encoding) > $size) {
                        	    // '$fieldname cannot be > $size characters
                                $errors[$fieldname] = $callingOBJ->getLanguageText('sys0021', $translated_fieldname, $size);
                            } // if
                        } else {
                            // '$fieldname cannot be > $size characters
                            $errors[$fieldname] = $callingOBJ->getLanguageText('sys0021', $translated_fieldname, $size);
                        } // if
                    } // if
                } // if
            } // if
        } // if

        if (!empty($errors)) {
            $this->errors = array_merge($this->errors, $errors);
        	return $fieldvalue;
        } // if

        if (!empty($fieldspec['custom_validation'])) {
        	$fieldvalue = $this->validateCustom($fieldname, $fieldvalue, $fieldspec);
        	return $fieldvalue;
        } // if

        switch ($fieldspec['type']) {
            case '':
                // this points to an error in the dictionary export function
                $this->errors[$fieldname] = $callingOBJ->getLanguageText('sys0036', 'null');
                break;

            case 'enum':
                break;

            case 'boolean':
                // result from boolean fields may be varied, so convert to TRUE or FALSE
                // (where actual values are defined within $fieldspec)
                if (is_True($fieldvalue)) {
                    if (isset($fieldspec['true'])) {
                    	$fieldvalue = $fieldspec['true'];
                    } // if
                } else {
                    if (isset($fieldspec['false'])) {
                    	$fieldvalue = $fieldspec['false'];
                    } // if
                } // if
                break;

            case 'set':
            case 'array':
            case 'string':
                if (isset($fieldspec['uppercase'])) {
                    // value in this field must be uppercase
                    if (function_exists('mb_strtoupper')) {
                    	$fieldvalue = mb_strtoupper($fieldvalue);
                    } else {
                        $fieldvalue = strtoupper($fieldvalue);
                    } // if
                } elseif (isset($fieldspec['lowercase'])) {
                    // value in this field must be lowercase
                    if (function_exists('mb_strtolower')) {
                        $fieldvalue = mb_strtolower($fieldvalue);
                    } else {
                        $fieldvalue = strtolower($fieldvalue);
                    } // if
                } // if

                if (strpos($fieldvalue, '%') === false) {
                    // field does not contain the '%' (wildcard) character
                } else {
                    if (!empty($fieldspec['pkey'])) {
                        // 'Must not use wildcard character (%) in a primary or unique key'
                        $this->errors[$fieldname] = getLanguageText('sys0017');
                    } elseif (is_array($this->unique_keys) AND !empty($this->unique_keys)) {
                        foreach ($this->unique_keys as $keynum => $fields) {
                            if (in_array($fieldname, $fields)) {
                                // 'Must not use wildcard character (%) in a primary or unique key'
                                $this->errors[$fieldname] = getLanguageText('sys0017');
                            } // if
                        } // foreach
                    } // if
                } // if

                if (isset($fieldspec['subtype'])) {
                    // perform any subtype processing
                    switch ($fieldspec['subtype']) {
                        case 'button':
                            break;
                        case 'filename':
                        case 'image':
                        case 'video':
                            if ($fieldspec['subtype'] == 'video' AND preg_match('/^http/i', $fieldvalue)) {
                                // this is a URL, so do not validate it
                            } else {
                                // check that value is a valid file name
                                $try = $fieldvalue;
                                if (!file_exists($try)) {
                                    // 'Filename does not exist'
                                    if (!empty($callingOBJ->picker_subdir)) {
                                	    $try = $callingOBJ->picker_subdir .'/' .$fieldvalue;
                                    } // if
                                    if (!file_exists($try)) {
                                        $this->errors[$fieldname] = $callingOBJ->getLanguageText('sys0057', $fieldvalue);
                                    } // if
                                } // if
                            } // if
                            break;
                        case 'email':
                            // check that value is a valid email address
                            $this->validateEmail($fieldname, $fieldvalue);
                            break;
                        default:
                            // '$fieldname: specification for subtype is invalid'
                            $this->errors[$fieldname] = $callingOBJ->getLanguageText('sys0037', $translated_fieldname, 'subtype');
                    } // switch
                } // if

                if (isset($fieldspec['password'])) {
                    // passwords may have a 'hash' specification
                    if (isset($fieldspec['hash'])) {
                        switch ($fieldspec['hash']) {
                            case 'md5':
                                $fieldvalue = md5($fieldvalue);
                                break;
                            case 'sha1':
                                $fieldvalue = sha1($fieldvalue);
                                break;
                            case 'custom':
                                break;
                            default:
                                // '$fieldname: specification for hash is invalid'
                                $this->errors[$fieldname] = $callingOBJ->getLanguageText('sys0037', $translated_fieldname, 'hash');
                        } // switch
                    } // if
                } // if

                if (isset($fieldspec['control']) AND $fieldspec['control'] == 'multiline') {
                    // replace CRLF with LF as it sometimes results in two linefeeds
                    $fieldvalue = str_replace("\r\n", "\n", $fieldvalue);
                } // if

                break;

            case 'blob':
                break;

            case 'date':
                // value must be a date
                if (!$internaldate = $this->dateobj->getInternalDate($fieldvalue)) {
                    $this->errors[$fieldname] = "$translated_fieldname: " . $this->dateobj->getErrors();
                } else {
                    // set date to internal format
                    $fieldvalue = $internaldate;
                } // if
                break;

            case 'datetime':
            case 'timestamp':
                if ($fieldvalue == 'now()') {
                    // let this through
                } elseif ($fieldvalue == '0000-00-00 00:00:00') {
                    // let this through
                } else {
                    // value must be a combined date and time
                    if (!$internaldatetime = $this->dateobj->getInternalDateTime($fieldvalue, $fieldspec)) {
                        $this->errors[$fieldname] = "$translated_fieldname: " . $this->dateobj->getErrors();
                    } else {
                        // set date to internal format
                        $fieldvalue = $internaldatetime;
                    } // if
                } // if
                break;

            case 'time':
                // value must be a time
                if (!$internaltime = $this->dateobj->getInternaltime($fieldvalue)) {
                    $this->errors[$fieldname] = "$translated_fieldname: " . $this->dateobj->getErrors();
                } else {
                    // set time to internal format
                    $fieldvalue = $internaltime;
                } // if
                break;

            default:
                if (is_array($allow_db_function) AND in_array($fieldname, $allow_db_function)) {
                    // this is a function call, not a value, so leave it alone
                } else {
                    // perform validation if field type is numeric (integer, decimal)
                    $ini_precision = ini_get('precision');
                    if (isset($fieldspec['size']) AND $fieldspec['size'] > $ini_precision) {
                        ini_set('precision', $fieldspec['size']);
                    } // if
                    $fieldvalue = $this->validateNumber($fieldname, $fieldvalue, $fieldspec);
                    ini_set('precision', $ini_precision);
                } // if
        } // switch

        return $fieldvalue;

    } // validateField

    // ****************************************************************************
    function validateInsert ($fieldarray, $fieldspec, &$caller)
    // Validate contents of $fieldarray against $fieldspec array.
    // Errors are returned in $errors array.
    // NOTE: for INSERT all fields contained in $fieldspecs must be present.
    {
        $this->errors = array();

        $this->caller = &$caller;

        $this->fields_not_for_trimming = $caller->fields_not_for_trimming;

        $this->unique_keys = $caller->unique_keys;

        // create array to hold data which has been formatted for the database
        $insertarray = array();

        // step through each fieldspec entry and compare with input data
        foreach ($fieldspec as $field => $spec) {
            if (isset($spec['mustvalidate'])) {
                unset($spec['nondb']);  // allow a non-database field to be validated
            } // if
            if (isset($spec['novalidate']) OR isset($spec['nondb']) OR isset($spec['autoinsert'])) {
                // ignore this field
            } else {
                if (isset($fieldarray[$field])) {
                    $value = $fieldarray[$field];
                } else {
                    $value = null;
                } // if
                $value = $this->validateField($field, $value, $spec);
                // transfer to array which will be passed to the database
                // (remember that a null value is not the same as no value at all)
                if (strlen($value) > 0) {
                    $insertarray[$field] = $value;
                } else {
                    $insertarray[$field] = null;
                } // if
            } // if
        } // foreach

        return $insertarray;

    } // validateInsert

    // ****************************************************************************
    function validateNumber ($field, $value, $spec)
    // if $spec identifies $field as a number then check that $value is within range.
    {
        $callingOBJ =& $this->caller;

        if (preg_match("/^$field"."[+-][1-9]+/i", $value)) {
            // assume value is in format 'field+1', so let it through
            return $value;
        } // if

        // check if field type = integer (whole numbers only)
        $pattern = '/(int1|tinyint|int2|smallint|int3|mediumint|int4|integer|int8|bigint|int)/i';
        if (preg_match($pattern, $spec['type'], $match)) {
            while (strlen($value) > 1 AND substr($value, 0, 1) === '0'){
                $value = substr($value, 1);  // strip leading zero (except the only zero)
            } // while
            // test that input contains a valid value for an integer field (note that BIGINT is not supported yet)
            if (version_compare(phpversion(), '5.2.0', '>=') AND $value <= 2147483648) {
                $number = $value;
                if (filter_var($number, FILTER_VALIDATE_INT) === false) {
                    // 'Value is not a whole number'
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0029');
                    return $value;
                } // if
            } else {
                $number = (double)$value;
                $number = floor($number); // remove any decimal places
                if ((string)$value <> (string)$number) {
                    // 'Value is not a whole number'
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0029');
                    return $value;
                } // if
            } // if

            if (isset($spec['minvalue'])) {
                // obtain value from $fieldspec
                $minvalue = (double)$spec['minvalue'];
            } else {
                $minvalue = 0;
            } // if

            if ($number < $minvalue) {
                // 'Value is below minimum value'
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0024', $minvalue);
            } // if

            if (isset($spec['maxvalue'])) {
                // obtain value from $fieldspec
                $maxvalue = (double)$spec['maxvalue'];
            } else {
                if (isset($spec['size'])) {
                	$precision = (int)$spec['size'];
                } else {
                    $precision = 3;
                } // if
                $maxvalue = (int)str_repeat('9', $precision);
            } // if

            if ($number > $maxvalue) {
                // 'Value is above maximum value'
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0025', $maxvalue);
            } // if

            if (isset($spec['zerofill'])) {
                while (strlen($value) < $spec['size']) {
                    $value = '0' . $value;
                } // while
            } // if

            return $value;

        } // if

        // check if field type = numeric (with optional decimal places)
        $pattern = '/(decimal|numeric)/i';
        if (preg_match($pattern, $spec['type'], $match)) {
            // input must at least be numeric to begin with
            if (version_compare(phpversion(), '5.2.0', '>=')) {
                if (filter_var($value, FILTER_VALIDATE_FLOAT) === false) {
                    // 'value is not numeric'
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0023', $value);
                    return $value;
                } // if
            } else {
                if (!is_numeric(trim($value))) {
                    // 'value is not numeric'
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0023', $value);
                    return $value;
                } // if
            } // if

            // value for 'precision' must be present
            if (isset($spec['precision'])) {
                $precision = (int)$spec['precision'];
            } elseif (isset($spec['size'])) {
                $precision = (int)$spec['size'];
            } else {
                // 'Specification missing for PRECISION'
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0026');
                return $value;
            } // if

            // value for 'scale' is optional (default is zero)
            if (isset($spec['scale'])) {
                $scale = (int)$spec['scale'];
            } else {
                $scale = 0;
            } // if

            // minvalue includes negative sign
            $minvalue = '-' . str_repeat('9', $precision-1);

            // maxvalue has no positive sign
            $maxvalue = (int)str_repeat('9', $precision);
            if ($scale > 0) {
                // adjust values to include decimal places
                $minvalue = $minvalue / pow(10, $scale);
                $maxvalue = $maxvalue / pow(10, $scale);
            } // if

            // adjust min value if value is unsigned
            if (isset($spec['unsigned'])) {
                $minvalue = 0;
            } // if

            if (isset($spec['minvalue'])) {
                // override with value provided in $fieldspec
                $minvalue = (float)$spec['minvalue'];
            } // if

            if ($value < $minvalue) {
                // 'Value is below minimum value'
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0024', $minvalue);
            } // if

            if (isset($spec['maxvalue'])) {
                // override with value provided in $fieldspec
                $maxvalue = (float)$spec['maxvalue'];
            } // if

            if ($value > $maxvalue) {
                // 'Value is above maximum value'
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0025', $maxvalue);
            } // if

            // set to internal format
            $value = number_format($value, $scale, '.', '');

            return $value;

        } // if

        // check if field type = floating point
        $pattern = '/(float|double|real)/i';
        if (preg_match($pattern, $spec['type'], $match)) {
            // cast the input value into its designated type
            switch ($match[0]) {
                case 'float':
                    $number = (float)$value;
                    break;
                case 'double':
                    $number = (double)$value;
                    break;
                case 'real':
                    $number = (real)$value;
                default: ;
            } // switch

            if (!is_numeric($value)) {
                // "Value is not a number";
                $this->errors[$field] = $callingOBJ->getLanguageText('sys0022', $value);
                return $value;
            } // if

            if ((string)$value <> (string)$number) {
                // values do not match
                if (is_float($number)) {
                    $number = number_format($number, 0, '', '');
                } // if
                $valuelen  = strlen($value);
                $numberlen = strlen($number);
                if ($valuelen > $numberlen) {
                    // "Value has too many digits";
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0027');
                    return $number;
                } // if
            } // if
            //
            if (isset($spec['unsigned'])) {
                if ($number < 0) {
                    // "Value cannot be negative";
                    $this->errors[$field] = $callingOBJ->getLanguageText('sys0028');
                    return $value;
                } // if
            } // if

            return $value;

        } // if

        // "Unknown value for 'type': {$spec['type']}";
        $this->errors[$field] = $callingOBJ->getLanguageText('sys0036', $spec['type']);

        return $value;

    } // validateNumber

    // ****************************************************************************
    function validateUpdate ($fieldarray, $fieldspec, &$caller)
    // validate contents of $fieldarray against $fieldspec array.
    // errors are returned in $errors array.
    // NOTE: for UPDATE only a subset of fields may be supplied.
    {
        $this->errors = array();

        $this->caller = &$caller;

        $this->fields_not_for_trimming = $caller->fields_not_for_trimming;

        $this->unique_keys = $caller->unique_keys;

        // create array to hold data which has been formatted for the database
        $updatearray = array();

        // step through input data and validate each field in turn
        foreach ($fieldarray as $field => $value) {
            if (array_key_exists($field, $fieldspec)) {
                $spec = $fieldspec[$field];
                if (isset($spec['mustvalidate'])) {
                    unset($spec['nondb']);  // allow a non-database field to be validated
                } // if
                if (isset($spec['novalidate']) OR isset($spec['nondb']) OR isset($spec['autoinsert'])) {
                    // ignore this field
                } else {
                    // validate field using field specifications
                    $value = $this->validateField($field, $value, $spec);
                    // transfer to array which will be passed to the database
                    // (allow null values as field may have been cleared)
                    if (strlen($value) > 0 OR in_array($field, $caller->primary_key)) {
                        $updatearray[$field] = $value;
                    } else {
                        $updatearray[$field] = null;
                    } // if
                } // if
            } elseif (preg_match('/^rdc_/i', $field)) {
                // allow this framework instruction to carry on through
                $updatearray[$field] = $value;
            } // if
        } // foreach

        return $updatearray;

    } // validateUpdate

// ****************************************************************************
} // end validation_class
// ****************************************************************************

?>
