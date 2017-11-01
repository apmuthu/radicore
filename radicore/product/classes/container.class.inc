<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class container extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'container';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('facility_id', $this->lookup_data)) {
            // get array for facility and put into LOOKUP_DATA
            $object = RDCsingleton::getInstance('facility');
            $array  = $object->getValRep('facility_id');
            $this->lookup_data['facility_id'] = $array;
        } // if

        if (!array_key_exists('facility_id', $this->lookup_data)) {
            // get array for container_type and put into LOOKUP_DATA
            $object = RDCsingleton::getInstance('container_type');
            $array  = $object->getValRep('container_type_id');
            $this->lookup_data['container_type_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set inventory_item_id to next available number
        if (!empty($fieldarray['facility_id'])) {
            $facility_id  = $fieldarray['facility_id'];
            $where = "facility_id='$facility_id'";
            $query = "SELECT max(container_id) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['container_id'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
