<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_role extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_role ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_role';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_role

    // ****************************************************************************
    function getRole ()
    // return the role details for the current user.
    {
        $this->errors = array();

        if (!isset($_SESSION['role_id'])) {
            // not found, so assume user has global access
            $array = array('role_id' => 'GLOBAL', 'global_access' => true);
        } elseif (isset($_SESSION['global_access'])) {
            $array['role_id']       = $_SESSION['role_id'];
            $array['global_access'] = $_SESSION['global_access'];
        } else {
            // look for security class from logon screen
            $role_id = $_SESSION['role_id'];
            $this->sql_select = 'role_id,global_access';
            $role_data = $this->getData_raw("role_id='$role_id'");
            if ($this->errors) {
                return FALSE;
            } // if
            if ($this->numrows <> 1) {
                // 'Role does not exist';
                $this->errors[] = getLanguageText('sys0013');
                return FALSE;
            } // if
            $array = $role_data[0];
            if (is_true($array['global_access'])) {
                $array['global_access'] = TRUE;
            } else {
                $array['global_access'] = FALSE;
            } // if
            $_SESSION['global_access'] = $array['global_access'];
        } // if

       return $array;

    } // getRole

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;

        if ($mode == 'search') {
            $prev_script = getPreviousScript();
            $pattern_id  = getPatternId($prev_script);
            //if (basename($prev_script) == 'mnu_role_task_link(a).php') {
            if ($pattern_id == 'LINK1') {
                // add an extra field to the field list
                $this->fieldspec['selected'] = array('type' => 'boolean');
            } // if
            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['role_id']['noedit']);
            unset($fieldarray['role_id']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (isset($fieldarray['start_task_id'])) {
            //require_once 'classes/mnu_task.class.inc';
            $dbobject =& singleton::getInstance('mnu_task');
            $dbobject->sql_select = 'task_type';
            $foreign_data = $dbobject->getData("task_id='{$fieldarray['start_task_id']}'");
            if ($foreign_data[0]['task_type'] != 'MENU') {
                // "start_task_id must be of type MENU"
                $this->errors['start_task_id'] = getLanguageText('e0014');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'role_id') {
            // get data from the database
            $this->sql_select     = 'role_id, role_desc';
            $this->sql_orderby    = 'role_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
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

        $array['role_id'] = 'Total count:';
        $array['role_desc'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        switch ($popupname) {
            case 'mnu_task(popup1)':
            case 'mnu_task(popup1)b':
                $where = null;
                if ($GLOBALS['mode'] == 'search') {
                    // use input from current screen
                    if (!empty($_POST['start_task_id'])) {
                        $where = "task_id LIKE '{$_POST['start_task_id']}'";
                    } // if
                } // if
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
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array)
    /// process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {

//        if (isset($select_array['task_id'])) {
//            // change 'task_id' to 'start_task_id'
//            $fieldarray['start_task_id'] = $select_array['task_id'];
//            unset($select_array['task_id']);
//        } // if

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
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        // add standard entries to MNU_ROLE_TASK
        $role_id = $rowdata['role_id'];
        $access[] = array('role_id' => $role_id, 'task_id' => 'menu');
        $access[] = array('role_id' => $role_id, 'task_id' => 'mnu_user(upd1)a');
        $access[] = array('role_id' => $role_id, 'task_id' => 'mnu_user(upd1)b');
        $access[] = array('role_id' => $role_id, 'task_id' => 'mnu_user(upd1)c');

        $dbobject =& singleton::getInstance('mnu_role_task');
        $access = $dbobject->insertMultiple($access);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->errors);
        } // if

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // only do this if sql_select is empty
//        if (empty($this->sql_select)) {
//            // include columns from foreign table
//            $this->sql_select = 'mnu_role.*, mnu_task.task_id AS start_task_id, mnu_task.task_desc as start_task_desc';
//            $this->sql_from   = 'mnu_role '
//                              . 'LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_role.start_task_id)';
//        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
