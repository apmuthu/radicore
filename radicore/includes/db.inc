<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// *****************************************************************************

// This file contains database access details and the standard connection function
$dbms   = 'mysql';      // database engine is MySQL
$dbhost = 'localhost';

// NOTE: $dbprefiix is for my web host (shared) where my databases are prefixed
// with my account name to keep them separate from other accounts.

if ($_SERVER['SERVER_NAME'] == 'localhost'
or  $_SERVER['SERVER_NAME'] == 'desktop'
or  $_SERVER['SERVER_NAME'] == 'laptop') {
    // this is for my PC
    $dbusername = 'tony';
    $dbuserpass = 'tony';
    $dbprefix   = null;
} else {
    // this is for my shared web host
    $dbusername = 'radicore_radicor';
    $dbuserpass = 'GrungeBunny';
    $dbprefix   = 'radicore_';
} // if

$dbconnect   = null;

function db_connect($dbname)
// connect to the database and/or select database name
{
    global $dbconnect, $dbhost, $dbusername, $dbuserpass, $dbprefix;

    $dbname = $dbprefix . $dbname;

    if (function_exists('mysqli_connect')) {
        // use 'improved' mysql functions
        if (!$dbconnect) $dbconnect = mysqli_connect($dbhost, $dbusername, $dbuserpass);
        if (!$dbconnect) {
            return 0;
        } elseif (!mysqli_select_db($dbconnect, $dbname)) {
            return 0;
        } else {
            return $dbconnect;
        } // if
    } else {
        // use standard mysql functions
        if (!$dbconnect) $dbconnect = mysql_connect($dbhost, $dbusername, $dbuserpass);
        if (!$dbconnect) {
            return 0;
        } elseif (!mysql_select_db($dbname)) {
            return 0;
        } else {
            return $dbconnect;
        } // if
    } // if

} // db_connect

if (version_compare(phpversion(), '5.0.0', '<')) {
    // these do not exist in PHP 4, so define them manually
    define('E_STRICT', 2048);
    define('E_RECOVERABLE_ERROR', 4096);
} // if


?>