<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_column extends Default_Table
{
    // member variables
    var $colspecs = array();    // array of column specifications

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_column ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'dict_column';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // dict_column

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        global $mode;
        if ($mode != 'search') {
            // these fields are 'noedit' when not in search mode
            $this->fieldspec['col_values']['noedit']            = 'y';
            $this->fieldspec['col_precision']['noedit']         = 'y';
            $this->fieldspec['col_scale']['noedit']             = 'y';
            $this->fieldspec['col_null']['noedit']              = 'y';
            $this->fieldspec['col_key']['noedit']               = 'y';
            $this->fieldspec['col_unsigned']['noedit']          = 'y';
            $this->fieldspec['col_auto_increment']['noedit']    = 'y';
            $this->fieldspec['col_default']['noedit']           = 'y';
        } // if

        if ($GLOBALS['mode'] != 'search') {
			// do not replace database id with textual description
		    unset($this->fieldspec['database_id']['control']);
		} // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_checkColumnType ($fieldarray)
    // Make field visible if it is valid for this column type, and
    // initialise the value if it is not.
    {
        //DebugBreak();
        $type     = $fieldarray['col_type'];
        $colspecs = $this->_cm_getColSpecs($type, $fieldarray);

        if (eregi('(enum|set)', $type)) {
            unset($this->fieldspec['col_values']['nodisplay']);
        } else {
            $this->fieldspec['col_values']['nodisplay'] = 'y';
        } // if

        if (isset($colspecs['user_size'])) {
            unset($this->fieldspec['user_size']['nodisplay']);
        } else {
            if ($type == 'boolean') {
                // leave user_size alone
            } else {
                $fieldarray['user_size'] = null;
            } // if
        } // if

        if (isset($colspecs['col_auto_increment'])) {
            unset($this->fieldspec['col_auto_increment']['nodisplay']);
        } else {
            $fieldarray['col_auto_increment'] = $this->fieldspec['col_auto_increment']['false'];
        } // if
        if (isset($colspecs['col_unsigned'])) {
            unset($this->fieldspec['col_unsigned']['nodisplay']);
        } else {
            $fieldarray['col_unsigned'] = $this->fieldspec['col_unsigned']['false'];
        } // if
        if (isset($colspecs['col_zerofill_bwz'])) {
            unset($this->fieldspec['col_zerofill_bwz']['nodisplay']);
        } else {
            $fieldarray['col_zerofill_bwz'] = null;
        } // if

        if (isset($colspecs['is_required'])) {
            unset($this->fieldspec['is_required']['nodisplay']);
            if (isset($fieldarray['col_null']) and $fieldarray['col_null'] == 'N') {
            	$this->fieldspec['is_required']['noedit'] = 'Y';
            } // if
        } else {
            $fieldarray['is_required'] = $this->fieldspec['is_required']['false'];
        } // if
        if (isset($colspecs['noedit_nodisplay'])) {
            unset($this->fieldspec['noedit_nodisplay']['nodisplay']);
        } else {
            $fieldarray['noedit_nodisplay'] = null;
        } // if
        if (isset($colspecs['nosearch'])) {
            unset($this->fieldspec['nosearch']['nodisplay']);
        } else {
            $fieldarray['nosearch'] = null;
        } // if
        if (isset($colspecs['upper_lowercase'])) {
            unset($this->fieldspec['upper_lowercase']['nodisplay']);
        } else {
            $fieldarray['upper_lowercase'] = null;
        } // if
        if (isset($colspecs['is_password'])) {
            unset($this->fieldspec['is_password']['nodisplay']);
        } else {
            $fieldarray['is_password'] = $this->fieldspec['is_password']['false'];
        } // if
        if (isset($colspecs['auto_insert'])) {
            unset($this->fieldspec['auto_insert']['nodisplay']);
        } else {
            $fieldarray['auto_insert'] = $this->fieldspec['auto_insert']['false'];
        } // if
        if (isset($colspecs['auto_update'])) {
            unset($this->fieldspec['auto_update']['nodisplay']);
        } else {
            $fieldarray['auto_update'] = $this->fieldspec['auto_update']['false'];
        } // if
        if (isset($colspecs['minvalue'])) {
            unset($this->fieldspec['user_minvalue']['nodisplay']);
        } else {
            $fieldarray['user_minvalue'] = null;
        } // if
        if (isset($colspecs['maxvalue'])) {
            unset($this->fieldspec['user_maxvalue']['nodisplay']);
        } else {
            $fieldarray['user_maxvalue'] = null;
        } // if
        if (isset($colspecs['col_precision'])) {
            unset($this->fieldspec['col_precision']['nodisplay']);
        } else {
            $fieldarray['col_precision'] = null;
        } // if
        if (isset($colspecs['col_scale'])) {
            unset($this->fieldspec['col_scale']['nodisplay']);
        } else {
            $fieldarray['col_scale'] = null;
        } // if
        if (isset($colspecs['infinityisnull'])) {
            unset($this->fieldspec['infinityisnull']['nodisplay']);
        } else {
            $fieldarray['infinityisnull'] = $this->fieldspec['infinityisnull']['false'];
        } // if
        if (isset($colspecs['subtype'])) {
            unset($this->fieldspec['subtype']['nodisplay']);
            if (isset($colspecs['image_width'])) {
                unset($this->fieldspec['image_width']['nodisplay']);
            } else {
                $fieldarray['image_width'] = null;
            } // if
            if (isset($colspecs['image_height'])) {
                unset($this->fieldspec['image_height']['nodisplay']);
            } else {
                $fieldarray['image_height'] = null;
            } // if
        } else {
            $fieldarray['subtype'] = null;
            $fieldarray['image_width'] = null;
            $fieldarray['image_height'] = null;
        } // if

        if (isset($colspecs['boolean_true'])) {
            unset($this->fieldspec['boolean_true']['nodisplay']);
        } else {
            //$fieldarray['boolean_true'] = null;
        } // if
        if (isset($colspecs['boolean_false'])) {
            unset($this->fieldspec['boolean_false']['nodisplay']);
        } else {
            //$fieldarray['boolean_false'] = null;
        } // if

        if (isset($colspecs['control'])) {
            unset($this->fieldspec['control']['nodisplay']);
        } else {
            $fieldarray['control'] = null;
        } // if
        if (isset($colspecs['optionlist'])) {
            unset($this->fieldspec['optionlist']['nodisplay']);
        } else {
            $fieldarray['optionlist'] = null;
        } // if
        if (isset($colspecs['task_id'])) {
            unset($this->fieldspec['task_id']['nodisplay']);
        } else {
            $fieldarray['task_id'] = null;
        } // if
        if (isset($colspecs['foreign_field'])) {
            unset($this->fieldspec['foreign_field']['nodisplay']);
        } else {
            $fieldarray['foreign_field'] = null;
        } // if
        if (isset($colspecs['align_hv'])) {
            unset($this->fieldspec['align_hv']['nodisplay']);
        } else {
            $fieldarray['align_hv'] = null;
        } // if
        if (isset($colspecs['multi_cols'])) {
            unset($this->fieldspec['multi_cols']['nodisplay']);
        } else {
            $fieldarray['multi_cols'] = null;
        } // if
        if (isset($colspecs['multi_rows'])) {
            unset($this->fieldspec['multi_rows']['nodisplay']);
        } else {
            $fieldarray['multi_rows'] = null;
        } // if

        //DebugBreak();
        // column type may be changed in rare circumstances
        $this->fieldspec['col_type']['noedit'] = 'y';
        if (eregi('(char|tinyint|boolean)', $fieldarray['col_type'])) {
            if ($fieldarray['col_type'] == 'boolean') {
                // set this flag for future reference
                $fieldarray['is_boolean'] = $this->fieldspec['is_boolean']['true'];
            } elseif ($fieldarray['user_size'] == 1) {
                // provide the option to convert this field to BOOLEAN
                unset($this->fieldspec['col_type']['noedit']);
                $array = $this->lookup_data['col_type'];
                foreach ($array as $id => $value) {
                	if ($id == $fieldarray['col_type'] or $id == 'boolean') {
                	    // leave it in
                    } else {
                        // remove it
                        unset($array[$id]);
                	} // if
                } // foreach
                $this->lookup_data['col_type'] = $array;
            } else {
                $fieldarray['is_boolean']    = $this->fieldspec['is_boolean']['false'];
                $fieldarray['boolean_true']  = null;
                $fieldarray['boolean_false'] = null;
            } // if
        } else {
            $fieldarray['is_boolean']    = $this->fieldspec['is_boolean']['false'];
            $fieldarray['boolean_true']  = null;
            $fieldarray['boolean_false'] = null;
        } // if

        return $fieldarray;

    } // _cm_checkColumnType

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (!is_True($fieldarray['col_null'])) {
            if (!is_True($fieldarray['is_required'])) {
                // "If field is NOT NULL then 'is required' must be set"
                $this->errors['is_required'] = getLanguageText('e0001');
            } // if
        } // if
        if (isset($fieldarray['multi_cols'])) {
            if ($fieldarray['control'] != 'multiline') {
                // "Invalid unless CONTROL = 'multi-line'"
                $this->errors['multi_cols'] = getLanguageText('e0002');
            } // if
        } // if
        if (isset($fieldarray['multi_rows'])) {
            if ($fieldarray['control'] != 'multiline') {
                // "Invalid unless CONTROL = 'multi-line'"
                $this->errors['multi_rows'] = getLanguageText('e0002');
            } // if
        } // if

        if (isset($fieldarray['col_type'])) {
            if ($fieldarray['col_type'] == 'boolean') {
            	if (isset($fieldarray['control'])) {
            	    if ($fieldarray['control'] == 'dropdown' or $fieldarray['control'] == 'radiogroup') {
            	    	// this is valid
            	    } else {
            	        // "Can only be 'dropdown' or 'radiogroup' if TYPE = 'boolean'"
            	        $this->errors['control'] = getLanguageText('e0003');
            	    } // if
            	} // if
            } // if
        } // if

        if (isset($fieldarray['subtype'])) {
            switch ($fieldarray['subtype']) {
            	case 'filename':
                    ;
                    break;
                case 'image':
            		if ($fieldarray['control'] != 'filepicker') {
            		    // "Invalid unless CONTROL = 'filepicker'"
                        $this->errors['subtype'] = getLanguageText('e0004');
                    } // if
            		break;
            	case 'email':
            		;
            		break;
            	default:
            	    // "Unknown value for 'subtype'"
            		$this->errors['subtype'] = getLanguageText('e0005', $fieldarray['subtype']);
            } // switch
        } // if
        if (isset($fieldarray['image_width'])) {
            if ($fieldarray['subtype'] != 'image') {
                // "Invalid unless SUBTYPE = 'image'"
                $this->errors['image_width'] = getLanguageText('e0006');
            } // if
        } // if
        if (isset($fieldarray['image_height'])) {
            if ($fieldarray['subtype'] != 'image') {
                // "Invalid unless SUBTYPE = 'image'"
                $this->errors['image_height'] = getLanguageText('e0006');
            } // if
        } // if

        if (isset($fieldarray['align_hv'])) {
            if ($fieldarray['control'] != 'radio') {
                // "Invalid unless CONTROL = 'radio group'"
                $this->errors['align_hv'] = getLanguageText('e0007');
            } // if
        } // if
        if (isset($fieldarray['foreign_field'])) {
            if ($fieldarray['control'] != 'popup') {
                // "Invalid unless CONTROL = 'popup'"
                $this->errors['foreign_field'] = getLanguageText('e0008');
            } // if
        } // if
        if (isset($fieldarray['task_id'])) {
            if (eregi('(popup|filepicker)', $fieldarray['control'])) {
                // this combination is valid
            } else {
                // "Invalid unless CONTROL = 'popup' or 'filepicker'"
                $this->errors['task_id'] = getLanguageText('e0009');
            } // if
        } // if
        if (isset($fieldarray['optionlist'])) {
            if (eregi('(dropdown|radio)', $fieldarray['control'])) {
                // this is valid
            } else {
                // "Invalid unless CONTROL = 'dropdown' or 'radio group'"
                $this->errors['optionlist'] = getLanguageText('e0010');
            } // if
        } // if

        if (isset($fieldarray['control'])) {
            switch ($fieldarray['control']) {
            	case 'dropdown':
            		if (!isset($fieldarray['optionlist'])) {
            		    if ($fieldarray['col_type'] == 'boolean') {
            		        // allowed to be empty, will default to 'boolean'
            		    } else {
            		        // "Required if CONTROL = 'dropdown'"
                            $this->errors['optionlist'] = getLanguageText('e0011');
            		    } // if
                    } // if
            		break;
            	case 'radio':
            		if (!isset($fieldarray['optionlist'])) {
            		    if ($fieldarray['col_type'] == 'boolean') {
            		        // allowed to be empty, will default to 'boolean'
            		    } else {
            		        // "Required if CONTROL = 'radio group'"
            		        $this->errors['optionlist'] = getLanguageText('e0012');
            		    } // if
                    } // if
            		break;
            	case 'multiline':
            		if (!isset($fieldarray['multi_cols'])) {
            		    // "Required if CONTROL = 'multi-line'"
                        $this->errors['multi_cols'] = getLanguageText('e0013');
                    } // if
                    if (!isset($fieldarray['multi_rows'])) {
                        // "Required if CONTROL = 'multi-line'"
                        $this->errors['multi_rows'] = getLanguageText('e0013');
                    } // if
            		break;
            	case 'popup':
            		if (!isset($fieldarray['task_id'])) {
            		    // "Required if CONTROL = 'popup'"
                        $this->errors['task_id'] = getLanguageText('e0014');
                    } // if
                    if (!isset($fieldarray['foreign_field'])) {
                        // "Required if CONTROL = 'popup'"
                        $this->errors['foreign_field'] = getLanguageText('e0014');
                    } // if
            		break;
            	case 'filepicker':
            		if (!isset($fieldarray['task_id'])) {
            		    // "Required if CONTROL = 'file picker'"
                        $this->errors['task_id'] = getLanguageText('e0015');
                    } // if
            		break;
            	default:
            	    // "Unknown value for 'control'"
            		$this->errors['control'] = getLanguageText('e0016', $fieldarray['control']);
            } // switch
        } // if

        // initialise any fields which are not valid for this column type
        $fieldarray = $this->_cm_checkColumnType($fieldarray);

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getColSpecs ($type, $fieldarray)
    // get column specifications.
    {
        //DebugBreak();
        // start with standard column specs for this type from the DBMS
        $colspecs = $this->colspecs[$type];

        // insert additional specifications based on column type

        // these are universal
        $colspecs['noedit_nodisplay'] = 'y';
        $colspecs['nosearch']         = 'y';
        $colspecs['noaudit']          = 'y';
        $colspecs['is_required']      = 'y';

        // these are dependant on the column type
        switch ($colspecs['type']) {
        	case 'boolean':
        		$colspecs['boolean_true']  = '?';
                $colspecs['boolean_false'] = '?';
                $colspecs['is_required']   = 'y';
                $colspecs['control']       = '?';
                $colspecs['optionlist']    = '?';
        		break;
            case 'string':
                $colspecs['user_size']           = 'y';
                if ($fieldarray['user_size'] <= 255) {
                	$colspecs['upper_lowercase'] = 'y';
                    $colspecs['is_password']     = 'y';
                    $colspecs['auto_insert']     = 'y';
                    $colspecs['auto_update']     = 'y';
                    $colspecs['subtype']         = 'y';
                    $colspecs['image_width']     = '?';
                    $colspecs['image_height']    = '?';
                    $colspecs['control']         = '?';
                    $colspecs['optionlist']      = '?';
                    $colspecs['task_id']         = '?';
                    $colspecs['foreign_field']   = '?';
                    $colspecs['align_hv']        = '?';
                    $colspecs['multi_cols']      = '?';
                    $colspecs['multi_rows']      = '?';
                } else {
                    $colspecs['control']         = '?';
                    $colspecs['multi_cols']      = '?';
                    $colspecs['multi_rows']      = '?';
                } // if
                break;
        	case 'date':
                $colspecs['user_size']      = 'y';
                $colspecs['infinityisnull'] = 'y';
                $colspecs['auto_insert']    = 'y';
                $colspecs['auto_update']    = 'y';
                break;
        	case 'time':
                $colspecs['user_size']      = 'y';
                $colspecs['auto_insert']    = 'y';
                $colspecs['auto_update']    = 'y';
                break;
        	case 'datetime':
                $colspecs['user_size']      = 'y';
                $colspecs['infinityisnull'] = 'y';
                $colspecs['auto_insert']    = 'y';
                $colspecs['auto_update']    = 'y';
                break;
        	case 'numeric':
        	case 'float':
                $colspecs['user_size']        = 'y';
                $colspecs['col_unsigned']     = 'y';
                $colspecs['col_zerofill_bwz'] = 'y';
                $colspecs['col_precision']    = '?';
                $colspecs['col_scale']        = '?';
                $colspecs['minvalue']         = '?';
                $colspecs['maxvalue']         = '?';
                break;
        	case 'integer':
                $colspecs['user_size']          = 'y';
                $colspecs['col_auto_increment'] = 'y';
                $colspecs['col_unsigned']       = 'y';
                $colspecs['col_zerofill_bwz']   = 'y';
                $colspecs['control']            = '?';
                $colspecs['optionlist']         = '?';
                $colspecs['align_hv']           = '?';
                $colspecs['task_id']            = '?';
                $colspecs['foreign_field']      = '?';
                $colspecs['minvalue']           = '?';
                $colspecs['maxvalue']           = '?';
                break;
        	case 'enum':
            case 'set':
                $colspecs['control']          = '?';
                $colspecs['optionlist']       = '?';
                break;
        	default:
        		break;
        } // switch

        return $colspecs;

    } // _cm_getColSpecs

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if (empty($this->lookup_data)) {
            // get arrays to put into LOOKUP_DATA
            $array = $this->getValRep('align_hv');
            $this->lookup_data['align_hv'] = $array;

            $array = $this->getValRep('auto_insert');
            $this->lookup_data['auto_insert'] = $array;

            $array = $this->getValRep('auto_update');
            $this->lookup_data['auto_update'] = $array;

            $array = $this->getValRep('col_auto_increment');
            $this->lookup_data['col_auto_increment'] = $array;

            $array = $this->getValRep('col_key');
            $this->lookup_data['col_key'] = $array;

            $array = $this->getValRep('col_null');
            $this->lookup_data['col_null'] = $array;

            $array = $this->getValRep('col_type');
            $this->lookup_data['col_type'] = $array;

            $array = $this->getValRep('col_unsigned');
            $this->lookup_data['col_unsigned'] = $array;

            $array = $this->getValRep('col_zerofill_bwz');
            $this->lookup_data['col_zerofill_bwz'] = $array;

            $array = $this->getValRep('control');
            $this->lookup_data['control'] = $array;

            $array = $this->getValRep('infinityisnull');
            $this->lookup_data['infinityisnull'] = $array;

            $array = $this->getValRep('is_required');
            $this->lookup_data['is_required'] = $array;

            $array = $this->getValRep('is_password');
            $this->lookup_data['is_password'] = $array;

            $array = $this->getValRep('noedit_nodisplay');
            $this->lookup_data['noedit_nodisplay'] = $array;

            $array = $this->getValRep('noaudit');
            $this->lookup_data['noaudit'] = $array;

            $array = $this->getValRep('nosearch');
            $this->lookup_data['nosearch'] = $array;

            $array = $this->getValRep('subtype');
            $this->lookup_data['subtype'] = $array;

            $array = $this->getValRep('upper_lowercase');
            $this->lookup_data['upper_lowercase'] = $array;

            // get contents of foreign table DATABASE and add as a LOOKUP list
            require_once 'dict_database.class.inc';
            $dbobject =& singleton::getInstance('dict_database');
            $array    = $dbobject->getValRep('database_id');
            $this->lookup_data['database_id'] = $array;
        } // if

		return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where=null)
    // get Value/Representation list as an associative array.
    {
        if ($item == 'align_hv') {
            return getLanguageArray('align_hv');
        } // if

        if ($item == 'auto_insert') {
            return getLanguageArray('auto_insert');
        } // if

        if ($item == 'auto_update') {
            return getLanguageArray('auto_update');
        } // if

        if ($item == 'column_id') {
            // get data from the database
            $this->sql_select     = 'column_id, column_desc';
            $this->sql_orderby    = 'column_seq';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where);

            // convert each row into 'id=id' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[0];
            } // foreach

            return $array;

        } // if

        if ($item == 'col_auto_increment') {
            return getLanguageArray('col_auto_increment');
        } // if

        if ($item == 'col_key') {
            return getLanguageArray('col_key');
        } // if

        if ($item == 'col_null') {
            return getLanguageArray('col_null');
        } // if

        if ($item == 'col_type') {
            $colspecs = $this->_ddl_getColumnSpecs();
            foreach ($colspecs as $id => $spec) {
                $array[$id] = $spec['name'];
            } // foreach
            return $array;
        } // if

        if ($item == 'col_unsigned') {
            return getLanguageArray('col_unsigned');
        } // if

        if ($item == 'col_zerofill_bwz') {
            return getLanguageArray('col_zerofill_bwz');
        } // if

        if ($item == 'control') {
            return getLanguageArray('control');
        } // if

        if ($item == 'infinityisnull') {
            return getLanguageArray('infinityisnull');
        } // if

        if ($item == 'is_required') {
            return getLanguageArray('is_required');
        } // if

        if ($item == 'is_password') {
            return getLanguageArray('is_password');
        } // if

        if ($item == 'noedit_nodisplay') {
            return getLanguageArray('noedit_nodisplay');
        } // if

        if ($item == 'noaudit') {
            return getLanguageArray('noaudit');
        } // if

        if ($item == 'nosearch') {
            return getLanguageArray('nosearch');
        } // if

        if ($item == 'subtype') {
            return getLanguageArray('subtype');
        } // if

        if ($item == 'upper_lowercase') {
            return getLanguageArray('upper_lowercase');
        } // if

        return array();

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        //DebugBreak();
        switch ($popupname) {
            // replace $where string for this popup
        	case 'dict_table(popup)':
        		$where = "database_id='{$fieldarray['database_id']}'";
        		break;
        	default:
        		;
        } // switch

        // ensure that only one entry can be selected
        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        // make all optional columns invisible
        $this->fieldspec['user_size']['nodisplay']          = 'y';
        $this->fieldspec['col_auto_increment']['nodisplay'] = 'y';
        $this->fieldspec['col_unsigned']['nodisplay']       = 'y';
        $this->fieldspec['col_zerofill_bwz']['nodisplay']   = 'y';
        $this->fieldspec['is_required']['nodisplay']        = 'y';
        $this->fieldspec['noedit_nodisplay']['nodisplay']   = 'y';
        $this->fieldspec['nosearch']['nodisplay']           = 'y';
        $this->fieldspec['upper_lowercase']['nodisplay']    = 'y';
        $this->fieldspec['is_password']['nodisplay']        = 'y';
        $this->fieldspec['auto_insert']['nodisplay']        = 'y';
        $this->fieldspec['auto_update']['nodisplay']        = 'y';
        $this->fieldspec['user_minvalue']['nodisplay']      = 'y';
        $this->fieldspec['user_maxvalue']['nodisplay']      = 'y';
        $this->fieldspec['col_precision']['nodisplay']      = 'y';
        $this->fieldspec['col_scale']['nodisplay']          = 'y';
        $this->fieldspec['infinityisnull']['nodisplay']     = 'y';
        $this->fieldspec['subtype']['nodisplay']            = 'y';
        $this->fieldspec['image_width']['nodisplay']        = 'y';
        $this->fieldspec['image_height']['nodisplay']       = 'y';
        $this->fieldspec['boolean_true']['nodisplay']       = 'y';
        $this->fieldspec['boolean_false']['nodisplay']      = 'y';
        $this->fieldspec['control']['nodisplay']            = 'y';
        $this->fieldspec['optionlist']['nodisplay']         = 'y';
        $this->fieldspec['task_id']['nodisplay']            = 'y';
        $this->fieldspec['foreign_field']['nodisplay']      = 'y';
        $this->fieldspec['align_hv']['nodisplay']           = 'y';
        $this->fieldspec['value_false']['nodisplay']        = 'y';
        $this->fieldspec['multi_cols']['nodisplay']         = 'y';
        $this->fieldspec['multi_rows']['nodisplay']         = 'y';

        if (count($rowdata) == 1) {
            $rowdata[0] = $this->_cm_checkColumnType($rowdata[0]);
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        // start with standard column specs for this DBMS
        $this->colspecs = $this->_ddl_getColumnSpecs();

        // obtain any lookup data
        $array = $this->_cm_getExtraData($where, $where_array);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {
        //DebugBreak();
        if (strlen($fieldarray['user_size']) > 0) {
            $user_value = (float)$fieldarray['user_size'];
            $col_value  = (float)$fieldarray['col_maxsize'];
            if ($user_value > $col_value) {
                // 'Cannot be greater than ' .$fieldarray['col_maxsize']
                $this->errors['user_size'] = getLanguageText('e0017', $fieldarray['col_maxsize']);
            } // if
        } // if
        if (strlen($fieldarray['user_minvalue']) > 0) {
            $user_value = (float)$fieldarray['user_minvalue'];
            $col_value  = (float)$fieldarray['col_minvalue'];
            if ($user_value < $col_value) {
                // 'Cannot be less than ' .$fieldarray['col_minvalue']
                $this->errors['user_minvalue'] = getLanguageText('e0018', $fieldarray['col_minvalue']);
            } // if
        } // if
        if (strlen($fieldarray['user_maxvalue']) > 0) {
            $user_value = (float)$fieldarray['user_maxvalue'];
            $col_value  = (float)$fieldarray['col_maxvalue'];
            if ($user_value > $col_value) {
                // 'Cannot be greater than ' .$fieldarray['col_maxvalue']
                $this->errors['user_maxvalue'] = getLanguageText('e0017', $fieldarray['col_maxvalue']);
            } // if
        } // if

        if ($fieldarray['col_type'] == 'boolean') {
            $fieldarray['is_boolean'] = $this->fieldspec['is_boolean']['true'];
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
