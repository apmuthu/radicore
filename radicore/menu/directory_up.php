<?php
//*****************************************************************************
// This is a special task that will take the current directory path in $where,
// drop off the last directory and return it to the calling program.
//*****************************************************************************

require_once 'include.general.inc';

initSession();      // initialise session

if (!empty($where)) {
    $where_array = where2array($where);
    if (!empty($where_array['picker_subdir'])) {
        // strip last part of this path name
        $return_string = dirname($where_array['picker_subdir']);
    } // if
} // if

if (!empty($return_string)) {
    // send updated value back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION['pages'][$prev_script][$prev_task]['return_string'] = $return_string;
} // if
scriptPrevious(null, null, 'choose');

?>
