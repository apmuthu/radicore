<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_subsystem extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_subsystem ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'mnu_subsystem';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_subsystem

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (strpos($fieldarray['subsys_dir'], '/') or strpos($fieldarray['subsys_dir'], '\\')) {
            // only a single directory name is required
            $this->errors['subsys_dir'] = getLanguageText('e0034');
        } // if

//        if (!is_dir('../' .$fieldarray['subsys_dir'])) {
//            // Directory name does not exist
//            $this->errors['subsys_dir'] = getLanguageText('e0035');
//        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
//        if ($fieldarray['count'] <= 50) {
//            $css_array['count'] = 'red';
//            $css_array['subsys_desc'] = 'red';
//        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $pattern_id = getPatternId();

        if (preg_match('/^(list1)$/i', $pattern_id)
        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
                // set list of field names for QuickSearch option
                $array = array('subsys_id' => 'Subsys Id',
                               'subsys_desc' => 'Subsys Desc',
                               'subsys_dir' => 'Subsys Directory',
                               'task_prefix' => 'Task Prefix');
                $this->lookup_data['quicksearch_field'] = $array;
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'subsys_id') {
            // get data from the database
            $this->sql_select     = 'subsys_id, subsys_desc';
            $this->sql_orderby    = 'subsys_desc';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['subsys_desc'] = 'Total count for all Subsystems:';
        $array['count'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count += $fieldarray['count'];
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {
        // no logging for this 'erase'
        $this->audit_logging = false;

        // replace standard code (which is slow) with this hard-coded turbo version
        $dbobject =& RDCsingleton::getInstance('mnu_task');
        $selection ="mnu_task.subsys_id='{$fieldarray['subsys_id']}'";
        $resource = $dbobject->getData_serial($selection);

        $count = 0;
        $child_count = 0;
        while ($row = $dbobject->fetchRow($resource)){
            $from = 'mnu_task
, help_text
, mnu_favourite
, mnu_initial_value_role
, mnu_initial_value_user
, menu_snr
, menu_jnr
, nav_button_snr
, nav_button_jnr
, mnu_role
, mnu_role_task
, mnu_role_taskfield
, mnu_task_field
, mnu_task_ip_address
, mnu_todo';
            $using = 'mnu_task
LEFT JOIN help_text ON (help_text.task_id=mnu_task.task_id)
LEFT JOIN mnu_favourite ON (mnu_favourite.task_id=mnu_task.task_id)
LEFT JOIN mnu_initial_value_role ON (mnu_initial_value_role.task_id=mnu_task.task_id)
LEFT JOIN mnu_initial_value_user ON (mnu_initial_value_user.task_id=mnu_task.task_id)
LEFT JOIN mnu_menu AS menu_snr ON (menu_snr.menu_id=mnu_task.task_id)
LEFT JOIN mnu_menu AS menu_jnr ON (menu_jnr.task_id_jnr=mnu_task.task_id)
LEFT JOIN mnu_nav_button AS nav_button_snr ON (nav_button_snr.task_id_snr=mnu_task.task_id)
LEFT JOIN mnu_nav_button AS nav_button_jnr ON (nav_button_jnr.task_id_jnr=mnu_task.task_id)
LEFT JOIN mnu_role ON (mnu_role.start_task_id=mnu_task.task_id)
LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_task.task_id)
LEFT JOIN mnu_role_taskfield ON (mnu_role_taskfield.task_id=mnu_task.task_id)
LEFT JOIN mnu_task_field ON (mnu_task_field.task_id=mnu_task.task_id)
LEFT JOIN mnu_task_ip_address ON (mnu_task_ip_address.task_id=mnu_task.task_id)
LEFT JOIN mnu_todo ON (mnu_todo.task_id=mnu_task.task_id)';

            $selection ="mnu_task.task_id='{$row['task_id']}'";
            $sub_count = $this->_dml_deleteSelection($selection, $from, $using);
            $child_count = $child_count + $sub_count;
            $count++;
        } // while

        $dbobject =& RDCsingleton::getInstance('mnu_control');
        $result = $dbobject->_dml_deleteSelection("record_id='{$fieldarray['subsys_id']}'");

        $this->messages[] = "$count task records have been deleted";
        $this->messages[] = "$child_count child records have been deleted";

        // LEFT JOIN mnu_control ON (mnu_control.record_id=mnu_subsystem.subsys_id)';

        return $fieldarray;

    } // _cm_pre_eraseRecord

    // ****************************************************************************
    function _cm_validateInsert ($rowdata)
    // perform custom validation before an insert.
    // if anything is placed in $this->errors the insert will be terminated.
    {
//        $this->errors['subsys_id'] = 'dummy message for subsys_id';
//        $this->errors[] = "This message is not associated with a field";
//        $this->errors['foobar'] = "error message concerning 'foobar'";
//        $this->errors['barfoo'] = "error message concerning 'barfoo'";
//        $this->errors['internal-class']['foobar'] = "error message concerning '[x]foobar'";
//        $this->errors['internal-class'][1] = "error message concerning '[x][1]foobar'";
//        $this->errors[2]['foobar'] = "error message concerning '[2]foobar'";
//        $this->errors['subsys_desc'] = 'dummy message for subsys_desc';

        return $rowdata;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
