<?php
$dir = basename(getcwd());
if (preg_match('/^(radicore|transix)$/i', $dir)) {
	$header = 'Location: menu/logon.php';
} else {
    $header = "Location: $dir/menu/logon.php";
} // if
header($header);
?>