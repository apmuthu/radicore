<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class prod_cat_rollup extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'product';
        $this->tablename   = 'prod_cat_rollup';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        if ($fieldarray['prod_cat_id_snr'] == $fieldarray['prod_cat_id_jnr']) {
            $this->errors[] = getLanguageText('e0014'); // 'Cannot add a category to itself';
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        //DebugBreak();
        switch ($GLOBALS['task_id']) {
            case 'pro_prod_cat_rollup(list)':
                // change fieldname in $where from 'prod_cat_id' to 'prod_cat_id_snr'
                $where = str_replace('prod_cat_id=', 'prod_cat_id_snr=', $where);
                break;
            default:
                ;
        } // switch

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        // change fieldname in $fieldarray from 'prod_cat_id' to 'prod_cat_id_jnr'
        if (array_key_exists('prod_cat_id', $fieldarray)) {
            $fieldarray['prod_cat_id_jnr'] = $fieldarray['prod_cat_id'];
            unset($fieldarray['prod_cat_id']);
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
