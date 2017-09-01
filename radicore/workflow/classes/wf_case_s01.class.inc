<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'wf_case.class.inc';
class wf_case_s01 extends wf_case
{
    // ****************************************************************************
    // this subclass changes the status of a workflow case
    // ****************************************************************************

    var $new_status = null;         // change status to this value

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        $this->xsl_params['main_noedit'] = 'y';  // no fields can be changed in the screen

        $status_desc = $this->lookup_data['case_status'][$this->new_status];
        // "Press SUBMIT to change status to '%1\$s'"
        $this->messages[] = getLanguageText('e0084', $status_desc);

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        global $settings;

        if (!empty($settings) AND is_array($settings) AND isset($settings['case_status'])) {
            if (preg_match('/^(CA|SU|OP)$/i', $settings['case_status'])) {
                $this->new_status = $settings['case_status'];
            } else {
                // "Invalid value (x) for CASE_STATUS in task settings - cannot continue"
                $this->errors[] = getLanguageText('e0083', $settings['case_status']);
                return $where;
            } // if
        } else {
            // "Task settings does not contain a value for CASE_STATUS - cannot continue"
            $this->errors[] = getLanguageText('e0082');
            return $where;
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        if ($fieldarray['case_status'] == 'CA') {
            $where = "case_id='{$fieldarray['case_id']}'";
            // this change must cascade down to other related tables
            $dbobject = RDCsingleton::getInstance('wf_token');
            $dbobject->allow_db_function[] = 'cancelled_date';
            $msg = $dbobject->updateSelection($where." AND token_status IN ('FREE','LOCK')", "token_status='CANC', cancelled_date=NOW()");
            if ($dbobject->errors) {
                $this->errors[$dbobject->getClassName()] = $dbobject->errors;
                return $fieldarray;
            } // if
            unset($dbobject);
            $this->messages[] = $msg;

            $dbobject = RDCsingleton::getInstance('wf_workitem');
            $dbobject->allow_db_function[] = 'cancelled_date';
            $msg = $dbobject->updateSelection($where." AND workitem_status IN ('EN','IP')", "workitem_status='CA', cancelled_date=NOW()");
            if ($dbobject->errors) {
                $this->errors[$dbobject->getClassName()] = $dbobject->errors;
                return $fieldarray;
            } // if
            unset($dbobject);
            $this->messages[] = $msg;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    // if anything is placed in $this->errors the update will be terminated.
    {
        $is_valid = false;

        switch ($this->new_status) {
            case 'CA':
                if ($originaldata['case_status'] == 'OP') {
                    $is_valid = true;
                } elseif ($originaldata['case_status'] == 'SU') {
                    $is_valid = true;
                } // if
                break;
            case 'SU':
                if ($originaldata['case_status'] == 'OP') {
                    $is_valid = true;
                } // if
                break;
            case 'OP':
                if ($originaldata['case_status'] == 'SU') {
                    $is_valid = true;
                } // if
                break;
            default:
                $this->errors[] = getLanguageText('e0083', $this->new_status);
                return $fieldarray;
        } // switch

        if (!$is_valid) {
            // "Invalid - cannot change status from '%1\$s' to '%2\$s'"
            $from = $this->lookup_data['case_status'][$originaldata['case_status']];
            $to   = $this->lookup_data['case_status'][$this->new_status];
            $this->errors[] = getLanguageText('e0085', $from, $to);
            return $fieldarray;
        } // if

        if (!empty($originaldata)) {
            $fieldarray = $originaldata;  // no changes are allowed in this screen
            $fieldarray['case_status'] = $this->new_status;  // except for this
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
