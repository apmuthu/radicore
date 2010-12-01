<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_role_taskfield extends Default_Table
{

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_role_taskfield ()
    {
		// save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_role_taskfield';
		$this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_role_taskfield

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('access_type', $this->lookup_data)) {
            // get options for access_type and insert in LOOKUP data
            $array = $this->getValRep('access_type');
            $this->lookup_data['access_type'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'access_type') {
//            $array['FULL'] = 'Full';
//            $array['NED']  = 'NOEDIT';
//            $array['NDI']  = 'NODISPLAY';
            $array = getLanguageArray('access_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

// ****************************************************************************
} // end class
// ****************************************************************************

?>
