<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class product_feature extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function product_feature ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'product_feature';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // product_feature

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {

        global $mode;

        if ($mode == 'update') {
            $this->fieldspec['prod_feature_cat_id']['noedit'] = 'y';
        } // if
        if ($mode == 'search') {
            $this->fieldspec['prod_feature_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (!isset($fieldarray['measurement_reqd'])) {
            require_once 'product_feature_category.class.inc';
            $dbobject =& singleton::getInstance('product_feature_category');
            $dbobject->sql_select = 'measurement_reqd';
            $data = $dbobject->getData("prod_feature_cat_id='{$fieldarray['prod_feature_cat_id']}'");
            $fieldarray = array_merge($fieldarray, $data[0]);
        } // if

        if (is_true($fieldarray['measurement_reqd'])) {
            if (empty($fieldarray['uom_id'])) {
                $this->errors['uom_id'] = getLanguageText('sys0020', 'UOM_ID'); // "This field is required";
            } // if
            if (empty($fieldarray['measurement'])) {
                $this->errors['measurement'] = getLanguageText('sys0020', 'MEASUREMENT'); // "This field is required";
            } // if
        } else {
            $fieldarray['uom_id'] = null;
            $fieldarray['measurement'] = null;
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get contents of foreign table and add to lookup array
        require_once 'product_feature_category.class.inc';
        $dbobject =& singleton::getInstance('product_feature_category');
        $data_array = $dbobject->getValRep('prod_feaure_cat_id');
        $this->lookup_data['prod_feature_cat_id'] = $data_array;

        // get contents of foreign table and add to lookup array
        require_once 'unit_of_measure.class.inc';
        $dbobject =& singleton::getInstance('unit_of_measure');
        $data_array = $dbobject->getValRep('uom_id');
        $this->lookup_data['uom_id'] = $data_array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        $count = $this->getCount("SELECT max(prod_feature_id) FROM $this->tablename");
        $fieldarray['prod_feature_id'] = (int)$count + 1;

        $this->fieldspec['prod_feature_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        if (array_key_exists('measurement_reqd', $rowdata[0])) {
            if (is_true($rowdata[0]['measurement_reqd'])) {
                $this->fieldspec['uom_id']['required']      = 'y';
                $this->fieldspec['measurement']['required'] = 'y';
                unset($this->fieldspec['uom_id']['nodisplay']);
                unset($this->fieldspec['measurement']['nodisplay']);
            } else {
                unset($this->fieldspec['uom_id']['required']);
                unset($this->fieldspec['measurement']['required']);
                $this->fieldspec['uom_id']['nodisplay']      = 'y';
                $this->fieldspec['measurement']['nodisplay'] = 'y';
                $fieldarray['uom_id']                        = null;
                $fieldarray['measurement']                   = null;
            } // if
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    {
        //DebugBreak();
        if (empty($this->sql_select)) {
            $this->sql_select = "$this->tablename.*, measurement_reqd, uom_abbrev";
            $this->sql_from   = "$this->tablename "
                              . "LEFT JOIN product_feature_category "
                              . "ON (product_feature_category.prod_feature_cat_id=$this->tablename.prod_feature_cat_id) "
                              . "LEFT JOIN unit_of_measure "
                              . "ON (unit_of_measure.uom_id=$this->tablename.uom_id) ";
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
