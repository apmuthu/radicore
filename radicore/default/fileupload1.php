<?php
//*****************************************************************************
// This will allow the user to upload a file to the server.
//*****************************************************************************

$xsl_file = 'std.fileupload1.xsl';               // xsl file for transformation
$subdir   = '#dirname#';                         // subdirectory
$filetype = '#filetype#';                        // file types to process
$maxfilesize = '#maxfilesize#';                  // maximum file size

require 'std.fileupload1.inc';                   // activate page controller

?>
