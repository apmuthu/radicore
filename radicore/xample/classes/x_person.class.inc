<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_person extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function x_person()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'x_person';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // x_person

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
            $prev_script = getPreviousScript();
            $pattern_id  = getPatternId($prev_script);
            if ($pattern_id == 'LINK1') {
                // add an extra field to the field list
                $this->fieldspec['selected'] = array('type' => 'boolean');
            } // if
            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['last_addr_no']['noedit']);
        } // if

        // if using the Oracle database then exclude field 'favourite_food'
        // as the OCI8 driver cannot deal with VARRAY types.
        //if ($this->dbms_engine == 'oracle' AND version_compare(phpversion(), '5.0.0', '<')) {
        if ($this->dbms_engine == 'oracle') {
        	unset($this->fieldspec['favourite_food']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['start_date'] > $fieldarray['end_date']) {
            // 'Start Date cannot be later than End Date';
            $this->errors['start_date'] = getLanguageText('e0001');
            // 'End Date cannot be earlier than Start Date';
            $this->errors['end_date']   = getLanguageText('e0002');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        if (!isset($fieldarray['person_name'])) {
            // merge first_name and last_name into person_name
            if (isset($fieldarray['first_name']) AND isset($fieldarray['last_name'])) {
                $fieldarray['person_name'] = $fieldarray['first_name']
                                           . ' '
                                           . $fieldarray['last_name'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = TRUE;     // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']) {
            case 'insert':
                $lock_array[] = $this->tablename;
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person_addr';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person_addr';
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('star_sign', $this->lookup_data)) {
            // get values for star_sign and insert into lookup array
            $array = $this->getValRep('star_sign');
            $this->lookup_data['star_sign'] = $array;
        } // if

        if (!array_key_exists('favourite_food', $this->lookup_data)) {
            // get values for favourite_food and insert into lookup array
            $array = $this->getValRep('favourite_food');
            $this->lookup_data['favourite_food'] = $array;
        } // if

        if (!array_key_exists('pers_type_id', $this->lookup_data)) {
            // get contents of foreign table and add to lookup array
            $pers_type =& singleton::getInstance('x_pers_type');
            $pers_type_array = $pers_type->getValRep('pers_type_id');
            $this->lookup_data['pers_type_id'] = $pers_type_array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // this field is irrelevant for insert
        $this->fieldspec['last_addr_no']['nodisplay'] = 'y';
        $fieldarray['last_addr_no'] = 0;

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item='', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'star_sign') {
            // $array = $this->getEnum($item);
//            $array['ARI'] = 'Aries';
//            $array['AQU'] = 'Aquarius';
//            $array['CAN'] = 'Cancer';
//            $array['CAP'] = 'Capricorn';
//            $array['GEM'] = 'Gemini';
//            $array['LEO'] = 'Leo';
//            $array['LIB'] = 'Libra';
//            $array['PIS'] = 'Pisces';
//            $array['SAG'] = 'Sagittarius';
//            $array['SCO'] = 'Scorpio';
//            $array['TAU'] = 'Taurus';
//            $array['VIR'] = 'Virgo';
            $array = getLanguageArray('star_sign');
            return $array;
        } // if

        if ($item == 'favourite_food') {
            $array = getLanguageArray('favourite_food');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialiseFilePicker ()
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        $this->picker_subdir      = 'pictures';

        // identify the file types that may be picked
        $this->picker_filetypes   = array('bmp', 'jpg', 'png', 'gif');

        return;

    } // _cm_initialiseFilePicker

    // ****************************************************************************
    function _cm_initialiseFileUpload ($fieldarray)
    // perform any initialisation before displaying the File Upload screen.
    {
        $this->upload_subdir      = 'pictures';
        //$this->upload_filetypes   = array('image/x-png', 'image/gif');
        $this->upload_filetypes   = 'image';
        $this->upload_maxfilesize = 100000;

        return $fieldarray;

    } // _cm_initialiseFileUpload

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        switch ($name) {
        	case 'multi1':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi2':
                // retrieve associated data from PERSON_ADDR table
                $object =& singleton::getInstance('x_person_addr');
                $person_id  = $fieldarray['person_id'];
                $object->sql_orderby = 'address_no asc';
                $outarray = $object->getData("person_id='$person_id'");
                if (empty($outarray)) {
                    // print an empty line
                    $outarray[] = array('dummy' => '');
                } else {
                    // format each record
                    foreach ($outarray as $rownum => $rowdata) {
                        // format all dates
                    	$rowdata = $object->formatData($rowdata);
                    	// construct address line
                    	$address_long = $rowdata['addr_line_1'];
                    	if (!empty($rowdata['addr_line_2'])) {
                    		$address_long .= "\n" .$rowdata['addr_line_2'];
                    	} // if
                    	if (!empty($rowdata['addr_line_3'])) {
                    		$address_long .= "\n" .$rowdata['addr_line_3'];
                    	} // if
                    	if (!empty($rowdata['town'])) {
                    		$address_long .= "\n" .$rowdata['town'];
                    	} // if
                    	if (!empty($rowdata['county'])) {
                    		$address_long .= "\n" .$rowdata['county'];
                    	} // if
                    	if (!empty($rowdata['postcode'])) {
                    		$address_long .= "\n" .$rowdata['postcode'];
                    	} // if

                        $rowdata['address_long'] = $address_long;
                        $outarray[$rownum] = $rowdata;  // required for PHP4
                    } // foreach
                } // if

        		break;

        	case 'multi3':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi4':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
                break;

        	case 'multi5':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi6':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi7':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi8':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi9':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	default:
        		break;
        } // switch

        if ($outarray) {
        	return $outarray;
        } else {
            return false;
        } // if

    } // _cm_output_multi

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        if ($popupname == 'x_tree_structure(popup)') {
            // structure must be of type 'ORG'
            $where = "tree_type_id='ORG'";
        } // if

		// allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-detail') {
        	$fieldarray['barcode'] = '0123456789';
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        // do nothing if there are no addresses yet
        if ($fieldarray['last_addr_no'] == 0) {
            return $fieldarray;
        } // if

        $dbobject =& singleton::getInstance('x_person_addr');

        if ($fieldarray['start_date'] <> $old_data['start_date']) {
            // update start date on first address
            $first_array['person_id']  = $fieldarray['person_id'];
            $first_array['address_no'] = '1';
            $first_array['start_date'] = $fieldarray['start_date'];
        } // if

        if ($fieldarray['end_date'] <> $old_data['end_date']) {
            if ($fieldarray['last_addr_no'] == 1) {
                // update end date on first (only) address
                $first_array['person_id']  = $fieldarray['person_id'];
                $first_array['address_no'] = '1';
                $first_array['end_date']   = $fieldarray['end_date'];
            } else {
                // update end date on last address
                $last_array['person_id']  = $fieldarray['person_id'];
                $last_array['address_no'] = $fieldarray['last_addr_no'];
                $last_array['end_date']   = $fieldarray['end_date'];
            } // if
        } // if

        if (isset($first_array)) {
            $dbobject->skip_validation = true;
            $first_array = $dbobject->updateRecord($first_array);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $fieldarray;
            } // if
        } // if

        if (isset($last_array)) {
            $dbobject->skip_validation = true;
            $last_array = $dbobject->updateRecord($last_array);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $orignaldata)
    // perform custom validation before update.
    {
        // get current value for 'last_addr_no'
        $last_addr_no = $fieldarray['last_addr_no'];

        // no validation required if $last_addr_no = 0 or 1
        if ($last_addr_no > 1) {
            // there is more than one address, so...
            $dbobject =& singleton::getInstance('x_person_addr');

            // compare start date with end date of first address
            $dbobject->sql_select = 'end_date';
            $where_array['person_id']  = $fieldarray['person_id'];
            $where_array['address_no'] = 1;
            $where = array2where($where_array);
            $first_addr_data = $dbobject->getdata_raw($where);
            if ($dbobject->numrows <> 1) {
                // "Could not locate first ADDRESS record"
                $this->errors[] = getLanguageText('e0010');
                return $fieldarray;
            } // if

            $first_addr_data = $first_addr_data[0];  // extract array for first occurrence only

            if ($fieldarray['start_date'] > $first_addr_data['end_date']) {
                $fieldarray['start_date'] = $first_addr_data['end_date'];
                // 'Start Date cannot be later than End Date of first address'
                $this->errors['start_date'] = getLanguageText('e0011');
                return $fieldarray;
            } // if

            // compare end date with start date of last address
            $dbobject->sql_select = 'start_date';
            $where_array['person_id']  = $fieldarray['person_id'];
            $where_array['address_no'] = $last_addr_no;
            $where = array2where($where_array);
            $last_addr_data = $dbobject->getdata_raw($where);
            if ($dbobject->numrows <> 1) {
                // "Could not locate last ADDRESS record"
                $this->errors[] = getLanguageText('e0012');
                return $fieldarray;
            } // if

            $last_addr_data = $last_addr_data[0];  // extract array for first occurrence only

            if ($fieldarray['end_date'] < $last_addr_data['start_date']) {
                $fieldarray['end_date'] = $last_addr_data['start_date'];
                // 'End Date cannot be earlier than Start Date of last address'
                $this->errors['end_date'] = getLanguageText('e0013');
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
