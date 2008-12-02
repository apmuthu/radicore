<?php
//*****************************************************************************
// This is a special task that will set search criteria to a particular value,
// then return to the previous script.
//*****************************************************************************

require_once 'include.general.inc';

initSession();      // initialise session

// send search criteria back to the previous script
$prev_script = getPreviousScript();
$prev_task   = getPreviousTask($prev_script);
$_SESSION['pages'][$prev_script][$prev_task]['search'] = "curr_or_hist='H'";
// Date range has been set to HISTORIC
scriptPrevious(null, getLanguageText('sys0096'));

?>
