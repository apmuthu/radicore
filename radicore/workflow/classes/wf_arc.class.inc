<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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

        $this->dbms_engine = $GLOBALS['dbms'];
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
        $this->sql_select = "wf_arc.workflow_id, transition_id, wf_arc.place_id, arc_type, direction, pre_condition, place_type";
        $this->sql_from   = "wf_arc "
                          . "LEFT JOIN wf_place ON "
                          . "(wf_arc.workflow_id=wf_place.workflow_id AND wf_arc.place_id=wf_place.place_id) ";
        $where = "workflow_id='$workflow_id' AND transition_id='$transition_id' AND direction='IN'";
        $place_data = $this->getData($where);
        if ($this->errors) return;

        // now check that these places have the correct number of tokens
        require_once 'classes/wf_token.class.inc';
        $dbtoken =& singleton::getInstance('wf_token');

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
        $dbworkitem =& singleton::getInstance('wf_workitem');
        $workitem_data['workflow_id'] = $workflow_id;
        $workitem_data['transition_id'] = $transition_id;
        $workitem_data['case_id'] = $case_id;
        $workitem_data['role_id'] = $arc_data['role_id'];
        $workitem_data['task_id'] = $arc_data['task_id'];
        $workitem_data['context'] = $arc_data['context'];
        $workitem_data['transition_trigger'] = $arc_data['transition_trigger'];
        if ($arc_data['transition_trigger'] == 'TIME') {
        	$workitem_data['deadline'] = adjustDateTime(time(), "+{$arc_data['time_limit']} hours");
        } // if

        $workitem_data = $dbworkitem->insertRecord($workitem_data);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        // if trigger is 'AUTO' then process this workitem now
        if ($arc_data['transition_trigger'] == 'AUTO') {
            $next['task_id'] = $arc_data['task_id'];
            $next['where']   = $arc_data['context'];
            $_SESSION['script_sequence'][] = $next;
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
            $dbobject =& singleton::getInstance('wf_place');
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
                if (!eregi('SEQ|OR-SPLIT-I|AND-JOIN', $arc_type, $regs)) {
                    // "ARC_TYPE is invalid for this DIRECTION"
                    $this->errors['arc_type'] = getLanguageText('e0003');
                    return $fieldarray;
                } // if
                break;
            case 'OUT':
                if (!eregi('SEQ|AND-SPLIT|OR-SPLIT-E|OR-JOIN', $arc_type, $regs)) {
                    // "ARC_TYPE is invalid for this DIRECTION"
                    $this->errors['arc_type'] = getLanguageText('e0003');
                    return $fieldarray;
                } // if
                break;
            default:
                ;
        } // switch

        // pre_condition is only valid if arc_type = 'OR split (E)'
        if (!empty($fieldarray['pre_condition'])) {
            if ($arc_type != 'OR-SPLIT-E') {
                // "pre_condition invalid unless ARC_TYPE = 'Explicit OR-split'"
                $this->errors['pre_condition'] = getLanguageText('e0004');
                return $fieldarray;
            } // if
            $guard = stripslashes($fieldarray['pre_condition']);
            // turn on output buffering to capture any errors from eval()
            ob_start();
            $result = eval($guard);
            $eval_result = ob_get_clean();
            if ($eval_result) {
                // there was a parse error
                $this->errors['pre_condition'] = $eval_result;
                return $fieldarray;
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
        // get array for arc_type and put into LOOKUP_DATA
        $array = $this->getValRep('arc_type');
        $this->lookup_data['arc_type'] = $array;

        // get array for direction and put into LOOKUP_DATA
        $array = $this->getValRep('direction');
        $this->lookup_data['direction'] = $array;

        if (!empty($fieldarray['workflow_id'])) {
            $workflow_id = $fieldarray['workflow_id'];

            // get contents of foreign table TRANSITION and add as a LOOKUP list
            require_once 'classes/wf_transition.class.inc';
            $dbobject =& singleton::getInstance('wf_transition');
            $array = $dbobject->getValRep('transition_id', "workflow_id='$workflow_id'");
            $this->lookup_data['transition_id'] = $array;

            // get contents of foreign table PLACE and add as a LOOKUP list
            require_once 'classes/wf_place.class.inc';
            $dbobject =& singleton::getInstance('wf_place');
            $array = $dbobject->getValRep('place_id', "workflow_id='$workflow_id'");
            $this->lookup_data['place_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'direction') {
//            $array['']    = ' ';   // start with blank entry
//            $array['IN']  = 'In (P -> T)';
//            $array['OUT'] = 'Out (P <- T)';
            $array = getLanguageArray('direction');
            return $array;
        } // if

        if ($item == 'arc_type') {
//            $array['']           = ' ';   // start with blank entry
//            $array['SEQ']        = 'Sequential';
//            $array['OR-SPLIT-E'] = 'OR-split (Explicit)';
//            $array['OR-SPLIT-I'] = 'OR-split (Implicit)';
//            $array['OR-JOIN']    = 'OR-join';
//            $array['AND-SPLIT']  = 'AND-split';
//            $array['AND-JOIN']   = 'AND-join';
            $array = getLanguageArray('arc_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

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
