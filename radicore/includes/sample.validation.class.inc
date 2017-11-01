<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
class sample_validation_class
{
    // ****************************************************************************
    // This is an example of a custom validation class for the RADICORE framework.
    // ****************************************************************************
    // This uses the following error measages:
    //
    // $array['sample001'] = "Invalid format for a postcode.";
    // $array['sample002'] = "Invalid format for a telephone number.";
    // $array['sample003'] = "Invalid format for a fax number.";
    //
    // These messages should be added to your 'language_text.inc' file
    //
    // ****************************************************************************

    function __construct()
    {
        // custom code goes here

    } // __construct

    // ****************************************************************************
    function postcode (&$input, $fieldspec)
    // perform validation that is common to INSERT and UPDATE.
    // $input is passed BY REFERENCE as it may be changed
    {
        $input = strtoupper($input);

        if (!empty($input)) {
            $pattern = '/^'                         // begins with
                     . '('
                     . '[A-Z]{1,2}[0-9]{1,2}'       // AN, ANN, AAN, AANN
                     . '|'                          // or
                     . '[A-Z]{1}[0-9]{1}[A-Z]{1}'   // ANA
                     . '|'                          // or
                     . '[A-Z]{2}[0-9]{1}[A-Z]{1}'   // AANA
                     . ')'
                     . ' '                          // space
                     . '[0-9]{1}[A-Z]{2}'           // NAA
                     . '$/';                        // ends with
            if (!preg_match($pattern, $input)) {
                // 'Invalid format for a postcode.'
                return getLanguageText('sample001');
            } // if
        } // if

        return;

    } // postcode

    // ****************************************************************************
    function telephone_no (&$input, $fieldspec)
    // perform validation that is common to INSERT and UPDATE.
    // $input is passed BY REFERENCE as it may be changed
    {
        if (!empty($input)) {
            $pattern = "/^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$/";
            if (!preg_match($pattern, $input)) {
                // 'Invalid format for a telephone number.'
                return getLanguageText('sample002');
            } // if
        } // if

        return;

    } // telephone_no

    // ****************************************************************************
    function fax_no (&$input, $fieldspec)
    // perform validation that is common to INSERT and UPDATE.
    // $input is passed BY REFERENCE as it may be changed
    {
        if (!empty($input)) {
            $pattern = "/^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$/";
            if (!preg_match($pattern, $input)) {
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
