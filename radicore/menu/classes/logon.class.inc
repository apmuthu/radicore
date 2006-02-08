<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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
        //DebugBreak();
        $this->errors = array();

        $GLOBALS['task_id'] = 'logoff';

        $updatearray['user_id'] = $logon_user_id;
        $updatearray['in_use']  = $this->fieldspec['in_use']['false'];
        $this->skip_validation  = true;

        $updatearray = $this->updateRecord($updatearray);

        return $this->errors;

    } // user_logoff

    // ****************************************************************************
    function user_logon ($logonarray)
    // validate the user_id and password from the logon screen
    {
        //DebugBreak();
        $this->errors = array();

        $GLOBALS['task_id'] = 'logon';

        // perform primary validation on the input
        $updatearray = $this->_validateUpdate($logonarray);

        // if there are errors do not display unencrypted password
        $logonarray['user_password'] = '';

        $this->fieldarray = $updatearray;
        if (!empty($this->errors)) return $this->errors;

        $logon_password = $updatearray['user_password'];
        $logon_user_id  = $updatearray['user_id'];

        // find out if user passwords are encrypted or not
        require_once 'mnu_control.class.inc';
        $mnu_control =& singleton::getInstance('mnu_control');
        $encrypt_flag = $mnu_control->getControlData('pswd_encrypt');

        if ($encrypt_flag) {
            // encrypt the password to inlude in database lookup
            require_once 'std.encryption.class.inc';
            $crypt_obj =& singleton::getInstance('encryption_class');
            $spec = $this->fieldspec['user_password'];
            $logon_password = $crypt_obj->encrypt($logon_user_id, $logon_password, $spec['size']);
            if ($crypt_obj->errors) {
            	return $crypt_obj->errors;
            } // if
            $logon_password = addslashes($logon_password);
            unset ($crypt_obj);
        } // if

        // join to MNU_ROLE to obtain start_task_id
        $this->sql_select = 'user_id, is_disabled, pswd_count, pswd_chg_date, language_code, mnu_user.role_id, mnu_role.start_task_id ';
        $this->sql_from   = 'mnu_user '
                          . 'LEFT JOIN mnu_role ON (mnu_role.role_id=mnu_user.role_id)';

        $fieldarray = $this->getData_raw("user_id='$logon_user_id' AND user_password='$logon_password'");
        if ($this->numrows <> 1) {
            $this->errors[] = getLanguageText('e0000'); // 'Security violation';
            $this->PasswordRetries($logon_user_id);
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        // logon OK, so clear retry values
        unset($_SESSION['logon_retries']);

        $fieldarray = $fieldarray[0];
        $fieldarray['user_password'] = '';
        if (is_True($fieldarray['is_disabled'])) {
            $this->errors[] = getLanguageText('e0001'); // 'This user has been disabled';
            $this->fieldarray = $logonarray;
            return $this->errors;
        } // if

        // make logon data available throughout the session
        $_SESSION['logon_user_id'] = $logon_user_id;
        $_SESSION['role_id']       = $fieldarray['role_id'];
        if (strlen($fieldarray['language_code']) > 0) {
        	$_SESSION['user_language'] = $fieldarray['language_code'];
        } // if

        // update user record to show that he/she has logged in
        $updatearray['user_id']       = $logon_user_id;
        $updatearray['pswd_count']    = $fieldarray['pswd_count'] + 1;
        $updatearray['logon_date']    = getTimeStamp('date');
        $updatearray['logon_time']    = getTimeStamp('time');
        $updatearray['in_use']        = true;

        $updatearray = $this->updateRecord($updatearray);

        // find out if user needs to change his password
        if ($mnu_control->getControlData('pswd_change', $updatearray)) {
            $next['task_id'] = 'mnu_user(upd)b';
            $next['where']   = "user_id='$logon_user_id'";
            $next['action']  = 'OK';
            $next['message'] = getLanguageText('e0002'); // 'You must change your password';
            // this is processed by scriptnext() and scriptprevious()
            $_SESSION['script_sequence'][] = $next;
        } // if

        // save this data inside this object
        $this->fieldarray = $fieldarray;

        return $this->errors;

    } // user_logon

    // ****************************************************************************
    function PasswordRetries ($user_id)
    // password has been rejected, so increment count for this user, and if it
    // exceeds the value in $limit then disable this user (this prevents a
    // hacker from trying multiple guesses)
    {
        //DebugBreak();
        // get count of password attempts
        require_once 'mnu_control.class.inc';
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
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // remove everything from $fieldspec except USER_ID and PASSWORD
        foreach ($this->fieldspec as $fieldname => $spec) {
            if ($fieldname == 'user_id' OR $fieldname == 'user_password') {
                $fieldarray[$fieldname] = null;
            } else {
                unset($this->fieldspec[$fieldname]);
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //DebugBreak();

        // this replaces the function in the parent class

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
