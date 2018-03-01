<?php
//*****************************************************************************
// This is a special task that will set search criteria to a particular value,
// then return to the previous script.
//*****************************************************************************

require_once 'include.general.inc';

initSession();      // initialise session

// retrieve and modify current search criteria
$search_array = where2array($search, null, false);
$search_array['curr_or_hist'] = 'A';
$search  = array2where($search_array);
$message = getLanguageText('sys0270');  // Date range has been set to ALL

// send search criteria back to the previous script
$prev_script = getPreviousScript();
$prev_task   = getPreviousTask($prev_script);
$_SESSION['pages'][$prev_script][$prev_task]['search'] = $search;
scriptPrevious(null, $message);

?>
