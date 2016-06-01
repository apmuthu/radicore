<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_task_quicksearch_alt extends Default_Table
{
    // ****************************************************************************
    function mnu_task_quicksearch_alt ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_task_quicksearch_alt';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_task_quicksearch_alt

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('language_id', $this->lookup_data)) {
            // get options for language_id
            $dbobject =& RDCsingleton::getInstance('mnu_language');
            $array = $dbobject->getValRep('language_id', "language_id != '{$_SESSION['default_language']}'");
            $array = array_change_key_case($array, CASE_LOWER);
            $this->lookup_data['language_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
