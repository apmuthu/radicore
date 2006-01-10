<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_todo extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_todo ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_todo';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_todo

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get contents of foreign table MNU_ROLE and put into lookup_data
        require_once 'mnu_user.class.inc';
        $dbobject =& singleton::getInstance('mnu_user');
        $array = $dbobject->getValRep('user_id');
        $this->lookup_data['user_id'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // these fields should not appear on INSERT screen
        $this->fieldspec['is_complete']['nodisplay'] = 'y';
        $this->fieldspec['seq_no']['nodisplay']      = 'y';

        if (isset($fieldarray['user_id']) and !empty($fieldarray['user_id'])) {
            // obtain the next value for table_seq_no
            $select = "SELECT max(seq_no) FROM $this->tablename WHERE user_id='{$fieldarray['user_id']}'";
            $count = $this->getCount($select);
            $fieldarray['seq_no'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {
        require_once 'std.datevalidation.class.inc';
        $dateobj =& singleton::getInstance('date_class');

        $due_date = $dateobj->getInternalDate($fieldarray['due_date']);

        if ($due_date <= getTimeStamp ('date')) {
            // 'Due Date must be in the future'
        	$this->errors['due_date'] = getLanguageText('e0033');
        } // if

        return $fieldarray;

    } // _cm_validateInsert

// ****************************************************************************
} // end class
// ****************************************************************************

?>
