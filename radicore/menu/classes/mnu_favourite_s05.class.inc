<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_favourite.class.inc';
class mnu_favourite_s05 extends mnu_favourite
{
    // ****************************************************************************
    // this subtype is used by mnu_favourite(add4).php
    // it will add a set of defaults to the user's list of favourites
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        $fieldarray = parent::_cm_getInitialData ($fieldarray);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause,
    // or current data from the outer object (if one exists).
    {
        if (is_long(key($fieldarray))) {
            $fieldarray = $fieldarray[0];
        } // if

        // save USER_ID
        if (empty($fieldarray)) {
        	$user_id = $_SESSION['logon_user_id'];
        } elseif (empty($fieldarray) OR empty($fieldarray['user_id'])) {
            $user_id = $_SESSION['logon_user_id'];
        } else {
            $user_id = $fieldarray['user_id'];
        } // if

        // create entries for default favourites
        $fieldarray = array();
        $fieldarray[] = array('user_id' => $user_id, 'task_id' => 'mnu_user(upd1)a', 'task_desc' => 'Change Password');
        $fieldarray[] = array('user_id' => $user_id, 'task_id' => 'mnu_todo(list2)', 'task_desc' => 'To-Do');
        $fieldarray[] = array('user_id' => $user_id, 'task_id' => 'mnu_motd(list1)', 'task_desc' => 'MOTD');

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // custom code goes here

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // custom code goes here

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertMultiple ($rows)
    // perform custom processing after multiple database records are inserted.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // custom code goes here

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertMultiple ($rows)
    // perform custom processing before multiple database records are inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_insertMultiple

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        $rowdata = parent::_cm_pre_insertRecord ($rowdata);

        return $rowdata;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
