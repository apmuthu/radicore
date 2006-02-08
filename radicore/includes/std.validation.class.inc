<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class validation_class
{
    // member variables
    var $caller;            // details of calling object
    var $errors;            // array of error messages

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function validation_class()
    {

    } // validation_class

    // ****************************************************************************
    function getErrors ()
    // return the array of error messages.
    {
        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function validateEmail ($fieldname, $fieldvalue)
    // standard function for validating email addresses.
    {
        // look for 'user@hostname.domain'
        $pattern = "/"                      // start pattern
                 . "^[a-z0-9_-]+"           // valid chars (at least once)
                 . "(\.[a-z0-9_-]+)*"       // dot valid chars (0-n times)
                 . "@"                      // at
                 . "[a-z0-9][a-z0-9-]*"     // valid chars (at least once)
                 . "(\.[a-z0-9-]+)*"        // dot valid chars (0-n times)
                 . "\.([a-z]{2,6})$"        // dot valid chars
                 . "/i";                    // end pattern, case insensitive

        if (!preg_match($pattern, $fieldvalue)) {
            // 'Invalid format for e-mail address.'
            $this->errors[$fieldname] = getLanguageText('sys0039');
        } // if

        return;

    } // validateEmail

    // ****************************************************************************
    function validateField ($fieldname, $fieldvalue, $fieldspec)
    // standard function for validating database fields.
    {
        //DebugBreak();
        static $dateobj;

        if (!isset($dateobj)) {
            require_once 'std.datevalidation.class.inc';
            $dateobj =& singleton::getInstance('date_class');
        } // if

        if ($fieldspec['type'] == 'enum') {
            // get enum array for this field
            $enum = $this->caller->getValRep($fieldname);
            // if we already have the value do not replace it
            if (!in_array($fieldvalue, $enum)) {
                // replace index number with text value
                $fieldvalue = $enum[$fieldvalue];
            } // if
        } // if

        // trim any leading or trailing spaces
        $fieldvalue = trim($fieldvalue);

        if (strlen($fieldvalue) == 0) {
            // field is empty - is it allowed to be?
            if (isset($fieldspec['required'])) {
                if (isset($fieldspec['autoinsert'])
                 or isset($fieldspec['auto_increment'])) {
                    // value will be filled in later, so continue
                } elseif (isset($fieldspec['default'])) {
                    $fieldvalue = $fieldspec['default'];
                } else {
                    // '"$fieldname cannot be blank'
                    $this->errors[$fieldname] = getLanguageText('sys0020', $fieldname);
                } // if
            } // if
            if ($fieldspec['type'] == 'date' or $fieldspec['type'] == 'datetime'
                                             or $fieldspec['type'] == 'timestamp') {
                if (isset($fieldspec['infinityisnull'])) {
                    $fieldvalue = '9999-12-31';
                } // if
            } // if
            if ($fieldspec['type'] == 'boolean') {
                $fieldvalue = $fieldspec['false'];
            } // if
            // nothing left to validate, so return now
            return $fieldvalue;
        } // if

        // field is not empty - check field size
        if (isset($fieldspec['size'])) {
            $size = (int)$fieldspec['size'];
            if (strlen($fieldvalue) > $size) {
                // '$fieldname cannot be > $size characters
                $this->errors[$fieldname] = getLanguageText('sys0021', $fieldname, $size);
            } // if
        } // if

        switch ($fieldspec['type']) {
            case 'boolean':
                // result from boolean fields may be varied, so convert to TRUE or FALSE
                // (where actual values are defined within $fieldspec)
                if (is_True($fieldvalue)) {
                    $fieldvalue = $fieldspec['true'];
                } else {
                    $fieldvalue = $fieldspec['false'];
                } // if
                break;

            case 'string':
                if (isset($fieldspec['uppercase'])) {
                    // value in this field must be uppercase
                    $fieldvalue = strtoupper($fieldvalue);
                } // if

                if (isset($fieldspec['lowercase'])) {
                    // value in this field must be lowercase
                    $fieldvalue = strtolower($fieldvalue);
                } // if

                if (isset($fieldspec['subtype'])) {
                    // perform any subtype processing
                    switch ($fieldspec['subtype']) {
                        case 'filename':
                        case 'image':
                            // check that value is a valid file name
                            if (!file_exists($fieldvalue)) {
                                // 'Filename does not exist'
                                $this->errors[$fieldname] = getLanguageText('sys0057', $fieldvalue);
                            } // if
                            break;
                        case 'email':
                            // check that value is a valid email address
                            $this->validateEmail($fieldname, $fieldvalue);
                            break;
                        default:
                            // '$fieldname: specification for subtype is invalid'
                            $this->errors[$fieldname] = getLanguageText('sys0037', $fieldname, 'subtype');
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
                                $this->errors[$fieldname] = getLanguageText('sys0037', $fieldname, 'hash');
                        } // switch
                    } // if
                } // if

                // escape any suspect characters in string fields
                $fieldvalue = addslashes($fieldvalue);

                break;

            case 'date':
                // value must be a date
                if (!$internaldate = $dateobj->getInternalDate($fieldvalue)) {
                    $this->errors[$fieldname] = "$fieldname: " . $dateobj->getErrors();
                } else {
                    // set date to internal format
                    $fieldvalue = $internaldate;
                } // if
                break;

            case 'datetime':
                // value must be a combined date and time
                if (!$internaldatetime = $dateobj->getInternalDateTime($fieldvalue)) {
                    $this->errors[$fieldname] = "$fieldname: " . $dateobj->getErrors();
                } else {
                    // set date to internal format
                    $fieldvalue = $internaldatetime;
                } // if
                break;

            case 'time':
                // value must be a time
                if (!$internaltime = $dateobj->getInternaltime($fieldvalue)) {
                    $this->errors[$fieldname] = "$fieldname: " . $dateobj->getErrors();
                } else {
                    // set time to internal format
                    $fieldvalue = $internaltime;
                } // if
                break;

            default:
                // perform validation if field type is numeric (integer, decimal)
                $fieldvalue = $this->validateNumber($fieldname, $fieldvalue, $fieldspec);
        } // switch

        return $fieldvalue;

    } // validateField

    // ****************************************************************************
    function validateInsert ($fieldarray, $fieldspec, &$caller)
    // Validate contents of $fieldarray against $fieldspec array.
    // Errors are returned in $errors array.
    // NOTE: for INSERT all fields contained in $fieldspecs must be present.
    {
        //DebugBreak();
        $this->errors = array();

        $this->caller = &$caller;

        // create array to hold data which has been formatted for the database
        $insertarray = array();

        // step through each fieldspec entry and compare with input data
        foreach ($fieldspec as $field => $spec) {
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
        } // foreach

        return $insertarray;

    } // validateInsert

    // ****************************************************************************
    function validateNumber ($field, $value, $spec)
    // if $spec identifies $field as a number then check that $value is within range.
    {
        //DebugBreak();
        // check if field type = integer (whole numbers only)
        $pattern = '/(int1|tinyint|int2|smallint|int3|mediumint|int4|integer|int8|bigint|int)/i';
        if (preg_match($pattern, $spec['type'], $match)) {
            // test that input contains a valid value for an integer field
            $number = (double)$value;
            $number = floor($number); // remove any decimal places
            if ((string)$value <> (string)$number) {
                // 'Value is not a whole number'
                $this->errors[$field] = getLanguageText('sys0029');
                return $value;
            } // if

            if (isset($spec['minvalue'])) {
                // obtain value from $fieldspec
                $minvalue = (double)$spec['minvalue'];
            } else {
                $minvalue = 0;
            } // if

            if ($number < $minvalue) {
                // 'Value is below minimum value'
                $this->errors[$field] = getLanguageText('sys0024', $minvalue);
            } // if

            if (isset($spec['maxvalue'])) {
                // obtain value from $fieldspec
                $maxvalue = (double)$spec['maxvalue'];
            } else {
                $maxvalue = 127;
            } // if

            if ($number > $maxvalue) {
                // 'Value is above maximum value'
                $this->errors[$field] = getLanguageText('sys0025', $maxvalue);
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
            // take account of different thousands and decimal separators
            $value = number_unformat($value);

            // input must at least be numeric to begin with
            if (!is_numeric(trim($value))) {
                // 'value is not numeric'
                $this->errors[$field] = getLanguageText('sys0023');
                return $value;
            } // if

            // value for 'precision' must be present
            if (isset($spec['precision'])) {
                $precision = (int)$spec['precision'];
            } elseif (isset($spec['size'])) {
                $precision = (int)$spec['size'];
            } else {
                // 'Specification missing for PRECISION'
                $this->errors[$field] = getLanguageText('sys0026');
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
            $maxvalue = str_repeat('9', $precision);
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
                $this->errors[$field] = getLanguageText('sys0024', $minvalue);
            } // if

            if (isset($spec['maxvalue'])) {
                // override with value provided in $fieldspec
                $maxvalue = (float)$spec['maxvalue'];
            } // if

            if ($value > $maxvalue) {
                // 'Value is above maximum value'
                $this->errors[$field] = getLanguageText('sys0025', $maxvalue);
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
                $this->errors[$field] = getLanguageText('sys0022');
                return $value;
            } // if

            if ((string)$value <> (string)$number) {
                // values do not match
                if (is_float($number)) {
                    $number = number_format($number, 0, '', '');
                } // if
                $valuelen = strlen($value);
                $numberlen = strlen($number);
                if ($numberlen > $numberlen) {
                    // "Value has too many digits";
                    $this->errors[$field] = getLanguageText('sys0027');
                    return $number;
                } // if
            } // if
            //
            if (isset($spec['unsigned'])) {
                if ($number < 0) {
                    // "Value cannot be negative";
                    $this->errors[$field] = getLanguageText('sys0028');
                    return $value;
                } // if
            } // if

            return $value;

        } // if

        // "Unknown value for 'type': {$spec['type']}";
        $this->errors[$field] = getLanguageText('sys0036', $spec['type']);

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

        // create array to hold data which has been formatted for the database
        $updatearray = array();

        // step through input data and validate each field in turn
        foreach ($fieldarray as $field => $value) {
            // (this will not carry forward any fields which do not exist in this table)
            if (array_key_exists($field, $fieldspec)) {
                // validate field using field specifications
                $value = $this->validateField($field, $value, $fieldspec[$field]);
                // transfer to array which will be passed to the database
                // (allow null values as field may have been cleared)
                if (strlen($value) > 0) {
                    $updatearray[$field] = $value;
                } else {
                    $updatearray[$field] = null;
                } // if
            } // if
        } // foreach

        return $updatearray;

    } // validateUpdate

// ****************************************************************************
} // end validation_class
// ****************************************************************************

?>
