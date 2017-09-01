<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_table.class.inc';
class dict_table_s03 extends dict_table
{
    // ****************************************************************************
    // this class is used by script: table_generate_a.php
    // to display the list of available transaction patterns
    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this is used to capture the value which is passed on to the child script
        $this->fieldspec['pattern_id']      = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'pattern_id');

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // create array of patterns that can be selected
        $include_array[] = 'add4';
        $include_array[] = 'add5';
        $include_array[] = 'del3';
        $include_array[] = 'del4';
        $include_array[] = 'batch';
        $include_array[] = 'erase1';
        $include_array[] = 'filedownload';
        $include_array[] = 'filedownload2';
        $include_array[] = 'filepicker';
        $include_array[] = 'filepicker2';
        $include_array[] = 'fileupload';
        $include_array[] = 'link1';
        $include_array[] = 'list1';
        $include_array[] = 'list2';
        $include_array[] = 'list3';
        $include_array[] = 'multi1';
        $include_array[] = 'multi2';
        $include_array[] = 'multi3';
        $include_array[] = 'multi4';
        $include_array[] = 'multi5';
        $include_array[] = 'multi6';
        $include_array[] = 'output1';
        $include_array[] = 'output2';
        $include_array[] = 'output3';
        $include_array[] = 'output4';
        $include_array[] = 'output5';
        $include_array[] = 'output6';
        $include_array[] = 'popup1';
        $include_array[] = 'popup2';
        $include_array[] = 'popup3';
        $include_array[] = 'popup4';
        $include_array[] = 'timetable1';
        $include_array[] = 'tree1';
        $include_array[] = 'tree2';
        $include_array[] = 'upd2';
        $include_array[] = 'upd3';
        $include_array[] = 'upd4';
        $include_array[] = 'upd5';
        $select_list = '';
        foreach ($include_array as $item) {
        	if (empty($select_list)) {
        		$select_list = "'$item'";
        	} else {
        	    $select_list .= ", '$item'";
        	} // if
        } // foreach
        $select_list = strtoupper($select_list);

        if (!array_key_exists('pattern_id', $this->lookup_data)) {
            // get contents of foreign table and add as a LOOKUP list
            $dbobject = RDCsingleton::getInstance('mnu_pattern');
            $array    = $dbobject->getValRep('pattern_id', "pattern_id IN ($select_list)");
            $this->lookup_data['pattern_id'] = $array;
        } // if

		return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if (!empty($where)) {
            // reduce multiple selections to a single selection
            $rows = splitWhereByRow($where);
            $where = $rows[0];
        } // if

        unset($GLOBALS['act_buttons']['submitBtn']);

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        foreach ($rows as $rownum => $rowdata) {
            // insert non-database field
        	$rows[$rownum]['pattern_id'] = '';
        } // foreach

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        $database_id = $fieldarray['database_id'];
        $table_id    = $fieldarray['table_id'];
        $pattern_id  = $fieldarray['pattern_id'];

        // jump to next task when this one finishes
        $next['task_id']   = 'dict_table(generate)b';
        $next['where']     = "database_id='$database_id' AND table_id='$table_id' AND pattern_id='$pattern_id'";
        $next['immediate'] = true;
        append2ScriptSequence($next);

        return $fieldarray;

    } // _cm_post_updateRecord

    // ***************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // find out if tables in the 'menu' database need to be qualified
        $menuDB = findDBName('menu', $this->dbname);

        if (empty($this->sql_from)) {
        	$this->sql_select = 'dict_table.database_id, dict_table.table_id, dict_database.subsys_id, mnu_subsystem.subsys_dir';
        	$this->sql_from   = 'dict_table '
        	                  . 'LEFT JOIN dict_database ON (dict_database.database_id=dict_table.database_id) '
        	                  . "LEFT JOIN {$menuDB}mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) ";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    // if anything is placed in $this->errors the update will be terminated.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
