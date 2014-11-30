<?php
$dir = basename(getcwd());
if ($dir == 'radicore') {
	$header = 'Location: menu/logon.php';
} else {
    $header = "Location: $dir/menu/logon.php";
} // if
header($header);
?>