<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user_role.class.inc';
class mnu_user_role_s03 extends mnu_user_role
{
    // ****************************************************************************
    // this subtype is used by mnu_user_role(upd4)reseq.php
    // it will update the sort_seq in all records for a user
    // ****************************************************************************

    var $sort_seq;      //  sequence number

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // customisable code goes here

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // custom code goes here

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateMultiple ($rows)
    // perform custom processing after multiple database records have been updated.
    {
        // customisable code goes here
        $this->messages[] = getLanguageText('e0073'); // 'Entries have been resequenced';

        return $rows;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // remove everything from $where except user_id
        if (empty($where_array['user_id'])) {
            // "Nothing has been selected yet";
            $this->errors[] = getLanguageText('sys0081');
        } // if

        $where = "user_id='{$where_array['user_id']}'";

        //$this->sql_orderby = 'sort_seq';

        $this->sort_seq = 1;    // sequence numbers start at 1

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($rows)
    // perform custom processing before multiple database records are updated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_updateMultiple

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // replace sequence number
        $fieldarray['sort_seq'] = $this->sort_seq;

        // increment sequence number
        $this->sort_seq++;

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
