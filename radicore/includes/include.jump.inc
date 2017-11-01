<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains functions which jump between one key and another in an
// array of primary keys which is maintained in $this->scrollarray which is
// used in transaction pattern MULTI1.

// $this->scrollarray contains an indexed array of primary keys which the MULTI1
// task will step through one at a time and enable each record associated with
// that key to be either inserted, updated or deleted as required by the user.

// in some cases, such as in the Survey/Questionnaire prototype, an answer to one
// question in the series may cause a jump to a question which is much later in
// the series. Each of these jumps will be recorded as an entry in $jumparray
// which has two values - jump_from and jump_to - which are the index numbers to
// the primary keys in this->scrollarray. All keys between these two jump points
// are therefore to be considered as invalid, in quarantine or in a no-fly zone.

// note that it would not be a good idea to remove the jumped-over keys from
// $this->scrollarray as it would always be possible to to back to the record
// which caused the jump and change its value, which would either cancel the jump
// or provide a different jump-to point.

// note also that it is possible for a single survey/questionnaire to contain
// any number of jumps.

// ****************************************************************************
function addJump ($jump_from, $jump_to)
// add this pair of jump points to the jumparray.
// each point is a key in $this->scrollarray.
{
    global $script_vars;

    // retrieve existing array from session area
    if (isset($script_vars['jumparray'])) {
        $jumparray = $script_vars['jumparray'];
    } else {
        $jumparray = array();
    } // if

    foreach ($jumparray as $key => $jump) {
        if ($jump['jump_from'] == $jump_from) {
            // entry found, so delete it
            unset($jumparray[$key]);
        } // if
    } // if

    // append ths new pair of 'jumpto' values
    $jumparray[] = array('jump_from' => (int)$jump_from,
                         'jump_to' => (int)$jump_to);

    // save modified array in session area
    $script_vars['jumparray'] = $jumparray;

    return;

} // addJump

// ****************************************************************************
function clearJump ($index)
// find out if selected $index is the 'jump_from' value in a pair of jump points.
// if it is then the entire pair must be removed from the jumparray.
{
    global $script_vars;

    if (isset($script_vars['jumparray'])) {
        $jumparray = $script_vars['jumparray'];
        // note: $jumparray may contain more than one 'from/to' pairs
        if (count($jumparray) > 0) {
            // see if there is an entry which covers the current $index
            foreach ($jumparray as $key => $jump) {
                if ($jump['jump_from'] == $index) {
                    // entry found, so delete it
                    unset($jumparray[$key]);
                    // store updated array for use later
                    $script_vars['jumparray'] = $jumparray;
                } // if
            } // foreach
        } // if
    } // if

    return;

} // clearJump

// ****************************************************************************
function findJump ($index, $prev_index)
// find out if selected $index falls between a pair of jump points.
// if it does then it must be adjusted.
// $prev_index is the value of $index in the previous iteration.
{
    global $script_vars;

    if (isset($script_vars['jumparray'])) {
        $jumparray = $script_vars['jumparray'];
        // note: $jumparray may contain more than one 'from/to' pair
        if (count($jumparray) > 0) {
            // see if there is an entry which covers the current $index
            foreach ($jumparray as $jump) {
                if ($jump['jump_from'] < $index AND $jump['jump_to'] > $index) {
                    if ($prev_index == $jump['jump_from']) {
                        // jump forwards to the end point
                        $index = $jump['jump_to'];
                    } else {
                        // jump backwards to the start point
                        $index = $jump['jump_from'];
                    } // if
                } // if
            } // foreach
        } // if
    } // if

    return (int)$index;

} // findJump

// ****************************************************************************
?>
