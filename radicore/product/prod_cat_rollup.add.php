<?php
//*****************************************************************************
// Allow occurrences of the MANY table in a ONE(a)-to-MANY-to-ONE(b) relationship
// to be created. 
// The primary key for ONE(a) is passed from the previous screen while one or
// more primary keys from ONE(b) are selected in a separate popup screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'prod_cat_rollup';   // table name (many)

$popup_screen = 'pro_prod_cat(popup)';

// activate page controller
require 'std.add3.inc';

?>

