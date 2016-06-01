<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_table extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_table ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
        $this->tablename   = 'dict_table';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // dict_table

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
            if (empty($where)) {
            	// use ordinary textbox in a search screen
                unset($this->fieldspec['alt_language_table']['control']);
            } // if
            unset($this->fieldspec['alt_language_cols']['noedit']);
            // change these fields from popup to text box
            unset($this->fieldspec['nameof_start_date']['control']);
            unset($this->fieldspec['nameof_end_date']['control']);
        } else {
			// do not replace database id with textual description
		    unset($this->fieldspec['database_id']['control']);
		} // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($fieldarray['nameof_start_date']) OR !empty($fieldarray['nameof_end_date'])) {
        	if ($fieldarray['nameof_start_date'] == $fieldarray['nameof_end_date']) {
        	    // alias names cannot be the same
        		$this->errors['nameof_start_date'] = getLanguageText('e0060');
        		$this->errors['nameof_end_date']   = getLanguageText('e0061');
        		return $fieldarray;
        	} // if

            $dbobject =& RDCsingleton::getInstance('dict_column');
            $dbobject->sql_select = 'database_id, table_id, column_id, col_type';

            if (!empty($fieldarray['nameof_start_date'])) {
                if (preg_match('/^(start_date|end_date)$/i', $fieldarray['nameof_start_date'])) {
                    // Alias name cannot be either START_DATE or END_DATE
                    $this->errors['nameof_start_date'] = getLanguageText('e0062');
                } else {
                    $data = $dbobject->getData_raw("database_id='{$fieldarray['database_id']}' AND table_id='{$fieldarray['table_id']}' AND column_id='{$fieldarray['nameof_start_date']}'");
                    $type =& $data[0]['col_type'];
                    if (!preg_match('/^(date|datetime)$/i', $type)) {
                        // Alias name must be of type DATE or DATETIME
                    	$this->errors['nameof_start_date'] = getLanguageText('e0063');
                    } // if
                } // if
            } // if

            if (!empty($fieldarray['nameof_end_date'])) {
                if (preg_match('/^(start_date|end_date)$/i', $fieldarray['nameof_end_date'])) {
                    // Alias name cannot be either START_DATE or END_DATE
                    $this->errors['nameof_end_date'] = getLanguageText('e0062');
                } else {
                    $data = $dbobject->getData_raw("database_id='{$fieldarray['database_id']}' AND table_id='{$fieldarray['table_id']}' AND column_id='{$fieldarray['nameof_end_date']}'");
                    $type =& $data[0]['col_type'];
                    if (!preg_match('/^(date|datetime)$/i', $type)) {
                        // Alias name must be of type DATE or DATETIME
                    	$this->errors['nameof_end_date'] = getLanguageText('e0063');
                    } // if
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ***************************************************************************
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
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_column';
                $lock_array[] = 'dict_relationship';
                $lock_array[] = 'dict_related_column';
                $lock_array[] = 'dict_table_key';
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
        $database_id = $fieldarray['database_id'];
        $table_id    = $fieldarray['table_id'];

        if (!array_key_exists('audit_logging', $this->lookup_data)) {
            // get arrays to put into LOOKUP_DATA
            $array = $this->getValRep('audit_logging');
            $this->lookup_data['audit_logging'] = $array;
        } // if

        if (!array_key_exists('database_id', $this->lookup_data)) {
            // get contents of foreign table and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('dict_database');
            $array    = $dbobject->getValRep('database_id');
            $this->lookup_data['database_id'] = $array;
        } // if

        if (!array_key_exists('table_id', $this->lookup_data)) {
            if (!empty($fieldarray['database_id'])) {
            	// get contents of foreign table and add as a LOOKUP list
                $dbobject =& RDCsingleton::getInstance('dict_table');
                $array    = $dbobject->getValRep('table_id', "database_id='$database_id'");
                $this->lookup_data['table_id'] = $array;
            } // if
        } // if

        if (!array_key_exists('nameof_start_date', $this->lookup_data)) {
            // get list of column names which could be aliases for start/end date
            $dbobject =& RDCsingleton::getInstance('dict_column');
            $array    = $dbobject->getValRep('column_id', "database_id='$database_id' AND table_id='$table_id'");
            $this->lookup_data['nameof_start_date'] = $array;
            $this->lookup_data['nameof_end_date'] = $array;
        } // if

        $pattern_id = getPatternId();

//        if (preg_match('/^(list1)$/i', $pattern_id)
//        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
//        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('database_id' => 'Database Id',
//                               'table_id' => 'Table Id',
//                               'table_desc' => 'Table Desc');
//                $this->lookup_data['quicksearch_field'] = $array;
//            } // if
//        } elseif (preg_match('/^(popup2)$/i', $pattern_id) AND $this->zone == 'inner') {
//            if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('table_id' => 'Table Id',
//                               'table_desc' => 'Table Desc');
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

        if ($item == 'audit_logging') {
//            // provide values for dropdown list
//            $array['N'] = 'No';
//            $array['Y'] = 'LOGGING ENABLED';
            $array = getLanguageArray('audit_logging');
            return $array;
        } // if

        if ($item == 'table_id') {
            // get data from the database, ignoring any tables which have no entries on DICT_COLUMN
            $this->sql_select     = 'table_id, table_desc';
            //$this->sql_select    .= ', count(dict_column.table_id) as column_count';
            $this->sql_select    .= ', (SELECT COUNT(table_id) FROM dict_column WHERE dict_column.database_id=dict_table.database_id AND dict_column.table_id=dict_table.table_id GROUP BY dict_column.table_id) AS column_count';
            $this->sql_orderby    = 'table_id';
            $this->sql_ordery_seq = 'asc';
            $this->sql_from       = 'dict_table ';
            //                      . 'LEFT JOIN dict_column ON (dict_table.database_id=dict_column.database_id AND dict_table.table_id=dict_column.table_id) ';
            $this->sql_having     = 'column_count > 0';
            $this->sql_groupby    = '';
            $data = $this->getData($where);

            // convert each row into 'id=id' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[0];
            } // foreach
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // customisable code goes here

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['table_id'] = 'Total count:';
        $array['table_desc'] = $this->count;

        return $array;

    } // _cm_ListView_total

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
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {

        if (empty($this->sql_select)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_select  = null;
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
        } // if

        if (!preg_match('/ AS column_count/i', $this->sql_select)) {
        	$this->sql_select .= ', (SELECT COUNT(table_id) FROM dict_column WHERE dict_column.database_id=dict_table.database_id AND dict_column.table_id=dict_table.table_id GROUP BY dict_column.table_id) AS column_count';
        } // if
        if (!preg_match('/ AS rel_count_snr/i', $this->sql_select)) {
            $this->sql_select .= ', (SELECT COUNT(table_id_snr) FROM dict_relationship WHERE dict_relationship.database_id_snr=dict_table.database_id AND dict_relationship.table_id_snr=dict_table.table_id GROUP BY dict_relationship.table_id_snr) AS rel_count_snr';
        } // if
        if (!preg_match('/ AS rel_count_jnr/i', $this->sql_select)) {
            $this->sql_select .= ', (SELECT COUNT(table_id_jnr) FROM dict_relationship WHERE dict_relationship.database_id_jnr=dict_table.database_id AND dict_relationship.table_id_jnr=dict_table.table_id GROUP BY dict_relationship.table_id_jnr) AS rel_count_jnr';
        } // if

        $pattern_id = getPatternId();

        if (preg_match('/^(popup)/i', $pattern_id)) {
            $this->sql_having  = 'column_count > 0';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {
        if (empty($fieldarray['alt_language_table'])) {
        	$fieldarray['alt_language_cols'] = null;
        } else {
            if ($fieldarray['alt_language_table'] == $fieldarray['table_id']) {
            	// "Alternate Language Table must not be the same as this table"
            	$this->errors['alt_language_table'] = getLanguageText('e0050');
            	return $fieldarray;
            } // if

            $database_id  = $fieldarray['database_id'];
            $table_id     = $fieldarray['table_id'];
            $table_id_alt = $fieldarray['alt_language_table'];

            $dbobject =& RDCsingleton::getInstance('dict_table');
            $data = $dbobject->getData("database_id='$database_id' AND table_id='$table_id_alt'");
            if (empty($data)) {
            	// "This table does not exist"
            	$this->errors['alt_language_table'] = getLanguageText('e0051');
            	return $fieldarray;
            } // if

            // obtain primary key of this table
            $this_primary_key = array();
            $dbobject =& RDCsingleton::getInstance('dict_table_key');
            $dbobject->sql_orderby = 'seq_in_index';
            $data = $dbobject->getData("database_id='$database_id' AND table_id='$table_id' AND key_name='PRIMARY'");
            foreach ($data as $rownum => $rowdata) {
            	$this_primary_key[] = $rowdata['column_id'];
            } // foreach

            // obtain primary key of alternate table
            $alt_primary_key = array();
            $dbobject =& RDCsingleton::getInstance('dict_table_key');
            $dbobject->sql_orderby = 'seq_in_index';
            $data = $dbobject->getData("database_id='$database_id' AND table_id='$table_id_alt' AND key_name='PRIMARY'");
            foreach ($data as $rownum => $rowdata) {
            	$alt_primary_key[] = $rowdata['column_id'];
            } // foreach
            if (end($alt_primary_key) != 'language_id') {
            	// "Primary key of alternate language table must end in 'language_id'"
            	$this->errors['alt_language_table'] = getLanguageText('e0052');
            	return $fieldarray;
            } // if

            // compare the two primary keys
            if (count($alt_primary_key) != count($this_primary_key)+1) {
                // "Primary key of language table has wrong number of columns"
            	$this->errors['alt_language_table'] = getLanguageText('e0053');
            	return $fieldarray;
            } // if
            foreach ($this_primary_key as $colnum => $colname) {
            	if ($colname != $alt_primary_key[$colnum]) {
            	    // "Primary keys of the two tables do not match"
            		$this->errors['alt_language_table'] = getLanguageText('e0054');
            		break;
            	} // if
            } // foreach

            $colspecs = $this->_ddl_getColumnSpecs();

            // obtain field list from this table
            $this_fieldarray = array();
            $dbobject =& RDCsingleton::getInstance('dict_column');
            $dbobject->sql_orderby = 'column_seq';
            $data = $dbobject->getData("database_id='$database_id' AND table_id='$table_id'");
            foreach ($data as $rownum => $rowdata) {
                if ($rowdata['auto_insert'] == 'Y' OR $rowdata['auto_update'] == 'Y') {
                	// value inserted automatically, so ignore this entry
                	$x = true;
                } elseif (in_array($rowdata['column_id'], $this_primary_key)) {
                    // part of primary key, so ignore this entry
                    $x = true;
                } else {
                    $col_type = $rowdata['col_type'];
                    if ($colspecs[$col_type]['type'] == 'string') {
                    	$this_fieldarray[] = $rowdata['column_id'];
                    } // if
                } // if
            } // foreach

            // obtain field list from alternate table
            $alt_fieldarray = array();
            $dbobject =& RDCsingleton::getInstance('dict_column');
            $dbobject->sql_orderby = 'column_seq';
            $data = $dbobject->getData("database_id='$database_id' AND table_id='$table_id_alt'");
            foreach ($data as $rownum => $rowdata) {
                if ($rowdata['auto_insert'] == 'Y' OR $rowdata['auto_update'] == 'Y') {
                	// value inserted automatically, so ignore this entry
                	$x = true;
                } elseif (in_array($rowdata['column_id'], $alt_primary_key)) {
                    // part of primary key, so ignore this entry
                    $x = true;
                } elseif (!in_array($rowdata['column_id'], $this_fieldarray)) {
                    // not in this table, so ignore this entry
                    $x = true;
                } else {
                    $col_type = $rowdata['col_type'];
                    if ($colspecs[$col_type]['type'] == 'string') {
                    	$alt_fieldarray[] = $rowdata['column_id'];
                    } // if
                } // if
            } // foreach

            if (empty($alt_fieldarray)) {
            	// "There are no columns which are common in these two tables"
            	$this->errors['alt_language_table'] = getLanguageText('e0055');
            } else {
                $fieldarray['alt_language_cols'] = implode(', ', $alt_fieldarray);
            } // if

        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
