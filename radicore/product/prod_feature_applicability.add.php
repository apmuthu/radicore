<?php
//*****************************************************************************
// Allow a new occurrence to be added to the PROD_FEATURE_INTERACTION table for a
// particular value of PRODUCT_ID, as selected in the previous screen..
//*****************************************************************************

//DebugBreak();
$table_id = 'prod_feature_applicability';                     // table name
$screen   = 'prod_feature_applicability.detail.screen.inc';   // file identifying screen structure

// activate page controller
require 'std.add2.inc';

?>
