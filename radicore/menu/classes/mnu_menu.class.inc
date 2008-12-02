<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
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

        $this->dbms_engine = $GLOBALS['dbms'];
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
        $role_id = $_SESSION['role_id'];

        // identify extra parameters for a JOIN, as follows:-
        // MNU_MENU identifies list of tasks which are attached to the current menu,
        // MNU_ROLE_TASK identifies which taks the members of the current role may access,
        // (this is ignored if GLOBAL_ACCESS is TRUE).
        // MNU_TASK holds task descriptions, and whether a particular task has ben disabled
        // (in which case it must also be removed from he selection)

        $this->sql_select = 'mnu_task.task_id, mnu_task.task_desc, mnu_menu.button_text, global_access, '
                          . 'CASE WHEN mnu_role_task.role_id IS NOT NULL THEN 1 ELSE 0 END AS access_allowed';
        $this->sql_from   = 'mnu_menu '
                          . 'LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_menu.task_id_jnr) '
                          . "LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_menu.task_id_jnr AND mnu_role_task.role_id='$role_id') "
                          . "LEFT JOIN mnu_role ON (mnu_role.role_id='$role_id')";
        $this->sql_where  = "(mnu_role_task.role_id IS NOT NULL OR mnu_role.global_access='Y') "
                          . "AND (mnu_task.is_disabled='N')";

        $dbmenu_data = $this->getData_raw("menu_id='$task_id'");

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
            $dbobject =& singleton::getInstance('mnu_task');
            $dbobject->sql_select = 'button_text';
            $data = $dbobject->getData("task_id='$task_id_jnr'");
            $fieldarray = array_merge($fieldarray, $data[0]);
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
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
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
