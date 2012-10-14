<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class CSV
{
    // member variables
    var $dbobject;              // database object

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function CSV ($dbobject)
    //
    {
        // save reference to database object
        $this->dbobject =& $dbobject;

        // allow this CSV object to be accessed from within the database object
        $dbobject->csv =& $this;

        return;

    } // CSV

    // ****************************************************************************
    function outputCSV ($resource, $post=null)
    // read database resource and output all records to a CSV file.
    {
        $output = '';
        $row_count = 0;

        global $csvout, $csvouth;
        if (!isset($csvout)) {
            $csvout = get_class($dbobject) .'.csv';
        } // if

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

        if (isset($csvout) and isset($GLOBALS['batch'])) {
            if (!empty($csvout)) {
                if (!$csvouth = fopen($csvout, 'w')) {
                    trigger_error("Cannot open file $csvout", E_USER_ERROR);
                } // if
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
            $row_count++;
            if (!empty($post)) {
                // this contains a list of field names which may have to be excluded
                foreach ($fieldarray as $key => $value) {
                    if (isset($post[$key]) AND $post[$key] == 'Y') {
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
                        //$output .= $fieldname ."\t";
                        $output .= '"' .$fieldname .'"' ."\t";
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

        } // while

        // perform any post processing
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

        return $output;

    } // outputCSV

// ****************************************************************************
} // end class
// ****************************************************************************

?>
