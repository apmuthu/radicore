<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_todo extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_todo ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_todo';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_todo

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (empty($fieldarray['repeat_interval'])) {
        	if (!empty($fieldarray['repeat_unit'])) {
        	    // 'Unit is invalid without Interval'
        		$this->errors['repeat_unit'] = getLanguageText('e0060');
        	} // if
        } else {
            if (empty($fieldarray['repeat_unit'])) {
        	    // 'Repeat Unit is required with Repeat Interval'
        		$this->errors['repeat_unit'] = getLanguageText('e0061');
        	} // if
        } // if

        if (!empty($fieldarray['task_context'])) {
        	if (empty($fieldarray['task_id'])) {
        	    // 'Context is invalid without Task'
        		$this->errors['task_context'] = getLanguageText('e0062');
        	} // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if (!preg_match('/(search|insert|update)/i', $GLOBALS['mode'])) {
        	if (!is_True($fieldarray['is_complete'])) {
                $today = getTimeStamp('date');
                $dateobj = singleton::getInstance('date_class');
                $due_date = $dateobj->getInternalDate($fieldarray['due_date']);
                if ($due_date < $today) {
                    foreach ($this->fieldspec as $field => $specs) {
                    	$css_array[$field] = 'overdue';
                    } // foreach
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('user_id', $this->lookup_data)) {
            // get contents of foreign table and put into lookup_data
            $dbobject =& singleton::getInstance('mnu_user');
            $array = $dbobject->getValRep('user_id');
            $this->lookup_data['user_id'] = $array;
        } // if

        if (!array_key_exists('repeat_unit', $this->lookup_data)) {
            // get contents of language file and put into lookup_data
            $array = getLanguageArray('repeat_unit');
            $this->lookup_data['repeat_unit'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // these fields should not appear on INSERT screen
        $this->fieldspec['is_complete']['nodisplay'] = 'y';
        $this->fieldspec['seq_no']['nodisplay']      = 'y';

        if (isset($fieldarray['user_id']) and !empty($fieldarray['user_id'])) {
            // obtain the next value for table_seq_no
            $select = "SELECT max(seq_no) FROM $this->tablename WHERE user_id='{$fieldarray['user_id']}'";
            $count = $this->getCount($select);
            $fieldarray['seq_no'] = $count + 1;
        } // if

        if (empty($fieldarray['visibility'])) {
        	$fieldarray['visibility'] = 7;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        if ($rowdata['is_complete'] != $old_data['is_complete']) {
            // is this changed from 'N' to 'Y'?
        	if (is_True($rowdata['is_complete']) AND !empty($rowdata['repeat_interval'])) {
        		$new_data                = $rowdata;
        		$new_data['is_complete'] = 'N';

        		$dateobj = singleton::getInstance('date_class');
                switch ($rowdata['repeat_unit']) {
                	case 'D':  // days
                		$new_date = $dateobj->addDays($rowdata['due_date'], $rowdata['repeat_interval']);
                		break;

                	case 'W':  // weeks
                		$new_date = $dateobj->addWeeks($rowdata['due_date'], $rowdata['repeat_interval']);
                		break;

                	case 'M':  // months
                		$new_date = $dateobj->addMonths($rowdata['due_date'], $rowdata['repeat_interval']);
                		break;

                	default:
                	    $new_date = $rowdata['due_date'];
                		break;
                } // switch
        		$new_data['due_date'] = $new_date;
        		// create a copy of this record with an adjusted due_date
        		$new_data = $this->insertRecord($new_data);
        	} // if
        } // if

        return $rowdata;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $due_date = $dateobj->getInternalDate($fieldarray['due_date']);

        if ($due_date <= getTimeStamp ('date')) {
            // 'Due Date must be in the future'
        	$this->errors['due_date'] = getLanguageText('e0033');
        } // if

        return $fieldarray;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
