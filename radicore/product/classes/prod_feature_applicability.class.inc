<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class prod_feature_applicability extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'prod_feature_applicability';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _checkNextRecord ($fieldarray)
    // check that end_date of current record is earlier than end_date of next record.
    {
        //DebugBreak();
        require_once 'std.datevalidation.class.inc';
        $dateobj = RDCsingleton::getInstance('date_class');

        $end_date    = $dateobj->getInternalDate($fieldarray['end_date']);
        $next_seq_no = $fieldarray['seq_no'] + 1;

        $where = "(product_id='{$fieldarray['product_id']}' AND prod_feature_id='{$fieldarray['prod_feature_id']}' AND seq_no='$next_seq_no')" ;

        $dbobject = RDCsingleton::getInstance('prod_feature_applicability');
        $dbobject->sql_select = 'end_date';
        $next_seq_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate next PROD_FEATURE_APPLICABILITY record'
            $this->errors['end_date'] = getLanguageText('e0015');
            return $fieldarray;
        } // if

        // use data from first row only
        $next_seq_data = $next_seq_data[0];

        $next_end_date = $dateobj->getInternalDate($next_seq_data['end_date']);

        if ($end_date >= $next_end_date) {
            $this->errors['end_date'] = getLanguageText('e0008'); // 'End Date must be earlier than End Date of next entry';
            // use next end_date minus 1 day
            $fieldarray['end_date'] = adjustDate($next_end_date, -1);
        } // if

        return $fieldarray;

    } // _checkNextRecord

    // ****************************************************************************
    function _checkPrevRecord ($fieldarray)
    // check that start_date of current record is later than start_date of previous record.
    {
        //DebugBreak();
        require_once 'std.datevalidation.class.inc';
        $dateobj = RDCsingleton::getInstance('date_class');

        $start_date  = $dateobj->getInternalDate($fieldarray['start_date']);
        $prev_seq_no = $fieldarray['seq_no'] -1;

        $where = "(product_id='{$fieldarray['product_id']}' AND prod_feature_id='{$fieldarray['prod_feature_id']}' AND seq_no='$prev_seq_no')" ;

        $dbobject = RDCsingleton::getInstance('prod_feature_applicability');
        $dbobject->sql_select = 'start_date';
        $prev_rec_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            $this->errors['start_date'] = getlanguageText('e0016'); // 'Could not locate previous PROD_FEATURE_APPLICABILITY record';
            return $fieldarray;
        } // if

        // use data from first row only
        $prev_rec_data = $prev_rec_data[0];

        $prev_start_date = $dateobj->getInternalDate($prev_rec_data['start_date']);
        if ($start_date <= $prev_start_date) {
            $this->errors['start_date'] = getlanguageText('e0009'); // 'Start Date must be later than Start Date of previous entry';
            // use previous start_date plus 1 day
            $fieldarray['start_date'] = adjustDate($prev_start_date, 1);
        } // if

        return $fieldarray;

    } // _checkPrevRecord

    // ****************************************************************************
    function _updateNextRecord ($fieldarray)
    // update the start_date of the next record so that it is
    // 1 day later than the end_date of the current record
    {
        $end_date   = $fieldarray['end_date'];
        $start_date = adjustDate($end_date, 1);

        $update_array['product_id']      = $fieldarray['product_id'];
        $update_array['prod_feature_id'] = $fieldarray['prod_feature_id'];
        $update_array['seq_no']          = $fieldarray['seq_no'] + 1;
        $update_array['start_date']      = $start_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updateNextRecord

    // ****************************************************************************
    function _updatePrevRecord ($fieldarray)
    // update the end_date of the previous record so that it is
    // 1 day earlier than the start_date of the current record
    {
        $start_date = $fieldarray['start_date'];
        $end_date   = adjustDate($start_date, -1);

        $update_array['product_id']      = $fieldarray['product_id'];
        $update_array['prod_feature_id'] = $fieldarray['prod_feature_id'];
        $update_array['seq_no']          = $fieldarray['seq_no'] -1;
        $update_array['end_date']        = $end_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updatePrevRecord

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        //DebugBreak();
        require_once 'std.datevalidation.class.inc';
        $dateobj = RDCsingleton::getInstance('date_class');

        $start_date = $dateobj->getInternaldate($fieldarray['start_date']);
        $end_date   = $dateobj->getInternalDate($fieldarray['end_date']);

        if ($start_date > $end_date) {
            $this->errors['start_date'] = getLanguageText('e0002'); // 'Start Date cannot be later than End Date';
            $this->errors['end_date']   = getLanguageText('e0003'); // 'End Date cannot be earlier than Start Date';
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('feature_type', $this->lookup_data)) {
            // get array for product_subtype and put into LOOKUP_DATA
            $array = $this->getValRep('feature_type');
            $this->lookup_data['feature_type'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign entities.
    {
        //DebugBreak();
        if (!empty($fieldarray['prod_feature_id']) and empty($fieldarray['prod_feature_desc'])) {
            // get description for selected node
            require_once 'classes/product_feature.class.inc';
            $dbobject = RDCsingleton::getInstance('product_feature');
            $dbobject->sql_select = 'prod_feature_id, prod_feature_desc, prod_feature_cat_id';
            $foreign_data = $dbobject->getData("prod_feature_id='{$fieldarray['prod_feature_id']}'");
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $foreign_data[0]);

            require_once 'classes/product_feature_category.class.inc';
            $dbobject = RDCsingleton::getInstance('product_feature_category');
            $dbobject->sql_select = 'prod_feature_cat_desc';
            $foreign_data = $dbobject->getData("prod_feature_cat_id='{$fieldarray['prod_feature_cat_id']}'");
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $foreign_data[0]);
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        require_once 'std.datevalidation.class.inc';
        $dateobj = RDCsingleton::getInstance('date_class');

        // set seq_no to next available number
        if (!empty($fieldarray['product_id'])
        AND !empty($fieldarray['prod_feature_id'])) {
            $product_id      = $fieldarray['product_id'];
            $prod_feature_id = $fieldarray['prod_feature_id'];
            $where = "product_id='$product_id' AND prod_feature_id='$prod_feature_id'";
            $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['seq_no'] = $count + 1;

            if ($fieldarray['seq_no'] > 1 and empty($fieldarray['start_date'])) {
                // for subsequent records the start date must be later than
                // the start date of the previous record
                $prev_seq_no = $fieldarray['seq_no'] -1;
                $where = "product_id='$product_id' AND prod_feature_id='$prod_feature_id' AND seq_no='$prev_seq_no'";
                $this->sql_select = 'start_date,end_date';
                $prev_rec_data = $this->getData_raw($where);
                if ($this->numrows <> 1) {
                    $this->errors[] = getLanguageText('e0016'); // 'Could not locate previous PROD_FEATURE_APPLICABILITY record';
                    return $fieldarray;
                } // if
                $prev_rec_data = $prev_rec_data[0];

                // use previous start_date plus 1 day
                $start_date = $prev_rec_data['start_date'];
                $start_date = adjustDate($start_date, 1);
                $fieldarray['start_date'] = $dateobj->getExternalDate($start_date);
            } // if
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'feature_type') {
//            $array['S'] = 'Standard';
//            $array['O'] = 'Optional';
//            $array['R'] = 'Required';
//            $array['X'] = 'Selectable';
            $array = getLanguageArray('feature_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        if ($fieldarray['seq_no'] > 1) {
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
        //DebugBreak();
        // get last seq number for this product/category
        $product_id      = $fieldarray['product_id'];
        $prod_feature_id = $fieldarray['prod_feature_id'];
        $where = "product_id='$product_id' AND prod_feature_id='$prod_feature_id'";
        $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
        $last_seq_no = $this->getCount($query);

        $seq_no = $fieldarray['seq_no'];
        if ($seq_no > 1) {
            // update end_date on previous record
            $fieldarray = $this->_updatePrevRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if
        if ($seq_no < $last_seq_no) {
            // update start_date on next record
            $fieldarray = $this->_updateNextRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'prod_feature_applicability.*, product.product_name, prod_feature_desc, prod_feature_cat_desc';
            $this->sql_from = 'prod_feature_applicability '
                            . 'LEFT JOIN product '
                            . "ON (product.product_id=$this->tablename.product_id) "
                            . 'LEFT JOIN product_feature '
                            . "ON (product_feature.prod_feature_id=$this->tablename.prod_feature_id) "
                            . 'LEFT JOIN product_feature_category '
                            . "ON (product_feature_category.prod_feature_cat_id=product_feature.prod_feature_cat_id) ";
            $this->default_orderby = "prod_feature_cat_desc";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {
        // check that this is the latest record
        $where = "product_id='{$fieldarray['product_id']}' AND " . "prod_feature_id='{$fieldarray['prod_feature_id']}'";
        $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
        $max = $this->getCount($query);

        if ($fieldarray['seq_no'] != $max) {
            // "This is not the last record so it cannot be deleted."
            $this->errors[] = getLanguageText('e0007');
        } // if

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        //DebugBreak();
        if ($fieldarray['seq_no'] > 1) {
            // check against previous record
            $fieldarray = $this->_checkPrevRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update and allow for changes being made.
    {
        //DebugBreak();
        require_once 'std.datevalidation.class.inc';
        $dateobj = RDCsingleton::getInstance('date_class');

        $seq_no     = (int)$fieldarray['seq_no'];
        $start_date = $dateobj->getInternaldate($fieldarray['start_date']);
        $end_date   = $dateobj->getInternalDate($fieldarray['end_date']);

        if ($seq_no > 1) {
            // check against previous record
            $fieldarray = $this->_checkPrevRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        $where = "product_id='{$fieldarray['product_id']}' AND "
               . "prod_feature_id='{$fieldarray['prod_feature_id']}'";
        $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
        $max = $this->getCount($query);
        if ($seq_no < $max) {
            // check against next record
            $fieldarray = $this->_checkNextRecord($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
