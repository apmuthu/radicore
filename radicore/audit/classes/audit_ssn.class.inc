<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class audit_ssn extends Default_Table
{
    // ****************************************************************************
    function audit_ssn ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'audit';
        $this->tablename   = 'audit_ssn';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

        // there is absolutely NO logging of the audit database
        // (otherwise there would be an endless loop)
        $this->audit_logging = false;

    } // audit_ssn

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!isset($fieldarray['user_id'])) {
            $fieldarray['user_id']  = $_SESSION['logon_user_id'];
            $fieldarray['ssn_date'] = getTimeStamp('date');
            $fieldarray['ssn_time'] = getTimeStamp('time');
        } // if

        return $fieldarray;

    } // _cm_getInitialData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
