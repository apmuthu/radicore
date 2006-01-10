<?php
//*****************************************************************************
// This will allow the user to upload a file to the server.
//*****************************************************************************

//DebugBreak();
$xsl_file = 'std.fileupload1.xsl';               // xsl file for transformation
$subdir   = 'pictures';                          // subdirectory
$filetype = 'image';                             // file types to process
$maxfilesize = 100;                              // maximum file size

require 'std.fileupload1.inc';                   // activate page controller

?>
