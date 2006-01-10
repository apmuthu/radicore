<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_tree_node extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function x_tree_node ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'x_tree_node';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // x_tree_node

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;
        if ($mode == 'search') {
            $this->fieldspec['node_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // this is for one of the search screens.....
        if (isset($fieldarray['node_id_snr'])) {
            // read data from TREE_NODE table
            $this->sql_select = 'x_tree_node.*, x_tree_type.tree_type_desc, x_tree_level.tree_level_seq';
            $this->sql_from = 'x_tree_node '
                            . 'LEFT JOIN x_tree_type ON (x_tree_type.tree_type_id = x_tree_node.tree_type_id) '
                            . 'LEFT JOIN x_tree_level ON (x_tree_level.tree_level_id = x_tree_node.tree_level_id AND x_tree_level.tree_type_id = x_tree_node.tree_type_id)';
            $where = "node_id='{$fieldarray['node_id_snr']}'";
            $tree_node_data = $this->getData($where);
            if ($this->errors) {
                return;
            } // if

            // copy this data into $fieldarray
            $fieldarray['tree_type_desc'] = $tree_node_data[0]['tree_type_desc'];

            require_once 'x_tree_level.class.inc';
            $dbobject =& singleton::getInstance('x_tree_level');

            // get data for TREE_LEVEL which is one level lower
            $dbobject->sql_select = 'tree_level_seq, tree_level_id, tree_level_desc';
            $dbobject->sql_from   = 'x_tree_level';
            $dbobject->sql_where  = '';
            $tree_type_id = $tree_node_data[0]['tree_type_id'];
            $tree_level_seq = $tree_node_data[0]['tree_level_seq'] + 1;
            $where2 = "tree_type_id='$tree_type_id' AND tree_level_seq='$tree_level_seq'";
            $tree_level_data = $dbobject->getdata($where2);
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $tree_level_data[0]);
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set node_id to next available number
        $count = $this->getCount("SELECT max(node_id) FROM $this->tablename");
        $fieldarray['node_id'] = $count + 1;

        $this->fieldspec['node_id']['noedit'] = 'y';

        $fieldarray['node_id_snr'] = null;
        $this->fieldspec['node_id_snr']['nodisplay'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'x_tree_node.*, tree_type_desc, tree_level_desc';
            $this->sql_from   = 'x_tree_node '
                               .'LEFT JOIN x_tree_level ON (x_tree_level.tree_type_id=x_tree_node.tree_type_id AND x_tree_level.tree_level_id=x_tree_node.tree_level_id) '
                               .'LEFT JOIN x_tree_type ON (x_tree_type.tree_type_id=x_tree_node.tree_type_id)';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple rows in a single operation.
    {
        //DebugBreak();
        $replace = str_replace('node_id=', 'node_id_snr=', $replace);

        $count = $this->_dml_updateSelection($selection, $replace);

        // "$count rows were updated"
        return getLanguageText('sys0006', $count, $this->tablename);

    } // _cm_updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
