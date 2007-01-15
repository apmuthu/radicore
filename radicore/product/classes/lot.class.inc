<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class lot extends Default_Table
{
    // ****************************************************************************
    function lot ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'lot';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // lot

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['expiry_date'] < $fieldarray['manuf_date']) {
            // 'expiry date must be later than manufacture date'
        	$this->errors['expiry_date'] = getLanguageText('e0021');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

// ****************************************************************************
} // end class
// ****************************************************************************

?>
