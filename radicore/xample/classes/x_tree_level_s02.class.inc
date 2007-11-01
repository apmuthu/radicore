<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_level.class.inc';
class x_tree_level_s02 extends x_tree_level
{
    // ****************************************************************************
    // this class is for use by script: tree_node_jnr.popup.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // remove any tablename which qualifies a fieldname
        $where = unqualifyWhere($where);

        // convert 'node_id_snr=' to 'node_id=;
        $where = str_replace('node_id_snr=', 'node_id=', $where);

        // find out if $selection is for TREE_NODE table
        if (ereg('(node_id=)', $where)) {
            // yes - convert to TREE_LEVEL table
            $dbobject =& singleton::getInstance('x_tree_node');

            // read data from TREE_NODE table
            $tree_node_data = $dbobject->getData($where);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $where;
            } // if

            // get data from foreign table TREE_LEVEL
            $tree_type_id  = $tree_node_data[0]['tree_type_id'];
            $tree_level_id = $tree_node_data[0]['tree_level_id'];
            $where2        = "tree_type_id='$tree_type_id' AND tree_level_id='$tree_level_id'";
            $tree_level_data = $this->getData($where2);

            // get data for TREE_LEVEL which is one level lower
            $tree_level_seq = $tree_level_data[0]['tree_level_seq'] + 1;
            $where2         = "tree_type_id='$tree_type_id' AND tree_level_seq='$tree_level_seq'";
            $this->checkPrimaryKey = false;
            $tree_level_data = $this->getData($where2);

            // if ($this->errors) return($this->errors);
            if ($this->numrows <> 1) {
                // 'This is the lowest level - no children allowed'
                $this->errors[] = getLanguageText('e0003');
                return $where;
            } else {
                $where = array2where($tree_level_data[0], $this->getPkeyNames());
            } // if

            unset($dbobject);
        } // if

        $fieldarray = where2array($where);

        return $fieldarray;

    } // _cm_changeConfig

// ****************************************************************************
} // end class
// ****************************************************************************

?>
