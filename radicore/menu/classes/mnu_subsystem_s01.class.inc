<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_subsystem.class.inc';
class mnu_subsystem_s01 extends mnu_subsystem
{
    // member variables
    var $text_out;          // to be written to a text file

    // ****************************************************************************
    // This class is used to export task details for a subsystem to a text file.
    // It will also export the contents of the MENU database to an SQL file so that
    // the details can be reloaded if needed.
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // custom code goes here

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->checkPrimaryKey = true;  // check for primary key in selection

        if (empty($this->sql_select)) {
            // obtain SUBSYS_DIR
            $this->sql_select = 'subsys_id, subsys_dir';
            $this->sql_from   = 'mnu_subsystem';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // (1) create file 'text/<subsys>.menu_export.txt'

        // create object for retrieving task details
        $taskobj =& singleton::getInstance('mnu_task');

        // create object for retrieving dictionary details
        $dictobj =& singleton::getInstance('dict_column');

		$subsys_id   = $rowdata['subsys_id'];
        $subsys_dir  = $rowdata['subsys_dir'];

		$this->text_out = '// file created on ' .date('F j, Y, g:i a') ."\r\n    \r\n";

        // process menu descriptions
    	$taskobj->sql_select = 'menu_id, task_id_jnr, mnu_menu.button_text';
    	$taskobj->sql_from   = 'mnu_task RIGHT JOIN mnu_menu ON (mnu_task.task_id=mnu_menu.menu_id)';
    	$taskobj->sql_orderby = 'mnu_menu.button_text';
        $data = $taskobj->getData("subsys_id='$subsys_id'");
        $this->_createMenuDesc($data, $subsys_id);

		// process task descriptions
    	$taskobj->sql_select = 'task_id, task_desc';
    	$taskobj->sql_from   = 'mnu_task';
    	$taskobj->sql_orderby = 'task_id';
        $data = $taskobj->getData("subsys_id='$subsys_id' AND task_type='PROC'");
		$this->_createTaskDesc($data, $subsys_id);

		// process navigation buttons
    	$taskobj->sql_select = 'task_id_snr, task_id_jnr, mnu_nav_button.button_text';
    	$taskobj->sql_from   = 'mnu_task RIGHT JOIN mnu_nav_button ON (mnu_task.task_id=mnu_nav_button.task_id_jnr)';
    	$taskobj->sql_orderby = 'mnu_nav_button.button_text';
        $data = $taskobj->getData("subsys_id='$subsys_id'");
		$this->_createNavDesc($data, $subsys_id);

		// process field (column) names
    	$dictobj->sql_select = 'column_id, column_desc';
    	$dictobj->sql_from   = 'dict_column LEFT JOIN dict_database ON (dict_database.database_id=dict_column.database_id)';
    	$dictobj->sql_orderby = 'dict_column.column_id';
        $data = $dictobj->getData("subsys_id='$subsys_id'");
		$this->_createFieldDesc($data, $subsys_id);

		$this->text_out .= '// finished' ."\r\n";

        // write completed text file to disk
        $this->_writeTextFile ($this->text_out, $subsys_id, "$subsys_dir/text", 'txt');
        $this->text_out = '';

        // (2) create file '/help/<task_id>.help.txt'

        // process help text
    	$taskobj->sql_select = 'mnu_task.task_id, help_text';
    	$taskobj->sql_from   = 'mnu_task RIGHT JOIN help_text ON (mnu_task.task_id=help_text.task_id)';
    	$taskobj->sql_orderby = 'mnu_task.task_id';
        $data = $taskobj->getData("subsys_id='$subsys_id'");
		$this->_createHelpText($data, $subsys_dir);

		// (3) create file 'sql/<subsys>.menu_export.sql'

		// export details from menu database to an SQL file
		$this->_exportSQL($subsys_id, $subsys_dir);

        // do not display update count as there is none
        $this->no_display_count = TRUE;

		// return an empty array as there is no database update
        return array();

    } // _cm_pre_updateRecord

    // ****************************************************************************
    function _createFieldDesc ($field_array, $subsys_id)
    // put field (column) details into the output file.
    {
        // transfer details to an array to remove duplicate entries
        foreach ($field_array as $field) {
        	$array[$field['column_id']] = $field['column_id'];
        } // foreach

        //$indent  = str_pad('', 4);
        $indent  = '';
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// column details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($array as $key => $value) {
            $entry = $indent .'$array' ."['" .$key ."']";
            $entry = str_pad($entry, 50);
            $entry .= "= '" .addslashes($value) ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createFieldDesc

    // ****************************************************************************
    function _createHelpText ($help_array, $subsys_dir)
    // put each task's help text into a separate file.
    {
        $language_dir = $_SESSION['default_language'];

        foreach ($help_array as $help) {

            $sname = $subsys_dir .'/help/' .$language_dir .'/' .$help['task_id'] .'.help.txt';
            $fname = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$sname;
            if (!$fp = fopen($fname, 'w')) {
                $this->errors[] = getLanguageText('sys0076', $fname); // 'Cannot open file $fname'
            } else {
                if (fwrite($fp, $help['help_text']) === false) {
                    $this->errors[] = getLanguageText('sys0055', $fname); // 'Cannot write to file $fname'
                } // if
                fclose($fp);
            } // if
        } // foreach


    } // _createHelpText

    // ****************************************************************************
    function _createMenuDesc ($menu_array, $subsys_id)
    // put menu details into the output file.
    {
        //$indent  = str_pad('', 4);
        $indent  = '';
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// menu details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($menu_array as $menu) {
            $entry = $indent .'$array' ."['" .$menu['button_text'] ."']";
            $entry = str_pad($entry, 50);
            $entry .= "= '" .addslashes($menu['button_text']) ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createMenuDesc

    // ****************************************************************************
    function _createNavDesc ($nav_array, $subsys_id)
    // put navigation button details into the output file.
    {
        // transfer details to an array to remove duplicate entries
        foreach ($nav_array as $nav) {
        	$array[$nav['button_text']] = $nav['button_text'];
        } // foreach

        //$indent  = str_pad('', 4);
        $indent  = '';
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// navigation button details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($array as $key => $value) {
            $entry = $indent .'$array' ."['" .$key ."']";
            $entry = str_pad($entry, 50);
            $entry .= "= '" .addslashes($value) ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createNavDesc

    // ****************************************************************************
    function _createTaskDesc ($task_array, $subsys_id)
    // put task details into the output file.
    {
        //$indent  = str_pad('', 4);
        $indent  = '';
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// task details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($task_array as $task) {
            $entry = $indent .'$array' ."['" .$task['task_id'] ."']";
            $entry = str_pad($entry, 50);
            $entry .= "= '" .addslashes($task['task_desc']) ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createTaskDesc

    // ****************************************************************************
    function _exportSQL ($subsys_id, $subsys_dir)
    // export contents of MENU database for this subsystem.
    {
        $output = '-- file created on ' .date('F j, Y, g:i a') ."\r\n    \r\n";

        $taskobj =& singleton::getInstance('mnu_task');

        // export contents of MNU_SUBSYSTEM for this subsystem
    	$taskobj->sql_select = '*';
    	$taskobj->sql_from   = 'mnu_subsystem';
    	$taskobj->sql_orderby = 'subsys_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_subsystem', $data, $output);

        if ($subsys_id == 'MENU') {
            // export contents of MNU_language
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_language';
        	$taskobj->sql_orderby = 'language_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_language', $data, $output);

            // export contents of MNU_pattern
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_pattern';
        	$taskobj->sql_orderby = 'pattern_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_pattern', $data, $output);

            // export contents of MNU_ROLE
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_role';
        	$taskobj->sql_orderby = 'role_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_role', $data, $output);

            // export contents of MNU_ROLE for entries used by this subsystem
        	$taskobj->sql_select = 'DISTINCT role_id';
        	$taskobj->sql_from   = 'mnu_role_task '
        	                     . 'left join mnu_task ON (mnu_role_task.task_id=mnu_task.task_id)';
        	$taskobj->sql_orderby = 'role_id';
            $data = $taskobj->getData_raw("mnu_task.subsys_id='$subsys_id'");

            if (count($data) > 0) {
                // extract details of all roles which are actually used
                $range = null;
                foreach ($data as $row) {
                	if (empty($range)) {
                		$range = "'" .$row['role_id'] ."'";
                	} else {
                	    $range .= ",'" .$row['role_id'] ."'";
                	} // if
                } // foreach
            	$taskobj->sql_select = '*';
            	$taskobj->sql_from   = 'mnu_role';
            	$taskobj->sql_orderby = 'role_id';
                $data = $taskobj->getData_raw("role_id IN ($range)");
                $output = $this->_exportSqlData('mnu_role', $data, $output);
            } // if
        } // if

        // export contents of MNU_TASK for this subsystem (where type = 'PROC')
    	$taskobj->sql_select = '*';
    	$taskobj->sql_from   = '';
    	$taskobj->sql_orderby = 'task_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id' AND task_type='PROC'");
        foreach ($data as $task_data) {
        	$output = $this->_exportSqlData('mnu_task', $task_data, $output);
        	$task_id = $task_data['task_id'];

        	// export the contents of MNU_NAV_BUTTON for this task (2 passes)
        	$taskobj->sql_select = 'mnu_nav_button.*';
        	$taskobj->sql_from   = 'mnu_nav_button';
        	$taskobj->sql_orderby = 'sort_seq';
            $data2 = $taskobj->getData_raw("task_id_snr='$task_id'");  // 1st pass
            $output = $this->_exportSqlData('mnu_nav_button', $data2, $output);

            $data2 = $taskobj->getData_raw("task_id_jnr='$task_id'");  // 2nd pass
            $output = $this->_exportSqlData('mnu_nav_button', $data2, $output);

            // export the contents of MNU_TASK_FIELD for this task
        	$taskobj->sql_select = 'mnu_task_field.*';
        	$taskobj->sql_from   = 'mnu_task_field';
        	$taskobj->sql_orderby = 'field_id';
            $data2 = $taskobj->getData_raw("task_id='$task_id'");
            $output = $this->_exportSqlData('mnu_task_field', $data2, $output);

            // export the contents of MNU_ROLE_TASK for this task
        	$taskobj->sql_select = 'mnu_role_task.*';
        	$taskobj->sql_from   = 'mnu_role_task';
        	$taskobj->sql_orderby = 'role_id';
            $data2 = $taskobj->getData_raw("task_id='$task_id'");
            $output = $this->_exportSqlData('mnu_role_task', $data2, $output);

            // export the contents of MNU_ROLE_TASKFIELD for this task
        	$taskobj->sql_select = 'mnu_role_taskfield.*';
        	$taskobj->sql_from   = 'mnu_role_taskfield';
        	$taskobj->sql_orderby = 'field_id,role_id';
            $data2 = $taskobj->getData_raw("task_id='$task_id'");
            $output = $this->_exportSqlData('mnu_role_taskfield', $data2, $output);

            // export the contents of MNU_INITIAL_VALUE_ROLE for this task
        	$taskobj->sql_select = 'mnu_initial_value_role.*';
        	$taskobj->sql_from   = 'mnu_initial_value_role';
        	$taskobj->sql_orderby = 'field_id,role_id';
            $data2 = $taskobj->getData_raw("task_id='$task_id'");
            $output = $this->_exportSqlData('mnu_initial_value_role', $data2, $output);

            // export the contents of MNU_TASK_IP_ADDRESS for this task
        	$taskobj->sql_select = 'mnu_task_ip_address.*';
        	$taskobj->sql_from   = 'mnu_task_ip_address';
        	$taskobj->sql_orderby = 'task_id,ip_address';
            $data2 = $taskobj->getData_raw("task_id='$task_id'");
            $output = $this->_exportSqlData('mnu_task_ip_address', $data2, $output);

        } // foreach

        // export contents of MNU_TASK for this subsystem (where type = 'MENU')
    	$taskobj->sql_select = '*';
    	$taskobj->sql_from   = '';
    	$taskobj->sql_orderby = 'task_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id' AND task_type='MENU'");
        $output = $this->_exportSqlData('mnu_task', $data, $output);

        // export the contents of MNU_MENU for this subsystem (1st pass)
        // (where subsys_id of menu_id and task_id_jnr is the same as current subsys_id)
    	$taskobj->sql_select = 'mnu_menu.*';
    	$taskobj->sql_from   = 'mnu_menu '
    	                      .'LEFT JOIN mnu_task AS SNR ON (menu_id=SNR.task_id) '
    	                      .'LEFT JOIN mnu_task AS JNR ON (task_id_jnr=JNR.task_id) ';
    	$taskobj->sql_orderby = 'menu_id, sort_seq';
        $data = $taskobj->getData_raw("SNR.subsys_id='$subsys_id' AND JNR.subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_menu', $data, $output);

        // export the contents of MNU_MENU for this subsystem (2nd pass)
        // (where subsys_id of menu_id is not the same as current subsys_id)
    	$taskobj->sql_select = 'mnu_menu.*';
    	$taskobj->sql_from   = 'mnu_menu '
    	                      .'LEFT JOIN mnu_task AS SNR ON (menu_id=SNR.task_id) '
    	                      .'LEFT JOIN mnu_task AS JNR ON (task_id_jnr=JNR.task_id) ';
    	$taskobj->sql_orderby = 'menu_id, sort_seq';
        $data = $taskobj->getData_raw("SNR.subsys_id != '$subsys_id' AND JNR.subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_menu', $data, $output);

        // export the contents of HELP_TEXT for this subsystem
    	$taskobj->sql_select = 'help_text.*';
    	$taskobj->sql_from   = 'help_text LEFT JOIN mnu_task ON (mnu_task.task_id=help_text.task_id)';
    	$taskobj->sql_orderby = 'help_text.task_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('help_text', $data, $output);

        if ($subsys_id == 'MENU') {
			// export contents of MNU_CONTROL where record_id='SYSTEM'
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_control';
        	$taskobj->sql_orderby = 'record_id, field_id';
            $data = $taskobj->getData_raw("record_id='SYSTEM'");
            $output = $this->_exportSqlData('mnu_control', $data, $output);

            // export contents of MNU_ACCOUNT
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_account';
        	$taskobj->sql_orderby = 'rdcaccount_id';
            $data = $taskobj->getData_raw();
            $output = $this->_exportSqlData('mnu_account', $data, $output);

            // export contents of MNU_MOTD
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_motd';
        	$taskobj->sql_orderby = 'motd_id';
            $data = $taskobj->getData_raw();
            $output = $this->_exportSqlData('mnu_motd', $data, $output);

            unset($taskobj);
            $userobj =& singleton::getInstance('mnu_user');
            $userobj->sql_select = '*';
        	$userobj->sql_from   = '';
        	$userobj->sql_orderby = 'task_id';
            $data = $userobj->getData_raw();
            foreach ($data as $user_data) {
            	$output = $this->_exportSqlData('mnu_user', $user_data, $output);
            	$user_id = $user_data['user_id'];

            	// export the contents of MNU_INITIAL_VALUE_USER for this task
            	$userobj->sql_select = 'mnu_initial_value_user.*';
            	$userobj->sql_from   = 'mnu_initial_value_user';
            	$userobj->sql_orderby = 'field_id,user_id';
                $data2 = $userobj->getData_raw("task_id='$task_id'");
                $output = $this->_exportSqlData('mnu_initial_value_user', $data2, $output);

            	// export contents of MNU_TODO for this user
            	$userobj->sql_select = '*';
            	$userobj->sql_from   = 'mnu_todo';
            	$userobj->sql_orderby = 'user_id, seq_no';
                $data2 = $userobj->getData_raw("user_id='$user_id'");
                $output = $this->_exportSqlData('mnu_todo', $data2, $output);

                // export the contents of MNU_USER_IP_ADDRESS for this use
            	$userobj->sql_select = 'mnu_task_ip_address.*';
            	$userobj->sql_from   = 'mnu_task_ip_address';
            	$userobj->sql_orderby = 'task_id,ip_address';
                $data2 = $userobj->getData_raw("task_id='$task_id'");
                $output = $this->_exportSqlData('mnu_task_ip_address', $data2, $output);

            } // foreach

        } else {
            // export contents of MNU_CONTROL where record_id='<subsystem>'
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_control';
        	$taskobj->sql_orderby = 'record_id, field_id';
            $data = $taskobj->getData_raw("record_id='" .strtoupper($subsys_id) ."'");
            $output = $this->_exportSqlData('mnu_control', $data, $output);
        } // if

        $output .= "-- finished\r\n";

        // write completed text file to disk
        $this->_writeTextFile ($output, $subsys_id, "$subsys_dir/sql", 'sql');

        return;

    } // _exportSQL

    // ****************************************************************************
    function _exportSqlData ($table_id, $data, $output)
    // output the contents of the $data array to the $output string for $table_id
    {
        if (empty($data)) return $output;

        $key = key($data);
        if (!is_array($data[$key])) {
            // array is not indexed by row, so set it to row zero
            $new_array[] = $data;
            $data = $new_array;
        } // if

        // get field names from first row
        $replace_string .= 'REPLACE INTO `' .$table_id .'` (';
        foreach ($data[0] as $fieldname => $fieldvalue) {
        	$replace_string .= "`$fieldname`, ";
        } // foreach
        $replace_string = substr_replace($replace_string, null, -2); // drop trailing comma separator
        $replace_string .= ') VALUES ';

        // output values from each row
        foreach ($data as $row => $rowdata) {
            $value_string = '';
            foreach ($rowdata as $fieldname => $fieldvalue) {
                if (strlen($fieldvalue) == 0) {
                	$value_string .= "NULL, ";
                } else {
                    $value_string .= "'" .addslashes($fieldvalue) ."', ";
                } // if
            } // foreach
            $value_string = substr_replace($value_string, null, -2); // drop trailing comma separator
            $output .= $replace_string .'(' .$value_string .');' ."\r\n";
        } // foreach

        $output .= "\r\n";

        return $output;

    } // _exportSqlData

    // ****************************************************************************
    function _writeTextFile ($text, $subsys_id, $subsys_dir, $type)
    // write the contents of $text to a disk file.
    {
        $sname = $subsys_dir .'/' .strtolower($subsys_id) .'.menu_export.' .$type;
        $fname = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$sname;
        if (!$fp = fopen($fname, 'w')) {
            $this->errors[] = getLanguageText('sys0076', $fname); // 'Cannot open file $fname'
        } else {
            if (fwrite($fp, $text) === false) {
                $this->errors[] = getLanguageText('sys0055', $fname); // 'Cannot write to file $fname'
            } // if
            fclose($fp);
            $this->messages[] = getLanguageText('sys0093', $fname); // 'Data exported to $fname'
        } // if

        return;

    } // _writeTextFile

// ****************************************************************************
} // end class
// ****************************************************************************

?>
