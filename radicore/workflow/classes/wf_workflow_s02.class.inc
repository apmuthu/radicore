<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'wf_workflow.class.inc';
class wf_workflow_s02 extends wf_workflow
{
    // ****************************************************************************
    // this subclass copies a workflow process
    // ****************************************************************************

    var $old_workflow_id;       // entry to be copied
    var $valid_tables;          // child tables to be copied

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $this->fieldspec['workflow_name']['noedit'] = 'y';
        $this->fieldspec['revision_id']['noedit']   = 'y';

        if (!array_key_exists('old_workflow_id', $this->fieldspec)) {
            $this->fieldspec['old_workflow_id'] = $this->fieldspec['workflow_id'];
            $this->fieldspec['old_workflow_id']['nondb'] = 'y';
            $this->fieldspec['old_workflow_id']['noedit'] = 'y';
            unset($this->fieldspec['old_workflow_id']['pkey']);
        } // if

        if (!array_key_exists('new_workflow_id', $this->fieldspec)) {
            $this->fieldspec['new_workflow_id'] = $this->fieldspec['workflow_id'];
            $this->fieldspec['new_workflow_id']['nondb'] = 'y';
            unset($this->fieldspec['new_workflow_id']['pkey']);
        } // if
        if (!array_key_exists('new_revision_id', $this->fieldspec)) {
            $this->fieldspec['new_revision_id'] = $this->fieldspec['revision_id'];
            $this->fieldspec['new_revision_id']['nondb'] = 'y';
            unset($this->fieldspec['new_revision_id']['noedit']);
        } // if

        // this button causes confusion, so remove it
        unset($GLOBALS['act_buttons']['submitstay']);

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (empty($fieldarray['workflow_name'])) {
            // check that a single workflow has been selected
            $this->checkPrimaryKey = true;
            if (empty($where)) {
                $where = "workflow_id='".addslashes($fieldarray['workflow_id'])."'";
            } // if
            $data = $this->getData($where);
            if (count($data) <> 1) {
                // "Nothing has been selected yet"
                $this->errors[] = getLanguageText('sys0081');
            } else {
                $fieldarray = array_merge($fieldarray, $data[0]);
                $this->old_workflow_id = $fieldarray['workflow_id'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign entities.
    {
        // this is here to override the method in the parent class

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing prior to insertRecord().
    // $fieldarray contains data from the initial $where clause.
    {
        if (!isset($fieldarray['old_workflow_id'])) {
            $fieldarray['old_workflow_id'] = $fieldarray['workflow_id'];
        } // if
        if (!isset($fieldarray['new_workflow_id'])) {
            $fieldarray['new_workflow_id'] = null;
        } // if
        if (!isset($fieldarray['new_revision_id'])) {
            $fieldarray['new_revision_id'] = null;
        } // if

        // set workflow_id to next available number
        $count = $this->getCount("SELECT max(workflow_id) FROM $this->tablename");
        $fieldarray['new_workflow_id'] = $count + 1;

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        // use $selection instead of $where
        $where = $selection;
        $selection = null;

        $where = parent::_cm_initialise ($where, $selection, $search);

        // not all child tables can be copied, only these
        $this->valid_tables[] = 'wf_arc';
        $this->valid_tables[] = 'wf_place';
        $this->valid_tables[] = 'wf_transition';

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        $where = "workflow_id='$this->old_workflow_id'";
        $new_workflow_id = $rowdata['workflow_id'];

        $today = getTimeStamp('date');

        $childobj = null;   // initialise instance for child table

        // process each entry in $child_relations
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            if ($reldata['fields']['workflow_id'] != 'workflow_id') {
                // different column name on child table, so ignore it
            } elseif (!in_array($tblchild, $this->valid_tables)) {
                // this table cannot be copied
            } else {
                if (!is_object($childobj) or $childobj->getTableName() != $tblchild) {
                    unset($childobj);
                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = "../" .$reldata['subsys_dir'] ."/";
                    } else {
                        $dir = NULL;
                    } // if
                    $fname = $dir ."classes/$tblchild.class.inc";
                    if (file_exists($fname)) {
                        require_once $fname;
                        $childobj = new $tblchild;
                    } else {
                        // "File name '$fname' does not exist"
                        $msg[] = getLanguageText('sys0057', $fname);
                    } // if
                } // if
                if (file_exists($fname)) {
                    // delete any existing data - just in case
                    $childobj->audit_logging = false;
                    $del = $childobj->deleteSelection("workflow_id='$new_workflow_id'");
                    $childobj->audit_logging = $this->audit_logging;
                    // read all data for 'old' workflow_id
                    $where = "$tblchild.workflow_id='$this->old_workflow_id'";
                    $data = $childobj->getData_raw($where);
                    foreach ($data as $rownum1 => $rowdata1) {
                        // create copy using 'new' workflow_id
                        $rowdata1['workflow_id'] = $new_workflow_id;
                        $rowdata1 = $childobj->insertRecord($rowdata1);
                        if ($childobj->errors) {
                            $this->errors = array_merge($this->errors, $childobj->errors);
                            return $rowdata;
                        } // if
                    } // foreach
                    // "N records were copied into X"
                    $this->messages[] = getLanguageText('sys0117', count($data), strtoupper($tblchild));
                } // if
            } // if
        } // foreach

        // initiate task to validate this workflow
        $next['task_id'] = 'wf_workflow(upd4)validate';
        $next['where']   = "workflow_id='{$fieldarray['workflow_id']}'";
        append2ScriptSequence($next);

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        $rowdata['workflow_id'] = $rowdata['new_workflow_id'];
        $rowdata['revision_id'] = $rowdata['new_revision_id'];
        $rowdata['start_date']  = getTimeStamp('date');
        $rowdata['end_date']    = null;

        return $rowdata;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
