<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_column extends Default_Table
{
    // member variables
    var $colspecs = array();    // array of column specifications
    var $count;                 // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_column ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
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
        if ($GLOBALS['mode'] != 'search') {
            // these fields are 'noedit' when not in search mode
            $this->fieldspec['col_values']['noedit']            = 'y';
            $this->fieldspec['col_precision']['noedit']         = 'y';
            $this->fieldspec['col_scale']['noedit']             = 'y';
            $this->fieldspec['col_null']['noedit']              = 'y';
            $this->fieldspec['col_key']['noedit']               = 'y';
            $this->fieldspec['col_unsigned']['noedit']          = 'y';
            $this->fieldspec['col_auto_increment']['noedit']    = 'y';
            $this->fieldspec['col_array_type']['noedit']        = 'y';
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
        $type     = $fieldarray['col_type'];
        $colspecs = $this->_cm_getColSpecs($type, $fieldarray);

        if (preg_match('/(int|char)/i', $fieldarray['col_type'])) {
            if ($fieldarray['user_size'] == 1) {
                $fieldarray['col_type_native'] = $fieldarray['col_type'].',boolean';
            } // if
        } elseif (preg_match('/^(bit)$/i', $fieldarray['col_type'])) {
            $fieldarray['col_type_native'] = $fieldarray['col_type'].',boolean';
            $fieldarray['col_maxsize'] = 1;
            $fieldarray['user_size']   = 1;
        } // if

        if (preg_match('/^(enum|set)$/i', $type)) {
            unset($this->fieldspec['col_values']['nodisplay']);
        } else {
            $this->fieldspec['col_values']['nodisplay'] = 'y';
        } // if

        if (preg_match('/^(timestamp)$/i', $type)) {
            $fieldarray['col_auto_increment'] = 'Y';
        } // if

        if (preg_match('/^(array|varray)$/i', $type)) {
            unset($this->fieldspec['col_array_type']['nodisplay']);
        } else {
            $this->fieldspec['col_array_type']['nodisplay'] = 'y';
        } // if

        if (isset($colspecs['user_size'])) {
            unset($this->fieldspec['user_size']['nodisplay']);
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
            } else {
                unset($this->fieldspec['is_required']['noedit']);
            } // if
        } else {
            $fieldarray['is_required'] = $this->fieldspec['is_required']['false'];
        } // if
        if (isset($colspecs['noedit_nodisplay'])) {
            unset($this->fieldspec['noedit_nodisplay']['nodisplay']);
        } else {
            $fieldarray['noedit_nodisplay'] = null;
        } // if
        if (isset($colspecs['no_search'])) {
            unset($this->fieldspec['no_search']['nodisplay']);
        } else {
            $fieldarray['no_search'] = null;
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

        if ($fieldarray['col_key'] == 'PRI' OR $fieldarray['col_key'] == 'UNI') {
        	$fieldarray['auto_insert'] = $this->fieldspec['auto_insert']['false'];
        	$fieldarray['auto_update'] = $this->fieldspec['auto_update']['false'];
        } else {
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

        if (isset($colspecs['col_subtype'])) {
            unset($this->fieldspec['col_subtype']['nodisplay']);
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
            $fieldarray['col_subtype'] = null;
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
        if (isset($colspecs['optionlist']) AND !preg_match('/(checkbox)/i', $fieldarray['control'])) {
            unset($this->fieldspec['optionlist']['nodisplay']);
        } else {
            $fieldarray['optionlist'] = null;
        } // if
        if (isset($colspecs['checkbox_label'])) {
            unset($this->fieldspec['checkbox_label']['nodisplay']);
        } else {
            $fieldarray['checkbox_label'] = null;
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
            $this->fieldspec['align_hv']['nodisplay'] = 'y';
            $fieldarray['align_hv'] = null;
        } // if
        if (isset($colspecs['align_lr'])) {
            unset($this->fieldspec['align_lr']['nodisplay']);
        } else {
            $this->fieldspec['align_lr']['nodisplay'] = 'y';
            $fieldarray['align_lr'] = null;
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

        // some columns may offer a choice of types
        $col_types = $this->getValRep('col_type');
        if (strpos($fieldarray['col_type_native'], ',')) {
        	$type_array = explode(',', $fieldarray['col_type_native']);
        	// remove entries from $col_types which are not in $type_array
        	foreach ($col_types as $key => $value) {
        		if (!in_array($key, $type_array)) {
            	    unset($col_types[$key]);
            	} // if
        	} // foreach
        	unset($this->fieldspec['col_type']['noedit']);
        } else {
            $this->fieldspec['col_type']['noedit'] = 'y';
        } // if
        $this->lookup_data['col_type'] = $col_types;

        if ($fieldarray['col_type'] == 'boolean') {
            $fieldarray['is_boolean'] = 'Y';
        } else {
            $fieldarray['is_boolean']    = 'N';
            $fieldarray['boolean_true']  = null;
            $fieldarray['boolean_false'] = null;
        } // if

        return $fieldarray;

    } // _cm_checkColumnType

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $colspecs = $this->_ddl_getColumnSpecs();

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
            if (!preg_match('/(multiline|dropdown|multidrop)/i', $fieldarray['control'])) {
                // "Invalid unless CONTROL = 'multi-line', 'dropdown' or 'dropdown-multi'"
                $this->errors['multi_rows'] = getLanguageText('e0035');
            } // if
        } // if

        if (isset($fieldarray['col_type'])) {
            if ($fieldarray['col_type'] == 'boolean') {
            	if (isset($fieldarray['control'])) {
            	    if (preg_match('/(dropdown|radio|checkbox)/i', $fieldarray['control'])) {
            	    	// this is valid
            	    } else {
            	        // "If TYPE = 'boolean' CONTROL can only be 'dropdown' or 'radiogroup' or 'checkbox'"
            	        $this->errors['control'] = getLanguageText('e0003');
            	    } // if
            	} else {
            	    // default to 'radio group'
            	    $fieldarray['control'] = 'radio';
            	} // if
            	if (is_null($fieldarray['boolean_true'])) {
                    if (preg_match('/(int|bit)/i', $fieldarray['col_type_native'])) {
                        $fieldarray['boolean_true']  = '1';
                    } else {
            		    $fieldarray['boolean_true']  = 'Y';
                    } // if
            	} // if
            	if (is_null($fieldarray['boolean_false'])) {
                    if (preg_match('/(int|bit)/i', $fieldarray['col_type_native'])) {
            		    $fieldarray['boolean_false'] = '0';
                    } else {
                        $fieldarray['boolean_false'] = 'N';
                    } // if
            	} // if
                if ($fieldarray['col_type'] == 'boolean') {
                    $fieldarray['user_minvalue'] = null;
                    $fieldarray['user_maxvalue'] = null;
                } // if
            } // if
            if (preg_match('/int|double|float|number|numeric/i', $fieldarray['col_type'])) {
                if (is_null($fieldarray['user_minvalue'])) {
                    $fieldarray['user_minvalue'] = $fieldarray['col_minvalue'];
                } // if
                if (is_null($fieldarray['user_maxvalue'])) {
                    $fieldarray['user_maxvalue'] = $fieldarray['col_maxvalue'];
                } // if
            } // if
        } // if

        if (isset($fieldarray['col_subtype'])) {
            switch ($fieldarray['col_subtype']) {
            	case 'filename':
                    ;
                    break;
                case 'image':
            		if (!preg_match('/^(filepicker|imagehyper)$/i', $fieldarray['control'])) {
            		    // "Invalid unless CONTROL = 'filepicker' or 'image hyperlink'"
                        $this->errors['col_subtype'] = getLanguageText('e0004');
                    } // if
            		break;
            	case 'email':
            		;
            		break;
            	default:
            	    // "Unknown value for 'col_subtype'"
            		$this->errors['col_subtype'] = getLanguageText('e0005', $fieldarray['col_subtype']);
            } // switch
        } // if

        if (isset($fieldarray['custom_validation'])) {
            $array = explode('/', $fieldarray['custom_validation']);
            if (count($array) <> 3) {
                // "Invalid format for CUSTOM_VALIDATION - must be 'file/class/method'"
                $this->errors['custom_validation'] = getLanguageText('e0038');
            } // if
        } // if

        if (isset($fieldarray['image_width'])) {
            if ($fieldarray['control'] == 'image' OR $fieldarray['col_subtype'] == 'image') {
            	// this is valid
            } else {
                // "Invalid unless CONTROL = 'image' or SUBTYPE = 'image'"
                $this->errors['image_width'] = getLanguageText('e0006');
            } // if
        } // if
        if (isset($fieldarray['image_height'])) {
            if ($fieldarray['control'] == 'image' OR $fieldarray['col_subtype'] == 'image') {
                // this is valid
            } else {
                // "Invalid unless CONTROL = 'image' or SUBTYPE = 'image'"
                $this->errors['image_height'] = getLanguageText('e0006');
            } // if
        } // if

        if (isset($fieldarray['align_hv'])) {
            if (isset($this->fieldspec['align_hv']['nodisplay'])) {
                $fieldarray['align_hv'] = null;
            } else {
                if (!preg_match('/(radio|m_checkbox)/i', $fieldarray['control'])) {
                    // "Invalid unless CONTROL = 'radio group' or 'multi-checkbox'"
                    $this->errors['align_hv'] = getLanguageText('e0007');
                } // if
            } // if
        } // if
        if (isset($fieldarray['align_lr'])) {
            if (isset($this->fieldspec['align_lr']['nodisplay'])) {
                $fieldarray['align_lr'] = null;
            } else {
                if (preg_match('/(radio|checkbox|m_checkbox)/i', $fieldarray['control'])) {
                    // this is valid
                } else {
                    // "Invalid unless CONTROL = 'radio group', 'checkbox' or 'multi-checkbox'"
                    //$this->errors['align_lr'] = getLanguageText('e0030');
                    $fieldarray['align_lr'] = null;
                } // if
                if (preg_match('/(radio|checkbox)/i', $fieldarray['control'])) {
                    // skip the next bit
                } else {
                    if (empty($fieldarray['checkbox_label'])) {
                	    // "TEXT-ALIGN is invalid for CHECKBOX unless CHECKBOX_LABEL is set"
                        //$this->errors['align_lr'] = getLanguageText('e0033');
                        $fieldarray['align_lr'] = null;
                    } // if
                } // if
            } // if
        } // if
        if (isset($fieldarray['foreign_field'])) {
            if ($fieldarray['control'] != 'popup') {
                // "Invalid unless CONTROL = 'popup'"
                $this->errors['foreign_field'] = getLanguageText('e0008');
            } // if
            $count = preg_match_all('/\w+/', $fieldarray['foreign_field'], $regs);
            if ($count > 1) {
                // "This field can only contain a single word"
            	$this->errors['foreign_field'] = getLanguageText('e0039');
            } // if
        } // if
        if (isset($fieldarray['task_id'])) {
            if (preg_match('/(popup|filepicker)/i', $fieldarray['control'])) {
                // this combination is valid
            } else {
                // "Invalid unless CONTROL = 'popup' or 'filepicker'"
                $this->errors['task_id'] = getLanguageText('e0009');
            } // if
        } // if
        if (isset($fieldarray['optionlist'])) {
            if (preg_match('/(dropdown|multidrop|radio|m_checkbox)/i', $fieldarray['control'])) {
                // this is valid
            } else {
                // "Invalid unless CONTROL = 'dropdown', 'multidropdown', 'radio group' or 'multi-checkbox'"
                $this->errors['optionlist'] = getLanguageText('e0010');
            } // if
        } // if
        if (isset($fieldarray['checkbox_label'])) {
            if ($fieldarray['control'] != 'checkbox') {
                // "Invalid unless CONTROL = 'checkbox'"
                //$this->errors['checkbox_label'] = getLanguageText('e0032');
                $fieldarray['checkbox_label'] = null;
            } // if
        } // if

        if (isset($fieldarray['control'])) {
            switch ($fieldarray['control']) {
            	case 'dropdown':
            		if (!isset($fieldarray['optionlist'])) {
            		    if ($fieldarray['col_type'] == 'boolean') {
            		        // allowed to be empty, will default to 'boolean'
            		        $fieldarray['optionlist'] = 'boolean';
            		    } else {
            		        // "Required if CONTROL = 'dropdown'"
                            $this->errors['optionlist'] = getLanguageText('e0011');
            		    } // if
            		} // if
            		break;
            	case 'multidrop':
            		if (!isset($fieldarray['optionlist'])) {
            		    // "Required if CONTROL = 'dropdown' or 'multidrop'"
                        $this->errors['optionlist'] = getLanguageText('e0011');
            		} // if
            		break;
            	case 'radio':
            		if (!isset($fieldarray['optionlist'])) {
            		    if ($fieldarray['col_type'] == 'boolean') {
            		        // allowed to be empty, will default to 'boolean'
            		        $fieldarray['optionlist'] = 'boolean';
            		    } else {
            		        // "Required if CONTROL = 'radio group'"
            		        $this->errors['optionlist'] = getLanguageText('e0012');
            		    } // if
                    } // if
            		break;
            	case 'checkbox':
            		if ($fieldarray['col_type'] != 'boolean') {
        		        // "CONTROL cannot be 'checkbox' unless TYPE is 'boolean'"
        		        $this->errors['control'] = getLanguageText('e0031');
        		    } // if
            		break;
            	case 'm_checkbox':
            		if (!isset($fieldarray['optionlist'])) {
            		    // "Required if CONTROL = 'dropdown', 'multidrop' or 'multi-checkbox'"
                        $this->errors['optionlist'] = getLanguageText('e0011');
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
            	case 'hyperlink':
            	    $type = $fieldarray['col_type'];
            	    if ($colspecs[$type]['type'] != 'string') {
            		    // "CONTROL cannot be 'hyperlink' unless TYPE is 'string'"
                        $this->errors['control'] = getLanguageText('e0034');
                    } // if
            	    break;
            	case 'imagehyper':
            	    $type = $fieldarray['col_type'];
            	    if ($colspecs[$type]['type'] != 'string') {
            		    // "CONTROL cannot be 'image hyperlink' unless TYPE is 'string'"
                        $this->errors['control'] = getLanguageText('e0070');
                    } // if
            	    break;
            	case 'image':
            	    $type = $fieldarray['col_type'];
            	    if ($colspecs[$type]['type'] != 'string') {
            		    // "CONTROL cannot be 'image' unless TYPE is 'string'"
                        $this->errors['control'] = getLanguageText('e0071');
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
        // start with standard column specs for this type from the DBMS
        if (strpos($type, ',')) {
            // contains comma-separated list, so extract first entry
        	list($type) = explode(',', $type);
        } // if
        $colspecs = $this->colspecs[$type];

        // insert additional specifications based on column type

        // these are universal
        $colspecs['noedit_nodisplay']  = 'y';
        $colspecs['no_search']         = 'y';
        $colspecs['no_audit']          = 'y';
        $colspecs['is_required']       = 'y';
        $colspecs['custom_validation'] = 'y';

        // these are dependant on the column type
        switch ($colspecs['type']) {
        	case 'boolean':
        		$colspecs['boolean_true']   = '?';
                $colspecs['boolean_false']  = '?';
                $colspecs['is_required']    = 'y';
                $colspecs['control']        = '?';
                $colspecs['optionlist']     = '?';
                break;
            case 'bit':
                $colspecs['is_required']    = 'y';
                $colspecs['control']        = '?';
                $colspecs['optionlist']     = '?';
        		break;
        	case 'binary':
        	    $colspecs['user_size']           = 'y';
        	    break;
            case 'string':
                $colspecs['user_size']           = 'y';
                if ($fieldarray['user_size'] <= 255) {
                	$colspecs['upper_lowercase'] = 'y';
                    $colspecs['is_password']     = 'y';
                    $colspecs['auto_insert']     = 'y';
                    $colspecs['auto_update']     = 'y';
                    $colspecs['col_subtype']     = 'y';
                    $colspecs['image_width']     = '?';
                    $colspecs['image_height']    = '?';
                    $colspecs['control']         = '?';
                    $colspecs['optionlist']      = '?';
                    $colspecs['task_id']         = '?';
                    $colspecs['foreign_field']   = '?';
                    $colspecs['multi_cols']      = '?';
                    $colspecs['multi_rows']      = '?';
                } else {
                    $colspecs['control']         = '?';
                    $colspecs['multi_cols']      = '?';
                    $colspecs['multi_rows']      = '?';
                } // if
                break;
            case 'array':
            case 'set':
            case 'varray':
                $colspecs['control']        = '?';
                $colspecs['optionlist']     = '?';
                $colspecs['multi_rows']     = '?';
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
        	case 'timestamp':
                $colspecs['auto_insert']    = 'y';
                $colspecs['auto_update']    = 'y';
                break;
        	case 'interval':
        	    $colspecs['user_size']      = 'y';
        	    break;
            case 'numeric':
            case 'number':
        	    $colspecs['user_size']        = 'y';
                $colspecs['col_unsigned']     = 'y';
                $colspecs['col_zerofill_bwz'] = 'y';
                $colspecs['col_precision']    = '?';
                $colspecs['col_scale']        = '?';
                $colspecs['minvalue']         = '?';
                $colspecs['maxvalue']         = '?';
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
                $colspecs['auto_insert']        = 'y';
                $colspecs['auto_update']        = 'y';
                $colspecs['control']            = '?';
                $colspecs['optionlist']         = '?';
                $colspecs['task_id']            = '?';
                $colspecs['foreign_field']      = '?';
                $colspecs['minvalue']           = '?';
                $colspecs['maxvalue']           = '?';
                break;
        	case 'enum':
        	    $colspecs['control']          = '?';
                $colspecs['optionlist']       = '?';
                break;
            default:
        		break;
        } // switch

        if (isset($fieldarray['control'])) {
        	// these are dependant on the control type
            switch ($fieldarray['control']) {
            	case 'dropdown':
            	case 'multidrop':
                    $colspecs['multi_rows'] = 'y';
            	    break;
                case 'checkbox';
                    $colspecs['align_lr']       = 'y';
                    $colspecs['checkbox_label'] = 'y';
                    break;
            	case 'm_checkbox':
            	    $colspecs['align_lr']   = 'y';
            	    $colspecs['align_hv']   = 'y';
                    break;
                case 'radio':
                    $colspecs['align_lr']   = 'y';
                    $colspecs['align_hv']   = 'y';
            	default:
            	    break;
            } // switch
        } // if

        return $colspecs;

    } // _cm_getColSpecs

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('align_hv', $this->lookup_data)) {
            // get arrays to put into LOOKUP_DATA
            $array = $this->getValRep('align_hv');
            $this->lookup_data['align_hv'] = $array;

            $array = $this->getValRep('align_lr');
            $this->lookup_data['align_lr'] = $array;

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

            $array = $this->getValRep('no_audit');
            $this->lookup_data['no_audit'] = $array;

            $array = $this->getValRep('no_search');
            $this->lookup_data['no_search'] = $array;

            $array = $this->getValRep('col_subtype');
            $this->lookup_data['col_subtype'] = $array;

            $array = $this->getValRep('upper_lowercase');
            $this->lookup_data['upper_lowercase'] = $array;
        } // if

        if (!array_key_exists('database_id', $this->lookup_data)) {
            // get contents of foreign table DATABASE and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('dict_database');
            $array    = $dbobject->getValRep('database_id');
            $this->lookup_data['database_id'] = $array;
        } // if

        $pattern_id = getPatternId();

        if (preg_match('/^(list1)$/i', $pattern_id)
        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
                // set list of field names for QuickSearch option
                $array = array('database_id' => 'Database Id',
                               'table_id' => 'Table Id',
                               'column_id' => 'Column Id');
                $this->lookup_data['quicksearch_field'] = $array;
            } // if
        } // if

		return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        if ($item == 'align_hv') {
            return getLanguageArray('align_hv');
        } // if

        if ($item == 'align_lr') {
            return getLanguageArray('align_lr');
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

        if ($item == 'no_audit') {
            return getLanguageArray('no_audit');
        } // if

        if ($item == 'no_search') {
            return getLanguageArray('no_search');
        } // if

        if ($item == 'col_subtype') {
            return getLanguageArray('col_subtype');
        } // if

        if ($item == 'upper_lowercase') {
            return getLanguageArray('upper_lowercase');
        } // if

        return array();

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        // customisable code goes here
        if ($GLOBALS['mode'] == 'search') {
        	$this->colspecs = $this->_ddl_getColumnSpecs();
        	if (!array_key_exists('array', $this->colspecs)) {
        		$this->fieldspec['col_array_type']['nodisplay'] = 'y';
        	} // if
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['database_id'] = 'Total count:';
        $array['table_id'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        //DebugBreak();
        switch ($popupname) {
            // replace $where string for this popup
        	case 'dict_table(popup2)':
        		$where = "database_id='{$fieldarray['database_id']}'";
        		break;
        	default:
        		$where = '';
        } // switch

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        // find out if this column is named as an alias on DICT_TABLE entry
        $dbobject =& RDCsingleton::getInstance('dict_table');
        $data = $dbobject->getData("database_id='{$fieldarray['database_id']}' AND table_id='{$fieldarray['table_id']}'");
        if ($data) {
        	$data = $data[0];
        	if ($fieldarray['column_id'] == $data['nameof_start_date']) {
        	    // yes it is, so empty it
        		$data['nameof_start_date'] = null;
        		$data = $dbobject->updateRecord($data);
        	} // if
        	if ($fieldarray['column_id'] == $data['nameof_end_date']) {
        	    // yes it is, so empty it
        		$data['nameof_end_date'] = null;
        		$data = $dbobject->updateRecord($data);
        	} // if
        	if ($dbobject->errors) {
        		$this->errors = array_merge($this->errors, $dbobject->errors);
        	} // if
        } // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count++;
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // make all optional columns invisible (this may be reversed later)
        $this->fieldspec['user_size']['nodisplay']          = 'y';
        $this->fieldspec['col_auto_increment']['nodisplay'] = 'y';
        $this->fieldspec['col_unsigned']['nodisplay']       = 'y';
        $this->fieldspec['col_zerofill_bwz']['nodisplay']   = 'y';
        $this->fieldspec['is_required']['nodisplay']        = 'y';
        $this->fieldspec['noedit_nodisplay']['nodisplay']   = 'y';
        $this->fieldspec['no_search']['nodisplay']          = 'y';
        $this->fieldspec['upper_lowercase']['nodisplay']    = 'y';
        $this->fieldspec['is_password']['nodisplay']        = 'y';
        $this->fieldspec['auto_insert']['nodisplay']        = 'y';
        $this->fieldspec['auto_update']['nodisplay']        = 'y';
        $this->fieldspec['user_minvalue']['nodisplay']      = 'y';
        $this->fieldspec['user_maxvalue']['nodisplay']      = 'y';
        $this->fieldspec['col_precision']['nodisplay']      = 'y';
        $this->fieldspec['col_scale']['nodisplay']          = 'y';
        $this->fieldspec['infinityisnull']['nodisplay']     = 'y';
        $this->fieldspec['col_subtype']['nodisplay']        = 'y';
        $this->fieldspec['image_width']['nodisplay']        = 'y';
        $this->fieldspec['image_height']['nodisplay']       = 'y';
        $this->fieldspec['boolean_true']['nodisplay']       = 'y';
        $this->fieldspec['boolean_false']['nodisplay']      = 'y';
        $this->fieldspec['control']['nodisplay']            = 'y';
        $this->fieldspec['optionlist']['nodisplay']         = 'y';
        $this->fieldspec['checkbox_label']['nodisplay']     = 'y';
        $this->fieldspec['task_id']['nodisplay']            = 'y';
        $this->fieldspec['foreign_field']['nodisplay']      = 'y';
        $this->fieldspec['align_hv']['nodisplay']           = 'y';
        $this->fieldspec['align_lr']['nodisplay']           = 'y';
        $this->fieldspec['value_false']['nodisplay']        = 'y';
        $this->fieldspec['multi_cols']['nodisplay']         = 'y';
        $this->fieldspec['multi_rows']['nodisplay']         = 'y';
        $this->fieldspec['col_array_type']['nodisplay']     = 'y';

        if (count($rowdata) == 1) {
            $rowdata[0] = $this->_cm_checkColumnType($rowdata[0]);
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->colspecs)) {
        	// start with standard column specs for this DBMS
            $this->colspecs = $this->_ddl_getColumnSpecs();
        } // if

        // obtain any lookup data
        $array = $this->_cm_getExtraData($where, $where_array);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {
        $type = $fieldarray['col_type'];

        if ($fieldarray['col_type'] != $originaldata['col_type']) {
        	// column type has changed, so update maximum size
        	if (array_key_exists($type, $this->colspecs)) {
        	    if (array_key_exists('size', $this->colspecs[$type])) {
        	        if ($fieldarray['col_maxsize'] > $this->colspecs[$type]['size']) {
        	        	$fieldarray['col_maxsize'] = $this->colspecs[$type]['size'];
                    	$fieldarray['user_size']   = $this->colspecs[$type]['size'];
        	        } // if
        	    } // if
        	} // if
        } // if

        if ($fieldarray['col_maxsize'] == 0) {
        	$fieldarray['col_maxsize'] = $this->colspecs[$type]['size'];
        } // if
        if ($fieldarray['user_size'] == 0) {
        	$fieldarray['user_size'] = $fieldarray['col_maxsize'];
        } // if

        if (strlen($fieldarray['user_size']) > 0) {
            $user_value = (float)$fieldarray['user_size'];
            $col_value  = (float)$fieldarray['col_maxsize'];
            if ($user_value > $col_value) {
                // 'Cannot be greater than ' .$fieldarray['col_maxsize']
                $this->errors['user_size'] = getLanguageText('e0017', $fieldarray['col_maxsize']);
            } // if
        } // if
        if (strlen($fieldarray['user_minvalue']) > 0 AND strlen($fieldarray['col_minvalue']) > 0 ) {
            $user_value = (float)$fieldarray['user_minvalue'];
            $col_value  = (float)$fieldarray['col_minvalue'];
            if ($user_value < $col_value) {
                // 'Cannot be less than ' .$fieldarray['col_minvalue']
                $this->errors['user_minvalue'] = getLanguageText('e0018', $fieldarray['col_minvalue']);
            } // if
        } // if
        if (strlen($fieldarray['user_maxvalue']) > 0 AND strlen($fieldarray['col_maxvalue']) > 0 ) {
            $user_value = (float)$fieldarray['user_maxvalue'];
            $col_value  = (float)$fieldarray['col_maxvalue'];
            if ($user_value > $col_value) {
                // 'Cannot be greater than ' .$fieldarray['col_maxvalue']
                $this->errors['user_maxvalue'] = getLanguageText('e0017', $fieldarray['col_maxvalue']);
            } // if
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
