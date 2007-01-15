<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_answer_hdr extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function survey_answer_hdr ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'survey_answer_hdr';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // survey_answer_hdr

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if (!empty($fieldarray['survey_answer_id'])) {
            $query = "select count(*) FROM survey_answer_dtl WHERE survey_answer_id='{$fieldarray['survey_answer_id']}'";
            $count = $this->getCount($query);
        } else {
            $count = 0;
        } // if

        if ($count == 0) {
            // there are no records on SURVEY_ANSWER_DTL yet, so ...
            // add specification to invoke popup form
            $this->fieldspec['survey_id']['task_id'] = 'srv_survey_hdr(popup)';
        } else {
            // do not allow popup form to be called
            unset($this->fieldspec['survey_id']['task_id']);
        } // if

        if (($GLOBALS['mode'] == 'search')) {
            $fieldarray['user_name'] = null;
            // add specification to invoke popup for USER_NAME field
            $this->fieldspec['user_id']['task_id'] = 'mnu_user(popup)';
            unset($this->fieldspec['user_id']['noedit']);
            unset($this->fieldspec['is_complete']['noedit']);
        } else {
            unset($this->fieldspec['user_id']['task_id']);
            $this->fieldspec['user_id']['noedit'] = 'y';
            $this->fieldspec['is_complete']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getForeignData ($fieldarray)
    // Retrieve data from foreign entities.
    {
        //DebugBreak();
        if (!empty($fieldarray['node_id']) and empty($fieldarray['node_desc'])) {
            // not supplied yet, so get it manually
            require_once 'classes/tree_node.class.inc';
            $dbobject =& singleton::getInstance('tree_node');
            $dbobject->sql_select = 'node_id, node_desc, node_type';
            $foreign_data = $dbobject->getData("node_id='{$fieldarray['node_id']}'");
            if ($foreign_data[0]['node_type'] == 'L') {
                // use data from 1st row only
                $fieldarray = array_merge($fieldarray, $foreign_data[0]);
            } else {
                // not a location, so reject it
                $fieldarray['node_id'] = null;
            } // if
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // set survey_answer_id to next available number
        $query = "SELECT max(survey_answer_id) FROM $this->tablename";
        $count = $this->getCount($query);
        $fieldarray['survey_answer_id'] = $count + 1;

        $this->fieldspec['survey_answer_id']['noedit'] = 'y';

        $fieldarray['answer_date'] = getTimeStamp('date');

        $fieldarray['user_id'] = $_SESSION['logon_user_id'];

        // do not display this field on the input screen
        $this->fieldspec['is_complete']['nodisplay'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        if ($popupname == 'mnu_user(popup)') {
            // use input from current screen
            if (!empty($_POST['user_id'])) {
                $where = "user_id LIKE '{$_POST['user_id']}'";
            } // if
        } // if

        if ($popupname == 'srv_survey_hdr(popup)') {
            if ($GLOBALS['mode'] == 'search') {
                // use input from current screen
                if (!empty($_POST['survey_id'])) {
                    $where = "survey_id LIKE '{$_POST['survey_id']}'";
                } // if
            } // if
        } // if

        if ($popupname == 'srv_tree_node(popup)') {
            // use input from current screen
            if (!empty($_POST['node_id'])) {
                $where = "node_id LIKE '{$_POST['node_id']}'";
            } // if
        } // if

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        if ($return_from == 'srv_tree_node(popup)') {
            // get description for selected item
            require_once 'classes/tree_node.class.inc';
            $dbobject =& singleton::getInstance('tree_node');
            $dbobject->sql_select = 'node_id, node_desc, node_type';
            $foreign_data = $dbobject->getData($selection);

            if ($foreign_data[0]['node_type'] == 'L') {
                // merge with existing data
                $fieldarray = array_merge($fieldarray, $foreign_data[0]);
            } else {
                // invalid type, so try again
                scriptnext($return_from);
                // $fieldarray['node_id'] = null;
                // $this->errors['node_id'] = 'You must choose a LOCATION';
            } // if
            unset($dbobject);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        $where = array2where($fieldarray, $this->getPkeyNames());

        $next['task_id'] = 'srv_survey_answer_dtl(multi)';
        $next['where']   = $where;

        // this is processed by scriptnext() and scriptprevious()
        $_SESSION['script_sequence'][] = $next;

        return $fieldarray;

    } // _cm_post_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
