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
                // current node has a parent, so fetch it
                $where = "x_tree_node.node_id='{$rowdata[0]['node_id_snr']}'";
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
} // end class
// ****************************************************************************

?>
