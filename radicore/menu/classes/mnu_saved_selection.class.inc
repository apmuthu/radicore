<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_saved_selection extends Default_Table
{
    // ****************************************************************************
    function mnu_saved_selection ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_saved_selection';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_saved_selection

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $pattern_id = getPatternId();

        if (preg_match('/upd/i', $pattern_id)) {
            $this->fieldspec['user_id']['noedit'] = 'y';
            $this->fieldspec['task_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function saveSelection ($selection, $description, $user_id=null, $task_id=null)
    // save this selection in the database
    {
        if (empty($user_id)) {
            $user_id = $_SESSION['logon_user_id'];
        } // if
        if (empty($task_id)) {
            $task_id = $GLOBALS['task_id'];
        } // if
        if (empty($description)) {
            if (!empty($selection['rdc_selection_desc'])) {
                $description = $selection['rdc_selection_desc'];
            } else {
                $description = getTimeStamp();
            } // if
        } // if

        // create the header record on this table
        $new['user_id']        = $user_id;
        $new['task_id']        = $task_id;
        $new['selection_desc'] = $description;
        $new = $this->insertRecord($new);
        if ($this->errors) {
            return false;
        } // if

        // dump the selection data into the child table
        $dbobject =& RDCsingleton::getInstance('mnu_saved_selection_data');
        $dbobject->audit_logging = false;  // do not log initial insert
        foreach ($selection as $fieldname => $fieldvalue) {
            $fieldvalue = trim($fieldvalue);
            $add['selection_id'] = $new['selection_id'];
            $add['fieldname']    = $fieldname;
            $add['fieldvalue']   = $fieldvalue;
            $result = $dbobject->insertRecord($add);
            if ($dbobject->errors) {
                $this->errors[$dbobject->getClassName()] = $dbobject->errors;
                return false;
            } // if
        } // foreach

        return true;

    } // saveSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
