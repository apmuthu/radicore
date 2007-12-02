<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class singleton
// ensure that only a single instance exists for each class.
{
    static function &getInstance ($class, $arg1=null)
    // implements the 'singleton' design pattern.
    {
        static $instances = array();  // array of instance names

        if (array_key_exists($class, $instances)) {
            // instance exists in array, so use it
            $instance =& $instances[$class];
            if (method_exists($instance, 'sqlSelectInit')) {
                // initialise all sql selection criteria
            	$instance->sqlSelectInit();
            } // if
        } else {
            // load the class file (if not already loaded)
            if (!class_exists($class)) {
            	switch ($class) {
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
                	    require_once "classes/$class.class.inc";
                		break;
                } // switch
            } // if

            // instance does not exist, so create it
            $instances[$class] = new $class($arg1);
            $instance =& $instances[$class];
            if (method_exists($instance, 'initialise')) {
                // object has an 'initialise' method, so call it
            	$null = $instance->initialise($arg1);
            } // if
        } // if

        return $instance;

    } // getInstance

} // singleton

?>