<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_task extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_task ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_task';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_task

    // ****************************************************************************
    function checkSelection ($task_id)
    // validate a selection from the menu screen or a navigation button.
    {
        //DebugBreak();
        // obtain security class from logon screen
        $role_id = $_SESSION['role_id'];

        // load options for SQL SELECT statement
        // NOTE that task access is affected by the following:
        // - an entry on mnu_role_task (if no entry exists then access is denied)
        // - mnu_role.global_access (if 'Y' this simulates an entry on mnu_role_task for everything)
        // - mnu_task.is_disabled (if 'Y' then task is temporarily disabled and cannot be used)
        $this->sql_select = 'mnu_task.task_id, task_desc, button_text, task_type, dialog_type_id, script_id, subsys_dir, initial_passthru, selection_fixed, selection_temp, settings, order_by, is_disabled, global_access, keep_data, log_sql_query, screen_refresh, '
                           .'CASE WHEN mnu_role_task.role_id IS NOT NULL THEN 1 ELSE 0 END AS access_allowed';
        $this->sql_from   = 'mnu_task '
                          . 'LEFT JOIN mnu_subsystem '
                          . 'ON (mnu_subsystem.subsys_id=mnu_task.subsys_id) '
                          . 'LEFT JOIN mnu_role_task '
                          . "ON (mnu_role_task.task_id=mnu_task.task_id AND mnu_role_task.role_id='$role_id') "
                          . 'LEFT JOIN mnu_role '
                          . "ON (mnu_role.role_id='$role_id')";
        $this->sql_where  = '';

        $this->errors = array();

        $fieldarray = $this->getData("task_id='$task_id'");
        if ($this->numrows <> 1) {
            $this->errors[] = getLanguageText('sys0030', $task_id); // "Task '$task_id' does not exist.";
            return;
        } else {
            // use data from first row only
            $fieldarray = $fieldarray[0];
            if (is_True($fieldarray['is_disabled'])) {
                $this->errors[] = getLanguageText('sys0031', $task_id); // "Task '$task_id' has been disabled";
                return;
            } // if
            if (!is_True($fieldarray['global_access'])) {
                if (!is_True($fieldarray['access_allowed'])) {
                    $this->errors[] = getLanguageText('sys0032', $task_id); // "Access to task '$task_id' has not been allowed";
                    return;
                } // if
            } // if
        } // if

        if ($fieldarray['task_type'] <> 'MENU') {
            // this script must exist as a file
            $filename = $_SERVER['DOCUMENT_ROOT']
                       .getParentDIR () .'/'
                       .$fieldarray['subsys_dir'] .'/' .$fieldarray['script_id'];
            if (!$fp = @fopen($filename, 'r')) {
                $this->errors[] = getLanguageText('sys0057', $fieldarray['script_id']); // "File '{$fieldarray['script_id']}' does not exist";
                return;
            } // if
            fclose($fp);
        } // if

        return $fieldarray;

    } // checkSelection

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;
        if ($mode == 'search') {
            $prev_script = getPreviousScript();
            switch (basename($prev_script)) {
            	case 'mnu_role_task_link(b).php':
                case 'mnu_nav_button_link.php':
                case 'mnu_menu_link.php':
            		// add an extra field to the field list
                    $this->fieldspec['selected'] = array('type' => 'boolean',
                                                         'true' => 'Y',
                                                         'false' => 'N');
            		break;
            	default:
            		;
            } // switch

            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['task_id']['noedit']);
            //unset($fieldarray['task_id']);
        } // if

        if (isset($fieldarray['task_type'])) {
            if ($fieldarray['task_type'] == 'MENU') {
                // these fields are irrelevant for menus, so turn them off
                $this->fieldspec['dialog_type_id']['noedit']      = 'y';
                $this->fieldspec['script_id']['nodisplay']        = 'y';
                $this->fieldspec['initial_passthru']['nodisplay'] = 'y';
                $this->fieldspec['selection_fixed']['nodisplay']  = 'y';
                $this->fieldspec['selection_temp']['nodisplay']   = 'y';
                $this->fieldspec['settings']['nodisplay']         = 'y';
                $this->fieldspec['order_by']['nodisplay']         = 'y';
                $this->fieldspec['keep_data']['nodisplay']        = 'y';
                $this->fieldspec['log_sql_query']['nodisplay']    = 'y';
                $this->fieldspec['screen_refresh']['nodisplay']   = 'y';
            } else {
                // turn these fields back on
                unset($this->fieldspec['dialog_type_id']['noedit']);
                unset($this->fieldspec['script_id']['nodisplay']);
                unset($this->fieldspec['initial_passthru']['nodisplay']);
                unset($this->fieldspec['selection_fixed']['nodisplay']);
                unset($this->fieldspec['selection_temp']['nodisplay']);
                unset($this->fieldspec['settings']['nodisplay']);
                unset($this->fieldspec['order_by']['nodisplay']);
                unset($this->fieldspec['keep_data']['nodisplay']);
                unset($this->fieldspec['log_sql_query']['nodisplay']);
                unset($this->fieldspec['screen_refresh']['nodisplay']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        switch ($fieldarray['task_type']) {
            case 'MENU':
                // menus always have these values
                $fieldarray['dialog_type_id']   = 'MENU';
                $fieldarray['script_id']        = 'menu.php';
                $fieldarray['initial_passthru'] = null;
                $fieldarray['selection_fixed']  = null;
                $fieldarray['selection_temp']   = null;
                $fieldarray['settings']         = null;
                break;
            case 'PROC':
                // script_id must not include any directory names
                $fieldarray['script_id'] = basename($fieldarray['script_id']);
                break;
            default:
                // "Unknown value in TASK_TYPE"
                $this->errors[] = getLanguageText('e0017', $fieldarray['task_type']);
        } // switch

        if (!empty($fieldarray['initial_passthru'])) {
            if ($fieldarray['initial_passthru'] == $fieldarray['task_id']) {
                // "Cannot passthru to self"
                $this->errors['initial_passthru'] = getLanguageText('e0018');
                return $fieldarray;
            } // if
            $dbobject =& singleton::getInstance('mnu_task');
            $data = $dbobject->getData("task_id='{$fieldarray['initial_passthru']}'");
            if ($dbobject->numrows < 1) {
                // "This task does not exist"
                $this->errors['initial_passthru'] = getLanguageText('e0019', $fieldarray['initial_passthru']);
                return $fieldarray;
            } // if
            if ($data[0]['task_type'] != 'PROC') {
                // "This task must be of type PROC"
                $this->errors['initial_passthru'] = getLanguageText('e0020');
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get array for task_type and put into LOOKUP_DATA
        $array = $this->getValRep('task_type');
        $this->lookup_data['task_type'] = $array;

        // get contents of foreign table DIALOG_TYPE and add as a LOOKUP list
        require_once 'mnu_dialog_type.class.inc';
        $dbobject =& singleton::getInstance('mnu_dialog_type');
        $array = $dbobject->getValRep('dialog_type_id');
        $this->lookup_data['dialog_type_id'] = $array;

        // get contents of foreign table SUBSYSTEM and add as a LOOKUP list
        require_once 'mnu_subsystem.class.inc';
        $dbobject =& singleton::getInstance('mnu_subsystem');
        $array = $dbobject->getValRep('subsys_id');
        $this->lookup_data['subsys_id'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // this field should not appear in the INSERT screen
        $this->fieldspec['is_disabled']['nodisplay'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'task_type') {
            // provide values for dropdown list
//            $array['']     = ' ';   // start with blank entry
//            $array['PROC'] = 'Proc';
//            $array['MENU'] = 'Menu';
            $array = getLanguageArray('task_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        $entry = getEntryPoint($this);
        if (strtolower($entry) != 'getdata') {
            // not initiated via the 'getdata' method, so this section is not required
            return $rowdata;
        } // if

        if (empty($rowdata)) return $rowdata;   // do nothing

        switch (basename($_SERVER['PHP_SELF'])) {
            case 'mnu_task_field_list.php':
            case 'mnu_role_taskfield_multi(a).php':
                if ($rowdata[0]['task_type'] != 'PROC') {
                    // "This function is only valid if TASK_TYPE='PROC'"
                    $this->errors = getLanguageText('e0021');
                } // if
                break;
            default:
                ;
        } // switch

        // switch between MENU or PROC
        $rowdata[0] = $this->_cm_changeConfig($where, $rowdata[0]);

        if (isset($rowdata[0]['task_type']) AND $rowdata[0]['task_type'] == 'MENU') {
            if (isset($rowdata[0]['task_id'])) {
            	// check to see if any menu items exist
                require_once 'mnu_menu.class.inc';
                $dbobject =& singleton::getInstance('mnu_menu');
                $count = $dbobject->getCount("menu_id='{$rowdata[0]['task_id']}'");
                if ($count == 0) {
                    // no menu items exist, so allow type to be changed
                    unset($this->fieldspec['task_type']['noedit']);
                } else {
                    $this->fieldspec['task_type']['noedit'] = 'y';
                } // if
            } // if
        } else {
            unset($this->fieldspec['task_type']['noedit']);
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        if ($fieldarray['task_type'] == 'MENU') {
            // menus always have these values
            $fieldarray['dialog_type_id'] = 'MENU';
            $fieldarray['script_id']      = 'menu.php';
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        // valid characters are numbers, letters, and '_#$()'
        if (ereg('[^0-9a-zA-Z_#$()]', $fieldarray['task_id'], $regs)) {
            $this->errors['task_id'] = getLanguageText('e0022', $regs[0]); // "Contains invalid character ($regs[0])";
        } // if

        return $fieldarray;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
