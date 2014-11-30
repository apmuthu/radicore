<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_favourite extends Default_Table
{
    // ****************************************************************************
    function mnu_favourite ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

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

        if (!empty($rowdata['current_menu']) AND !empty($rowdata['breadcrumbs'])) {
            $string = "current_menu=".$rowdata['current_menu'];

            foreach ($rowdata['breadcrumbs'] as $task_id => $task_array) {
            	foreach ($task_array as $key => $value) {
            		$string .= "&$task_id"."[$key]=$value";
            	} // foreach
            } // foreach

            // save this string in the database record
            $rowdata['breadcrumbs'] = $string;

            parse_str($string, $test);
        } // if

        return $rowdata;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function rebuildBreadcrumbs ($user_id, $task_id, $task_array)
    // a favourite task has been chosen, so rebuild the menu bar and breadcrumbs area
    // to what it was when the favourite was first set.
    {
        $where = "user_id='$user_id' AND task_id='$task_id'";
        $data = $this->getData($where);
        if (!empty($data)) {
        	$data = $data[0];
        	if (!empty($data['breadcrumbs'])) {
        	    // convert the string into an array
        		parse_str($data['breadcrumbs'], $breadcrumbs);
        		// obtain existing vars for this task
        		$script_id = '/' .$task_array['subsys_dir'] .'/' .$task_array['script_id'];
        		if (isset($_SESSION['pages'][$script_id])) {
                    if (isset($_SESSION['pages'][$script_id][$task_id])) {
                        $script_vars = $_SESSION['pages'][$script_id][$task_id];
                    } else {
                        $script_vars = array();
                    } // if
                } else {
                    $script_vars = array();
                } // if
        		// overwrite values in $script_vars
        		$_SESSION['pages'][$script_id]['task_id']              = $task_id;
        		$_SESSION['pages'][$script_id]['pattern_id']           = $task_array['pattern_id'];
        		$_SESSION['pages'][$script_id]['task_array'][$task_id] = true;

        		$script_vars['current_menu'] = $breadcrumbs['current_menu'];
        		unset($breadcrumbs['current_menu']);
        		$script_vars['page_stack']   = $breadcrumbs;
        		// rebuild contents of menu bar
        		$dbmenu =& RDCsingleton::getInstance('mnu_menu');
                $script_vars['menu_buttons'] = $dbmenu->getMenuButtons($script_vars['current_menu']);
                unset($script_vars['dbobject']);
                // put the amended values back into the session array
                $_SESSION['pages'][$script_id][$task_id] = $script_vars;
                $GLOBALS['current_task'] = $task_id;
                // do not allow current values to be carried forward
                unset($GLOBALS['current_menu']);
                unset($GLOBALS['menu_buttons']);
                unset($GLOBALS['page_stack']);
                return true;
        	} // if
        } // if

        return false;

    } // rebuildBreadcrumbs

// ****************************************************************************
} // end class
// ****************************************************************************

?>
