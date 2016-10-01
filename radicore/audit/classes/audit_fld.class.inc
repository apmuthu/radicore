<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class audit_fld extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'audit';
        $this->tablename   = 'audit_fld';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

        // there is absolutely NO logging of the audit database
        // (otherwise there would be an endless loop)
        $this->audit_logging = false;

    } // __construct

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        $max_size = $this->fieldspec['new_value']['size'];
        if (strlen($rowdata['old_value']) > $max_size) {
            // truncate value in order to avoid a validation error
        	$rowdata['old_value'] = substr($rowdata['old_value'], 0, $max_size);
        } // if
        if (strlen($rowdata['new_value']) > $max_size) {
            // truncate value in order to avoid a validation error
        	$rowdata['new_value'] = substr($rowdata['new_value'], 0, $max_size);
        } // if

        return $rowdata;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
