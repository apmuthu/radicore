<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains functions for the SwiftMailer library

// ****************************************************************************
function SWIFT_email_address2array ($addr_string)
// return a string of email address(es) into an array.
{
    // multiple address are separated by ','
    $array = explode(',', $addr_string);
    foreach ($array as $ix => $element) {
        if (strpos($element, '@') === false) {
            // does not contain an '@' sign, so add it to the start of the next element
            $prefix = $element.',';
            unset($array[$ix]);
        } // if
        if (isset($array[$ix]) AND !empty($prefix)) {
            // prefix this element with contents of previous element
            $array[$ix] = $prefix.$array[$ix];
            $prefix = null;
        } // if
    } // foreach
    foreach ($array as $value) {
        $value = trim($value);
        if (strpos($value, '<') AND preg_match_all('/(.+(?=<)|<[^>]*>)/', $value, $regs)) {
            // format = 'name <address>'
            $name = $regs[0][0];
            $addr = trim($regs[0][1], '<>');
            $addr_array[$addr] = $name;
        } else {
            $addr_array[] = $value;
        } // if
    } // foreach

    return $addr_array;

} // SWIFT_email_address2array
?>