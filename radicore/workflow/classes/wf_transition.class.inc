<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_transition extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_transition';

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
        if ($GLOBALS['mode'] == 'search') {
            $this->fieldspec['task_id']['allow_input'] = 'y';
            $this->fieldspec['task_id']['foreign_field'] = 'task_id';
            unset($this->fieldspec['workflow_name']['noedit']);
            unset($this->fieldspec['transition_trigger']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['transition_trigger'] == 'TIME') {
        	if ($fieldarray['time_limit'] < 1) {
        	    // "Cannot be blank if Trigger = 'TIME'"
        		$this->errors['time_limit'] = getLanguageText('e0058');
        	} // if
        } // if

        if ($fieldarray['time_limit'] > 0) {
            if ($fieldarray['transition_trigger'] != 'TIME') {
                // Must be blank if Trigger not = 'TIME'
                $this->errors['time_limit'] = getLanguageText('e0059');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if (!empty($fieldarray['time_limit'])) {
        	// convert from minutes to hours and minutes
        	$hours   = floor($fieldarray['time_limit'] / 60);
        	$minutes = $fieldarray['time_limit'] % 60;
        	if (strlen($minutes) < 2) {
        		$minutes = '0'.$minutes;
        	} // if
        	$fieldarray['time_limit'] = $hours.':'.$minutes;
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('transition_trigger', $this->lookup_data)) {
            // get array for after_submit and put into LOOKUP_DATA
            $array = $this->getValRep('transition_trigger');
            $this->lookup_data['transition_trigger'] = $array;
        } // if

        if (!array_key_exists('role_id', $this->lookup_data)) {
            $dbobject = RDCsingleton::getInstance('mnu_role');
            $role_array = $dbobject->getValRep('role_id');
            $this->lookup_data['role_id'] = $role_array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['workflow_id']) AND empty($fieldarray['transition_id'])) {
            // set transition_id to next available number for this workflow_id
            $workflow_id = $fieldarray['workflow_id'];
            $query = "SELECT max(transition_id) FROM $this->tablename WHERE workflow_id='$workflow_id'";
            $count = $this->getCount($query);
            $fieldarray['transition_id'] = $count + 1;
            $retry_on_duplicate_key = 'transition_id';
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'transition_id') {
            // get data from the database
            $this->sql_select     = 'transition_id, transition_name';
            $this->sql_orderby    = 'transition_id';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData_raw($where);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach
            return $array;
        } // if

        if ($item == 'transition_trigger') {
//            $array['']     = ' ';   // start with blank entry
//            $array['USER'] = 'User (manual)';
//            $array['AUTO'] = 'Automatic';
//            $array['MSG']  = 'Message';
//            $array['TIME'] = 'Time';
            $array = getLanguageArray('transition_trigger');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        switch ($popupname) {
            case 'mnu_task(popup1)a':
                $where = null;
                if ($GLOBALS['mode'] == 'search') {
                    // use input from current screen
                    if (!empty($_POST['start_task_id'])) {
                        $where = "task_id LIKE '{$_POST['start_task_id']}'";
                    } elseif (!empty($fieldarray['task_id'])) {
                        $where = "task_id LIKE '{$fieldarray['task_id']}'";
                    } // if
                } // if
                break;
            case 'mnu_role(popup1)':
                $where = null;
                if ($GLOBALS['mode'] == 'search') {
                    // use input from current screen
                    if (!empty($_POST['role_id'])) {
                        $where = "role_id LIKE '{$_POST['role_id']}'";
                    } // if
                } // if
                break;
            default:
                ;
        } // switch

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        foreach ($rows as $rownum => $rowdata) {
            if (isset($rowdata['task_id']) AND $rowdata['task_id'] == '.') {
                $rowdata['task_id'] = null;  // remove dummy entry
                $rows[$rownum] = $rowdata;
            } // if
        } // foreach

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record has been inserted.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array).
    // $parent_data may contain contents of current record in the parent object.
    {
        // find out if tables in the 'menu' database need to be qualified
        $menuDB = findDBName('menu', $this->dbname);

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'wf_transition.*, mnu_task.task_desc, mnu_role.role_desc';
            $this->sql_from   = 'wf_transition '
                              . "LEFT JOIN {$menuDB}mnu_task ON (mnu_task.task_id=wf_transition.task_id) "
                              . "LEFT JOIN {$menuDB}mnu_role ON (mnu_role.role_id=wf_transition.role_id) ";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive
        //$this->row_locks_supp = '?' // DBMS-specific

        // reuse existing SELECT statement in _dml_ReadBeforeUpdate() method
        //$this->reuse_previous_select = true;

        if (!empty($rowdata['time_limit'])) {
        	if (preg_match('/([0-9]{1,3}):[0-9]{2}/', $rowdata['time_limit'], $regs)) {
        	    // convert from hours and minutes to minutes
                preg_match('/[0-9]{1,9}(?=:)/', $rowdata['time_limit'], $regs);
                $hours = $regs[0];
                if ($hours > 999) {
                    // "Cannot specify more than 999 hours"
                	$this->errors['time_limit'] = getLanguageText('e0072');
                	$hours = 999;
                } // if
                preg_match('/(?<=:)[0-9]{2}/', $rowdata['time_limit'], $regs);
                $minutes = $regs[0];
                if ($minutes > 59) {
                    // "Cannot specify more than 59 minutes"
                	$this->errors['time_limit'] = getLanguageText('e0073');
                	$minutes = 59;
                } // if
                $rowdata['time_limit'] = ($hours * 60) + $minutes;
        	} else {
        	    // "Must be in format HHH:MM"
        	    $this->errors['time_limit'] = getLanguageText('e0071');
        	} //
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

    // ***************************************************************************
    function _updateWorkflow ($workflow_id)
    // set IS_VALID to FALSE to force workflow to be revalidated.
    {
        $dbobject = RDCsingleton::getInstance('wf_workflow');
        $update['workflow_id'] = $workflow_id;
        $update['is_valid']    = FALSE;
        $update = $dbobject->updateRecord($update);
        if ($dbobject->errors) {
            $this->errors[$dbobject->getClassName()] = $dbobject->errors;
            return false;
        } // if

        return true;

    } // _updateWorkflow

// ****************************************************************************
} // end class
// ****************************************************************************

?>
