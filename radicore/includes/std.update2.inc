<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update2.inc

// type = update2

// This will update records in the database using data in $where (supplied by the
// previous screen) plus data selected by a popup screen which will called next.
// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (basename($return_from) <> $popup_screen) {
        // have not been to popup screen yet, so go there now
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $_SESSION[$PHP_SELF][$task_id]['selection'] = null;
        scriptNext($popup_screen, $where);
    } else {
        if (empty($selection)) {
            scriptprevious(getLanguageText('sys0083')); // 'Nothing selected from popup screen.'
        } // if
    } // if

    // we now have some data in $where (from the previous screen)
    // and some in $selection (from the popup screen)
    // use them to update the database accordingly
    $dbobject->startTransaction();

    $messages = $dbobject->updateSelection($selection, $where);
    $errors   = $dbobject->getErrors();
    if (!$errors) {
    	$errors = $dbobject->commit();
    } // if
    if ($errors) {
        $dbobject->rollback();
    } // if

    if (empty($errors)) {
        if (isset($popup_repeat)) {
            // clear output from previous popup
            unset($script_vars['selection']);
            $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
            $_SESSION[$PHP_SELF][$task_id] = $script_vars;
            // repeat popup screen
            scriptnext($popup_screen, $where);
        } // if
    } // if

    // return to previous screen
    scriptPrevious($errors, $messages);
} // if

?>
