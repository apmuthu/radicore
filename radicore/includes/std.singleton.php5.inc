<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class RDCsingleton
// ensure that only a single instance exists for each class.
{
    static function &getInstance ($class, $arg1=null, $initialise=true, $unbuffered_query=false)
    // implements the 'singleton' design pattern.
    // $class = name of class to be instantiated.
    // $arg1 = an optional argument to pass to the class constructor (may be a string/array/whatever).
    // $initialise = if set to FALSE an existing instance will not have its initialise() method called.
    // $unbuffered_query = if set to TRUE this will create a separate instance.
    {
        static $instances = array();  // array of instance names

        if ($class == '__destruct') {
            // session is being destroyed, instances are being lost, so lose all references to them
            foreach ($instances as $key => $value) {
                $value = null;
            	unset($instances[$key]);
            } // foreach
        	$instances = array();
        	return $instances;
        } // if

        $classdir =& $GLOBALS['classdir'];  // save

        $pattern = '/^('        // begins with
                 . 'server'     // 'server'
                 . '[_]{2}'     // 2 underscores
                 . '[0-9]+'     // at least 1 digit
                 . '[_]{2}'     // 2 underscores
                 . ')/';        // ends with
        if (preg_match($pattern, $class, $regs)) {
            // $class starts with $pattern, so separate them
            $server = $regs[0];
            $class  = substr($class, strlen($server));
        } else {
            $server = null;
        } // if

        if ($unbuffered_query === true) {
            // make this part unique so that it is used only once
            $server .= 'unbuffered_';
        } // if

        if (substr_count($class, '/')) {
	        // use leading directory name as the subsystem name
	        $subsystem = basename(dirname($class));     // only one directory allowed
	    	$classname = basename($class);              // strip leading directories
	    	$filename  = "../$subsystem/classes/$classname.class.inc";
            // ensure that this subsystem is in the include plath
            $include_path = ini_get('include_path');
            $pattern = '#'              // start pattern
                     . '('              // start choice
                     . '(/|\\\)'        // '/' or '\'
                     . $subsystem       // subsystem name
                     . PATH_SEPARATOR   // ';' or ':'
                     . '|'              // or
                     . '(/|\\\)'        // '/' or '\'
                     . $subsystem       // subsystem name
                     . '$'              // ends with
                     . ')'              // end choice
                     . '#i';            // end pattern, case insensitive
            if (!preg_match($pattern, $include_path)) {
                $include_path .= PATH_SEPARATOR ."../$subsystem";
                ini_set('include_path', $include_path);
            } // if
        } else {
            $classname = $class;
            $filename  = "classes/$classname.class.inc";
	    } // if

        if (!empty($instances[$server.$classname])) {
            // instance exists in array, so use it
            $instance =& $instances[$server.$classname];
        } else {
            $cur_dir = dirname($_SERVER['SCRIPT_FILENAME']);
            if (getcwd() != $cur_dir) {
                chdir($cur_dir);  // current directory is wrong, so change it
            } // if
            // load the class file (if not already loaded)
            if (!class_exists($classname)) {
            	switch ($classname) {
                	case 'curl_class':
                		require_once 'std.curl.class.inc';
                		break;

                	case 'csv_class':
                        require_once 'std.csv.class.inc';
                        break;

                    case 'currency_class':
                        require_once 'std.currency.class.inc';
                        break;

                    case 'date_class':
                        require_once 'std.datevalidation.class.inc';
                        break;

                    case 'encryption_class':
                		require_once 'std.encryption.class.inc';
                		break;

                	case 'validation_class':
                		require_once 'std.validation.class.inc';
                		break;

                	default:
                	    require_once $filename;
                		break;
                } // switch
            } // if

            // instance does not exist, so create it
            $instances[$server.$classname] = new $classname($arg1);
            $instance =& $instances[$server.$classname];

            if (is_array($arg1)) {
                if (isset($arg1['initiated_from_controller'])) {
                    $instance->initiated_from_controller = true;
                    unset($arg1['initiated_from_controller']);
                } // if
            } // if
            if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
            	$instance->audit_logging = false;
            } // if
            $instance->unbuffered_query = $unbuffered_query;
            if ($initialise === true) {
                if (method_exists($instance, 'initialise')) {
                    // object has an 'initialise' method, so call it
                	$null = $instance->initialise($arg1);
                } // if
            } // if
        } // if

        if (method_exists($instance, 'sqlSelectInit')) {
            // initialise all sql variables
            $instance->sqlSelectInit();
        } // if

        $GLOBALS['classdir'] = $classdir;  // restore

        return $instance;

    } // getInstance

} // class: RDCsingleton

?>
