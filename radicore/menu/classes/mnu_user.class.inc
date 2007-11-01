<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_user extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_user ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_user';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_user

    // ****************************************************************************
    function checkPasswords ($switch)
    // encrypt or decrypt all user passwords according to $switch
    {
        $crypt_obj =& singleton::getInstance('encryption_class');

        // read records for all current users
        $this->sql_select = 'user_id,user_password';
        $rowdata = $this->getData_raw(null);
        if ($this->errors) {
            return $this->errors;
        } // if

        // get size of password field
        $size = $this->fieldspec['user_password']['size'];

        // step through all database rows
        foreach ($rowdata as $row => $data) {
            // encrypt or decrypt user password according to $switch
            if (is_True($switch)) {
                $password = $crypt_obj->encrypt($data['user_id'], $data['user_password'], $size);
            } else {
                $password = $crypt_obj->decrypt($data['user_id'], $data['user_password']);
            } // if
            if ($crypt_obj->errors) {
            	$this->errors['user_password'] = getLanguageText('e0048', $data['user_id']) .' - ' .$crypt_obj->errors[0];
            	return $this->errors;
            } // if
        } // foreach

        unset ($crypt_obj);

        return $this->errors;

    } // checkPasswords

    // ****************************************************************************
    function setPasswords ($switch)
    // encrypt or decrypt all user passwords according to $switch
    {
        $crypt_obj =& singleton::getInstance('encryption_class');

        // read records for all current users
        $this->sql_select = 'user_id,user_password';
        $rowdata = $this->getData_raw(null);
        if ($this->errors) {
            return $this->errors;
        } // if

        // get size of password field
        $size = $this->fieldspec['user_password']['size'];

        // step through all database rows
        foreach ($rowdata as $row => $data) {
            // encrypt or decrypt user password according to $switch
            if (is_True($switch)) {
                $password = $crypt_obj->encrypt($data['user_id'], $data['user_password'], $size);
            } else {
                $password = $crypt_obj->decrypt($data['user_id'], $data['user_password']);
            } // if
            if ($crypt_obj->errors) {
            	$this->errors['user_password'] = $crypt_obj->errors[0];
            	return $this->errors;
            } // if
            // now update this record on the database
            $newdata = $data;
            $newdata['user_password'] = $password;
            $this->_dml_updateRecord($newdata, $data);
            if ($this->errors) {
                return $this->errors;
            } // if
        } // foreach

        unset ($crypt_obj);

        return $this->errors;

    } // setPasswords

    // ****************************************************************************
    function validatePassword ($password, $format)
    // validate $password against specification in $format
    {
        $format_minlen = (int)$format['pswd_format_minlen'];
        $format_digits = (int)$format['pswd_format_digits'];
        $format_lower  = (int)$format['pswd_format_lower'];
        $format_upper  = (int)$format['pswd_format_upper'];

        if ($format_minlen > 0) {
            if (strlen($password) < $format_minlen) {
                return getLanguageText('e0025', $format_minlen); // "Password must have at least $format_minlen characters";
            } // if
        } // if

        if ($format_digits > 0) {
            $digits = preg_match_all("([0-9])", $password, $regs);
            if ($digits < $format_digits) {
                return getLanguageText('e0026', $format_digits); // "Password must have at least $format_digits digits";
            } // if
        } // if

        if ($format_lower > 0) {
            $lower = preg_match_all("([a-z])", $password, $regs);
            if ($lower < $format_lower) {
                return getLanguageText('e0027', $format_lower); // "Password must have at least $format_lower lowercase characters";
            } // if
        } // if

        if ($format_upper > 0) {
            $upper = preg_match_all("([A-Z])", $password, $regs);
            if ($upper < $format_upper) {
                return getLanguageText('e0028', $format_upper); // "Password must have at least $format_upper uppercase characters";
            } // if
        } // if

        return;

    } // validatePassword

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // find out if user passwords are to be hidden or not
        static $pswd_hidden;
        if (!is_bool($pswd_hidden)) {
        	$dbobject =& singleton::getInstance('mnu_control');
            $pswd_hidden = $dbobject->getControlData('pswd_hidden');
            unset($dbobject);
        } // if

        global $mode;
        if ($mode == 'search') {
            // remove certain 'noedit' flags
            unset($this->fieldspec['pswd_chg_date']['noedit']);
            unset($this->fieldspec['pswd_chg_time']['noedit']);
            unset($this->fieldspec['pswd_count']['noedit']);
            unset($this->fieldspec['logon_date']['noedit']);
            unset($this->fieldspec['logon_time']['noedit']);
            $this->fieldspec['user_password']['nodisplay'] = 'y';
            unset($this->fieldspec['ip_address']['noedit']);

        } elseif ($mode == 'insert') {
            // these fields should not appear on INSERT screen
            $this->fieldspec['pswd_chg_date']['nodisplay'] = 'y';
            $this->fieldspec['pswd_chg_time']['nodisplay'] = 'y';
            $this->fieldspec['pswd_count']['nodisplay']    = 'y';
            $this->fieldspec['in_use']['nodisplay']        = 'y';
            $this->fieldspec['is_disabled']['nodisplay']   = 'y';
            $this->fieldspec['logon_date']['nodisplay']    = 'y';
            $this->fieldspec['logon_time']['nodisplay']    = 'y';
            $this->fieldspec['ip_address']['nodisplay']    = 'y';
        } else {
            if ($pswd_hidden) {
            	// not insert mode, so cannot edit this field
                $this->fieldspec['user_password']['nodisplay'] = 'y';
            } else {
                // not insert mode, so cannot edit this field
                $this->fieldspec['user_password']['noedit'] = 'y';
            } // if
        } // if

        if (!empty($_SESSION['rdcaccount_id'])) {
        	$this->fieldspec['rdcaccount_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $start_date = $fieldarray['start_date'];
        $end_date   = $fieldarray['end_date'];

        if ($start_date > $end_date) {
            // 'Start Date cannot be later than End Date';
            $this->errors['start_date'] = getLanguageText('e0036');
            // 'End Date cannot be earlier than Start Date';
            $this->errors['end_date']   = getLanguageText('e0037');
        } // if

        global $mode;

        if ($mode <> 'insert') {
            if (get_class($this) == $this->tablename
            or  strtolower(get_class($this)) == 'logon') {
                // cannot update password in parent class or in logon screen
                unset($fieldarray['user_password']);
                unset($originaldata['user_password']);
            } // if
        } // if

        // find out if user passwords are encrypted or not
        $dbobject =& singleton::getInstance('mnu_control');

        $encrypt_flag = $dbobject->getControlData('pswd_encrypt');
        $pswd_format  = $dbobject->getControlData('pswd_format');
        unset($dbobject);

        if ($GLOBALS['task_id'] != 'logon') {
        	// use new_password1 (if it exists) else use user_password
            if (isset($fieldarray['new_password1'])) {
                // check that password has correct format
                if ($error = $this->validatePassword ($fieldarray['new_password1'], $pswd_format)) {
                    $this->errors['new_password1'] = $error;
                    //$fieldarray['new_password1']   = null;
                    //$fieldarray['new_password2']   = null;
                    return $fieldarray;
                } else {
                    $fieldarray['user_password'] = $fieldarray['new_password1'];
                } // if
            } elseif (isset($fieldarray['user_password'])) {
                // check that password has correct format
                if ($error = $this->validatePassword ($fieldarray['user_password'], $pswd_format)) {
                    $this->errors['user_password'] = $error;
                    $fieldarray['user_password'] = null;
                    return $fieldarray;
                } // if
            } // if
        } // if

        // if both 'user_id' and 'user_password' exist then encrypt the password
        if (isset($fieldarray['user_id']) AND isset($fieldarray['user_password'])) {
            // always encryptstring to ensure it has valid characters
            $crypt_obj =& singleton::getInstance('encryption_class');
            $key = $fieldarray['user_id'];
            $string = $fieldarray['user_password'];
            $spec = $this->fieldspec['user_password'];
            $encrypted_string = $crypt_obj->encrypt($key, $string, $spec['size']);
            if ($crypt_obj->errors) {
                if (isset($fieldarray['new_password1'])) {
                	$this->errors['new_password1'] = $crypt_obj->errors[0];
                } else {
            	    $this->errors['user_password'] = $crypt_obj->errors[0];
                } // if
                return $fieldarray;
            } else {
                if ($encrypt_flag) {
                    // replace string with encrypted version
                    $fieldarray['user_password'] = $encrypted_string;
                    // insert dummy field to say that password has been encrypted
                    $fieldarray['pswd_is_encrypted'] = true;
                } // if
            } // if
        } // if

		if (isset($fieldarray['user_password'])) {
		    if ($fieldarray['user_password'] != $originaldata['user_password']) {
            	// set change date and time, and reset count
            	$fieldarray['pswd_chg_date'] = getTimeStamp('date');
            	$fieldarray['pswd_chg_time'] = getTimeStamp('time');
            	$fieldarray['pswd_count']    = 0;
        	} // if
		} // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        static $encrypt_flag = null;
        if (!is_bool($encrypt_flag)) {
        	$dbobject =& singleton::getInstance('mnu_control');
            $encrypt_flag = $dbobject->getControlData('pswd_encrypt');
        } // if

        if ((isset($fieldarray['pswd_is_encrypted']) and $fieldarray['pswd_is_encrypted']) or $encrypt_flag == true) {
        	// decrypt the password (if it is encrypted)
            if (!empty($fieldarray['user_id']) and !empty($fieldarray['user_password'])) {
                // find out if user passwords are encrypted or not
                if ($encrypt_flag) {
                    //require_once 'std.encryption.class.inc';
                    $crypt_obj =& singleton::getInstance('encryption_class');
                    $key = $fieldarray['user_id'];
                    $string = $fieldarray['user_password'];
                    $fieldarray['user_password'] = $crypt_obj->decrypt($key, $string);
                    if ($crypt_obj->errors) {
                    	$this->errors['user_password'] = $crypt_obj->errors[0];
                    } // if
                    //$this->errors = array_merge($this->errors, $crypt_obj->errors);
                } // if
            } // if
            unset($fieldarray['pswd_is_encrypted']);
        } // if

        return $fieldarray;

    } // _cm_formatData

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
                $lock_array['READ'][] = 'mnu_control';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array['READ'][] = 'mnu_control';
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
        if (!array_key_exists('role_id', $this->lookup_data)) {
            // get contents of foreign table MNU_ROLE and put into lookup_data
            $dbobject =& singleton::getInstance('mnu_role');
            $array = $dbobject->getValRep('role_id');
            $this->lookup_data['role_id'] = $array;
        } // if

        if (!array_key_exists('language_code', $this->lookup_data)) {
            // get array of language codes
            $array = getLanguageArray('languages');
            $this->lookup_data['language_code'] = $array;
        } // if

        if (!array_key_exists('rdcaccount_id', $this->lookup_data)) {
            // get contents of foreign table and put into lookup_data
            $dbobject =& singleton::getInstance('mnu_account');
            $array = $dbobject->getValRep('rdcaccount_id');
            $this->lookup_data['rdcaccount_id'] = $array;
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
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'user_id') {
            // get data from the database
            $this->sql_select     = 'user_id, user_name';
            $this->sql_orderby    = 'user_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where)
    // perform any initialisation for the current task.
    {
        // this may be called from the home page, so insert user's id
        if (empty($where)) {
            $pattern_id = getPatternId();
            if (eregi('upd1|enq1', $pattern_id)) {
            	$where = "user_id='" .$_SESSION['logon_user_id'] ."'";
            } // if
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['user_id'] = 'Total count:';
        $array['user_name'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count++;
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        static $encrypt_flag = null;

        if (!is_bool($encrypt_flag)) {
        	$dbobject =& singleton::getInstance('mnu_control');
            $encrypt_flag = $dbobject->getControlData('pswd_encrypt');
        } // if

        if ($encrypt_flag == true) {
        	foreach ($rows as $row => $rowdata) {
                // insert dummy field to say that data is currently encrypted
            	$rows[$row]['pswd_is_encrypted'] = true;
            } // foreach
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        if (isset($rowdata['user_password'])) {
            // if pswd is being input it has not been encrypted yet
        	unset($rowdata['pswd_is_encrypted']);
        } // if

        return $rowdata;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        if (isset($rowdata['user_password'])) {
            $spec = $this->fieldspec['user_password'];
            if (isset($spec['noedit']) or isset($spec['nodisplay'])) {
            	// not being input by user, so leave alone
            } else {
                // if pswd is being input it has not been encrypted yet
            	unset($rowdata['pswd_is_encrypted']);
            } // if
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
