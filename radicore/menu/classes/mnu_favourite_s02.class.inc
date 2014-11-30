<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_favourite.class.inc';
class mnu_favourite_s02 extends mnu_favourite
{
    // ****************************************************************************
    // this subtype is used by mnu_favourite(upd4)movedown.php
    // it will move a row DOWN (later) in the sequence
    // ****************************************************************************

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
        // can only process a single row
        if (count($rowdata) > 1) {
            // 'Multiple rows selected - only the 1st accepted'
            $this->messages[] = getLanguageText('e0070');
            $array[0] = $rowdata[0];
            $rowdata  = $array;
        } // if

        // save primary key of this record
        $user_id = $rowdata[0]['user_id'];
        $seq_no  = $rowdata[0]['seq_no'];

        // tell previous screen to keep this row selected
        $this->instruction['select']['seq_no'] = $seq_no;

        $this_sort_seq = $rowdata[0]['sort_seq'];

        // look for record(s) with higher sort_seq
        $where = "user_id='$user_id' AND sort_seq=(SELECT MIN(sort_seq) FROM mnu_favourite WHERE user_id='$user_id' AND sort_seq>'$this_sort_seq')";
        $this->sql_select = 'user_id, seq_no, sort_seq';
        $this->sql_from   = $this->tablename;
        $next_rows = $this->getData_raw($where);
        if (empty($next_rows)) {
            // "This entry cannot be moved DOWN any further";
            $this->errors[] = getLanguageText('e0072');
            return $rowdata;
        } // if

        $next_sort_seq = (int)$next_rows[0]['sort_seq'];

        // update sequence number of current entry
        $rowdata[0]['sort_seq'] = $next_sort_seq;

        // copy in following row(s) and update sort_seq
        foreach ($next_rows as $next_data) {
        	$next_data['sort_seq'] = $this_sort_seq;
        	$rowdata[] = $next_data;
        } // foreach

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateMultiple ($rows)
    // perform custom processing after multiple database records have been updated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // check that full primary key has been passed down from parent form
        $this->checkPrimaryKey = true;

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
} // end class
// ****************************************************************************

?>
