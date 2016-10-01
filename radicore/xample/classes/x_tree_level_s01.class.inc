<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_level.class.inc';
class x_tree_level_s01 extends x_tree_level
{
    // ****************************************************************************
    // this class is for use by script: tree_level_multi.php
    // ****************************************************************************

    // ****************************************************************************
    function checkChildNodes ($fieldarray)
    // Find out if the tree_level below the current level has changed...
    // If it has then any children of nodes on the current level must be orphaned.
    {
        if (empty($fieldarray['tree_level_id_jnr'])) {
            // did not have any children before, so ignore
            return;
        } // if

        $tree_type_id      = $fieldarray['tree_type_id'];
        $tree_level_id     = $fieldarray['tree_level_id'];
        $tree_level_id_jnr = $fieldarray['tree_level_id_jnr'];

        // check to see if the level below this one has changed
        $dblevel =& RDCsingleton::getInstance('x_tree_level');
        $dblevel->sql_select = "x_tree_level.tree_type_id, x_tree_level.tree_level_id, t2.tree_level_id as tree_level_id_jnr";
        $dblevel->sql_from = "x_tree_level "
                            . "LEFT JOIN x_tree_level AS t2 ON (t2.tree_type_id = x_tree_level.tree_type_id AND t2.tree_level_seq = (x_tree_level.tree_level_seq +1))";
        $where  = "x_tree_level.tree_type_id='$tree_type_id' AND x_tree_level.tree_level_id='$tree_level_id'";
        $leveldata = $dblevel->getdata($where);

        if ($leveldata[0]['tree_level_id_jnr'] <> $tree_level_id_jnr) {
            // child level has changed, so update all nodes in previous child level to make them orphans
            $dbnode =& RDCsingleton::getInstance('x_tree_node');
            $where = "tree_type_id='$tree_type_id' AND tree_level_id='$tree_level_id_jnr'";
            $replace = 'node_id_snr=NULL';
            $count = $dbnode->updateSelection($where, $replace);
        } // if

        return;

    } // checkChildNodes

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // remove 'noedit' switch
        unset($this->fieldspec['tree_level_seq']['noedit']);

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = TRUE;     // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_tree_level AS t2';
                $lock_array[] = 'x_tree_node';
                $lock_array[] = 'x_tree_type';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        // turn all database locking OFF
        $GLOBALS['lock_tables'] = FALSE;
        $lock_array = array();

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_post_updateMultiple ($fieldarray)
    // perform custom processing after multiple database records have been updated.
    {
        // sort the rows according to 'tree_level_seq'
        foreach ($fieldarray as $row) {
            // create a new array indexed by 'tree_level_seq'
            $sortedarray[$row['tree_level_seq']] = $row;
        } // foreach

        ksort($sortedarray);            // sort this array
        $fieldarray = $sortedarray;     // replace original array

        foreach ($fieldarray as $rowdata) {
            // check child nodes in case they need to be updated
            $result = $this->checkChildNodes($rowdata);
            if ($this->errors) return $fieldarray;
        } // foreach

        return $fieldarray;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // unset rows_per_page for maintenance screen
        $this->rows_per_page = 0;

        // allow this field to be edited
        unset($this->fieldspec['tree_level_seq']['noedit']);

        // these fields must be display only
        $this->fieldspec['tree_level_id']['noedit']   = 'y';
        $this->fieldspec['tree_level_desc']['noedit'] = 'y';

        // selection criteria must be limited to 'tree_type'
        $where = "tree_type_id ='{$where_array['tree_type_id']}'";

        if (empty($this->sql_select)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_select  = null;
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
            // include details of current junior level (if there is one)
            $this->sql_select .= ', t2.tree_level_id as tree_level_id_jnr'
                               . ', t2.tree_level_seq as tree_level_seq_jnr';
            $this->sql_from   .= ' LEFT JOIN x_tree_level AS t2 ON (t2.tree_type_id = x_tree_level.tree_type_id AND t2.tree_level_seq = (x_tree_level.tree_level_seq +1))';
            $this->sql_where = '';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($fieldarray)
    // perform custom processing before multiple database records are updated.
    {
        $spec = $this->fieldspec['tree_level_seq'];

        // check that each update is valid
        $count = count($fieldarray);
        $used  = array();
        foreach ($fieldarray as $rownum => $rowdata) {
        	$seq = $rowdata['tree_level_seq'];
            if (strlen($seq) == 0) {
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0004'); // 'Cannot be empty'
            } elseif (strlen($seq) > $spec['size']) {
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0005', $spec[size]); // "Value too large ($spec[size])"
            } elseif (strcmp($seq, (int)$seq)) {
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0006'); // 'Must be an integer'
            } elseif (intval($seq) < 1) {
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0007'); // 'Must be greater than 0'
            } elseif (intval($seq) > $count) {
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0008', $count); // "Must not be greater than $count"
            } // if

            // make sure that each value is used no more than once
            if (array_key_exists($seq, $used)) {
                // 'Value has already been used'
                $this->errors[$rownum]['tree_level_seq'] = getLanguageText('e0009');
            } else {
                $used[$seq] = 'y';
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_pre_updateMultiple

// ****************************************************************************
} // end class
// ****************************************************************************

?>
