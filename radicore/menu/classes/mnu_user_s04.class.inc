<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user.class.inc';
class mnu_user_s04 extends mnu_user
{
    // ****************************************************************************
    // This class is for use by script: mnu_todo_list2.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        // customisable code goes here
        if (empty($where)) {
            // called from the menu/home page, so supply a default value
        	$where = "user_id='{$_SESSION['logon_user_id']}'";
        } // if

        return $where;

    } // _cm_initialise

// ****************************************************************************
} // end class
// ****************************************************************************

?>
