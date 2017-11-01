<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'product_category';                    // table name
$screen   = 'product_category.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = "product_category.prod_cat_id, product_category.prod_cat_desc, CASE WHEN prod_cat_rollup.prod_cat_id_snr IS NULL THEN 'F' ELSE 'T' END AS rollup";
$sql_from   = 'product_category '.
              'LEFT JOIN prod_cat_rollup ON (prod_cat_rollup.prod_cat_id_snr=product_category.prod_cat_id)';
$sql_where  = NULL;
$sql_groupby = 'product_category.prod_cat_id, product_category.prod_cat_desc, prod_cat_rollup.prod_cat_id_snr';

require 'std.list1.inc';            // activate page controller

?>
