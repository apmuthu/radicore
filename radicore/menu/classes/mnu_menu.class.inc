<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
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
            $query = "SELECT max(sort_seq) FROM $this->tablename " . "WHERE menu_id='{$fieldarray['menu_id']}'";
            $count = $this->getCount($query);
            $fieldarray['sort_seq'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        switch (basename($_SERVER['PHP_SELF'])) {
            // may need to change the contents of $where
        	case 'mnu_menu_link.php':
        		// do nothing
        		break;
            case 'mnu_menu_multi.php':
                $where = str_replace('mnu_task.task_id=', 'mnu_menu.menu_id=', $where);
        	default:
        		$where = str_replace('task_id=', 'menu_id=', $where);
        } // switch

        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'mnu_menu.*, mnu_task_snr.task_desc AS menu_desc, mnu_task_jnr.task_desc AS task_desc_jnr';
            $this->sql_from   = 'mnu_menu '
                              . 'LEFT JOIN mnu_task AS mnu_task_snr '
                              . 'ON (mnu_task_snr.task_id=mnu_menu.menu_id) '
                              . 'LEFT JOIN mnu_task AS mnu_task_jnr '
                              . 'ON (mnu_task_jnr.task_id=mnu_menu.task_id_jnr) ';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        // change fieldname in $fieldarray from 'task_id' to 'task_id_jnr'
        if (array_key_exists('task_id', $fieldarray)) {
            $fieldarray['task_id_jnr'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        global $mode;
        switch ($mode) {
            case 'insert':
                if (array_key_exists('task_id_jnr', $fieldarray)) {
                    $task_id_jnr = $fieldarray['task_id_jnr'];
                    // get default button text from mnu_task table
                    require_once 'mnu_task.class.inc';
                    $dbobject =& singleton::getInstance('mnu_task');
                    $dbobject->sql_select = 'button_text';
                    $data = $dbobject->getData("task_id='$task_id_jnr'");
                    $fieldarray = array_merge($fieldarray, $data[0]);
                } // if
                break;
            default:
                ;
        } // switch

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
        // the default is to clear out the contents of $where
        $where = '';

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        // ensure that only one entry can be selected
        // (multiple entries may be defined by separating them with '&')
        //$settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

// ****************************************************************************
} // end class
// ****************************************************************************

?>
