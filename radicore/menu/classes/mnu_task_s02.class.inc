<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_s02 extends mnu_task
{
    // ****************************************************************************
    // this class is for use by script: mnu_task(upd2).php (rename task)
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $this->fieldspec['task_desc']['noedit'] = 'y';
        $this->fieldspec['new_task_id']     = array('type' => 'string',
                                                    'size' => $this->fieldspec['task_id']['size'],
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'nondb' => 'y');
        if (!isset($fieldarray['new_task_id'])) {
            // ensure this field appears in the HTML output
            $fieldarray['new_task_id'] = null;
        } // if

        // this button causes confusion, so remove it
        unset($GLOBALS['act_buttons']['submitnext']);

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {
        $where = "task_id='{$fieldarray['new_task_id']}'";
        $count = $this->getCount($where);
        if ($count > 0) {
            // "This TASK_ID is already in use"
            $this->errors['new_task_id'] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        $old_task_id = $fieldarray['task_id'];
        $new_task_id = $fieldarray['new_task_id'];

        $childobj = null;   // initialise instance for child table

        // process each entry in $child_relations
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            if (!is_object($childobj) or $childobj->getTableName() != $tblchild) {
                unset($childobj);
                // instantiate an object for this table
                if (array_key_exists('subsys_dir', $reldata)) {
                    // get path to current subsystem directory
                    $dir = dirname($this->dirname);
                    // switch to other subsystem directory
                    $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
                } else {
                    $dir = NULL;
                } // if
                require_once $dir ."classes/$tblchild.class.inc";
                $childobj = new $tblchild;
            } // if
            // extract name of foreign field on child table
            foreach ($reldata['fields'] as $fldparent => $fldchild) {
            	$selection = "$fldchild='$old_task_id'";
                $replace   = "$fldchild='$new_task_id'";
            } // foreach
            // perform the replacement
            $msg[] = $childobj->updateSelection($selection, $replace);
        } // foreach

        // now update the parent MNU_TASK record
        unset($childobj);
        //require_once 'classes/mnu_task.class.inc';
        $childobj =& RDCsingleton::getInstance('mnu_task');
        $msg[] = $childobj->updateSelection("task_id='$old_task_id'", "task_id='$new_task_id'");
        unset($childobj);

        $fieldarray['task_id'] = $new_task_id;
        $this->where = "task_id='$new_task_id'";

        $this->messages = $msg;

        $fieldarray = array();  // do not update anything else

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
