<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_account extends Default_Table
{
    // ****************************************************************************
    function mnu_account ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_account';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_account

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
        	unset($this->fieldspec['rdcaccount_id']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'rdcaccount_id') {
            // get data from the database
            $this->sql_select     = 'rdcaccount_id, account_name';
            $this->sql_orderby    = 'account_name';
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
