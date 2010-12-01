<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class product extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function product ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'product';
        $this->tablename   = 'product';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // product

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;

        if ($mode == 'search') {
            // add extra fields to the search screen
            $this->fieldspec['identity_type_id']    = array('type' => 'string',
                                                            'size' => 6,
                                                            'uppercase' => 'y',
                                                            'control' => 'dropdown',
                                                            'optionlist' => 'identity_type_id');
                                                            //'control' => 'popup',
                                                            //'foreign_field' => 'identity_type_desc',
                                                            //'task_id' => 'pro_good_id_type(popup)');
            $this->fieldspec['id_value']            = array('type' => 'string',
                                                            'size' => 32,
                                                            'uppercase' => 'y');
            $this->fieldspec['prod_cat_id']         = array('type' => 'string',
                                                            'size' => 16,
                                                            'uppercase' => 'y',
                                                            'control' => 'popup',
                                                            'foreign_field' => 'prod_cat_desc',
                                                            'task_id' => 'pro_prod_cat(popup)');
            $this->fieldspec['prod_feature_id']     = array('type' => 'mediumint',
                                                            'control' => 'popup',
                                                            'foreign_field' => 'prod_feature_desc',
                                                            'task_id' => 'pro_prod_feature(popup)');
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('product_subtype', $this->lookup_data)) {
            // get array for product_subtype and put into LOOKUP_DATA
            $array = $this->getValRep('product_subtype');
            $this->lookup_data['product_subtype'] = $array;
        } // if

        if (!array_key_exists('identity_type_id', $this->lookup_data)) {
            // get array for good_identity_type and put into LOOKUP_DATA
            $object =& RDCsingleton::getInstance('good_identity_type');
            $array  = $object->getValRep('identity_type_id');
            $this->lookup_data['identity_type_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray)
    // Retrieve data from foreign entities.
    {
        //DebugBreak();
        // NOTE: these are for the search screen only

        if (!empty($fieldarray['identity_type_id']) and empty($fieldarray['identity_type_desc'])) {
            // get description for selected entry
            require_once 'classes/good_identity_type.class.inc';
            $dbobject =& RDCsingleton::getInstance('good_identity_type');
            $dbobject->sql_select = 'identity_type_id, identity_type_desc';
            $foreign_data = $dbobject->getData("identity_type_id='{$fieldarray['identity_type_id']}'");
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $foreign_data[0]);
        } // if

        if (!empty($fieldarray['prod_cat_id']) and empty($fieldarray['prod_cat_desc'])) {
            // get description for selected entry
            require_once 'classes/product_category.class.inc';
            $dbobject =& RDCsingleton::getInstance('product_category');
            $dbobject->sql_select = 'prod_cat_id, prod_cat_desc';
            $foreign_data = $dbobject->getData("prod_cat_id='{$fieldarray['prod_cat_id']}'");
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $foreign_data[0]);
        } // if

        if (!empty($fieldarray['prod_feature_id']) and empty($fieldarray['prod_feature_desc'])) {
            // get description for selected entry
            require_once 'classes/product_feature.class.inc';
            $dbobject =& RDCsingleton::getInstance('product_feature');
            $dbobject->sql_select = 'prod_feature_id, prod_feature_desc';
            $foreign_data = $dbobject->getData("prod_feature_id='{$fieldarray['prod_feature_id']}'");
            // merge with existing data
            $fieldarray = array_merge($fieldarray, $foreign_data[0]);
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'product_subtype') {
//            $array['G'] = 'Good';
//            $array['S'] = 'Service';
            $array = getLanguageArray('product_subtype');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        //DebugBreak();
        if (empty($this->sql_search)) {
            // no search criteria to be modified
            return $where;
        } // if

        $search = $this->sql_search;

        $this->sql_select  = "$this->tablename.*";
        $this->sql_from    = $this->tablename;
        $this->sql_groupby = '';

        if (eregi('(identity_type_id|id_value)', $search, $regs)) {
            $this->sql_from .= " LEFT JOIN good_identification"
                             . " ON (good_identification.product_id=product.product_id)";
            $this->sql_groupby = 'product.product_id';
        } // if

        if (eregi('(prod_feature_id)', $search, $regs)) {
            $today = date('Y-m-d');
            $this->sql_from .= " LEFT JOIN prod_feature_applicability"
                             . " ON (prod_feature_applicability.product_id=product.product_id"
                             . " AND prod_feature_applicability.start_date<='$today'"
                             . " AND prod_feature_applicability.end_date>='$today')";
            $this->sql_groupby = 'product.product_id';
        } // if

        if (eregi('(prod_cat_id)', $search, $regs)) {
            if (eregi('(prod_cat_id LIKE)', $search, $regs)) {
                // this value may have a hierarchy on PROD_CAT_ROLLUP, so extract complete
                // hierarchy structure and build into a range of values
                // convert search string to an array
                $array = where2array($search, false, false);

                // extract value for prod_cat_id
                $prod_cat_id = $array['prod_cat_id'];
                // remove 'LIKE ' operator
                $prod_cat_id = ltrim($prod_cat_id, "LIKE ");
                // remove prod_cat_id from array
                unset($array['prod_cat_id']);

                require_once 'classes/prod_cat_rollup.class.inc';
                $dbobject =& RDCsingleton::getInstance('prod_cat_rollup');
                $dbobject->sql_select = 'prod_cat_id_jnr';

                // initialise range with starting value
                $range  = $prod_cat_id;
                $range2 = $range;
                // repeat until end of hierarchy is reached
                do {
                    // look for children of current range
                    $array2 = $dbobject->getData_raw("prod_cat_id_snr IN ($range2)");
                    if (!empty($array2)) {
                        // convert array of rows into a range string
                        $range2 = array2range($array2);
                        // append to whole range string
                        $range .= ",$range2";
                    } // if
                } while (!empty($array2));

                // add complete range string to array
                $array['prod_cat_id'] = "IN ($range)";

                // rebuild search string with range string
                $this->sql_search = array2where($array);
            } // if

            $today = date('Y-m-d');
            $this->sql_from .= " LEFT JOIN prod_cat_class"
                             . " ON (prod_cat_class.product_id=product.product_id"
                             . " AND prod_cat_class.start_date<='$today'"
                             . " AND prod_cat_class.end_date>='$today')";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update and allow for changes being made.
    {
        //DebugBreak();
        if ($fieldarray['product_subtype'] != $originaldata['product_subtype']) {
            // value has changed, so ...
            if ($originaldata['product_subtype'] == 'G') {
                $where = "product_id='{$fieldarray['product_id']}'";
                $query = "SELECT count(*) FROM good_identification WHERE $where";
                $count = $this->getCount($query);
                if ($count > 0) {
                    $fieldarray['product_subtype'] = 'G';
                    // "Cannot change when identification values exist"
                    $this->errors['product_subtype'] = getLanguageText('e0018');
                    return $fieldarray;
                } // if
            } // if
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
