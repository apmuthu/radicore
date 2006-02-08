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
    function checkNextAddress ($fieldarray)
    // check that end_date of current address is earlier than end_date of next address.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $end_date = $dateobj->getInternalDate($fieldarray['end_date']);
        $next_addr_no = $fieldarray['address_no'] + 1;
        $where = "(person_id = '{$fieldarray['person_id']}' AND address_no = '$next_addr_no')" ;

        $dbobject =& singleton::getInstance('x_person_addr');
        $dbobject->sql_select = 'end_date';
        $dbobject->row_locks = 'SH'; // set row-level locks to shared
        $next_addr_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate next PERSON_ADDR record'
            $this->errors['end_date'] = getLanguageText('e0014');
            return $fieldarray;
        } // if

        // use data from first row only
        $next_addr_data = $next_addr_data[0];

        $next_end_date = $dateobj->getInternalDate($next_addr_data['end_date']);

        if ($end_date >= $next_end_date) {
            // 'End Date must be earlier than End Date of next entry'
            $this->errors['end_date'] = getLanguageText('e0015');
            // use next end_date minus 1 day
            $fieldarray['end_date'] = $dateobj->addDays($next_end_date, -1);
        } // if

        return $fieldarray;

    } // checkNextAddress

    // ****************************************************************************
    function checkPrevAddress ($fieldarray)
    // check that start_date of current address is later than start_date of previous address.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $start_date = $dateobj->getInternalDate($fieldarray['start_date']);
        $prev_addr_no = $fieldarray['address_no'] -1;
        $where = "(person_id='{$fieldarray['person_id']}' AND address_no='$prev_addr_no')" ;

        $dbobject =& singleton::getInstance('x_person_addr');
        $dbobject->sql_select = 'start_date';
        $dbobject->row_locks = 'SH'; // set row-level locks to shared
        $prev_addr_data = $dbobject->getData_raw($where);
        if ($dbobject->numrows <> 1) {
            // 'Could not locate previous PERSON_ADDR record'
            $this->errors['start_date'] = getLanguageText('e0016');
            return $fieldarray;
        } // if

        // use data from first row only
        $prev_addr_data = $prev_addr_data[0];

        $prev_start_date = $dateobj->getInternalDate($prev_addr_data['start_date']);
        if ($start_date <= $prev_start_date) {
            // 'Start Date must be later than Start Date of previous entry'
            $this->errors['start_date'] = getLanguageText('e0017');
            // use previous start_date plus 1 day
            $fieldarray['start_date'] = $dateobj->addDays($prev_start_date, 1);
        } // if

        return $fieldarray;

    } // checkPrevAddress

    // ****************************************************************************
    function updateNextAddress ($fieldarray)
    // update the start_date of the next address so that it is
    // 1 day later than the end_date of the current address.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $end_date = $fieldarray['end_date'];
        $start_date = $dateobj->addDays($end_date, 1);

        $update_array['person_id']  = $fieldarray['person_id'];
        $update_array['address_no'] = $fieldarray['address_no'] + 1;
        $update_array['start_date'] = $start_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // updateNextAddress

    // ****************************************************************************
    function updatePrevAddress ($fieldarray)
    // update the end_date of the previous address so that it is
    // 1 day earlier than the start_date of the current address.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $start_date = $fieldarray['start_date'];
        $end_date = $dateobj->addDays($start_date, -1);

        $update_array['person_id']  = $fieldarray['person_id'];
        $update_array['address_no'] = $fieldarray['address_no'] -1;
        $update_array['end_date']   = $end_date;
        $this->skip_validation = true;
        $update_array = $this->updateRecord($update_array);

        return $fieldarray;

    } // updatePrevAddress

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (!empty($fieldarray['postcode'])) {
            $pattern = "^[A-Z]{1,2}[0-9]{1,2}[A-Z]{0,1} [0-9]{1}[A-Z]{2}$";
            if (!ereg($pattern, $fieldarray['postcode'])) {
                // 'Invalid format for a postcode.'
                $this->errors['postcode'] = getLanguageText('e0020');
            } // if
        } // if

        if (!empty($fieldarray['telephone_no'])) {
            $pattern = "^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$";
            if (!ereg($pattern, $fieldarray['telephone_no'])) {
                // 'Invalid format for a telephone number.'
                $this->errors['telephone_no'] = getLanguageText('e0021');
            } // if
        } // if

        if (!empty($fieldarray['fax_no'])) {
            $pattern = "^([0-9]{3,5})[ ][0-9]{3,4}[ ]([0-9]{3,4})$";
            if (!ereg($pattern, $fieldarray['fax_no'])) {
                // 'Invalid format for a fax number.'
                $this->errors['fax_no'] = getLanguageText('e0022');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        if ($fieldarray['address_no'] == 1) {
            // if this is first address set start_date to 'noedit'
            $this->fieldspec['start_date']['noedit'] = 'y';
        } else {
            unset($this->fieldspec['start_date']['noedit']);
        } // if

        // look for the highest value for address_no on person_addr table
        $query = "SELECT MAX(address_no) FROM $this->tablename "
               . "WHERE person_id='{$fieldarray['person_id']}'";
        $address_no = $this->getCount($query);

        if ($address_no == $fieldarray['address_no']) {
            // if this is last address set end date to 'noedit'
            $this->fieldspec['end_date']['noedit'] = 'y';
        } else {
            unset($this->fieldspec['end_date']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_formatData

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
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        if (empty($fieldarray['person_id'])) {
            // 'No parent has been selected yet.'
            $this->errors = getLanguageText('sys0082');
            return $fieldarray;
        } // if

        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

        $dbobject->row_locks  = 'SH'; // set row-level locks to shared
        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $person_data = $dbobject->getData_raw("person_id='{$fieldarray['person_id']}'");
        if ($dbobject->numrows <> 1) {
            // 'Could not locate PERSON record'
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        // use data from first row only
        $person_data = $person_data[0];

        // this field is generated, not input by the user
        $this->fieldspec['address_no']['noedit'] = 'y';

        // get last_addr_no and increment it for the new address
        $address_no = $person_data['last_addr_no'] + 1;
        $fieldarray['address_no'] = $address_no;

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
                $address_no = $address_no -1;
                $where = "(person_id='{$person_data['person_id']}' AND address_no='$address_no')" ;
                $this->sql_select = 'start_date,end_date';
                $prev_addr_data = $this->getData_raw($where);
                if ($this->numrows <> 1) {
                    // 'Could not locate previous PERS_ADDR record'
                    $this->errors[] = getLanguageText('e0016');
                    return $fieldarray;
                } // if
                $prev_addr_data = $prev_addr_data[0];
                // use previous start_date plus 1 day
                $start_date = $prev_addr_data['start_date'];
                $start_date = $dateobj->addDays($start_date, 1);
                $fieldarray['start_date'] = $dateobj->getExternalDate($start_date);
            } // if
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record is deleted.
    {
        // do this bit only if a specific address has been selected
        // (ignored if deleting all addresses for a person)
        if (isset($fieldarray['address_no']) AND (int)$fieldarray['address_no'] > 0) {
            // update last_addr_no value on PERSON record
            require_once 'x_person.class.inc';
            $dbobject =& singleton::getInstance('x_person');
            $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
            $person_data = $dbobject->getData_raw("person_id='{$fieldarray['person_id']}'");

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
                $update_array['end_date']   = $person_data[0]['end_date'];
                $this->skip_validation = true;
                $update_array = $this->updateRecord($update_array);
                if ($this->errors) return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

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
            $fieldarray = $this->updatePrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        // get last address number for this person
        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $last_addr_no = $dbobject->getLastAddressNo("person_id='{$fieldarray['person_id']}'");

        $address_no = $fieldarray['address_no'];
        if ($address_no > 1) {
            // update end_date on previous address
            $fieldarray = $this->updatePrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($address_no < $last_addr_no) {
            // update start_date on next address
            $fieldarray = $this->updateNextAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {
        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $person_data = $dbobject->getData_raw("person_id='{$fieldarray['person_id']}'");
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return;
        } // if

        // use data from first row only
        $person_data = $person_data[0];

        if (!isset($fieldarray['address_no'])) {
            // 'You have not selected an address for deletion.'
            $this->errors[] = getLanguageText('e0024');;
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
        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $dbobject->row_locks  = 'SH'; // set row-level locks to shared
        $person_data = $dbobject->getData_raw("person_id='{$fieldarray['person_id']}'");
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        // use data from first row only
        $person_data = $person_data[0];

        $address_no = (int)$fieldarray['address_no'];
        $start_date = $fieldarray['start_date'];
        $end_date   = $fieldarray['end_date'];

        if ($address_no == 1) {
            // first address - start date must be same as person.start_date
            $start_date = $person_data['start_date'];
        } else {
            // check against previous address
            $fieldarray = $this->checkPrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        // newest address must have same end_date as person record
        $end_date = $person_data['end_date'];

        if ($start_date > $end_date) {
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
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        require_once 'x_person.class.inc';
        $dbobject =& singleton::getInstance('x_person');

        $dbobject->sql_select = 'person_id,last_addr_no,start_date,end_date';
        $dbobject->row_locks  = 'SH'; // set row-level locks to shared
        $person_data = $dbobject->getData_raw("person_id='{$fieldarray['person_id']}'");
        if ($dbobject->numrows <> 1) {
            // "Could not locate PERSON record"
            $this->errors[] = getLanguageText('e0023');
            return $fieldarray;
        } // if

        // use data from first row only
        $person_data = $person_data[0];

        $address_no = (int)$fieldarray['address_no'];
        $start_date = $dateobj->getInternaldate($fieldarray['start_date']);
        $end_date   = $dateobj->getInternalDate($fieldarray['end_date']);

        if ($address_no == 1) {
            // first address - start date must be same as person.start_date
            if ($start_date <> $person_data['start_date']) {
                $fieldarray['start_date']   = $person_data['start_date'];
                // 'Cannot change start date of first address.'
                $this->errors['start_date'] = getLanguageText('e0018');
                return $fieldarray;
            } // if
        } else {
            // check against previous address
            $fieldarray = $this->checkPrevAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($address_no == $person_data['last_addr_no']) {
            // latest address must have same end_date as person record
            if ($end_date <> $person_data['end_date']) {
                $fieldarray['end_date']   = $person_data['end_date'];
                // 'Cannot change end date of last address.'
                $this->errors['end_date'] = getLanguageText('e0019');
                return $fieldarray;
            } // if
        } else {
            // check against next address
            $fieldarray = $this->checkNextAddress($fieldarray);
            if ($this->errors) return $fieldarray;
        } // if

        if ($start_date > $end_date) {
            // 'Start Date cannot be later than End Date'
            $this->errors['start_date'] = getLanguageText('e0001');
            // 'End Date cannot be earlier than Start Date'
            $this->errors['end_date']   = getLanguageText('e0002');
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
