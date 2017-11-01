<?php

// Delete errorlog.html

$header = <<< END_OF_HEADER
<!DOCTYPE HTML SYSTEM>
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type="text/css">
<!--
  .error h2, .error p {
    color: red;
    font-weight: bold;
  }
-->
</STYLE>
</HEAD>
<BODY>
END_OF_HEADER;

$fp = fopen('./error_logs/errorlog.html', 'w');
$result = fwrite($fp, $header);
fclose($fp);

echo "<div align='center'>\n";
echo "<p>Errorlog has been deleted.</p>\n";
echo "<p>Press your browser 'back' button to continue.</p>\n";
echo "</div>";
exit;
?>