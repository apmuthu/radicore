<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
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
        // create 'old_password' field
        if (!isset($fieldarray['old_password'])) $fieldarray['old_password'] = '';
        $this->fieldspec['old_password']['type'] = 'string';
        $this->fieldspec['old_password']['size'] = $this->fieldspec['user_password']['size'];
        $this->fieldspec['old_password']['password'] = 'y';
        $this->fieldspec['old_password']['required'] = 'y';
        $this->fieldspec['old_password']['nondb']    = 'y';

        // create 'new_password' field
        if (!isset($fieldarray['new_password1'])) $fieldarray['new_password1'] = '';
        $this->fieldspec['new_password1']['type'] = 'string';
        $this->fieldspec['new_password1']['size'] = $this->fieldspec['user_password']['size'];
        $this->fieldspec['new_password1']['password'] = 'y';
        $this->fieldspec['new_password1']['required'] = 'y';
        $this->fieldspec['new_password1']['nondb']    = 'y';

        // get user to repeat input to avoid mistakes
        if (!isset($fieldarray['new_password2'])) $fieldarray['new_password2'] = '';
        $this->fieldspec['new_password2']['type'] = 'string';
        $this->fieldspec['new_password2']['size'] = $this->fieldspec['user_password']['size'];
        $this->fieldspec['new_password2']['password'] = 'y';
        $this->fieldspec['new_password2']['required'] = 'y';
        $this->fieldspec['new_password2']['nondb']    = 'y';

        // blank out current password (must be re-input)
        //$fieldarray['user_password'] = '';

        // cannot change user_name
        $this->fieldspec['user_name']['noedit'] = 'y';

        if (!is_dir('../responsive-web/xsl')) {
            // directory does not exist, so remove this field
            unset($this->fieldspec['allow_responsive_gui']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (is_True($this->pswd_encrypt)) {
            $crypt_obj = RDCsingleton::getInstance('encryption_class');
            // encrypt input password and compare with original
            $key    = $fieldarray['user_id'];
            $string = $fieldarray['old_password'];
            $spec   = $this->fieldspec['user_password'];
            $string = $crypt_obj->encrypt($key, $string, $spec['size']);
            if ($crypt_obj->errors) {
            	$this->errors['old_password'] = $crypt_obj->errors[0];
            } // if
        } else {
            $string = $fieldarray['old_password'];
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

        // turn of switch which forces user to change his password
        $fieldarray['force_pswd_chg'] = 'N';

        // perform standard processing defined in the parent class
        $fieldarray = parent::_cm_commonValidation($fieldarray, $originaldata);

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        // this is here to override the method in the parent class

        if (isset($fieldarray['allow_responsive_gui'])) {
            if (!isset($this->fieldspec['allow_responsive_gui'])) {
                // fieldspec does not exist, so remove field from output
                unset($fieldarray['allow_responsive_gui']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $where = parent::_cm_initialise($where, $selection, $search);

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
        	$where = "user_id='" .$_SESSION['logon_user_id'] ."'";
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        $rows = parent::_cm_post_getData ($rows, $where);

        // blank out current password (must be re-input)
        $rows[0]['user_password'] = '';

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive
        //$this->row_locks_supp = '?' // DBMS-specific

        // do not reuse existing customised SELECT statement in _dml_ReadBeforeUpdate() method
        //$this->reuse_previous_select = false;

        // user_password is not used in this task
        unset($fieldarray['user_password']);
        $this->fieldspec['user_password']['nodisplay'] = 'y';

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
