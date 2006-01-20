<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'tree_node.class.inc';
class tree_node_s03 extends tree_node
{
    // ****************************************************************************
    // this version is used to add nodes of type 'asset'
    // ****************************************************************************

    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (isset($fieldarray['node_id_snr'])) {
            // processing of parent node has been done, so skip next bit
        } else {
            // a parent node must have been selected for this to work
            if (!isset($fieldarray['node_id'])) {
                $this->errors[] = getLanguageText('e0026'); // 'This function requires a parent node to be selected';
                return $fieldarray;
            } // if

            // get details of parent node
            $node_id_snr = $fieldarray['node_id'];
            $this->sql_select = 'node_type, node_depth, node_desc';
            $parent_data = $this->getData_raw("node_id='$node_id_snr'");

            // check that parent is valid
            if ($parent_data[0]['node_type'] == 'A') {
                $this->errors[] = getLanguageText('e0028'); // 'Cannot add an asset to an asset';
                return $fieldarray;
            } // if

            $fieldarray['node_id_snr'] = $node_id_snr;
            $fieldarray['node_desc_snr'] = $parent_data[0]['node_desc'];

            // set depth to 1 greater than parent node
            $fieldarray['node_depth'] = (int)$parent_data[0]['node_depth'] + 1;

            // set node_type to 'ASSET' and make it display only
            $fieldarray['node_type'] = 'A';
            $this->fieldspec['node_type']['noedit'] = 'y';

            // set non-applicable fields to invisible
            $this->fieldspec['org_type_id']['nodisplay'] = 'y';
            $this->fieldspec['location_type_id']['nodisplay'] = 'y';

            // make this a required field
            $this->fieldspec['asset_type_id']['required'] = 'y';

            // return an instruction to expand the parent node
            $this->instruction['expand'] = $node_id_snr;
        } // if

        // perform standard processing in parent class
        $fieldarray = parent::_cm_getInitialData($fieldarray);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        // tell previous screen to keep this row selected
        $this->instruction['select']['node_id'] = $fieldarray['node_id'];

        return $fieldarray;

    } // _cm_post_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
