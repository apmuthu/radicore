<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_dataBase extends Default_Table
{
    var $count;         // subsystem count for PDF output
    var $table_count;   // count of tables within all subsystems
    var $rel_count;     // count of relationships within all subsystems

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'dict_database';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] != 'search') {
			// do not replace database id with textual description
		    unset($this->fieldspec['database_id']['control']);
		} // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if (isset($fieldarray['rel_count_snr'])) {
            if ($fieldarray['rel_count_snr'] == 0) {
                $fieldarray['rel_count_snr'] = null;
            } // if
        } // if
        if (isset($fieldarray['rel_count_jnr'])) {
            if ($fieldarray['rel_count_jnr'] == 0) {
                $fieldarray['rel_count_jnr'] = null;
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

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
                $lock_array[] = 'dict_table';
                $lock_array[] = 'dict_table_key';
                $lock_array[] = 'dict_column';
                $lock_array[] = 'dict_relationship';
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
            // get contents of this table and put into lookup data
    		$dbobject = RDCsingleton::getInstance('dict_database');
    		$array = $dbobject->_cm_getValRep('database_id');
    		$this->lookup_data['database_id'] = $array;
        } // if

        if (!array_key_exists('subsys_id', $this->lookup_data)) {
            // get contents of foreign table and put into lookup_data
            $dbobject = RDCsingleton::getInstance('mnu_subsystem');
            $array = $dbobject->getValRep('subsys_id');
            $this->lookup_data['subsys_id'] = $array;
        } // if

        $pattern_id = getPatternId();

//        if (preg_match('/^(list1)$/i', $pattern_id)
//        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
//        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('database_id' => 'Database Id',
//                               'database_name' => 'Database Name',
//                               'subsys_id' => 'Subsys Id');
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

        if ($item == 'database_id') {
            // get data from the database
            $this->sql_select     = 'database_id, database_name';
            $this->sql_orderby    = 'database_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

			// convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[0];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['database_id'] = 'Total count:';
        $array['database_name'] = $this->count;
        $array['table_count']   = $this->table_count;
        $array['rel_count_snr'] = $this->rel_count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count++;
            $this->table_count = $this->table_count + $fieldarray['table_count'];
            $this->rel_count   = $this->rel_count   + $fieldarray['rel_count_snr'];
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {
        // no logging for this 'erase'
        $this->audit_logging = false;

        return $fieldarray;

    } // _cm_pre_eraseRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (array_key_exists('database_id', $where_array)) {
        	if (strlen($where_array['database_id']) == 0) {
        	    // no value was supplied, so allow all existing entries to be read
        		$where = null;
        		// do not cause the lack of a primary key to cause an error
        		$this->checkPrimaryKey = false;
        	} // if
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
        	// do not display long text from option lists for these fields
            unset($this->fieldspec['subsys_id']['optionlist']);
        } // if

        return $filename;

    } // _cm_pre_output

// ****************************************************************************
} // end class
// ****************************************************************************

?>
