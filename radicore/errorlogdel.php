<?php

// Delete errorlog.html

$fp = fopen('errorlog.html', 'w');
fclose($fp);

echo "<div align='center'>\n";
echo "<p>Errorlog has been deleted.</p>\n";
echo "<p>Press your browser 'back' button to continue.</p>\n";
echo "</div>";
exit;
?>