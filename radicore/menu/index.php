<?php

// look for existing session
session_start();
// now destroy it and start afresh
$_SESSION = array();
session_destroy();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Tony's demonstration menu system</title>
	<style type="text/css">
	<!--
		body { margin-left: 5%; margin-right: 5%; }
		h1 { text-align: center; }
	-->
	</style>
</head>

<body>

<h1>Tony's demonstration menu system</h1>

<table border="0">
<colgroup width="150" />

<?php
if ($_SERVER['SERVER_NAME'] == 'localhost' or $_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
?>
<tr><td><img src="../counter.php?page=<?php echo $_SERVER['PHP_SELF'] ?>" alt="counter" /></td><td></td></tr>
<tr><td>HTTP_REFERER</td><td><?= @$_SERVER['HTTP_REFERER'] ?></td><td></td></tr>
<tr><td><a href="../counter_r1.php">Read Page Counter</a></td><td><a href="../counter-mail.php">Email Page Counter</a></td></tr>
<tr><td><a href="../errorlog.html">View Error Log</a></td><td><a href="../errorlogdel.php">Delete Error Log</a></td></tr>
<?php
} // if
?>
<tr><td><hr /></td></tr>
<tr><td><a href="../index.html">Home page</a></td>
    <td>&lt;- Click here for my home page</td>
<tr><td><hr /></td></tr>
<tr><td><a href="logon.php?csxslt=off">Logon</a></td>
    <td>&lt;- Click here for the logon screen</td>
</tr>
<tr><td><a href="logon.php?csxslt=on">Logon (csxslt)</a></td>
    <td>&lt;- Click here for the logon screen (with client-side XSL transformations)</td>
</tr>
<tr><td><hr /></td></tr>
</table>

</body>
</html>
