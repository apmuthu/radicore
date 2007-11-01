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
        if ($GLOBALS['mode'] == 'search') {
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
        if ($GLOBALS['mode'] == 'search') {
            // get details from parent (foreign) tables
        	if (isset($fieldarray['node_id']) and (!isset($fieldarray['tree_type_id']))) {
        	    $this->sql_select = 'x_tree_node.node_id, x_tree_node.tree_type_id, x_tree_node.tree_level_id';
            	$data = $this->getdata($where);
            	$fieldarray = array_merge($fieldarray, $data[0]);
            	return $fieldarray;
            } // if
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
