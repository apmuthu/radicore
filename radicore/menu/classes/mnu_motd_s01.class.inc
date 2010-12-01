<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_motd.class.inc';
class mnu_motd_s01 extends mnu_motd
{
    // ****************************************************************************
    // this subtype is used in: mnu_motd(show)
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this button is redundant
        unset($GLOBALS['act_buttons']['copy']);

        return $fieldarray;

    } // _cm_changeConfig

// ****************************************************************************
} // end class
// ****************************************************************************

?>
