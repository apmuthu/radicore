<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class good_identification extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'good_identification';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {

        switch ($GLOBALS['task_id']) {
            case 'pro_good_id(upd)':
                // this field cannot be modified
                $this->fieldspec['identity_type_id']['noedit'] = 'y';
                break;
            default:
                ;
        } // switch

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('identity_type_id', $this->lookup_data)) {
            // get contents of foreign table and add to lookup array
            $dbobject = RDCsingleton::getInstance('good_identity_type');
            $data_array = $dbobject->getValRep('identity_type_id');
            $this->lookup_data['identity_type_id'] = $data_array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        require_once 'classes/product.class.inc';
        $dbobject = RDCsingleton::getInstance('product');
        $dbobject->sql_select = 'product_subtype';
        $data = $dbobject->getData("product_id='{$fieldarray['product_id']}'");
        if ($data[0]['product_subtype'] != 'G') {
            $this->errors[] = getLanguageText('e0001'); // "Can only add identification to products of type GOOD";
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
