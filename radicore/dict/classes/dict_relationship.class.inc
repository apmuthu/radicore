<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_relationship extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'dict_relationship';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;
        if ($mode == 'search') {
            // remove NOEDIT switches
            unset($this->fieldspec['table_id_snr']['noedit']);
            unset($this->fieldspec['table_id_jnr']['noedit']);
            if (isset($fieldarray['table_id_jnr'])) {
                // in SEARCH mode set control to POPUP
                $this->fieldspec['table_id_snr']['control']       = 'popup';
                $this->fieldspec['table_id_snr']['task_id']       = 'dict_table(popup2)snr';
                $this->fieldspec['table_id_snr']['foreign_field'] = 'table_id_snr';

            } elseif (isset($fieldarray['table_id_snr'])) {
                // in SEARCH mode set control to POPUP
                $this->fieldspec['table_id_jnr']['control']       = 'popup';
                $this->fieldspec['table_id_jnr']['task_id']       = 'dict_table(popup2)jnr';
                $this->fieldspec['table_id_jnr']['foreign_field'] = 'table_id_jnr';
            } // if
            // change from DROPDOWN to TEXT field
            unset($this->fieldspec['parent_field']['control']);
            unset($this->fieldspec['key_name']['control']);
        } // if

        if ($GLOBALS['task_id'] == 'dict_related_column(multi4)a' OR $GLOBALS['task_id'] == 'dict_related_column(multi4)b') {
            // insert some javascript to submit form when a different value is selected in this dropdown list
            $this->fieldspec['key_name']['javascript'] = array('onchange' => 'this.form.submit();');
        } // if

		return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($fieldarray['table_alias_snr'])) {
            $count = preg_match_all('/\w+/', $fieldarray['table_alias_snr'], $regs);
            if ($count > 1) {
                // "This field can only contain a single word"
            	$this->errors['table_alias_snr'] = getLanguageText('e0039');
            } // if
        } // if

        if (!empty($fieldarray['table_alias_jnr'])) {
            $count = preg_match_all('/\w+/', $fieldarray['table_alias_jnr'], $regs);
            if ($count > 1) {
                // "This field can only contain a single word"
            	$this->errors['table_alias_jnr'] = getLanguageText('e0039');
            } // if
        } // if

//        if (empty($fieldarray['relation_name'])) {
//        	if (!empty($fieldarray['table_id_snr']) and !empty($fieldarray['table_id_jnr'])) {
//        		$fieldarray['relation_name'] = 'Links ' .strtoupper($fieldarray['table_id_snr']) .' to ' .strtoupper($fieldarray['table_id_jnr']);
//        	} // if
//        } // if

        if (!empty($fieldarray['orderby'])) {
            if ($fieldarray['relation_type'] != 'DEL') {
                $this->errors['orderby'] = getLanguageText('e0020'); // "Invalid unless relation type = 'DELETE'";
            } // if
        } // if

        if (!empty($fieldarray['calc_field'])) {
            if ($fieldarray['parent_field'] != '#calc#') {
                $this->errors['calc_field'] = getLanguageText('e0021'); // "Invalid unless display field = 'CALCULATED'";
            } // if
        } // if

        if ($fieldarray['parent_field'] == '#calc#') {
            if (empty($fieldarray['calc_field'])) {
                $this->errors['calc_field'] = getLanguageText('e0022'); // "Required if display field = 'CALCULATED'";
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(list1)/i', $pattern_id)
          OR preg_match('/^(list2)/i', $pattern_id) AND $this->zone == 'inner') {
            if (!empty($fieldarray['table_alias_snr'])) {
                $fieldarray['table_id_snr'] .= ' ('.$fieldarray['table_alias_snr'].')';
            } // if
            if (!empty($fieldarray['table_alias_jnr'])) {
                $fieldarray['table_id_jnr'] .= ' ('.$fieldarray['table_alias_jnr'].')';
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

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
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_related_column';
                $lock_array[] = 'dict_table_key';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_related_column';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_related_column';
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
        if (!array_key_exists('database_id', $this->lookup_data)) {
            // get contents of foreign table DICT_DATABASE and add as a LOOKUP list
            $dbobject = RDCsingleton::getInstance('dict_database');
            $array = $dbobject->getValRep('database_id');
            $this->lookup_data['database_id'] = $array;
        } // if

        if (isset($fieldarray['database_id_snr']) AND !isset($fieldarray['database_id_jnr'])) {
            // current values are to be used for the SNR (parent)
            $fieldarray['database_id_jnr'] = $fieldarray['database_id_snr'];
            // remove the original values
            unset($fieldarray['database_id']);
            unset($fieldarray['table_id']);
        } // if

        if (isset($fieldarray['database_id_snr']) and isset($fieldarray['table_id_snr'])) {
            // get column details for snr table and add as a LOOKUP list
            $dbobject = RDCsingleton::getInstance('dict_column');
            $array = $dbobject->getValRep('column_id', "database_id='{$fieldarray['database_id_snr']}' AND table_id='{$fieldarray['table_id_snr']}'");
            $array = array_merge(array('' => ' ', '#calc#' => 'CALCULATED'), $array);
            $this->lookup_data['parent_field'] = $array;
        } // if

        if (!array_key_exists('relation_type', $this->lookup_data)) {
            // get array of relationship types
            $array = $this->getValRep('relation_type');
            $this->lookup_data['relation_type'] = $array;
        } // if

        //if (!array_key_exists('key_name', $this->lookup_data)) {
            if (!empty($fieldarray['database_id_snr']) AND !empty($fieldarray['table_id_snr'])) {
                $array = $this->_showKeyNames($fieldarray['database_id_snr'], $fieldarray['table_id_snr']);
            } else {
                // get the names of all unique keys
                $array = $this->getValRep('key_name');
            } // if
            $this->lookup_data['key_name'] = $array;
        //} // if

        $pattern_id = getPatternId();

//        if (preg_match('/^(list1)$/i', $pattern_id)
//        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
//        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('database_id_snr' => 'Database Id Snr',
//                               'table_id_snr' => 'Table Id Snr',
//                               'database_id_jnr' => 'Database Id Jnr',
//                               'table_id_jnr' => 'Table Id Jnr');
//                $this->lookup_data['quicksearch_field'] = $array;
//            } // if
//        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'relation_type') {
//            // provide values for dropdown list
//            $array['RES'] = 'RESTRICTED';
//            $array['DEL'] = 'CASCADE';
//            $array['NUL'] = 'NULLIFY';
            $array = getLanguageArray('relation_type');
            return $array;
        } // if

        if ($item == 'key_name') {
            // provide values for dropdown list
            $array['PRIMARY'] = 'PRIMARY';
            return $array;
        } // if

        if ($item == 'table_alias_snr') {
            // get data from the database
            $this->sql_select     = 'table_id_snr, table_alias_snr';
            $this->sql_orderby    = 'table_alias_snr';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where .' AND table_alias_snr IS NOT NULL');

            // convert each row into 'alias=alias' in the output array
            foreach ($data as $row => $rowdata) {
                $text = $rowdata['table_id_snr'] .' AS ' .$rowdata['table_alias_snr'];
                $array[$text] = $text;
            } // foreach
            $array = array_unique($array);  // remove duplicate entries
            return $array;
        } // if

        if ($item == 'table_alias_jnr') {
            // get data from the database
            $this->sql_select     = 'table_id_jnr, table_alias_jnr';
            $this->sql_orderby    = 'table_alias_jnr';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where .' AND table_alias_jnr IS NOT NULL');

            // convert each row into 'alias=alias' in the output array
            foreach ($data as $row => $rowdata) {
                $text = $rowdata['table_id_jnr'] .' AS ' .$rowdata['table_alias_jnr'];
                $array[$text] = $text;
            } // foreach
            $array = array_unique($array);  // remove duplicate entries
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['database_id_snr'] = 'Total count:';
        $array['table_id_snr'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        switch ($name) {
        	case 'multi1':
                // return a non-empty dummy array - this is labels only
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi2':
                // retrieve associated data from RELATED_COLUMN table
                $object = RDCsingleton::getInstance('dict_related_column');
                $db_id_snr  = $fieldarray['database_id_snr'];
                $tbl_id_snr = $fieldarray['table_id_snr'];
                $db_id_jnr  = $fieldarray['database_id_jnr'];
                $tbl_id_jnr = $fieldarray['table_id_jnr'];
                $seq_no     = $fieldarray['seq_no'];
                $object->sql_orderby = 'seq_in_index asc';
                $outarray = $object->getData("database_id_snr='$db_id_snr' AND table_id_snr='$tbl_id_snr' AND database_id_jnr='$db_id_jnr' AND table_id_jnr='$tbl_id_jnr' AND seq_no=$seq_no");
                if (empty($outarray)) {
                    // print an empty line
                	$outarray[] = array('dummy' => '');
                } // if
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
        switch ($popupname) {
            // replace $where string for this popup
        	case 'dict_table(popup2)':
        		$where = "database_id='{$fieldarray['database_id_jnr']}'";
        		break;
        	case 'dict_table(popup2)snr':
        		$where = "database_id='{$fieldarray['database_id_snr']}'";
        		break;
        	case 'dict_column(popup2)':
        		$where = "database_id='{$fieldarray['database_id_snr']}' AND table_id='{$fieldarray['table_id_snr']}'";
        		break;
        	default:
        		$where = '';
        } // switch

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array, $return_files)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {
        switch ($return_from) {
            // move returned value to the correct field
            case 'dict_table(popup2)':
//                $fieldarray['database_id_jnr'] = $select_array['database_id'];
//                $fieldarray['table_id_jnr']    = $select_array['table_id'];
//                unset($select_array['database_id']);
//                unset($select_array['table_id']);
                break;
            case 'dict_table(popup2)snr':
//                $fieldarray['database_id_snr'] = $select_array['database_id'];
//                $fieldarray['table_id_snr']    = $select_array['table_id'];
//                unset($select_array['database_id']);
//                unset($select_array['table_id']);
                break;
            case 'dict_column(popup1)':
//                $fieldarray['parent_field'] = $select_array['column_id'];
//                unset($select_array['database_id']);
//                unset($select_array['table_id']);
//                unset($select_array['column_id']);
                break;
            default:
                ;
        } // switch

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count++;
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        if (is_string(key($rows))) {
        	if (isset($rows['database_id_snr']) and isset($rows['table_id_snr'])) {
                // get column details for snr table and add as a LOOKUP list
                $dbobject = RDCsingleton::getInstance('dict_column');
                $array = $dbobject->getValRep('column_id', "database_id='{$rows['database_id_snr']}' AND table_id='{$rows['table_id_snr']}'");
                $array = array_merge(array('#calc#' => 'CALCULATED'), $array);
                $this->lookup_data['parent_field'] = $array;
            } // if
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // look for entries where the specified table is SENIOR
        // in order to find all its JUNIOR relationships
        $where = str_replace('database_id=', 'database_id_snr=', $where );
        $where = str_replace('table_id=', 'table_id_snr=', $where );

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        if (empty($fieldarray['relation_name'])) {
            if (!empty($fieldarray['table_id_snr']) and !empty($fieldarray['table_id_jnr'])) {
                $fieldarray['relation_name'] = 'Links ' .strtoupper($fieldarray['table_id_snr']) .' to ' .strtoupper($fieldarray['table_id_jnr']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation
    {
        // custom code goes here

        return $filename;

    } // _cm_pre_output

    // ****************************************************************************
    function _cm_updateFieldarray ($fieldarray, &$postarray, $rownum)
    // allow object to deal with any changes POSTed from the form.
    // $fieldarray contains current data from one row.
    // $postarray contains any changes made in the form for this row.
    // $rownum identifies which row is being processed.
    // NOTE: the contents of $postarray will be mered with $fieldarray after this call.
    // $postarray is PASSED BY REFERENCE to allow you to remove unwanted values.
    {
        if (is_object($this->child_object) AND $this->child_object instanceof dict_related_column) {
            if (isset($postarray['key_name']) AND isset($fieldarray['key_name']) AND $postarray['key_name'] != $fieldarray['key_name']) {
                // name of key has changed, so replace data on DICT_RELATED_COLUMN table
                $fieldarray['key_name'] = $postarray['key_name'];  // change to this value
                $result = $this->_setRelatedColumns($fieldarray);
                if ($result == false) {
                    return $fieldarray;
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_updateFieldarray

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _showKeyNames ($dbname, $tablename)
    // identify the names of all unique keys in this table (for the dropdown list).
    {
        $key_names = array();

        $dbobject = RDCsingleton::getInstance('dict_table_key');
        $where = "database_id='$dbname' AND table_id='$tablename' AND is_unique='Y'";
        $data = $dbobject->getData($where);

        foreach ($data as $entry) {
            $key_name = $entry['key_name'];
            $key_names[$key_name] = $key_name;
        } // foreach

        return $key_names;

    } // _showKeyNames

    // ****************************************************************************
    function _setRelatedColumns ($reldata)
    // create entries on the DICT_RELATED_COLUMN table for this relationship.
    {
        if (is_string($reldata)) {
            $where_array = where2array($reldata);
            $where       = $reldata;
        } else {
            $where_array = $reldata;
            $where       = array2where($reldata);
        } // if

        $relOBJ = RDCsingleton::getInstance('dict_related_column');
        $relOBJ->startTransaction();
        $where2 = array2where($where_array, array('database_id_snr','table_id_snr','database_id_jnr','table_id_jnr','seq_no'));
        $del = $relOBJ->deleteSelection($where2);
        if (empty($relOBJ->errors)) {
            $where2 = array2where($where_array, array('database_id_snr','table_id_snr','database_id_jnr','table_id_jnr','seq_no','key_name'));
            $colarray = $relOBJ->getInitialDataMultiple($where2);
            $colarray = $relOBJ->insertMultiple($colarray);
        } // if
        if ($relOBJ->errors) {
            $this->errors[$relOBJ->getClassName()] = $relOBJ->getErrors();
            $relOBJ->rollback();
            return false;
        } else {
            $relOBJ->commit();
        } // if

        $this->setChildData($colarray);  // put this amended data into the child object

        return $where_array;

    } // _setRelatedColumns

// ****************************************************************************
} // end class
// ****************************************************************************

?>
