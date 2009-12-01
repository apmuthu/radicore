<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class php_session extends Default_Table
{
    // ****************************************************************************
    // This class saves the PHP session data in a database table.
    // ****************************************************************************

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function php_Session ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'audit';
        $this->tablename   = 'php_session';

        $this->fieldspec = $this->getFieldSpec_original();

        // there is absolutely NO logging of the audit database
        $this->audit_logging = false;

    } // php_Session

    // ****************************************************************************
    function open ($save_path, $session_name)
    // open the session.
    {
        // do nothing
        return true;

    } // open

    // ****************************************************************************
    function close ()
    // close the session.
    {
        if (!empty($this->fieldarray)) {
            // perform garbage collection
            $result = $this->gc(ini_get('session.gc_maxlifetime'));
            return $result;
        } // if

        return FALSE;

    } // close

    // ****************************************************************************
    function read ($session_id)
    // read any data for this session.
    {
        // strip off any trailing characters
        $session_id = substr($session_id, 0, $this->fieldspec['session_id']['size']);

        $fieldarray = $this->_dml_getData("session_id='" .addslashes($session_id) ."'");

        if (isset($fieldarray[0]['session_data'])) {
            $this->fieldarray = $fieldarray[0];
            $this->fieldarray['session_data'] = '';
            return $fieldarray[0]['session_data'];
        } else {
            return '';  // return an empty string
        } // if

    } // read

    // ****************************************************************************
    function write ($session_id, $session_data)
    // write session data to the database.
    {
        // strip off any trailing characters
        $session_id = substr($session_id, 0, $this->fieldspec['session_id']['size']);

        if (!empty($this->fieldarray)) {
            if ($this->fieldarray['session_id'] != $session_id) {
                // user is starting a new session with previous data
                $this->fieldarray = array();
            } // if
        } // if

        $count = $this->getCount("session_id='" .addslashes($session_id) ."'");

        if ($count == 0) {
            // create new record
            $array['session_id']   = $session_id;
            $array['date_created'] = getTimeStamp();
            $array['last_updated'] = getTimeStamp();
            $array['session_data'] = $session_data;
            $this->_dml_insertRecord($array);
        } else {
            // update existing record
            if (isset($_SESSION['logon_user_id'])) {
                $array['user_id']  = $_SESSION['logon_user_id'];
            } // if
            $array['last_updated'] = getTimeStamp();
            $array['session_data'] = $session_data;
            if ($session_id == $this->fieldarray['session_id']) {
            	$old_data[0] = $this->fieldarray;
            } else {
                $old_data = $this->_dml_ReadBeforeUpdate ("session_id='" .addslashes($session_id) ."'");
            } // if
            $this->_dml_updateRecord($array, $old_data[0]);
        } // if

        return true;

    } // write

    // ****************************************************************************
    function destroy ($session_id)
    // destroy the specified session.
    {
        // strip off any trailing characters
        $session_id = substr($session_id, 0, $this->fieldspec['session_id']['size']);

        $fieldarray['session_id'] = $session_id;
        $this->_dml_deleteRecord($fieldarray);

        return true;

    } // destroy

    // ****************************************************************************
    function gc ($max_lifetime)
    // perform garbage collection.
    {
        $real_now = date('Y-m-d H:i:s');
        $dt1 = strtotime("$real_now -$max_lifetime seconds");
        $dt2 = date('Y-m-d H:i:s', $dt1);

        $count = $this->_dml_deleteSelection("last_updated < '$dt2'");

        return true;

    } // gc

    // ****************************************************************************
    function __destruct ()
    // ensure session data is written out before this class is destroyed
    // (see http://bugs.php.net/bug.php?id=33772 for details)
    {

        @session_write_close();

    } // __destruct

// ****************************************************************************
} // end class
// ****************************************************************************

?>
