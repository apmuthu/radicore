<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_transition extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_transition ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_transition';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_transition

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get array for after_submit and put into LOOKUP_DATA
        $array = $this->getValRep('transition_trigger');
        $this->lookup_data['transition_trigger'] = $array;

        require_once 'classes/mnu_role.class.inc';
        $dbobject =& singleton::getInstance('mnu_role');
        $role_array = $dbobject->getValRep('role_id');
        $this->lookup_data['role_id'] = $role_array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if (isset($fieldarray['workflow_id'])) {
            // set transition_id to next available number for this workflow_id
            $workflow_id = $fieldarray['workflow_id'];
            $query = "SELECT max(transition_id) FROM $this->tablename WHERE workflow_id='$workflow_id'";
            $count = $this->getCount($query);
            $fieldarray['transition_id'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item, $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'transition_id') {
            // get data from the database
            $this->sql_select     = 'transition_id, transition_name';
            $this->sql_orderby    = 'transition_id';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where);

            $array[''] = ' ';   // start with blank entry

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
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        switch ($popupname) {
            case 'mnu_task(popup)':
                $where = null;
                if ($GLOBALS['mode'] == 'search') {
                    // use input from current screen
                    if (!empty($_POST['start_task_id'])) {
                        $where = "task_id LIKE '{$_POST['start_task_id']}'";
                    } // if
                } // if
                break;
            case 'mnu_role(popup)':
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

        // ensure that only one entry can be selected
        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        global $dbprefix;

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'wf_transition.*, task_desc, role_desc';
            $this->sql_from   = 'wf_transition '
                              . 'LEFT JOIN ' .$dbprefix .'menu.mnu_task ON (mnu_task.task_id=wf_transition.task_id) '
                              . 'LEFT JOIN ' .$dbprefix .'menu.mnu_role ON (mnu_role.role_id=wf_transition.role_id) ';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
