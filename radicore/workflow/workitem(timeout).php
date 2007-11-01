<?

/*
Look for wf_workitem records whose deadline has passed so that they may be closed
*/

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

// create object for wf_workitem table
require 'classes/wf_workitem.class.inc';
$workitem = new wf_workitem;

// create object for workflow processing
require_once 'classes/workflow_engine.class.inc';
$workflow = new workflow_engine;

$now = getTimeStamp();
$where = "workitem_status='EN' AND deadline <= '$now'";
$workitem->sql_orderby = 'case_id, deadline';
$workitem_result = $workitem->getData_serial($where);
$workflow->startTransaction();
while ($row = $workitem->fetchRow($workitem_result)) {
    $case_id     = $row['case_id'];
    $workitem_id = $row['workitem_id'];
    $context     = $row['context'];
    $row = $workflow->fireTimedEvent($row);
    check_errors($workflow);
} // while

$workflow->commit();

//$_SESSION['script_sequence'][0]['task_id'] = 'x_person(del)2';
//$_SESSION['script_sequence'][0]['where']   = "person_id='TEST1'";

if (isset($_SESSION['script_sequence'])) {
	require_once 'classes/mnu_task.class.inc';
	$taskobj = new mnu_task;
	$taskobj->sql_select = 'script_id, subsys_dir';
	$taskobj->sql_from   = 'mnu_task '
	                     . 'LEFT JOIN mnu_subsystem ON (mnu_subsystem.subsys_id=mnu_task.subsys_id) ';
    foreach ($_SESSION['script_sequence'] as $task) {
        $task_id = $task['task_id'];
        $context = $task['where'];
        $task_data = $taskobj->getData_raw("task_id='$task_id'");
        check_errors($taskobj);
        // set up instructions for next script
        $next_script = '/' .$task_data[0]['subsys_dir'] .'/' .$task_data[0]['script_id'];
        $_SESSION[$next_script]['task_id']             = $task_id;
        $_SESSION[$next_script][$task_id]['where']     = $context;
        $_SESSION[$next_script][$task_id]['selection'] = $context;
        $_SERVER['PHP_SELF']    = $next_script;
        $_SERVER['SCRIPT_NAME'] = $next_script;
        $_SESSION['role_id']    = 'batch';
        // now change directory and execute the specified script
        $new_dir = "../" .$task_data[0]['subsys_dir'];
        chdir($new_dir);
        $batch_errors = null;
        require_once $task_data[0]['script_id'];
        if ($batch_errors) {
            $workflow->rollback();
        	trigger_error("Task_id='$task_id': " .$batch_errors, E_USER_ERROR);
        } // if

    } // foreach
} // if

batchEnd();

?>
