<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_option.class.inc';
class x_option_s01 extends x_option
{
    // ****************************************************************************
    // this class is for use by script: x_option(output3).php
    // ****************************************************************************

    var $address_array;      // data for PDF output

    // ****************************************************************************
    function _cm_ListView_print_before ($prev_row, $curr_row)
    // allow extra rows to be created in List View
    {
        $output = array();

        // customisable code goes here

        return $output;

    } // _cm_ListView_print_before

    // ****************************************************************************
    function _cm_ListView_print_after ($curr_row, $next_row)
    // allow extra rows to be created in List View
    {
        $output = array();

        // customisable code goes here

        return $output;

    } // _cm_ListView_print_after

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        // customisable code goes here

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        // construct address field from current row
        $address = "option_id: " .$fieldarray['option_id'] ."\n"
                  ."option_desc: " .$fieldarray['option_desc'] ."\n"
                  ."created_date: " .$fieldarray['created_date'] ."\n"
                  ."created_user: " .$fieldarray['created_user'];

        //$address .= "\nline5\nline6\nline7\nline8";

        $this->address_array[] = $address;      // save address
        $fieldarray = null;                     // do not print anything yet

        // obtain the number of labels to print on each line
        $count = (int)$this->report_structure['pdf']['label_print'];
        if ($count < 1) $count = 1;

        if (count($this->address_array) == $count) {
        	// print all saved addresses
        	foreach ($this->address_array as $ix => $address) {
        		$name = 'address'.($ix+1);
        		$fieldarray[$name] = $address;
        	} // foreach
        	// remove addresses which have been printed
            $this->address_array = array();
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_lastRow ()
    // perform custom processing after last record has been read.
    {
        $fieldarray = array();

        if (!empty($this->address_array)) {
        	// return all saved addresses
        	foreach ($this->address_array as $ix => $address) {
        		$name = 'address'.($ix+1);
        		$fieldarray[$name] = $address;
        	} // foreach
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_output ($string, $filename)
    // perform any processing required after the output operation
    {
        // customisable code goes here

        return $string;

    } // _cm_post_output

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation.
    // $filename is only available if the output is being sent to a disk file.
    {
        // customisable code goes here

        return $filename;

    } // _cm_pre_output

// ****************************************************************************
} // end class
// ****************************************************************************

?>
