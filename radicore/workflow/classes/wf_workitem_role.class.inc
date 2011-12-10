<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'wf_workitem.class.inc';
class wf_workitem_role extends wf_workitem
{
    // ****************************************************************************
    // This is used in home.php/menu.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        $dirname = dirname($this->dirname) ."/classes/custom-processing/";
        $fname = $dirname .'cp_' .get_class($this) .'.class.inc';
        if (file_exists($fname)) {
            $class_name = 'cp_' .get_class($this);
            if (!class_exists($class_name)) {
            	include_once($fname);
            } // if
            if (class_exists($class_name)) {
                $object = new $class_name;

                $rows = $object->_cm_post_getData ($rows, $where);

            } // if
        } // if

        return $rows;

    } // _cm_post_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
