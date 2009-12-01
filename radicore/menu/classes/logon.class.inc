<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user.class.inc';
class logon extends mnu_user
{
    // ****************************************************************************
    // this subclass is used by scripts: logon.php and error.inc
    // ****************************************************************************
    function user_logoff ($logon_user_id)
    // mark the current user as logged off.
    {
        $this->errors = array();

        $GLOBALS['task_id'] = 'logoff';

        $updatearray['user_id'] = $logon_user_id;
        $updatearray['in_use']  = $this->fieldspec['in_use']['false'];
        $this->skip_validation  = true;

        $updatearray = $this->updateRecord($updatearray);

        return $this->errors;

    } // user_logoff

    // ****************************************************************************
    function user_logon ($logonarray, $external_auth_off=false)
    // validate the user_id and password from the logon screen
    {
        $this->errors = array();

        $GLOBALS['task_id'] = 'logon';

        $mnu_control =& singleton::getInstance('mnu_control');

        $login_type = $mnu_control->getControlData('login_type');
        if ($login_type == 'EMAIL') {
            $this->fieldspec['email_addr']['required'] = 'y';
            if (!isset($logonarray['email_addr'])) {
            	$logonarray['email_addr'] = null;
            } // if
            unset($this->fieldspec['user_id']['required']);
            unset($logonarray['user_id']);
        } else {
            $this->fieldspec['user_id']['required'] = 'y';
            if (!isset($logonarray['user_id'])) {
            	$logonarray['user_id'] = null;
            } // if
            unset($this->fieldspec['email_addr']['required']);
            unset($logonarray['email_addr']);
        } // if

        // perform primary validation on the input
        $updatearray = $this->_validateUpdate($logonarray);
        if ($this->errors) {
            $this->fieldarray = $logonarray;
        	return $this->errors;
        } // if

        if ($login_type == 'EMAIL') {
            $data = $this->getData("email_addr='{$logonarray['email_addr']}'");
            if (empty($data)) {
                $this->errors[] = getLanguageText('sys0142'); // 'Security violation';
                $this->PasswordRetries(NULL, $updatearray['user_password'], $logonarray['email_addr']);
                $this->fieldarray = $logonarray;
                return $this->errors;
            } else {
            	$updatearray['user_id'] = $data[0]['user_id'];
            	unset($updatearray['email_addr']);
            } // if
        } // if

        if (is_True($external_auth_off)) {
            // do not use External Authentication
            $auth_array['authentication'] = 'INTERNAL';
        } else {
            $auth_array = $mnu_control->getControlData('authentication');
            if ($auth_array['authentication'] != 'INTERNAL') {
                // external authentication is turned ON globally, but is it turned off for this USER or ROLE
                $this->sql_select = 'user_id, mnu_user.role_id'
                                  . ", CASE WHEN mnu_user.is_external_auth_off='Y' THEN 'Y' ELSE mnu_role.is_external_auth_off END AS is_external_auth_off";
                $this->sql_from   = 'mnu_user '
                                  . 'LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user.role_id)';
                $where = "user_id='" .addslashes($logonarray['user_id']) ."'";
                $fieldarray = $this->getData_raw($where);
                if (is_True($fieldarray[0]['is_external_auth_off'])) {
                    $auth_array['authentication'] = 'INTERNAL';
                } // if
            } // if
            if ($auth_array['authentication'] != 'INTERNAL') {
                $this->fieldspec['user_password']['size'] = 40;
            } // if
        } // if

        // if there are errors do not display unencrypted passwords
        $logonarray['user_password'] = '';

        $this->fieldarray = $updatearray;
        if (!empty($this->errors)) return $this->errors;

        $logon_password = $updatearray['user_password'];
        $logon_user_id  = $updatearray['user_id'];

        // find out if user passwords are encrypted or not
        $encrypt_flag = $mnu_control->getControlData('pswd_encrypt');

        if ($auth_array['authentication'] != 'INTERNAL') {
            // no need to encrypt the password
        } elseif ($encrypt_flag == true) {
            // encrypt the password to include in database lookup
            $crypt_obj =& singleton::getInstance('encryption_class');
            $spec = $this->fieldspec['user_password'];
            $logon_password = $crypt_obj->encrypt($logon_user_id, $logon_password, $spec['size']);
            if ($crypt_obj->errors) {
            	return $crypt_obj->errors;
            } // if
            //$logon_password = addslashes($logon_password);
            unset ($crypt_obj);
        } // if

        $ip_address = $_SERVER['SERVER_ADDR'];

        // join to MNU_ROLE to obtain start_task_id
        $this->sql_select = 'user_id, user_name, start_date, end_date, is_disabled, pswd_count, pswd_chg_date, language_code, email_addr, mnu_user.role_id, mnu_role.start_task_id, mnu_user.rdcaccount_id, mnu_user.external_id, mnu_user.party_id, mnu_user.user_timezone ';
        $this->sql_from   = 'mnu_user '
                          . 'LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user.role_id)';
        $where = "user_id='" .addslashes($logon_user_id) ."'";
        // lookup on MNU_USER_IP_ADDRESS to see if this IP address is valid
        $this->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE $where) = 0 THEN true"
                                  ." WHEN (SELECT count(ip_address) FROM mnu_user_ip_address WHERE $where AND ip_address='$ip_address') = 1 THEN true"
                                  ." ELSE false"
                             ." END AS ip_address_valid";
        if ($auth_array['authentication'] == 'INTERNAL') {
            // include user_password in selection criteria
            $where .= " AND user_password='" .addslashes($logon_password) ."'";
        } // if
        $fieldarray = $this->getData_raw($where);
        if ($this->numrows <> 1) {
            $this->errors[] = getLanguageText('sys0142'); // 'Security violation';
            $this->PasswordRetries($logon_user_id, $updatearray['user_password']);
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        // logon OK, so clear retry values
        unset($_SESSION['logon_retries']);

        $fieldarray = $fieldarray[0];
        $fieldarray['user_password'] = '';
        if (is_True($fieldarray['is_disabled'])) {
            $this->errors[] = getLanguageText('sys0143'); // 'This user has been disabled';
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        $today = getTimeStamp('date');
        if ($fieldarray['end_date'] < $today) {
            // 'This user has an end date which is in the past'
        	$this->errors[] = getLanguageText('sys0144');
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if ($fieldarray['start_date'] > $today) {
            // 'This user has a start date which is in the future'
        	$this->errors[] = getLanguageText('sys0145');
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if (!is_True($fieldarray['ip_address_valid'])) {
            // 'This IP address is not valid'
        	$this->errors[] = getLanguageText('sys0200', $ip_address);
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if (!empty($_SESSION['timezone_server'])) {
        	if (!empty($fieldarray['user_timezone']) AND $fieldarray['user_timezone'] != $_SESSION['timezone_server']) {
            	// put this user's time zone in a permanent cookie (for use in the shutdown function)
                setcookie("timezone_client", $fieldarray['user_timezone'], time()+7776000, '/');
            } else {
                // delete this cookie
                setcookie("timezone_client", '', time()-42000, '/');
            } // if
        } // if

        if ($auth_array['authentication'] != 'INTERNAL') {
            if (empty($fieldarray['external_id'])) {
        		$fieldarray['external_id'] = $logon_user_id;
        	} // if
            if ($auth_array['authentication'] == 'RADIUS') {
            	$radius = singleton::getInstance('radius_class');
            	$result = $radius->authenticate($fieldarray['external_id'], $logon_password);
            	if ($result == RADIUS_ACCESS_ACCEPT) {
            	    // continue
            	} else {
            	    // 'RADIUS authentication has failed'
            		$this->errors[] = getLanguageText('sys0174');
                    $this->fieldarray = $logonarray;
                    return $this->errors;
            	} // if
            } elseif ($auth_array['authentication'] == 'LDAP') {
                $ldap = singleton::getInstance('ldap_class');
                $result = $ldap->authenticate($fieldarray['external_id'], $logon_password);
                if ($result === true) {
                    // continue
                } else {
            	    // 'LDAP authentication has failed'
            		$this->errors[] = getLanguageText('sys0176');
            		$this->errors[] = getLanguageText('sys0177', $result);
                    $this->fieldarray = $logonarray;
                    return $this->errors;
            	} // if
            } // if
        } // if

        // make logon data available throughout the session
        $_SESSION['logon_user_id']    = $logon_user_id;
        $_SESSION['logon_user_name']  = $fieldarray['user_name'];
        $_SESSION['role_id']          = $fieldarray['role_id'];
        $_SESSION['logon_email_addr'] = $fieldarray['email_addr'];
        $_SESSION['rdcaccount_id']    = $fieldarray['rdcaccount_id'];
        $_SESSION['logon_party_id']   = $fieldarray['party_id'];
        $_SESSION['start_task_id']    = $fieldarray['start_task_id'];

        if (strlen($fieldarray['language_code']) > 0) {
            // user has a pre-set language code
        	$_SESSION['user_language'] = strtolower($fieldarray['language_code']);
        } // if

        // store locale data based on user's preferred language
        $_SESSION['locale_name'] = saveLocaleFormat($_SESSION['user_language']);

        // make a permanent copy in session data as global data may be changed
        $_SESSION['localeconv'] = $GLOBALS['localeconv'];

        if (!empty($_SESSION['timezone_server'])) {
            $_SESSION['timezone_client'] = $fieldarray['user_timezone'];
        } // if

        // update user record to show that he/she has logged in
        $updatearray['user_id']       = $logon_user_id;
        $updatearray['rdcaccount_id'] = $fieldarray['rdcaccount_id'];
        $updatearray['pswd_count']    = $fieldarray['pswd_count'] + 1;
        $updatearray['logon_date']    = getTimeStamp('date');
        $updatearray['logon_time']    = getTimeStamp('time');
        $updatearray['in_use']        = true;
        $updatearray['ip_address']    = $_SERVER['REMOTE_ADDR'];
        unset($updatearray['user_password']);

        $updatearray = $this->updateRecord($updatearray);

        if (empty($this->errors)) {
        	if ($auth_array['authentication'] == 'INTERNAL') {
                // find out if user needs to change his password
                if ($mnu_control->getControlData('pswd_change', $updatearray)) {
                    $next['task_id']  = 'mnu_user(upd1)b';
                    $next['where']    = "user_id='$logon_user_id'";
                    $next['action']   = 'OK';
                    // 'You must change your password';
                    $next['messages'] = getLanguageText('sys0146');
                    // this is processed by scriptnext() and scriptprevious()
                    append2ScriptSequence($next);
                } else {
                    // find out is the user's password is due to expire in the near future
                    if ($expiry_msg = $mnu_control->getControlData('pswd_expires', $updatearray)) {
                    	$this->messages[] = $expiry_msg;
                    } // if
                } // if
            } // if
        } else {
            // an error has occurred, so remove redundant data before screen is redisplayed
            if ($login_type == 'EMAIL') {
                unset($fieldarray['user_id']);
            } else {
                unset($fieldarray['email_addr']);
            } // if
        } // if

        // show MOTD (Message of the Day) screen
        //$motd['task_id']  = 'mnu_motd(show)';
        //$motd['where']    = "motd_id IS NOT NULL";
        //append2ScriptSequence($motd);

        $data = $mnu_control->getControlData('pagination');
        $_SESSION['pagination_width'] = $data['pagination_width'];
        $_SESSION['scrolling_width']  = $data['scrolling_width'];

        // save this data inside this object
        $this->fieldarray = $fieldarray;

        return $this->errors;

    } // user_logon

    // ****************************************************************************
    function PasswordRetries ($user_id, $user_password, $email_addr=null)
    // password has been rejected, so increment count for this user, and if it
    // exceeds the value in $limit then disable this user (this prevents a
    // hacker from trying multiple guesses)
    // ALSO: write record to audit_logon_errors
    {
        // log this failed attempt in 'audit_logon_errors' table
        $auditobj =& singleton::getInstance('audit_logon_errors');

        $audit_data['user_id']       = $user_id;
        $audit_data['email_addr']    = $email_addr;
        $audit_data['user_password'] = $user_password;
        $audit_data['ip_address']    = $_SERVER['REMOTE_ADDR'];
        $audit_data = $auditobj->insertRecord($audit_data);
        if ($auditobj->errors) {
        	$this->errors = array_merge($this->errors, $auditobj->errors);
        } // if

        // get count of password attempts
        $mnu_control =& singleton::getInstance('mnu_control');

        $max_retries = $mnu_control->getControlData('pswd_retries');

        if (isset($_SESSION['logon_retries'])) {
            if ($_SESSION['logon_retries']['user_id'] <> $user_id) {
                // change of user_id, so initialize counter
                $_SESSION['logon_retries']['count'] = 0;
            } // if
        } else {
            // first failure, so initialize counter
            $_SESSION['logon_retries']['user_id'] = $user_id;
            $_SESSION['logon_retries']['count']   = 0;
        } // if

        $_SESSION['logon_retries']['count']++;

        // slow down the response to confuse any robots which might be sniffing
        $interval = (int)$_SESSION['logon_retries']['count']-1;
        sleep($interval);

        if ($max_retries > 0) {
            // a limit has been set on the number of retries
            if ($_SESSION['logon_retries']['count'] > $max_retries) {
                $errors = $this->errors;
                // limit exceeded, so disable user
                $fieldarray = $this->getData_raw("user_id='$user_id'");
                if ($this->numrows == 1) {
                    $_SESSION['logon_user_id'] = $user_id;
                    $fieldarray[0]['is_disabled'] = true;
                    $fieldarray = $this->updateRecord($fieldarray);
                    if (($this->errors)) {
                        $errors = array_merge($errors, $this->errors);
                    } // if
                    $errors[] = getLanguageText('e0003'); // 'Retry count exceeded.';
                    $errors[] = getLanguageText('e0001'); // 'This user has been disabled.';
                } // if
                $this->errors = $errors;
            } // if
        } // if

        return;

    } // PasswordRetries

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this is here just to override the method in the parent class

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        $where = '';
        $where = $this->_cm_changeConfig($where, $fieldarray);

        // get list of fields which are defined in the current screen
        foreach ($GLOBALS['screen_structure']['main']['fields'] as $key => $value) {
        	$fieldlist[] = key($value);
        } // foreach

        // remove everything from $fieldspec except these fields
        foreach ($this->fieldspec as $fieldname => $spec) {
            if (in_array($fieldname, $fieldlist)) {
            	$fieldarray[$fieldname] = null;
            } else {
                unset($this->fieldspec[$fieldname]);
            } // if
        } // foreach

        // remove field(s) and data depending on 'login_type'
        $dbobject =& singleton::getInstance('mnu_control');
        $login_type = $dbobject->getControlData('login_type');

        switch ($login_type) {
        	case 'USER':
        		unset($this->fieldspec['email_addr']);
        		unset($fieldarray['email_addr']);
        		break;

        	case 'EMAIL':
        		unset($this->fieldspec['user_id']);
        		unset($fieldarray['user_id']);
        		break;

        	default:
        		break;
        } // switch

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // this replaces the function in the parent class

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
