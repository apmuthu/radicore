<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_todo.class.inc';
class mnu_todo_s02 extends mnu_todo
{
// ****************************************************************************
    // this is used by: processtodo.php
    // it allows a To-Do entry to be activated from a hyperlink in an email.
    // ****************************************************************************

    var $user_id;
    var $seq_no;

    // ****************************************************************************
    function _cm_filterWhere ($array=null)
    // identify field names which are NOT to be filtered out of a $where string.
    {
        // custom code goes here

        return $array;

    } // _cm_filterWhere

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // examine what was passed in the query string
        $where_array = where2array($where);
        $valid        = true;
        $new_where    = array();
        $query_string = '';
        // get the passed hash of the entire query string
        if (!empty($where_array['h'])) {
            $hash = $where_array['h'];
        } else {
            $valid = false;
        } // if
        // get the passed user_id
        if (!empty($where_array['u'])) {
            $user_id = $where_array['u'];
            $query_string .= "U={$user_id}";
            $new_where['user_id'] = $user_id;
        } else {
            $valid = false;
        } // if
        // get the passed seq_no
        if (!empty($where_array['s'])) {
            $seq_no = $where_array['s'];
            $query_string .= "&S={$seq_no}";
            $new_where['seq_no'] = $seq_no;
        } else {
            $valid = false;
        } // if
        // generate a new hash and check that it matches what was passed in
        if ($valid) {
            $test_hash = sha1($query_string, false);
            if ($test_hash != $hash) {
                $valid = false;
            } // if
        } // if
        if (!$valid) {
            // "The supplied URL is not valid - report to your system administrator"
            $this->errors[] = getLanguageText('e0066');
            return $where;
        } // if

        // check that this item is for the current user
        if ($user_id != $_SESSION['logon_user_id']) {
            // "This entry is for a different user"
            $this->errors[] = getLanguageText('e0067');
            return $where;
        } // if

        // check that this item has not already been marked as completed
        $where = array2where($new_where);
        $data = $this->getData_raw($where);
        if (!empty($data)) {
            $data = $data[0];
            if (is_True($data['is_complete'])) {
                // "This To-Do item is already marked as 'complete'"
                $this->errors[] = getLanguageText('e0068');
                return $where;
            } // if
        } else {
            // "A To-Do entry with id 'n' cannot be found"
            $this->errors[] = getLanguageText('e0069', $survey_id);
            return $where;
        } // if

        // save these values so that they can be used in the _cm_post_updateRecord() method
        $this->user_id = $user_id;
        $this->seq_no  = $seq_no;

        $where = array2where($new_where);  // return a proper WHERE string

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateMultiple ($rows)
    // perform custom processing after multiple database records have been updated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        if (empty($this->errors) AND !empty($this->user_id)) {
            // switch to task connected to this ToDo entry
            $next['task_id'] = $fieldarray['task_id'];
            $next['where']   = $fieldarray['task_context'];
            append2ScriptSequence($next);  // run task AFTER this task has terminated
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain contents of current record in the parent object.
    {
        // customisable code goes here

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
        // customisable code goes here

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
