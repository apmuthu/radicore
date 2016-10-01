<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_task_ip_address extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_task_ip_address';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($fieldarray['ip_address'])) { //If ip_address is not empty
            if (filter_var($fieldarray['ip_address'], FILTER_VALIDATE_IP) === false) {
                // "This is not a valid IP address"
                $this->errors['ip_address'] = getLanguageText('sys0207');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

// ****************************************************************************
} // end class
// ****************************************************************************

?>
