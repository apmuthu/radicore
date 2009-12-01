<?php

// define subsystem function

// ****************************************************************************
function dict_findDBPrefix ($dbname)
// find the prefix which is to be used with this database name.
{
    if (!empty($GLOBALS['servers'])) {
	    foreach ($GLOBALS['servers'] as $server) {
	        if ($server['dbnames'] == '*') {
	            // any dbname not previously specified
	        	$dbprefix = $server['dbprefix'];
	        	break;
	        } else {
	            // convert list of dbnames into an array
	            $dbname_array = explode(',', $server['dbnames']);
                if (in_array($dbname, $dbname_array)) {
                	$dbprefix = $server['dbprefix'];
	        	    break;
                } // if
	        } // if
	    } // foreach
    } else {
        $dbprefix = $GLOBALS['dbprefix'];
    } // if

    return $dbprefix;

} // dict_findDBPrefix

?>