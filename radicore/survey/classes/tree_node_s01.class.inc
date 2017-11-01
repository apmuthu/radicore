<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'tree_node.class.inc';
class tree_node_s01 extends tree_node
{
    // ****************************************************************************
    // this version is used to add nodes of type 'organisation'
    // ****************************************************************************

    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // perform standard processing in parent class
        $fieldarray = parent::_cm_getInitialData($fieldarray);

        // organisations are always at depth 1
        $fieldarray['node_depth'] = 1;

        // set node_type to 'ORG' and make it display only
        $fieldarray['node_type'] = 'O';
        $this->fieldspec['node_type']['noedit'] = 'y';

        // set non-applicable fields to invisible
        $this->fieldspec['location_type_id']['nodisplay'] = 'y';
        $this->fieldspec['asset_type_id']['nodisplay'] = 'y';

        // do not display this field in insert mode
        $this->fieldspec['node_id_snr']['nodisplay'] = 'y';

        // make this a required field
        $this->fieldspec['org_type_id']['required'] = 'y';

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
