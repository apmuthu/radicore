<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2013 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_dummy extends x_person
{

    // ****************************************************************************
    // This subclass is used in script person(multi5).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // assign values to fields which appear in the screen
        $this->fieldarray['pers_type_id'] = null;
        $this->fieldarray['star_sign'] = null;

        return $where;

    } // _cm_initialise

// ****************************************************************************
} // end class
// ****************************************************************************

?>
