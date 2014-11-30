<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_tbl.class.inc';
class audit_tbl_s02 extends audit_tbl
{
    // ****************************************************************************
    // this subtype is used in: audit_tbl(upd4).php
    // it is used to generate an SQL statement to reproduce the database change.
    // ****************************************************************************

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
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        $where = array2where($rowdata, $this->getPkeyNames());
        $pkey_array = where2array($rowdata['pkey']);

        // construct components of SQL string
        $output = "\nUSE `" .$rowdata['base_name'] ."`;\n\n";

        $dbobject =& RDCsingleton::getInstance('audit_fld');
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
        	    // previous values are all empty, so this could either be an INSERT or an UPDATE,
            	$mode = null;
            	// if the list of field names does not include the primary key the this is an UPDATE
            	foreach ($pkey_array as $keyname => $keyvalue) {
            		foreach ($field_data as $key => $value) {
            			if ($value['field_id'] == $keyname) {
            				$mode = 'insert';
            				break;
            			} // if
            		} // foreach
            		if (!empty($mode)) break;
            	} // foreach
            	if (empty($mode)) $mode = 'update';
            } elseif (count($field_data) == $new_null_count) {
                // new values are all empty, so this a DELETE
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
        			    $value_string = str_replace(chr(10), '\n', $value_string);
        	            $value_string = str_replace(chr(13), '\r', $value_string);
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
        			    $replace_string = str_replace(chr(10), '\n', $replace_string);
        	            $replace_string = str_replace(chr(13), '\r', $replace_string);
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
            $this->errors[] = $this->getLanguageText('sys0076', $fname); // 'Cannot open file $fname'
        } else {
            if (fwrite($fp, $output) === false) {
                $this->errors[] = $this->getLanguageText('sys0055', $fname); // 'Cannot write to file $fname'
            } // if
            fclose($fp);
            $this->messages[] = $this->getLanguageText('sys0093', $fname); // 'Data exported to $fname'
        } // if

        // do not display update count as there is none
        $this->no_display_count = true;

        // return an empty array as there is no database update
        return array();

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
