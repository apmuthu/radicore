<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// *****************************************************************************
// allows changes to be made to the $xsl_params array before it is written out
// to the XML document prior to it being transformed into HTML.
// *****************************************************************************

class custom_xsl_params
{
    // ****************************************************************************
    function __construct ()
    {
        // nothing here

        return;

    } // __construct

    // ****************************************************************************
    function amend_text ($xsl_params)
    // see if any element in the $text array needs changing
    {
        // custom code goes here

        return $xsl_params;

    } // amend_text

// ****************************************************************************
} // class: custom_xsl_params
// ****************************************************************************
?>
