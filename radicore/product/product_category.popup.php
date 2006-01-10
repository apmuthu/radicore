<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'product_category';                     // table name
$screen   = 'product_category.list.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = "product_category.*, CASE WHEN prod_cat_rollup.prod_cat_id_snr IS NULL THEN 'F' ELSE 'T' END AS rollup";
$sql_from   = 'product_category '.
              'LEFT JOIN prod_cat_rollup ON (prod_cat_rollup.prod_cat_id_snr=product_category.prod_cat_id)';
$sql_where  = NULL;
$sql_groupby = 'prod_cat_id';

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.popup.inc';                      // activate page controller

?>
