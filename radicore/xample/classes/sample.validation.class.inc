<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
class sample_validation_class
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // custom code goes here

    } // __construct

    // ****************************************************************************
    function postcode ($input)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($input)) {
            $pattern = "^[A-Z]{1,2}[0-9]{1,2}[A-Z]{0,1} [0-9]{1}[A-Z]{2}$";
            if (!ereg($pattern, $input)) {
                // 'Invalid format for a postcode.'
                return getLanguageText('sample001');
            } // if
        } // if

        return;

    } // _cm_commonValidation

    // ****************************************************************************
    function telephone_no ($input)
    // perform validation that is common to INSERT and UPDATE.
    {
       if (!empty($input)) {
            $pattern = "^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$";
            if (!ereg($pattern, $input)) {
                // 'Invalid format for a telephone number.'
                return getLanguageText('sample002');
            } // if
        } // if

        return;

    } // telephone_no

    // ****************************************************************************
    function fax_no ($input)
    // perform validation that is common to INSERT and UPDATE.
    {
         if (!empty($input)) {
            $pattern = "^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$";
            if (!ereg($pattern, $input)) {
                // 'Invalid format for a fax number.'
                return getLanguageText('sample003');
            } // if
        } // if

        return;

    } // fax_no

// ****************************************************************************
} // end class
// ****************************************************************************

?>
