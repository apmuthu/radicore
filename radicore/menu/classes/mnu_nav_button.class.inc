<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_nav_button extends Default_Table
{

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_nav_button ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_nav_button';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_nav_button

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;

        if ($mode == 'search') {
            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['task_id_jnr']['noedit']);
            unset($fieldarray['task_id_jnr']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        //DebugBreak();
        if ($fieldarray['task_id_snr'] == $fieldarray['task_id_jnr']) {
            $this->errors[] = getLanguageText('e0012'); // 'Cannot add a task to itself';
            return $fieldarray;
        } // if

        if (array_key_exists('task_type', $orignaldata)) {
            if ($orignaldata['task_type'] == 'MENU') {
                $this->errors[] = getLanguageText('e0013'); // 'Cannot add a task of type MENU';
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array['READ'][] = 'mnu_dialog_type';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['task_id_snr'])) {
            // get next available value for SORT_SEQ
            $query = "SELECT max(sort_seq) FROM $this->tablename WHERE task_id_snr='{$fieldarray['task_id_snr']}'";
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
            case 'mnu_nav_button_link.php':
                // do nothing
                break;
            case 'mnu_nav_button_multi.php':
                $where = str_replace('mnu_task.task_id=', 'mnu_nav_button.task_id_snr=', $where);
                break;
            case 'mnu_nav_button_list.php':
                // if not aready qualified with a table name ...
                if (!strpos($where, '.task_id=')) {
                    $where = str_replace('task_id=', 'task_id_snr=', $where);
                } // if
                break;
            default:
                ;
        } // switch

//        if (empty($this->sql_select)) {
//            // include columns from foreign table
//            $this->sql_select = 'mnu_nav_button.*, mnu_task_snr.task_desc AS task_desc_snr, mnu_task_jnr.task_desc AS task_desc_jnr';
//            $this->sql_from   = 'mnu_nav_button '
//                               .'LEFT JOIN mnu_task AS mnu_task_snr '
//                               .'ON (mnu_task_snr.task_id=mnu_nav_button.task_id_snr) '
//                               .'LEFT JOIN mnu_task AS mnu_task_jnr '
//                               .'ON (mnu_task_jnr.task_id=mnu_nav_button.task_id_jnr) ';
//        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted
    {
        //DebugBreak();
        switch (basename($_SERVER['PHP_SELF'])) {
            case 'mnu_nav_button_add.php':
                if (array_key_exists('task_id', $fieldarray)) {
                    // change fieldname in $fieldarray from 'task_id' to 'task_id_jnr'
                    $task_id = $fieldarray['task_id'];
                    $fieldarray['task_id_jnr'] = $fieldarray['task_id'];
                    unset($fieldarray['task_id']);

                    // get default button text from mnu_task table
                    require_once 'mnu_task.class.inc';
                    $dbobject =& singleton::getInstance('mnu_task');
                    $dbobject->setSqlSelect('button_text,task_type,dialog_type_id');
                    $data = $dbobject->getData("task_id='$task_id'");
                    $fieldarray = array_merge($fieldarray, $data[0]);

                    // get default context_preselect from mnu_dialog table
                    $dialog_type_id = $fieldarray['dialog_type_id'];
                    require_once 'mnu_dialog_type.class.inc';
                    $dbobject =& singleton::getInstance('mnu_dialog_type');
                    $dbobject->setSqlSelect('context_preselect');
                    $data = $dbobject->getData("dialog_type_id='$dialog_type_id'");
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
    // $postarray is an array of entries which have been selected.
    // NOTE: $postarray is passed BY REFERENCE so that it may be modified.
    {
        // remove any selection which links an item to itself
        foreach ($postarray['select'] as $row => $switch) {
            if ($fieldarray[$row-1]['task_id_snr'] == $fieldarray[$row-1]['task_id_jnr']) {
                unset($postarray['select'][$row]);
                $this->messages[] = getLanguageText('e0012'); // 'Cannot add a task to itself';
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
