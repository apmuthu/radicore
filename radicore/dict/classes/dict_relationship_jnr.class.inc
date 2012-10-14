<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_relationship.class.inc';
class dict_relationship_jnr extends dict_relationship
{

    // ****************************************************************************
    // this subclass is used in: relationship(list2)c.php
    //                           relationship(add2)a.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // make these fields editable
        unset($this->fieldspec['database_id_jnr']['noedit']);
        unset($this->fieldspec['table_id_jnr']['noedit']);

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (isset($fieldarray['database_id'])) {
            // current values are to be used for the SNR (parent)
            $fieldarray['database_id_snr'] = $fieldarray['database_id'];
            $fieldarray['table_id_snr']    = $fieldarray['table_id'];
            // remove the original values
            unset($fieldarray['database_id']);
            unset($fieldarray['table_id']);
        } // if

        if (!isset($fieldarray['database_id_jnr'])) {
            // set default for database_id_jnr
            $fieldarray['database_id_jnr'] = $fieldarray['database_id_snr'];
        } // if

        // this button causes confusion, so remove it
        unset($GLOBALS['act_buttons']['submitstay']);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
            // ignore contents of selection
            $selection = null;
        } else {
            if (!empty($selection)) {
                $where     = $selection;
                $selection = null;
            } // if
        } // if

        if (preg_match('/(add2)/i', $pattern_id)) {
            $where_array = where2array($where, false, false);
             // remove fields included from $selection instead of $where
            if (isset($where_array['database_id_jnr'])) {
                unset($where_array['database_id_jnr']);
            } // if
            if (isset($where_array['table_id_jnr'])) {
                unset($where_array['table_id_jnr']);
            } // if
            if (isset($where_array['seq_no'])) {
                unset($where_array['seq_no']);
            } // if
            $where = array2where($where_array);
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        $where = array2where($fieldarray, $this->getPkeyNames());

        // create initial records on DICT_RELATED_COLUMN table
        $relobj =& RDCsingleton::getInstance('dict_related_column');

        $outarray = $relobj->getInitialDataMultiple($fieldarray);
        $outarray = $relobj->insertMultiple($outarray);
        if ($relobj->getErrors()) {
            $this->errors = array_merge($this->errors, $relobj->getErrors());
            return $fieldarray;
        } // if

        // switch to task to maintain related columns
        $next['task_id'] = 'dict_related_column(multi4)a';
        $next['where']   = $where;

        // this is processed by scriptnext() and scriptprevious()
        append2ScriptSequence($next);

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // look for entries where the specified table is SENIOR
        // in order to find all its JUNIOR relationships
        $where = str_replace('database_id=', 'database_id_snr=', $where );
        $where = str_replace('table_id=', 'table_id_snr=', $where );

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
