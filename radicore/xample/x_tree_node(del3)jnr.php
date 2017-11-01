<?php
//*****************************************************************************
// Allow occurrences of the TREE_NODE table to be unlinked from a parent node.
// The identity of the parent (NODE_ID_SNR) and a list of one or more NODE_IDs
// is passed down from the previous screen.
// For the selected nodes the value of NODE_ID_SNR will be set to NULL.
//*****************************************************************************

$table_id = 'x_tree_node_jnr';      // table name

require_once 'std.delete3.inc';     // activate page controller

?>
