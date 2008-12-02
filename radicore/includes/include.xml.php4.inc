<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains functions related to XML and XSL for use with PHP 4

// ****************************************************************************
function addData2XMLdoc ($doc, $root, $parent, $dbobject, &$errors)
// add contents of object's data array to current XML document.
// NOTE: $parent may or may not be the same as $root.
// NOTE: $errors is passed BY REFERENCE as it may be updated.
{
    if (!is_object($dbobject)) {
        return; // something is wrong, so stop now
    } // if

    global $screen_structure;

    // get object name to use as node name in XML file
    if (eregi('filepicker|fileupload', getPatternId())) {
    	$objectname = getPatternId();
    } else {
        $objectname = $dbobject->getClassName();
    } // if

    if (empty($errors)) {
        // array is empty
        $errors = array();
    } elseif (is_string($errors)) {
        // set string to apply to row zero
        $errors = (array)$errors;
	} // if

    if (array_key_exists($objectname, $errors)) {
        // extract errors for this object only
        $object_errors = $errors[$objectname];
		unset($errors[$objectname]);
		if (is_string(key($object_errors))) {
			// not indexed by row, so set to row zero
		    $array[] = $object_errors;
			$object_errors = $array;
		} // if
		foreach ($object_errors as $row => $row_errors) {
			// deal with errors for fields which are not actually displayed
    		$object_errors[$row] = filterErrors($row_errors, $objectname, $errors[$row], $screen_structure);
		} // foreach
    } else {
		// no errors for current object
        $object_errors = array();
    } // if

    // get field access details for current object
    $dbobject->setFieldAccess();

    // get field specifications for current object (inluding field access details)
    $fieldspec = $dbobject->getFieldSpec();

    // get data array for current object (indexed by rownum)
    $objectdata = $dbobject->getFieldArray();

    // process the data one row at a time
    foreach ($objectdata as $rownum => $rowdata) {
        // add a node to identify the name of this database table
        $node = $doc->create_element(strtolower($objectname));
        $node = $parent->append_child($node);
        if (!is_array($rowdata)) {
            // this is not an array, so output as data now

            $rowdata = convertEncoding($rowdata, 'UTF-8');

            // insert as text element for the current node
            $value = $doc->create_text_node($rowdata);
            $value = $node->append_child($value);
        } else {
            // look for optional attributes just for this row
            if (array_key_exists('rdc_rowspecs', $rowdata)) {
            	foreach ($rowdata['rdc_rowspecs'] as $key => $value) {
            		$node->set_attribute($key, $value);
            	} // foreach
                unset($rowdata['rdc_rowspecs']);
            } // if
            $css_array = array();  // optional css class specifications
        	// format data for output (this converts dates and numbers)
            $rowdata = $dbobject->formatData($rowdata, $css_array);
            // add a child node for each field
            foreach ($rowdata as $fieldname => $fieldvalue) {
                $child = $doc->create_element($fieldname);
                $child = $node->append_child($child);
                if (array_key_exists($fieldname, $css_array)) {
                    // include css class name(s)
                	$child->set_attribute('css_class', $css_array[$fieldname]);
                } // if
                if (isset($fieldspec[$fieldname])) {
                    // field exists in $fieldspec, so get field specifications
                    $spec = array_change_key_case($fieldspec[$fieldname], CASE_LOWER);
                    // add field size as an attribute
                    if (isset($spec['size'])) {
                        $child->set_attribute('size', $spec['size']);
                    } // if

                    // look for 'noedit' attribute
                    if (isset($spec['noedit'])) {
                        $child->set_attribute('noedit', 'y');
                    } else {
                        // look for primary key attribute
                        if (isset($spec['pkey'])) {
                            $child->set_attribute('pkey', 'y');
                        } // if
                        if (isset($spec['required'])) {
                            $child->set_attribute('required', 'y');
                        } // if
                        // option for password fields
                        if (isset($spec['password'])) {
                            $child->set_attribute('password', 'y');
                        } // if
                    } // if

                    // look for nodisplay attribute (value is not contained within form)
                    if (isset($spec['nodisplay'])) {
                        $child->set_attribute('nodisplay', 'y');
                        $fieldvalue = '**hidden**';
                    } else {
                        // if an error message exists put it into the error attribute
                        if (!empty($object_errors)) {
                            if (array_key_exists($rownum, $object_errors) and is_array($object_errors[$rownum])) {
                                if (array_key_exists($fieldname, $object_errors[$rownum])) {
                                    $child->set_attribute('error', $object_errors[$rownum][$fieldname]);
                                    unset($object_errors[$rownum][$fieldname]);
                                } // if
                            } // if
                        } // if
                    } // if

                    if (isset($spec['type'])) {
                        if ($spec['type'] == 'boolean') {
                            if (!isset($spec['control'])) {
                                // no 'control' set, so default to radiogroup
                            	$spec['control'] = 'radiogroup';
                            } // if
                            if (!isset($spec['optionlist'])) {
                                // no 'optionlist' set, so default to $fieldname
                            	$spec['optionlist'] = $fieldname;
                            } // if
                            $optionlist = $spec['optionlist'];
                            if (isset($dbobject->lookup_data[$optionlist])) {
                                $lookup = $dbobject->lookup_data[$optionlist];
                            } else {
                        	    // no list set, so use default (true=Yes, false=No)
                        		$lookup = getLanguageArray('boolean');
                            } // if
                            // ensure 'true' and 'false' are set to field specifications
                            $lookup = fixTrueFalseArray($lookup, $spec);
                            // now put back into object's internal data
                        	$dbobject->lookup_data[$optionlist] = $lookup;
                        } // if
                    } // if

                    if (isset($spec['control'])) {
                        // option for hidden field (contained within form but not shown)
                        if ($spec['control'] == 'hidden') {
                            $child->set_attribute('control', 'hidden');
                        } // if
                        // option for dropdown fields
                        if ($spec['control'] == 'dropdown') {
                            $child->set_attribute('control', 'dropdown');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['rows'])) {
                            	$child->set_attribute('rows', $spec['rows']);
                            } // if
                        } // if
                        // option for multi-dropdown fields
                        if ($spec['control'] == 'multidrop') {
                            $child->set_attribute('control', 'multidrop');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['rows'])) {
                            	$child->set_attribute('rows', $spec['rows']);
                            } // if
                        } // if
                        // option for filename fields
                        if ($spec['control'] == 'filepicker') {
                            $child->set_attribute('control', 'filepicker');
                            if (isset($spec['task_id'])) {
                                $child->set_attribute('task_id', "task#{$spec['task_id']}");
                            } // if
                            if (isset($spec['subtype']) and $spec['subtype'] == 'image') {
                                $child->set_attribute('image', 'y');
                                if (isset($spec['imagewidth'])) {
                                    $child->set_attribute('imagewidth', $spec['imagewidth']);
                                } // if
                                if (isset($spec['imageheight'])) {
                                    $child->set_attribute('imageheight', $spec['imageheight']);
                                } // if
                            } // if
                            if (isset($spec['notext'])) {
                                // display the image without any filename text
                                $child->set_attribute('notext', "{$spec['notext']}");
                            } // if
                        } // if
                        // options for multiline fields
                        if ($spec['control'] == 'multiline') {
                            $child->set_attribute('control', 'multiline');
                            $child->set_attribute('cols', $spec['cols']);
                            $child->set_attribute('rows', $spec['rows']);
                        } // if
                        // option for popup fields
                        if ($spec['control'] == 'popup') {
                            $child->set_attribute('control', 'popup');
                            if (isset($spec['foreign_field'])) {
                                $child->set_attribute('foreign_field', $spec['foreign_field']);
                            } // if
                            if (isset($spec['task_id'])) {
                                $child->set_attribute('task_id', "task#{$spec['task_id']}");
                            } // if
                            if (isset($spec['allow_input'])) {
                                $child->set_attribute('allow_input', $spec['allow_input']);
                            } // if
                        } // if
                        // option for radio buttons
                        if ($spec['control'] == 'radiogroup' or $spec['control'] == 'radio') {
                            $child->set_attribute('control', 'radiogroup');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['align_hv'])) {
                            	$child->set_attribute('align_hv', strtolower($spec['align_hv']));
                            } // if
                            if (isset($spec['align_lr'])) {
                            	$child->set_attribute('align_lr', strtolower($spec['align_lr']));
                            } // if
                        } // if
                        // option for a single checkbox
                        if ($spec['control'] == 'checkbox') {
                            $child->set_attribute('control', 'checkbox');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['label'])) {
                                $spec['label'] = convertEncoding($spec['label'], 'UTF-8');
                            	$child->set_attribute('label', $spec['label']);
                            } // if
                            if (isset($spec['align_lr'])) {
                            	$child->set_attribute('align_lr', strtolower($spec['align_lr']));
                            } // if
                        } // if
                        // option for multiple checkboxes
                        if ($spec['control'] == 'm_checkbox' OR $spec['control'] == 'checkbox_multi') {
                            $child->set_attribute('control', 'checkbox_multi');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['align_hv'])) {
                            	$child->set_attribute('align_hv', strtolower($spec['align_hv']));
                            } // if
                            if (isset($spec['align_lr'])) {
                            	$child->set_attribute('align_lr', strtolower($spec['align_lr']));
                            } // if
                        } // if
                        // option for hyperlink
                        if ($spec['control'] == 'hyperlink') {
                            $child->set_attribute('control', 'hyperlink');
                        } // if
                    } // if

                    // option for javascript events
                    if (isset($spec['javascript'])) {
                        foreach ($spec['javascript'] as $event_name => $event_body) {
                        	$child->set_attribute($event_name, $event_body);
                        } // foreach
                    } // if
                } else {
                    // field does not exist in $fieldspec, so make it non-editable
                    $child->set_attribute('noedit', 'y');
                    // if an error message exists put it into the error attribute
                    if (!empty($object_errors)) {
                        if (array_key_exists($rownum, $object_errors) and is_array($object_errors[$rownum])) {
                            if (array_key_exists($fieldname, $object_errors[$rownum])) {
                                $child->set_attribute('error', $object_errors[$rownum][$fieldname]);
                                unset($object_errors[$rownum][$fieldname]);
                            } // if
                        } // if
                    } // if
                } // if

                if (is_array($fieldvalue)) {
                    // output each entry as a separate child node
                    foreach ($fieldvalue as $entry) {
                    	$array_value = $doc->create_element('array');
                        $array_value = $child->append_child($array_value);
                        $array_value->set_attribute('id', $entry);
                        //$value = $doc->create_text_node($entry);
                        //$value = $array_value->append_child($value);
                    } // foreach
                } else {
                    $fieldvalue = convertEncoding($fieldvalue, 'UTF-8');

                    // insert as text element for the current node
                    $value = $doc->create_text_node($fieldvalue);
                    $value = $child->append_child($value);
                } // if
            } // foreach
        } // if
        if (array_key_exists($rownum, $object_errors)) {
		    if (count($object_errors[$rownum]) > 0) {
				// there are errors that have not been extracted yet, so ...
				// transfer them to general array
			    foreach ($object_errors as $key => $value){
			        if (is_array($value)) {
			            foreach ($value as $key2 => $value2) {
			                // prefix with fieldname
			            	$errors[$key] = '[' .$key2 .'] ' .$value2;
			            } // foreach
			        } else {
			            if ($key == (int)$key) {
			                // do not prefix with row number
    			            $errors[$key] = $value;
			            } else {
			                // prefix with fieldname
        					$errors[$key] = '[' .$key .'] ' .$value;
			            } // if
			        } // if
				} // foreach
			} // if
		} // if
    } // foreach

    // extract any lookup tables from the current object
    list($lookup, $lookup_css) = $dbobject->getLookupData();

    static $lookup_items = array(); // list of items that have been loaded

    if (!empty($lookup)) {
    	if ($GLOBALS['mode'] == 'search') {
            $undefined = getLanguageText('undefined');
    	} else {
    	    $undefined = ' ';
        } // if
        foreach ($lookup as $name => $data) {
            if (array_key_exists($name, $lookup_items)) {
            	// item has already been loaded, so don't duplicate it
                unset($lookup[$name]);
            } else {
                if (array_key_exists($name, $fieldspec)) {
                    // lookup name is the same as a field name
                	$spec = $fieldspec[$name];
                } else {
                    // find the field which uses this lookup array
                    $spec = array('type' => 'string');
                    foreach ($fieldspec as $key => $array) {
                    	if (array_key_exists('optionlist', $array)) {
                    		if ($array['optionlist'] == $name) {
                    			$spec = $array;
                    			break;
                    		} // if
                    	} // if
                    } // foreach
                } // if
                if ($spec['type'] == 'enum' AND array_key_exists(0, $data)) {
                	// blank entry already exists, so do not add another
                } elseif (isset($spec['control']) AND $spec['control'] == 'multidrop') {
                    // do not add blank entry
                } elseif (!array_key_exists(' ', $data)) {
                    // array does not contain blank entry, so insert one
                    $data2= array('' => $undefined);
                    // append all existing array entries (so as not to resequence any numerical keys)
                    foreach ($data as $key => $value) {
                    	$data2[$key] = $value;
                    } // foreach
                    $lookup[$name] = $data2;
                } // if
                $lookup_items[$name] = 'done';
            } // if
        } // foreach

        if (!empty($lookup)) {
            // insert LOOKUP arrays into XML document
            addLookup2XMLdoc($lookup, $lookup_css, $doc, $root);
        } // if
    } // if

    if (isset($node)) {
        // return the node created here as it may be used as the parent node for subsequent input
        return $node;
    } else {
        return $root;
    } // if

} // addData2XMLdoc

// ****************************************************************************
function addLookup2XMLdoc ($lookup, $lookup_css, $doc, $root)
// add contents of lookup array to current XML document
// there may be several lookup names each with its own option list
{
    $node = $doc->create_element('lookup');
    $node = $root->append_child($node);

    foreach ($lookup as $lookupname => $optionlist) {
        // add node to contain this list of options
        $occ = $doc->create_element($lookupname);
        $occ = $node->append_child($occ);
        // add each option as a child node
        foreach ($optionlist as $id => $optvalue) {
            $child = $doc->create_element('option');
            $child = $occ->append_child($child);
            $child->set_attribute('id', $id);

            if (array_key_exists($lookupname, $lookup_css)) {
            	if (array_key_exists($id, $lookup_css[$lookupname])) {
            	    // set css 'class' attribute for this entry
            	    $child->set_attribute('class', $lookup_css[$lookupname][$id]);
            	} // if
            } // if

            if (is_array($optvalue)) {
            	foreach ($optvalue as $key1 => $value1) {
            		if ($key1 == 'value') {
            			$value1 = convertEncoding($value1, 'UTF-8');
                        $value = $doc->create_text_node($value1);
                        $value = $child->append_child($value);
            		} else {
            		    $child->set_attribute($key1, $value1);
            		} // if
            	} // foreach
            } else {
                $optvalue = convertEncoding($optvalue, 'UTF-8');
                $value = $doc->create_text_node($optvalue);
                $value = $child->append_child($value);
            } // if
        } // foreach
    } // foreach

    return;

} // addLookup2XMLdoc

// ****************************************************************************
function addParams2XMLdoc ($doc, $root, $xsl_params)
// add optional parameters to XML document
{
    global $mode;           // insert/update/read/delete
    global $orderby;
    global $orderby_seq;
    global $screen_refresh;
    global $settings;
    global $title;
    global $task_id;

    if (is_True($_SERVER['HTTPS'])) {
        $protocol = 'HTTPS://';
        if (strlen($GLOBALS['https_server']) > 0) {
        	$xsl_params['script'] = $protocol .$GLOBALS['https_server'] .$_SERVER['PHP_SELF'];
        } else {
            $xsl_params['script'] = $protocol .$_SERVER['HTTP_HOST'] .$_SERVER['PHP_SELF'];
        } // if
    } else {
        $protocol = 'HTTP://';
        $xsl_params['script'] = $protocol . $_SERVER['HTTP_HOST'] .$_SERVER['PHP_SELF'];
    } // if

    $xsl_params['script_short'] = basename($_SERVER['PHP_SELF'], '.php');
    // replace parentheses with underscores so that this can be used as a CSS class name
    $xsl_params['script_short'] = str_replace(array('(', ')'),
                                              array('_', '_'),
                                              $xsl_params['script_short']);

    $xsl_params['session_name'] = session_name();
    //$xsl_params['session_id']   = session_id();

    $xsl_params['title'] = getLanguageText($task_id);

    if ($handle = fopen('version.txt', "r")) {
        $xsl_params['version'] = trim(fread($handle, 40));
        fclose($handle);
    } // if

    $xsl_params['language'] = $GLOBALS['output_language'];

    $xsl_params['pagination_width'] = $_SESSION['pagination_width'];
    $xsl_params['scrolling_width']  = $_SESSION['scrolling_width'];

    // insert various pieces of text
    $xsl_params['text']['logout-all']   = getLanguageText('xsl_logout_all');
    $xsl_params['text']['recover-pswd'] = getLanguageText('xsl_recover_pswd');
    $xsl_params['text']['new-session']  = getLanguageText('xsl_new_session');
    $xsl_params['text']['print']        = getLanguageText('xsl_print');
    $xsl_params['text']['noprint']      = getLanguageText('xsl_noprint');

    if (file_exists('../css/xsl_params.inc')) {
        // include overrides from optional file
        include('../css/xsl_params.inc');
    } // if

    $xsl_params['text']['page']         = getLanguageText('xsl_page');
    $xsl_params['text']['item']         = getLanguageText('xsl_item');
    $xsl_params['text']['of']           = getLanguageText('xsl_of');
    $xsl_params['text']['first']        = getLanguageText('xsl_first');
    $xsl_params['text']['last']         = getLanguageText('xsl_last');
    $xsl_params['text']['prev']         = getLanguageText('xsl_prev');
    $xsl_params['text']['next']         = getLanguageText('xsl_next');
    $xsl_params['text']['show']         = getLanguageText('xsl_show');
    $xsl_params['text']['select-all']   = getLanguageText('xsl_select_all');
    $xsl_params['text']['unselect-all'] = getLanguageText('xsl_unselect_all');
    $xsl_params['text']['logout']       = getLanguageText('xsl_logout');
    $xsl_params['text']['help']         = getLanguageText('xsl_help');
    $xsl_params['text']['page-created'] = getLanguageText('xsl_page_created');
    $xsl_params['text']['seconds']      = getLanguageText('xsl_seconds');
    if (is_true($_SESSION['XSLT_client_side'])) {
        $xsl_params['client-side'] = 'true';
    } // if
    if (isset($_SESSION['logon_user_name'])) {
    	$xsl_params['text']['logged-in-as'] = getLanguageText('xsl_logged_in_as');
        $xsl_params['logged-in-as']         = $_SESSION['logon_user_name'];
    } // if

    if (isset($mode)) {
        $xsl_params['mode'] = $mode;
    } // if
    if (isset($task_id)) {
        $xsl_params['taskid'] = $task_id;
    } // if

    $dir = getParentDIR();

    if (!empty($GLOBALS['http_server'])) {
    	$xsl_params['help_root'] = 'HTTP://' .$GLOBALS['http_server'] .$dir .dirname(getSelf());
        $xsl_params['doc_root']  = $protocol .$GLOBALS['http_server'] .$dir;
    } else {
        $xsl_params['help_root'] = 'HTTP://' .$_SERVER['HTTP_HOST'] .dirname($_SERVER['PHP_SELF']);
        $xsl_params['doc_root']  = $protocol .$_SERVER['HTTP_HOST'] .$dir;
    } // if

    // insert sort details
    if (ereg(',', $orderby)) {
        // convert from 'column,column' to just 'column'
        list($column) = split(',', $orderby);
        $orderby = $column;
    } // if
    if (ereg('\.', $orderby)) {
        // convert from 'table.column' to just 'column'
        list($table, $column) = split('\.', $orderby);
        $orderby = $column;
    } // if
    if (!empty($orderby)) {
        $xsl_params['orderby'] = $orderby;
        if (!empty($orderby_seq)) {
        	$xsl_params['order'] = trim(strtolower($orderby_seq));
        } else {
            $xsl_params['order'] = 'asc';
        } // if
    } // if

    if (isset($screen_refresh)) {
        if ((int)$screen_refresh > 0) {
        	$xsl_params['screen_refresh'] = (int)$screen_refresh;
        } // if
    } // if

    if ($settings) {
        // merge $settings array with $xsl_params array
        foreach ($settings as $key => $value) {
            $value = trim($value);
        	if (strtoupper($value) == 'FALSE') {
        		// ignore any settings which are FALSE
        	} else {
        	    $xsl_params[$key] = $value;
        	} // if
        } // foreach
    } // if

    if (isset($GLOBALS['no_script_time']) AND is_True($GLOBALS['no_script_time'])) {
        // do not add script_time to XML output
    } else {
    	// calculate the function's elapsed time
        list($usec, $sec) = explode(' ', microtime());
        $script_end = (float) $sec + (float) $usec;
        $elapsed = number_format($script_end - $_SESSION['script_start'], 5, '.', '');
        $xsl_params['script_time'] = $elapsed;
    } // if
    unset($_SESSION['script_start']);

    // now add each parameter to the XML document
    $node = $doc->create_element('params');
    $node = $root->append_child($node);

    foreach ($xsl_params as $name => $value) {
        // add node to contain this list of options
        $child = $doc->create_element($name);
        $child = $node->append_child($child);
        if (is_array($value)) {
            // output each entry as a sub-element
            foreach ($value as $name1 => $value1) {
        		$child1 = $doc->create_element($name1);
                $child1 = $child->append_child($child1);

                $value1 = convertEncoding($value1, 'UTF-8');

                $text = $doc->create_text_node($value1);
                $text = $child1->append_child($text);
        	} // foreach
        } else {
            $value = convertEncoding($value, 'UTF-8');
            $text = $doc->create_text_node($value);
            $text = $child->append_child($text);
        } // if
    } // foreach

    return;

} // addParams2XML

// ****************************************************************************
function buildXML ($xml_objects, $errors=null, $messages=null)
// build XML document using the database objects identified in $xml_objects
{
    // test that DOM XML funcions are available
    if (!function_exists('domxml_new_doc')) {
        trigger_error(getLanguageText('sys0070', 'DOM XML'), E_USER_ERROR); // 'DOM XML functions are not available.'
    } // if

    global $act_buttons;
    global $current_menu;
    global $current_task;
    global $menu_buttons;
    global $mode;
    global $nav_buttons;
    global $nav_buttons_omit;
    global $pagination;
    global $screen_structure;
    global $scrolling;
    global $task_id;
    global $xsl_file;

    $xsl_params    = array();
    $css_files     = array();
    $javascript    = array();
    $errors        = (array)$errors;

    // create a new XML document
    $xml_doc = domxml_new_doc('1.0');

    // get name of XSL file
    $xsl_file = getXSLfile($xml_doc, $xsl_file, $screen_structure);

    // add root node
    $node_array['root'] = $xml_doc->create_element('root');
    $root = $xml_doc->append_child($node_array['root']);

    foreach ($xml_objects as $seq => $object_data) {
        $node   = key($object_data);
        $object = $object_data[$node];
        if (!array_key_exists($node, $node_array)) {
            // "Node $node does not exist in node array"
            trigger_error(getLanguageText('sys0054', $node), E_USER_ERROR);
        } // if
        // add data from this object to XML document
        $child = addData2XMLdoc($xml_doc, $node_array['root'], $node_array[$node], $object, $errors);
        // add this object's name to $node_array
        $node_array[$object->getClassName()] = $child;
        // extract and merge any parameters for the XSL transformation
        $xsl_params = array_merge_recursive($xsl_params, (array)$object->xsl_params);
        // extract and merge any CSS file names
        $css_files = array_merge_recursive($css_files, (array)$object->css_files);
        // extract and merge any JavaScript code
        $javascript = array_merge_recursive($javascript, $object->javascript);
    } // foreach

    // insert list of CSS files
    setCSSfiles($xml_doc, $root, $css_files);

    if (!empty($javascript)) {
    	// insert optional JavaScript
        setJavaScript($xml_doc, $root, $javascript);
    } // if

    if (isset($_GET['action']) and $_GET['action'] == 'print') {
	    // skip
    } else {
        // insert action buttons
        if (!empty($act_buttons)) {
            setActBar($xml_doc, $root, $act_buttons);
        } // if

        // insert menu buttons
        if (!empty($menu_buttons)) {
            setMenuBar($xml_doc, $root, $menu_buttons, $current_menu, $current_task);
        } // if
    } // if

    if (isset($object) and is_object($object)) {
        if ($mode == 'logon') {
            // no navigation buttons exist on the logon screen
        } else {
            if (isset($_GET['action']) and $_GET['action'] == 'print') {
                // switch into print-preview mode
	            $xsl_params['noshow']        = 'true';
	            $xsl_params['noselect']      = 'true';
	            $xsl_params['print-preview'] = 'true';
            } else {
                // get navigation buttons from last $object
                $dbnav =& singleton::getInstance('mnu_nav_button');
                $nav_buttons = $dbnav->getNavButtons($task_id, $object);
                if ($dbnav->getErrors()) {
                    $errors = array_merge($errors, $dbnav->getErrors());
                } // if
            } // if
        } // if
        // insert navigation buttons
        if (!empty($nav_buttons)) {
            setNavBar($xml_doc, $root, $nav_buttons, $nav_buttons_omit);
        } // if
    } // if

    // insert scrolling details for any number of objects (optional)
    if (!empty($scrolling)) {
        setScrollbar($xml_doc, $root, $scrolling);
    } // if

    // insert pagination details for any number of objects (optional)
    if (!empty($pagination)) {
        setpaginationbar($xml_doc, $root, $pagination);
    } // if

    if (!empty($errors)) {
        // there may be errors for fields which are not in the form
        // so write them to separate error lines
        if (!is_array($errors)) {
            // convert string into an array
            $errors = (array)$errors;
        } // if
        if (is_string(key($errors))) {
            // array is not indexed by rownum, so set it to row zero
            $array[0] = $errors;
            $errors   = $array;
        } // if
        // add node to hold error lines
        $occ = $xml_doc->create_element('errmsg');
        $occ = $root->append_child($occ);
        foreach ($errors as $rownum => $rowdata) {
            if (!is_array($rowdata)) {
                // convert string into an array
                $rowdata = (array)$rowdata;
            } // if
			if (!empty($rowdata) AND is_array($rowdata[key($rowdata)])) {
	            // array within an array, so bring it up one level
	            $array  = $rowdata[key($rowdata)];
	            if (!is_string(key($array))) {
	                // array is indexed, so use it 'as-is'
	                $rowdata = $array;
	            } else {
	                // array is associative, so add column name to error message
	                $rowdata = array();
	                foreach ($array as $name => $value) {
	                    $rowdata[] = '[' .$name .'] ' .$value;
	                } // foreach
	            } // if
	        } // if
			foreach ($rowdata as $id => $msg) {
                $child = $xml_doc->create_element('line');
                $child = $occ->append_child($child);

                if (is_string($id)) {
                	// put fieldname and rownum into error message
                    $msg = $id .'[' .$rownum .']: ' .$msg;
                } // if

                $msg = convertEncoding($msg, 'UTF-8');

                $value = $xml_doc->create_text_node($msg);
                $value = $child->append_child($value);
            } // foreach
        } // foreach
    } // if

    if (!empty($messages)) {
        // add messages which are not errors to their own area
        if (!is_array($messages)) {
            $messages[] = $messages;
        } // if
        // add node to hold error lines
        $occ = $xml_doc->create_element('infomsg');
        $occ = $root->append_child($occ);
        foreach ($messages as $rownum => $msg) {
            $child = $xml_doc->create_element('line');
            $child = $occ->append_child($child);

            $msg = convertEncoding($msg, 'UTF-8');

            $value = $xml_doc->create_text_node($msg);
            $value = $child->append_child($value);
        } // foreach
    } // if

    if (!empty($screen_structure)) {
        // put screen structure into XML document
        setScreenStructure($xml_doc, $root, $screen_structure);
    } // if

    // look for optional HEADER.TXT
    if ($GLOBALS['mode'] == 'logon') {
        // use file associated with this logon script
        $script = basename($_SERVER['PHP_SELF'], '.php');
    	$fname = $script .'_header.txt';
    } else {
        $fname = 'header.txt';
    } // if
    if (file_exists($fname)) {
        $header = file_get_contents($fname);
        if (!empty($header)) {
            $occ = $xml_doc->create_element('header');
            $occ = $root->append_child($occ);
            $child = $xml_doc->create_cdata_section($header);
            $child = $occ->append_child($child);
        } // if
    } // if

    // look for optional FOOTER.TXT
    if ($GLOBALS['mode'] == 'logon') {
        // use file associated with this logon script
        $script = basename($_SERVER['PHP_SELF'], '.php');
    	$fname = $script .'_footer.txt';
    } else {
        $fname = 'footer.txt';
    } // if
    if (file_exists($fname)) {
        $footer = file_get_contents($fname);
        if (!empty($footer)) {
            $occ = $xml_doc->create_element('footer');
            $occ = $root->append_child($occ);
            $child = $xml_doc->create_cdata_section($footer);
            $child = $occ->append_child($child);
        } // if
    } // if

    // add optional parameters
    addParams2XMLdoc ($xml_doc, $root, $xsl_params);

    // get completed xml document
    $xml_string = $xml_doc->dump_mem(true, 'UTF-8');
    unset($xml_doc);

    if (is_True($_SESSION['log_xml_document'])) {
        // write XML data to a disk file in XSL subdirectory for debugging
        $fname = './xsl/' . basename($_SERVER['PHP_SELF']) . '.xml' ;
        if (!$fp = @fopen($fname, 'w')) {
            //chmod("./xsl", 0777);
            //if (!$fp = fopen($fname, 'w')) {
            //    trigger_error("Cannot open file $fname", E_USER_ERROR);
            //} // if
        } else {
            if (fwrite($fp, $xml_string) === false) {
                // "Cannot write to file $fname"
                trigger_error(getLanguageText('sys0055', $fname));
            } // if
            fclose($fp);
        } // if
    } // if

    if (is_true($_SESSION['XSLT_client_side'])) {
        // send XML file to the client for transformation there
        XSLclient($xml_string);
    } else {
        // transform XML document using XSL file
        XSLTransform($xml_string, $xsl_file);
    } // if

    return;

} // buildXML

// ****************************************************************************
function createXMLdoc ($rows, $root_name='root', $root_attrs, $element_name='element')
// create an XML document from rows of input data and return it as a string.
{
    $qualifiedName =& $root_attrs['qualifiedName'];
    $publicId      =& $root_attrs['publicId'];
    $systemId      =& $root_attrs['systemId'];

    unset($root_attrs['qualifiedName']);
    unset($root_attrs['publicId']);
    unset($root_attrs['systemId']);

    // create a new XML document
    $xml_doc = domxml_new_doc('1.0');

    $root = $xml_doc->create_element($root_name);
    $root = $xml_doc->append_child($root);

    foreach ($root_attrs as $attr_name => $attr_value) {
    	$root->set_attribute($attr_name, $attr_value);
    } // foreach

    if (is_string(key($rows))) {
        // this is an associative array containing a single row, so mae it row zero
    	$temp[0] = $rows;
    	$rows    = $temp;
    	unset($temp);
    } // if

    foreach ($rows as $rownum => $rowdata) {
    	// add element containing action buttons
        $occ = $xml_doc->create_element($element_name);
        $occ = $root->append_child($occ);

        foreach ($rowdata as $fieldname => $fieldvalue) {
            // add each field to the xml document
            $child = $xml_doc->create_element($fieldname);
            $child = $occ->append_child($child);

            $fieldvalue = str_replace('&nbsp;', chr(160), $fieldvalue);

            $fieldvalue = convertEncoding($fieldvalue, 'UTF-8');

            $value = $xml_doc->create_text_node(trim($fieldvalue));
            $value = $child->append_child($value);
        } // foreach
    } // foreach

    // get completed xml document
    $xml_string = $xml_doc->dump_mem(true, 'UTF-8');

    return $xml_string;

} // createXMLdoc

// ****************************************************************************
function getXSLfile ($xml_doc, $xsl_file, $screen_structure)
// extract name of XSL file from screen structure.
{
    if (is_array($screen_structure)) {
    	if (array_key_exists('xsl_file', $screen_structure)) {
        	$xsl_file = $screen_structure['xsl_file'];
        } // if
    } // if

    if (empty($xsl_file)) {
    	// 'XSL file has not been defined'
        trigger_error(getLanguageText('sys0074', $screen), E_USER_ERROR);
    } // if

    // does a local variation of this XSL file exist?
    $filename = './xsl/' .$xsl_file;
    if (!file_exists($filename)) {
        // no, so load from standard area
        if (is_True($_SERVER['HTTPS'])) {
            // use one or the other of these, whichever is available
            if (strlen($_SERVER['PATH_TRANSLATED']) > strlen($_SERVER['SCRIPT_FILENAME'])) {
            	$dir = getParentDIR($_SERVER['PATH_TRANSLATED']);
            } else {
                $dir = getParentDIR($_SERVER['SCRIPT_FILENAME']);
            } // if
            $filename = $dir .'/xsl/' .$xsl_file;
            //logstuff("filename: " .$filename, __FUNCTION__, __LINE__);

            $xsl_url = 'HTTPS://' .$GLOBALS['https_server']
                                  .$GLOBALS['https_server_suffix']
                                  .getParentDIR()
                                  .'/xsl/' .$xsl_file;
        } else {
            $dir = getParentDIR();
            $filename = $_SERVER['DOCUMENT_ROOT'] .$dir .'/xsl/' .$xsl_file;
            $xsl_url = 'HTTP://' .$_SERVER['HTTP_HOST'] .$dir .'/xsl/' .$xsl_file;
        } // if
        if (!file_exists($filename)) {
            trigger_error("File $filename does not exist...", E_USER_ERROR);
        } // if
    } // if

    if (is_true($_SESSION['XSLT_client_side'])) {
    	$pi = $xml_doc->create_processing_instruction('xml-stylesheet', 'type="text/xsl" href="' .$xsl_url .'"');
    	$xml_doc->append_child($pi);
    } // if

    return $filename;

} // get XSLfile

// ****************************************************************************
function setActBar ($doc, $root, $act_buttons)
// add contents of $act_buttons to the current XML document
{
    // add element containing action buttons
    $occ = $doc->create_element('actbar');
    $occ = $root->append_child($occ);

    foreach ($act_buttons as $button => $label) {
        // add each button to the xml document
        $child = $doc->create_element('button');
        $child = $occ->append_child($child);
        $child->set_attribute('id', $button);

        // convert text into output language
        $label = getLanguageText($label);

        $label = convertEncoding($label, 'UTF-8');

        $value = $doc->create_text_node(trim($label));
        $value = $child->append_child($value);
    } // foreach

    return;

} // setActBar

// ****************************************************************************
function setCSSfiles ($doc, $root, $css_files)
// add contents of $css_files to the current XML document
{
    // convert from string to array, if necessary
    if (!is_array($css_files)) {
        $css_files = (array)$css_files;
    } // if

    // if no custom stylesheet is specified use 'style_custom.css' in local directory
    if (empty($css_files)) {
        $css_files[] = 'style_custom.css';
    } // if

    foreach ($css_files as $filenum => $filename) {
        if (dirname($filename) == '.') {
            // prepend file name with directory name
        	$css_files[$filenum] = dirname($_SERVER['PHP_SELF']) .'/' .$filename;
        } // if
    } // foreach

    // identify global CSS file and add it to the front of this array
    $default_css = getParentDIR() .'/css/' .$_SESSION['css_file'] .'.css';
    array_unshift($css_files, $default_css);

    foreach ($css_files as $filenum => $filename) {
        // prepend each file with protocol and domain name
        if (is_True($_SERVER['HTTPS'])) {
            if (strlen($GLOBALS['https_server']) > 0) {
            	$css_files[$filenum] = 'HTTPS://' .$GLOBALS['https_server'] .$GLOBALS['https_server_suffix'] .$filename;
            } else {
                $css_files[$filenum] = 'HTTPS://' .$_SERVER['HTTP_HOST'] .$filename;
            } // if
        } else {
            $css_files[$filenum] = 'HTTP://' . $_SERVER['HTTP_HOST'] .$filename;
        } // if
    } // if

    // add element containing file names
    $occ = $doc->create_element('cssfiles');
    $occ = $root->append_child($occ);

    foreach ($css_files as $filename) {
        // add each filename to the xml document
        $child = $doc->create_element('filename');
        $child = $occ->append_child($child);

        $filename = convertEncoding($filename, 'UTF-8');

        $value = $doc->create_text_node($filename);
        $value = $child->append_child($value);
    } // foreach

    return;

} // setCSSfiles

// ****************************************************************************
function setJavaScript ($doc, $root, $javascript)
// insert JavaScript into the <HEAD> and <BODY> elements
{
    if (isset($javascript['head'])) {
        $occ = $doc->create_element('javascript');
        $occ = $root->append_child($occ);
    	foreach ($javascript['head'] as $entry) {
            if (key($entry) == 'file') {
                // add a reference to a file
                $head = $doc->create_element('head');
                $head->set_attribute('type', 'file');
                $head = $occ->append_child($head);

                $url = $entry[key($entry)];
                if (strtoupper(substr($url, 0, 4)) != 'HTTP') {
            		if (is_True($_SERVER['HTTPS'])) {
                        if (strlen($GLOBALS['https_server']) > 0) {
                        	$url = 'HTTPS://' .$GLOBALS['https_server'] .dirname($_SERVER['PHP_SELF']) .'/' .$url;
                        } else {
                            $url = 'HTTPS://' .$_SERVER['HTTP_HOST'] .dirname($_SERVER['PHP_SELF']) .'/' .$url;
                        } // if
                    } else {
                        $url = 'HTTP://' . $_SERVER['HTTP_HOST'] .dirname($_SERVER['PHP_SELF']) .'/' .$url;
                    } // if
                } // if

                $head  = $occ->append_child($head);
                $value = $doc->create_text_node($url);
                $value = $head->append_child($value);
            } // if

            if (key($entry) == 'code') {
            	// add a block of javascript code
                $head = $doc->create_element('head');
                $head->set_attribute('type', 'code');
                $head  = $occ->append_child($head);
                $value = $doc->create_text_node($entry[key($entry)]);
                $value = $head->append_child($value);
            } // if
        } // foreach
    } // if

    if (isset($javascript['body'])) {
        // add element containing action buttons
        $body = $doc->create_element('body');
        $body = $occ->append_child($body);

        foreach ($javascript['body'] as $tag => $event) {
            // add each event to the xml document
            $body->set_attribute($tag, $event);
        } // foreach
    } // if

    if (isset($javascript['tbody'])) {
        // add element containing action buttons
        $body = $doc->create_element('tbody');
        $body = $occ->append_child($body);

        foreach ($javascript['tbody'] as $tag => $event) {
            // add each event to the xml document
            $body->set_attribute($tag, $event);
        } // foreach
    } // if

    return;

} // setJavaScript

// ****************************************************************************
function setMenuBar ($doc, $root, $menu_buttons, $current_menu, $current_task)
// add contents of $menu_buttons table to the current XML document.
{
    // add element containing navigation buttons
    $occ = $doc->create_element('menubar');
    $occ = $root->append_child($occ);

    foreach ($menu_buttons as $task_id => $task_desc) {
        // add each button to the xml document
        $child = $doc->create_element('button');
        $child->set_attribute('id', $task_id);
        if ($task_id == $current_task) {
            $child->set_attribute('active', 'y');
        } // if
        $child = $occ->append_child($child);

        // convert text into output language
        $task_desc = getLanguageText($task_desc);

        $task_desc = convertEncoding($task_desc, 'UTF-8');

        $value = $doc->create_text_node(trim($task_desc));
        $value = $child->append_child($value);
    } // foreach

    if (isset($GLOBALS['page_stack'])) {
        // insert stack which identifies the sequence of pages used so far (aka 'breadcrumbs')
        $page_stack = $GLOBALS['page_stack'];
        foreach ($page_stack as $task_id => $data) {
            $child = $doc->create_element('stack');
            $child->set_attribute('id', $task_id);
            if ($task_id == $current_menu) {
                $child->set_attribute('active', "y");
            } // if
            $child = $occ->append_child($child);

            // convert text into output language
            $data['button_text'] = getLanguageText($data['button_text']);

            $data['button_text'] = convertEncoding($data['button_text'], 'UTF-8');

            $value = $doc->create_text_node(trim($data['button_text']));
            $value = $child->append_child($value);
        } // foreach
    } // if

    return;

} // setMenuBar

// ****************************************************************************
function setNavBar ($doc, $root, $nav_buttons, $nav_buttons_omit=null)
// add contents of $nav_button array to the current XML document
{
    // remove nominated buttons (if necessary)
    if (count($nav_buttons_omit) > 0) {
        // examine each nominated button
        foreach ($nav_buttons_omit as $task_id) {
            // remove from button array (if found)
        	foreach ($nav_buttons as $num => $button) {
        		if ($button['task_id'] == $task_id) {
        		    unset($nav_buttons[$num]);
        		} // if
        	} // foreach
        } // foreach
    } // if

    // add element containing navigation buttons
    $occ = $doc->create_element('navbar');
    $occ = $root->append_child($occ);

    foreach ($nav_buttons as $button) {
        // add each button to the xml document
        $child = $doc->create_element('button');
        $child->set_attribute('id', "task#{$button['task_id']}");
        $child->set_attribute('context_preselect', "{$button['context_preselect']}");
        $child = $occ->append_child($child);

        // convert text into output language
        $button['button_text'] = getLanguageText($button['button_text']);

        $button['button_text'] = convertEncoding($button['button_text'], 'UTF-8');

        $value = $doc->create_text_node(trim($button['button_text']));
        $value = $child->append_child($value);
    } // foreach

    return;

} // setNavBar

// ****************************************************************************
function setPaginationBar ($xml_doc, $root, $pagination)
// insert (optional) pagination details for any number of objects
// into the current XML document
{
    $occ = $xml_doc->create_element('pagination');
    $occ = $root->append_child($occ);

    // create a separate child node for each table
    foreach ($pagination as $object => $objectlist) {
        $child = $xml_doc->create_element('page');
        $child = $occ->append_child($child);
        $child->set_attribute('id', $object);
        foreach ($objectlist as $itemname => $itemvalue) {
            if ($itemname <> 'where') {
                $child->set_attribute($itemname, $itemvalue);
            } // if
        } // foreach
    } // foreach

    return;

} // setPaginationBar

// ****************************************************************************
function setScreenStructure ($xml_doc, $root, $structure)
// extract screen structure from named file and insert details into XML document.
{
    // define node to contain all structure elements
    $occ = $xml_doc->create_element('structure');
    $occ = $root->append_child($occ);

    // structure may contain one or more tables, so step through each one
    foreach ($structure['tables'] as $zone => $id) {
        $id = removeTableSuffix(strtolower(trim($id)));
        $zone = strtolower(trim($zone));
        // add this table name as a child to the structure element
        $table = $xml_doc->create_element($zone);
        $table = $occ->append_child($table);
        $table->set_attribute('id', $id);
        // set column values for this table, if present
        if (isset($structure[$zone]['columns'])) {
            $columns = $xml_doc->create_element('columns');
            $columns = $table->append_child($columns);
            foreach ($structure[$zone]['columns'] as $row => $array) {
                $array = array_change_key_case($array, CASE_LOWER);
                // if 'nodisplay' attribute is set then do not output this column
                if (!array_key_exists('nodisplay', $array)) {
                	$column = $xml_doc->create_element('column');
                    $column = $columns->append_child($column);
                    foreach ($array as $attrname => $attrvalue) {
                        $attrname = trim($attrname);
                        if ($attrname == 'nosort') {
                            // ignore this attribute
                        } else {
                            $column->set_attribute($attrname, $attrvalue);
                        } // if
                    } // foreach
                } // if
            } // foreach
        } // if

        // test for 'old' format file
        if (is_string(key($structure[$zone]['fields']))) {
            // "FIELDS array for zone '$zone' in screen structure file is not indexed by rownum"
            trigger_error(getLanguageText('sys0053', $zone), E_USER_ERROR);
        } // if

        // extract field details one row at a time
        foreach ($structure[$zone]['fields'] as $row => $rowdata) {
        	$rowocc = $xml_doc->create_element('row');
            $rowocc = $table->append_child($rowocc);
            if (is_string(key($rowdata))) {
            	// not indexed by cell number, so assume 'fieldname' => 'label'

            	$rowdata = array_change_key_case($rowdata, CASE_LOWER);

            	// if 'nodisplay' attribute is set then do not output this column
            	if (!array_key_exists('nodisplay', $rowdata)) {
                	foreach ($rowdata as $fieldname => $fieldlabel) {
                	    $fieldname = trim($fieldname);
                	    if (empty($fieldname)) {
                	    	$fieldname = 'null';
                	    } // if
                        if (preg_match('/^(nosort)$/i', $fieldname, $regs)) {
                            // ignore 'nosort' entry
                        } elseif ($fieldname=='size' AND is_numeric($fieldlabel)) {
                            // 'size=<numeric>' is an attribute of the previous field, whereas
                            // 'size=<string>' is a new 'field=label' pair
                            $cell->set_attribute($fieldname, $fieldlabel);
                        } elseif ($fieldname == 'javascript' and is_array($fieldlabel)) {
                            foreach ($fieldlabel as $sttr => $attrvalue) {
                        		// add this entry as an attribute to the current row
                        	    $rowocc->set_attribute($sttr, $attrvalue);
                        	} // foreach
                        } elseif (preg_match('/^(imagewidth|imageheight|colspan|rowspan|class|display-empty)$/i', $fieldname, $regs)) {
                            // write these out as attributes on the current cell
                            $cell->set_attribute($regs[0], $fieldlabel);
                        } else {
                            $cell = $xml_doc->create_element('cell');
                            $cell = $rowocc->append_child($cell);

                            // convert text into output language
                            $fieldlabel = getLanguageText($fieldlabel);

                            $fieldlabel = convertEncoding($fieldlabel, 'UTF-8');
                            $cell->set_attribute('label', $fieldlabel);

                            if (array_key_exists('nosort', $rowdata)) {
                            	$cell->set_attribute('nosort', 'y');
                            } // if

                            $cell = $xml_doc->create_element('cell');
                            $cell = $rowocc->append_child($cell);

                            $cell->set_attribute('field', $fieldname);

                        } // if
                    } // foreach
            	} // if
            } else {
                // there is a separate entry for each cell in the current row
                foreach ($rowdata as $cellno => $cellspec) {
                    $cellspec = array_change_key_case($cellspec, CASE_LOWER);
                    if (key($cellspec) == 'javascript' and is_array($cellspec[key($cellspec)])) {
                    	$javascript = $cellspec['javascript'];
                    	foreach ($javascript as $attr => $attrvalue) {
                    		// add this entry as an attribute to the current row
                    	    $rowocc->set_attribute($attr, $attrvalue);
                    	} // foreach
                    } else {
                        // create XML element for a new cell
                        $cell = $xml_doc->create_element('cell');
                        $cell = $rowocc->append_child($cell);

                    	foreach ($cellspec as $celltype => $cellvalue) {
                    	    $celltype = trim($celltype);
                    	    if (empty($celltype)) {
                    	    	$celltype = 'null';
                    	    } // if
                    	    if ($celltype == 'label') {
                    	    	// convert text into output language
                                $cellvalue = getLanguageText($cellvalue);
                    	    } // if
                    		// add this entry as an attribute to the current cell
                    	    $cell->set_attribute($celltype, $cellvalue);
                    	} // foreach
                    } // if
                } // foreach
            } // if
        } // foreach

        // insert tree node data names, if supplied
        if (isset($structure[$zone]['node_data_names'])) {
            $columns = $xml_doc->create_element('node_data_names');
            $columns = $table->append_child($columns);
            foreach ($structure[$zone]['node_data_names'] as $item => $value) {
                $item = strtolower(trim($item));
                // write the contents of the array as attributes
                $columns->set_attribute(strtolower($item), $value);
            } // foreach
        } // if
    } // foreach

    return;

} // setScreenStructure

// ****************************************************************************
function setScrollbar ($xml_doc, $root, $scrolling)
// insert (optional) scrolling details for any number of objects
// into the current XML document
{
    $occ = $xml_doc->create_element('scrolling');
    $occ = $root->append_child($occ);

    // create a separate child node for each table
    foreach ($scrolling as $object => $objectlist) {
        $child = $xml_doc->create_element('scroll');
        $child = $occ->append_child($child);
        $child->set_attribute('id', strtolower($object));
        foreach ($objectlist as $itemname => $itemvalue) {
            if ($itemname <> 'where') {
                $child->set_attribute($itemname, $itemvalue);
            } // if
        } // foreach
    } // foreach

    return;

} // setScrollbar

// ****************************************************************************
function XSLclient ($xml_string)
// send the XML file to the client so that it can be transformed into HTML there
{
    // set charset to display accented characters correctly
    header('content-type: application/xml; charset=UTF-8');
    header('content-length: ' .strlen($xml_string));

    // disable any caching by the browser
    header('Expires: Mon, 14 Oct 2002 05:00:00 GMT'); // Date in the past
    header('Last-Modified: ' . gmdate("D, d M Y H:i:s") . ' GMT'); // always modified
	if (is_True($_SERVER['HTTPS']) or (isset($GLOBALS['use_https']) and $GLOBALS['use_https'] == true)) {
        // skip this next bit
    } else {
    	header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP 1.1
        header('Cache-Control: post-check=0, pre-check=0', false);
        header('Pragma: no-cache'); // HTTP 1.0
    } //if

    echo $xml_string;

    return;

} // XSLclient

// ****************************************************************************
function XSLTransform ($xml_string, $xsl_file)
// transform XML into HTML using XSL file
// $xml_string = XML document
// $xsl_file   = name of external xsl file
{
    // set the file names
    $xsl_string = join('', file($xsl_file));

    // set the argument buffer
    $arg_buffer = array('/xml' => $xml_string, '/xsl' => $xsl_string);

    if (!function_exists('xslt_create')) {
        // 'XSLT functions are not available.'
        trigger_error(getLanguageText('sys0070', 'XSLT'), E_USER_ERROR);
    } // if

    // create the XSLT processor
    $xp = xslt_create() or trigger_error(getLanguageText('sys0071', 'XSLT'), E_USER_ERROR);

    xslt_set_error_handler($xp, "XSLT_errorHandler");

    if (function_exists('xslt_set_encoding')) {
        // xslt_set_encoding($xp, 'ISO-8859-1');
        xslt_set_encoding($xp, 'UTF-8');
    } // if

    // set charset to display accented characters correctly
    header('content-type:text/html; charset=UTF-8');

    // disable any caching by the browser
    header('Expires: Mon, 14 Oct 2002 05:00:00 GMT'); // Date in the past
    header('Last-Modified: ' . gmdate("D, d M Y H:i:s") . ' GMT'); // always modified
    header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP 1.1
    header('Cache-Control: post-check=0, pre-check=0', false);
    header('Pragma: no-cache'); // HTTP 1.0

    // set the base directory name for 'xsl:include', 'xsl:import' etc
    xslt_set_base($xp, 'file://' . dirname($xsl_file) .'/');

    // set start time of XSL transformation
    list($usec, $sec) = explode(' ', microtime());
    $xsl_start = (float) $sec + (float) $usec;

    // process the two files to get the desired output
    if ((!$result = xslt_process($xp, 'arg:/xml', 'arg:/xsl', null, $arg_buffer))) {
        // display error
        global $xslt_error;
        trigger_error($xslt_error, E_USER_ERROR);
    } // endif

    // free the resources occupied by the XSLT processor
    xslt_free($xp);

    // calculate the function's elapsed time
    list($usec, $sec) = explode(' ', microtime());
    $xsl_end = (float) $sec + (float) $usec;
    $xsl_elapsed = number_format($xsl_end - $xsl_start, 5, '.', '');

    // insert this value into the HTML output
    $result = str_replace('$xsl$', $xsl_elapsed, $result);

    echo $result;

    return;

} // XSLTransform

// ****************************************************************************
?>
