<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class inventory_item extends Default_Table
{
    // ****************************************************************************
    function inventory_item ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'inventory_item';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // inventory_item

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
            unset($this->fieldspec['inv_item_status_id']['noedit']);
        } // if

        if (!array_key_exists('variance_qty', $this->fieldspec)) {
        	$this->fieldspec['variance_qty']    = array('type' => 'integer',
                                                        'noedit' => 'y',
                                                        'minvalue' => -2147483648,
                                                        'maxvalue' => 2147483647,
                                                        'nondb' > 'y');
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($fieldarray['inv_type'])) {
        	switch ($fieldarray['inv_type']) {
        		case 'S':
                    if (empty($fieldarray['serial_no'])) {
                        // SERIAL_NO must be specified for serialised products
        		    	$this->errors['serial_no'] = getLanguageText('e0023');
        		    } // if
        		    if ($fieldarray['qty_on_hand'] != 1) {
        		        // QTY_ON_HAND must be 1 for serialised items
        		        $this->errors['qty_on_hand'] = getLanguageText('e0037');
        		        $fieldarray['qty_on_hand'] = 1;
            		    $fieldarray['total_qty']   = 1;
        		    } // if
        		    if (!empty($fieldarray['lot_id'])) {
        		        // LOT_ID must not be specified for serialised products
        		    	$this->errors['lot_id'] = getLanguageText('e0027');
        		    	$fieldarray['lot_id'] = null;
        		    } // if
        			break;

        		case 'N':
        		    if (!empty($fieldarray['serial_no'])) {
        		        // SERIAL_NO must not be specified for non-serialised products
        		    	$this->errors['serial_no'] = getLanguageText('e0024');
        		    	$fieldarray['serial_no'] = null;
        		    } // if
        		    if (empty($fieldarray['qty_on_hand'])) {
                        // QTY_ON_HAND must be specified for non-serialised products
        		    	$this->errors['qty_on_hand'] = getLanguageText('e0025');
        		    } elseif ($fieldarray['qty_on_hand'] < 1) {
        		        // QTY_ON_HAND must be greater than zero
        		        $this->errors['qty_on_hand'] = getLanguageText('e0026');
        		    } // if
        		    break;

        		default:
        		    // unknown value for INV_TYPE
        		    $this->errors['inv_type'] = getLanguageText('e0022', $fieldarray['inv_type']);
        			break;
        	} // switch
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('inv_type', $this->lookup_data)) {
            // get array for inv_type and put into LOOKUP_DATA
            $array = $this->getValRep('inv_type');
            $this->lookup_data['inv_type'] = $array;
        } // if

        if (!array_key_exists('inv_item_status_id', $this->lookup_data)) {
            // get array for inv_item_status_id and put into LOOKUP_DATA
            $object =& singleton::getInstance('inventory_item_status');
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
        // set inventory_item_id to next available number
        if (!empty($fieldarray['product_id'])) {
            $product_id  = $fieldarray['product_id'];
            $where = "product_id='$product_id'";
            $query = "SELECT max(inventory_item_id) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['inventory_item_id'] = $count + 1;
        } // if

        $fieldarray['inv_item_status_id'] = '1';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'inv_type') {
            $array = getLanguageArray('inv_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        $where = '';

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        if ($popupname == 'pro_container(popup)') {
            if (!empty($fieldarray['facility_id'])) {
            	// replace $where for this popup
                $where = "facility_id='" .$fieldarray['facility_id'] ."'";
            } // if
        } // if

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {

        if ($return_from == 'pro_facility(popup)') {
            $fieldarray['container_id'] = null;
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        switch ($GLOBALS['mode']) {
            case 'delete':
            case 'read':
            case 'update':
            	switch ($rowdata[0]['inv_type']) {
            		case 'S':
            		    unset($this->fieldspec['serial_no']['nodisplay']);
                        $this->fieldspec['qty_on_hand']['nodisplay']  = 'y';
                        $this->fieldspec['total_qty']['nodisplay']    = 'y';
                        $this->fieldspec['variance_qty']['nodisplay'] = 'y';
            			break;

            		case 'N':
            		    $this->fieldspec['serial_no']['nodisplay']   = 'y';
            		    unset($this->fieldspec['qty_on_hand']['nodisplay']);
            		    unset($this->fieldspec['total_qty']['nodisplay']);
            		    unset($this->fieldspec['variance_qty']['nodisplay']);
            		    break;

            		default:
            		    break;
            	} // switch
            default:
                break;
        } // switch

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (!eregi('(variance_qty)', $this->sql_select, $regs)) {
            if (empty($this->sql_select)) {
            	$this->sql_select = '*, qty_on_hand - total_qty AS variance_qty ';
            } else {
                $this->sql_select .= ', qty_on_hand - total_qty AS variance_qty ';
            } // if
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        $rowdata['total_qty']  = $rowdata['qty_on_hand'];

        return $rowdata;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive
        if (isPrimaryObject($this)) {
            // this object is the 1st in the current script
        	$rowdata['total_qty']  = $rowdata['qty_on_hand'] - $rowdata['variance_qty'];
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
