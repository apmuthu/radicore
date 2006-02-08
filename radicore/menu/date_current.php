<?php
//*****************************************************************************
// This is a special task that will set search criteria to select records which
// have CURRENT dates, then reurn to the previous script.
//*****************************************************************************

require_once 'include.general.inc';

initSession();      // initialise session

// send search criteria back to the previous script
$prev_script = getPreviousScript();
$prev_task   = getPreviousTask($prev_script);
$_SESSION[$prev_script][$prev_task]['search'] = "curr_or_hist='C'";
scriptPrevious(null, 'OK');

?>
