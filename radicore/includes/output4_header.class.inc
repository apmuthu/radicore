<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

require_once 'std.table.class.inc';
class output4_header extends Default_Table
{
    // member variables
    var $names = array();       // array of field names

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'unknown';
        $this->tablename   = 'output4_header';

        // add fields to save or restore the selection values
        $fieldspec['button_group']          = array('type' => 'string', 'control' => 'button');
        $fieldspec['rdc_selection_desc']    = array('type' => 'string', 'size' => 80);
        $fieldspec['rdc_restore_selection'] = array('type' => 'string',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'rdc_restore_selection',
                                                    'javascript' => array('onchange' => 'this.form.submit();'));
        $fieldspec['rdc_limit']  = array('type' => 'integer', 'minvalue' => 0, 'maxvalue' => 4294967295, 'required' => 'y');
        $fieldspec['rdc_offset'] = array('type' => 'integer', 'minvalue' => 0, 'maxvalue' => 4294967295, 'required' => 'y');

        $this->fieldspec = $fieldspec;

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_customButton ($fieldarray, $button)
    // user pressed a custom button.
    {
        if (preg_match('/rdc_save_selection/i', $button)) {
            if (empty($fieldarray['rdc_selection_desc'])) {
                // "Cannot save this selection without a description"
                $this->errors['rdc_selection_desc'] = getLanguageText('sys0250');
                return $fieldarray;
            } // if
            $child_data = $this->child_object->getFieldarray();

            $this->child_object->startTransaction();
            $dbobject = RDCsingleton::getInstance('mnu_saved_selection');
            $selection_id = $dbobject->saveSelection($child_data,
                                                     $fieldarray['rdc_selection_desc'],
                                                     $_SESSION['logon_user_id'],
                                                     $GLOBALS['task_id']);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                $this->child_object->rollback();
                return $fieldarray;
            } else {
                $this->child_object->commit(false, false);
            } // if
            $output['rdc_selection_desc'] = null;  // this has been used, so clear it out
            $fieldarray['selection_id']   = $selection_id;  // allow this selection to be updated
            $fieldarray['button_group']['rdc_update_selection'] = getLanguageText('Update Selection');

        } elseif (preg_match('/rdc_update_selection/i', $button)) {
            if (empty($fieldarray['selection_id'])) {
                // "You must first make a selection before it can be updated"
                $this->errors['rdc_restore_selection'] = getLanguageText('sys0255');
                return $fieldarray;
            } // if
            if (empty($fieldarray['rdc_selection_desc'])) {
                // "Cannot save this selection without a description"
                $this->errors['rdc_selection_desc'] = getLanguageText('sys0250');
                return $fieldarray;
            } // if
            $child_data = $this->child_object->getFieldarray();

            $this->child_object->startTransaction();
            $dbobject = RDCsingleton::getInstance('mnu_saved_selection');
            $result = $dbobject->updateSavedSelection($fieldarray['selection_id'],
                                                      $child_data,
                                                      $fieldarray['rdc_selection_desc'],
                                                      $_SESSION['logon_user_id'],
                                                      $GLOBALS['task_id']);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                $this->child_object->rollback();
                return $fieldarray;
            } else {
                $this->child_object->commit(false, false);
            } // if

        } elseif (preg_match('/rdc_view_selections/i', $button)) {
            $next['user_id'] = $_SESSION['logon_user_id'];
            $next['task_id'] = $GLOBALS['task_id'];
            scriptNext('mnu_saved_selection(list2)', array2where($next));
        } // if

        $this->messages = array_merge($this->messages, $dbobject->messages);

        return $fieldarray;

    } // _cm_customButton

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (empty($fieldarray['button_group'])) {
            $fieldarray['button_group']['rdc_save_selection'] = getLanguageText('Save Selection');
            $fieldarray['rdc_selection_desc']   = null;
        } // if

        // get array from foreign table and put into LOOKUP_DATA
        $dbobject = RDCsingleton::getInstance('mnu_saved_selection');
        $array = array();
        $where1 = "user_id='{$_SESSION['logon_user_id']}' AND task_id='{$GLOBALS['task_id']}'";
        $data = $dbobject->getData($where1);
        if (!empty($data)) {
            foreach ($data as $row) {
                $array[$row['selection_id']] = $row['selection_name'];
            } // foreach
            $this->lookup_data['rdc_restore_selection'] = $array;
            $fieldarray['rdc_restore_selection'] = null;  // blank out dropdown list
            $fieldarray['button_group']['rdc_view_selections'] = getLanguageText('View Selections');
        } else {
            // there are no choices available, so do not display this control
            unset($this->lookup_data['rdc_restore_selection']);
            unset($fieldarray['rdc_restore_selection']);
            unset($fieldarray['button_group']['rdc_view_selections']);
        } // if

        if (!array_key_exists('rdc_limit', $fieldarray)) {
            $fieldarray['rdc_limit']  = 1000;
            $fieldarray['rdc_offset'] = 0;
        } // if

        if (isset($fieldarray['button_group']['rdc_view_selections'])) {
            // option selected, but does the user have permission to access this task?
            $taskobj = RDCsingleton::getInstance('mnu_task');
            $task_array = $taskobj->checkSelection('mnu_saved_selection(list2)');
            if ($taskobj->errors) {
                //$this->errors = $taskobj->errors;
                unset($fieldarray['button_group']['rdc_view_selections']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_updateFieldarray ($fieldarray, $postarray, $rownum)
    // allow object to deal with any changes POSTed from the form.
    // $fieldarray contains current data from one row.
    // $postarray contains any changes made in the form for this row.
    // $rownum identifies which row is being processed
    {
        if (!empty($postarray['rdc_restore_selection'])) {
            $child_array = array();
            $dbobject = RDCsingleton::getInstance('mnu_saved_selection_data');
            $data = $dbobject->getData("selection_id='{$postarray['rdc_restore_selection']}'");
            if (!empty($data)) {
                foreach ($data as $rownum => $rowdata) {
                    $rowdata['selected'] = $rowdata['fieldvalue'];
                    if (empty($rowdata['sort_seq'])) {
                        $rowdata['sort_seq'] = $rownum+1;  // not defined yet, so load default value
                    } // if
                    if (!preg_match('/^(rdc_)/i', $rowdata['fieldname'])) {
                        $child_array[] = $rowdata;  // not a reserved word, so use as valid data
                    } // if
                } // foreach
                // copy this data into the child object
                $result = $this->child_object->setFieldarray($child_array);
                // indicate that this selection has been loaded
                $ix = $postarray['rdc_restore_selection'];
                $fieldarray['rdc_selection_desc']    = $this->lookup_data['rdc_restore_selection'][$ix];
                $fieldarray['selection_id']          = $ix;
                $fieldarray['button_group']['rdc_update_selection'] = getLanguageText('Update Selection');
            } else {
                $fieldarray['rdc_restore_selection'] = null;  // blank out dropdown list
            } // if
        } // if

        return $fieldarray;

    } // _cm_updateFieldarray

    // ****************************************************************************
    function getFieldLabels ($fieldarray)
    // return a list of column labels that will be written out as the 1st line in the CSV file.
    {
        $child_data = $this->getChildData();  // start with current data from the child object

        $labels = array();
        $names  = array();

        foreach ($child_data as $data) {
            if (is_True($data['selected'])) {  // include only those fields which have been selected
                // check if this sequence number has already been used
                while (array_key_exists($data['sort_seq'], $labels)){
                    $data['sort_seq']++;
                } // while
                $labels[$data['sort_seq']] = $data['output_name'];
                $names[$data['sort_seq']]  = $data['fieldname'];
            } // if
        } // foreach

        $res = ksort($labels, SORT_NUMERIC);
        $res = ksort($names, SORT_NUMERIC);

        $this->names = $names;

        return $labels;

    } // getFieldLabels

    // ****************************************************************************
    function setFieldSequence ($fieldarray)
    // rearrange data so that it is in the specified sequence.
    {
        $output = array();

        foreach ($this->names as $fieldname) {
            if (isset($fieldarray[$fieldname])) {
                $output[$fieldname] = $fieldarray[$fieldname];
            } else {
                $output[$fieldname] = null;
            } // if
        } // foreach

        return $output;

    } // setFieldSequence

// ****************************************************************************
} // end output4_header
// ****************************************************************************

?>
