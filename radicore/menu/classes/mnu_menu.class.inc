<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_menu extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_menu ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'mnu_menu';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_menu

    // ****************************************************************************
    function getMenuButtons ($task_id)
    // return current menu buttons as an array.
    {
        // first we must obtain the user's current security setting
        $dbrole =& RDCsingleton::getInstance('mnu_role');
        $dbrole_data = $dbrole->getRole();
        if ($dbrole->errors) {
            $this->errors = $dbrole->errors;
            return FALSE;
        } // if

        $role_id       = $dbrole_data['role_id'];
        $role_list     = $dbrole_data['role_list'];
        $global_access = $dbrole_data['global_access'];

        // identify extra parameters for a JOIN, as follows:-
        // MNU_MENU identifies list of tasks which are attached to the current menu,
        // MNU_ROLE_TASK identifies which taks the members of the current role may access,
        // (this is ignored if GLOBAL_ACCESS is TRUE).
        // MNU_TASK holds task descriptions, and whether a particular task has ben disabled
        // (in which case it must also be removed from he selection)

        $having_array = array();

        $this->sql_select = 'mnu_task.task_id, mnu_task.task_desc, mnu_menu.button_text, mnu_menu.sort_seq'
                          .", CASE WHEN EXISTS(SELECT 1 FROM mnu_role_task WHERE task_id=mnu_task.task_id AND role_id IN($role_list) ) THEN 'Y' ELSE 'N' END AS access_allowed";
        $this->sql_from   = 'mnu_menu '
                          .' LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_menu.task_id_jnr)';
        if (!is_True($global_access)) {
           $having_array['access_allowed'] = 'Y';
        } // if

        if (!empty($_SESSION['empty_tables']) AND array_key_exists('mnu_task_ip_address', $_SESSION['empty_tables'])) {
            // table is empty, so no lookup is required
        } else {
            // lookup on MNU_TASK_IP_ADDRESS to see if this IP address is valid
            $ip_address = getRealIPAddress();
            $this->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE mnu_task_ip_address.task_id=mnu_menu.task_id_jnr) = 0 THEN 'Y'"
                                      ." WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE mnu_task_ip_address.task_id=mnu_menu.task_id_jnr AND ip_address='$ip_address') = 1 THEN 'Y'"
                                      ." ELSE 'N'"
                                 ." END AS ip_address_valid";
            //$this->sql_having = "ip_address_valid='Y'";
            $having_array['ip_address_valid'] = 'Y';
        } // if
        $this->sql_having = array2where($having_array);

        $where = "menu_id='$task_id' AND (mnu_task.is_disabled='N')";

        $dbmenu_data = $this->getData_raw($where);

        $menu_buttons = array();
        foreach ($dbmenu_data as $data) {
            $menu_buttons[$data['task_id']] = $data['button_text'];
        } // foreach

        return $menu_buttons;

    } // getMenuBttons

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        if ($fieldarray['menu_id'] == $fieldarray['task_id_jnr']) {
            $this->errors[] = getLanguageText('e0011'); // 'Cannot add a menu to itself';
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['menu_id'])) {
            // supply next value for SORT_SEQ
            $query = "SELECT max(sort_seq) FROM $this->tablename "
                   . "WHERE menu_id='{$fieldarray['menu_id']}'";
            $count = $this->getCount($query);
            $fieldarray['sort_seq'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $pattern_id = getPatternId();
        switch (strtolower($pattern_id)) {
            // may need to change the contents of $where
        	case 'link1':
        		// alter sort criteria
        		//$this->sql_orderby = str_replace('mnu_menu.task_id_jnr', 'task_id_jnr', $this->sql_orderby);
        		break;

        	default:
        		$where = str_replace('task_id=', 'menu_id=', $where);
        } // switch

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        if (array_key_exists('task_id', $fieldarray)) {
            // change fieldname in $fieldarray from 'task_id' to 'task_id_jnr'
            $fieldarray['task_id_jnr'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        if (array_key_exists('task_id_jnr', $fieldarray) AND !array_key_exists('button_text', $fieldarray)) {
            $task_id_jnr = $fieldarray['task_id_jnr'];
            // get default button text from mnu_task table
            $dbobject =& RDCsingleton::getInstance('mnu_task');
            //$dbobject->sql_select = 'button_text';
            $data = $dbobject->getData("task_id='$task_id_jnr'");
            if (!empty($data)) {
                $data = $data[0];
                $size = $this->fieldspec['button_text']['size'];
                if (strlen($data['button_text']) <= $size) {
                    $fieldarray['button_text'] = $data['button_text'];
                } else {
                    $fieldarray['button_text'] = substr($data['button_text'], 0, $size);
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateLinkdata ($fieldarray, &$postarray)
    // $fieldarray is an array of field data (multiple rows).
    // $select is an array of entries which have been selected.
    // NOTE: $postarry is passed BY REFERENCE so that it may be modified.
    // NOTE: $fieldarray starts at 0, $select starts at 1.
    {
        // remove any selection which links an item to itself
        foreach ($postarray['select'] as $row => $switch) {
            if ($fieldarray[$row-1]['menu_id'] == $fieldarray[$row-1]['task_id_jnr']) {
                unset($postarray['select'][$row]);
                $this->errors[] = 'Cannot add a menu to itself';
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_pre_updateLinkData

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        $where = '';

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        $settings['select_one'] = false;

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        return $where;

    } // _cm_popupCall

// ****************************************************************************
} // end class
// ****************************************************************************

?>
