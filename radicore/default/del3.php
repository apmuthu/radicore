<?php
//*****************************************************************************
// Allow occurrences of a CHILD entry to be unlinked from a PARENT entry.
// The identity of the PARENT and a list of one or more CHILD entries is
// passed down from the previous screen.
// Unlinking may involve either the deletion of link records, or the updating
// each CHILD entry to set its PARENT ID to NULL.
//*****************************************************************************

//DebugBreak();
$table_id = '#tablename#';          // table name

require 'std.delete3.inc';          // activate page controller

?>
