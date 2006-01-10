<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'product_category.class.inc';
class product_category_snr extends product_category
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        // change fieldname in $where from 'prod_cat_id_snr' to 'prod_cat_id'
        $where = str_replace('prod_cat_id_snr=', 'prod_cat_id=', $where);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
