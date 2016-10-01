<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class ldap_class
{
    // member variables
    var $resource;              // resource

    // ****************************************************************************
    function __construct ()
    {
        if (!extension_loaded('ldap')) {
    		trigger_error("LDAP extension is not loaded", E_USER_ERROR);
    	} // if

        require 'ldap.config.inc';

        if (!$this->resource = @ldap_connect($ldap_host, $ldap_port)) {
            // "Cannot connect to LDAP host"
            trigger_error(getLanguageText('sys0175'), E_USER_ERROR);
        } // if

        return;

    } // __construct

    // ****************************************************************************
    function authenticate ($username, $password)
    // check if this username and password are valid.
    {
        @ldap_set_option($ld, LDAP_OPT_PROTOCOL_VERSION, 3);
        $result = @ldap_bind($this->resource, $username, $password);

        if (!$result) {
		    $errno = ldap_errno($this->resource);
		    $error = ldap_error($this->resource);
		    $result = $errno .' - ' .$error;
        } // if

        ldap_close($this->resource);

        return $result;

    } // authenticate

} // ldap_class
?>
