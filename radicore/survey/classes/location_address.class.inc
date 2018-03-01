<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class location_address extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'survey';
        $this->tablename   = 'location_address';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        if (!empty($fieldarray['postcode'])) {
            $pattern = "/^[A-Z]{1,2}[0-9]{1,2}[A-Z]{0,1} [0-9]{1}[A-Z]{2}$/i";
            if (!preg_match($pattern, $fieldarray['postcode'])) {
                $this->errors['postcode'] = getlanguageText('e0005'); // 'Invalid format for a postcode.';
            } // if
        } // if

        if (!empty($fieldarray['telephone'])) {
            $pattern = "/^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$/i";
            if (!preg_match($pattern, $fieldarray['telephone'])) {
                $this->errors['telephone'] = getlanguageText('e0006'); // 'Invalid format for a telephone number.';
            } // if
        } // if

        if (!empty($fieldarray['fax'])) {
            $pattern = "/^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$/i";
            if (!preg_match($pattern, $fieldarray['fax'])) {
                $this->errors['fax'] = getlanguageText('e0007'); // 'Invalid format for a fax number.';
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

// ****************************************************************************
} // end class
// ****************************************************************************

?>
