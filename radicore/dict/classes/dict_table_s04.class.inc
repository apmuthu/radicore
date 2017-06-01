<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_table.class.inc';
class dict_table_s04 extends dict_table
{
    // ****************************************************************************
    // this class is used by script: table_generate_b.php
    // ****************************************************************************

    var $pattern_id;        //
    var $prefix;            //
    var $report_file_short; //
    var $report_file_long;  //
    var $screen_file_short; //
    var $screen_file_long;  //
    var $subsys_dir;        //
    var $subsys_id;         //
    var $task_array;        // entries to be added to MNU_TASK table
    var $nav_array;         // entries to be added to MNU_NAV_BUTTON table
    var $menu_array;        // entries to be added to MNU_MENU table

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $this->fieldspec['pattern_id']      = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'pattern_id',
                                                    'noedit' => 'y');

        if (empty($this->pattern_id)) {
        	// remove PATTERN_ID from $where
            $this->pattern_id = strtolower(stripOperators($fieldarray['pattern_id']));
            unset($fieldarray['pattern_id']);
        } // if

        $this->fieldspec['task_id']         = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');

        $this->fieldspec['script_id']       = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');

        $this->fieldspec['screen_file']     = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'lowercase' => 'y');

        $this->fieldspec['report_file']     = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'lowercase' => 'y');

        if (!isset($this->fieldspec['tablename'])) {
            $this->fieldspec['tablename']   = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'table_id');
        } // if

        if (!isset($this->fieldspec['table_alias'])) {
            $this->fieldspec['table_alias'] = array('type' => 'string',
                                                    'size' => 40,
                                                    'lowercase' => 'y');
        } // if

        if (!isset($this->fieldspec['outer_table'])) {
            $this->fieldspec['outer_table']         = array('type' => 'string',
                                                            'size' => 80,
                                                            'required' => 'y',
                                                            'control' => 'dropdown',
                                                            'optionlist' => 'table_id_outer');
            $this->fieldspec['outer_table_alias']   = array('type' => 'string',
                                                            'size' => 40,
                                                            'lowercase' => 'y');
            $this->fieldspec['database_id_outer']   = array('type' => 'string',
                                                            'size' => 80,
                                                            'required' => 'y',
                                                            'control' => 'popup',
                                                            'task_id' => 'dict_database(popup1)outer',
                                                            'foreign_field' => 'database_id_outer');
            $this->parent_relations[]               = array('parent' => 'dict_database',
                                                            'parent_field' => 'database_name AS outer_database_name',
                                                            'fields' => array('database_id_outer' => 'database_id'));

        } // if

        if (!isset($this->fieldspec['link_table'])) {
            $this->fieldspec['link_table']      = array('type' => 'string',
                                                        'size' => 80,
                                                        'required' => 'y',
                                                        'control' => 'dropdown',
                                                        'optionlist' => 'table_id');
        } // if

        if (!isset($this->fieldspec['middle_table'])) {
            $this->fieldspec['middle_table']        = array('type' => 'string',
                                                            'size' => 80,
                                                            'required' => 'y',
                                                            'control' => 'dropdown',
                                                            'optionlist' => 'table_id_middle');
            $this->fieldspec['middle_table_alias']  = array('type' => 'string',
                                                            'size' => 40,
                                                            'lowercase' => 'y');
            $this->fieldspec['database_id_middle']  = array('type' => 'string',
                                                            'size' => 80,
                                                            'required' => 'y',
                                                            'control' => 'popup',
                                                            'task_id' => 'dict_database(popup1)middle',
                                                            'foreign_field' => 'database_id_middle');
            $this->parent_relations[]               = array('parent' => 'dict_database',
                                                            'parent_field' => 'database_name AS middle_database_name',
                                                            'fields' => array('database_id_middle' => 'database_id'));
        } // if

        if (!isset($this->fieldspec['inner_table'])) {
            $this->fieldspec['inner_table']     = array('type' => 'string',
                                                        'size' => 80,
                                                        'required' => 'y',
                                                        'control' => 'dropdown',
                                                        'optionlist' => 'table_id_inner');
            $this->fieldspec['inner_table_alias']   = array('type' => 'string',
                                                            'size' => 40,
                                                            'lowercase' => 'y');
            $this->fieldspec['database_id_inner']   = array('type' => 'string',
                                                            'size' => 80,
                                                            'required' => 'y',
                                                            'control' => 'popup',
                                                            'task_id' => 'dict_database(popup1)inner',
                                                            'foreign_field' => 'database_id_inner');
            $this->parent_relations[]               = array('parent' => 'dict_database',
                                                            'parent_field' => 'database_name AS inner_database_name',
                                                            'fields' => array('database_id_inner' => 'database_id'));
        } // if

        if (!isset($this->fieldspec['popup_task_id'])) {
            $this->fieldspec['popup_task_id']   = array('type' => 'string',
                                                        'size' => 40,
                                                        'control' => 'popup',
                                                        'task_id' => 'mnu_task(popup1)',
                                                        'foreign_field' => 'task_name');
            $this->parent_relations[]           = array('parent' => 'mnu_task',
                                                        'dbname' => 'menu',
                                                        'subsys_dir' => 'menu',
                                                        'parent_field' => 'task_name',
                                                        'fields' => array('popup_task_id' => 'task_id'));
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('pattern_id', $this->lookup_data)) {
            // get contents of foreign table and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('mnu_pattern');
            $array    = $dbobject->getValRep('pattern_id');
            $this->lookup_data['pattern_id'] = $array;
        } // if

        if (isset($fieldarray['database_id'])) {
            $database_id = $fieldarray['database_id'];
        	// get list of tables from current database
            $dbobject =& RDCsingleton::getInstance('dict_table');
            $array1    = $dbobject->getValRep('table_id', "database_id='$database_id'");

            // get alias names from any relationships
            $dbobject =& RDCsingleton::getInstance('dict_relationship');
            $array2   = $dbobject->getValRep('table_alias_snr', "database_id_snr='$database_id'");
            $array3   = $dbobject->getValRep('table_alias_jnr', "database_id_jnr='$database_id'");

            // merge the three arrays into one
            $this->lookup_data['table_id'] = array_merge($array1, $array2, $array3);
            ksort($this->lookup_data['table_id']);
        } // if

        if (isset($fieldarray['database_id_outer'])) {
            $database_id = $fieldarray['database_id_outer'];
        	// get list of tables from current database
            $dbobject =& RDCsingleton::getInstance('dict_table');
            $array1    = $dbobject->getValRep('table_id', "database_id='$database_id'");

            // get alias names from any relationships
            $dbobject =& RDCsingleton::getInstance('dict_relationship');
            $array2   = $dbobject->getValRep('table_alias_snr', "database_id_snr='$database_id'");
            $array3   = $dbobject->getValRep('table_alias_jnr', "database_id_jnr='$database_id'");

            // merge the three arrays into one
            $this->lookup_data['table_id_outer'] = array_merge($array1, $array2, $array3);
            ksort($this->lookup_data['table_id_outer']);
        } // if

        if (isset($fieldarray['database_id_middle'])) {
            $database_id = $fieldarray['database_id_middle'];
            // get list of tables from current database
            $dbobject =& RDCsingleton::getInstance('dict_table');
            $array1    = $dbobject->getValRep('table_id', "database_id='$database_id'");

            // get alias names from any relationships
            $dbobject =& RDCsingleton::getInstance('dict_relationship');
            $array2   = $dbobject->getValRep('table_alias_snr', "database_id_snr='$database_id'");
            $array3   = $dbobject->getValRep('table_alias_jnr', "database_id_jnr='$database_id'");

            // merge the three arrays into one
            $this->lookup_data['table_id_middle'] = array_merge($array1, $array2, $array3);
            ksort($this->lookup_data['table_id_middle']);
        } // if

        if (isset($fieldarray['database_id_inner']) AND $fieldarray['pattern_id'] == 'link1') {
            $database_id = $fieldarray['database_id_inner'];
            // get list of tables from inner database
            $dbobject =& RDCsingleton::getInstance('dict_table');
            $array1    = $dbobject->getValRep('table_id', "database_id='$database_id'");

            // get alias names from any relationships
            $dbobject =& RDCsingleton::getInstance('dict_relationship');
            $array2   = $dbobject->getValRep('table_alias_snr', "database_id_snr='$database_id'");
            $array3   = $dbobject->getValRep('table_alias_jnr', "database_id_jnr='$database_id'");

            // merge the three arrays into one
            $this->lookup_data['table_id_inner'] = array_merge($array1, $array2, $array3);
            ksort($this->lookup_data['table_id_inner']);
        } // if

		return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        // reduce multiple selections to a single selection
        $rows = splitWhereByRow($where);
        $where = $rows[0];

        // remove message created by table_generate_a.php
        $GLOBALS['messages'] = array();

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        $where = '';

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        // allow a single result to be selected without user intervention
        //$settings['choose_single_row'] = true;

        //if ($popupname == 'foo(bar)') {
        //    // replace $where for this popup
        //    $where = "$where";
        //} else {
        //    $where = '';
        //} // if

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array, $return_files)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {

//        if ($return_from == 'mnu_task(popup1)') {
//           // change field name from 'task_id' to 'popup_task_id'
//           $select_array['popup_task_id'] = $select_array['task_id'];
//           unset($select_array['task_id']);
//        } // if
//
//        if ($return_from == 'dict_database(popup1)') {
//           // change field name from 'database_id' to 'database_id_outer'
//           $select_array['database_id_outer'] = $select_array['database_id'];
//           unset($select_array['database_id']);
//        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // deal with first row only
        $fieldarray = $rows[0];

        // put back pattern_id which was saved earlier
        $fieldarray['pattern_id'] = $this->pattern_id;

        // compile list of possible child forms
        switch ($this->pattern_id) {
            case 'list1':
        		$fieldarray['child_forms'] = getLanguageText('t0001');  // 'Add1, Delete1, Enquire1, Search, Update1, Audit';
        		break;

        	case 'list2':
        	    // create array of options
                $array[1] = getLanguageText('t0002');  // 'Add2, Delete1, Enquire1, Search, Update1, Audit';
                $array[2] = getLanguageText('t0003');  // 'Add3, Popup, Delete2, Search';
                $array[3] = getLanguageText('t0009');  // 'Update2, Popup, Delete3, Search';
                $this->lookup_data['child_forms'] = $array;
                // use radio buttons so that the user can make a choice
                $this->fieldspec['child_forms']     = array('type' => 'numeric',
                                                            'size' => 2,
                                                            'required' => 'y',
                                                            'control' => 'radiogroup',
                                                            'optionlist' => 'child_forms',
                                                            'align_hv' => 'vertical');
            	$fieldarray['child_forms'] = '1';      // set default selection
            	$fieldarray['popup_task_id'] = '';     // ensure this field is displayed
            	$fieldarray['inner_table_alias'] = ''; // ensure this field is displayed
            	$fieldarray['database_id_outer'] = $fieldarray['database_id'];
        	    break;

        	case 'list3':
        	    $fieldarray['child_forms'] = getLanguageText('t0004');  // 'Add2, Delete1, Enqire1, Search, Update1';
                $fieldarray['database_id_outer'] = $fieldarray['database_id'];
                $fieldarray['database_id_middle'] = $fieldarray['database_id'];
                $fieldarray['outer_table_alias'] = ''; // ensure this field is displayed
                $fieldarray['middle_table_alias'] = ''; // ensure this field is displayed
                $fieldarray['inner_table_alias'] = ''; // ensure this field is displayed
        	    break;

        	case 'link1':
        	    $fieldarray['child_forms'] = getLanguageText('t0005');  // 'Search';
        	    $fieldarray['database_id_outer'] = $fieldarray['database_id'];
                $fieldarray['database_id_inner'] = $fieldarray['database_id'];
        	    break;

        	case 'multi2':
        	    // create array of options
                $array[1] = getLanguageText('t0011');  // 'Add2, Delete1';
                $array[2] = getLanguageText('t0012');  // 'Add3, Popup, Delete2';
                $this->lookup_data['child_forms'] = $array;
                // use radio buttons so that the user can make a choice
                $this->fieldspec['child_forms']     = array('type' => 'numeric',
                                                            'size' => 2,
                                                            'required' => 'y',
                                                            'control' => 'radiogroup',
                                                            'optionlist' => 'child_forms',
                                                            'align_hv' => 'vertical');
            	$fieldarray['child_forms'] = '1';        // set default selection
            	$fieldarray['inner_table_alias'] = '';   // ensure this field is displayed
        	    $fieldarray['popup_task_id'] = '';       // ensure this field is displayed
        	    $fieldarray['database_id_outer'] = $fieldarray['database_id'];
            	break;

        	case 'multi3':
        	    $fieldarray['child_forms'] = getLanguageText('t0002');  // 'Add2, Delete1, Enquire1, Search, Update1, Audit';
        	    $fieldarray['inner_table_alias'] = '';   // ensure this field is displayed
        	    $fieldarray['database_id_outer'] = $fieldarray['database_id'];
            	break;

        	case 'add5':
            case 'del4':
        	case 'multi4':
                $fieldarray['inner_table_alias'] = '';   // ensure this field is displayed
        	    $fieldarray['database_id_outer'] = $fieldarray['database_id'];
            	break;

        	case 'multi5':
                $fieldarray['outer_table_alias'] = '';   // ensure this field is displayed
                $fieldarray['inner_table_alias'] = '';   // ensure this field is displayed
                $fieldarray['database_id_outer'] = $fieldarray['database_id'];
                break;

            case 'multi6':
                $fieldarray['outer_table_alias']  = '';   // ensure this field is displayed
                $fieldarray['middle_table_alias'] = '';   // ensure this field is displayed
                $fieldarray['inner_table_alias']  = '';   // ensure this field is displayed
                $fieldarray['database_id_outer']  = $fieldarray['database_id'];
                $fieldarray['database_id_middle'] = $fieldarray['database_id'];
                break;

            case 'popup2':
        	case 'popup4':
        	case 'tree2':
        	    $fieldarray['inner_table_alias'] = ''; // ensure this field is displayed
        	    $fieldarray['database_id_outer'] = $fieldarray['database_id'];
        	    break;

        	case 'output5':
        	    $fieldarray['table_alias'] = $fieldarray['table_id'].'_s01';  // set to default value
        	    break;

        	default:
        		break;
        } // switch

        // save these for later
        $this->subsys_dir = strtolower($fieldarray['subsys_dir']);
        $this->subsys_id  = strtolower($fieldarray['subsys_id']);
        $this->prefix     = strtolower($fieldarray['task_prefix']);

        $table_id  = $fieldarray['table_id'];

        if ($count = preg_match('/^' .$this->prefix .'/', $table_id)) {
            // $table_id already starts with $prefix, so do not duplicate it
        	$this->prefix = '';
        } // if

        // insert suggested TASK_ID and SCRIPT_ID
        $fieldarray['task_id']   = $this->prefix .$table_id .'(' .$this->pattern_id .')';
        $fieldarray['script_id'] = $table_id .'(' .$this->pattern_id .').php';

        // load in associated script from DEFAULT directory
        $filename = '../default/' .$this->pattern_id .'.php';
        if (!$handle = fopen($filename, "r")) {
            $this->errors[] = getLanguageText('sys0076', $filename);  // cannot open file
        	return;
        } // if
        $contents = fread($handle, filesize($filename));
        fclose($handle);

        // look for all text beginning with '#' and ending in single quote or '#'
        $count = preg_match_all("/#.+'|#.+#/", $contents, $regs);

        foreach ($regs[0] as $match) {
        	// remove trailing quote
        	$match = trim($match, "'");
        	if (substr($match, -1, 1) == '#') {
        	    // there is nothing after 2nd '#', so this is a table name
        		$tablename = trim($match, '#');
        		switch ($fieldarray['pattern_id']) {
        		    case 'add5':
        		    case 'del4':
        			case 'list2':
        			case 'list3':
        			case 'multi2':
        			case 'multi3':
        			case 'multi4':
                    case 'multi5':
                    case 'multi6':
        			case 'popup2':
        			case 'popup4':
        			case 'timetable1':
        			case 'tree2':
        				if ($tablename == 'inner_table') {
                			$fieldarray[$tablename] = $table_id;
                			$this->fieldspec['inner_table']['noedit'] = 'y';
                		} else {
                		    $fieldarray[$tablename] = '';
                		} // if
        				break;

        			case 'link1':
        				if ($tablename == 'link_table') {
                			$fieldarray[$tablename] = $table_id;
                			$this->fieldspec['link_table']['noedit'] = 'y';
                		} else {
                		    $fieldarray[$tablename] = '';
                		} // if
        				break;

        			default:
        			    if ($tablename == 'tablename') {
                			$fieldarray[$tablename] = $table_id;
                			$this->fieldspec['tablename']['noedit'] = 'y';
                		} else {
                		    $fieldarray[$tablename] = '';
                		} // if
        				break;
        		} // switch
        	} else {
        	    // look for word that comes before '.inc' (could be 'screen' or 'report')
        	    preg_match("/\w+(?=\.inc)/i", $match, $regs);
        	    if ($regs[0] == 'screen') {
        	    	$fieldarray['screen_file'] = $match;
                    $this->screen_file_long    = $match;
        	    } elseif ($regs[0] == 'report') {
        	        $fieldarray['report_file'] = $match;
                    $this->report_file_long    = $match;
        	    } // if
        	} // if
        } // foreach

        if (!empty($this->screen_file_long)) {
            // find word which is enclosed in a pair of '#' characters
        	preg_match("/(?<=#)\w+/", $this->screen_file_long, $regs);
        	// replace it with selected table_id
        	$fieldarray['screen_file'] = str_replace("#$regs[0]#", $table_id, $fieldarray['screen_file']);
        	// store version without without this prefix
        	$this->screen_file_short = str_replace("#$regs[0]#.", '', $this->screen_file_long);
        } elseif (!empty($this->report_file_long)) {
            // find word which is enclosed in a pair of '#' characters
        	preg_match("/(?<=#)\w+/", $this->report_file_long, $regs);
        	// replace it with selected table_id
        	$fieldarray['report_file'] = str_replace("#$regs[0]#", $table_id, $fieldarray['report_file']);
        	// store version without without this prefix
        	$this->report_file_short = str_replace("#$regs[0]#.", '', $this->report_file_long);
        } // if

        // replace first row
        $rows[0] = $fieldarray;

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        if (empty($this->errors)) {
        	$this->messages[] = getLanguageText('e0042');  // 'Script has been generated';
        } // if

        return $rowdata;

    } // _cm_post_updateRecord

    // ***************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // find out if tables in the 'menu' database need to be qualified
        $menuDB = findDBName('menu', $this->dbname);

        if (empty($this->sql_from)) {
        	$this->sql_select = 'dict_table.database_id, dict_table.table_id, dict_table.table_name, dict_database.subsys_id, mnu_subsystem.subsys_dir, mnu_subsystem.task_prefix, mnu_pattern.pattern_desc';
        	$this->sql_from   = 'dict_table '
        	                  . 'LEFT JOIN dict_database ON (dict_database.database_id=dict_table.database_id) '
        	                  . "LEFT JOIN {$menuDB}mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) "
        	                  . "LEFT JOIN {$menuDB}mnu_pattern ON (mnu_pattern.pattern_id='{$this->pattern_id}') ";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        if ($fieldarray['pattern_id'] == 'list2') {
            if ($fieldarray['child_forms'] == 1) {
                unset($this->fieldspec['popup_task_id']['required']);
                $fieldarray['popup_task_id'] = '';
            } else {
            	$this->fieldspec['popup_task_id']['required'] = 'y';
            } // if
        } // if

        if ($fieldarray['pattern_id'] == 'multi2') {
            if ($fieldarray['child_forms'] == 1) {
                unset($this->fieldspec['popup_task_id']['required']);
                $fieldarray['popup_task_id'] = '';
            } else {
            	$this->fieldspec['popup_task_id']['required'] = 'y';
            } // if
        } // if

        // generate all the scripts and database records for this task

        $task_id    = $fieldarray['task_id'];
        $script_id  = $fieldarray['script_id'];
        $subsys_id  = $this->subsys_id;
        $subsys_dir = $this->subsys_dir;

        // check to see if task_id or script_id have been used yet
        $task_obj =& RDCsingleton::getInstance('mnu_task');
        $count = $task_obj->getCount("task_id='$task_id'");
        if ($count > 0) {
            // 'This id is already in use'
            $this->errors['task_id'] = getLanguageText('e0040');
        } // if
        $count = $task_obj->getCount("script_id='$script_id' AND subsys_id='$subsys_id'");
        if ($count > 0) {
            // 'This id is already in use'
            $this->errors['script_id'] = getLanguageText('e0040');
        } // if

        // get default language for screen/report file
        $control_obj =& RDCsingleton::getInstance('mnu_control');
        $default_lang = $control_obj->getControlData('DEFAULT_LANGUAGE');
        unset($control_obj);

        if (isset($fieldarray['screen_file'])) {
            // check to see if screen structure file exists yet
            $screen_dir  = "../$subsys_dir/screens/$default_lang/";
            $screen_file = $screen_dir .$fieldarray['screen_file'];
            if (file_exists($screen_file)) {
                // 'A file with this name already exists'
                $this->errors['screen_file'] = getLanguageText('e0041');
            } // if
        } elseif (isset($fieldarray['report_file'])) {
            // check to see if report structure file exists yet
            $report_dir  = "../$subsys_dir/reports/$default_lang/";
            $report_file = $report_dir .$fieldarray['report_file'];
            if (file_exists($report_file)) {
                // 'A file with this name already exists'
                $this->errors['report_file'] = getLanguageText('e0041');
            } // if
        } // if

        if (!empty($fieldarray['tablename']) AND !empty($fieldarray['table_alias'])) {
            if ($fieldarray['tablename'] == $fieldarray['table_alias']) {
                // Alias name must not be the same as the table name
                $this->errors['table_alias'] = getLanguageText('e0045');
            } // if
        } // if

        if (!empty($fieldarray['outer_table']) AND !empty($fieldarray['outer_table_alias'])) {
            if ($fieldarray['outer_table'] == $fieldarray['outer_table_alias']) {
                // Alias name must not be the same as the table name
                $this->errors['outer_table_alias'] = getLanguageText('e0045');
            } // if
        } // if

        if (!empty($fieldarray['middle_table']) AND !empty($fieldarray['middle_table_alias'])) {
            if ($fieldarray['middle_table'] == $fieldarray['middle_table_alias']) {
                // Alias name must not be the same as the table name
                $this->errors['middle_table_alias'] = getLanguageText('e0045');
            } // if
        } // if

        if (!empty($fieldarray['inner_table']) AND !empty($fieldarray['inner_table_alias'])) {
            if ($fieldarray['inner_table'] == $fieldarray['inner_table_alias']) {
                // Alias name must not be the same as the table name
                $this->errors['inner_table_alias'] = getLanguageText('e0045');
            } // if
        } // if

        if (preg_match('/^(multi5)$/i', $fieldarray['pattern_id'])) {
            // unrelated tables are allowed, but if same table is used for both outer and inner one of them must be aliased
            if ($fieldarray['outer_table'] == $fieldarray['inner_table']) {
                if (empty($fieldarray['outer_table_alias']) AND empty($fieldarray['inner_table_alias'])) {
                    // Table name is used more than once, so one must be aliased
                    $this->errors['outer_table_alias'] = getLanguageText('e0044', $fieldarray['inner_table']);
                    $this->errors['inner_table_alias'] = getLanguageText('e0044', $fieldarray['inner_table']);
                } // if
            } // if
        } elseif (preg_match('/^(multi6)$/i', $fieldarray['pattern_id'])) {
            // unrelated tables are allowed, but if same table is used for outer, middle and inner one of them must be aliased
            if ($fieldarray['outer_table'] == $fieldarray['middle_table']) {
                if (empty($fieldarray['outer_table_alias']) AND empty($fieldarray['middle_table_alias'])) {
                    // Table name is used more than once, so one must be aliased
                    $this->errors['outer_table_alias'] = getLanguageText('e0044', $fieldarray['middle_table']);
                    $this->errors['middle_table_alias'] = getLanguageText('e0044', $fieldarray['middle_table']);
                } // if
            } // if
            $error = $this->_checkRelationship($fieldarray['middle_table'], $fieldarray['database_id_middle'], $fieldarray['inner_table'], $fieldarray['database_id']);
            if ($error) {
                $this->errors['middle_table'] = $error;
            } // if
        } else {
            // if more than one database table is involved, check that they are related
            if (isset($fieldarray['outer_table'])) {
                if (isset($fieldarray['middle_table'])) {
                    $error = $this->_checkRelationship($fieldarray['outer_table'], $fieldarray['database_id_outer'], $fieldarray['middle_table'], $fieldarray['database_id_middle']);
                    if ($error) {
                        $this->errors['outer_table'] = $error;
                    } // if
                    $error = $this->_checkRelationship($fieldarray['middle_table'], $fieldarray['database_id_middle'], $fieldarray['inner_table'], $fieldarray['database_id']);
                    if ($error) {
                        $this->errors['middle_table'] = $error;
                    } // if
                } elseif (isset($fieldarray['link_table'])) {
                    $error = $this->_checkRelationship($fieldarray['outer_table'], $fieldarray['database_id_outer'], $fieldarray['link_table'], $fieldarray['database_id']);
                    if ($error) {
                        $this->errors['outer_table'] = $error;
                    } // if
                    $error = $this->_checkRelationship($fieldarray['inner_table'], $fieldarray['database_id_inner'], $fieldarray['link_table'], $fieldarray['database_id']);
                    if ($error) {
                        $this->errors['inner_table'] = $error;
                    } // if
                } else {
                    $error = $this->_checkRelationship($fieldarray['outer_table'], $fieldarray['database_id_outer'], $fieldarray['inner_table'], $fieldarray['database_id']);
                    if ($error) {
                        $this->errors['outer_table'] = $error;
                    } // if
                } // if
            } // if
        } // if

        if (!empty($this->errors)) {
            return $fieldarray;
        } // if

        // all OK so far!!!
        $this->task_array = array();
        $this->nav_array  = array();

        // check for 'table AS alias' in any names
        if (isset($fieldarray['outer_table'])) {
            list($original, $alias) = getTableAlias3($fieldarray['outer_table']);
            if (strlen($alias) > 0) {
                $fieldarray['outer_table']       = $original;
                $fieldarray['outer_table_alias'] = $alias;
            } // if
        } // if

        if (isset($fieldarray['middle_table'])) {
            list($original, $alias) = getTableAlias3($fieldarray['middle_table']);
            if (strlen($alias) > 0) {
                $fieldarray['middle_table']       = $original;
                $fieldarray['middle_table_alias'] = $alias;
            } // if
        } // if

        // build component script
        $string = $this->_buildComponentScript ($this->pattern_id, $fieldarray);

        if (isset($fieldarray['screen_file'])) {
            if ($this->pattern_id == 'timetable1') {
                // build screen structure script
                $string = $this->_buildTimetableStructure ($this->pattern_id, $fieldarray, $screen_file);
            } else {
                // build screen structure script
                $string = $this->_buildScreenStructure ($this->pattern_id, $fieldarray, $screen_file);
            } // if
        } elseif (isset($fieldarray['report_file'])) {
            // build report structure script
            $string = $this->_buildReportStructure ($this->pattern_id, $fieldarray, $report_file);
        } // if

        $nav_data = array();
        // see if this task requires children to be built automatically
        if ($this->pattern_id == 'list1') {
            // build child tasks to run under this parent
            $string = $this->_buildComponentScript ('add1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('enq1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('upd1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('del1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
            // build single screen structure file for all these children
            $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
            $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);
            // add navigation button for AUDIT task
            $nav_data['task_id_snr'] = $fieldarray['task_id'];
            $nav_data['task_id_jnr'] = 'audit_dtl(list)3';
            $nav_data['context_preselect'] = 'Y';
            $this->nav_array[]       = $nav_data;

        } elseif ($this->pattern_id == 'list2') {
            if ($fieldarray['child_forms'] == '1') {
                unset($fieldarray['inner_table']);
                unset($fieldarray['inner_table_alias']);
                // build child tasks to run under this parent
                $string = $this->_buildComponentScript ('add2', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('enq1', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('upd1', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('del1', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
                // build single screen structure file for all these children
                $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
                $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);
                // add navigation button for AUDIT task
                $nav_data['task_id_snr'] = $fieldarray['task_id'];
                $nav_data['task_id_jnr'] = 'audit_dtl(list)3';
                $nav_data['context_preselect'] = 'Y';
                $this->nav_array[]       = $nav_data;

            } elseif ($fieldarray['child_forms'] == '2') {
                unset($fieldarray['inner_table']);
                unset($fieldarray['inner_table_alias']);
                // build child tasks to run under this parent
                $string = $this->_buildComponentScript ('add3', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('del2', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
                // build a screen structure file for the search screen
                $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
                $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);

            } elseif ($fieldarray['child_forms'] == '3') {
                unset($fieldarray['inner_table']);
                unset($fieldarray['inner_table_alias']);
                // build child tasks to run under this parent
                $string = $this->_buildComponentScript ('upd2', $fieldarray, $fieldarray['task_id'], 'popup1');
                $string = $this->_buildComponentScript ('del3', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
                // build a screen structure file for the search screen
                $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
                $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);

            } // if

        } elseif ($this->pattern_id == 'list3') {
            unset($fieldarray['inner_table']);
            unset($fieldarray['inner_table_alias']);
            // build child tasks to run under this parent
            $string = $this->_buildComponentScript ('add2', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('enq1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('upd1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('del1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
            // build single screen structure file for all these children
            $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
            $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);

        } elseif ($this->pattern_id == 'link1') {
            $fieldarray['table_id'] = $fieldarray['inner_table'];
            if ($fieldarray['database_id_inner'] == $fieldarray['database_id']) {
                $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
                // build single screen structure file for all these children
                $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
                $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);
            } // if

        } elseif ($this->pattern_id == 'multi2') {
            if ($fieldarray['child_forms'] == '1') {
                unset($fieldarray['inner_table']);
                unset($fieldarray['inner_table_alias']);
                $string = $this->_buildComponentScript ('add2', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('del1', $fieldarray, $fieldarray['task_id']);
                // build single screen structure file for all these children
                $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
                $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);

            } elseif ($fieldarray['child_forms'] == '2') {
                $string = $this->_buildComponentScript ('add3', $fieldarray, $fieldarray['task_id']);
                $string = $this->_buildComponentScript ('del2', $fieldarray, $fieldarray['task_id']);
            } // if

        } elseif ($this->pattern_id == 'multi3') {
            unset($fieldarray['inner_table']);
            unset($fieldarray['inner_table_alias']);
            // build child tasks to run under this parent
            $string = $this->_buildComponentScript ('add2', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('enq1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('upd1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('del1', $fieldarray, $fieldarray['task_id']);
            $string = $this->_buildComponentScript ('search', $fieldarray, $fieldarray['task_id']);
            // build single screen structure file for all these children
            $screen_file = $screen_dir .$fieldarray['table_id'] .'.detail.screen.inc';
            $string = $this->_buildScreenStructure ('detail1', $fieldarray, $screen_file);

        } // if

        if (!empty($this->errors)) {
            return $fieldarray;
        } // if

        if (!empty($this->task_array)) {
            // insert entries into MNU_TASK table
            $fieldarray = $task_obj->insertMultiple($this->task_array);
            if ($task_obj->errors) {
                $this->errors = array_merge($this->errors, $task_obj->getErrors());
            } // if
            $this->messages = array_merge($this->messages, $task_obj->getMessages());
        } // if

        if (!empty($this->nav_array)) {
            // add enties to MNU_NAV_BUTTON
            $nav_obj =& RDCsingleton::getInstance('mnu_nav_button');
            $fieldarray = $nav_obj->insertMultiple($this->nav_array);
            if ($nav_obj->errors) {
                $this->errors = array_merge($this->errors, $nav_obj->getErrors());
            } // if
            $this->messages = array_merge($this->messages, $nav_obj->getMessages());
        } // if

        if (!empty($this->menu_array)) {
            // add enties to MNU_MENU
            $menu_obj =& RDCsingleton::getInstance('mnu_menu');
            $fieldarray = $menu_obj->insertMultiple($this->menu_array);
            if ($menu_obj->errors) {
                $this->errors = array_merge($this->errors, $menu_obj->getErrors());
            } // if
            $this->messages = array_merge($this->messages, $menu_obj->getMessages());
        } // if

        $fieldarray = array();  // do not update the database

        //$this->messages[] = getLanguageText('e0042');  // 'Script has been generated';

        return $fieldarray;

    } // _cm_pre_updateRecord

    // ****************************************************************************
    function _buildComponentScript ($pattern_id, $fieldarray, $parent_id=null, $popup_type='popup1')
    // load in default component script, replace arguments, then output the result
    {
        // load in associated script from DEFAULT directory
        $filename = '../default/' .$pattern_id .'.php';
        if (!$handle = fopen($filename, "r")) {
            $this->errors[] = getLanguageText('sys0076', $filename);  // cannot open file
        	return;
        } // if
        $string = fread($handle, filesize($filename));
        fclose($handle);

        if (!empty($fieldarray['screen_file'])) {
            // insert name of screen structure file
            $string = str_replace($this->screen_file_long, $fieldarray['screen_file'], $string);
        } // if

        // replace table/task names with appropriate values
        if (!empty($fieldarray['table_id'])) {
            if (!empty($fieldarray['table_alias'])) {
            	$string = str_replace("#tablename#", $fieldarray['table_alias'], $string);
            	// create subclass for this alias name
            	$this->_writeClassFile ($fieldarray['table_id'], $fieldarray['table_alias']);
            } else {
            	$string = str_replace("#tablename#", $fieldarray['table_id'], $string);
            } // if
        } // if
        if (!empty($fieldarray['outer_table'])) {
            if (!empty($fieldarray['outer_table_alias'])) {
            	$string = str_replace("#outer_table#", $fieldarray['outer_table_alias'], $string);
            	// create subclass for this alias name
            	$this->_writeClassFile ($fieldarray['outer_table'], $fieldarray['outer_table_alias']);
            } else {
                $string = str_replace("#outer_table#", $fieldarray['outer_table'], $string);
            } // if
        } // if
        if (!empty($fieldarray['link_table'])) {
            $string = str_replace("#link_table#", $fieldarray['link_table'], $string);
        } // if
        if (!empty($fieldarray['middle_table'])) {
            if (!empty($fieldarray['middle_table_alias'])) {
            	$string = str_replace("#middle_table#", $fieldarray['middle_table_alias'], $string);
            	// create subclass for this alias name
            	$this->_writeClassFile ($fieldarray['middle_table'], $fieldarray['middle_table_alias']);
            } else {
                $string = str_replace("#middle_table#", $fieldarray['middle_table'], $string);
            } // if
        } // if
        if (!empty($fieldarray['inner_table'])) {
            if (!empty($fieldarray['inner_table_alias'])) {
            	$string = str_replace("#inner_table#", $fieldarray['inner_table_alias'], $string);
            	// create subclass for this alias name
            	$this->_writeClassFile ($fieldarray['inner_table'], $fieldarray['inner_table_alias']);
            } else {
                $string = str_replace("#inner_table#", $fieldarray['inner_table'], $string);
            } // if
        } // if

        if (!empty($fieldarray['popup_task_id'])) {
            $string = str_replace("#popup_task#", $fieldarray['popup_task_id'], $string);
        } // if

        // now output the result
        if ($pattern_id != $fieldarray['pattern_id']) {
        	// this is for a child screen, so some things need changing ...
            $fieldarray['script_id'] = $fieldarray['table_id'] ."($pattern_id).php";
            $fieldarray['task_id']   = $this->prefix .$fieldarray['table_id'] ."($pattern_id)";
        } // if

        $filename = '../' .$this->subsys_dir .'/' .$fieldarray['script_id'];
        if (file_exists($filename)) {
			// file already exists, so leave it alone
		} else {
	        if (!$fp = fopen($filename, 'w')) {
	            // "Cannot open file $filename"
	            $this->errors['script_id'] = getLanguageText('sys0076', $filename);
	        } else {
	            if (fwrite($fp, $string) === false) {
	                // "Cannot write to file $filename"
	                $this->errors['script_id'] = getLanguageText('sys0055', $filename);
	            } // if
	            fclose($fp);
	        } // if
		} // if

        $task_obj =& RDCsingleton::getInstance('mnu_task');
        $button_size = $task_obj->fieldspec['button_text']['size'];

        // build default description for use as button_text
        $table_name  = ucwords(str_replace('_', ' ', $fieldarray['table_id']));

		$task_obj =& RDCsingleton::getInstance('mnu_task');
        $count = $task_obj->getCount("task_id='{$fieldarray['task_id']}'");
        if ($count == 0) {
            // task does not exist, so create details to be added later
    		$task_data['task_id']     = $fieldarray['task_id'];
    		$task_data['task_type']   = 'PROC';
    		$task_data['script_id']   = $fieldarray['script_id'];
    		if ($pattern_id == 'search') {
    			$task_data['pattern_id']  = 'SRCH';
    		} else {
    		    $task_data['pattern_id']  = $pattern_id;
    		} // if
    		$task_data['subsys_id']   = $this->subsys_id;
    		$menu_data = array();
    		switch ($pattern_id) {
				case 'add1':
				case 'add2':
				case 'add3':
				case 'add4':
				case 'add5':
				    $task_data['task_name']   = getLanguageText('Add') .' ' .$table_name;
					$task_data['button_text'] = getLanguageText('New');
        			break;

				case 'batch':
				    $task_data['task_name']   = getLanguageText('Update') .' ' .$table_name .' (' .getLanguageText('batch') .')';
					$task_data['button_text'] = getLanguageText('Update') .' (' .getLanguageText('batch') .')';
        			break;

				case 'del1':
				case 'del2':
				case 'del3':
				case 'del4':
				    $task_data['task_name']   = getLanguageText('Delete') .' ' .$table_name;
					$task_data['button_text'] = getLanguageText('Delete');
        			break;

				case 'enq1':
				    $task_data['task_name']   = getLanguageText('Enquire') .' ' .$table_name;
					$task_data['button_text'] = getLanguageText('Read');
        			break;

				case 'filedownload':
                case 'filedownload2':
				    $task_data['task_name']   = getLanguageText('File Download');
					$task_data['button_text'] = getLanguageText('File Download');
        			break;

				case 'filepicker':
                case 'filepicker2':
				    $task_data['task_name']   = getLanguageText($fieldarray['table_id'] .' File Picker');
					$task_data['button_text'] = getLanguageText('File Picker');
        			break;

				case 'fileupload':
				    $task_data['task_name']   = getLanguageText('File Upload');
					$task_data['button_text'] = getLanguageText('File Upload');
        			break;

				case 'link1':
				    $task_data['task_name']   = getLanguageText('t0006', $fieldarray['inner_table'], $fieldarray['outer_table']);  // 'Link X to selected Y'
					$task_data['button_text'] = getLanguageText('Maintain') .' ' .$fieldarray['inner_table'];
        			break;

				case 'list1':
				    $task_data['task_name']   = getLanguageText('List') .' ' .$table_name;
					$task_data['button_text'] = $table_name;
					// add ths task to the subsystem's main menu
			        $menu_data['menu_id']     = $this->subsys_id;
			        $menu_data['task_id_jnr'] = $fieldarray['task_id'];
                    $menu_data['button_text'] = $table_name;
    			    break;

				case 'list2':
                    $fieldarray['inner_table'] = ucwords(str_ireplace('_', ' ', $fieldarray['inner_table']));
                    $fieldarray['outer_table'] = ucwords(str_ireplace('_', ' ', $fieldarray['outer_table']));
				    $task_data['task_name']   = getLanguageText('t0007', $fieldarray['inner_table'], $fieldarray['outer_table']);  // 'List X by Y'
					$task_data['button_text'] = $table_name;
        			break;

				case 'list3':
                    $fieldarray['inner_table']  = ucwords(str_ireplace('_', ' ', $fieldarray['inner_table']));
                    $fieldarray['middle_table'] = ucwords(str_ireplace('_', ' ', $fieldarray['middle_table']));
                    $fieldarray['outer_table']  = ucwords(str_ireplace('_', ' ', $fieldarray['outer_table']));
				    $task_data['task_name']   = getLanguageText('t0008', $fieldarray['inner_table'], $fieldarray['middle_table'], $fieldarray['outer_table']);  // 'List X by Y by Z'
					$task_data['button_text'] = $table_name;
        			break;

				case 'multi1':
				case 'multi2':
				case 'multi3':
				case 'multi4':
					$task_data['task_name']   = getLanguageText('Maintain') .' ' .$table_name;
                    $task_data['button_text'] = getLanguageText('Maintain') .' ' .$table_name;
					break;

				case 'multi5':
                case 'multi6':
                    $task_data['task_name']   = getLanguageText('Select/Display') .' ' .$table_name;
                    $task_data['button_text'] = getLanguageText('Select/Display') .' ' .$table_name;
                    break;

                case 'output1':
                case 'output6':
					$task_data['task_name']   = getLanguageText('t0020', $table_name);  // 'Output X to CSV';
    		        $task_data['button_text'] = getLanguageText('t0021');  // 'Output to CSV';
					break;

				case 'output2':
					$task_data['task_name']   = getLanguageText('t0022', $table_name);  // 'Output X to PDF (list view)';
    		        $task_data['button_text'] = getLanguageText('t0023');  // Output to PDF(L)';
					break;

				case 'output3':
					$task_data['task_name']   = getLanguageText('t0024', $table_name);  // 'Output X to PDF (detail view)';
    		        $task_data['button_text'] = getLanguageText('t0025');  // 'Output to PDF(D)';
					break;

				case 'output4':
					$task_data['task_name']   = getLanguageText('t0020', $table_name);  // 'Output X to CSV';
    		        $task_data['button_text'] = getLanguageText('t0021');  // 'Output to CSV';
					break;

				case 'output5':
					$task_data['task_name']   = getLanguageText('t0028', $table_name);  // 'Output X to PDF (address labels)';
    		        $task_data['button_text'] = getLanguageText('t0029');  // 'Address labels';
					break;

				case 'popup1':
				case 'popup2':
				case 'popup3':
				case 'popup4':
					$task_data['task_name']   = getLanguageText('Choose') .' ' .$table_name;
    		        $task_data['button_text'] = getLanguageText('Choose');
					break;

				case 'search':
					$task_data['task_name']   = getLanguageText('Search') .' ' .$table_name;
    		        $task_data['button_text'] = getLanguageText('Search');
					break;

				case 'timetable1':
					$task_data['task_name']   = getLanguageText('t0026', $table_name);  // 'Timetable for X';
    		        $task_data['button_text'] = getLanguageText('Timetable');
					break;

				case 'tree1':
				case 'tree2':
					$task_data['task_name']   = getLanguageText('t0027', $table_name);  // 'Tree Structure for X';
    		        $task_data['button_text'] = getLanguageText('Tree Structure');
					break;

				case 'upd1':
				case 'upd2':
				case 'upd3':
				case 'upd4':
				    $task_data['task_name']   = getLanguageText('Update') .' ' .$table_name;
					$task_data['button_text'] = getLanguageText('Update');
        			break;

				case 'upd5':
				    $task_data['task_name']   = getLanguageText('Insert or Update') .' ' .$table_name;
					$task_data['button_text'] = getLanguageText('Insert/Update');
        			break;

				default:
				    $task_data['task_name']   = getLanguageText('DEFAULT');
					$task_data['button_text'] = getLanguageText('DEFAULT');
					break;
			} // switch
            if (strlen($task_data['button_text']) > $button_size) {
                $task_data['button_text'] = substr($task_data['button_text'], 0, $button_size);  // truncate to maximum length allowed
            } // if
    		$this->task_array[] = $task_data;
    		if (!empty($menu_data)) {
                if (strlen($menu_data['button_text']) > $button_size) {
                    $menu_data['button_text'] = substr($menu_data['button_text'], 0, $button_size);  // truncate to maximum length allowed
                } // if
    			$this->menu_array[] = $menu_data;
    		} // if
        } // if

		if (!empty($parent_id)) {
		    // this task has a parent, so add it to parent's navigation buttons
			$nav_data['task_id_snr'] = $parent_id;
			$nav_data['task_id_jnr'] = $fieldarray['task_id'];
			$nav_obj =& RDCsingleton::getInstance('mnu_nav_button');
            $count = $nav_obj->getCount("task_id_snr='{$nav_data['task_id_snr']}' AND task_id_jnr='{$nav_data['task_id_jnr']}'");
            if ($count == 0) {
            	switch ($pattern_id) {
    			    case 'add1':
    				case 'add2':
    				case 'add3':
    				case 'add4':
    				case 'add5':
    					$nav_data['button_text']       = getLanguageText('New');
            			$nav_data['context_preselect'] = 'N';
    					break;

    				case 'del1':
    				case 'del2':
    				case 'del3':
    				case 'del4':
    					$nav_data['button_text']       = getLanguageText('Delete');
            			$nav_data['context_preselect'] = 'Y';
    					break;

    				case 'enq1':
    					$nav_data['button_text']       = getLanguageText('Read');
            			$nav_data['context_preselect'] = 'Y';
    					break;

    				case 'search':
    					$nav_data['button_text']       = getLanguageText('Search');
            			$nav_data['context_preselect'] = 'N';
    					break;

    				case 'upd1':
    				case 'upd2':
    				case 'upd3':
    				case 'upd4':
    					$nav_data['button_text']       = getLanguageText('Update');
    					if ($fieldarray['pattern_id'] == 'list2' AND $pattern_id == 'upd2') {
    						$nav_data['context_preselect'] = 'N';
    					} else {
            			    $nav_data['context_preselect'] = 'Y';
    					} // if
    					break;

    				default:
    				    $nav_data['button_text']       = $pattern_id;
            			$nav_data['context_preselect'] = 'Y';
    					break;
    			} // switch
    			$this->nav_array[] = $nav_data;
            } // if
		} // if

        return $string;

    } // _buildCompnentScript

    // ****************************************************************************
    function _buildReportStructure ($pattern_id, $fieldarray, $filename_out)
    // load in default report script, replace arguments, then output the result
    {
        // load in associated script from DEFAULT directory
        $filename = '../default/reports/en/' .$pattern_id .'.report.inc';
        if (!$handle = fopen($filename, "r")) {
            $this->errors[] = getLanguageText('sys0076', $filename);  // cannot open file
        	return;
        } // if

        // create object for obtaining column details for each table
        $object =& RDCsingleton::getInstance('dict_column');
    	$object->sql_select = 'column_id, column_name';
	    $database_id = $fieldarray['database_id'];
	    $table_id = $fieldarray['table_id'];
        $rowdata = $object->getData_raw("database_id='$database_id' AND table_id='$table_id'");

        // array of processed objects (so each one is only done once)
	    $done = array();

        $string_out = '';
        while (!feof($handle)) {
            $string_in = fgets($handle);

            if ($pattern_id == 'output2') {
            	// replace column details
                if (preg_match('/^\$structure\[\'columns\']/i', $string_in)) {
                    if (array_key_exists('columns', $done)) {
                    	// already been done, so do not repeat
                    } else {
                        $done['columns'] = true;
                        // set column width as a percentage
                        $percent = round(100 / count($rowdata), 2);
                        $string_in = str_replace('n%', "$percent%", $string_in);
                        // repeat this line for every column in the table
                        for ($i = 0; $i < count($rowdata); $i++) {
                		    $string_out .= $string_in;
                		} // for
                    } // if
                    $string_in = '';
                } // if
            } // if

            if ($pattern_id == 'output5') {
                // skip this next bit
            } else {
                // insert field details
                if (preg_match('/^\$structure\[\'body\']\[\'fields\']/i', $string_in)) {
                    $string_in = '';
                    if (array_key_exists('fields', $done)) {
                    	// already been done, so do not repeat
                    } else {
                        $done['fields'] = true;
                        foreach ($rowdata as $data) {
                            $field = $data['column_id'];
                            $label = $data['column_name'];
                            $string_out .= '$structure' ."['body']['fields'][] = array('$field' => '$label');\n";
                        } // foreach
                    } // if
                } // if
            } // if

            $string_out .= $string_in;
        } // while
        fclose($handle);

        // now output the result
        if (file_exists($filename_out)) {
			// file already exists, so leave it alone
		} else {
	        if (!$fp = fopen($filename_out, 'w')) {
	            // "Cannot open file $filename"
	            $this->errors['report_file'] = getLanguageText('sys0076', $filename_out);
	        } else {
	            if (fwrite($fp, $string_out) === false) {
	                // "Cannot write to file $filename"
	                $this->errors['report_file'] = getLanguageText('sys0055', $filename_out);
	            } // if
	            fclose($fp);
	        } // if
		} // if

        return $string_out;

    } // _buildReportStructure

    // ****************************************************************************
    function _buildScreenStructure ($pattern_id, $fieldarray, $filename_out)
    // load in default screen script, replace arguments, then output the result
    {
        // load in associated script from DEFAULT directory
        $filename = '../default/screens/en/' .$pattern_id .'.screen.inc';

        if (!$handle = fopen($filename, "r")) {
            $this->errors[] = getLanguageText('sys0076', $filename);  // cannot open file
        	return;
        } // if

        // load contents into local variable $structure
        require $filename;

        // build arrays of generic-to-actual table names
        $search_array  = array();
        $replace_array = array();
        if (!empty($fieldarray['table_id'])) {
            $search_array[]  = '#tablename#';
            if (!empty($fieldarray['table_id_alias'])) {
            	$replace_array[] = $fieldarray['table_id_alias'];
            } else {
                $replace_array[] = $fieldarray['table_id'];
            } // if
            $fieldarray['main_table'] = $fieldarray['table_id'];
        } // if
        if (!empty($fieldarray['outer_table'])) {
            $search_array[]  = '#outer_table#';
            if (!empty($fieldarray['outer_table_alias'])) {
            	$replace_array[] = $fieldarray['outer_table_alias'];
            } else {
                $replace_array[] = $fieldarray['outer_table'];
            } // if
        } // if
        if (!empty($fieldarray['link_table'])) {
            $search_array[]  = '#link_table#';
            $replace_array[] = $fieldarray['link_table'];
        } // if
        if (!empty($fieldarray['middle_table'])) {
            $search_array[]  = '#middle_table#';
            if (!empty($fieldarray['middle_table_alias'])) {
                $replace_array[] = $fieldarray['middle_table_alias'];
            } else {
                $replace_array[] = $fieldarray['middle_table'];
            } // if
        } // if
        if (!empty($fieldarray['inner_table'])) {
            $search_array[]  = '#inner_table#';
            if (!empty($fieldarray['inner_table_alias'])) {
            	$replace_array[] = $fieldarray['inner_table'] .' AS ' .$fieldarray['inner_table_alias'];
            } else {
                $replace_array[] = $fieldarray['inner_table'];
            } // if
        } // if

        $string_out = '';
        if (preg_match('/filepicker/i', $pattern_id)) {
            // there is no text to replace in this file
        	while (!feof($handle)) {
                $string_in = fgets($handle);
                $string_out .= $string_in;
        	} // while
        } else {

            // create object for obtaining column details for each table
            $object =& RDCsingleton::getInstance('dict_column');
        	$object->sql_select = 'column_id, column_name';

    	    // array of processed objects (so each one is only done once)
    	    $done = array();

    	    while (!feof($handle)) {
                $string_in = fgets($handle);

                // replace '#generic#' with 'actual' table name
                if (preg_match('/#.+#/i', $string_in, $regs)) {
                    $key = array_search($regs[0], $search_array);
                    if ($key !== false) {
                    	$replace = $replace_array[$key];
                    	// look for 'original AS alias' and extract the two names
                        list($original, $alias) = getTableAlias3($replace);
                        if (strlen($original) < 1) {
                        	$original = $replace;
                        	$alias    = $replace;
                        } // if
                        $string_in = str_replace($regs[0], $alias, $string_in);
                    } // if
                } // if

                if (preg_match('/(tree1)/i', $pattern_id)) {
                    // ignore this next bit
                } else {
                    // look for an instance of "$structure['zone']['columns']" and extract 'zone'
                    if (preg_match('/(?<=\$structure\[\')\w+(?=\']\[\'columns\'])/i', $string_in, $regs)) {
                        $zone = $regs[0];
                        if (preg_match('/(tree2)/i', $pattern_id) AND preg_match('/(inner)/i', $zone)) {
                            // ignore this next bit
                        } else {
                            $string_in = '';
                            if (!empty($done[$zone]) AND array_key_exists('columns', $done[$zone])) {
                    	        // already been done, so do not repeat
                            } else {
                                $done[$zone]['columns'] = true;
                                if ($zone == 'outer') {
                        	        $database_id = $fieldarray['database_id_outer'];
                                } else {
                                    $database_id = $fieldarray['database_id'];
                                } // if
                                $table_id  = $fieldarray[$zone.'_table'];
                                // look for 'original AS alias' and extract the two names
                                list($original, $alias) = getTableAlias3($table_id);
                                if (strlen($original) > 0) {
                        	        $table_id = $original;
                                } // if
                                if (array_key_exists('selectbox', $structure[$zone]['fields'][0])) {
                        	        // these columns are dispayed across the page (horizonal)
                    		        // define width for SELECTBOX column
                    		        $string_out .= '$structure[\'' .$zone ."']['columns'][] = array('width' => 5);\n";
                    		        // create entry for each column in this table
                    		        $rowdata   = $object->getData_raw("database_id='$database_id' AND table_id='$table_id'");
                    		        $percent = round(100 / count($rowdata), 2);
                    		        for ($i = 0; $i < count($rowdata); $i++) {
                    		            //$string_out .= '$structure[\'' .$zone ."']['columns'][] = array('width' => '$percent%');\n";
                                        $string_out .= '$structure[\'' .$zone ."']['columns'][] = array('width' => '*');\n";
                    		        } // for
                    	        } else {
                    	            // these columns are displayed down the page (vertical) so only 2 entries are needed
                    	            $string_out .= '$structure[\'' .$zone ."']['columns'][] = array('width' => '25%');\n";
                    	            $string_out .= '$structure[\'' .$zone ."']['columns'][] = array('width' => '*');\n";
                                } // if
                            } // if
                        } // if
                    } // if

                    // look for an instance of "$structure['zone']['fields']" and extract 'zone'
                    if (preg_match('/(?<=\$structure\[\')\w+(?=\']\[\'fields\'])/i', $string_in, $regs)) {
                        $zone = $regs[0];
                        if (preg_match('/(tree2)/i', $pattern_id) AND preg_match('/(inner)/i', $zone)) {
                            // ignore this next bit
                        } else {
                            $string_in = '';
                            if (array_key_exists('fields', $done[$zone])) {
                    	        // already been done, so ignore
                            } else {
                                $done[$zone]['fields'] = true;
                                if ($zone == 'outer') {
                        	        $database_id = $fieldarray['database_id_outer'];
                                } else {
                                    $database_id = $fieldarray['database_id'];
                                } // if
                                $table_id  = $fieldarray[$zone.'_table'];
                                // look for 'original AS alias' and extract the two names
                                list($original, $alias) = getTableAlias3($table_id);
                                if (strlen($original) > 0) {
                        	        $table_id = $original;
                                } // if
                                $rowdata   = $object->getData_raw("database_id='$database_id' AND table_id='$table_id'");
                                if (array_key_exists('selectbox', $structure[$zone]['fields'][0])) {
                                    // create entry for SELECTBOX column
                    		        $string_out .= '$structure[\'' .$zone ."']['fields'][] = array('selectbox' => 'Select');\n";
                                } // if
                                // create entries for each column
                                foreach ($rowdata as $data) {
                                    $field = $data['column_id'];
                                    $label = $data['column_name'];
                                    $string_out .= '$structure[\'' .$zone ."']['fields'][] = array('$field' => '$label');\n";
                                } // foreach
                            } // if
                        } // if
                    } // if
                } // if

                $string_out .= $string_in;
            } // while
        } // if

        fclose($handle);

        // now output the result
        if (file_exists($filename_out)) {
			// file already exists, so leave it alone
		} else {
	        if (!$fp = fopen($filename_out, 'w')) {
	            // "Cannot open file $filename"
	            $this->errors['screen_file'] = getLanguageText('sys0076', $filename_out);
	        } else {
	            if (fwrite($fp, $string_out) === false) {
	                // "Cannot write to file $filename"
	                $this->errors['screen_file'] = getLanguageText('sys0055', $filename_out);
	            } // if
	            fclose($fp);
	        } // if
		} // if

        return $string_out;

    } // _buildScreenStructure

    // ****************************************************************************
    function _buildTimetableStructure ($pattern_id, $fieldarray, $filename_out)
    // load in default screen script, replace arguments, then output the result
    {
        // load in associated script from DEFAULT directory
        $filename = '../default/screens/en/' .$pattern_id .'.screen.inc';
        if (!$handle = fopen($filename, "r")) {
            $this->errors[] = getLanguageText('sys0076', $filename);  // cannot open file
        	return;
        } // if

        // build arrays of generic-to-actual table names
        $search_array  = array();
        $replace_array = array();
        if (!empty($fieldarray['outer_table'])) {
            $search_array[]  = '#outer_table#';
            $replace_array[] = $fieldarray['outer_table'];
        } // if
        if (!empty($fieldarray['inner_table'])) {
            $search_array[]  = '#inner_table#';
            $replace_array[] = $fieldarray['inner_table'];
        } // if

        // create object for obtaining column details for each table
        $object =& RDCsingleton::getInstance('dict_column');
    	$object->sql_select = 'column_id, column_name';
	    $database_id = $fieldarray['database_id'];

        $string_out = '';
        while (!feof($handle)) {
            $string_in = fgets($handle);

            // replace table names
            if (preg_match('/^\$structure\[\'tables\']/i', $string_in)) {
                $string_in = str_replace($search_array, $replace_array, $string_in);
            } // if

            // insert column details
            if (preg_match('/^\$structure\[\'outer\']\[\'fields\']/i', $string_in)) {
                $string_in = '';
                $table_id = $fieldarray['outer_table'];
                $rowdata = $object->getData_raw("database_id='$database_id' AND table_id='$table_id'");
                foreach ($rowdata as $data) {
                    $field = $data['column_id'];
                    $label = $data['column_name'];
                    $string_out .= '$structure' ."['outer']['fields'][] = array('$field' => '$label');\n";
                } // foreach
            } // if

            $string_out .= $string_in;
        } // while
        fclose($handle);

        // now output the result
        if (file_exists($filename_out)) {
			// file already exists, so leave it alone
		} else {
	        if (!$fp = fopen($filename_out, 'w')) {
	            // "Cannot open file $filename"
	            $this->errors['screen_file'] = getLanguageText('sys0076', $filename_out);
	        } else {
	            if (fwrite($fp, $string_out) === false) {
	                // "Cannot write to file $filename"
	                $this->errors['screen_file'] = getLanguageText('sys0055', $filename_out);
	            } // if
	            fclose($fp);
	        } // if
		} // if

        return $string_out;

    } // _buildTimetableStructure

    // ****************************************************************************
    function _checkRelationship($parent, $parent_database, $child, $child_database)
    // check that the $parent table is related to the $child table
    {
        $error = null;

        // look for 'original AS alias' and extract the two names
        list($original, $alias) = getTableAlias3($parent);

        $dbobject =& RDCsingleton::getInstance('dict_relationship');
        if (strlen($original) > 0) {
        	$where = "database_id_snr='$parent_database' AND table_id_snr='$original' AND database_id_jnr='$child_database' AND table_id_jnr='$child'";
        } else {
            $where = "database_id_snr='$parent_database' AND table_id_snr='$parent' AND database_id_jnr='$child_database' AND table_id_jnr='$child'";
        } // if
        $count = $dbobject->getCount($where);
        if ($count < 1) {
            // 'Table $parent is not related to $child'
        	$error = getLanguageText('e0043', strtoupper($parent), strtoupper($child));
        } // if

        return $error;

    } // _checkRelationship

    // ****************************************************************************
    function _writeClassFile ($table_id, $alias_id)
    // create a class file to access this database table using an alias name.
    {
        // read in skeleton class file
        $fname = $_SERVER['DOCUMENT_ROOT']
                .getParentDIR()
                .'/default/classes/alias.class.inc';
        if (!$template = file_get_contents($fname)) {
            $this->errors[] = "Cannot read file $fname";
			return;
        } // if

		// insert original table name and alias name into template
		$template = str_replace('#tablename#', $table_id, $template);
		$template = str_replace('#aliasname#', $alias_id, $template);

		$fname = $_SERVER['DOCUMENT_ROOT']
		        .getParentDIR()
		        .'/' .$this->subsys_dir .'/classes/' .$alias_id .'.class.inc';

	    if (file_exists($fname)) {
			// file already exists, so leave it alone
		} else {
	        if (!$fp = fopen($fname, 'w')) {
	            $this->errors[] = getLanguageText('sys0076', $fname); // "Cannot open file $fname";
	        } else {
	            if (fwrite($fp, $template) === false) {
	                $this->errors[] = getLanguageText('sys0055', $fname); // "Cannot write to file $fname";
	            } // if
	            fclose($fp);
	            //$this->messages[] = getLanguageText('sys0093', $fname); // "Exported to $fname";
	        } // if
		} // if

        return;

    } // _writeClassFile

// ****************************************************************************
} // end class
// ****************************************************************************

?>
