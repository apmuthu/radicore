<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_person extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'xample';
        $this->tablename   = 'x_person';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function getFieldSpec_original ()
    // set the specifications for this database table.
    {
        $fieldspec = parent::getFieldSpec_original();

        // if using the Oracle database then exclude field 'favourite_food'
        // as the OCI8 driver cannot deal with VARRAY types.
        //if ($this->dbms_engine == 'oracle' AND version_compare(phpversion(), '5.0.0', '<')) {
        if (preg_match('/(oracle|sqlsrv)/i', $this->dbms_engine)) {
            unset($fieldspec['favourite_food']);
        } // if

        return $fieldspec;

    } // if

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
            // include fields from PERSON_ADDR table
            $this->fieldspec['county']      = array('type' => 'string', 'size' => 30);
            $this->fieldspec['postcode']    = array('type' => 'string', 'size' => 10);
        } else {
            if (empty($this->fieldspec['video_id'])) {
                $this->fieldspec['video_id']        = array('type' => 'string',
                                                            'size' => 255,
                                                            'subtype' => 'video',
                                                            'preload' => 'y',
                                                            'imageheight' => 360,
                                                            'imagewidth' => 640,
                                                            'control' => 'filepicker',
                                                            'task_id' => 'x_person(filepicker)video');
            } // if
            if (empty($where) AND !empty($fieldarray)) {
                $fieldarray['video_id'] = 'videos\mov_bbb.mp4';
            } // if
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
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
//        if (!isset($fieldarray['person_name'])) {
//            // merge first_name and last_name into person_name
//            if (isset($fieldarray['first_name']) AND isset($fieldarray['last_name'])) {
//                $fieldarray['person_name'] = $fieldarray['first_name']
//                                           . ' '
//                                           . $fieldarray['last_name'];
//            } // if
//        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getColumnNames ($fieldarray)
    // modify data to be used by 'std.output4.inc'.
    {
        $fieldarray = array();  // clear current list

        // set the defaults for this screen
        $fieldarray['person_id'] = 'Y';
        $fieldarray['first_name'] = 'N';
        $fieldarray['last_name'] = 'N';
        $fieldarray['initials'] = 'N';
        $fieldarray['person_name'] = 'Y';
        $fieldarray['pers_type_id'] = 'N';
        $fieldarray['pers_type_desc'] = 'Y';
        $fieldarray['node_id'] = 'N';
        $fieldarray['node_desc'] = 'N';
        $fieldarray['nat_ins_no'] = 'N';
        $fieldarray['star_sign'] = 'N';
        $fieldarray['email_addr'] = 'Y';
        $fieldarray['value1'] = 'Y';
        $fieldarray['value2'] = 'Y';
        $fieldarray['start_date'] = 'Y';
        $fieldarray['end_date'] = 'Y';
        $fieldarray['favourite_food'] = 'N';

        return $fieldarray;

    } // _cm_getColumnNames

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
                $lock_array[] = 'x_pers_opt_xref';
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
        if (!array_key_exists('star_sign', $this->lookup_data)) {
            // get values for star_sign and insert into lookup array
            $array = $this->getValRep('star_sign');
            $this->lookup_data['star_sign'] = $array;
            //$this->lookup_data[] = $array;  // cause a fatal error
        } // if

        if (!array_key_exists('favourite_food', $this->lookup_data)) {
            // get values for favourite_food and insert into lookup array
            $array = $this->getValRep('favourite_food');
            $this->lookup_data['favourite_food'] = $array;
        } // if

        if (!array_key_exists('pers_type_id', $this->lookup_data)) {
            // get contents of foreign table and add to lookup array
            $pers_type =& RDCsingleton::getInstance('x_pers_type');
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
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // customisable code goes here

//        $pattern_id = getPatternId();
//        if (preg_match('/^(add)/i', $pattern_id)) {
//        	// ignore contents of selection
//        	$selection = null;
//        } else {
//            if (!empty($selection)) {
//            	$where     = $selection;
//            	$selection = null;
//            } // if
//        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // customisable code goes here

        if (empty($this->sql_from)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
            // combine two fields intoone
            $this->sql_select .= ", CONCAT(first_name, ' ', last_name) AS person_name";
            // ***** TEST *****
            //$this->sql_select .= ", (SELECT SUM(credit_amount) FROM test_credit WHERE test_credit.person_id=x_person.person_id) AS credit_amount";
            //$this->sql_select .= ", (SELECT SUM(debit_amount) FROM test_debit WHERE test_debit.person_id=x_person.person_id) AS debit_amount";
            //$this->sql_having = "credit_amount <> debit_amount";
            //$this->sql_having = "credit_amount - debit_amount <> 0";
            // ***** TEST *****
        } // if

        $pattern_id = getPatternId();
        if (preg_match('/output/i', $pattern_id) AND !empty($GLOBALS['sql_orderby'])) {
        	$this->sql_orderby = $GLOBALS['sql_orderby'];
        } // if

        if (!empty($this->sql_search)) {
        	$search_array = where2array($this->sql_search, false, false);
        	if (!empty($search_array['county'])) {
        		$search_array[] = "AND EXISTS (SELECT county"
        		                            ." FROM x_person_addr"
        		                            ." WHERE x_person_addr.person_id=x_person.person_id"
        		                              ." AND x_person_addr.county LIKE '{$search_array['county']}')";
        	    unset($search_array['county']);
        	} // if
        	if (!empty($search_array['postcode'])) {
        		$search_array[] = "AND EXISTS (SELECT postcode"
        		                            ." FROM x_person_addr"
        		                            ." WHERE x_person_addr.person_id=x_person.person_id"
        		                              ." AND x_person_addr.postcode LIKE '{$search_array['postcode']}')";
        	    unset($search_array['postcode']);
        	} // if
        	$this->sql_search = array2where($search_array);
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation
    {
//        if ($GLOBALS['mode'] == 'pdf-list') {
//            // replace report headings
//            $replace = array('initials' => 'ONE',
//                             'star_sign' => 'TWO',
//                             'pers_type_desc' => 'THREE');
//            $result = replaceReportHeadings ($replace);
//        } // if

        return $filename;

    } // _cm_pre_output

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
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
    function _cm_initialiseFilePicker ($fieldarray, $search)
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        $this->picker_subdir      = 'pictures';

        // identify the file types that may be picked
        $this->picker_filetypes   = array('bmp', 'jpg', 'png', 'gif');

        return $fieldarray;

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
    function _cm_ListView_print_before ($prev_row, $curr_row)
    // allow extra rows to be created in List View
    {
        $output = array();

        if (!empty($prev_row)) {
            $lines_left = $this->pdf->getLinesRemaining();
            if (substr($prev_row['last_name'], 0, 1) != substr($curr_row['last_name'], 0, 1)) {
                // first character of last name has changed
            	$this->pdf->AddPage();
            } // if
        } // if

//        $output[0]['pers_type_desc'] = 'before ' .$curr_row['person_id'];

        return $output;

    } // _cm_ListView_print_before

    // ****************************************************************************
    function _cm_ListView_print_after ($curr_row, $next_row)
    // allow extra rows to be created in List View
    {
        $output = array();

//        $output[0]['pers_type_desc'] = 'after ' .$curr_row['person_id'];

//        $lines_left = $this->pdf->getLinesRemaining();

        if (substr($next_row['last_name'], 0, 1) != substr($curr_row['last_name'], 0, 1)) {
            // first character of last name has changed
            $output[0]['pers_type_desc'] = 'after ' .$curr_row['person_id'];
        } // if

        return $output;

    } // _cm_ListView_print_after

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['pers_type_desc'] = 'Count:';
        $array['value2'] = $this->count;

        return $array;

    } // _cm_ListView_total

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
                $object =& RDCsingleton::getInstance('x_person_addr');
                $where = array2where($fieldarray, $this->getPkeyNames());
                $object->sql_orderby = 'address_no asc';
                $outarray = $object->getData($where);
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
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        if ($popupname == 'x_tree_structure(popup4)') {
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

        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count ++;
        } // if

//        if ($fieldarray['last_name'] == 'Lucan') {
//            $this->pdf->AddPage();
//        } // if

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

        $dbobject =& RDCsingleton::getInstance('x_person_addr');

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
            $dbobject =& RDCsingleton::getInstance('x_person_addr');

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
