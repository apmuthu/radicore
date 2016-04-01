<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains database access details and the standard connection function
$GLOBALS['dbms']   = 'mysql';       // database engine is MySQL
//$GLOBALS['dbms']   = 'pgsql';      // database engine is PostgreSQL
//$GLOBALS['dbms']   = 'oracle';     // database engine is Oracle
//$GLOBALS['dbms']   = 'sqlsrv';     // database engine is SQL Server (Microsoft)

if ($GLOBALS['dbms'] == 'oracle') {
    $GLOBALS['dbhost']   = '//localhost/xe';
    $GLOBALS['dbprefix'] = '';

} elseif ($GLOBALS['dbms'] == 'sqlsrv') {
    // JOIN clauses in SQL Server require 'dbname.<schema>.tblname'
    $GLOBALS['dbhost']         = 'localhost';
    $GLOBALS['dbprefix']       = '';
    $GLOBALS['SQLSRV_schema']  = 'dbo';
    $GLOBALS['serverName']     = '(local)';
    $GLOBALS['connectionInfo'] = array('CharacterSet' => 'UTF-8',
                                       'ReturnDatesAsStrings' => true);

} elseif ($GLOBALS['dbms'] == 'pgsql') {
    // NOTE: with MYSQL there are tables withing databases, and within a single connection
    // it is possible to access tables in any database.
    // But with PostgreSQL there are tables within schemas within databases, and within
    // a single connection it is only possible to access a single database, but any number
    // of schemas within that database.
    // When using PostgreSQL you must supply a value for $PGSQL_dbname for the single database
    // connection, and what is known as 'dbname' to MySQL becomes 'schema' to PostgreSQL.
    $GLOBALS['dbhost']       = 'localhost';
    $GLOBALS['dbprefix']     = '';
    $GLOBALS['PGSQL_dbname'] = 'radicore';

} else {
    $GLOBALS['dbhost']   = 'localhost';
    $GLOBALS['dbprefix'] = 'demo_';
} // if

// NOTE: $dbprefix is for my web host (shared) where my databases are prefixed
// with my account name to keep them separate from other accounts.

if (preg_match('/^(local\.radicore\.org|127.0.0.1|localhost|desktop|laptop)$/i', $_SERVER['SERVER_NAME'])) {
    // this is for my PC
    global $servers;
    // server 0
    $servers[0]['dbhost']     = $GLOBALS['dbhost'];
    $servers[0]['dbengine']   = $GLOBALS['dbms'];
    if (isset($GLOBALS['SQLSRV_schema'])) {
        $servers[0]['SQLSRV_schema']   = $GLOBALS['SQLSRV_schema'];
        $servers[0]['serverName']      = $GLOBALS['serverName'];
        $servers[0]['connectionInfo']  = $GLOBALS['connectionInfo'];
    } // if
    if (isset($GLOBALS['PGSQL_dbname'])) {
        $servers[0]['PGSQL_dbname']   = $GLOBALS['PGSQL_dbname'];
    } // if
    $servers[0]['dbusername'] = 'tony';
    $servers[0]['dbuserpass'] = 'tony';
    $servers[0]['dbport']     = '';
    $servers[0]['dbsocket']   = '';
    $servers[0]['dbprefix']   = $GLOBALS['dbprefix'];
    $servers[0]['dbnames']    = 'audit,radicore,menu,dict,workflow,classroom,product,survey,xample';

    // server 1
    $servers[1]['dbhost']     = $GLOBALS['dbhost'];
    $servers[1]['dbengine']   = $GLOBALS['dbms'];
    $servers[1]['dbusername'] = 'tony';
    $servers[1]['dbuserpass'] = 'tony';
    $servers[1]['dbport']     = '';
    $servers[1]['dbsocket']   = '';
    $servers[1]['dbprefix']   = '';
    $servers[1]['dbnames']    = '*';

    // set these only if secure HTTPS protocol is available on your server
    $GLOBALS['http_server']  = 'local.radicore.org';
    $GLOBALS['https_server'] = 'local.radicore.org';
    $GLOBALS['https_server_suffix'] = '';
    //define('HTTPS_NOT_FOR_FILES', true);

} else {
    // this is for my shared web host
    $GLOBALS['dbusername'] = 'radicore_radicor';
    $GLOBALS['dbuserpass'] = 'GrungeBunny';
    $GLOBALS['dbprefix']   = 'radicore_';
    $GLOBALS['http_server']  = 'www.radicore.org';
    // set these only if secure HTTPS protocol is available on your server
    $GLOBALS['https_server']        = '';
    $GLOBALS['https_server_suffix'] = '';

    //$GLOBALS['https_server'] = 'starburst.secureguards.com/~radicore';
    //$GLOBALS['https_server'] = 'titan.secureguards.com/~radicore';
    //$GLOBALS['https_server'] = 'neutrino.secureguards.com/~radicore';
    $GLOBALS['https_server']        = 'fire.secureguards.com/~radicore';
    $GLOBALS['https_server_suffix'] = '/~radicore';

    // define this only if content such as CSS or JS files are not to be referenced using HTTPS
    //define('HTTPS_NOT_FOR_FILES', true);
    // converts datetime between client and server timezones (PHP version >= 5.2)
    $GLOBALS['server_timezone'] = 'America/New_York';
    date_default_timezone_set('America/New_York');
} // if

// set this to true if you want all XSL transformations to be done by the client
// (NOTE: only valid if supported by your client browser)
$GLOBALS['XSLT_client_side'] = false;

// set this to TRUE to write all sql queries to file 'sql/<script_id>.sql' (for debugging)
$GLOBALS['log_sql_query'] = false;

// set date format - choose one of te following
$GLOBALS['date_format'] = 'dmy';
//$GLOBALS['date_format'] = 'mdy';
//$GLOBALS['date_format'] = 'ymd';

// set this to TRUE to write all XML documents to file 'xsl/<script_id>.xml' (for debugging)
if (preg_match('/^(local\.radicore\.org|localhost|desktop|laptop)$/i', $_SERVER['SERVER_NAME'])
or $_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
    $GLOBALS['log_xml_document'] = true;
} else {
    $GLOBALS['log_xml_document'] = false;
} // if

// use HTTPS for all web pages
$GLOBALS['use_https'] = false;

// use to access files in the 'classes/custom-processing/<project>/' folder
//$GLOBALS['project_code'] = 'unknown';

// redirect all outgoing emails to this address
define('MAIL_TO_REDIRECT', 'tony@marston-home.demon.co.uk');

// defines email address(es) to which any error_log will be sent
define('ERROR_LOG_MAILTO', 'tony@marston-home.demon.co.uk, tonymarston@hotmail.com');

// defines directory into which error logs will be written
define('ERROR_LOG_DIR', $_SERVER['DOCUMENT_ROOT'].'/demo/error_logs');

if (preg_match('/^(local\.)/i', $_SERVER['SERVER_NAME'])
OR $_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
    // causes the logstuff() function to write details to the log file
    //define('LOGSTUFF', true);
} // if

?>