<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
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
        logstuff("SESSION_ID: $session_id", 'session_'.__FUNCTION__, __LINE__);

        // strip off any trailing characters
        $session_id = substr($session_id, 0, $this->fieldspec['session_id']['size']);

        $session_id = addslashes($session_id);

        $fieldarray = $this->_dml_getData("session_id='$session_id'");

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

        logstuff("SESSION_ID: $session_id", 'session_'.__FUNCTION__, __LINE__);

        $session_id = addslashes($session_id);

        if (!empty($this->fieldarray)) {
            if ($this->fieldarray['session_id'] != $session_id) {
                // user is starting a new session with previous data
                $this->fieldarray = array();
            } // if
        } // if

        $count = $this->getCount("session_id='$session_id'");

        // deal with any UTF-8 characters
        //$session_data = iconv('iso-8859-1', 'UTF-8//TRANSLIT', $session_data);

        if ($this->fieldspec['session_data']['type'] == 'blob') {
            // convert string data to binary data
            list($dbname2, $dbprefix, $dbms_engine) = findDBConfig($this->dbname);
            switch ($dbms_engine) {
                case 'sqlsrv':
                    // deal with any UTF-8 characters
                    $session_data = iconv('iso-8859-1', 'UTF-8//TRANSLIT', $session_data);
                    // cause this column to be converted into binary
                    $this->allow_db_function[] = 'session_data';
                    $session_data = "CONVERT(varbinary(max),'$session_data')";
                    //$query = "SELECT CONVERT(varbinary(max),?) AS result";
                    //$result = null;
                    //$params = array(&$session_data);
                    //$session_data = '0x'.$this->executePreparedQuery($query, $params, 'string');
                    break;
                case 'oracle':

                    break;
                case 'pgsql':

                    break;
                case 'mysql':

                    break;
                default:
                    // do nothing
            } // switch
        } // if

        if ($count == 0) {
            // create new record
            $array['session_id']   = $session_id;
            //$array['date_created'] = date('Y-m-d H:i:s');
            //$array['last_updated'] = date('Y-m-d H:i:s');
            $array['date_created'] = 'now()';
            $this->allow_db_function[] = 'date_created';
            $array['last_updated'] = 'now()';
            $this->allow_db_function[] = 'last_updated';
            $array['session_data'] = $session_data;
            $this->update_on_duplicate_key = true;
            $this->_dml_insertRecord($array);
        } else {
            // update existing record
            if (isset($_SESSION['logon_user_id'])) {
                $array['user_id']  = $_SESSION['logon_user_id'];
            } // if
            //$array['last_updated'] = date('Y-m-d H:i:s');
            $array['last_updated'] = 'now()';
            $this->allow_db_function[] = 'last_updated';
            $array['session_data'] = $session_data;
            if (isset($this->fieldarray['session_id']) AND $this->fieldarray['session_id'] == $session_id) {
            	$old_data[0] = $this->fieldarray;
            } else {
                $old_data = $this->_dml_ReadBeforeUpdate ("session_id='$session_id'");
            } // if
            $this->_dml_updateRecord($array, $old_data[0]);
        } // if

        $result = RDCsingleton::getInstance('__destruct');

        return true;

    } // write

    // ****************************************************************************
    function destroy ($session_id)
    // destroy the specified session.
    {
        // strip off any trailing characters
        $session_id = substr($session_id, 0, $this->fieldspec['session_id']['size']);

        logstuff("SESSION_ID: $session_id", 'session_'.__FUNCTION__, __LINE__);

        $fieldarray['session_id'] = addslashes($session_id);
        $this->_dml_deleteRecord($fieldarray);

        return true;

    } // destroy

    // ****************************************************************************
    function gc ($max_lifetime)
    // perform garbage collection.
    {
        $count = $this->_dml_deleteSelection("last_updated < DATE_SUB(NOW(), INTERVAL $max_lifetime SECOND)");

        if ($count > 0) {
            logstuff("COUNT: $count", 'session_'.__FUNCTION__, __LINE__);
        } // if

        //$now = date('Y-m-d H:i:s');
        //$count = $this->_dml_deleteSelection("last_updated < DATE_SUB('$now', INTERVAL $max_lifetime SECOND)");

        //$count = $this->_dml_deleteSelection("DATE_SUB(NOW(), INTERVAL $max_lifetime SECOND) > last_updated");
        //$count = $this->_dml_deleteSelection("DATE_SUB(last_updated, INTERVAL $max_lifetime SECOND) < now()");

        return true;

    } // gc

    // ****************************************************************************
    function __destruct ()
    // ensure session data is written out before this class is destroyed
    // (see http://bugs.php.net/bug.php?id=33772 for details)
    {

        $result = RDCsingleton::getInstance('__destruct');
        @session_write_close();

    } // __destruct

// ****************************************************************************
} // end class
// ****************************************************************************

?>
