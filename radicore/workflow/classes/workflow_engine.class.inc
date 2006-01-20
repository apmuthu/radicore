<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
if (!class_exists('wf_workflow')) {
	require_once 'wf_workflow.class.inc';
} // if
class workflow_engine extends wf_workflow
{
    // ****************************************************************************
    // This subclass deals with cases, or instances of workflow processes.
    // ****************************************************************************
    function startWorkflowCase ($task_id, $context)
    // Look for a workflow process for the specified task, and if one exists
    // then start a new case (a workflow instance).
    {
        // look for a valid and current workflow for this task_id
        $today = date('Y-m-d');
        $where = "start_task_id='$task_id' AND is_valid='Y' AND start_date<='$today' AND end_date>='$today'";
        $this->sql_select = 'workflow_id, workflow_name';
        $data = $this->getData_raw($where);
        if ($this->numrows < 1) {
            // no process defined for this task, so quit here
            return;
        } // if

        $context = trim($context, '()');

        // create a case (workflow instance) for this task
        require_once 'wf_case.class.inc';
        $dbcase =& singleton::getInstance('wf_case');

        // there may be more than one workflow, but it is unlikely
        foreach ($data as $workflow) {
            $case_data['workflow_id'] = $workflow['workflow_id'];
            $case_data['context']     = $context;
            $case_data = $dbcase->insertRecord($case_data);
            if ($dbcase->errors) {
                $this->errors = array_merge($this->errors, $dbcase->getErrors());
                return;
            } // if
        } // foreach

        return $case_data['case_id'];

    } // startWorkflowCase

    // ****************************************************************************
    function finishWorkItem ($case_id, $workitem_id, $context, $fieldarray)
    // a workitem (transition) has been completed, so update this workflow case.
    {
        // mark this workitem as finished
        require_once 'wf_workitem.class.inc';
        $dbworkitem =& singleton::getInstance('wf_workitem');

        //check that workitem has not already been processed
        $where = "case_id='$case_id' AND workitem_id='$workitem_id' AND workitem_status='EN'";
        $data = $dbworkitem->getData($where);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        // if nothing found exit now
        if ($dbworkitem->numrows == 0) {
            return;
        } // if

        // mark this workitem as finished
        $workitem_array['case_id']         = $case_id;
        $workitem_array['workitem_id']     = $workitem_id;
        $workitem_array['workitem_status'] = 'FI';
        $workitem_array['finished_date']   = getTimeStamp();
        $workitem_array['user_id']         = $_SESSION['logon_user_id'];
        $workitem_array = $dbworkitem->updateRecord($workitem_array);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        $workflow_id   = $workitem_array['workflow_id'];
        $transition_id = $workitem_array['transition_id'];
        $context       = trim($context, '()');

        // find tokens on all input arcs (there may be more than one)
        require_once 'wf_arc.class.inc' ;
        $dbarc =& singleton::getInstance('wf_arc');

        $dbarc->sql_select = 'wf_arc.*, token_id, case_id';
        $dbarc->sql_from   = "wf_arc "
                           . "LEFT JOIN wf_token ON (wf_token.case_id=$case_id AND wf_token.workflow_id=wf_arc.workflow_id AND wf_token.place_id=wf_arc.place_id) ";
        $where = "workflow_id='$workflow_id' AND transition_id='$transition_id' AND direction='IN'";
        $arc_data = $dbarc->getData($where);
        if ($dbarc->errors) {
            $this->errors = array_merge($this->errors, $dbarc->getErrors());
            return;
        } // if

        // now mark them all as consumed
        require_once 'wf_token.class.inc';
        $dbtoken =& singleton::getInstance('wf_token');

        foreach ($arc_data as $arc) {
            $arc['token_status']  = 'CONS';
            $arc['consumed_date'] = getTimeStamp();
            $token_data = $dbtoken->updateRecord($arc);
            if ($dbtoken->errors) {
                $this->errors = array_merge($this->errors, $dbtoken->getErrors());
                return;
            } // if
        } // foreach

        // find the arc(s) which leave this transition and go to other places
        $dbarc->sql_select = 'wf_arc.*, place_type, pre_condition';
        $dbarc->sql_from   = "wf_arc "
                           . "LEFT JOIN wf_place ON (wf_place.workflow_id=wf_arc.workflow_id AND wf_place.place_id=wf_arc.place_id) ";
        $where = "workflow_id='$workflow_id' AND transition_id='$transition_id' AND direction='OUT'";
        $arc_data = $dbarc->getData($where);
        if ($dbarc->numrows < 1) {
            // "There are no outbound arcs from this transition"
            $this->errors[] = getLanguageText('e0010');
            return;
        } // if

        $arc_type = null;

        // check that all linked places have the same place_type
        foreach ($arc_data as $arc) {
            if (empty($arc_type)) {
                // use the value from the first row
                $arc_type = $arc['arc_type'];
            } else {
                // compare with previous value
                if ($arc['arc_type'] != $arc_type) {
                    // "Outward arcs do not have the same ARC_TYPE"
                    $this->errors[] = getLanguageText('e0011');
                    return;
                } // if
            } // if
        } // foreach

        $token_data = array();      // initialise
        $token_data['case_id']     = $case_id;
        $token_data['workflow_id'] = $workflow_id;
        $token_data['context']     = $context;

        // process arc according to it's type
        switch ($arc_type) {
            case 'SEQ':
                if (count($arc_data) > 1) {
                    // "Cannot have more than one outward arc with ARC_TYPE='Sequential'"
                    $this->errors[] = getLanguageText('e0012');
                    return;
                } // if
                // create a single new token
                $token_data = $this->_createToken($dbtoken, $token_data, $arc_data[0]);
                if ($this->errors) return;
                break;
            case 'AND-SPLIT':
                if (count($arc_data) <= 1) {
                    // "Must have more than one outward arc with ARC_TYPE='AND-split'"
                    $this->errors[] = getLanguageText('e0013');
                    return;
                } // if
                // create a new token in every output place
                foreach ($arc_data as $arc) {
                    $token_data = $this->_createToken($dbtoken, $token_data, $arc);
                    if ($this->errors) return;
                } // foreach
                break;
            case 'OR-SPLIT-E':
                if (count($arc_data) <= 1) {
                    // "Must have more than one outward arc with ARC_TYPE='OR-split (explicit)'"
                    $this->errors[] = getLanguageText('e0014');
                    return;
                } // if

                // one of the two arcs has a pre-condition (guard)
                if (!empty($arc_data[0]['pre_condition'])) {
                    $guard = stripslashes($arc_data[0]['pre_condition']);
                    $true_arc  = 0;
                    $false_arc = 1;
                } else {
                    $guard = stripslashes($arc_data[1]['pre_condition']);
                    $true_arc  = 1;
                    $false_arc = 0;
                } // if
                // turn on output buffering to capture any errors from eval()
                ob_start();
                $result = eval($guard);
                $eval_result = ob_get_clean();
                if ($eval_result) {
                    // there was a parse error
                    $this->errors[] = $eval_result;
                    return;
                } // if
                if ($result == TRUE) {
                    $token_data = $this->_createToken($dbtoken, $token_data, $arc_data[$true_arc]);
                } else {
                    $token_data = $this->_createToken($dbtoken, $token_data, $arc_data[$false_arc]);
                } // if
                if ($this->errors) return;
                break;
            case 'OR-JOIN':
                if (count($arc_data) > 1) {
                    // "Cannot have more than one outward arc with ARC_TYPE='OR-join'"
                    $this->errors[] = getLanguageText('e0015');
                    return;
                } // if
                // create a single new token
                $token_data = $this->_createToken($dbtoken, $token_data, $arc_data[0]);
                if ($this->errors) return;
                break;
            default:
                // "Invalid PLACE_TYPE on outward arc"
                $this->errors[] = getLanguageText('e0016');
                return;
        } // switch

        return;

    } // finishWorkItem

    // ****************************************************************************
    function _createToken ($dbtoken, $token_data, $arc_data)
    // create a token at the designated place for this workflow case
    {
        $token_data['place_id']   = $arc_data['place_id'];
        $token_data['place_type'] = $arc_data['place_type'];
        $token_data = $dbtoken->insertRecord($token_data);
        if ($dbtoken->errors) {
            $this->errors = array_merge($this->errors, $dbtoken->getErrors());
            return;
        } // if

        return;

    } // _createToken

// ****************************************************************************
} // end class
// ****************************************************************************

?>
