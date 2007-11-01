<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user.class.inc';
class mnu_user_s01 extends mnu_user
{
    // ****************************************************************************
    // This class is for use by script: mnu_user_upd(a).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // create 'new_password' field
        $fieldarray['new_password1'] = '';
        $this->fieldspec['new_password1']['type'] = 'string';
        $this->fieldspec['new_password1']['size'] = $this->fieldspec['user_password']['size'];
        $this->fieldspec['new_password1']['password'] = 'y';
        $this->fieldspec['new_password1']['required'] = 'y';

        // get user to repeat input to avoid mistakes
        $fieldarray['new_password2'] = '';
        $this->fieldspec['new_password2']['type'] = 'string';
        $this->fieldspec['new_password2']['size'] = $this->fieldspec['user_password']['size'];
        $this->fieldspec['new_password2']['password'] = 'y';
        $this->fieldspec['new_password2']['required'] = 'y';

        // blank out current password (must be re-input)
        $fieldarray['user_password'] = '';

        // cannot change user_name
        $this->fieldspec['user_name']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        // find out if user passwords are encrypted or not
        $dbobject =& singleton::getInstance('mnu_control');
        $encrypt_flag = $dbobject->getControlData('pswd_encrypt');
        unset($dbobject);

        if ($encrypt_flag) {
            $crypt_obj =& singleton::getInstance('encryption_class');
            // encrypt input password and compare with original
            $key    = $fieldarray['user_id'];
            $string = $fieldarray['user_password'];
            $spec   = $this->fieldspec['user_password'];
            $string = $crypt_obj->encrypt($key, $string, $spec['size']);
            if ($crypt_obj->errors) {
            	$this->errors['user_password'] = $crypt_obj->errors[0];
            } // if
        } else {
            $string = $fieldarray['user_password'];
        } // if

        // input password must match original password
        if ($originaldata['user_password'] != $string) {
            $this->errors['user_password'] = getLanguageText('e0029'); // 'Password is invalid';
            return $fieldarray;
        } // if

        // validate new password
        $new_password = $fieldarray['new_password1'];
        if ($new_password == $fieldarray['user_password']) {
            $this->errors['new_password1'] = getLanguageText('e0030'); // 'New password must not match old password';
            return $fieldarray;
        } // if

        if ($new_password != $fieldarray['new_password2']) {
            $this->errors['new_password2'] = getLanguageText('e0031'); // 'Repeat password does not match new password';
            return $fieldarray;
        } // if

        // perform standard processing defined in the parent class
        $fieldarray = parent::_cm_commonValidation($fieldarray, $originaldata);

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_initialise ($where)
    // perform any initialisation for the current task.
    {
        // this may be called from the home page, so insert user's id
        if (empty($where)) {
        	$where = "user_id='" .$_SESSION['logon_user_id'] ."'";
        } // if

        return $where;

    } // _cm_initialise

// ****************************************************************************
} // end class
// ****************************************************************************

?>
