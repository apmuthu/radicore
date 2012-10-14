<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_motd extends Default_Table
{
    var $next_motd_id;          // id of next record
    var $prev_motd_id;          // id of previous record

    // ****************************************************************************
    function mnu_motd ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_motd';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_motd

    // ****************************************************************************
    function _checkNextRecord ($fieldarray)
    // check that end_date of current record is earlier than end_date of next record.
    {
        $dbobject =& RDCsingleton::getInstance('mnu_motd');

        $dbobject->sql_select = 'motd_id,end_date';
        $curr_id = $fieldarray['motd_id'];
        $where = "motd_id=(SELECT MIN(motd_id) FROM mnu_motd WHERE motd_id>$curr_id)";
        $next_rec_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows < 1) {
            $this->next_motd_id = null;
        } else {
            // use data from first row only
            $next_rec_data = $next_rec_data[0];
            // save primary key of next record
            $this->next_motd_id = $next_rec_data['motd_id'];

            if ($fieldarray['end_date'] >= $next_rec_data['end_date']) {
                // 'End Date must be earlier than End Date of next entry'
                $this->errors['end_date'] = getLanguageText('sys0194');
                // use next end_date minus 1 day
                $fieldarray['end_date'] = adjustDate($next_rec_data['end_date'], -1);
            } // if
        } // if

        return $fieldarray;

    } // _checkNextRecord

    // ****************************************************************************
    function _checkPrevRecord ($fieldarray)
    // find the previous record so that a check can be made against its start date.
    // (the previous record has a lower value for PRICE_COMPONENT_ID)
    // check that start_date of current record is later than start_date of previous record.
    {
        $dbobject =& RDCsingleton::getInstance('mnu_motd');

        $dbobject->sql_select = 'motd_id,start_date';
        if (empty($fieldarray['motd_id'])) {
        	$where = "motd_id=(SELECT MAX(motd_id) FROM mnu_motd)";
        } else {
            $curr_id = $fieldarray['motd_id'];
            $where = "motd_id=(SELECT MAX(motd_id) FROM mnu_motd WHERE motd_id<$curr_id)";
        } // if
        $prev_rec_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows < 1) {
            $this->prev_motd_id = null;
        } else {
            // use data from first row only
            $prev_rec_data = $prev_rec_data[0];
            // save primary key of previous record
            $this->prev_motd_id = $prev_rec_data['motd_id'];

            if ($fieldarray['start_date'] <= $prev_rec_data['start_date']) {
                // 'Start Date must be later than Start Date of previous entry'
                $this->errors['start_date'] = getLanguageText('sys0193');
                // use previous start_date plus 1 day
                $fieldarray['start_date'] = adjustDate($prev_rec_data['start_date'], +1);
            } // if
        } // if

        return $fieldarray;

    } // _checkPrevRecord

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['start_date'] > $fieldarray['end_date']) {
            // 'Start Date cannot be later than End Date';
            $this->errors['start_date'] = getLanguageText('sys0190');
            // 'End Date cannot be earlier than Start Date';
            $this->errors['end_date']   = getLanguageText('sys0191');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('role_id', $this->lookup_data)) {
            // get contents of foreign table MNU_ROLE and put into lookup_data
            $dbobject =& RDCsingleton::getInstance('mnu_role');
            $array = $dbobject->getValRep('role_id');
            $this->lookup_data['role_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (empty($fieldarray['start_date'])) {
        	$fieldarray['start_date'] = getTimeStamp('date');
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
//        if (!empty($this->prev_motd_id)) {
//            // update end_date on previous record
//            $fieldarray = $this->_updatePrevRecord($fieldarray);
//            if ($this->errors) return $fieldarray;
//        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
//        if (is_True($this->skip_validation)) {
//        	// skip the next bit
//        } else {
//            if (!empty($this->prev_motd_id)) {
//                // update end_date on previous record
//                $fieldarray = $this->_updatePrevRecord($fieldarray);
//                if ($this->errors) return $fieldarray;
//            } // if
//
//            if (!empty($this->next_motd_id)) {
//                // update start_date on next record
//                $fieldarray = $this->_updateNextRecord($fieldarray);
//                if ($this->errors) return $fieldarray;
//            } // if
//        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray, $parent_table)
    // verify that the selected record can be deleted.
    // $parent_table is not empty during a cascade delete.
    // (put any errors in $this->errors)
    {
        // check against next record (if it exists)
//        $fieldarray = $this->_checkNextRecord($fieldarray);
//
//        if (!empty($this->next_motd_id)) {
//            // "This is not the last record so it cannot be deleted."
//            $this->errors[] = getLanguageText('sys0192');
//        } // if

        return $fieldarray;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        // check against previous record (if it exists)
//        $fieldarray = $this->_checkPrevRecord($fieldarray);

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update and allow for changes being made.
    {
//        if (is_true($this->skip_validation)) {
//        	// this update has been pre-validated, so skip this bit
//        	return $fieldarray;
//        } // if
//
//        // check against previous record (if it exists)
//        $fieldarray = $this->_checkPrevRecord($fieldarray);
//
//        // check against next record (if it exists)
//        $fieldarray = $this->_checkNextRecord($fieldarray);

        return $fieldarray;

    } // _cm_validateUpdate

    // ****************************************************************************
    function _updateNextRecord ($fieldarray)
    // update the start_date of the next record so that it is
    // 1 day later than the end_date of the current record.
    {
        $end_date   = $fieldarray['end_date'];
        $start_date = adjustDate($end_date, +1);

        $update_array['motd_id']    = $this->next_motd_id;
        $update_array['start_date'] = $start_date;
        $dbobject =& RDCsingleton::getInstance('mnu_motd');
        $dbobject->skip_validation = true;
        $update_array = $dbobject->updateRecord($update_array);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->errors);
        } // if

        return $fieldarray;

    } // _updateNextRecord

    // ****************************************************************************
    function _updatePrevRecord ($fieldarray)
    // update the end_date of the previous record so that it is
    // 1 day earlier than the start_date of the current record.
    {
        $start_date = $fieldarray['start_date'];
        $end_date   = adjustDate($start_date, -1);

        $update_array['motd_id']  = $this->prev_motd_id;
        $update_array['end_date'] = $end_date;
        $dbobject =& RDCsingleton::getInstance('mnu_motd');
        $dbobject->skip_validation = true;
        $update_array = $dbobject->updateRecord($update_array);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->errors);
        } // if

        return $fieldarray;

    } // _updatePrevRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
