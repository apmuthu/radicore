<?php

// define subsystem function

// ****************************************************************************
function dict_findDBPrefix ($dbname)
// find the prefix which is to be used with this database name.
{
    $switch_dbnames = array();

    if (!empty($GLOBALS['servers'])) {
	    foreach ($GLOBALS['servers'] as $server) {
	        if ($server['dbnames'] == '*') {
	            // any dbname not previously specified
	        	$dbprefix = $server['dbprefix'];
	        	break;
	        } else {
	            // convert list of dbnames into an array
	            $dbname_array = explode(',', $server['dbnames']);
                $dbname_array = array_map('trim', $dbname_array);
                if (in_array($dbname, $dbname_array)) {
                	$dbprefix = $server['dbprefix'];
                    if (!empty($server['switch_dbnames']) AND is_array($server['switch_dbnames'])) {
                        $switch_dbnames = array_merge($switch_dbnames, $server['switch_dbnames']);
                    } // if
	        	    break;
                } // if
	        } // if
	    } // foreach
    } // if

    if (!empty($switch_dbnames)) {
        if (array_key_exists($dbname, $switch_dbnames)) {
            // dbname in the data dictionary is different from the name on the server
            $dbname = $switch_dbnames[$dbname];
        } // if
    } // if

    if (!isset($dbprefix)) {
        if (!empty($GLOBALS['dbprefix'])) {
            $dbprefix =& $GLOBALS['dbprefix'];  // default to global setting
        } else {
            $dbprefix = '';                     // no setting defined
        } // if
    } // if

    return array($dbprefix, $dbname);

} // dict_findDBPrefix

?>