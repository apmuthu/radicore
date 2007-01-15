<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class help_text extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function help_text ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'help_text';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // help_text

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        // replace HTML line breaks with newline
        $pattern[]   = "<br>";
        $pattern[]   = "<br/>";
        $pattern[]   = "<br />";
        $replacement = "\n";

        if (isset($fieldarray['help_text'])) {
        	$text = $fieldarray['help_text'];
        	$fieldarray['help_text'] = str_replace($pattern, $replacement, $text);
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        unset($this->fieldspec['task_id']['noedit']);
        unset($this->fieldspec['help_text']['noedit']);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        //DebugBreak();
        if (isset($_POST['retrieve'])) {
            unset($where_array['help_text']);
            $where = array2where($where_array);
            return $where;
        } // if

        if (empty($this->sql_select)) {
            $this->sql_select = 'help_text.*, task_desc';
            $this->sql_from   = 'help_text '
                              . 'LEFT JOIN mnu_task ON (mnu_task.task_id=help_text.task_id) ';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
