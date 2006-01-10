<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class product_category extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function product_category ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'product_category';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // product_category

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'prod_cat_id') {
            // get data from the database
            $this->sql_select     = 'prod_cat_id, prod_cat_desc';
            $this->sql_orderby    = 'prod_cat_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            $array[''] = ' ';   // start with blank entry

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
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        // add extra field to LIST screen
        $this->fieldspec['rollup']  = array('type' => 'boolean',
                                            'true' => 'Y',
                                            'false' => 'N');

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
