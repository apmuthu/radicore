<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class price_component extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'price_component';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _updateNextRecord ($fieldarray)
    // update the start_date of the next record so that it is
    // 1 day later than the end_date of the current record.
    {
        $end_date = $fieldarray['end_date'];
        $start_date = adjustDate($end_date, 1);

        $update_array['price_component_id'] = $fieldarray['next_price_component_id'];
        $update_array['start_date'] = $start_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updateNextRecord

    // ****************************************************************************
    function _updatePrevRecord ($fieldarray)
    // update the end_date of the previous record so that it is
    // 1 day earlier than the start_date of the current record.
    {
        $start_date = $fieldarray['start_date'];
        $end_date = adjustDate($start_date, -1);

        $update_array['price_component_id'] = $fieldarray['prev_price_component_id'];
        $update_array['end_date'] = $end_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updatePrevRecord

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& RDCsingleton::getInstance('date_class');
        $start_date = $dateobj->getInternaldate($fieldarray['start_date']);
        $end_date   = $dateobj->getInternalDate($fieldarray['end_date']);

        if ($start_date > $end_date) {
            // 'Start Date cannot be later than End Date'
            $this->errors['start_date'] = getLanguageText('e0002');
            // 'End Date cannot be earlier than Start Date'
            $this->errors['end_date']   = getLanguageText('e0003');
        } // if

        switch ($fieldarray['price_frequency']) {
            case 'R':
                // recurring charge requires unit of frequency
                if (empty($fieldarray['uom_id'])) {
                    // "Unit of frequency is required"
                    $this->errors['uom_id'] = getLanguageText('e0004');
                } // if
                $fieldarray['quantity'] = null;
                break;
            case 'U':
                // utilisation charge requires quantity and unit of measure
                if (empty($fieldarray['uom_id'])) {
                    // "Unit of utilisation is required"
                    $this->errors['uom_id'] = getLanguageText('e0005');
                } // if
                if (empty($fieldarray['quantity'])) {
                    // "Utilisation quantity is required"
                    $this->errors['quantity'] = getLanguageText('e0006');
                } // if
                break;
            default:
                $fieldarray['uom_id']   = null;
                $fieldarray['quantity'] = null;
        } // switch

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('price_type', $this->lookup_data)) {
            // get array for price_type and put into LOOKUP_DATA
            $array = $this->getValRep('price_type');
            $this->lookup_data['price_type'] = $array;
        } // if

        if (!array_key_exists('price_frequency', $this->lookup_data)) {
            // get array for price_frequency and put into LOOKUP_DATA
            $array = $this->getValRep('price_frequency');
            $this->lookup_data['price_frequency'] = $array;
        } // if

        if (!array_key_exists('uom_id', $this->lookup_data)) {
            // get contents of foreign table and add to lookup array
            $dbobject =& RDCsingleton::getInstance('unit_of_measure');
            $data_array = $dbobject->getValRep('uom_id');
            $this->lookup_data['uom_id'] = $data_array;
        } // if

        if (!array_key_exists('prod_cat_id', $this->lookup_data)) {
            // get contents of foreign table and add to lookup array
            $dbobject =& RDCsingleton::getInstance('product_category');
            $data_array = $dbobject->getValRep('prod_cat_id');
            $this->lookup_data['prod_cat_id'] = $data_array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign (parent) tables.
    {
        // this is here to avoid a conflict with the uom_id which is available on the
        // PRODUCT record, to ensure that the right uom_desc is loaded. (this can be
        // wrong when the PRODUCT table is accessed via the getForeignData() method).
        if (isset($fieldarray['uom_id'])) {
        	require_once 'classes/unit_of_measure.class.inc';
            $dbobject =& RDCsingleton::getInstance('unit_of_measure');
            $dbobject->sql_select = 'uom_desc';
            $data = $dbobject->getData("uom_id='{$fieldarray['uom_id']}'");
            $fieldarray = array_merge($data[0], $fieldarray);
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set price_component_id to next available number
        $query = "SELECT max(price_component_id) FROM $this->tablename";
        $count = $this->getCount($query);
        $fieldarray['price_component_id'] = $count + 1;

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'price_type') {
//            $array['B'] = 'Base Price';
//            $array['D'] = 'Discount';
//            $array['S'] = 'Surcharge';
//            $array['M'] = 'MRP';
            $array = getLanguageArray('price_type');
            return $array;
        } // if

        if ($item == 'price_frequency') {
//            $array['1'] = 'One Time charge';
//            $array['R'] = 'Recurring charge';
//            $array['U'] = 'Utilisation charge';
            $array = getLanguageArray('price_frequency');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        if (isset($fieldarray['prev_price_component_id'])) {
            // update end_date on previous record
            $fieldarray = $this->_updatePrevRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        if (isset($fieldarray['prev_price_component_id'])) {
            // update end_date on previous record
            $fieldarray = $this->_updatePrevRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if (isset($fieldarray['next_price_component_id'])) {
            // update start_date on next record
            $fieldarray = $this->_updateNextRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {
        // check against next record (if it exists)
        $fieldarray = $this->_checkNextRecord($fieldarray);
        if ($this->errors) return $fieldarray;

        if (isset($fieldarray['next_price_component_id'])) {
            // "This is not the last record so it cannot be deleted."
            $this->errors[] = getLanguageText('e0007');
        } // if

        return $fieldarray;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        // check against previous record (if it exists)
        $fieldarray = $this->_checkPrevRecord($fieldarray);
        if ($this->errors) return $fieldarray;

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update and allow for changes being made.
    {
        // check against previous record (if it exists)
        $fieldarray = $this->_checkPrevRecord($fieldarray);

        // if ($this->errors) return $fieldarray;
        // check against next record (if it exists)
        $fieldarray = $this->_checkNextRecord($fieldarray);

        // if ($this->errors) return $fieldarray;

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
