<?php
//*****************************************************************************
// This is a special script that will allow a user's password to be reset.
// It should only be used as a last resort.
// Use: ../mnu_user_reset.php?user_id=...
//*****************************************************************************

$table_id = 'mnu_user_s03';                         // table id
$screen   = 'mnu_user.detail(pswd).screen.inc';     // file identifying screen structure

require_once 'include.general.inc';

// custom code...
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
   // cancel any current session
   session_start();
   session_unset();
   $_SESSION['role_id'] = 'GLOBAL';
   // load user_id into script vars
   if (isset($_GET['user_id'])) {
      $user_id = &$_GET['user_id'];
   } else {
      $user_id = 'null';
   } // if
   $task_id = 'logon';
   $PHP_SELF = getSelf();
   $_SESSION['pages'][$PHP_SELF]['task_id'] = $task_id;
   $_SESSION['pages'][$PHP_SELF][$task_id]['where'] = "user_id='$user_id'";
   $_SESSION['logon_user_id'] = $user_id;
} // endif

require 'std.update1.inc';  // activate page controller

?>