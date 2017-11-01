<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_s03 extends mnu_task
{
    // ****************************************************************************
    // this class is for use by script: mnu_task_(pdf)3.php
    // purpose: to print nav_button details for each task
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->sql_select = 'task_id, task_name, task_type, count(task_id_snr) AS button_count';
        $this->sql_from   = 'mnu_task '
                          . 'LEFT JOIN mnu_nav_button ON (mnu_nav_button.task_id_snr=mnu_task.task_id) ';
        $this->sql_groupby = 'task_id, task_name, task_type ';
        $this->sql_having = 'button_count > 0';

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        if (strtoupper($fieldarray['task_type']) != 'PROC') {
            return false;
        } // if

        switch ($name) {
        	case 'multi1':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi2':
                // retrieve associated data from MNU_MENU table
                $object = RDCsingleton::getInstance('mnu_nav_button');
                $task_id  = $fieldarray['task_id'];
                $object->sql_orderby = 'sort_seq asc';
                $outarray = $object->getData("task_id_snr='$task_id'");
                if (empty($outarray)) {
                    // print an empty line
                    $outarray[] = array('dummy' => '');
                } // if

        		break;

        	case 'multi3':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi4':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi5':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi6':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi7':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi8':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi9':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	default:
        		break;
        } // switch

        if ($outarray) {
        	return $outarray;
        } else {
            return false;
        } // if

    } // _cm_output_multi

// ****************************************************************************
} // end class
// ****************************************************************************

?>
