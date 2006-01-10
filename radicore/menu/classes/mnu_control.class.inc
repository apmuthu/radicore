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
                $data = $this->getData_unformatted($where);

                if (is_True($data[0]['field_value'])) {
                    return true;
                } else {
                    return false;
                } // if
        		break;

        	case 'PSWD_FORMAT';
        	    $where = "record_id='SYSTEM' and field_id LIKE 'PSWD_FORMAT%'";
                $rowdata = $this->getData_unformatted($where);

                // turn multiple rows into a single associative array
                $fieldarray = array();
                foreach ($rowdata as $row => $data) {
                    $fieldarray[strtolower($data['field_id'])] = $data['field_value'];
                } // foreach

                return $fieldarray;
        	    break;

        	case 'PSWD_RETRIES';
        	    $where = "record_id='SYSTEM' and field_id='PSWD_RETRIES'";
                $data = $this->getData_unformatted($where);

                return $data[0]['field_value'];
        	    break;

        	case 'PSWD_CHANGE';
        	    $where = "record_id='SYSTEM' and field_id='PSWD_CHANGE'";
                $data = $this->getData_unformatted($where);

                switch ($data[0]['field_value']) {
                    case 'AR':
                        // no change is required
                        break;

                    case 'AD';
                        // check the number of days since password was last changed
                        $where = "record_id='SYSTEM' and field_id='PSWD_DAYS'";
                        $data = $this->getData_unformatted($where);
                        $count = $data[0]['field_value'];
                        $due_date = strtotime("{$user_data['pswd_chg_date']} +$count days");
                        if ($due_date < strtotime('now')) {
                            return true; // password must be changed
                        } // if
                        break;

                    case 'AL':
                        // check the number of times this user has logged in
                        $where = "record_id='SYSTEM' and field_id='PSWD_COUNT'";
                        $data = $this->getData_unformatted($where);
                        $count = $data[0]['field_value'];
                        if ($user_data['pswd_count'] > $count) {
                            return true; // password must be changed
                        } // if
                        break;

                    default:
                        break;
                } // if

                return false;
        	    break;

        	case 'DEFAULT_LANGUAGE':
                $where = "record_id='SYSTEM' and field_id='DEFAULT_LANGUAGE'";
                $data = $this->getData_unformatted($where);

                return $data[0]['field_value'];
                break;

        	default:
        	    return getLanguageText('e0004', $field_id); // 'Invalid value for field_id';
        	    break;
        } // switch

    } // getControlData

    // ****************************************************************************
    function getFieldSpec ()
    // return array of field specifications.
    // This is a special version as this table contains columns labelled
    // 'field_id' and 'field_value' which are costructed as follows:
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
                                                    'align' => 'vertical');
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

        if (!empty($this->field_access)) {
            // include specified access_type in $fieldspec array
            foreach ($this->field_access as $field_id => $access_type) {
                if (array_key_exists($field_id, $fieldspec)) {
                    $fieldspec[$field_id][$access_type] = 'y';
                } // if
            } // foreach
        } // if

        return $fieldspec;

    } // getFieldSpec

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        // if we are validating database data rather than screen data then ignore
        if (isset($fieldarray['record_id'])) {
            return $fieldarray;
        } // if

        // get password length from USER class
        require_once 'mnu_user.class.inc';
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
        //DebugBreak();
        // get options for pswd_change and insert in LOOKUP data
        $array = $this->getValRep('pswd_change');
        $this->lookup_data['pswd_change'] = $array;

        // get options for language_code
        $array = getLanguageArray('languages');
        $this->lookup_data['language_code'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
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
                require_once 'mnu_user.class.inc';
                $dbobject =& singleton::getInstance('mnu_user');
                // encrypt or decrypt all user passwords as required
                $errors = $dbobject->setPasswords($fieldarray['field_value']);
                unset($dbobject);
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
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
        //DebugBreak();
        $errors = array();
        $this->fieldarray = $fieldarray;

        // set $fieldspec to the user view
        $this->fieldspec = $this->getFieldSpec();

        // perform standard declarative checks on input data
        $updatearray = $this->validateUpdate($fieldarray);
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
            $where = array2where($rowdata[$rownum], $pkeynames);

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
