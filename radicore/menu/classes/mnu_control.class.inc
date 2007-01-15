<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_control extends Default_Table
{
    // extra vaiables
    var $record_id;         // part of primary key

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_control ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_control';
        $this->dbname      = 'menu';

        $this->record_id = 'SYSTEM';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_control

    // ****************************************************************************
    function getControlData ($field_id, $user_data=null)
    // return one or more specified values from the control table.
    {
        switch (strtoupper($field_id)) {
            case 'PSWD_ENCRYPT':
        	    $where = "record_id='SYSTEM' and field_id='PSWD_ENCRYPT'";
                $data = $this->getData_raw($where);

                if (is_True($data[0]['field_value'])) {
                    return true;
                } else {
                    return false;
                } // if
        		break;

        	case 'PSWD_HIDDEN':
        	    $where = "record_id='SYSTEM' and field_id='PSWD_HIDDEN'";
                $data = $this->getData_raw($where);

                if (is_True($data[0]['field_value'])) {
                    return true;
                } else {
                    return false;
                } // if
        		break;

        	case 'PSWD_FORMAT';
        	    $where = "record_id='SYSTEM' and field_id LIKE 'PSWD_FORMAT%'";
                $rowdata = $this->getData_raw($where);

                // turn multiple rows into a single associative array
                $fieldarray = array();
                foreach ($rowdata as $row => $data) {
                    $fieldarray[strtolower($data['field_id'])] = $data['field_value'];
                } // foreach

                return $fieldarray;
        	    break;

        	case 'PSWD_RETRIES';
        	    $where = "record_id='SYSTEM' and field_id='PSWD_RETRIES'";
                $data = $this->getData_raw($where);

                return $data[0]['field_value'];
        	    break;

        	case 'PSWD_CHANGE';
        	    $where = "record_id='SYSTEM' and field_id='PSWD_CHANGE'";
                $data = $this->getData_raw($where);

                switch ($data[0]['field_value']) {
                    case 'AR':
                        // no change is required
                        break;

                    case 'AD';
                        // check the number of days since password was last changed
                        $where = "record_id='SYSTEM' and field_id='PSWD_DAYS'";
                        $data = $this->getData_raw($where);
                        $count = $data[0]['field_value'];
                        // compare with date in passed data
                        $due_date = strtotime("{$user_data['pswd_chg_date']} +$count days");
                        if ($due_date < strtotime('now')) {
                            return true; // password must be changed
                        } // if
                        break;

                    case 'AL':
                        // check the number of times this user has logged in
                        $where = "record_id='SYSTEM' and field_id='PSWD_COUNT'";
                        $data = $this->getData_raw($where);
                        $count = $data[0]['field_value'];
                        // compare with count in passed data
                        if ($user_data['pswd_count'] > $count) {
                            return true; // password must be changed
                        } // if
                        break;

                    default:
                        break;
                } // if

                return false; // password does not need to be changed
        	    break;

        	case 'PSWD_EXPIRES';
        	    // identify if/when the current password will expire
        	    $where = "record_id='SYSTEM' and field_id='PSWD_CHANGE'";
                $data = $this->getData_raw($where);

                switch ($data[0]['field_value']) {
                    case 'AR':
                        // no change is required
                        break;

                    case 'AD';
                        // identify the number of days warning period
                        $where = "record_id='SYSTEM' and field_id='PSWD_WARNING'";
                        $data = $this->getData_raw($where);
                        $limit = $data[0]['field_value'];

                        // check the number of days since password was last changed
                        $where = "record_id='SYSTEM' and field_id='PSWD_DAYS'";
                        $data = $this->getData_raw($where);
                        $count = $data[0]['field_value'];
                        // compare date in passed data with todays date
                        $due_date = strtotime("{$user_data['pswd_chg_date']} +$count days");
                        $diff_seconds = $due_date - strtotime('now');
                        $diff_days    = floor($diff_seconds / 86400);
                        if ($diff_days > 0) {
                            if ($diff_days <= $limit) {
                                // "Your password will expire in N days"
                                return getLanguageText('e0040', $diff_days);
                            } // if
                        } // if
                        break;

                    case 'AL':
                        // identify the number of logons warning period
                        $where = "record_id='SYSTEM' and field_id='PSWD_WARNING'";
                        $data = $this->getData_raw($where);
                        $limit = $data[0]['field_value'];

                        // check the number of times this user has logged in
                        $where = "record_id='SYSTEM' and field_id='PSWD_COUNT'";
                        $data = $this->getData_raw($where);
                        $count = $data[0]['field_value'];
                        // compare with count in passed data
                        $diff_count = floor($count - $user_data['pswd_count']);

                        if ($diff_count > 0) {
                            if ($diff_count <= $limit) {
                                // "Your password will expire in N logons"
                                return getLanguageText('e0041', $diff_count);
                            } // if
                        } // if
                        break;

                    default:
                        break;
                } // if

                return; // no message
        	    break;

        	case 'DEFAULT_LANGUAGE':
                $where = "record_id='SYSTEM' and field_id='DEFAULT_LANGUAGE'";
                $data = $this->getData_raw($where);

                return $data[0]['field_value'];
                break;

        	case 'SHUTDOWN':
                $where = "record_id='SYSTEM' and field_id LIKE 'SHUTDOWN%'";
                $rowdata = $this->getData_raw($where);
                foreach ($rowdata as $row) {
                	$data[strtolower($row['field_id'])] = $row['field_value'];
                } // foreach

                return $data;
                break;

        	default:
        	    return getLanguageText('e0004', $field_id); // 'Invalid value for field_id';
        	    break;
        } // switch

    } // getControlData

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // default language code
        $fieldspec['default_language']      = array('type' => 'string',
                                                    'size' => 5,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_code');

        // how often must the user change his password?
        $fieldspec['pswd_change']           = array('type' => 'string',
                                                    'size' => 2,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'radiogroup',
                                                    'optionlist' => 'pswd_change',
                                                    'align_hv' => 'vertical');
        // change password after 'n' logons
        $fieldspec['pswd_count']            = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        // change password after 'n' days
        $fieldspec['pswd_days']             = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        // an invalid password can be tried 'n' times after which the user_id will be disabled
        $fieldspec['pswd_retries']          = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        // issue a "password will expire in N days/logons" warning
        $fieldspec['pswd_warning']          = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        // specify the format of user passwords
        $fieldspec['pswd_format_minlen']    = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y',
                                                    'required' => 'y',
                                                    'minvalue' => 1);
        $fieldspec['pswd_format_upper']     = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        $fieldspec['pswd_format_lower']     = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        $fieldspec['pswd_format_digits']    = array('type' => 'integer',
                                                    'size' => 3,
                                                    'unsigned' => 'y');
        // are passwords to be encrypted on the database?
        $fieldspec['pswd_encrypt']          = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');

        // are passwords to be visible in the update/enquiry screens?
        $fieldspec['pswd_hidden']           = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');

        // define lockout times between which system is unavailable
        $fieldspec['shutdown_start']        = array('type' => 'time',
                                                    'size' => 5);
        $fieldspec['shutdown_end']          = array('type' => 'time',
                                                    'size' => 5);
        $fieldspec['shutdown_warning']      = array('type' => 'time',
                                                    'size' => 5);

        $day_names = getLanguageArray('day_names_short');

        $fieldspec['shutdown_monday']       = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['mon'],
                                                    'align_lr' => 'left');

        $fieldspec['shutdown_tuesday']      = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['tue'],
                                                    'align_lr' => 'left');
        $fieldspec['shutdown_wednesday']    = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['wed'],
                                                    'align_lr' => 'left');
        $fieldspec['shutdown_thursday']     = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['thu'],
                                                    'align_lr' => 'left');
        $fieldspec['shutdown_friday']       = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['fri'],
                                                    'align_lr' => 'left');
        $fieldspec['shutdown_saturday']     = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['sat'],
                                                    'align_lr' => 'left');
        $fieldspec['shutdown_sunday']       = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'checkbox',
                                                    'label' => $day_names['sun'],
                                                    'align_lr' => 'left');

        $this->fieldspec = $fieldspec;

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        // if we are validating database data rather than screen data then ignore
        if (isset($fieldarray['record_id'])) {
            return $fieldarray;
        } // if

        // get password length from USER class
        //require_once 'classes/mnu_user.class.inc';
        $dbobject =& singleton::getInstance('mnu_user');

        // encrypt or decrypt all user passwords as required
        $fieldspec = $dbobject->getFieldSpec();
        $pswd_size = (int)$fieldspec['user_password']['size'];
        unset($dbobject);

        if (isset($fieldarray['pswd_change'])) {
            switch ($fieldarray['pswd_change']) {
                case 'AR':
                    // no validation required
                    $fieldarray['pswd_count'] = null;
                    $fieldarray['pswd_days'] = null;
                    break;
                case 'AD':
                    $fieldarray['pswd_count'] = null;
                    if ($fieldarray['pswd_days'] <= 0) {
                        $this->errors['pswd_days'] = getLanguageText('e0005'); // "pswd_days must be > 0";
                    } // if
                    break;
                case 'AL':
                    $fieldarray['pswd_days'] = null;
                    if ($fieldarray['pswd_count'] <= 0) {
                        $this->errors['pswd_count'] = getLanguageText('e0006'); // "pswd_count must be > 0";
                    } // if
                    break;
                default:
                    ;
            } // switch
        } // if

        if ($fieldarray['pswd_format_minlen'] > $pswd_size) {
            $this->errors['pswd_format_minlen'] = getLanguageText('e0007', $pswd_size); // "pswd_format_minlen must be <= $pswd_size";
        } // if

        if ($fieldarray['pswd_format_upper'] > $pswd_size) {
            $this->errors['pswd_format_upper'] = getLanguageText('e0008', $pswd_size); // "pswd_format_upper must be <= $pswd_size";
        } // if

        if ($fieldarray['pswd_format_lower'] > $pswd_size) {
            $this->errors['pswd_format_lower'] = getLanguageText('e0009', $pswd_size); // "pswd_format_lower must be <= $pswd_size";
        } // if

        if ($fieldarray['pswd_format_digits'] > $pswd_size) {
            $this->errors['pswd_format_digits'] = getLanguageText('e0010', $pswd_size); // "pswd_format_digits must be <= $pswd_size";
        } // if

        if (isset($fieldarray['shutdown_start'])) {
            if (!isset($fieldarray['shutdown_end'])) {
        	    // Shutdown End cannot be empty if Shutdown Start is not empty
        	    $this->errors['shutdown_end'] = getLanguageText('e0043');
        	} // if
        	if ($fieldarray['shutdown_start'] >= $fieldarray['shutdown_end']) {
        	    // Shutdown End must be after Shutdown Start
        		$this->errors['shutdown_start'] = getLanguageText('e0044');
        		$this->errors['shutdown_end']   = getLanguageText('e0045');
        	} // if
        } else {
            if (isset($fieldarray['shutdown_end'])) {
        	    // Shutdown Start cannot be empty if Shutdown End is not empty
        	    $this->errors['shutdown_start'] = getLanguageText('e0042');
        	} // if
        	// if SHUTDOWN_START is empty then SHUTDOWN_*DAY must be OFF
        	$fieldarray['shutdown_monday']    = false;
        	$fieldarray['shutdown_tuesday']   = false;
        	$fieldarray['shutdown_wednesday'] = false;
        	$fieldarray['shutdown_thursday']  = false;
        	$fieldarray['shutdown_friday']    = false;
        	$fieldarray['shutdown_saturday']  = false;
        	$fieldarray['shutdown_sunday']    = false;
        } // if

        if (isset($fieldarray['shutdown_warning'])) {
            if (!isset($fieldarray['shutdown_start'])) {
        	    // Shutdown Warning cannot be non-empty if Shutdown Start is empty
        	    $this->errors['shutdown_warning'] = getLanguageText('e0046');
        	} // if
        	if ($fieldarray['shutdown_warning'] >= $fieldarray['shutdown_start']) {
        	    // Shutdown Warning must be before Shutdown Start
        		$this->errors['shutdown_warning'] = getLanguageText('e0047');
        	} // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'mnu_user';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // get options for pswd_change and insert in LOOKUP data
        $array = $this->getValRep('pswd_change');
        $this->lookup_data['pswd_change'] = $array;

        // get options for language_code
        $array = getLanguageArray('languages');
        $this->lookup_data['language_code'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'pswd_change') {
//            $array['AR'] = 'At Random';
//            $array['AL'] = "After 'n' logons";
//            $array['AD'] = "After 'n' days";
            $array = getLanguageArray('pswd_change');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // turn multiple rows into a single associative array
        foreach ($rowdata as $row => $data) {
            $fieldarray[0][strtolower($data['field_id'])] = $data['field_value'];
        } // foreach

        // get list of (virtual) fields in this table
        $fieldspec = $this->getFieldSpec();

        // insert any missing fields from $fieldspec
        foreach ($fieldspec as $fieldname => $spec) {
            if (!array_key_exists(strtolower($fieldname), $fieldarray[0])) {
                $fieldarray[0][$fieldname] = null;
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        if (strtolower($fieldarray['field_id']) == 'pswd_encrypt') {
            // if 'pswd_encrypt' has changed then process the change
            if ($fieldarray['field_value'] <> $old_data['field_value']) {
                // open up a dialog with the user class
                //require_once 'classes/mnu_user.class.inc';
                $dbobject =& singleton::getInstance('mnu_user');
                // encrypt or decrypt all user passwords as required
                $errors = $dbobject->setPasswords($fieldarray['field_value']);
                unset($dbobject);
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
        // limit selection by contents of RECORD_ID column
        $this->record_id = 'SYSTEM';
        $where = "record_id='$this->record_id'";

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_updateSelection($fieldarray, $replace)
    // update multiple rows in a single operation.
    {
        $errors = array();
        $this->fieldarray = $fieldarray;

        // perform standard declarative checks on input data
        $updatearray = $this->_validateUpdate($fieldarray);
        if (!empty($this->errors)) {
            return $fieldarray;
        } // if

        // perform any custom validation/processing before update
        $updatearray = $this->_cm_commonValidation($updatearray, null);
        if (!empty($this->errors)) {
            return $fieldarray;
        } // if

        // now set $fieldspec to the database view
        $this->fieldspec = $this->getFieldSpec_original();

        // get array of fieldnames in the primary key
        $pkeynames = $this->getPkeyNames();

        // now turn the array of columns into an array of rows
        $rowdata = array();
        $rownum = 0;
        foreach ($updatearray as $fieldname => $fieldvalue) {
            $rowdata[$rownum]['record_id']   = $this->record_id;
            $rowdata[$rownum]['field_id']    = $fieldname;
            $rowdata[$rownum]['field_value'] = $fieldvalue;
            // construct 'where' clause from primary key
            $where = array2where($rowdata[$rownum], $pkeynames, $this);

            // find out if this record currently exists or not
            $count = $this->getCount($where);
            if ($count == 0) {
                // record does not exist, so create it
                $rowdata[$rownum] = $this->insertRecord($rowdata[$rownum]);
            } else {
                // record already exists, so update it
                $rowdata[$rownum] = $this->updateRecord($rowdata[$rownum]);
            } // if

            if (!empty($this->errors)) {
                // ignore 'name' and extract 'value' from $this->errors
                // as 'name' may not be the same as $fieldname
                $errors[$fieldname] = array_shift($this->errors);
            } // if
            $rownum = $rownum + 1;
        } // foreach

        $this->errors = $errors;

        return $fieldarray;

    } // _cm_updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
