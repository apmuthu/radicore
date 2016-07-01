<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_user extends Default_Table
{
    var $count;             // record count for PDF output
    var $pswd_hidden;       // is password field displayed or hidden?
    var $pswd_encrypt;      // is password encrypted in the database?
    var $pswd_format;       // password format

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_user ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'mnu_user';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_user

    // ****************************************************************************
    function getFieldSpec_original ()
    // set the specifications for this database table.
    {
        $fieldspec = parent::getFieldSpec_original();

        // remove references to any relationships which do not exist in this installation
        foreach ($this->child_relations as $index => $relation) {
            if (isset($relation['subsys_dir'])) {
                $classname = '../'. $relation['subsys_dir'] .'/classes/' .$relation['child'] .'.class.inc';
                if (!file_exists($classname)) {
                    unset($this->child_relations[$index]);
                } // if
            } // if
        } // foreach

        return $fieldspec;

    } // getFieldSpec_original

    // ****************************************************************************
    function switchPasswords ($switch)
    // encrypt or decrypt all user passwords according to $switch
    {
        $crypt_obj =& RDCsingleton::getInstance('encryption_class');

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

    } // switchPasswords

    // ****************************************************************************
    function validatePassword ($user_id, $password, $ip_address=null, $external_auth_off=false)
    // check that this user's password matches that in the database
    {
        $logonarray['user_id']       = $user_id;
        $logonarray['user_password'] = $password;

        $mnu_control =& RDCsingleton::getInstance('mnu_control');

        if (is_True($external_auth_off)) {
            // do not use External Authentication
            $auth_array['authentication'] = 'INTERNAL';
        } else {
            $auth_array = $mnu_control->getControlData('authentication');
            if (empty($auth_array)) {
                $auth_array['authentication'] = 'INTERNAL';  // data missing, so use this default
            } // if
        } // if

        if ($auth_array['authentication'] != 'INTERNAL') {
            // external authentication is turned ON globally, but is it turned off for this USER or ROLE
            $this->sql_select = 'mnu_user.user_id, mnu_user_role.role_id'
                              . ", CASE WHEN mnu_user.is_external_auth_off='Y' THEN 'Y' ELSE mnu_role.is_external_auth_off END AS is_external_auth_off";
            $this->sql_from   = 'mnu_user'
                              ." LEFT JOIN mnu_user_role ON (mnu_user_role.user_id=mnu_user.user_id AND mnu_user_role.is_primary='Y')"
                              .' LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user_role.role_id)';
            $where = "mnu_user.user_id='" .addslashes($logonarray['user_id']) ."'";
            $fieldarray = $this->getData_raw($where);
            if (is_True($fieldarray[0]['is_external_auth_off'])) {
                $auth_array['authentication'] = 'INTERNAL';
            } // if
        } // if
        if ($auth_array['authentication'] != 'INTERNAL') {
            $this->fieldspec['user_password']['size'] = 40;
        } // if

        if (is_True($external_auth_off)) {
            // do not use External Authentication
            $auth_array['authentication'] = 'INTERNAL';
        } else {
            $auth_array = $mnu_control->getControlData('authentication');
            if (empty($auth_array)) {
                $auth_array['authentication'] = 'INTERNAL';  // data missing, so use this default
            } // if
            if ($auth_array['authentication'] != 'INTERNAL') {
                // external authentication is turned ON globally, but is it turned off for this USER or ROLE
                $this->sql_select = 'mnu_user.user_id, mnu_user_role.role_id'
                                  . ", CASE WHEN mnu_user.is_external_auth_off='Y' THEN 'Y' ELSE mnu_role.is_external_auth_off END AS is_external_auth_off";
                $this->sql_from   = 'mnu_user'
                                  ." LEFT JOIN mnu_user_role ON (mnu_user_role.user_id=mnu_user.user_id AND mnu_user_role.is_primary='Y')"
                                  .' LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user_role.role_id)';
                $where = "mnu_user.user_id='" .addslashes($logonarray['user_id']) ."'";
                $fieldarray = $this->getData_raw($where);
                if (is_True($fieldarray[0]['is_external_auth_off'])) {
                    $auth_array['authentication'] = 'INTERNAL';
                } // if
            } // if
            if ($auth_array['authentication'] != 'INTERNAL') {
                $this->fieldspec['user_password']['size'] = 40;
            } // if
        } // if

        $updatearray['user_password'] = $password;
        $updatearray['user_id']       = $user_id;

        $this->fieldarray = $updatearray;
        if (!empty($this->errors)) return $this->errors;

        // find out if user passwords are encrypted or not
        $encrypt_flag = $mnu_control->getControlData('pswd_encrypt');

        if ($auth_array['authentication'] != 'INTERNAL') {
            // no need to encrypt the password
            $logon_password = $password;
        } elseif ($encrypt_flag === true) {
            // encrypt the password to include in database lookup
            $crypt_obj =& RDCsingleton::getInstance('encryption_class');
            $spec = $this->fieldspec['user_password'];
            $logon_password = $crypt_obj->encrypt($user_id, $password, $spec['size']);
            if ($crypt_obj->errors) {
                $this->errors = $crypt_obj->errors;
                return false;
            } // if
            unset($crypt_obj);
        } else {
            $logon_password = $password;
        } // if

        // join to MNU_ROLE to obtain start_task_id
        $this->sql_select = 'mnu_user.user_id, user_name, user_password, start_date, end_date, is_disabled, pswd_count, pswd_chg_date, mnu_user.language_id, email_addr, rdcaccount_id, external_id, party_id, user_timezone, mnu_user_role.role_id, mnu_role.start_task_id ';
        $this->sql_from   = 'mnu_user'
                          ." LEFT JOIN mnu_user_role ON (mnu_user_role.user_id=mnu_user.user_id AND mnu_user_role.is_primary='Y')"
                          .' LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user_role.role_id)';
        $where = "mnu_user.user_id='" .addslashes($user_id) ."'";
        $user_id = addslashes($user_id);
        if (!empty($ip_address)) {
            // lookup on MNU_USER_IP_ADDRESS to see if this IP address is valid
            $this->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE user_id='$user_id') = 0 THEN true"
                                      ." WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE user_id='$user_id' AND ip_address='$ip_address') = 1 THEN true"
                                      ." ELSE false"
                                 ." END AS ip_address_valid";
        } // if
        $this->sql_select .= ", (SELECT GROUP_CONCAT(role_id ORDER BY role_id SEPARATOR ',') FROM mnu_user_role WHERE user_id=mnu_user.user_id) AS role_list";
        // fetch the user's language with any date formats
        $this->sql_select .= ', mnu_language.input_date_format, mnu_language.output_date_format';
        $this->sql_from   .= " LEFT JOIN mnu_language ON ( mnu_language.language_id=COALESCE(mnu_user.language_id, '{$_SESSION['default_language']}'))";
        if ($auth_array['authentication'] == 'INTERNAL') {
            // include user_password in selection criteria
            $where .= " AND user_password='" .addslashes($logon_password) ."'";
        } // if
        $fieldarray = $this->getData_raw($where);
        if ($this->numrows <> 1) {
            $this->errors['user_password'] = getLanguageText('sys0142'); // 'Security violation';
            return $logonarray;
        } // if
        $fieldarray = $fieldarray[0];

        if ($auth_array['authentication'] != 'INTERNAL') {
            if (empty($fieldarray['external_id'])) {
                $fieldarray['external_id'] = $logon_user_id;
            } // if
            if ($auth_array['authentication'] == 'RADIUS') {
                $radius = RDCsingleton::getInstance('radius_class');
                $result = $radius->authenticate($fieldarray['external_id'], $logon_password);
                if ($result == RADIUS_ACCESS_ACCEPT) {
                    // continue
                } else {
                    // 'RADIUS authentication has failed'
                    $this->errors[] = getLanguageText('sys0174');
                    $fieldarray = $logonarray;
                    return $this->errors;
                } // if
            } elseif ($auth_array['authentication'] == 'LDAP') {
                $ldap = RDCsingleton::getInstance('ldap_class');
                $result = $ldap->authenticate($fieldarray['external_id'], $logon_password);
                if ($result === true) {
                    // continue
                } else {
                    // 'LDAP authentication has failed'
                    $this->errors[] = getLanguageText('sys0176');
                    $this->errors[] = getLanguageText('sys0177', $result);
                    $fieldarray = $logonarray;
                    return $this->errors;
                } // if
            } // if
        } // if

        $fieldarray['authentication'] = $auth_array['authentication'];

        return $fieldarray;

    } // validatePassword

    // ****************************************************************************
    function setPasswords ($switch)
    // encrypt or decrypt all user passwords according to $switch
    {
        $crypt_obj =& RDCsingleton::getInstance('encryption_class');

        $rdcaccount_id = $_SESSION['rdcaccount_id'];    // save
        $_SESSION['rdcaccount_id'] = null;              // operate on ALL accounts, not just user's account

        // read records for all current users
        $this->sql_select = 'user_id,user_password';
        $rowdata = $this->getData_raw(null);
        if ($this->errors) {
            return $this->errors;
        } // if

        $_SESSION['rdcaccount_id'] = $rdcaccount_id;    // restore

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
    function validatePasswordFormat ($password, $format)
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

    } // validatePasswordFormat

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
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
            // add field to allow searching on the MNU_USER_ROLE table
            $this->fieldspec['role_id']     = array('type' => 'string',
                                                    'size' => 16,
                                                    //'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'role_id');

        } elseif ($mode == 'insert' AND is_True($this->initiated_from_controller)) {
            // these fields should not appear on INSERT screen
            $this->fieldspec['pswd_chg_date']['nodisplay'] = 'y';
            $this->fieldspec['pswd_chg_time']['nodisplay'] = 'y';
            $this->fieldspec['pswd_count']['nodisplay']    = 'y';
            $this->fieldspec['in_use']['nodisplay']        = 'y';
            $this->fieldspec['is_disabled']['nodisplay']   = 'y';
            $this->fieldspec['logon_date']['nodisplay']    = 'y';
            $this->fieldspec['logon_time']['nodisplay']    = 'y';
            $this->fieldspec['ip_address']['nodisplay']    = 'y';
            // add field which will be written to the MNU_USER_ROLE table
            $this->fieldspec['role_id']     = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    //'nondb' => 'y',
                                                    'optionlist' => 'role_id');
        } else {
            if ($this->pswd_hidden) {
            	// not insert mode, so cannot edit this field
                $this->fieldspec['user_password']['nodisplay'] = 'y';
            } else {
                // not insert mode, so cannot edit this field
                $this->fieldspec['user_password']['noedit'] = 'y';
            } // if
        } // if

        if ($mode == 'update') {
            $this->fieldspec['user_roles']      = array('type' => 'string',
                                                        'control' => 'input',
                                                        'nondb' => 'y',
                                                        'task_id' => 'mnu_user_role(list2)');
            if (empty($where)) {
                if (empty($fieldarray['user_roles'])) {
                    $fieldarray['user_roles'] = null;
                } // if
            } // if
        } // if

        if ($_SESSION['rdcaccount_id'] <= 1) {
            // this user is able to set this field to anything
            unset($this->fieldspec['rdcaccount_id']['noedit']);
            unset($this->fieldspec['rdcaccount_id']['nodisplay']);
        } else {
            // account is fixed, so cannot be changed
        	$this->fieldspec['rdcaccount_id']['noedit'] = 'y';
        } // if

        if (version_compare(phpversion(), '5.2.0', '<')) {
            // not available in this version
            $this->fieldspec['user_timezone']['nodisplay'] = 'y';
        } // if

//        if (empty($where) AND !empty($fieldarray)) {
//            if (!isset($fieldarray['abc'])) $fieldarray['abc'] = 'anything';
//        } // if

        return $fieldarray;

    } // _cm_changeConfig

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

        global $mode;

        if ($mode <> 'insert') {
            if (get_class($this) == $this->tablename
            or  strtolower(get_class($this)) == 'logon') {
                // cannot update password in parent class or in logon screen
                unset($fieldarray['user_password']);
                unset($originaldata['user_password']);
            } // if
        } // if

    	// use new_password1 (if it exists) else use user_password
        if (isset($fieldarray['new_password1'])) {
            $password_name = 'new_password1';
        } else {
            $password_name = 'user_password';
        } // if
        if (isset($fieldarray[$password_name])) {
            $password_value = $fieldarray[$password_name];
            // check that password has correct format
            if ($error = $this->validatePasswordFormat ($password_value, $this->pswd_format)) {
                $this->errors[$password_name] = $error;
                return $fieldarray;
            } // if
        } // if

        // if both 'user_id' and 'user_password' exist then encrypt the password
        if (!empty($fieldarray['user_id']) AND !empty($password_value)) {
            if (is_True($this->pswd_encrypt)) {
                // always encrypt string to ensure it has valid characters
                $crypt_obj =& RDCsingleton::getInstance('encryption_class');
                $key    = $fieldarray['user_id'];
                $spec   = $this->fieldspec['user_password'];
                $encrypted_string = $crypt_obj->encrypt($key, $password_value, $spec['size']);
                if ($crypt_obj->errors) {
                    $this->errors[$password_name] = $crypt_obj->errors[0];
                    return $fieldarray;
                } else {
                    // replace plain text string with encrypted version
                    $fieldarray['user_password'] = $encrypted_string;
                    // insert dummy field to say that password has been encrypted
                    $fieldarray['pswd_is_encrypted'] = true;
                    $this->fields_not_for_trimming[] = 'user_password';  // do not trim() this field
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

		if (!empty($fieldarray['user_timezone']) AND is_numeric($fieldarray['user_timezone'])) {
		    // convert from index to value
			$array = DateTimeZone::listIdentifiers();
			$fieldarray['user_timezone'] = $array[$fieldarray['user_timezone']];
		} // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if (is_True($this->pswd_encrypt)) {
        	if (isset($fieldarray['pswd_is_encrypted']) AND is_True($fieldarray['pswd_is_encrypted'])) {
            	// decrypt the password
                if (!empty($fieldarray['user_id']) AND !empty($fieldarray['user_password'])) {
                    $crypt_obj =& RDCsingleton::getInstance('encryption_class');
                    $key    = $fieldarray['user_id'];
                    $string = $fieldarray['user_password'];
                    $fieldarray['user_password'] = $crypt_obj->decrypt($key, $string);
                    if ($crypt_obj->errors) {
                    	$this->errors['user_password'] = $crypt_obj->errors[0];
                    } // if
                } // if
                unset($fieldarray['pswd_is_encrypted']);
            } // if
        } // if

        if (isset($_SESSION['timezone_server']) AND isset($_SESSION['timezone_client'])) {
            $dateobj =& RDCsingleton::getInstance('date_class');
            // combine 'date' and 'time' fields before performing timezone conversion
            $date = $fieldarray['logon_date'];
            $time = $fieldarray['logon_time'];
            $fieldarray['logon_date'] = convertTZdate($date, $time, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
            $fieldarray['logon_date'] = $dateobj->getExternalDate($fieldarray['logon_date']);
            $fieldarray['logon_time'] = convertTZtime($date, $time, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
            $date = $fieldarray['pswd_chg_date'];
            $time = $fieldarray['pswd_chg_time'];
            $fieldarray['pswd_chg_date'] = convertTZdate($date, $time, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
            $fieldarray['pswd_chg_date'] = $dateobj->getExternalDate($fieldarray['pswd_chg_date']);
            $fieldarray['pswd_chg_time'] = convertTZtime($date, $time, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
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
            $dbobject =& RDCsingleton::getInstance('mnu_role');
            $array = $dbobject->getValRep('role_id');
            $this->lookup_data['role_id'] = $array;
        } // if

        if (!array_key_exists('language_id', $this->lookup_data)) {
            // get array of all supported language codes
            $dbobject =& RDCsingleton::getInstance('mnu_language');
            $array = $dbobject->getValRep('language_id');
//            if (!empty($_SESSION['default_language'])) {
//                // remove default language as an option in this screen
//            	unset($array[strtoupper($_SESSION['default_language'])]);
//            } // if
            $this->lookup_data['language_id'] = $array;
        } // if

        if (!array_key_exists('rdcaccount_id', $this->lookup_data)) {
            // get contents of foreign table and put into lookup_data
            $dbobject =& RDCsingleton::getInstance('mnu_account');
            $array = $dbobject->getValRep('rdcaccount_id');
            $this->lookup_data['rdcaccount_id'] = $array;
        } // if

        if (version_compare(phpversion(), '5.2.0', '>=')) {
            if (!array_key_exists('user_timezone', $this->lookup_data)) {
                // get array of available timezones
                $array = DateTimeZone::listIdentifiers();
                $this->lookup_data['user_timezone'] = $array;
            } // if
        } // if

        $pattern_id = getPatternId();

//        if (preg_match('/^(list1)$/i', $pattern_id)
//        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
//        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('user_id' => 'User Id',
//                               'user_name' => 'User Name');
//                $this->lookup_data['quicksearch_field'] = $array;
//            } // if
//        } // if

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

        if (version_compare(phpversion(), '5.2.0', '>=')) {
            if (empty($fieldarray['user_timezone'])) {
            	$fieldarray['user_timezone'] = date_default_timezone_get();
            } // if
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'user_id') {
            // get data from the database
            $this->sql_select     = 'user_id, user_name';
            $this->sql_orderby    = 'user_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where);

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
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        // this may be called from the home page, so insert user's id
        if (empty($where)) {
            if (preg_match('/(upd1|enq1|list2)/i', $pattern_id)) {
            	$where = "user_id='" .$_SESSION['logon_user_id'] ."'";
            } // if
        } else {
            if ($GLOBALS['mode'] == 'search') {
                $where_array = where2array($where, false, false);
                $prev_script = getPreviousScript();
                $pattern_id  = getPatternId($prev_script);
                if (preg_match('/multi3/i', $pattern_id)) {
                    if (isset($where_array['mnu_user.user_id'])) {
                    	unset($where_array['mnu_user.user_id']);
                    	$where = array2where($where_array);
                    } // if
                } // if
            } // if
        } // if

        // find out if user passwords are to be hidden or not
    	$dbobject =& RDCsingleton::getInstance('mnu_control');
        $this->pswd_hidden  = $dbobject->getControlData('pswd_hidden');
        $this->pswd_encrypt = $dbobject->getControlData('pswd_encrypt');
        $this->pswd_format  = $dbobject->getControlData('pswd_format');
        unset($dbobject);

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
        if (is_True($this->pswd_encrypt)) {
        	foreach ($rows as $row => $rowdata) {
                // insert dummy field to say that data is currently encrypted
            	$rows[$row]['pswd_is_encrypted'] = true;
            } // foreach
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        // add primary role to MNU_USER_ROLE table
        $dbobject =& RDCsingleton::getInstance('mnu_user_role');
        $role['user_id']    = $rowdata['user_id'];
        $role['role_id']    = $rowdata['role_id'];
        $role['is_primary'] = TRUE;
        $role = $dbobject->insertRecord($role);
        if ($dbobject->errors) {
            $this->errors[$dbobject->getClassName()] = $dbobject->errors;
            return $rowdata;
        } // if

        // create default favourites
        $next['task_id']  = 'mnu_favourite(add4)';
        $next['where']    = "user_id='{$rowdata['user_id']}'";
        append2ScriptSequence($next);

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_from)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_union   = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
            // retrieve one or more roles from MNU_USER_ROLE
            $this->sql_select .= ", (SELECT GROUP_CONCAT(role_desc ORDER BY is_primary DESC, mnu_user_role.role_id ASC SEPARATOR ', ') FROM mnu_user_role LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user_role.role_id) WHERE user_id=mnu_user.user_id) AS role_list)";
            // retrieve primary role from MNU_USER_ROLE
            $this->sql_select .= ", (SELECT role_desc FROM mnu_user_role LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user_role.role_id) WHERE user_id=mnu_user.user_id AND is_primary='Y' LIMIT 1) AS role_id";
        } // if

        if (!empty($this->sql_search)) {
            $search_array = where2array($this->sql_search, false, false);
            if (!empty($search_array['role_id'])) {
                $role_id = stripOperators($search_array['role_id']);
                $search_array[] = "EXISTS(SELECT 1 FROM mnu_user_role WHERE user_id=mnu_user.user_id AND role_id='$role_id')";
                unset($search_array['role_id']);
            } // if
            $this->sql_search = array2where($search_array);
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        if (isset($rowdata['user_password'])) {
            // if pswd is being input it has not been encrypted yet
        	unset($rowdata['pswd_is_encrypted']);
            $this->fields_not_for_trimming = array();  // pswd is plain text, so trim() it
        } else {
            $this->fields_not_for_trimming[] = 'user_password';  // do not trim() this field
        } // if

        if (empty($rowdata['email_addr'])) {
            // create default value as SQLSRV does not allow duplicate keys containing NULL
            $rowdata['email_addr'] = $rowdata['user_id'].'@null.null';
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
                $this->fields_not_for_trimming[] = 'user_password';  // do not trim() this field
            } else {
                // if pswd is being input it has not been encrypted yet
            	unset($rowdata['pswd_is_encrypted']);
                $this->fields_not_for_trimming = array();  // pswd is plain text, so trim() it
            } // if

        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
