<?php
//*****************************************************************************
// This will display the contents of a subdirectory and allow the user to
// chose one of the files.
//*****************************************************************************

//DebugBreak();
$screen   = 'person.filepicker.screen.inc'; // file identifying screen structure
$subdir   = 'pictures';                     // subdirectory
$filetype = 'image';                        // file types to process

// activate page controller
require 'std.filepicker1.inc';

?>
