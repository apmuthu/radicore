<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_user_role extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname     = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_user_role';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $pattern_id = getPatternId();

        if (preg_match('/^(enq|upd|del|list|add)/i', $pattern_id)) {
            $this->fieldspec['is_external_auth_off']    = array('type' => 'boolean',
                                                                'optionlist' => 'boolean_YN',
                                                                'noedit' => 'y',
                                                                'nondb' => 'y');
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign (parent) tables.
    // $rownum identifies current row number.
    {
        if (empty($fieldarray['start_task_id']) OR empty($fieldarray['is_external_auth_off'])) {
            if (!empty($fieldarray['role_id'])) {
                $dbobject1 = RDCsingleton::getInstance('mnu_role');
                $data1 = $dbobject1->getData("role_id='{$fieldarray['role_id']}'");
                if (!empty($data1)) {
                    $data1 = $data1[0];
                    $fieldarray['start_task_id']        = $data1['start_task_id'];
                    $fieldarray['start_task_name']      = $data1['start_task_name'];
                    $fieldarray['is_external_auth_off'] = $data1['is_external_auth_off'];
                } // if
            } // if
            if (empty($fieldarray['start_task_name']) AND !empty($fieldarray['start_task_id'])) {
                $dbobject2 = RDCsingleton::getInstance('mnu_task');
                $data2 = $dbobject2->getData("task_id='{$fieldarray['start_task_id']}'");
                if (!empty($data2)) {
                    $data2 = $data2[0];
                    $fieldarray['start_task_name'] = $data2['task_name'];
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing prior to insertRecord().
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['user_id'])) {
            $where = "user_id='{$fieldarray['user_id']}'";
            $query = "SELECT MAX(sort_seq) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['sort_seq'] = $count + 1;
        } // if

        if (empty($fieldarray['start_date'])) {
            $fieldarray['start_date'] = getTimeStamp('date');
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array, $return_files)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // $return_files contains a list of all files loaded via a fileupload task.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {
        if ($return_from == 'mnu_role(popup1)') {
            // initialise associated fields
            $fieldarray['role_name']            = null;
            $fieldarray['start_task_id']        = null;
            $fieldarray['start_task_name']      = null;
            $fieldarray['is_external_auth_off'] = null;
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        //if (is_True($fieldarray['is_primary'])) {
        //    // ensure that at least one row has 'primary=TRUE'
        //    $this->_setPrimaryTrue($fieldarray);
        //} // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //if (is_True($fieldarray['is_primary'])) {
        //    // ensure this is the only row with 'primary=TRUE'
        //    $this->_setPrimaryFalse($fieldarray);
        //} else {
        //    // ensure that at least one row has 'primary=TRUE'
        //    $this->_setPrimaryTrue($fieldarray);
        //} // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        if (is_True($this->skip_validation)) {
            // skip the next bit
        } else {
            //if (is_True($fieldarray['is_primary'])) {
            //    // ensure that any other rows have 'primary=FALSE'
            //    $this->_setPrimaryFalse($fieldarray);
            //} else {
            //    // if there are other rows ensure that one of them has 'primary=TRUE'
            //    $this->_setPrimaryTrue($fieldarray);
            //} // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain contents of current record in the parent object.
    {
        //$pattern_id = getPatternId();

        //if (preg_match('/^(list)/i', $pattern_id)) {
            if (empty($this->sql_from)) {
                // construct default SELECT and FROM clauses using parent relations
                $this->sql_from    = null;
                $this->sql_groupby = null;
                $this->sql_having  = null;
                $this->sql_union   = null;
                $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
                // link to MNU_ROLE for START_TASK_ID
                if (!preg_match('/\bstart_task_id\b/i', $this->sql_select)) {
                    $this->sql_select .= ', mnu_role.start_task_id, mnu_task.task_name AS start_task_name';
                    $this->sql_from   .= "\nLEFT JOIN mnu_task ON (mnu_task.task_id=mnu_role.start_task_id)";
                } // if
            } // if
        //} // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateDelete ($rowdata, $parent_table)
    // verify that the selected record can be deleted.
    // ($parent_table is only used in a cascade delete)
    // if anything is placed in $this->errors the delete will be terminated.
    {
        if (is_null($parent_table)) {
            $count = $this->getCount("user_id='{$rowdata['user_id']}'");
            if ($count <= 1) {
                // "Cannot delete a user's only role"
                $this->errors[] = getLanguageText('e0000');
            } // if
        } // if

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _setPrimaryFalse ($fieldarray)
    // current row has 'primary=TRUE', so all others must have 'primary=FALSE'
    {
//        $save_numrows = $this->numrows;

//        $date = getTimeStamp('date');

//        $selection = "user_id='{$fieldarray['user_id']}'"
//                   ." AND role_id != '{$fieldarray['role_id']}'";
//        $replace   = "is_primary='" .$this->fieldspec['is_primary']['false'] ."'";
//        $count = $this->_dml_updateSelection($selection, $replace);

//        $this->numrows = $save_numrows;

        return;

    } // _setPrimaryFalse

    // ****************************************************************************
    function _setPrimaryTrue ($fieldarray)
    // if there are other rows ensure that one of them has 'primary=TRUE'
    {
//        $date = getTimeStamp('date');

//        $where = "user_id='{$fieldarray['user_id']}'";
//        $true = $this->fieldspec['is_primary']['true'];
//        $count = $this->getCount($where ." AND is_primary='$true'");
//        if ($count < 1) {
//            $this->sql_orderby = "created_date asc";
//            $data = $this->getData($where);
//            if (!empty($data)) {
//                $update = $data[0];  // use 1st record only
//                $update['is_primary'] = $true;
//                $this->skip_validation = true;
//                $update = $this->updateRecord($update);
//            } // if
//        } // if

        return;

    } // _setPrimaryTrue

// ****************************************************************************
} // end class
// ****************************************************************************

?>
