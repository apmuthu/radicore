<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_user.class.inc';
class mnu_user_s05 extends mnu_user
{
    // ****************************************************************************
    // This class is for use by script: mnu_user_pswd.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this is here to neutralise the method in the parent class
        unset($GLOBALS['act_buttons']['copy']);
        unset($GLOBALS['act_buttons']['submitnext']);

        $GLOBALS['mode'] = 'recover';

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this is here to neutralise the method in the parent class

        return $fieldarray;

    } // _cm_getExtraData

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

        // find out if user passwords are to be hidden or not
    	$dbobject =& singleton::getInstance('mnu_control');
        $this->pswd_hidden  = $dbobject->getControlData('pswd_hidden');
        $this->pswd_encrypt = $dbobject->getControlData('pswd_encrypt');
        $this->pswd_format  = $dbobject->getControlData('pswd_format');
        unset($dbobject);

        // this is here to neutralise the method in the parent class
        $this->where = $where;

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // this is here to neutralise the method in the parent class

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->skip_getdata    = true;
        $this->checkPrimaryKey = false;
        $this->fieldarray[0]['email_addr'] = '';

        // "Enter e-mail address where password is to be sent"
        $this->messages[]      = getLanguageText('sys0150');

        $where = '';

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        $rowdata = $this->_cm_changeConfig('', $rowdata);

        $email_addr = addslashes($rowdata['email_addr']);
        $data = $this->getData_raw("email_addr='$email_addr'");
        if ($this->numrows < 1) {
            // "E-mail address was not found"
        	$this->errors[] = getLanguageText('sys0151');
        } else {
            $data = $data[0];
            $data = $this->formatData($data);
            $email_addr = $data['email_addr'];
            $password   = $data['user_password'];
            if (is_True($this->pswd_encrypt)) {
                // decrypt the password
                $crypt_obj =& singleton::getInstance('encryption_class');
                $key = $data['user_id'];
                $password = $crypt_obj->decrypt($key, $password);
                if ($crypt_obj->errors) {
                	$this->errors['user_password'] = $crypt_obj->errors[0];
                	return false;
                } // if
            } // if
            // "Here is your password for "
            $subject = getLanguageText('sys0153') .' ' .$_SERVER['HTTP_HOST'];
        	$body    = "Hi,\n\n" .$subject ."\n\n" . $password;

        	if (isset($_SERVER['SERVER_ADMIN'])) {
                $sender  = $_SERVER['SERVER_ADMIN'];
            } else {
                $sender  = 'webmaster@radicore.org';
            } // if
        	$headers = "From: $sender\r\n";

        	$result = mail($email_addr, $subject, $body, $headers);

        	// "Your password has been e-mailed"
            scriptPrevious(null, getLanguageText('sys0152'));
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
