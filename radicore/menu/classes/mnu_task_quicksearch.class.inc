<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_task_quicksearch extends Default_Table
{
    // ****************************************************************************
    function mnu_task_quicksearch ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_task_quicksearch';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_task_quicksearch

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (empty($fieldarray['sort_seq']) AND !empty($fieldarray['task_id'])) {
            // get next available value for SORT_SEQ
            $query = "SELECT max(sort_seq) FROM $this->tablename "
                    ." WHERE task_id='{$fieldarray['task_id']}'";
            $count = $this->getCount($query);
            $fieldarray['sort_seq'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain contents of current record in the parent object.
    {
        if (!empty($parent_data)) {
            if (!preg_match('/^(list|popup)/i', $parent_data['pattern_id'])) {
                // "QuickSearch options are not valid unless pattern is 'LIST' or 'POPUP'"
                $this->errors[] = getLanguageText('e0079');
                $GLOBALS['nav_buttons_omit'][] = 'mnu_task_quicksearch(add2)';
                return $where;
            } // if
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
