<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class branch extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function branch ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'branch';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // branch

// ****************************************************************************
} // end class
// ****************************************************************************

?>
