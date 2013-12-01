<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class inventory_item_variance extends Default_Table
{
    // ****************************************************************************
    function inventory_item_variance ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'inventory_item_variance';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // inventory_item_variance

    // ****************************************************************************
    function updateInvItemQty ($fieldarray)
    // update qty_on_hand for this inventory_item record
    {
        // accumulate variance quantities for this item
        $product_id        = $fieldarray['product_id'];
        $inventory_item_id = $fieldarray['inventory_item_id'];

        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id'";
        $variance_qty = $this->getCount("SELECT sum(variance_qty) FROM $this->tablename WHERE $where");

        // update inventory_item record with this value
        $object =& RDCsingleton::getInstance('inventory_item');
        $object->row_locks = 'EX'; // lock this row for update
        $data   = $object->getData_raw($where);
        if (empty($data)) {
            // 'Could not locate original $tablename record for updating $where'
            $this->errors[] = getLanguageText('sys0007', strtoupper($object->getTableName()), $where);
        } else {
            $total_qty = $data[0]['total_qty'];
            $update['product_id']         = $product_id;
            $update['inventory_item_id']  = $inventory_item_id;
            $update['qty_on_hand']        = $total_qty + $variance_qty;
            $object->updateRecord($update);
            $this->errors = array_merge($this->errors, $object->errors);
        } // if

        return $fieldarray;

    } // updateInvItemQty

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $today = getTimeStamp('date');
        if ($fieldarray['inventory_date'] > $today) {
        	// "Inventory date cannot be in the future"
            $this->errors['inventory_date'] = getLanguageText('e0033');
        } // if

        if ((int)$fieldarray['variance_qty'] == 0) {
        	// "Variance Quantity cannot be zero"
            $this->errors['variance_qty'] = getLanguageText('e0036');
        } // if

        if (!empty($this->errors)) {
        	return $fieldarray;
        } // if

        $object =& RDCsingleton::getInstance('inventory_item_variance');

        $product_id        = $fieldarray['product_id'];
        $inventory_item_id = $fieldarray['inventory_item_id'];
        $seq_no            = $fieldarray['seq_no'];

        // look for a previous record
//        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id' AND seq_no<$seq_no";
//        $object->rows_per_page = 1;
//        $object->pageno        = 1;
//        $object->sql_orderby   = 'inventory_date DESC';
//        $data = $object->getData_raw($where);
//        if (!empty($data)) {
//        	$prev_date = $data[0]['inventory_date'];
//        	if ($fieldarray['inventory_date'] <= $prev_date) {
//        		// "Inventory Date must be later than Inventory Date of previous entry"
//                $this->errors['inventory_date'] = getLanguageText('e0034');
//                $fieldarray['inventory_date'] = adjustDate($prev_date, +1);
//        	} // if
//        } // if

        // look for a next record
//        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id' AND seq_no>$seq_no";
//        $object->rows_per_page = 1;
//        $object->pageno        = 1;
//        $object->sql_orderby   = 'inventory_date ASC';
//        $data = $object->getData_raw($where);
//        if (!empty($data)) {
//        	$next_date = $data[0]['inventory_date'];
//        	if ($fieldarray['inventory_date'] >= $next_date) {
//        		// "Inventory Date must be earlier than Inventory Date of next entry"
//                $this->errors['inventory_date'] = getLanguageText('e0035');
//                $fieldarray['inventory_date'] = adjustDate($next_date, -1);
//        	} // if
//        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']) {
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'inventory_item';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'inventory_item';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'inventory_item';
                break;
            default:
                $lock_array = array();
        } // switch

        // turn all database locking OFF
        $GLOBALS['lock_tables'] = FALSE;
        $lock_array = array();

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('inv_var_reason_id', $this->lookup_data)) {
            // get array for inv_item_status_id and put into LOOKUP_DATA
            $object =& RDCsingleton::getInstance('inventory_variance_reason');
            $array  = $object->getValRep('inv_var_reason_id');
            $this->lookup_data['inv_var_reason_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['product_id'])
        and !empty($fieldarray['inventory_item_id'])) {
            $product_id         = $fieldarray['product_id'];
            $inventory_item_id  = $fieldarray['inventory_item_id'];
            $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id'";

            // check that this is a non-serialised item
            $object =& RDCsingleton::getInstance('inventory_item');
            $object->sql_select = 'inv_type';
            $data = $object->getData_raw($where);
            if ($data[0]['inv_type'] != 'N') {
            	// "This function is only valid for non-serialised items"
            	$this->errors[] = getLanguageText('e0039');
            } // if

            // set seq_no to next available number
            $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['seq_no'] = $count + 1;
        } // if

        if (empty($fieldarray['inventory_date'])) {
        	$fieldarray['inventory_date'] = getTimeStamp('date');
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        $fieldarray = $this->updateInvItemQty ($fieldarray);

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        $rowdata = $this->updateInvItemQty ($rowdata);

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        $rowdata = $this->updateInvItemQty ($rowdata);

        return $rowdata;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {
        // check that this is the latest record
//        $where = "product_id='{$fieldarray['product_id']}' AND " . "inventory_item_id='{$fieldarray['inventory_item_id']}'";
//        $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
//        $max = $this->getCount($query);
//
//        if ($fieldarray['seq_no'] != $max) {
//            // "This is not the last record so it cannot be deleted."
//            $this->errors[] = getLanguageText('e0007');
//        } // if

        return;

    } // _cm_validateDelete

// ****************************************************************************
} // end class
// ****************************************************************************

?>
