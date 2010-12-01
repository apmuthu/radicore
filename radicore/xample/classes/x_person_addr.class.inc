<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_person_addr extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function x_person_addr()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'x_person_addr';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // x_person_addr

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = TRUE;     // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']) {
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person';
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (empty($fieldarray['person_id'])) {
            // 'No parent has been selected yet.'
            $this->errors = getLanguageText('sys0082');
            return $fieldarray;
        } // if

        $dbobject =& RDCsingleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $where = array2where($fieldarray, $dbobject->getPkeyNames());
        $person_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate PERSON record'
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        $person_data = $person_data[0];  // use data from first row only

        // this field is generated, not input by the user
        $this->fieldspec['address_no']['noedit'] = 'y';

        // get last_addr_no and increment it for the new address
        $address_no = $person_data['last_addr_no'] + 1;
        //$address_no = 1;  // ********** TEST **********
        $fieldarray['address_no'] = $address_no;

        $this->retry_on_duplicate_key = 'address_no';

        // end_date must be same as person.end_date (and not editable)
        $fieldarray['end_date'] = $person_data['end_date'];
        $this->fieldspec['end_date']['noedit'] = 'y';

        if ($fieldarray['address_no'] == 1) {
            // for 1st address start_date must be same as person.start_date (and not editable)
            $fieldarray['start_date'] = $person_data['start_date'];
            $this->fieldspec['start_date']['noedit'] = 'y';
        } else {
            if (empty($fieldarray['start_date'])) {
                // for subsequent addresses the start date must be later than
                // the start date of the previous address
                $this->sql_select = 'start_date,end_date';
                $where_array['person_id']  = $fieldarray['person_id'];
                $where_array['address_no'] = $address_no -1;
                $where = array2where($where_array);
                $prev_addr_data = $this->getData_raw($where);
                if ($this->numrows <> 1) {
                    // 'Could not locate previous PERS_ADDR record'
                    $this->errors[] = getLanguageText('e0016');
                    return $fieldarray;
                } // if
                $prev_addr_data = $prev_addr_data[0];
                // use previous start_date plus 1 day
                $fieldarray['start_date'] = adjustDate($prev_addr_data['start_date'], +1);
            } // if
        } // if

        //$this->messages[] = "test message 1";     // array
        //$this->messages = "test message 2";       // string

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is only available for ADD2 tasks.
    {
        // customisable code goes here

        //$where .= " AND x_person_addr.start_date>'2000-01-01'";

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record is deleted.
    {
        // do this bit only if a specific address has been selected
        // (ignored if deleting all addresses for a person)
        if (isset($fieldarray['address_no']) AND (int)$fieldarray['address_no'] > 0) {
            // update last_addr_no value on PERSON record
            $dbobject =& RDCsingleton::getInstance('x_person');

            $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';

            $where = array2where($fieldarray, $dbobject->getPkeyNames());
            $person_data = $dbobject->getData_raw($where);

            $person_data = $person_data[0];  // use data from first row only

            $update_array['person_id']    = $fieldarray['person_id'];
            $update_array['last_addr_no'] = $fieldarray['address_no'] -1;
            $dbobject->skip_validation = true;
            $update_array = $dbobject->updateRecord($update_array);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $fieldarray;
            } // if

            if ($fieldarray['address_no'] > 1) {
                // set end_date of previous (now last) address to end_date of person
                $update_array = array();
                $update_array['person_id']  = $fieldarray['person_id'];
                $update_array['address_no'] = $fieldarray['address_no'] -1;
                $update_array['end_date']   = $person_data['end_date'];
                $this->skip_validation = true;
                $update_array = $this->updateRecord($update_array);
                if ($this->errors) return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        if ($GLOBALS['mode'] == 'update') {
        	foreach ($rows as $row => $fieldarray) {
            	if ($fieldarray['address_no'] == 1) {
                    // if this is first address set start_date to 'noedit'
                    $this->fieldspec['start_date']['noedit'] = 'y';
                } else {
                    unset($this->fieldspec['start_date']['noedit']);
                } // if

                $where2 = array2where($fieldarray, array('person_id'));

                // look for the highest value for address_no on person_addr table
                $query = "SELECT MAX(address_no) FROM $this->tablename WHERE $where2";
                $last_address_no = $this->getCount($query);

                if ($fieldarray['address_no'] == $last_address_no) {
                    // if this is last address set end date to 'noedit'
                    $this->fieldspec['end_date']['noedit'] = 'y';
                } else {
                    unset($this->fieldspec['end_date']['noedit']);
                } // if
            } // foreach
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        $dbobject =& RDCsingleton::getInstance('x_person');

        // update last_addr_no value on PERSON record
        $update_array['person_id']    = $fieldarray['person_id'];
        $update_array['last_addr_no'] = $fieldarray['address_no'];
        $dbobject->skip_validation = true;
        $update_array = $dbobject->updateRecord($update_array);
        if ($dbobject->errors) {
            $this->errors = $dbobject->errors;
            return $fieldarray;
        } // if

        if ($fieldarray['address_no'] > 1) {
            // update end_date on previous address
            $fieldarray = $this->_updatePrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        if (is_True($this->skip_validation)) {
        	// skip the next bit
        } else {
            // get last address number for this person
            $where = array2where($fieldarray, array('person_id'));
            $query = "SELECT MAX(address_no) FROM $this->tablename WHERE $where";
            $last_address_no = $this->getCount($query);

            if ($fieldarray['address_no'] > 1) {
                // update end_date on previous address
                $fieldarray = $this->_updatePrevAddress($fieldarray);
                if ($this->errors) return $fieldarray;
            } // if

            if ($fieldarray['address_no'] < $last_address_no) {
                // update start_date on next address
                $fieldarray = $this->_updateNextAddress($fieldarray);
                if ($this->errors) return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // customisable code goes here

        if (empty($this->sql_from)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
        } // if

        //$where = "x_person_addr.postcode LIKE '%' AND $where";

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray, $parent_table)
    // verify that the selected record can be deleted.
    // $parent_table is not empty during a cascade delete.
    // (put any errors in $this->errors)
    {
        $dbobject =& RDCsingleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $where = array2where($fieldarray, $dbobject->getPkeyNames());
        $person_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return;
        } // if

        $person_data = $person_data[0];  // use data from first row only

        if (!isset($fieldarray['address_no'])) {
            // 'You have not selected an address for deletion.'
            $this->errors[] = getLanguageText('e0024');
            return;
        } // if

        if ($fieldarray['address_no'] <> $person_data['last_addr_no']) {
            // 'Only the last address can be deleted.'
            $this->errors[] = getLanguageText('e0025');
            return;
        } else {
            // do not perform this validation on any more addresses
            $this->skip_validation = TRUE;
        } // if

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        $dbobject =& RDCsingleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';

        $where = array2where($fieldarray, $dbobject->getPkeyNames());
        $person_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        $person_data = $person_data[0];  // use data from first row only

        // newest address must have same end_date as person record
        $fieldarray['end_date'] = $person_data['end_date'];

        if ($fieldarray['address_no'] == 1) {
            // first address - start date must be same as person.start_date
            $fieldarray['start_date'] = $person_data['start_date'];
        } else {
            // check against previous address
            $fieldarray = $this->_checkPrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($fieldarray['start_date'] > $fieldarray['end_date']) {
            // 'Start Date cannot be later than End Date'
            $this->errors['start_date'] = getLanguageText('e0001');
            // 'End Date cannot be earlier than Start Date'
            $this->errors['end_date']   = getLanguageText('e0002');
        } // if

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $orignaldata)
    // perform custom validation before update and allow for changes being made.
    {
        $dbobject =& RDCsingleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';

        $where = array2where($fieldarray, $dbobject->getPkeyNames());
        $person_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        $person_data = $person_data[0];  // use data from first row only

        if ($fieldarray['address_no'] == 1) {
            // first address - start date must be same as person.start_date
            if ($fieldarray['start_date'] <> $person_data['start_date']) {
                $fieldarray['start_date']  = $person_data['start_date'];
                // 'Cannot change start date of first address.'
                $this->errors['start_date'] = getLanguageText('e0018');
                return $fieldarray;
            } // if
        } else {
            // check against previous address
            $fieldarray = $this->_checkPrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($fieldarray['address_no'] == $person_data['last_addr_no']) {
            // latest address must have same end_date as person record
            if ($fieldarray['end_date'] <> $person_data['end_date']) {
                $fieldarray['end_date']  = $person_data['end_date'];
                // 'Cannot change end date of last address.'
                $this->errors['end_date'] = getLanguageText('e0019');
                return $fieldarray;
            } // if
        } else {
            // check against next address
            $fieldarray = $this->_checkNextAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($fieldarray['start_date'] > $fieldarray['end_date']) {
            // 'Start Date cannot be later than End Date'
            $this->errors['start_date'] = getLanguageText('e0001');
            // 'End Date cannot be earlier than Start Date'
            $this->errors['end_date']   = getLanguageText('e0002');
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

    // ****************************************************************************
    function _checkNextAddress ($fieldarray)
    // check that end_date of current address is earlier than end_date of next address.
    {
        $dbobject =& RDCsingleton::getInstance('x_person_addr');
        $dbobject->sql_select = 'end_date';

        $where_array['person_id']  = $fieldarray['person_id'];
        $where_array['address_no'] = $fieldarray['address_no'] + 1;
        $where = array2where($where_array);

        $next_addr_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate next PERSON_ADDR record'
            $this->errors['end_date'] = getLanguageText('e0014');
            return $fieldarray;
        } // if

        $next_addr_data = $next_addr_data[0];  // use data from first row only

        if ($fieldarray['end_date'] >= $next_addr_data['end_date']) {
            // 'End Date must be earlier than End Date of next entry'
            $this->errors['end_date'] = getLanguageText('e0015');
            // use next end_date minus 1 day
            $fieldarray['end_date'] = adjustDate($next_addr_data['end_date'], -1);
        } // if

        return $fieldarray;

    } // _checkNextAddress

    // ****************************************************************************
    function _checkPrevAddress ($fieldarray)
    // check that start_date of current address is later than start_date of previous address.
    {
        $dbobject =& RDCsingleton::getInstance('x_person_addr');
        $dbobject->sql_select = 'start_date';

        $where_array['person_id']  = $fieldarray['person_id'];
        $where_array['address_no'] = $fieldarray['address_no'] - 1;
        $where = array2where($where_array);

        $prev_addr_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate previous PERSON_ADDR record'
            $this->errors['start_date'] = getLanguageText('e0016');
            return $fieldarray;
        } // if

        $prev_addr_data = $prev_addr_data[0];  // use data from first row only

        if ($fieldarray['start_date'] <= $prev_addr_data['start_date']) {
            // 'Start Date must be later than Start Date of previous entry'
            $this->errors['start_date'] = getLanguageText('e0017');
            // use previous start_date plus 1 day
            $fieldarray['start_date'] = adjustDate($prev_addr_data['start_date'], 1);
        } // if

        return $fieldarray;

    } // _checkPrevAddress

    // ****************************************************************************
    function _updateNextAddress ($fieldarray)
    // update the start_date of the next address so that it is
    // 1 day later than the end_date of the current address.
    {
        $start_date = adjustDate($fieldarray['end_date'], +1);

        $update_array['person_id']  = $fieldarray['person_id'];
        $update_array['address_no'] = $fieldarray['address_no'] +1;
        $update_array['start_date'] = $start_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updateNextAddress

    // ****************************************************************************
    function _updatePrevAddress ($fieldarray)
    // update the end_date of the previous address so that it is
    // 1 day earlier than the start_date of the current address.
    {
        $end_date = adjustDate($fieldarray['start_date'], -1);

        $update_array['person_id']  = $fieldarray['person_id'];
        $update_array['address_no'] = $fieldarray['address_no'] -1;
        $update_array['end_date']   = $end_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // _updatePrevAddress

// ****************************************************************************
} // end class
// ****************************************************************************

?>
