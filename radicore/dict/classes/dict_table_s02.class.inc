<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_table.class.inc';
class dict_table_s02 extends dict_table
{
    // member variables
    var $text_out;          // to be written to a text file

    // ****************************************************************************
    // this class is used to export table details to a PHP script
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        list($menu_prefix, $server_name) = dict_findDBPrefix('menu');

        // create object for retrieving column details
        $columnobj =& RDCsingleton::getInstance('dict_column');

        // create object for retrieving key details
        $keyobj =& RDCsingleton::getInstance('dict_table_key');

        // create object for retrieving relationship details
        $relobj =& RDCsingleton::getInstance('dict_relationship');

        // process each table separately
        foreach ($rowdata as $row => $tabledata) {

			$database_id = $tabledata['database_id'];
            $table_id    = $tabledata['table_id'];
            $subsys_dir  = $tabledata['subsys_dir'];
            $subsys_id   = $tabledata['subsys_id'];

            $count = $columnobj->getCount("database_id='$database_id' AND table_id='$table_id'");
            if ($count == 0) {
                // "Nothing exported for $table_id as it has no columns"
                $this->messages[] = getLanguageText('e0026', strtoupper($table_id));
            } else {

    			// write initial class file to disk
                $this->_writeClassFile ($database_id, $table_id, $subsys_dir);
                if ($this->errors) {
                	return array();
                } // if

                $this->text_out = '    // file created on ' .date('F j, Y, g:i a') ."\n    \n";

                // process column details
            	$columnobj->sql_orderby = 'column_seq';
                $data = $columnobj->getData("database_id='$database_id' AND table_id='$table_id'");
    			if (empty($data)) {
    			    $data[0]['database_id'] = $database_id;
    				$data[0]['table_id']    = $table_id;
    			} // if
    			$this->_createFieldSpecs($data);

                // process primary key details
                $keyobj->sql_orderby = 'key_name, seq_in_index';
                $data = $keyobj->getData("database_id='$database_id' AND table_id='$table_id' AND key_name='PRIMARY'");
                $this->_createPKeySpecs($data);

                // process candidate key details
                $keyobj->sql_orderby = 'key_name, seq_in_index';
                $data = $keyobj->getData("database_id='$database_id' AND table_id='$table_id' AND key_name<>'PRIMARY' AND is_unique='Y'");
                $this->_createUKeySpecs($data);

                // process child relationships
                $relobj->sql_select  = 'dict_relationship.*, dict_database.subsys_id, subsys_dir';
                $relobj->sql_from    = 'dict_relationship '
                                     . 'LEFT JOIN dict_database ON (dict_database.database_id=dict_relationship.database_id_jnr) '
                                     . 'LEFT JOIN "' .$menu_prefix .'menu".mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) ';
                $relobj->sql_orderby = 'database_id_jnr, table_id_jnr';
                $data = $relobj->getData("database_id_snr='$database_id' AND table_id_snr='$table_id'");
                $this->_createChildRelations($data, $subsys_id);

                // process parent relationships
                $relobj->sql_select  = 'dict_relationship.*, dict_database.subsys_id, subsys_dir';
                $relobj->sql_from    = 'dict_relationship '
                                     . 'LEFT JOIN dict_database ON (dict_database.database_id=dict_relationship.database_id_snr) '
                                     . 'LEFT JOIN "' .$menu_prefix .'menu".mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) ';
                $relobj->sql_orderby = 'database_id_snr, table_id_snr';
                $data = $relobj->getData("database_id_jnr='$database_id' AND table_id_jnr='$table_id'");
                $this->_createParentRelations($data, $subsys_id);

                // audit logging
                $this->text_out .= '    // determines if database updates are recorded in an audit log ' ."\n";
                $entry = '    $this->audit_logging';
                $entry = str_pad($entry, 44);
                if (is_True($tabledata['audit_logging'])) {
                    $entry .= "= TRUE;\n";
                } else {
                    $entry .= "= FALSE;\n";
                } // if
                $this->text_out .= $entry;
                $this->text_out .= "    \n";

                // default sort sequence
                $this->text_out .= '    // default sort sequence ' ."\n";
                $entry = '    $this->default_orderby';
                $entry = str_pad($entry, 44);
                $entry .= "= '".$tabledata['default_orderby'] ."';\n";
                $this->text_out .= $entry;
                $this->text_out .= "    \n";

                // alternative language options
                $this->text_out .= '    // alternative language options ' ."\n";
                $entry = '    $this->alt_language_table';
                $entry = str_pad($entry, 44);
                $entry .= "= '".$tabledata['alt_language_table'] ."';\n";
                $this->text_out .= $entry;
                $entry = '    $this->alt_language_cols';
                $entry = str_pad($entry, 44);
                $entry .= "= '".$tabledata['alt_language_cols'] ."';\n";
                $this->text_out .= $entry;
                $this->text_out .= "    \n";

                // start_date/end_date alias names
                $this->text_out .= '    // alias names ' ."\n";
                $entry = '    $this->nameof_start_date';
                $entry = str_pad($entry, 44);
                $entry .= "= '".$tabledata['nameof_start_date'] ."';\n";
                $this->text_out .= $entry;
                $entry = '    $this->nameof_end_date';
                $entry = str_pad($entry, 44);
                $entry .= "= '".$tabledata['nameof_end_date'] ."';\n";
                $this->text_out .= $entry;
                $this->text_out .= "    \n";

                $this->text_out .= '    // finished' ."\n";

                // write completed dict file to disk
                $this->_writeDictFile ($table_id, $subsys_dir);
                if ($this->errors) {
                	return array();
                } // if
            } // if

        } // foreach

		// return an empty array as there is no database update
        return array();

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // ensure that at least one entry has been selected
        $this->checkPrimaryKey = true;

        //list($menu_prefix, $server_name) = dict_findDBPrefix('menu');

        // find out if tables in the 'menu' database need to be qualified
        $menuDB = $this->_qualify_dbname($this->dbname, 'menu');

        if (empty($this->sql_select)) {
            // obtain SUBSYS_DIR from MNU_SUBSYSTEM table
            $this->sql_select = 'dict_table.*, dict_database.subsys_id, mnu_subsystem.subsys_dir';
            $this->sql_from   = 'dict_table '
                              . 'LEFT JOIN dict_database ON (dict_database.database_id=dict_table.database_id) '
                              . 'LEFT JOIN ' .$menuDB .'mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) ';
                              //. 'LEFT JOIN "' .$menu_prefix .'menu".mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id) ';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($rows)
    // perform custom processing before multiple database records are updated.
    {
        // do no display record count
        $this->no_display_count = true;

        return $rows;

    } // _cm_pre_updateMultiple

    // ****************************************************************************
    function _createChildRelations ($rel_array, $subsys_id)
    // format the contents of $rel_array into the $child_relations array.
    {
        // create an object to obtain column data
        $colobj =& RDCsingleton::getInstance('dict_related_column');

        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $indent3 = str_pad('', 18);
        $this->text_out .= $indent .'// child relationship details ' ."\n";

        if (empty($rel_array)) {
            $entry = $indent .'$this->child_relations';
            $entry = str_pad($entry, 44);
            $entry .= "= array();\n$indent\n";
            $this->text_out .= $entry;
        } else {
            foreach ($rel_array as $row => $rowdata) {
                $db_id_snr  = $rowdata['database_id_snr'];
                $tbl_id_snr = $rowdata['table_id_snr'];
                $db_id_jnr  = $rowdata['database_id_jnr'];
                $tbl_id_jnr = $rowdata['table_id_jnr'];
                $seq_no     = $rowdata['seq_no'];

            	// start entry for this relationship
                $entry = $indent .'$this->child_relations[]';
                $entry = str_pad($entry, 44);
                $entry .= "= array('child' => '{$rowdata['table_id_jnr']}',";
                if ($rowdata['database_id_snr'] != $rowdata['database_id_jnr']) {
                    if ($rowdata['subsys_id'] != $subsys_id) {
                    	if (empty($rowdata['subsys_dir'])) {
                            // "SUBSYS_DIR is missing for database '?'"
                        	$this->errors[] = getLanguageText('e0049', $rowdata['database_id_jnr']);
                        } // if
                        $entry .= "\n$indent2'dbname' => '{$rowdata['database_id_jnr']}',";
                        $entry .= "\n$indent2'subsys_dir' => '{$rowdata['subsys_dir']}',";
                    } // if
                } // if
                if (strlen($rowdata['table_alias_jnr']) > 0) {
                    $entry .= "\n$indent2'alias' => '{$rowdata['table_alias_jnr']}',";
                } // if
                $entry .= "\n$indent2'type' => '{$rowdata['rel_type']}',";
                if (!empty($rowdata['orderby'])) {
                    $entry .= "\n$indent2'orderby' => '{$rowdata['orderby']}',";
                } // if

                // insert column details for this relationship
                $entry .= "\n$indent2'fields' => array(";
                $colobj->sql_orderby = 'seq_in_index';
                $data = $colobj->getData("database_id_snr='$db_id_snr' AND table_id_snr='$tbl_id_snr' AND database_id_jnr='$db_id_jnr' AND table_id_jnr='$tbl_id_jnr' AND seq_no='$seq_no'");
                foreach ($data as $row => $coldata) {
                	if ($row > 0) {
                        // entries after the first are on a separate line
                        $entry .= ",\n$indent2$indent3";
                    } // if
                    $entry .= "'{$coldata['column_id_snr']}' => '{$coldata['column_id_jnr']}'";
                } // foreach

                // close array structure and append to output string
                $entry .= "));\n$indent\n";
            	$this->text_out .= $entry;

            } // foreach
        } // if

        return;

    } // _createChildRelations

    // ****************************************************************************
    function _createFieldSpecs ($column_array)
    // format the contents of $column_array into the $fieldspec array.
    {
        // obtain standard column specs for this DBMS
        static $colspecs;
        if (!isset($colspecs)) {
            $colspecs = $this->_ddl_getColumnSpecs();
        } // if

        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// field specifications for table ' .$column_array[0]['database_id'] .'.' .$column_array[0]['table_id'] ."\n";

		if (array_key_exists('column_id', $column_array[0])) {
		    foreach ($column_array as $column) {
	            // start entry for new column
	        	$entry = $indent .'$fieldspec' ."['" .$column['column_id'] ."']";
	            $entry = str_pad($entry, 44);
	            $type = $column['col_type'];
	            if (empty($colspecs[$type]['type'])) {
	                // "Value is missing for fieldspec['type]"
	            	$this->errors[$column['column_id']] = getLanguageText('e0027');
	            } // if
	            $entry .= '= array(' ."'type' => '" .$colspecs[$type]['type'] ."'";

                if ($column['col_type_native'] != $column['col_type']) {
                    if (strpos($column['col_type_native'], ',')) {
                        $type_array = explode(',', $column['col_type_native']);
                        $first      = $type_array[0];
                        $entry .= ",\n$indent2'type_native' => '$first'";
                    } // if
                } // if

	            if (strlen($column['col_array_type']) > 0) {
	                $entry .= ",\n$indent2'array_type' => " .$column['col_array_type'];
	            } // if

	            if (preg_match('/boolean/i', $type)) {
	                // size is irrelevant for boolean fields
	            } else {
	                if (strlen($column['user_size']) > 0) {
	                    if ($column['user_size'] > 0) {
	                        $entry .= ",\n$indent2'size' => " .$column['user_size'];
	                    } // if
	                } // if
	            } // if

	            if (strlen($column['col_values']) > 0) {
	                $array1 = explode(',', trim($column['col_values'], '()'));
	                $entry .= ",\n$indent2'values' => " .'array(1 => ';
                    foreach ($array1 as $array_entry) {
                        $entry .= $array_entry .',';
                    } // foreach
	                $entry = substr($entry, 0, strlen($entry) -1); // remove trailing ','
	                $entry .= ')';                                 // close array
	            } // if

	            // these are for numeric fields
	            if (strlen($column['col_precision']) > 0) {
	                $entry .= ",\n$indent2'precision' => " .$column['col_precision'];
	            } // if
	            if (strlen($column['col_scale']) > 0) {
	                $entry .= ",\n$indent2'scale' => " .$column['col_scale'];
	            } // if
	            if (!empty($column['col_zerofill_bwz'])) {
	            	switch ($column['col_zerofill_bwz']) {
	            		case 'ZF':
	            			$entry .= ",\n$indent2'zerofill' => 'y'";
	            			break;
	            		case 'BWZ':
	            			$entry .= ",\n$indent2'blank_when_zero' => 'y'";
	            			break;
	            		case 'STZ':
	            			$entry .= ",\n$indent2'strip_trailing_zero' => 'y'";
	            			break;
	            		default:
	            			break;
	            	} // switch
	            } // if
	            if (is_True($column['col_auto_increment'])) {
	                $entry .= ",\n$indent2'auto_increment' => 'y'";
	            } // if
                if (preg_match('/(boolean)/i', $type)) {
                    // min/max values not appropriate for boolean fields
                } else {
	                if (strlen($column['user_minvalue']) > 0) {
	                    $entry .= ",\n$indent2'minvalue' => " .$column['user_minvalue'];
	                } else {
	                    if (is_True($column['col_unsigned'])) {
	                        $entry .= ",\n$indent2'unsigned' => 'y'";
	                    } // if
	                } // if
                    if (strlen($column['user_maxvalue']) > 0) {
                        $entry .= ",\n$indent2'maxvalue' => " .$column['user_maxvalue'];
                    } // if
                } // if

	            if ($column['col_key'] == 'PRI') {
	                $entry .= ",\n$indent2'pkey' => 'y'";
	            } // if
	            if (is_True($column['is_required'])) {
	                $entry .= ",\n$indent2'required' => 'y'";
	            } // if
	            if (strlen($column['col_default']) > 0) {
	                $entry .= ",\n$indent2'default' => '" .$column['col_default'] ."'";
	            } // if
	            if (is_True($column['is_password'])) {
	                $entry .= ",\n$indent2'password' => 'y'";
	            } // if
	            if ($column['upper_lowercase'] == 'UPPER') {
	                $entry .= ",\n$indent2'uppercase' => 'y'";
	            } // if
	            if ($column['upper_lowercase'] == 'LOWER') {
	                $entry .= ",\n$indent2'lowercase' => 'y'";
	            } // if
	            if (is_True($column['auto_insert'])) {
	                $entry .= ",\n$indent2'autoinsert' => 'y'";
	            } // if
	            if (is_True($column['auto_update'])) {
	                $entry .= ",\n$indent2'autoupdate' => 'y'";
	            } // if
	            if (is_True($column['infinityisnull'])) {
	                $entry .= ",\n$indent2'infinityisnull' => 'y'";
	            } // if

	            if (preg_match('/boolean/i', $type)) {
	                // these are for boolean fields
	                if (strlen($column['boolean_true']) > 0) {
	                    $entry .= ",\n$indent2'true' => '" .$column['boolean_true'] ."'";
	                } // if
	                if (strlen($column['boolean_false']) > 0) {
	                    $entry .= ",\n$indent2'false' => '" .$column['boolean_false'] ."'";
	                } // if
	            } // if

	            if (strlen($column['custom_validation']) > 0) {
	                $entry .= ",\n$indent2'custom_validation' => '" .$column['custom_validation'] ."'";
	            } // if
	            if (strlen($column['col_subtype']) > 0) {
	                $entry .= ",\n$indent2'subtype' => '" .$column['col_subtype'] ."'";
	            } // if
	            if (strlen($column['image_width']) > 0) {
	                $entry .= ",\n$indent2'imagewidth' => " .$column['image_width'];
	            } // if
	            if (strlen($column['image_height']) > 0) {
	                $entry .= ",\n$indent2'imageheight' => " .$column['image_height'];
	            } // if
	            if (strlen($column['control']) > 0) {
	                $entry .= ",\n$indent2'control' => '" .$column['control'] ."'";
	            } // if
	            if (strlen($column['optionlist']) > 0) {
	                $entry .= ",\n$indent2'optionlist' => '" .$column['optionlist'] ."'";
	            } // if
	            if (strlen($column['checkbox_label']) > 0) {
	                if (preg_match('/^getLanguageText/', $column['checkbox_label'])) {
	                    // this is a function, not text, so do not enclose in single quotes
	                	$entry .= ",\n$indent2'label' => " .$column['checkbox_label'];
	                } else {
	                    $entry .= ",\n$indent2'label' => '" .$column['checkbox_label'] ."'";
	                } // if
	            } // if
	            if (strlen($column['task_id']) > 0) {
	                $entry .= ",\n$indent2'task_id' => '" .$column['task_id'] ."'";
	            } // if
	            if (strlen($column['foreign_field']) > 0) {
	                $entry .= ",\n$indent2'foreign_field' => '" .addslashes($column['foreign_field']) ."'";
	            } // if
	            if (strlen($column['align_hv']) > 0) {
	                $entry .= ",\n$indent2'align_hv' => '" .$column['align_hv'] ."'";
	            } // if
	            if (strlen($column['align_lr']) > 0) {
	                $entry .= ",\n$indent2'align_lr' => '" .$column['align_lr'] ."'";
	            } // if
	            if (strlen($column['multi_cols']) > 0) {
	                $entry .= ",\n$indent2'cols' => " .$column['multi_cols'];
	            } // if
	            if (strlen($column['multi_rows']) > 0) {
	                $entry .= ",\n$indent2'rows' => " .$column['multi_rows'];
	            } // if

	            if ($column['noedit_nodisplay'] == 'NED') {
	                $entry .= ",\n$indent2'noedit' => 'y'";
	            } // if
	            if ($column['noedit_nodisplay'] == 'NDI') {
	                $entry .= ",\n$indent2'nodisplay' => 'y'";
	            } // if
	            if ($column['no_search'] == 'NSR') {
	                $entry .= ",\n$indent2'nosearch' => 'y'";
	            } // if
                if ($column['no_audit'] == 'NAL') {
	                $entry .= ",\n$indent2'noaudit' => 'y'";
	            } // if
	            // close array structure and append to output string
	            $entry .= ");\n$indent\n";
	            $this->text_out .= $entry;

	        } // foreach
		} else {
			$entry = $indent .'$fieldspec';
	        $entry = str_pad($entry, 44);
	        $entry .= '= array();' ."\n";
			$this->text_out .= $entry;
		} // if

		//$this->text_out .= $indent ."\n";

    } // _createFieldSpecs

    // ****************************************************************************
    function _createParentRelations ($rel_array, $subsys_id)
    // format the contents of $rel_array into the $parent_relations array.
    {
        // create an object to obtain column data
        $colobj =& RDCsingleton::getInstance('dict_related_column');
        // create an object to obtain table data
        $tblobj =& RDCsingleton::getInstance('dict_table');

        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $indent3 = str_pad('', 18);
        $this->text_out .= $indent .'// parent relationship details ' ."\n";

        if (empty($rel_array)) {
            $entry = $indent .'$this->parent_relations';
            $entry = str_pad($entry, 44);
            $entry .= "= array();\n$indent\n";
            $this->text_out .= $entry;
        } else {
            foreach ($rel_array as $row => $rowdata) {
                $db_id_snr  = $rowdata['database_id_snr'];
                $tbl_id_snr = $rowdata['table_id_snr'];
                $db_id_jnr  = $rowdata['database_id_jnr'];
                $tbl_id_jnr = $rowdata['table_id_jnr'];
                $seq_no     = $rowdata['seq_no'];

            	// start entry for this relationship
                $entry = $indent .'$this->parent_relations[]';
                $entry = str_pad($entry, 44);
                $entry .= "= array('parent' => '{$rowdata['table_id_snr']}',";
                if ($rowdata['database_id_snr'] != $rowdata['database_id_jnr']) {
                    if ($rowdata['subsys_id'] != $subsys_id) {
                        if (empty($rowdata['subsys_dir'])) {
                            // "SUBSYS_DIR is missing for database '?'"
                        	$this->errors[] = getLanguageText('e0049', $rowdata['database_id_snr']);
                        } // if
                        $entry .= "\n$indent2'dbname' => '{$rowdata['database_id_snr']}',";
                        $entry .= "\n$indent2'subsys_dir' => '{$rowdata['subsys_dir']}',";
                    } // if
                } // if
                if (strlen($rowdata['table_alias_snr']) > 0) {
                    $entry .= "\n$indent2'alias' => '{$rowdata['table_alias_snr']}',";
                } // if
                if ($rowdata['parent_field'] == '#calc#') {
                    $entry .= "\n$indent2'parent_field' => '" .addslashes($rowdata['calc_field']) ."',";
                } else {
                    if (strlen($rowdata['parent_field']) > 0) {
                        $entry .= "\n$indent2'parent_field' => '{$rowdata['parent_field']}',";
                    } // if
                } // if

                // look for alternative language table
                $data = $tblobj->getData("database_id='$db_id_snr' AND table_id='$tbl_id_snr'");
                if (!empty($data)) {
                	$data = $data[0];
                	if (!empty($data['alt_language_table'])) {
                		$entry .= "\n$indent2'alt_language_table' => '" .$data['alt_language_table'] ."',";
                		$entry .= "\n$indent2'alt_language_cols' => '" .$data['alt_language_cols'] ."',";
                	} // if
                } // if

                // insert column details for this relationship
                $entry .= "\n$indent2'fields' => array(";
                $colobj->sql_orderby = 'seq_in_index';
                $data = $colobj->getData("database_id_snr='$db_id_snr' AND table_id_snr='$tbl_id_snr' AND database_id_jnr='$db_id_jnr' AND table_id_jnr='$tbl_id_jnr' AND seq_no='$seq_no'");
                foreach ($data as $row => $coldata) {
                	if ($row > 0) {
                        // entries after the first are on a separate line
                        $entry .= ",\n$indent2$indent3";
                    } // if
                    $entry .= "'{$coldata['column_id_jnr']}' => '{$coldata['column_id_snr']}'";
                } // foreach

                // close array structure and append to output string
                $entry .= "));\n$indent\n";
            	$this->text_out .= $entry;

            } // foreach
        } // if

        return;

    } // _createParentRelations

    // ****************************************************************************
    function _createPKeySpecs ($key_array)
    // format the contents of $key_array into the $primary_key array.
    {
        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// primary key details ' ."\n";

        // start entry for primary key
        $entry = $indent .'$this->primary_key';
        $entry = str_pad($entry, 44);
        $entry .= '= array(';
        foreach ($key_array as $key) {
            if ($key['seq_in_index'] == 1) {
                // first entry appended to current line
                $entry .= "'{$key['column_id']}'";
            } else {
                // subsequent entries continue on next line
                $entry .= ",\n$indent2'{$key['column_id']}'";
            } // if
        } // foreach

        // close array structure and append to output string
        $entry .= ");\n$indent\n";
    	$this->text_out .= $entry;

        return;

    } // _createPKeySpecs

    // ****************************************************************************
    function _createUKeySpecs ($key_array)
    // format the contents of $key_array into the $unique_keys array.
    // (note that there can be more than one unique key)
    {
        $indent  = str_pad('', 4);
        $indent2 = str_pad('', 52);
        $this->text_out .= $indent .'// unique key details ' ."\n";

        if (empty($key_array)) {
            $entry = $indent .'$this->unique_keys';
            $entry = str_pad($entry, 44);
            $entry .= '= array(';
        } else {
            while (!empty($key_array)) {
            	// start entry for unique keys
                $key_name = $key_array[key($key_array)]['key_name'];
                $entry = $indent .'$this->unique_keys[]';
                $entry = str_pad($entry, 44);
                $entry .= '= array(';
                foreach ($key_array as $row => $key) {
                    if ($key_name == $key['key_name']) {
                        if ($key['seq_in_index'] == 1) {
                            // first entry appended to current line
                            $entry .= "'{$key['column_id']}'";
                        } else {
                            // subsequent entries continue on next line
                            $entry .= ",\n$indent2'{$key['column_id']}'";
                        } // if
                        unset($key_array[$row]);
                    } else {
                        $entry .= ");\n$indent\n";
       	                $this->text_out .= $entry;
                        break;
                    } // if
                } // foreach
            } // while
        } // if

        // close array structure and append to output string
        $entry .= ");\n$indent\n";
       	$this->text_out .= $entry;

        return;

    } // _createUKeySpecs

    // ****************************************************************************
    function _writeClassFile ($db_id, $table_id, $subsys_dir)
    // create the initial class file for this database table.
    {
        // read in skeleton class file
        $fname = $_SERVER['DOCUMENT_ROOT']
                .getParentDIR()
                .'/default/classes/default.class.inc';
        if (!$template = file_get_contents($fname)) {
            $this->errors[] = "Cannot read file $fname";
			return;
        } // if

		// insert database and table names into template
		$template = str_replace(array('#dbname#', '#tablename#'), array($db_id, $table_id), $template);

		$fname = $_SERVER['DOCUMENT_ROOT']
		        .getParentDIR()
		        .'/' .$subsys_dir .'/classes/' .$table_id .'.class.inc';

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
	            if (!preg_match('/^WIN/i', PHP_OS)) {
                	chmod($fname, 0664);
                } // if
	            $this->messages[] = getLanguageText('sys0093', $fname); // "Exported to $fname";
	        } // if
		} // if

        return;

    } // _writeClassFile

    // ****************************************************************************
    function _writeDictFile ($table_id, $subsys_dir)
    // write the contents of $this->text_out to a disk file.
    {
        $fname  = $_SERVER['DOCUMENT_ROOT'];
        $fname .= getParentDIR();
        $fname .= '/' .$subsys_dir .'/classes/' .$table_id .'.dict.inc';

        if (!$fp = fopen($fname, 'w')) {
            $this->errors[] = getLanguageText('sys0076', $fname); // "Cannot open file $fname";
        } else {
            $text = "<?php\n" .$this->text_out ."?>";
            if (fwrite($fp, $text) === false) {
                $this->errors[] = getLanguageText('sys0055', $fname); // "Cannot write to file $fname";
            } // if
            fclose($fp);
            if (!preg_match('/^WIN/i', PHP_OS)) {
            	chmod($fname, 0664);
            } // if
            $this->messages[] = getLanguageText('sys0093', $fname); // "Exported to $fname";
        } // if

        return;

    } // _writeDictFile

// ****************************************************************************
} // end class
// ****************************************************************************

?>
