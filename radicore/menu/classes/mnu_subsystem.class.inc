<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_subsystem extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_subsystem ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_subsystem';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_subsystem

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (strpos($fieldarray['subsys_dir'], '/') or strpos($fieldarray['subsys_dir'], '\\')) {
            // only a single directory name is required
            $this->errors['subsys_dir'] = getLanguageText('e0034');
        } // if

        if (!is_dir('../' .$fieldarray['subsys_dir'])) {
            // not a valid directory name
            $this->errors['subsys_dir'] = getLanguageText('e0035');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'subsys_id') {
            // get data from the database
            $this->sql_select     = 'subsys_id, subsys_desc';
            $this->sql_orderby    = 'subsys_desc';
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
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {
        // no logging for this 'erase'
        $this->audit_logging = false;

        return $fieldarray;

    } // _cm_pre_eraseRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
