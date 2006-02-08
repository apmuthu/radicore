<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class location_type extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function location_type ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'location_type';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // location_type

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set location_type_id to next available number
        $count = $this->getCount("SELECT max(location_type_id) FROM $this->tablename");
        $fieldarray['location_type_id'] = $count + 1;

        $this->fieldspec['location_type_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'location_type_id') {
            // get data from the database
            $this->sql_select = 'location_type_id, location_type_desc';
            $this->sql_orderby = 'location_type_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            //$array[''] = ' ';   // start with blank entry

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a picklist screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        if ($return_from == 'srv_filepicker') {
            // get description for selected item
            $fieldarray['image_fname'] = $selection;
        } // if

        return $fieldarray;

    } // _cm_popupReturn

// ****************************************************************************
} // end class
// ****************************************************************************

?>