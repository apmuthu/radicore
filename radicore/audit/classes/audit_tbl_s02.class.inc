<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_tbl.class.inc';
class audit_tbl_s02 extends audit_tbl
{
    // ****************************************************************************
    // this subtype is used in: audit_tbl(upd4).php
    // it is used to generate an SQL statement to reproduce the database change.
    // ****************************************************************************

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        $rowdata = $rows[0];

        $pkey_array = where2array($rowdata['pkey']);

        // construct components of SQL string
        $output = "\nuse `" .$rowdata['base_name'] ."`;\n\n";

        $dbobject =& singleton::getInstance('audit_fld');
        $field_data = $dbobject->getData_raw($where);
        // split $field_data into $old_array and $new_array
        $old_array = array();
        $new_array = array();
        $old_null_count = 0;
        $new_null_count = 0;
        foreach ($field_data as $data) {
        	$old_array[$data['field_id']] = $data['old_value'];
        	if (empty($data['old_value'])) {
        		$old_null_count ++;
        	} // if
        	$new_array[$data['field_id']] = $data['new_value'];
        	if (empty($data['new_value'])) {
        		$new_null_count ++;
        	} // if
        } // foreach

        if (count($field_data) > 0) {
        	if (count($field_data) == $old_null_count) {
            	$mode = 'insert';
            } elseif (count($field_data) == $new_null_count) {
            	$mode = 'delete';
            } else {
                $mode = 'update';
            } // if
        } else {
            $mode = 'delete';
        } // if

        switch ($mode) {
        	case 'insert':
        	    $name_string  = null;
        	    $value_string = null;
        	    foreach ($new_array as $field => $value) {
        			$name_string  .= "`$field` ,";
        			if (empty($value)) {
        				$value_string .= "NULL ,";
        			} else {
        			    $value_string .= "'" .addslashes($value) ."' ,";
        			} // if
        		} // foreach
        		$name_string  = rtrim($name_string, ', ');
        		$value_string = rtrim($value_string, ', ');
        		$output .= "REPLACE INTO `{$rowdata['table_name']}` ($name_string) ";
        		$output .= "VALUES\n";
        		$output .= "($value_string);\n";
        		break;

        	case 'update':
                $replace_string = 'SET ';
                foreach ($new_array as $field => $value) {
        			$replace_string .= "`$field`=";
        			if (empty($value)) {
        				$replace_string .= 'NULL';
        			} else {
        			    $replace_string .= "'" .addslashes($value) ."'";
        			} // if
        			$replace_string .= " ,";
        		} // foreach
        		$replace_string = rtrim($replace_string, ', ');
                $output .= "UPDATE `{$rowdata['table_name']}` $replace_string WHERE {$rowdata['pkey']};\n";
        		break;

        	case 'delete':
        		$output .= "DELETE FROM `{$rowdata['table_name']}` WHERE {$rowdata['pkey']};\n";
        		break;

        	default:
        		break;
        } // switch

        $fname = './sql/audit_export.sql';
        if (!$fp = fopen($fname, 'a+')) {
            $this->errors[] = getLanguageText('sys0076', $fname); // 'Cannot open file $fname'
        } else {
            if (fwrite($fp, $output) === false) {
                $this->errors[] = getLanguageText('sys0055', $fname); // 'Cannot write to file $fname'
            } // if
            fclose($fp);
            $this->messages[] = getLanguageText('sys0093', $fname); // 'Data exported to $fname'
        } // if

        $rows[0] = $rowdata;
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
        $this->sql_select  = 'audit_tbl.*';
        $this->sql_from    = 'audit_tbl';

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
