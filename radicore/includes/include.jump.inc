<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains functions which jump between one key and another in an
// array of primary keys.

// ****************************************************************************
function addJump ($jump_from, $jump_to)
// add this pair of jump points to the jumparray.
{
    // DebugBreak();
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
    // DebugBreak();
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
    // DebugBreak();
    global $script_vars;

    if (isset($script_vars['jumparray'])) {
        $jumparray = $script_vars['jumparray'];
        // note: $jumparray may contain more than one 'from/to' pairs
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