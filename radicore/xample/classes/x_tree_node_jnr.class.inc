<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_node.class.inc';
class x_tree_node_jnr extends x_tree_node
{
    // ****************************************************************************
    function _cm_deleteSelection ($selection)
    // delete/update a selection of records.
    {
        // $where must contain at least one occurrence of 'node_id='
        if (substr_count($selection, 'node_id=') < 1) {
            // 'Nothing has been selected yet'
            return getlanguageText('sys0081');
        } // if

        // delete relationships by setting NODE_ID_SNR to NULL on selected records.
        $count = $this->_dml_updateSelection($selection, 'node_id_snr=NULL');

        // "$count rows were updated"
        return getLanguageText('sys0006', $count, $this->tablename);

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_getNodeData ($expanded, $where, $wherearray = null)
    // retrieve requested node data from the database.
    // $expanded may be a list of nodes to be expanded, or 'ALL' nodes.
    // $where may contain specific selection criteria as a string.
    // $wherearray is $where but converted into an array.
    {
        //DebugBreak();
        $this->sql_select  = 'x_tree_node.node_id, x_tree_node.node_desc, x_tree_level.tree_level_seq, COUNT(child.node_id) AS child_count';
        $this->sql_from    = 'x_tree_level, x_tree_node '
                           . 'LEFT JOIN x_tree_node AS child ON (x_tree_node.node_id=child.node_id_snr)';
        $this->sql_where   = 'x_tree_level.tree_type_id=x_tree_node.tree_type_id AND x_tree_level.tree_level_id=x_tree_node.tree_level_id';
        $this->sql_groupby = 'x_tree_node.node_id, x_tree_node.node_desc, x_tree_node.tree_level_id, x_tree_level.tree_level_seq';
        $this->sql_having  = '';
        $this->sql_orderby = 'x_tree_node.tree_level_id, x_tree_node.node_id';

        if (array_key_exists('tree_type_id', $wherearray)) {
            // look for root nodes within this tree_type
            $wherearray['tree_level_seq'] = 1;
            $where = array2where($wherearray);
        } // if

        $data_unformatted = $this->getData($where);

        foreach ($data_unformatted as $row => $rowdata) {
            // append data for current node to output array
            $fieldarray[] = $this->formatData($rowdata);
            $node_id = $rowdata['node_id'];
            if ($rowdata['child_count'] > 0) {
                // child nodes exist, but do we expand them?
                if ($expanded == 'ALL' or array_key_exists($node_id, $expanded)) {
                    // tell system this row has been expanded
                    $fieldarray[count($fieldarray)-1]['expanded'] = 'y';
                    // this replaces 'ALL' with a list of actual nodes
                    $this->expanded[$node_id] = true;
                    // get the child nodes belonging to this parent node
                    $childdata = $this->getNodeData($expanded, "node_id_snr='$node_id'");
                    // add in child data after the parent
                    $fieldarray = array_merge($fieldarray, $childdata);
                } else {
                    unset($this->expanded[$node_id]);
                } // if
            } // if
        } // foreach

        unset($data_unformatted);

        return $fieldarray;

    } // _cm_getNodeData

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple records in a single operation
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
