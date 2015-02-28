<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// *****************************************************************************
// This class is used for reading and writing CSV (Comma Separated Variable) files.
// *****************************************************************************

class csv_class
{
    // member variables
    var $dbobject;              // database object

    var $alternative_names;     // possible alternative names
    var $byte_order_mark = '';  // to be written at beginning of file
    var $errors = array();      // array of errors messages
    var $column_names;          // array of column names in the input file
    var $delimiter;             // delimiter used by fgetcsv()
    var $enclosure;             // enclosure used by fgetcsv()
    var $handle;                // file handle from fopen()
    var $max_reclen = 10000;    // maximum record length
    var $name_count = 0;        // count of column names
    var $old_names;             // column names as input
    var $record_count = 0;      // count of records read

    var $map_names_alt;         // alternative mapping names
    var $map_values;            // insert these values for empty columns
    var $map_leftovers;         //
    var $swap_values;           // their values whch must be swapped for our values

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function csv_class ($dbobject=null)
    //
    {
        if (is_object($dbobject)) {
            // save reference to database object
            $this->dbobject =& $dbobject;
            // allow this CSV object to be accessed from within the database object
            $dbobject->csv =& $this;
        } // if

        // mark the output file as using the UTF8 character set
        $this->byte_order_mark = pack("CCC",0xef,0xbb,0xbf);

        return;

    } // csv_class

    // ****************************************************************************
    function getErrors ()
    // return array of error messages
    {
        $errors = $this->errors;
        $this->errors = array();

        if (!is_array($errors)) {
            // convert string into an array
            $errors = (array)$errors;
        } // if

        return $errors;

    } // getErrors

    // ****************************************************************************
    function outputCSV ($resource, $exclude=null)
    // read database resource one record at a time and output to a CSV file.
    {
        $output = '';
        $row_count = 0;

        global $csvout, $csvouth;
        if (!isset($csvout)) {
            $csvout = get_class($dbobject) .'.csv';
        } // if

        $pattern_id = getPatternId();

        $dbobject =& $this->dbobject;

        // allow filename to be customised
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_pre_output')) {
                $csvout = $dbobject->custom_processing_object->_cm_pre_output($csvout);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $csvout = $dbobject->_cm_pre_output($csvout);
        } // if

        if (isset($csvout) AND isset($GLOBALS['batch'])) {
            if (!empty($csvout)) {
                if (!$csvouth = fopen($csvout, 'w')) {
                    trigger_error("Cannot open file $csvout", E_USER_ERROR);
                } // if
            } // if
            if (!empty($this->byte_order_mark)) {
                $result = fwrite($csvouth, $this->byte_order_mark);
            } // if
        } // if

        if (preg_match('/(\.txt)$/i', $GLOBALS['csvout'])) {
            $tab_delimited = true;
            $delimiter     = "\t";
        } else {
            $tab_delimited = false;
            $delimiter     = ",";
        } // if

        $search  = array("\t", "\r", "\n", '"');
        $replace = array("  ", null, null, "'");

        // fetch database rows one at a time
        while ($fieldarray = $dbobject->fetchRow($resource)) {
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return false;
            } // if
            $row_count++;
            if (!empty($exclude) AND is_array($exclude)) {
                // this contains a list of field names which may have to be excluded
                foreach ($fieldarray as $key => $value) {
                    if (isset($exclude[$key]) AND $exclude[$key] == 'Y') {
                        // this has been selected, so leave it in
                    } else {
                        unset($fieldarray[$key]);  // do not output this field
                    } // if
                } // foreach
            } // if
            if ($row_count == 1 AND !is_True($dbobject->no_csv_header)) {
                // first row, so output field names as labels
                foreach ($fieldarray as $fieldname => $fieldvalue) {
                    $fieldname = getLanguageText($fieldname);
                    if ($tab_delimited) {
                        $output .= $fieldname ."\t";
                        //$output .= '"' .$fieldname .'"' ."\t";
                    } else {
                        $output .= '"' .str_replace('"', "'", $fieldname) .'",';
                    } // if
                } // foreach
                // strip last ',' or "\t" and append <newline>
                $output = rtrim($output, $delimiter);
                $output .= "\r\n";
                if (isset($csvouth) AND !empty($csvout)) {
                    if (!$result = fwrite($csvouth, $output)) {
                        trigger_error("Cannot write to file $csvout", E_USER_ERROR);
                    } // if
                    $output = '';
                } // if
            } // if
            do {
                // perform any data formatting
                $null = array();
                $fieldarray = $dbobject->formatData($fieldarray, $null);
                // output each field as data
                foreach ($fieldarray as $fieldname => $fieldvalue) {
                    // replace any tab characters which may be in the data
                    $fieldvalue = str_replace($search, $replace, $fieldvalue);
                    if ($tab_delimited) {
                        $output .= $fieldvalue ."\t";
                        //$output .= '"' .$fieldvalue .'"' ."\t";
                    } else {
                        $output .= '"' .$fieldvalue .'",';
                    } // if
                } // foreach
                // strip last ',' or "\t" and append <newline>
                $output = rtrim($output, $delimiter);
                $output .= "\r\n";
                if (isset($csvouth) AND !empty($csvout)) {
                    if (!$result = fwrite($csvouth, $output)) {
                        trigger_error("Cannot write to file $csvout", E_USER_ERROR);
                    } // if
                    $output = '';
                } // if

                $result = check_memory_limit();

                if (preg_match('/^(output6)$/i', $pattern_id)) {
                    // this is a Tree View, so look for any children of this row
                    $fieldarray = $dbobject->fetchRowChild($fieldarray);
                } else {
                    $fieldarray = null;
                } // if

            } while (!empty($fieldarray));

        } // while

        if (isset($GLOBALS['transaction_has_started']) AND is_True($GLOBALS['transaction_has_started'])) {
            $errors = $dbobject->commit();
        } // if

        // perform any post processing (which may involve adding more records to $output)
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_post_output')) {
                $output = $dbobject->custom_processing_object->_cm_post_output($output, $csvout);
            } // if
        } // if

        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $output = $dbobject->_cm_post_output($output, $csvout);
        } // if

        fclose($csvouth);

        return $output;

    } // outputCSV

    // ************************************************************************
    // the following methods are for READING a CSV file
    // ************************************************************************
    function open_read ($filename)
    // open the file and read the first record to determine the delimiter and enclosure.
    {
        // deal with files created on unix or mac computers
        ini_set('auto_detect_line_endings', true);

        $this->handle = @fopen($filename, 'r');
        if ($this->handle === false) {
            $this->errors[] = "open_read: Cannot open file '$filename'";
            return false;
        } // if

        // deal with files created on unix or mac computers
        //ini_set('auto_detect_line_endings', true);

        // read first record to find out whether the delimiter is comma, tab or pipe
        $first = fgets($this->handle);
        $first = $this->removeBOM($first);  // remove Byte Order Mark
        if (strpos($first, "\t")) {
            $this->delimiter = "\t";        // tab
            $this->enclosure = chr(2);      // won't work with '', so use STX
        } elseif (strpos($first, "|")) {
            $this->delimiter = "|";         // pipe
            $this->enclosure = chr(2);      // won't work with '', so use STX
        } else {
            $this->delimiter = ',';         // comma
            $this->enclosure = '"';
        } // if

        rewind($this->handle);  // rewind back to start of file

        $this->record_count = 0;

        return true;

    } // open_read

    // ************************************************************************
    function read_file ()
    // read a record from the CSV file and return it to the calling object.
    {
        $this->errors = array();

        if (!is_resource($this->handle)) {
            $this->errors[] = "read_file: File has not been opened yet";
            return false;
        } // if

        $handle     =& $this->handle;
        $max_reclen =& $this->max_reclen;
        $delimiter  =& $this->delimiter;
        $enclosure  =& $this->enclosure;

        if (empty($this->column_names)) {
            $this->getColumnNames();  // not supplied yet, so read from first record in file
        } // if

        $record_count      =& $this->record_count;
        $column_names      =& $this->column_names;
        $alternative_names =& $this->alternative_names;
        $old_names         =& $this->old_names;
        $name_count        =& $this->name_count;
        $map_leftovers     =& $this->map_leftovers;
        $swap_values       =& $this->swap_values;

        if (!$input = fgetcsv($handle, $max_reclen, $delimiter, $enclosure)) {
            return false;
        } // if

        $data = array();

        $input[0] = trim($input[0]);
        if (count($input) == 1 AND empty($input[0])) {
            $x = 'blank';  // this is a blank line, so ignore it
        } elseif ($record_count == 0 AND !empty($column_names) AND $input[0] == $column_names[0]) {
            $x = 'names';  // this line contains column names, so ignore it
        } else {
            $record_count++;
            if ($record_count == 1) {
                $input[0] = $this->removeBOM($input[0]);
            } // if
            if (count($input) != $name_count) {
                $stuff = var_export($input, true);  // convert array to a string for inclusion in output
                $save_input = $input;
                $save_count = count($input);
                while ($save_count < $name_count) {
                    // premature EOF, so read next record and append to current column
                    $next_str = fgets($handle, $max_reclen);    // read next record as a string
                    if ($next_str == false) break;  // EOF
                    $next_arr = str_getcsv($next_str, $delimiter, $enclosure);  // split into one or more columns
                    $input[count($input)-1] .= '<BR>'.array_shift($next_arr);   // append first element to current column
                    if (!empty($next_arr)) {
                        $input = array_merge($input, $next_arr);    // append any additional columns
                    } // if
                    $save_count = count($input);
                } // while
                if (count($input) != $name_count) {
                    $this->errors[] = "Column count mismatch: expected $name_count, found $save_count, Record #$record_count";
                    $this->errors[] = "Data: ".var_export($input, true);;
                    return false;
                } // if
            } // if

            // merge names with data to produce an associative array
            if (!empty($this->map_values)) {
                $data = $this->map_values;  // start with default values
            } else {
                $data = array();  // start with an empty array
            } // if

            $nbsp = chr(194).chr(160); // non-breaking space

            foreach ($column_names as $key => $fieldname) {
                $data[$fieldname] = $input[$key];
                if (preg_match('/NULL/i', $data[$fieldname])) $data[$fieldname] = null;
                // replace non-breaking space with ordinary space
                //$data[$fieldname] = preg_replace('/[\xA0]/', ' ', $data[$fieldname]);
                $data[$fieldname] = str_replace($nbsp, ' ', $data[$fieldname]);
            } // foreach

            if (!empty($map_leftovers)) {
                // unused $mapping entries indicate an input value which is used more than once
                foreach ($map_leftovers as $name_out => $name_in) {
                    if (is_string($name_in)) {
                        $name_in = strtolower($name_in);
                        if (array_key_exists($name_in, $old_names)) {
                            $data[$name_out] = $input[$old_names[$name_in]];
                        } // if
                    } // if
                } // foreach
            } // if

            if (!empty($alternative_names)) {
                foreach ($alternative_names as $ours => $theirs) {
                    if (array_key_exists($theirs, $data)) {
                        // swap this column name from theirs to ours
                        $data[$ours] = $data[$theirs];
                        unset($data[$theirs]);
                    } // if
                } // foreach
            } // if

            if (!empty($swap_values)){
                foreach($swap_values as $row){ // for each row
                    if (array_key_exists($row['column_name'], $data)) {
                        // column in mapping data has been found in input data
                        if (strtolower($row['value_in']) == strtolower($data[$row['column_name']])) {
                            // change retailer's value to Flubit's value
                            $data[$row['column_name']] = $row['value_out'];
                        } // if
                    } // if
                } // foreach
            } // if

        } // if

        return $data;

    } // read_file

    // ************************************************************************
    function close ()
    // close this file
    {
        fclose($this->handle);
    } // close

    // ************************************************************************
    function removeBOM ($string="")
    // remove Byte Order Mark from a UTF8 string.
    {
        if (substr($string, 0,3) == pack("CCC",0xef,0xbb,0xbf)) {
            $string = substr($string, 3);
        }  // if

        return $string;

    } // removeBOM

    // ************************************************************************
    function getColumnNames ()
    // get the column names from the first record in the file.
    // (this is instead of the setColumnNames() method).
    {
        if (!is_resource($this->handle)) {
            $this->errors[] = "getColumnNames: File has not been opened yet";
            return false;
        } // if

        $names = fgetcsv($this->handle, $this->max_reclen, $this->delimiter, $this->enclosure);
        if (empty($names)) {
            $this->errors[] = "getColumnNames: First record in the file is empty, no names found";
            return false;
        } // if
        if (!is_array($names)) {
            $this->errors[] = "getColumnNames() does not return an array";
            return false;
        } // if

        $names[0] = $this->removeBOM($names[0]);

        $this->column_names = $names;
        $this->name_count   = count($names);

        // save these original names for later
        $this->old_names = array_flip($this->column_names);
        $this->old_names = array_change_key_case($this->old_names, CASE_LOWER);

        return true;

    } // getColumnNames

    // ************************************************************************
    function setColumnNames ($names)
    // set the column names manually as they are not present in the input file.
    // (this is instead of the getColumnNames() method).
    // $names is an indexed array in format: 'outname' = 'inputputname'
    {
        if (empty($names)) {
            $this->errors[] = "setColumnNames: Input array is empty";
            return false;
        } // if

        if (!is_array($names)) {
            $this->errors[] = "setColumnNames: Input argument is not an array";
            return false;
        } // if

        $this->column_names = $names;
        $this->name_count   = count($names);

        return true;

    } // setColumnNames

    // ************************************************************************
    function map_to_column_names ($mapping)
    // map these column names in the input file to different names for the output.
    // $mapping is an associative array.
    {
        if (empty($mapping)) {
            $this->errors[] = "map_to_column_names: Input array is empty";
            return false;
        } // if

        if (!is_array($mapping)) {
            $this->errors[] = "map_to_column_names: Input argument is not an array";
            return false;
        } // if

        if (empty($this->column_names)) {
            $this->getColumnNames();  // not supplied yet, so read from first record in file
            if (!empty($this->errors)) return;
        } // if

        // convert the original names to the mapped names
        foreach ($this->column_names as $ix => &$column_name) {
            $key = array_search($column_name, $mapping);
            if (!empty($key)) {
                $column_name = $key;
                unset($mapping[$key]);  // this has been used, so delete it
            } // if
        } // foreach

        // there may be entries left over, so store them here
        $this->map_leftovers = $mapping;

        return true;

    } // map_to_column_names

    // ************************************************************************
    function map_to_column_values ($names)
    // define default values for columns which may be missing from the input file.
    // $names is an associative array of name=value pairs.
    {
        if (empty($names)) {
            $this->errors[] = "map_to_column_values: Input array is empty";
            return false;
        } // if

        if (!is_array($names)) {
            $this->errors[] = "map_to_column_values: Input argument is not an array";
            return false;
        } // if

        $this->map_values = $names;

        return true;

    } // map_to_column_values

    // ************************************************************************
    function map_to_alternative_names ($names)
    // map these column names in the input file to different names for the output.
    // this is where different input files from the same source may use a variety
    // of different column names.
    // $names is an associative array of name_out=name_in pairs.
    {
        if (empty($names)) {
            $this->errors[] = "map_to_alternative_names: Input array is empty";
            return false;
        } // if

        if (!is_array($names)) {
            $this->errors[] = "map_to_alternative_names: Input argument is not an array";
            return false;
        } // if

        $this->alternative_names = $names;

        return true;

    } // map_to_alternative_names

    // ************************************************************************
    function set_swap_values ($input)
    // provide an array of input values which have to be swapped before being output.
    // $input is an associative array indexed by row number.
    // each row shoulkd contain the following:
    // column_name = <column_name>
    // value_in = <input value>
    // value_out = <output value>
    {
        if (empty($input)) {
            $this->errors[] = "set_swap_values: Input array is empty";
            return false;
        } // if

        if (!is_array($input)) {
            $this->errors[] = "set_swap_values: Input argument is not an array";
            return false;
        } // if

        $this->swap_values = $input;

        return true;

    } // set_swap_values

// ****************************************************************************
} // end class
// ****************************************************************************

?>
