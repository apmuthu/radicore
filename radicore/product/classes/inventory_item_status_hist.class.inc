<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class inventory_item_status_hist extends Default_Table
{
    // ****************************************************************************
    function inventory_item_status_hist ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'inventory_item_status_hist';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // inventory_item_status_hist

    // ****************************************************************************
    function updateInvItemStatus ($fieldarray)
    // update status on inventory_item record
    {
        // get status value with latest date
        $object =& RDCsingleton::getInstance('inventory_item_status_hist');
        $product_id        = $fieldarray['product_id'];
        $inventory_item_id = $fieldarray['inventory_item_id'];

        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id'";
        $object->rows_per_page = 1;
        $object->pageno        = 1;
        $object->sql_orderby   = 'status_date DESC';
        $data = $object->getData_raw($where);
        if (!empty($data)) {
        	$status_id = $data[0]['inv_item_status_id'];
        } else {
            $status_id = '1'; // no record found, so use default
        } // if

        // update inventory_item record with this value
        $object =& RDCsingleton::getInstance('inventory_item');
        $update['product_id']         = $product_id;
        $update['inventory_item_id']  = $inventory_item_id;
        $update['inv_item_status_id'] = $status_id;
        $object->updateRecord($update);
        $this->errors = array_merge($this->errors, $object->errors);

        return $fieldarray;

    } // updateInvItemStatus

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $today = getTimeStamp('date');
        if ($fieldarray['status_date'] > $today) {
        	// "Status date cannot be in the future"
            $this->errors['status_date'] = getLanguageText('e0032');
            return $fieldarray;
        } // if

        $object =& RDCsingleton::getInstance('inventory_item_status_hist');

        $product_id        = $fieldarray['product_id'];
        $inventory_item_id = $fieldarray['inventory_item_id'];
        $seq_no            = $fieldarray['seq_no'];

        // look for a previous record
        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id' AND seq_no<$seq_no";
        $object->rows_per_page = 1;
        $object->pageno        = 1;
        $object->sql_orderby   = 'status_date DESC';
        $data = $object->getData_raw($where);
        if (!empty($data)) {
        	$prev_date = $data[0]['status_date'];
        	if ($fieldarray['status_date'] <= $prev_date) {
        		// "Status Date must be later than Status Date of previous entry"
                $this->errors['status_date'] = getLanguageText('e0028');
                $fieldarray['status_date'] = adjustDate($prev_date, +1);
        	} // if
        	if ($fieldarray['inv_item_status_id'] == $data[0]['inv_item_status_id']) {
        		// "Status must not be same as Status of previous entry"
                $this->errors['inv_item_status_id'] = getLanguageText('e0030');
        	} // if
        } // if

        // look for a next record
        $where = "product_id='$product_id' AND inventory_item_id='$inventory_item_id' AND seq_no>$seq_no";
        $object->rows_per_page = 1;
        $object->pageno        = 1;
        $object->sql_orderby   = 'status_date ASC';
        $data = $object->getData_raw($where);
        if (!empty($data)) {
        	$next_date = $data[0]['status_date'];
        	if ($fieldarray['status_date'] >= $next_date) {
        		// "Status Date must be earlier than Status Date of next entry"
                $this->errors['status_date'] = getLanguageText('e0029');
                $fieldarray['status_date'] = adjustDate($next_date, -1);
        	} // if
        	if ($fieldarray['inv_item_status_id'] == $data[0]['inv_item_status_id']) {
        		// "Status must not be same as Status of next entry"
                $this->errors['inv_item_status_id'] = getLanguageText('e0031');
        	} // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('inv_item_status_id', $this->lookup_data)) {
            // get array for inv_item_status_id and put into LOOKUP_DATA
            $object =& RDCsingleton::getInstance('inventory_item_status');
            $array  = $object->getValRep('inv_item_status_id');
            $this->lookup_data['inv_item_status_id'] = $array;
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

            // check that this is a serialised item
            $object =& RDCsingleton::getInstance('inventory_item');
            $object->sql_select = 'inv_type';
            $data = $object->getData_raw($where);
            if ($data[0]['inv_type'] != 'S') {
            	// "This function is only valid for serialised items"
            	$this->errors[] = getLanguageText('e0038');
            } // if

            // set seq_no to next available number
            $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['seq_no'] = $count + 1;
        } // if

        if (empty($fieldarray['status_date'])) {
        	$fieldarray['status_date'] = getTimeStamp('date');
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        $fieldarray = $this->updateInvItemStatus ($fieldarray);

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        $rowdata = $this->updateInvItemStatus ($rowdata);

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        $rowdata = $this->updateInvItemStatus ($rowdata);

        return $rowdata;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {
        // check that this is the latest record
        $where = "product_id='{$fieldarray['product_id']}' AND " . "inventory_item_id='{$fieldarray['inventory_item_id']}'";
        $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
        $max = $this->getCount($query);

        if ($fieldarray['seq_no'] != $max) {
            // "This is not the last record so it cannot be deleted."
            $this->errors[] = getLanguageText('e0007');
        } // if

        return;

    } // _cm_validateDelete

// ****************************************************************************
} // end class
// ****************************************************************************

?>
