<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_database.class.inc';
class dict_dataBase_s02 extends dict_dataBase
{
    // ****************************************************************************
    // This class is used to export all the details of an application database
    // from the dictionary to an SQL file so that they may be reloaded.
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
		// create object for retrieving table details
        require_once 'dict_table.class.inc';
        $tableobj =& singleton::getInstance('dict_table');

        // process each subsystem separately
        foreach ($rowdata as $row => $database_data) {

            $database_id = $database_data['database_id'];
            $subsys_dir  = $database_data['subsys_dir'];
            unset($database_data['subsys_dir']);

			$output = '-- file created on ' .date('F j, Y, g:i a') ."\r\n\r\n";

			$output = $this->_exportSqlData('dict_database', $database_data, $output);

            // export contents of DICT_TABLE for this database
        	$tableobj->sql_select = '*';
        	$tableobj->sql_from   = 'dict_table';
        	$tableobj->sql_orderby = 'table_id';
            $table_data = $tableobj->getData_raw("database_id='$database_id'");

            // process each table one at a time
            foreach ($table_data as $row => $data) {
                $table_id = $data['table_id'];
            	$output = $this->_exportSqlData('dict_table', $data, $output);

            	// export contents of DICT_TABLE_KEY for this database table
            	$tableobj->sql_select = '*';
            	$tableobj->sql_from   = 'dict_table_key';
            	$tableobj->sql_orderby = 'table_id,key_name,seq_in_index';
                $data = $tableobj->getData_raw("database_id='$database_id' AND table_id='$table_id'");
                $output = $this->_exportSqlData('dict_table_key', $data, $output);

                // export contents of DICT_COLUMN for this database
            	$tableobj->sql_select = '*';
            	$tableobj->sql_from   = 'dict_column';
            	$tableobj->sql_orderby = 'table_id,column_seq';
                $data = $tableobj->getData_raw("database_id='$database_id' AND table_id='$table_id'");
                $output = $this->_exportSqlData('dict_column', $data, $output);

                // export contents of DICT_RELATIONSHIP for this database
            	$tableobj->sql_select = '*';
            	$tableobj->sql_from   = 'dict_relationship';
            	$tableobj->sql_orderby = 'database_id_jnr,table_id_jnr,seq_no';
                $data = $tableobj->getData_raw("database_id_snr='$database_id' AND table_id_snr='$table_id'");
                foreach ($data as $reldata) {
                	$output = $this->_exportSqlData('dict_relationship', $reldata, $output);
                	// export contents of DICT_RELATED_COLUMN for this table
                	$db_id_jnr  = $reldata['database_id_jnr'];
                	$tbl_id_jnr = $reldata['table_id_jnr'];
                	$seq_no     = $reldata['seq_no'];
                    $tableobj->sql_select = '*';
                	$tableobj->sql_from   = 'dict_related_column';
                	$tableobj->sql_orderby = 'column_id_snr,database_id_jnr,table_id_jnr,seq_no';
                    $data = $tableobj->getData_raw("database_id_snr='$database_id' AND table_id_snr='$table_id' AND database_id_jnr='$db_id_jnr' AND table_id_jnr='$tbl_id_jnr' AND seq_no='$seq_no'");
                    $output = $this->_exportSqlData('dict_related_column', $data, $output);
                } // foreach
            } // foreach

            $output .= "-- finished\r\n";

            // write completed text file to disk
            $this->_writeTextFile ($output, $database_id, "$subsys_dir/sql");

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

		if (empty($this->sql_select)) {
            // obtain SUBSYS_DIR from MNU_SUBSYSTEM
            $this->sql_select = 'dict_database.*, subsys_dir';
            $this->sql_from   = 'dict_database '
                               .'LEFT JOIN ' .$dbprefix .'menu.mnu_subsystem USING (subsys_id)';
        } // if

        return $where;

    } // _cm_pre_getData

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
    function _writeTextFile ($text, $database_id, $subsys_dir)
    // write the contents of $text to a disk file.
    {
        //DebugBreak();
        $sname = $subsys_dir .'/' .strtolower($database_id) .'.dict_export.sql';
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
