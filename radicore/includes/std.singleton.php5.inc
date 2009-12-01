<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class singleton
// ensure that only a single instance exists for each class.
{
    static function &getInstance ($class, $arg1=null, $initialise=true)
    // implements the 'singleton' design pattern.
    {
        static $instances = array();  // array of instance names

        $pattern = '/^('        // begins with
                 . 'server'     // 'server'
                 . '[_]{2}'     // 2 underscores
                 . '[0-9]+'     // at least 1 digit
                 . '[_]{2}'     // 2 underscores
                 . ')/';        // 2 underscores
        if (preg_match($pattern, $class, $regs)) {
            // $class starts with $pattern, so separate them
            $server = $regs[0];
            $class  = substr($class, strlen($server));
        } else {
            $server = null;
        } // if

        if (substr_count($class, '/')) {
	        // strip leading directory names
	        $pos = strrpos($class, '/');
	    	$classname = substr($class, $pos+1);
	    	$filename  = "classes/$class.class.inc";
        } else {
            $classname = $class;
            $filename  = "classes/$class.class.inc";
	    } // if

        if (!empty($instances[$server.$classname])) {
            // instance exists in array, so use it
            $instance =& $instances[$server.$classname];
            if (method_exists($instance, 'sqlSelectInit')) {
                // initialise all sql selection criteria
            	$instance->sqlSelectInit();
            } // if
        } else {
            // load the class file (if not already loaded)
            if (!class_exists($classname)) {
            	switch ($classname) {
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

        return $instance;

    } // getInstance

} // singleton

?>
