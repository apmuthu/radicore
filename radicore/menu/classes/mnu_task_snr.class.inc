<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_snr extends mnu_task
{
    // ****************************************************************************
    // This is a subtype (alias) which allows multiple copies of the same table
    // to appear in different places within an XML document.
    // ****************************************************************************

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        switch (basename($_SERVER['PHP_SELF'])) {
            case 'mnu_nav_button_list.php':
            case 'mnu_nav_button_multi.php':
            case 'mnu_nav_button_link.php':
                if ($rowdata[0]['task_type'] != 'PROC') {
                    $this->errors = getLanguageText('e0021'); // "This function is only valid if TASK_TYPE='PROC'";
                } // if
                break;
            case 'mnu_menu_list.php':
            case 'mnu_menu_multi.php':
            case 'mnu_menu_link.php':
                if ($rowdata[0]['task_type'] != 'MENU') {
                    $this->errors = getLanguageText('e0024'); // "This function is only valid if TASK_TYPE='MENU'";
                } // if
                break;
            default:
                ;
        } // switch

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // change fieldname in $where from 'menu_id' to 'task_id'
        $where = str_replace('menu_id=', 'task_id=', $where);
        $where = str_replace('task_id_snr=', 'task_id=', $where);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
