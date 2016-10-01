<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_user_role extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname     = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_user_role';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        if (is_True($fieldarray['is_primary'])) {
            // ensure that at least one row has 'primary=TRUE'
            $this->_setPrimaryTrue($fieldarray);
        } // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        if (is_True($fieldarray['is_primary'])) {
            // ensure this is the only row with 'primary=TRUE'
            $this->_setPrimaryFalse($fieldarray);
        } else {
            // ensure that at least one row has 'primary=TRUE'
            $this->_setPrimaryTrue($fieldarray);
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        if (is_True($this->skip_validation)) {
            // skip the next bit
        } else {
            if (is_True($fieldarray['is_primary'])) {
                // ensure that any other rows have 'primary=FALSE'
                $this->_setPrimaryFalse($fieldarray);
            } else {
                // if there are other rows ensure that one of them has 'primary=TRUE'
                $this->_setPrimaryTrue($fieldarray);
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_validateDelete ($rowdata, $parent_table)
    // verify that the selected record can be deleted.
    // ($parent_table is only used in a cascade delete)
    // if anything is placed in $this->errors the delete will be terminated.
    {
        if (is_null($parent_table)) {
            $count = $this->getCount("user_id='{$rowdata['user_id']}'");
            if ($count <= 1) {
                // "Cannot delete a user's only role"
                $this->errors[] = getLanguageText('e0000');
            } // if
        } // if

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _setPrimaryFalse ($fieldarray)
    // current row has 'primary=TRUE', so all others must have 'primary=FALSE'
    {
        $save_numrows = $this->numrows;

        $date = getTimeStamp('date');

        $selection = "user_id='{$fieldarray['user_id']}'"
                   ." AND role_id != '{$fieldarray['role_id']}'";
        $replace   = "is_primary='" .$this->fieldspec['is_primary']['false'] ."'";
        $count = $this->_dml_updateSelection($selection, $replace);

        $this->numrows = $save_numrows;

        return;

    } // _setPrimaryFalse

    // ****************************************************************************
    function _setPrimaryTrue ($fieldarray)
    // if there are other rows ensure that one of them has 'primary=TRUE'
    {
        $date = getTimeStamp('date');

        $where = "user_id='{$fieldarray['user_id']}'";
        $true = $this->fieldspec['is_primary']['true'];
        $count = $this->getCount($where ." AND is_primary='$true'");
        if ($count < 1) {
            $this->sql_orderby = "created_date asc";
            $data = $this->getData($where);
            if (!empty($data)) {
                $update = $data[0];  // use 1st record only
                $update['is_primary'] = $true;
                $this->skip_validation = true;
                $update = $this->updateRecord($update);
            } // if
        } // if

        return;

    } // _setPrimaryTrue

// ****************************************************************************
} // end class
// ****************************************************************************

?>
