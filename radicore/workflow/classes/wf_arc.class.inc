<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_arc extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_arc ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_arc';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_arc

    // ***************************************************************************
    function examineInwardArc ($arc_data)
    // examine an INWARD arc (from a place into a transition) to see if a
    // workitem can be created for the transition.
    {
        $workflow_id   = $arc_data['workflow_id'];
        $transition_id = $arc_data['transition_id'];
        $case_id       = $arc_data['case_id'];

        // get list of all the places which input to this transition
        $this->sql_select = "wf_arc.workflow_id, transition_id, wf_arc.place_id, arc_type, direction, condition_field, place_type";
        $this->sql_from   = "wf_arc "
                          . "LEFT JOIN wf_place ON "
                          . "(wf_arc.workflow_id=wf_place.workflow_id AND wf_arc.place_id=wf_place.place_id) ";
        $where = "workflow_id='$workflow_id' AND transition_id='$transition_id' AND direction='IN'";
        $place_data = $this->getData($where);
        if ($this->errors) return;

        // now check that these places have the correct number of tokens
        require_once 'classes/wf_token.class.inc';
        $dbtoken =& RDCsingleton::getInstance('wf_token');

        $token_array = array();

        foreach ($place_data as $place) {
            $place_id = $place['place_id'];
            $where = "workflow_id='$workflow_id' AND place_id='$place_id' AND case_id='$case_id' AND token_status='FREE'";
            $token_data = $dbtoken->getData_raw($where);
            $token_count = count($token_data);
            if ($token_count == 0) {
                // no tokens at this place, so unable to proceed
                return;
            } // if
            // merge token data from this place with all other places
            $token_array = array_merge($token_data, $token_array);

            if ($place['arc_type'] == 'OR_JOIN') {
                // needs a separate token for each transition which outputs to this place
                $where = "workflow_id='$workflow_id' AND place_id='$place_id' AND direction='OUT'";
                $transition_count = $this->getCount($where);
                if ($token_count != $transition_count) {
                    // not enough tokens, so unable to proceed
                    return;
                } // if
            } // if
        } // foreach

        // transition has enough input tokens, so create a workitem
        require_once 'classes/wf_workitem.class.inc';
        $dbworkitem =& RDCsingleton::getInstance('wf_workitem');
        $workitem_data['workflow_id']        = $workflow_id;
        $workitem_data['transition_id']      = $transition_id;
        $workitem_data['case_id']            = $case_id;
        $workitem_data['role_id']            = $arc_data['role_id'];
        $workitem_data['user_id']            = $arc_data['user_id'];
        $workitem_data['task_id']            = $arc_data['task_id'];
        $workitem_data['context']            = $arc_data['context'];
        $workitem_data['transition_trigger'] = $arc_data['transition_trigger'];
        if ($arc_data['transition_trigger'] == 'TIME') {
        	//$workitem_data['deadline'] = adjustDateTime(time(), "+{$arc_data['time_limit']} hours");
        	$workitem_data['deadline'] = adjustDateTime(time(), "+{$arc_data['time_limit']} minutes");
        } // if

        $workitem_data = $dbworkitem->insertRecord($workitem_data);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        if ($arc_data['transition_trigger'] == 'AUTO') {
            // trigger is 'AUTO', so commit current updates and process this workitem now
            $this->errors = $dbworkitem->commit();
            $next['task_id'] = $arc_data['task_id'];
            $next['where']   = $arc_data['context'];
            // prepend so that workflow tasks are executed before non-workflow tasks
            append2ScriptSequence($next, true);
            // terminate current script and activate designated task
            scriptPrevious();
        } // if

        return;

    } // examineInwardArc

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $arc_type = $fieldarray['arc_type'];

        if (!empty($fieldarray['place_id'])) {
            // get PLACE details
            require_once 'classes/wf_place.class.inc';
            $dbobject =& RDCsingleton::getInstance('wf_place');
            $dbobject->sql_select = 'place_type';
            $place_data = $dbobject->getData_raw("workflow_id='{$fieldarray['workflow_id']}' AND place_id='{$fieldarray['place_id']}'");
            $place_type = $place_data[0]['place_type'];
        } // if

        // check that START and END places have valid value for DIRECTION
        if (isset($place_type) and !empty($fieldarray['direction'])) {
            switch ($place_type) {
                case '1':
                    // Explicit OR Split is allowed to go to START place
//                    if ($fieldarray['direction'] == 'OUT') {
//                        // 'Cannot use direction OUT on START place'
//                        $this->errors['direction'] = getLanguageText('e0001');
//                        return $fieldarray;
//                    } // if
                    break;
                case '9':
                    if ($fieldarray['direction'] == 'IN') {
                        // 'Cannot use direction IN on END place'
                        $this->errors['direction'] = getLanguageText('e0002');
                        return $fieldarray;
                    } // if
                    break;
                default:
                    ;
            } // switch
        } // if

        // check for valid combinations of DIRECTION and ARC_TYPE
        switch ($fieldarray['direction']) {
            case 'IN':
                if (!preg_match('/(SEQ|OR-SPLIT-I|AND-JOIN)/i', $arc_type, $regs)) {
                    // "ARC_TYPE is invalid for this DIRECTION"
                    $this->errors['arc_type'] = getLanguageText('e0003');
                    return $fieldarray;
                } // if
                break;
            case 'OUT':
                if (!preg_match('/(SEQ|AND-SPLIT|OR-SPLIT-E|OR-JOIN)/i', $arc_type, $regs)) {
                    // "ARC_TYPE is invalid for this DIRECTION"
                    $this->errors['arc_type'] = getLanguageText('e0003');
                    return $fieldarray;
                } // if
                break;
            default:
                ;
        } // switch

        if (empty($fieldarray['condition_field'])) {
            // CONDITION_FIELD is empty, so other values must also be empty
            $fieldarray['condition_operator'] = null;
            $fieldarray['condition_value']    = null;
        } else {
            if ($arc_type != 'OR-SPLIT-E') {
                // "Condition is invalid unless ARC_TYPE = 'Explicit OR-split'"
                $this->errors['condition_field'] = getLanguageText('e0004');
                return $fieldarray;
            } // if
            if (!preg_match('/^(strlen\(\w+\)|\w+)$/i', $fieldarray['condition_field'])) {
                // "CONDITION_FIELD must be in format 'name' or 'strlen(name)'"
                $this->errors['condition_field'] = getLanguageText('e0078');
                return $fieldarray;
            } // if
            // CONDITION_FIELD is not empty, so other values must also be not empty
            if (empty($fieldarray['condition_operator'])) {
                // "Cannot specify CONDITION_FIELD without CONDITION_OPERATOR"
                $this->errors['condition_operator'] = getLanguageText('e0074');
            } // if
            if (strlen($fieldarray['condition_value']) == 0) {
                // "Cannot specify CONDITION_FIELD without CONDITION_VALUE"
                $this->errors['condition_value'] = getLanguageText('e0075');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('arc_type', $this->lookup_data)) {
            // get array for arc_type and put into LOOKUP_DATA
            $array = $this->getValRep('arc_type');
            $this->lookup_data['arc_type'] = $array;
        } // if

        if (!array_key_exists('direction', $this->lookup_data)) {
            // get array for direction and put into LOOKUP_DATA
            $array = $this->getValRep('direction');
            $this->lookup_data['direction'] = $array;
        } // if

        if (!array_key_exists('condition_operator', $this->lookup_data)) {
            // get array for direction and put into LOOKUP_DATA
            $array = $this->getValRep('condition_operator');
            $this->lookup_data['condition_operator'] = $array;
        } // if

        if (!empty($fieldarray['workflow_id'])) {
            $workflow_id = $fieldarray['workflow_id'];

            // get contents of foreign table TRANSITION and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('wf_transition');
            $array = $dbobject->getValRep('transition_id', "workflow_id='$workflow_id'");
            $this->lookup_data['transition_id'] = $array;

            // get contents of foreign table PLACE and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('wf_place');
            $array = $dbobject->getValRep('place_id', "workflow_id='$workflow_id'");
            $this->lookup_data['place_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'direction') {
            $array = getLanguageArray('direction');
            return $array;
        } // if

        if ($item == 'arc_type') {
            $array = getLanguageArray('arc_type');
            return $array;
        } // if

        if ($item == 'condition_operator') {
            $array = getLanguageArray('condition_operator');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if (preg_match('/(add2)/i', $pattern_id)) {
            $where_array = where2array($where);
         	// remove fields included from $selection instead of $where
            if (isset($fieldarray['transition_id'])) {
            	unset($fieldarray['transition_id']);
            } // if
            if (isset($fieldarray['place_id'])) {
            	unset($fieldarray['place_id']);
            } // if
            if (isset($fieldarray['direction'])) {
            	unset($fieldarray['direction']);
            } // if
            $where = array2where($where_array);
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            $this->sql_select = 'wf_arc.*, transition_name, place_name, place_type ';
            $this->sql_from   = 'wf_arc '
                               .'LEFT JOIN wf_transition ON (wf_transition.workflow_id=wf_arc.workflow_id AND wf_transition.transition_id=wf_arc.transition_id) '
                               .'LEFT JOIN wf_place ON (wf_place.workflow_id=wf_arc.workflow_id AND wf_place.place_id=wf_arc.place_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
