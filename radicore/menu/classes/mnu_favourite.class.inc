<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_favourite extends Default_Table
{
    // ****************************************************************************
    function mnu_favourite ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_favourite';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_favourite

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'update') {
        	// this field canot be changed
        	$this->fieldspec['task_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!empty($fieldarray)) {
        	if (empty($fieldarray['task_desc'])) {
            	$fieldarray['task_desc'] = $fieldarray['task_desc_original'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['user_id'])) {
            // get next available value for SORT_SEQ
            $query = "SELECT max(seq_no) FROM $this->tablename "
                   . "WHERE user_id='{$fieldarray['user_id']}'";
            $count = $this->getCount($query);
            $fieldarray['seq_no'] = $count + 1;
        } // if

        if (empty($fieldarray['sort_seq'])) {
        	$fieldarray['sort_seq'] = $fieldarray['seq_no'];
        } // if

        if (empty($fieldarray['task_desc']) AND !empty($fieldarray['task_id'])) {
        	$fieldarray = $this->getForeignData($fieldarray);
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings)
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
        //$settings['select_one'] = false;

        // allow a single result to be selected without user intervention
        //$settings['choose_single_row'] = true;

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {

        if ($return_from == 'mnu_task(popup1)') {
            // initialise field so that it can be reloaded in getForeignData()
            $fieldarray['task_desc']          = null;
            $fieldarray['task_desc_original'] = null;
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        $pattern_id = getPatternId();

        if ($this->initiated_from_controller AND preg_match('/(list1|list2)/i', $pattern_id)) {
        	// if there are no rows then jump to the ADD DEFAULT FAVOURITES screen
            if (count($rows) < 1) {
                if (isset($GLOBALS['return_from'])) {
                    // have returned from a child screen, so do nothing
                } else {
            	    scriptNext('mnu_favourite(add4)', $where);
                } // if
            } // if
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        if (empty($rowdata['task_desc']) AND !empty($rowdata['task_desc_original'])) {
        	$rowdata['task_desc'] = $rowdata['task_desc_original'];
        } // if

        return $rowdata;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
