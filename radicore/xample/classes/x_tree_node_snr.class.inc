<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_node.class.inc';
class x_tree_node_snr extends x_tree_node
{
    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        $this->default_orderby = null;

        // convert selection from 'node_id_snr=x' to 'node_id=x'
        $where = str_replace('node_id_snr=', 'node_id=', $where);

        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'x_tree_node.*, x_tree_type.tree_type_desc, x_tree_level.tree_level_desc, x_tree_level.tree_level_seq';
            $this->sql_from   = 'x_tree_node '
                               .'LEFT JOIN x_tree_type ON (x_tree_type.tree_type_id = x_tree_node.tree_type_id) '
                               .'LEFT JOIN x_tree_level ON (x_tree_level.tree_level_id = x_tree_node.tree_level_id AND x_tree_level.tree_type_id = x_tree_node.tree_type_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
