<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class uom_conversion extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function uom_conversion ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'uom_conversion';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // uom_conversion

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['uom_id_from'] == $fieldarray['uom_id_to']) {
            $this->errors['uom_id_from'] = getLanguageText('e0019'); // "FROM ID cannot be same as TO ID";
            $this->errors['uom_id_to']   = getLanguageText('e0020'); // "TO ID cannot be same as FROM ID";
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if (!isset($fieldarray['uom_id_from'])) {
            if (isset($fieldarray['uom_id'])) {
                $fieldarray['uom_id_from'] = $fieldarray['uom_id'];
                unset($fieldarray['uom_id']);
            } // if
        } // if

        if (empty($fieldarray['uom_id_from'])) {
            $this->errors = getLanguageText('sys0082'); // 'No parent has been selected yet.';
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        //DebugBreak();
        if ($return_from == 'pro_uom(popup)') {
            $fieldarray['uom_id_to'] = $fieldarray['uom_id'];
            unset($fieldarray['uom_id']);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        // change fieldname in $where from 'uom_id' to 'uom_id_from'
        $where = str_replace('uom_id=', 'uom_id_from=', $where);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
