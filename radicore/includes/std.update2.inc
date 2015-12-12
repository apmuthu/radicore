<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update2.inc

// type = update2

// This will update records in the database using data in $where (supplied by the
// previous screen) plus data selected by a popup screen which will be called next.
// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
// perform any initiaisation
$where = $dbobject->initialise($where, $selection);

if (!isset($popup_task)) {
	$popup_task =& $popup_screen;
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (basename($return_from) <> $popup_task) {
        // have not been to popup screen yet, so go there now
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $script_vars = $_SESSION['pages'][$PHP_SELF][$task_id];
        $fieldarray  = array();
        $settings    = null;
        // may need to adjust contents of $where or $settings
        $where       = $dbobject->popupCall($popup_task, $where, $script_vars, $fieldarray, $settings);
        $task_array['settings'] = $settings;
        $batch_errors = scriptNext($popup_task, $where, null, $task_array);
        return $batch_errors;
    } else {
        if (empty($selection)) {
            // 'Nothing selected from popup screen'
            $batch_errors = scriptprevious(getLanguageText('sys0083'));
            return $batch_errors;
        } // if
    } // if

    // we now have some data in $where (from the previous screen)
    // and some in $selection (from the popup screen)
    // use them to update the database accordingly
    $dbobject->startTransaction();

    $messages[] = $dbobject->updateSelection($selection, $where);
    $messages = array_merge($messages, $dbobject->getMessages());
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
            $script_vars = updateScriptVars ($script_vars);
            // repeat popup screen
            $batch_errors = scriptnext($popup_task, $where);
            return $batch_errors;
        } // if
    } // if

    if (empty($errors)) {
    	$action = 'update';
    } else {
        $action = 'fail';
    } // if

    // return to previous screen
    $batch_errors = scriptPrevious($errors, $messages, $action);
    return $batch_errors;
} // if

?>
