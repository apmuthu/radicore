<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_workflow extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_workflow ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_workflow';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_workflow

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;
        if ($mode == 'search' or $mode == 'insert') {
            $this->fieldspec['workflow_errors']['nodisplay'] = 'y';
            unset($this->fieldspec['is_valid']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $start_date = $fieldarray['start_date'];
        $end_date   = $fieldarray['end_date'];

        if ($start_date > $end_date) {
            // 'Start Date cannot be later than End Date'
            $this->errors['start_date'] = getLanguageText('e0008');
            // 'End Date cannot be earlier than Start Date'
            $this->errors['end_date']   = getLanguageText('e0009');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // set workflow_id to next available number
        $count = $this->getCount("SELECT max(workflow_id) FROM $this->tablename");
        $fieldarray['workflow_id'] = $count + 1;

        // not allowed to set this field on INSERT
        $this->fieldspec['is_valid']['nodisplay'] = 'y';
        $fieldarray['is_valid'] = 'N';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'workflow_id') {
            // get data from the database
            $this->sql_select     = 'workflow_id, workflow_name';
            $this->sql_orderby    = 'workflow_name';
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
            $fieldarray['start_task_id'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        if (count($rowdata) == 1) {
            if (empty($rowdata[0]['workflow_errors'])) {
                $this->fieldspec['workflow_errors']['nodisplay'] = 'y';
            } else {
                unset($this->fieldspec['workflow_errors']['nodisplay']);
            } // if
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        // create initial entries on PLACE table
        require_once 'wf_place.class.inc';
        $dbobject =& singleton::getInstance('wf_place');

        // create entry for START place
        $place_array[0]['workflow_id'] = $fieldarray['workflow_id'];
        $place_array[0]['place_id']    = 1;
        $place_array[0]['place_name']  = 'START';
        $place_array[0]['place_type']  = '1';

        // create entry for END place
        $place_array[1]['workflow_id'] = $fieldarray['workflow_id'];
        $place_array[1]['place_id']    = 2;
        $place_array[1]['place_name']  = 'END';
        $place_array[1]['place_type']  = '9';

        $place_array = $dbobject->insertArray($place_array);
        if ($dbobject->errors) {
            $this->errors = $dbobject->errors;
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        global $dbprefix;

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'wf_workflow.*, mnu_task.task_desc';
            $this->sql_from   = 'wf_workflow '
                              . 'LEFT JOIN ' .$dbprefix .'menu.mnu_task ON (mnu_task.task_id=wf_workflow.start_task_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
