<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class tree_node extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function tree_node ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'tree_node';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // tree_node

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        //DebugBreak();
        if (isset($fieldarray['node_type'])) {
            switch ($fieldarray['node_type']) {
                case 'O':
                    if (array_key_exists('org_type_id', $fieldarray)) {
                        require_once 'org_type.class.inc';
                        $dbobject =& singleton::getInstance('org_type');
                        $dbobject->sql_select = 'image_fname';
                        $data = $dbobject->getData("org_type_id='{$fieldarray['org_type_id']}'");
                        $fieldarray['icon'] = $data[0]['image_fname'];
                    } // if
                    break;
                case 'L':
                    if (array_key_exists('location_type_id', $fieldarray)) {
                        require_once 'location_type.class.inc';
                        $dbobject =& singleton::getInstance('location_type');
                        $dbobject->sql_select = 'image_fname';
                        $data = $dbobject->getData("location_type_id='{$fieldarray['location_type_id']}'");
                        $fieldarray['icon'] = $data[0]['image_fname'];
                    } // if
                    break;
                case 'A':
                    if (array_key_exists('asset_type_id', $fieldarray)) {
                        require_once 'asset_type.class.inc';
                        $dbobject =& singleton::getInstance('asset_type');
                        $dbobject->sql_select = 'image_fname';
                        $data = $dbobject->getData("asset_type_id='{$fieldarray['asset_type_id']}'");
                        $fieldarray['icon'] = $data[0]['image_fname'];
                    } // if
                    break;
                default:
                    ;
            } // switch
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get valrep list for node_type and insert into lookup array
        $array = $this->getValRep('node_type');
        $this->lookup_data['node_type'] = $array;

        // node_type cannot be changed
        $this->fieldspec['node_type']['noedit'] = 'y';

        // disable certain fields depending on the node_type
        switch ($fieldarray['node_type']) {
            case 'O':
                // allow org_type only
                $this->fieldspec['org_type_id']['required']       = 'y';
                $this->fieldspec['location_type_id']['nodisplay'] = 'y';
                $this->fieldspec['asset_type_id']['nodisplay']    = 'y';
                unset($this->fieldspec['org_type_id']['nodisplay']);
                unset($this->fieldspec['location_type_id']['required']);
                unset($this->fieldspec['asset_type_id']['required']);

                // get contents of foreign table ORG_TYPE and add as a LOOKUP list
                require_once 'org_type.class.inc';
                $dbobject =& singleton::getInstance('org_type');
                $data_array = $dbobject->getValRep('org_type_id');
                $this->lookup_data['org_type_id'] = $data_array;
                break;
            case 'L':
                // allow location type only
                $this->fieldspec['location_type_id']['required'] = 'y';
                $this->fieldspec['org_type_id']['nodisplay']     = 'y';
                $this->fieldspec['asset_type_id']['nodisplay']   = 'y';
                unset($this->fieldspec['location_type_id']['nodisplay']);
                unset($this->fieldspec['org_type_id']['required']);
                unset($this->fieldspec['asset_type_id']['required']);

                // get contents of foreign table LOCATION_TYPE and add as a LOOKUP list
                require_once 'location_type.class.inc';
                $dbobject =& singleton::getInstance('location_type');
                $data_array = $dbobject->getValRep('location_type_id');
                $this->lookup_data['location_type_id'] = $data_array;

                // get address data associated with this location
                require_once 'location_address.class.inc';
                $address =& singleton::getInstance('location_address');
                $node_id = $fieldarray['node_id'];
                $address_data = $address->getData("node_id='$node_id'");
                if ($address->numrows > 0) {
                    $fieldarray = array_merge($address_data[0], $fieldarray);
                } else {
                    // nothing found, so load empty fields into output array
                    $address_fieldspec = $address->getFieldSpec();
                    foreach ($address->fieldspec as $fieldname => $spec) {
                        if (!array_key_exists($fieldname, $fieldarray)) {
                            $fieldarray[$fieldname] = null;
                        } // if
                    } // foreach
                } // if

                // merge fieldspecs
                $this->fieldspec = array_merge($this->fieldspec, $address->getFieldspec());
                break;
            case 'A':
                // allow asset type only
                $this->fieldspec['asset_type_id']['required']     = 'y';
                $this->fieldspec['org_type_id']['nodisplay']      = 'y';
                $this->fieldspec['location_type_id']['nodisplay'] = 'y';
                unset($this->fieldspec['asset_type_id']['nodisplay']);
                unset($this->fieldspec['org_type_id']['required']);
                unset($this->fieldspec['location_type_id']['required']);

                // get contents of foreign table ASSET_TYPE and add as a LOOKUP list
                require_once 'asset_type.class.inc';
                $dbobject =& singleton::getInstance('asset_type');
                $data_array = $dbobject->getValRep('asset_type_id');
                $this->lookup_data['asset_type_id'] = $data_array;
                break;
            default:
                $this->errors[] = getLanguageText('e0025', $fieldarray['node_type']); // "Unknown value for NODE_TYPE ({$fieldarray['node_type']})";
        } // switch

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

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getNodeData ($expanded, $where, $wherearray = null)
    // retrieve requested node data from the database.
    // $expanded may be a list of nodes to be expanded, or 'ALL' nodes.
    // $where may contain specific selection criteria as a string.
    // $wherearray is $where but converted into an array.
    {
        //DebugBreak();
        $this->sql_select  = 'tree_node.node_id, tree_node.node_desc, tree_node.node_depth, COUNT(child.node_id) AS child_count';
        $this->sql_from    = 'tree_node '
                           . 'LEFT JOIN tree_node AS child ON (tree_node.node_id=child.node_id_snr)';
        $this->sql_where   = '';
        $this->sql_groupby = 'tree_node.node_id, tree_node.node_desc, tree_node.node_depth';
        $this->sql_having  = '';

        if (empty($where)) {
            // look for root nodes within this structure
            $where = "node_depth='1'";
        } // if

        $data_unformatted = $this->getData($where);

        foreach ($data_unformatted as $row => $rowdata) {
            // append data for current node to output array
            $fieldarray[] = $this->formatData($rowdata);
            $node_id = $rowdata['node_id'];
            if ($rowdata['child_count'] > 0) {
                // child nodes exist, but do we expand them?
                if ($expanded == 'ALL' OR array_key_exists($node_id, $expanded)) {
                    // tell system this row has been expanded
                    $fieldarray[count($fieldarray)-1]['expanded'] = 'y';
                    // this replaces 'ALL' with a list of actual nodes
                    $this->expanded[$node_id] = true;
                    // get the child nodes belonging to this parent node
                    $childdata = $this->_cm_getNodeData($expanded, "node_id_snr='$node_id'");
                    // add in child data after the parent
                    $fieldarray = array_merge($fieldarray, $childdata);
                } else {
                    unset($this->expanded[$node_id]);
                } // if
            } // if
        } // foreach

        unset($data_unformatted);

        return $fieldarray;

    } // _cm_getTreeNode

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'node_type') {
//            $array['']  = ' ';   // start with blank entry
//            $array['O'] = 'Organisation';
//            $array['L'] = 'Location';
//            $array['A'] = 'Asset';
            $array = getLanguageArray('node_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        if ($fieldarray['node_type'] == 'L') {
            // insert address data associated with this location
            require_once 'location_address.class.inc';
            $address =& singleton::getInstance('location_address');
            $fieldarray = $address->insertRecord($fieldarray);
            $address_errors = $address->getErrors();
            if ($address_errors) {
                $this->errors = array_merge($this->errors, $address_errors);
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        //DebugBreak();
        if ($fieldarray['node_type'] == 'L') {
            // update address data associated with this location
            require_once 'location_address.class.inc';
            $address =& singleton::getInstance('location_address');
            $count = $address->getCount("node_id='{$fieldarray['node_id']}'");
            if ($count == 0) {
                $fieldarray = $address->insertRecord($fieldarray);
            } else {
                $fieldarray = $address->updateRecord($fieldarray);
            } // if
            if ($address->errors) {
                $this->errors = array_merge($this->errors, $address->errors);
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        if (empty($this->sql_select)) {
            $this->sql_select = 'tree_node.*, tree_node_snr.node_desc as node_desc_snr';
            $this->sql_from   = 'tree_node '
                              . 'LEFT JOIN tree_node AS tree_node_snr ON (tree_node_snr.node_id=tree_node.node_id_snr)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
