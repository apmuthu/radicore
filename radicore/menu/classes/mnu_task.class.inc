<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_task extends Default_Table
{
    var $count;         // record count for PDF output

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
        // obtain security class from logon screen
        $role_id = $_SESSION['role_id'];
        $ip_address = $_SERVER['SERVER_ADDR'];

        // load options for SQL SELECT statement
        // NOTE that task access is affected by the following:
        // - an entry on mnu_role_task (if no entry exists then access is denied)
        // - mnu_role.global_access (if 'Y' this simulates an entry on mnu_role_task for everything)
        // - mnu_task.is_disabled (if 'Y' then task is temporarily disabled and cannot be used)
        $this->sql_select = 'mnu_task.task_id, task_desc, button_text, task_type, pattern_id, script_id, subsys_dir, initial_passthru, selection_fixed, selection_temp, settings, order_by, is_disabled, global_access, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time'
                           .", CASE WHEN mnu_role_task.role_id IS NOT NULL THEN 'Y' ELSE 'N' END AS access_allowed";
        // - check that IP address is valid
        $this->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE task_id='$task_id') = 0 THEN true"
                                  ." WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE task_id='$task_id' AND ip_address='$ip_address') = 1 THEN true"
                                  ." ELSE false"
                             ." END AS ip_address_valid";
        $this->sql_from   = 'mnu_task'
                         . ' LEFT JOIN mnu_subsystem ON (mnu_subsystem.subsys_id=mnu_task.subsys_id)'
                         . " LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_task.task_id AND mnu_role_task.role_id='$role_id')"
                         . " LEFT JOIN mnu_role ON (mnu_role.role_id='$role_id')";
        $this->sql_where  = '';

        $this->errors = array();

        $fieldarray = $this->getData_raw("mnu_task.task_id='" .addslashes($task_id) ."'");
        if ($this->numrows <> 1) {
            // "Task '$task_id' does not exist."
            $this->errors[] = getLanguageText('sys0030', $task_id);
            return;
        } else {
            // use data from first row only
            $fieldarray = $fieldarray[0];
            if (is_True($fieldarray['is_disabled'])) {
                // "Task '$task_id' has been disabled"
                $this->errors[] = getLanguageText('sys0031', $task_id);
                return;
            } // if
            if (!is_True($fieldarray['global_access'])) {
                if (!is_True($fieldarray['access_allowed'])) {
                    // "Access to task '$task_id' has not been allowed"
                    $this->errors[] = getLanguageText('sys0032', $task_id);
                    return;
                } // if
            } // if
            if (!is_True($fieldarray['ip_address_valid'])) {
                // 'This IP address is not valid'
            	$this->errors[] = getLanguageText('sys0201', $ip_address);
                return;
            } // if
        } // if

        if (preg_match('/PROC/i', $fieldarray['task_type'])) {
            // this script must exist as a file
            if (!empty($_SERVER['HTTPS'])) {
                // use one or the other of these, whichever is available
                if (!empty($_SERVER['PATH_TRANSLATED']) AND strlen($_SERVER['PATH_TRANSLATED']) > strlen($_SERVER['SCRIPT_FILENAME'])) {
                	$dir = getParentDIR($_SERVER['PATH_TRANSLATED']);
                } else {
                    $dir = getParentDIR($_SERVER['SCRIPT_FILENAME']);
                } // if
                $filename = $dir .'/' .$fieldarray['subsys_dir'] .'/' .$fieldarray['script_id'];
            } else {
                $dir = getParentDIR();
                $filename = $_SERVER['DOCUMENT_ROOT'] .$dir .'/' .$fieldarray['subsys_dir'] .'/' .$fieldarray['script_id'];
            } // if

            if (!$fp = @fopen($filename, 'r')) {
                // "File '{$fieldarray['script_id']}' does not exist"
                $this->errors[] = getLanguageText('sys0057', $fieldarray['script_id']);
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
        if ($GLOBALS['mode'] == 'search') {
            // make this a text box for the search screen
            unset($this->fieldspec['initial_passthru']['control']);

            $prev_script = getPreviousScript();
            $pattern_id  = getPatternId($prev_script);
            if ($pattern_id == 'LINK1') {
                // add an extra field to the field list
                $this->fieldspec['selected'] = array('type' => 'boolean');
            } // if

            switch (basename($prev_script)) {
            	case 'mnu_role_task_link(b).php':
            	    break;
                case 'mnu_nav_button_link.php':
                    break;
                case 'mnu_menu_link.php':
            		// turn off 'noedit' attribute for search screen
                    unset($this->fieldspec['task_id']['noedit']);
                    unset($fieldarray['task_id']);
            		break;
            	default:
            		;
            } // switch

        } // if

        if (isset($fieldarray['task_type'])) {
            if (strtoupper($fieldarray['task_type']) == 'MENU') {
                // these fields are irrelevant for menus, so turn them off
                $this->fieldspec['pattern_id']['noedit']          = 'y';
                $this->fieldspec['script_id']['nodisplay']        = 'y';
                $this->fieldspec['initial_passthru']['nodisplay'] = 'y';
                $this->fieldspec['selection_fixed']['nodisplay']  = 'y';
                $this->fieldspec['selection_temp']['nodisplay']   = 'y';
                $this->fieldspec['settings']['nodisplay']         = 'y';
                $this->fieldspec['order_by']['nodisplay']         = 'y';
                $this->fieldspec['keep_data']['nodisplay']        = 'y';
                $this->fieldspec['log_sql_query']['nodisplay']    = 'y';
                $this->fieldspec['screen_refresh']['nodisplay']   = 'y';
                $this->fieldspec['use_https']['nodisplay']        = 'y';
            } else {
                // turn these fields back on
                unset($this->fieldspec['pattern_id']['noedit']);
                unset($this->fieldspec['script_id']['nodisplay']);
                unset($this->fieldspec['initial_passthru']['nodisplay']);
                unset($this->fieldspec['selection_fixed']['nodisplay']);
                unset($this->fieldspec['selection_temp']['nodisplay']);
                unset($this->fieldspec['settings']['nodisplay']);
                unset($this->fieldspec['order_by']['nodisplay']);
                unset($this->fieldspec['keep_data']['nodisplay']);
                unset($this->fieldspec['log_sql_query']['nodisplay']);
                unset($this->fieldspec['screen_refresh']['nodisplay']);
                unset($this->fieldspec['use_https']['nodisplay']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        switch (strtoupper($fieldarray['task_type'])) {
            case 'MENU':
                // menus always have these values
                $fieldarray['pattern_id']       = 'MENU';
                $fieldarray['script_id']        = 'menu.php';
                $fieldarray['initial_passthru'] = null;
                $fieldarray['selection_fixed']  = null;
                $fieldarray['selection_temp']   = null;
                $fieldarray['settings']         = null;
                $fieldarray['use_https']        = null;
                break;
            case 'PROC':
                // script_id must not include any directory names
                $fieldarray['script_id'] = basename($fieldarray['script_id']);
                break;
            default:
                // "Unknown value in TASK_TYPE"
                $this->errors[] = getLanguageText('e0017', $fieldarray['task_type']);
                break;
        } // switch

        switch (strtoupper($fieldarray['pattern_id'])) {
            case 'BATCH':
                // these fields are not allowed
                $fieldarray['initial_passthru']   = null;
                $fieldarray['use_https']          = null;
                $fieldarray['keep_data']          = null;
                $fieldarray['screen_refresh']     = null;
                $fieldarray['max_execution_time'] = null;
                $fieldarray['order_by']           = null;
                $fieldarray['selection_fixed']    = null;
                $fieldarray['selection_temp']     = null;
                break;
            default:
                break;
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
            if (strtoupper($data[0]['task_type']) != 'PROC') {
                // "This task must be of type PROC"
                $this->errors['initial_passthru'] = getLanguageText('e0020');
                return $fieldarray;
            } // if
        } // if

        // remove leading/trailing spaces, and replace embedded spaces with underscores
        $fieldarray['task_id'] = str_replace(' ', '_', trim($fieldarray['task_id']));
        if (isset($fieldarray['new_task_id'])) {
            // do the same for the new task_id on the 'rename' screen
        	$fieldarray['new_task_id'] = str_replace(' ', '_', trim($fieldarray['new_task_id']));
        } // if

        if (is_True($fieldarray['keep_data'])) {
        	if (!preg_match('/(list1|popup1|tree1)/i', $fieldarray['pattern_id'])) {
        	    // 'This setting is not valid for this pattern'
        		$this->errors['keep_data'] = getLanguageText('e0055');
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
        if (!array_key_exists('task_type', $this->lookup_data)) {
            // get array for task_type and put into LOOKUP_DATA
            $array = $this->getValRep('task_type');
            $this->lookup_data['task_type'] = $array;
        } // if

        if (!array_key_exists('pattern_id', $this->lookup_data)) {
            // get contents of foreign table PATTERN and add as a LOOKUP list
            $dbobject =& singleton::getInstance('mnu_pattern');
            $array = $dbobject->getValRep('pattern_id');
            $this->lookup_data['pattern_id'] = $array;
        } // if

        if (!array_key_exists('subsys_id', $this->lookup_data)) {
            // get contents of foreign table SUBSYSTEM and add as a LOOKUP list
            $dbobject =& singleton::getInstance('mnu_subsystem');
            $array = $dbobject->getValRep('subsys_id');
            $this->lookup_data['subsys_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // this field should not appear in the INSERT screen
        $this->fieldspec['is_disabled']['nodisplay'] = 'y';

        if ($fieldarray['task_type'] == 'MENU') {
        	$fieldarray['pattern_id'] = 'MENU';
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'task_type') {
//            // provide values for dropdown list
//            $array['PROC'] = 'Proc';
//            $array['MENU'] = 'Menu';
            $array = getLanguageArray('task_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['task_id'] = 'Total count:';
        $array['task_desc'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        if (strtoupper($fieldarray['task_type']) != 'MENU') {
            return false;
        } // if

        switch ($name) {
        	case 'multi1':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi2':
                // retrieve associated data from MNU_MENU table
                $object =& singleton::getInstance('mnu_menu');
                $menu_id  = $fieldarray['task_id'];
                $object->sql_orderby = 'sort_seq asc';
                $outarray = $object->getData("menu_id='$menu_id'");
                if (empty($outarray)) {
                    // print an empty line
                    $outarray[] = array('dummy' => '');
                } // if

        		break;

        	case 'multi3':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi4':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi5':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi6':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi7':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi8':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi9':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	default:
        		break;
        } // switch

        if ($outarray) {
        	return $outarray;
        } else {
            return false;
        } // if

    } // _cm_output_multi

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
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        $entry = getEntryPoint($this);
        if (strtolower($entry) != 'getdata') {
            // not initiated via the 'getdata' method, so this section is not required
            return $rowdata;
        } // if

        if (empty($rowdata)) return $rowdata;   // do nothing

        switch (basename($_SERVER['PHP_SELF'])) {
            case 'mnu_task_field_list.php':
            case 'mnu_role_taskfield_multi(a).php':
                if (strtoupper($rowdata[0]['task_type']) != 'PROC') {
                    // "This function is only valid if TASK_TYPE='PROC'"
                    $this->errors = getLanguageText('e0021');
                } // if
                break;
            default:
                ;
        } // switch

        // switch between MENU or PROC
        $rowdata[0] = $this->_cm_changeConfig($where, $rowdata[0]);

        if (isset($rowdata[0]['task_type']) AND strtoupper($rowdata[0]['task_type']) == 'MENU') {
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
        if (strtoupper($fieldarray['task_type']) == 'MENU') {
            // menus always have these values
            $fieldarray['pattern_id'] = 'MENU';
            $fieldarray['script_id']  = 'menu.php';
        } // if

        if (strlen($fieldarray['task_desc']) > $this->fieldspec['task_desc']['size']) {
            // automatically truncate data (may come from data dictionary)
        	$fieldarray['task_desc'] = substr($fieldarray['task_desc'], 0, $this->fieldspec['task_desc']['size']);
        } // if

        if (strlen($fieldarray['button_text']) > $this->fieldspec['button_text']['size']) {
            // automatically truncate data (may come from data dictionary)
        	$fieldarray['button_text'] = substr($fieldarray['button_text'], 0, $this->fieldspec['button_text']['size']);
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
        	// do not display long text from option lists for these fields
            unset($this->fieldspec['subsys_id']['optionlist']);
            unset($this->fieldspec['pattern_id']['optionlist']);
        } // if

        return $filename;

    } // _cm_pre_output

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        // valid characters are numbers, letters, and '-_#$()'
        if (preg_match('/[^0-9a-zA-Z-_#$()]/', $fieldarray['task_id'], $regs)) {
            // "Contains invalid character ($regs[0])"
            $this->errors['task_id'] = getLanguageText('e0022', $regs[0]);
        } // if

        return $fieldarray;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
