<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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
        //DebugBreak();
		// create object for retrieving task details
        require_once 'mnu_task.class.inc';
        $taskobj =& singleton::getInstance('mnu_task');

        // process each subsystem separately
        foreach ($rowdata as $row => $tabledata) {

			$subsys_id   = $tabledata['subsys_id'];
            $subsys_dir  = $tabledata['subsys_dir'];

			$this->text_out = '    // file created on ' .date('F j, Y, g:i a') ."\r\n    \r\n";

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
            $data = $taskobj->getData("subsys_id='$subsys_id' AND task_type='proc'");
			$this->_createTaskDesc($data, $subsys_id);

			// process navigation buttons
        	$taskobj->sql_select = 'task_id_snr, task_id_jnr, mnu_nav_button.button_text';
        	$taskobj->sql_from   = 'mnu_task RIGHT JOIN mnu_nav_button ON (mnu_task.task_id=mnu_nav_button.task_id_jnr)';
        	$taskobj->sql_orderby = 'mnu_nav_button.button_text';
            $data = $taskobj->getData("subsys_id='$subsys_id'");
			$this->_createNavDesc($data, $subsys_id);

			$this->text_out .= '    // finished' ."\r\n";

            // write completed text file to disk
            $this->_writeTextFile ($this->text_out, $subsys_id, "$subsys_dir/text", 'txt');
            $this->text_out = '';

            // process help text
        	$taskobj->sql_select = 'mnu_task.task_id, help_text';
        	$taskobj->sql_from   = 'mnu_task RIGHT JOIN help_text ON (mnu_task.task_id=help_text.task_id)';
        	$taskobj->sql_orderby = 'mnu_task.task_id';
            $data = $taskobj->getData("subsys_id='$subsys_id'");
			$this->_createHelpText($data, $subsys_dir);

			// export details from menu database to an SQL file
			$this->_exportSQL($subsys_id, $subsys_dir);

        } // foreach

		// return an empty array as there is no database update
        return array();

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
		global $dbprefix;

		$this->checkPrimaryKey = true;  // check for primary key in selection

        if (empty($this->sql_select)) {
            // obtain SUBSYS_DIR
            $this->sql_select = 'subsys_id, subsys_dir';
            $this->sql_from   = 'mnu_subsystem';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _createHelpText ($help_array, $subsys_dir)
    // put each task's help text into a separate file.
    {
        //DebugBreak();
        require_once 'classes/mnu_control.class.inc';
        $mnu_control =& singleton::getInstance('mnu_control');
        $language_dir = $mnu_control->getControlData('default_language');

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
        //DebugBreak();
        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// menu details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($menu_array as $menu) {
            $entry = $indent .'$array' ."['" .$menu['button_text'] ."']";
            $entry = str_pad($entry, 44);
            $entry .= "= '" .$menu['button_text'] ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createMenuDesc

    // ****************************************************************************
    function _createNavDesc ($nav_array, $subsys_id)
    // put navigation button details into the output file.
    {
        //DebugBreak();
        // transfer details to an array to remove duplicate entries
        foreach ($nav_array as $nav) {
        	$array[$nav['button_text']] = $nav['button_text'];
        } // foreach

        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// navigation button details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($array as $key => $value) {
            $entry = $indent .'$array' ."['" .$key ."']";
            $entry = str_pad($entry, 44);
            $entry .= "= '" .$value ."';\r\n";

            $this->text_out .= $entry;
        } // foreach

		$this->text_out .= $indent ."\r\n";

    } // _createNavDesc

    // ****************************************************************************
    function _createTaskDesc ($task_array, $subsys_id)
    // put task details into the output file.
    {
        //DebugBreak();
        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// task details for subsystem ' .$subsys_id ."\r\n";

	    foreach ($task_array as $task) {
            $entry = $indent .'$array' ."['" .$task['task_id'] ."']";
            $entry = str_pad($entry, 44);
            $entry .= "= '" .$task['task_desc'] ."';\r\n";

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

        if ($subsys_id == 'MENU') {
			// export contents of MNU_CONTROL
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_control';
        	$taskobj->sql_orderby = 'record_id, field_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_control', $data, $output);

            // export contents of MNU_DIALOG_TYPE
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_dialog_type';
        	$taskobj->sql_orderby = 'dialog_type_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_dialog_type', $data, $output);

            // export contents of MNU_ROLE
        	$taskobj->sql_select = '*';
        	$taskobj->sql_from   = 'mnu_role';
        	$taskobj->sql_orderby = 'role_id';
            $data = $taskobj->getData_raw(null);
            $output = $this->_exportSqlData('mnu_role', $data, $output);
		} // if

        // export contents of MNU_SUBSYSTEM for this subsystem
    	$taskobj->sql_select = '*';
    	$taskobj->sql_from   = 'mnu_subsystem';
    	$taskobj->sql_orderby = 'subsys_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_subsystem', $data, $output);

        // export contents of MNU_TASK for this subsystem (where type = 'PROC')
    	$taskobj->sql_select = '*';
    	$taskobj->sql_from   = '';
    	$taskobj->sql_orderby = 'task_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id' AND task_type='PROC'");
        foreach ($data as $task_data) {
        	$output = $this->_exportSqlData('mnu_task', $task_data, $output);
        	$task_id = $task_data['task_id'];

        	// export the contents of MNU_NAV_BUTTON for this task
        	$taskobj->sql_select = 'mnu_nav_button.*';
        	$taskobj->sql_from   = 'mnu_nav_button';
        	$taskobj->sql_orderby = 'sort_seq';
            $data2 = $taskobj->getData_raw("task_id_snr='$task_id'");
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
    	                      .'LEFT JOIN mnu_task AS SNR on (menu_id=SNR.task_id) '
    	                      .'LEFT JOIN mnu_task AS JNR on (task_id_jnr=JNR.task_id) ';
    	$taskobj->sql_orderby = 'menu_id, sort_seq';
        $data = $taskobj->getData_raw("SNR.subsys_id='$subsys_id' AND JNR.subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_menu', $data, $output);

        // export the contents of MNU_MENU for this subsystem (2nd pass)
        // (where subsys_id of menu_id is not the same as current subsys_id)
    	$taskobj->sql_select = 'mnu_menu.*';
    	$taskobj->sql_from   = 'mnu_menu '
    	                      .'LEFT JOIN mnu_task AS SNR on (menu_id=SNR.task_id) '
    	                      .'LEFT JOIN mnu_task AS JNR on (task_id_jnr=JNR.task_id) ';
    	$taskobj->sql_orderby = 'menu_id, sort_seq';
        $data = $taskobj->getData_raw("SNR.subsys_id != '$subsys_id' AND JNR.subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('mnu_menu', $data, $output);

        // export the contents of HELP_TEXT for this subsystem
    	$taskobj->sql_select = 'help_text.*';
    	$taskobj->sql_from   = 'help_text LEFT JOIN mnu_task using (task_id)';
    	$taskobj->sql_orderby = 'help_text.task_id';
        $data = $taskobj->getData_raw("subsys_id='$subsys_id'");
        $output = $this->_exportSqlData('help_text', $data, $output);

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
        $output .= 'REPLACE INTO `' .$table_id .'` (';
        foreach ($data[0] as $fieldname => $fieldvalue) {
        	$output .= "`$fieldname`, ";
        } // foreach
        $output = substr_replace($output, null, -2); // drop trailing comma separator
        $output .= ') VALUES ' ."\r\n";

        // output values from each row
        foreach ($data as $row => $rowdata) {
            $output .= '(';
            foreach ($rowdata as $fieldname => $fieldvalue) {
                if (strlen($fieldvalue) == 0) {
                	$output .= "NULL, ";
                } else {
                    $output .= "'" .addslashes($fieldvalue) ."', ";
                } // if
            } // foreach
            $output = substr_replace($output, null, -2); // drop trailing comma separator
            $output .= '),' ."\r\n";
        } // foreach
        $output = substr_replace($output, ';', -3); // replace trailing comma with semicolon

        $output .= "\r\n\r\n";

        return $output;

    } // _exportSqlData

    // ****************************************************************************
    function _writeTextFile ($text, $subsys_id, $subsys_dir, $type)
    // write the contents of $text to a disk file.
    {
        //DebugBreak();
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
