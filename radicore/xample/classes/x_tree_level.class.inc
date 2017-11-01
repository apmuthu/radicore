<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_tree_level extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'xample';
        $this->tablename   = 'x_tree_level';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        switch ($GLOBALS['mode']) {
        	case 'search':
        		unset($this->fieldspec['tree_level_seq']['noedit']);
        		break;

        	case 'update':
        		$this->fieldspec['tree_level_seq']['noedit']  = 'y';
        		break;

        	case 'list':

        	    break;

        	default:
        		break;
        } // switch

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['tree_type_id'])) {
            // get next available number for tree_level_id
            $where = "tree_type_id='{$fieldarray['tree_type_id']}'";
            $query = "SELECT max(tree_level_id) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['tree_level_id']  = $count + 1;
            $fieldarray['tree_level_seq'] = $count + 1;
        } // if

        // set these fields to 'noedit' (read only)
        $this->fieldspec['tree_level_id']['noedit']  = 'y';
        $this->fieldspec['tree_level_seq']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'tree_level_id') {
            // get data from the database
            $this->sql_select     = 'tree_level_id, tree_level_desc';
            $this->sql_orderby    = 'tree_level_seq';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

// ****************************************************************************
} // end class
// ****************************************************************************

?>
