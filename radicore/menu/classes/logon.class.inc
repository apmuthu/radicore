<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user.class.inc';
class logon extends mnu_user
{
    var $login_type;

    // ****************************************************************************
    // this subclass is used by scripts: logon.php and error.inc
    // ****************************************************************************
    function user_logoff ($logon_user_id)
    // mark the current user as logged off.
    {
        $this->errors = array();

        $GLOBALS['task_id'] = 'logoff';

        $updatearray['user_id']       = $logon_user_id;
        $updatearray['in_use']        = $this->fieldspec['in_use']['false'];
        //$updatearray['rdcaccount_id'] =& $_SESSION['rdcaccount_id'];
        $this->skip_validation        = true;

        $updatearray = $this->updateRecord($updatearray);

        // perform any custom logon processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, 'user_logoff')) {
                $updatearray['session_id'] = session_id();
                $result = $this->custom_processing_object->user_logoff($updatearray);
            } // if
        } // if

        return $this->errors;

    } // user_logoff

    // ****************************************************************************
    function user_logon ($logonarray, $external_auth_off=false)
    // validate the user_id and password from the logon screen
    {
        $this->errors = array();

        $GLOBALS['task_id'] = 'logon';

        $mnu_control = RDCsingleton::getInstance('mnu_control');

        $login_type = $mnu_control->getControlData('login_type');
        $this->login_type = $login_type;
        if ($login_type == 'EMAIL') {
            // login using email address
            $this->fieldspec['email_addr']['required'] = 'y';
            if (!isset($logonarray['email_addr'])) {
            	$logonarray['email_addr'] = null;
            } // if
            unset($this->fieldspec['user_id']['required']);
            unset($logonarray['user_id']);
        } else {
            // default login is via USER_ID
            $this->fieldspec['user_id']['required'] = 'y';
            if (!isset($logonarray['user_id'])) {
            	$logonarray['user_id'] = null;
            } // if
            unset($this->fieldspec['email_addr']['required']);
            unset($logonarray['email_addr']);
        } // if

        // perform primary validation on the input
        $updatearray = $this->_validateUpdatePrimary($logonarray);
        if ($this->errors) {
            $this->fieldarray = $logonarray;
        	return $this->errors;
        } // if

        if ($login_type == 'EMAIL') {
            // convert email address into a user ID
            $where = "email_addr='".addslashes($logonarray['email_addr'])."'";
            $data = $this->getData($where);
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

        $this->fieldarray = $updatearray;
        if (!empty($this->errors)) return $this->errors;

        $logon_password = $updatearray['user_password'];
        $logon_user_id  = $updatearray['user_id'];
        $ip_address     = getRealIPAddress();

        // code has been moved to a separate function
        $fieldarray = $this->validatePassword ($logon_user_id, $logon_password, $ip_address, $external_auth_off);

        if (!empty($this->errors)) {
            $this->PasswordRetries($logon_user_id, $logon_password);
            $this->fieldarray['user_password'] = '';
            if (!empty($logonarray['user_id'])) {
                $this->fieldarray['user_id']    = $logonarray['user_id'];
            } elseif (!empty($logonarray['email_addr'])) {
                $this->fieldarray['email_addr'] = $logonarray['email_addr'];
            } // if
            return $this->errors;
        } // if

        // if there are errors do not display unencrypted passwords
        $logonarray['user_password'] = '';

        // logon OK, so clear retry values
        unset($_SESSION['logon_retries']);

        if (strlen($fieldarray['language_id']) > 0) {
            // user has a pre-set language code
            $_SESSION['user_language'] = strtolower($fieldarray['language_id']);
        } else {
            $_SESSION['user_language'] = $_SESSION['default_language'];
        } // if

        if ($logon_user_id == 'ANONYMOUS') {
            // the next bit does not apply
        } else {
            $fieldarray['user_password'] = '';
            if (is_True($fieldarray['is_disabled'])) {
                $this->errors[] = getLanguageText('sys0143'); // 'This user has been disabled';
                $this->fieldarray = $logonarray;
                return $this->errors;
            } // if
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

        if (empty($fieldarray['role_id']) OR empty($fieldarray['role_list'])) {
            // 'This user does not have a primary role'
            $this->errors[] = getLanguageText('sys0230');
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if (empty($fieldarray['start_task_id'])) {
            // 'This user does not have a starting task'
            $this->errors[] = getLanguageText('sys0231');
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if (!is_True($fieldarray['ip_address_valid'])) {
            // 'This IP address is not valid for this user'
        	$this->errors[] = getLanguageText('sys0200', $ip_address);
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        if (!empty($_SESSION['timezone_server'])) {
        	if (!empty($fieldarray['user_timezone']) AND $fieldarray['user_timezone'] != $_SESSION['timezone_server']) {
            	// put this user's time zone in a permanent cookie (for use in the shutdown function)
                setcookie("timezone_client", $fieldarray['user_timezone'], time()+7776000, '/');
                // save it so that it can be reproduced when moving between HTTP and HTTPS protocols
                $_SESSION['cookie_data']['timezone_client'] = $fieldarray['user_timezone'];
                $_SESSION['cookie_time']['timezone_client'] = time()+7776000;
            } else {
                // delete this cookie
                setcookie("timezone_client", '', time()-42000, '/');
                unset($_SESSION['cookie_data']['timezone_client']);
            } // if
        } // if

        // make logon data available throughout the session
        $_SESSION['logon_user_id']        = $logon_user_id;
        $_SESSION['logon_user_name']      = $fieldarray['user_name'];
        $_SESSION['role_id']              = $fieldarray['role_id'];
        $_SESSION['logon_email_addr']     = $fieldarray['email_addr'];
        $_SESSION['rdcaccount_id']        = $fieldarray['rdcaccount_id'];
        $_SESSION['logon_party_id']       = $fieldarray['party_id'];
        $_SESSION['start_task_id']        = $fieldarray['start_task_id'];
        $_SESSION['date_format_input']    = $fieldarray['input_date_format'];
        $_SESSION['date_format_output']   = $fieldarray['output_date_format'];
        $_SESSION['allow_responsive_gui'] = $fieldarray['allow_responsive_gui'];
        //$_SESSION['selection_lock']     = true;

        $_SESSION['display_foreign_currency'] = false;

        // save list of roles from MNU_USER_ROLE table
        $array = explode(',', $fieldarray['role_list']);
        if (!empty($array)) {
            $_SESSION['role_list'] = "'".implode("','", $array)."'";
        } else {
            $_SESSION['role_list'] = "'".$fieldarray['role_id']."'";
        } // if
        unset($array);

        // store locale data based on user's preferred language
        $_SESSION['locale_name'] = saveLocaleFormat($_SESSION['user_language']);

        // make a permanent copy in session data as global data may be changed
        $_SESSION['localeconv'] = $GLOBALS['localeconv'];

        if (!empty($_SESSION['timezone_server'])) {
            $_SESSION['timezone_client'] = $fieldarray['user_timezone'];
        } // if

        // update user record to show that he/she has logged in
        $updatearray['user_id']        = $logon_user_id;
        //$updatearray['rdcaccount_id']  = $fieldarray['rdcaccount_id'];
        $updatearray['pswd_count']     = $fieldarray['pswd_count'] + 1;
        $updatearray['logon_datetime'] = getTimeStamp();
        $updatearray['in_use']         = true;
        $updatearray['ip_address']     = $ip_address;
        unset($updatearray['user_password']);

        $updatearray = $this->updateRecord($updatearray);

        if (empty($this->errors)) {
        	if ($fieldarray['authentication'] == 'INTERNAL') {
                if ($logon_user_id == 'ANONYMOUS') {
                    // the next bit does not apply
                } else {
                    // find out if user needs to change his password
                    if ($mnu_control->getControlData('pswd_change', $updatearray)
                     OR is_True($updatearray['force_pswd_chg'])) {
                        $next['task_id']  = 'mnu_user(upd1)a';
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
            } // if
        } else {
            // an error has occurred, so remove redundant data before screen is redisplayed
            if ($login_type == 'EMAIL') {
                unset($fieldarray['user_id']);
            } else {
                unset($fieldarray['email_addr']);
            } // if
        } // if

        if (!empty($_SESSION['QUERY_STRING'])) {
            // see if QUERY_STRING requires extra processing
            $this->processQueryString($_SESSION['QUERY_STRING']);
            unset($_SESSION['QUERY_STRING']);
        } // if

        $data = $mnu_control->getControlData('pagination');
        $_SESSION['pagination_width'] = $data['pagination_width'];
        $_SESSION['scrolling_width']  = $data['scrolling_width'];

        // save this data inside this object
        $this->fieldarray = $fieldarray;

        $_SESSION['empty_tables'] = $this->findEmptyTables($logon_user_id);

        // perform any custom logon processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, 'user_logon')) {
                $fieldarray['session_id'] = session_id();
                $result = $this->custom_processing_object->user_logon($fieldarray);
            } // if
        } // if

        return $this->errors;

    } // user_logon

    // ****************************************************************************
    function user_new_session ($user_id)
    // perform any custom processing when the NEW SESSION link is pressed
    {
        $this->errors = array();

        // perform any custom processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, 'user_new_session')) {
                $result = $this->custom_processing_object->user_new_session($user_id, session_id());
            } // if
        } // if

        return $this->errors;

    } // user_new_session

    // ****************************************************************************
    function PasswordRetries ($user_id, $user_password, $email_addr=null)
    // password has been rejected, so increment count for this user, and if it
    // exceeds the value in $limit then disable this user (this prevents a
    // hacker from trying multiple guesses)
    // ALSO: write record to audit_logon_errors
    {
        // log this failed attempt in 'audit_logon_errors' table
        $auditobj = RDCsingleton::getInstance('audit_logon_errors');

        $audit_data['user_id']       = $user_id;
        $audit_data['email_addr']    = $email_addr;
        $audit_data['user_password'] = $user_password;
        //$audit_data['ip_address']    = $_SERVER['REMOTE_ADDR'];
        $audit_data['ip_address']    = getRealIPAddress();
        $audit_data = $auditobj->insertRecord($audit_data);
        if ($auditobj->errors) {
        	$this->errors = array_merge($this->errors, $auditobj->errors);
        } // if

        if (empty($user_id)) {
            return;  // no user_id to update, so skip the following
        } // if

        // get count of password attempts
        $controlobj = RDCsingleton::getInstance('mnu_control');

        $max_retries = $controlobj->getControlData('pswd_retries');

        if (isset($_SESSION['logon_retries'])) {
            if ($_SESSION['logon_retries']['user_id'] <> $user_id) {
                // change of user_id, so initialize counter
                $_SESSION['logon_retries']['user_id'] = $user_id;
                $_SESSION['logon_retries']['count']   = 0;
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
            $fail = false;
            // a limit has been set on the number of retries
            if ($_SESSION['logon_retries']['count'] > $max_retries) {
                $fail = true;
            } // if
            // check contents of AUDIT_LOGON_ERRORS table
            $now = getTimeStamp();
            $user_id = addslashes($user_id);
            $where = "user_id='{$user_id}' AND DATE_ADD(err_timestamp, INTERVAL 5 MINUTE) >= '$now'";
            $count = $auditobj->getCount($where);
            if ($count > $max_retries) {
                $fail = true;
            } // if
            if ($fail === true) {
                $errors = $this->errors;
                // limit exceeded, so disable user
                $fieldarray = $this->getData_raw("mnu_user.user_id='$user_id'");
                if ($this->numrows == 1) {
                    $_SESSION['logon_user_id'] = $user_id;
                    $fieldarray[0]['is_disabled'] = true;
                    $fieldarray = $this->updateRecord($fieldarray);
                    if (($this->errors)) {
                        $errors = array_merge($errors, $this->errors);
                    } // if
                    $errors[] = getLanguageText('e0003'); // 'Retry count exceeded.';
                    $errors[] = getLanguageText('e0001'); // 'This user has been disabled.';
                    unset($_SESSION['logon_retries']);
                    unset($_SESSION['logon_user_id']);
                } // if
                $this->errors = $errors;
            } // if
        } // if

        return;

    } // PasswordRetries

    // ****************************************************************************
    function processQueryString($query_string)
    // see if QUERY_STRING requires extra processing
    {
        $query_string = str_replace('&amp;', '&', $query_string);
        parse_str($query_string, $array);

        if (array_key_exists('case_id', $array) AND array_key_exists('workitem_id', $array)) {
            $dbobject = RDCsingleton::getInstance('wf_workitem');
            $array = array_map('addslashes', $array);
            $where = "case_id='{$array['case_id']}' AND workitem_id='{$array['workitem_id']}'";
            $data = $dbobject->getData($where);
            if (!empty($data)) {
                $data = $data[0];
                $next['task_id'] = $data['task_id'];
                $next['where']   = $data['context'];
                append2ScriptSequence($next);
            } // if

        } elseif (!empty($_SESSION['SSO'])) {
            // Single Sign On option requested from script '<subsys>/<script>'
            $_SESSION['SSO'] = ltrim($_SESSION['SSO'], '/');
            //list($subsys_id, $script_id) = explode('/', $_SESSION['SSO']);
            $script_id = basename($_SESSION['SSO']);
            $subsys_id = basename(dirname($_SESSION['SSO']));
            // find the task_id which goes with this script_id
            $dbobject = RDCsingleton::getInstance('mnu_task');
            $data = $dbobject->getData("subsys_id='$subsys_id' AND script_id='$script_id'");
            if (!empty($data)) {
                $data = $data[0];
                $next['task_id'] = $data['task_id'];
                $next['where']   = array2where($array);
                append2ScriptSequence($next, true);  // put at front of array
            } // if
            unset($dbobject);
            unset($_SESSION['SSO']);
        } // if

        return;

    } // processQueryString

    // ****************************************************************************
    function findEmptyTables ($user_id)
    // Find any empty tables to avoid reading them again in this session
    {
        $array = array();

        $count = $this->getCount("SELECT COUNT(*) FROM mnu_task_ip_address");
        if ($count == 0) {
            $array['mnu_task_ip_address'] = true;
        } // if

        $count = $this->getCount("SELECT COUNT(*) FROM mnu_user_ip_address WHERE user_id='$user_id'");
        if ($count == 0) {
            $array['mnu_user_ip_address'] = true;
        } // if

        $count = $this->getCount("SELECT COUNT(*) FROM mnu_time_limit_role");
        if ($count == 0) {
            $array['mnu_time_limit_role'] = true;
        } // if

        $count = $this->getCount("SELECT COUNT(*) FROM mnu_time_limit_user WHERE user_id='$user_id'");
        if ($count == 0) {
            $array['mnu_time_limit_user'] = true;
        } // if

        $count = $this->getCount("SELECT COUNT(*) FROM mnu_control WHERE record_id='SYSTEM' AND field_id LIKE 'SHUTDOWN%' AND field_value IS NOT NULL");
        if ($count == 0) {
            $array['SYSTEM_SHUTDOWN'] = true;
        } // if

        return $array;

    } // findEmptyTables

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
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if ($this->login_type == 'EMAIL') {
            unset($fieldarray['user_id']);
        } else {
            unset($fieldarray['email_addr']);
        } // if

        return $fieldarray;

    } // _cm_formatData

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
        $dbobject = RDCsingleton::getInstance('mnu_control');
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
