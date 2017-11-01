<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class prod_feature_interaction extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'prod_feature_interaction';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        if ($fieldarray['prod_feature_id_snr'] == $fieldarray['prod_feature_id_jnr']) {
            $this->errors[] = getLanguageText('e0017'); // 'Cannot add a feature to itself';
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('feature_interaction', $this->lookup_data)) {
            // get array for lookup list and put into LOOKUP_DATA
            $array = $this->getValRep('feature_interaction');
            $this->lookup_data['feature_interaction'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'feature_interaction') {
//            $array['D'] = 'Dependent';
//            $array['I'] = 'Incompatible';
            $array = getLanguageArray('feature_interaction');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array, $return_files)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {
        //DebugBreak();
        if ($return_from == 'pro_prod_feature(popup)snr') {
            $fieldarray['prod_feature_id_snr'] = $select_array['prod_feature_id'];
            unset($select_array['prod_feature_id']);
        } // if

        if ($return_from == 'pro_prod_feature(popup)jnr') {
            $fieldarray['prod_feature_id_jnr'] = $select_array['prod_feature_id'];
            unset($select_array['prod_feature_id']);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        // change fieldname in $fieldarray from 'prod_fature_id' to 'prod_feature_id_jnr'
        if (array_key_exists('prod_feature_id', $fieldarray)) {
            $fieldarray['prod_feature_id_jnr'] = $fieldarray['prod_feature_id'];
            unset($fieldarray['prod_feature_id']);
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
