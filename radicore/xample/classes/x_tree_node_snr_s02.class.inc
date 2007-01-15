<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_node_snr.class.inc';
class x_tree_node_snr_s02 extends x_tree_node_snr
{
    // ****************************************************************************
    // this subtype is for script: tree_node_snr_list.php
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        if (!empty($rowdata)) {

            // do not allow page breaks for this enquiry
            $this->rows_per_page = 0;

            // restrict data to 1st row
            $rowdata = array_slice($rowdata, 0, 1);

            $numrows = 1;
            // keeping reading parent node until NODE_ID_SNR is empty
            while (!empty($rowdata[0]['node_id_snr'])) {
                // current node has a parent, so get it
                $this->sql_select = 'node_id, node_id_snr, node_desc, external_code, tree_level_seq, tree_level_desc';
                $this->sql_from   = 'x_tree_node LEFT JOIN x_tree_level ON (x_tree_level.tree_type_id=x_tree_node.tree_type_id AND x_tree_level.tree_level_id=x_tree_node.tree_level_id)';
                $where = "node_id='{$rowdata[0]['node_id_snr']}'";
                $data = $this->_dml_getData($where);
                // add parent data to front of existing array
                array_unshift($rowdata, $data[0]);
                $numrows++;
            } // while

            $this->numrows = $numrows;

        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
//        if (empty($this->sql_select)) {
//        	// obtain an extra field from x_tree_level
//            $this->sql_select = 'x_tree_node.*, tree_level_seq';
//        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
