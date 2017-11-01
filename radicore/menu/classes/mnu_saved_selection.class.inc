<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_saved_selection extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_saved_selection';

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

        if (preg_match('/upd/i', $pattern_id)) {
            $this->fieldspec['user_id']['noedit'] = 'y';
            $this->fieldspec['task_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        if ($this->zone = 'inner' AND !empty($where)) {
            $where_array = where2array($where);
            // save this for use in the getData() method
            $this->sql_search_orig = array2where($where_array, array('task_id'));
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function saveSelection ($rows, $description, $user_id=null, $task_id=null)
    // save this selection in the database
    {
        if (empty($user_id)) {
            $user_id = $_SESSION['logon_user_id'];
        } // if
        if (empty($task_id)) {
            $task_id = $GLOBALS['task_id'];
        } // if
        if (empty($description)) {
            if (!empty($selection['rdc_selection_desc'])) {
                $description = $selection['rdc_selection_desc'];
            } else {
                $description = getTimeStamp();
            } // if
        } // if

        // create the header record on this table
        $new['user_id']        = $user_id;
        $new['task_id']        = $task_id;
        $new['selection_name'] = $description;
        $new = $this->insertRecord($new);
        if ($this->errors) {
            return false;
        } // if

        // "1 records were inserted into XXX"
        $this->messages[] = getLanguageText('sys0005', 1, strtoupper($this->tablename));

        // dump the selection data into the child table
        $dbobject = RDCsingleton::getInstance('mnu_saved_selection_data');
        $dbobject->audit_logging = false;  // do not log initial insert
        foreach ($rows as $rownum => $rowdata) {
            $add['selection_id'] = $new['selection_id'];
            $add['fieldname']    = $rowdata['fieldname'];
            $add['fieldvalue']   = $rowdata['selected'];
            $add['sort_seq']     = $rowdata['sort_seq'];
            $add['output_name']  = $rowdata['output_name'];
            $result = $dbobject->insertRecord($add);
            if ($dbobject->errors) {
                $this->errors[$dbobject->getClassName()] = $dbobject->errors;
                return false;
            } // if
        } // foreach

        // "N records were inserted into XXX"
        $this->messages[] = getLanguageText('sys0005', count($rows), strtoupper($dbobject->tablename));

        return $new['selection_id'];

    } // saveSelection

    // ****************************************************************************
    function updateSelection ($selection_id, $rows, $description, $user_id=null, $task_id=null)
    // save this selection in the database
    {
        if (empty($user_id)) {
            $user_id = $_SESSION['logon_user_id'];
        } // if
        if (empty($task_id)) {
            $task_id = $GLOBALS['task_id'];
        } // if
        if (empty($description)) {
            if (!empty($selection['rdc_selection_desc'])) {
                $description = $selection['rdc_selection_desc'];
            } else {
                $description = getTimeStamp();
            } // if
        } // if

        // update the header record on this table
        $upd['selection_id']   = $selection_id;
        $upd['user_id']        = $user_id;
        $upd['task_id']        = $task_id;
        $upd['selection_name'] = $description;
        $upd = $this->updateRecord($upd);
        if ($this->errors) {
            return false;
        } // if

        // "1 records were updated in XXX"
        $this->messages[] = getLanguageText('sys0006', 1, strtoupper($this->tablename));

        // transfer updated data to the database
        $dbobject = RDCsingleton::getInstance('mnu_saved_selection_data');

        $insert_count = 0;
        $update_count = 0;
        foreach ($rows as $rownum => $rowdata) {
            $rowdata['selection_id'] = $selection_id;
            $rowdata['fieldvalue']   = $rowdata['selected'];
            $rowdata = $dbobject->insertOrUpdate($rowdata);
            if ($dbobject->errors) {
                $this->errors[$dbobject->getClassName()] = $dbobject->errors;
                return false;
            } // if
            $insert_count = $insert_count + $dbobject->insert_count;
            $update_count = $update_count + $dbobject->update_count;
        } // foreach

        // "N records inserted, N records updated in XXX""
        $this->messages[] = getLanguageText('sys0098', $insert_count, $update_count, strtoupper($dbobject->tablename));

        return true;

    } // updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
