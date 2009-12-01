<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class audit_fld extends Default_Table
{
    // ****************************************************************************
    function audit_fld ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'audit';
        $this->tablename   = 'audit_fld';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

        // there is absolutely NO logging of the audit database
        // (otherwise there would be an endless loop)
        $this->audit_logging = false;

    } // audit_fld

// ****************************************************************************
} // end class
// ****************************************************************************

?>
