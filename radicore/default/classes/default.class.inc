<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class #tablename# extends Default_Table
{
    // ****************************************************************************
    function #tablename# ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = '#dbname#';
        $this->tablename   = '#tablename#';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // #tablename#

// ****************************************************************************
} // end class
// ****************************************************************************

?>
