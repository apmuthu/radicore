<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_role extends Default_Table
{
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
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;

        if ($mode == 'search') {
            $prev_script = getPreviousScript();
            if (basename($prev_script) == 'mnu_role_task_link(a).php') {
                // add an extra field to the field list
                $this->fieldspec['selected'] = array('type' => 'boolean',
                                                     'true' => 'Y',
                                                     'false' => 'N');
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
            require_once 'mnu_task.class.inc';
            $dbobject =& singleton::getInstance('mnu_task');
            $dbobject->sql_select = 'task_type';
            $foreign_data = $dbobject->getData("task_id='{$fieldarray['start_task_id']}'");
            if ($foreign_data[0]['task_type'] != 'MENU') {
                $this->errors['start_task_id'] = getLanguageText('e0014'); // "start_task_id must be of type MENU";
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'role_id') {
            // get data from the database
            $this->sql_select     = 'role_id, role_desc';
            $this->sql_orderby    = 'role_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            $array[''] = ' ';   // start with blank entry

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
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        switch ($popupname) {
            case 'mnu_task(popup)':
            case 'mnu_task(popup)b':
                $where = null;
                if ($GLOBALS['mode'] == 'search') {
                    // use input from current screen
                    if (!empty($_POST['start_task_id'])) {
                        $where = "task_id LIKE '{$_POST['start_task_id']}'";
                    } // if
                } // if
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

        if (isset($fieldarray['task_id'])) {
            // change 'task_id' to 'start_task_id'
            $fieldarray['start_task_id'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'mnu_role.*, mnu_task.task_id AS start_task_id, mnu_task.task_desc';
            $this->sql_from   = 'mnu_role '
                              . 'LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_role.start_task_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
