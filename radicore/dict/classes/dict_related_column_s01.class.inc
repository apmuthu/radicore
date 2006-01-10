<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_related_column.class.inc';
class dict_related_column_s01 extends dict_related_column
{

    // ****************************************************************************
    // this subclass is used to import existing column names for a selected table
    // ****************************************************************************

    function _cm_pre_updateMultiple ($fieldarray)
    // perform custom processing before multiple database records are updated.
    {
        //DebugBreak();
        // change field to REQUIRED (NOT NULL)
        $this->fieldspec['column_id_jnr']['required'] = 'y';

        return $fieldarray;

    } // _cm_pre_updateMultiple

// ****************************************************************************
} // end class
// ****************************************************************************

?>
