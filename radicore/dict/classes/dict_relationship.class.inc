<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_relationship extends Default_Table
{
    // member variables

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_relationship ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'dict_relationship';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // dict_relationship

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;
        if ($mode == 'search') {
            // in SEARCH mode set control to POPUP
            $this->fieldspec['table_id_snr']['control']       = 'popup';
            $this->fieldspec['table_id_snr']['task_id']       = 'dict_table(popup)snr';
            $this->fieldspec['table_id_snr']['foreign_field'] = 'table_id_snr';
            // remove NOEDIT switch
            unset($this->fieldspec['table_id_snr']['noedit']);
            // change from DROPDOWN to TEXT field
            unset($this->fieldspec['parent_field']['control']);
        } // if

		return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (!empty($fieldarray['orderby'])) {
            if ($fieldarray['rel_type'] != 'DEL') {
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
        //DebugBreak();
        // get contents of foreign table DICT_DATABASE and add as a LOOKUP list
        require_once 'dict_database.class.inc';
        $dbobject =& singleton::getInstance('dict_database');
        $array = $dbobject->getValRep('database_id');
        $this->lookup_data['database_id'] = $array;

        if (isset($fieldarray['database_id_snr']) AND !isset($fieldarray['database_id_jnr'])) {
            // current values are to be used for the SNR (parent)
            $fieldarray['database_id_jnr'] = $fieldarray['database_id_snr'];
            // remove the original values
            unset($fieldarray['database_id']);
            unset($fieldarray['table_id']);
        } // if

        if (isset($fieldarray['database_id_snr']) and isset($fieldarray['table_id_snr'])) {
            // get column details for snr table and add as a LOOKUP list
            require_once 'dict_column.class.inc';
            $dbobject =& singleton::getInstance('dict_column');
            $array = $dbobject->getValRep('column_id', "database_id='{$fieldarray['database_id_snr']}' AND table_id='{$fieldarray['table_id_snr']}'");
            $array = array_merge(array('' => ' ', '#calc#' => 'CALCULATED'), $array);
            $this->lookup_data['parent_field'] = $array;
        } // if

        // get array of relationship types
        $array = $this->getValRep('rel_type');
        $this->lookup_data['rel_type'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if (isset($fieldarray['database_id'])) {
            // current values are to be used for the SNR (parent)
            $fieldarray['database_id_snr'] = $fieldarray['database_id'];
            $fieldarray['table_id_snr']    = $fieldarray['table_id'];
            // remove the original values
            unset($fieldarray['database_id']);
            unset($fieldarray['table_id']);
        } // if

        if (!isset($fieldarray['database_id_jnr'])) {
            // set default for database_id_jnr
            $fieldarray['database_id_jnr'] = $fieldarray['database_id_snr'];
        } // if

        // this button causes confusion, so remove it
        unset($GLOBALS['act_buttons']['submitstay']);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'rel_type') {
            // provide values for dropdown list
//            $array['']    = ' ';
//            $array['RES'] = 'RESTRICTED';
//            $array['DEL'] = 'CASCADE';
//            $array['NUL'] = 'NULLIFY';
            $array = getLanguageArray('rel_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        switch ($popupname) {
            // replace $where string for this popup
        	case 'dict_table(popup)':
        		$where = "database_id='{$fieldarray['database_id_jnr']}'";
        		break;
        	case 'dict_table(popup)snr':
        		$where = "database_id='{$fieldarray['database_id_snr']}'";
        		break;
        	case 'dict_column(popup)':
        		$where = "database_id='{$fieldarray['database_id_snr']}' AND table_id='{$fieldarray['table_id_snr']}'";
        		break;
        	default:
        		;
        } // switch

        // ensure that only one entry can be selected
        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        //DebugBreak();
        switch ($return_from) {
            // move returned value to the correct field
        	case 'dict_table(popup)':
        		$fieldarray['table_id_jnr'] = $fieldarray['table_id'];
                // remove redundant data
                unset($fieldarray['database_id']);
                unset($fieldarray['table_id']);
        		break;
        	case 'dict_table(popup)snr':
        		$fieldarray['table_id_snr'] = $fieldarray['table_id'];
                // remove redundant data
                unset($fieldarray['database_id']);
                unset($fieldarray['table_id']);
        		break;
        	case 'dict_column(popup)':
        		$fieldarray['parent_field'] = $fieldarray['column_id'];
                // remove redundant data
                unset($fieldarray['database_id']);
                unset($fieldarray['table_id']);
                unset($fieldarray['column_id']);
        		break;
        	default:
        		;
        } // switch

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        $where = array2where($fieldarray, $this->getPkeyNames());

        // create initial records on DICT_RELATED_COLUMN table
        require_once 'dict_related_column.class.inc';
        $relobj =& singleton::getInstance('dict_related_column');

        $outarray = $relobj->getInitialData($fieldarray);
        $outarray = $relobj->insertMultiple($outarray);
        if ($relobj->getErrors()) {
            $this->errors = array_merge($this->errors, $relobj->getErrors());
            return $fieldarray;
        } // if

        // switch to task to maintain related columns
        $next['task_id'] = 'dict_related_column(multi)2';
        $next['where']   = $where;

        // this is processed by scriptnext() and scriptprevious()
        $_SESSION['script_sequence'][] = $next;

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        $where = str_replace('database_id=', 'database_id_snr=', $where );
        $where = str_replace('table_id=', 'table_id_snr=', $where );

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        if (empty($fieldarray['seq_no'])) {
            $fieldarray['seq_no'] = 0;
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        //DebugBreak();

        return $fieldarray;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
