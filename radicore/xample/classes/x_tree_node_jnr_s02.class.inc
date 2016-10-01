<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_node.class.inc';
class x_tree_node_jnr_s02 extends x_tree_node
{
    // ****************************************************************************
    // This subtype is for script: tree_node_jnr_list.php
    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        // remove 'tree_level_id' from search criteria
        $array = where2array(unqualifyWhere($this->sql_search));
        unset($array['tree_level_id']);
        $this->sql_search = array2where($array);

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // change criteria to look for children of the selected node
        $where = str_replace('node_id=', 'node_id_snr=', $where);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
