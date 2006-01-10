<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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

    // get object name from this object
    $objectname = $dbobject->getClassName();

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

            // convert from internal coding to UTF-8
            $rowdata = convertEncoding($rowdata, DEFAULT_CHARSET, 'UTF-8');

            // insert as text element for the current node
            $value = $doc->create_text_node($rowdata);
            $value = $node->append_child($value);
        } else {
            // add a child node for each field
            foreach ($rowdata as $fieldname => $fieldvalue) {
                $child = $doc->create_element($fieldname);
                $child = $node->append_child($child);
                if (isset($fieldspec[$fieldname])) {
                    // field exists in $fieldspec, so get field specifications
                    $spec = array_change_key_case($fieldspec[$fieldname], CASE_LOWER);
                    // add field size as an attribute
                    if (isset($spec['size'])) {
                        $child->set_attribute('size', $spec['size']);
                    } // if

                    // look for noedit attribute
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

                    // look for nodisplay/hidden attribute
                    if (isset($spec['nodisplay'])) {
                        $child->set_attribute('nodisplay', 'y');
                        $fieldvalue = '**hidden**';
                    } else {
                        // if an error message exists put it into the error attribute
                        if (!empty($object_errors)) {
                            if (array_key_exists($rownum, $object_errors) and is_array($object_errors[$rownum])) {
                                if (array_key_exists($fieldname, $object_errors[$rownum])) {
                                    $child->set_attribute("error", $object_errors[$rownum][$fieldname]);
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
                            $lookup = fixTrueFalse($lookup, $spec['true'], $spec['false']);
                            // now put back into object's internal data
                        	$dbobject->lookup_data[$optionlist] = $lookup;
                        } // if
                    } // if

                    if (isset($spec['control'])) {
                        // option for dropdown fields
                        if ($spec['control'] == 'dropdown') {
                            $child->set_attribute('control', 'dropdown');
                            $child->set_attribute('optionlist', $spec['optionlist']);
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
                        } // if
                        // option for radio buttons
                        if ($spec['control'] == 'radiogroup') {
                            $child->set_attribute('control', 'radiogroup');
                            $child->set_attribute('optionlist', $spec['optionlist']);
                            if (isset($spec['align'])) {
                            	$child->set_attribute('align', $spec['align']);
                            } // if
                        } // if
//                    } elseif (isset($spec['type'])) {
//                        if ($spec['type'] == 'boolean') {
//                            $child->set_attribute('control', 'boolean');
//                        } // if
                    } // if
                } else {
                    // field does not exist in $fieldspec, so make it non-editable
                    $child->set_attribute('noedit', 'y');
                } // if

                // convert from internal coding to UTF-8
                $fieldvalue = convertEncoding($fieldvalue, DEFAULT_CHARSET, 'UTF-8');

                // insert as text element for the current node
                $value = $doc->create_text_node($fieldvalue);
                $value = $child->append_child($value);
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
    $lookup = $dbobject->getLookupData();

    if ($GLOBALS['mode'] == 'search') {
        // add in an extra entry for 'undefined' in dropdowns or radio groups
        // (this will not overwrite an existing blank entry)
        $undefined = array('' => getLanguageText('undefined'));
        foreach ($lookup as $field => $data) {
            if (!array_key_exists(' ', $data)) {
                $data = array_merge($undefined, $data);
                $lookup[$field] = $data;
            } // if
        } // foreach
    } // if

    if (!empty($lookup)) {
        // insert LOOKUP arrays into XML document
        addLookup2XMLdoc($lookup, $doc, $root);
    } // if

    if (isset($node)) {
        // return the node created here as it may be used as the parent node for subsequent input
        return $node;
    } else {
        return $root;
    } // if

} // addData2XMLdoc

// ****************************************************************************
function addLookup2XMLdoc ($lookup, $doc, $root)
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

            // convert from internal coding to UTF-8
            $optvalue = convertEncoding($optvalue, DEFAULT_CHARSET, 'UTF-8');

            $value = $doc->create_text_node($optvalue);
            $value = $child->append_child($value);
        } // foreach
    } // foreach

    return;

} // addLookup2XMLdoc

// ****************************************************************************
function addParams2XMLdoc ($doc, $root, $xsl_params)
// add optional parameters to XML document
{
    global $language;       // for internationalisation
    global $mode;           // insert/update/read/delete
    global $orderby;
    global $orderby_seq;
    global $protocol;       // HTTP or HTTPS
    global $settings;
    global $title;
    global $task_id;

    $xsl_params['script'] = $protocol . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
    $xsl_params['session_name'] = session_name();
    $xsl_params['http_host'] = $protocol . $_SERVER['HTTP_HOST'];
    //$xsl_params['doc_root']  = $_SERVER['DOCUMENT_ROOT'];

    $xsl_params['title'] = getLanguageText($task_id);

    $xsl_params['language'] = $language;

    // insert various pieces of text
    $xsl_params['text']['page']  = getLanguageText('xsl_page');
    $xsl_params['text']['item']  = getLanguageText('xsl_item');
    $xsl_params['text']['of']    = getLanguageText('xsl_of');
    $xsl_params['text']['first'] = getLanguageText('xsl_first');
    $xsl_params['text']['last']  = getLanguageText('xsl_last');
    $xsl_params['text']['prev']  = getLanguageText('xsl_prev');
    $xsl_params['text']['next']  = getLanguageText('xsl_next');
    $xsl_params['text']['show']  = getLanguageText('xsl_show');
    $xsl_params['text']['select-all']   = getLanguageText('xsl_select_all');
    $xsl_params['text']['unselect-all'] = getLanguageText('xsl_unselect_all');
    $xsl_params['text']['logout']       = getLanguageText('xsl_logout');
    $xsl_params['text']['new-session']  = getLanguageText('xsl_new_session');
    $xsl_params['text']['help']         = getLanguageText('xsl_help');
    $xsl_params['text']['page-created'] = getLanguageText('xsl_page_created');
    $xsl_params['text']['seconds']      = getLanguageText('xsl_seconds');
    $xsl_params['text']['print']        = getLanguageText('xsl_print');
    $xsl_params['text']['noprint']      = getLanguageText('xsl_noprint');
    if (is_true($_SESSION['XSLT_client_side'])) {
        $xsl_params['client-side'] = 'true';
    } // if

    if (isset($mode)) {
        $xsl_params['mode'] = $mode;
    } // if
    if (isset($task_id)) {
        $xsl_params['taskid'] = $task_id;
    } // if

    $dir = getParentDIR();

    if (isset($GLOBALS['subsys_dir'])) {
        $xsl_params['help_root'] = $protocol .$_SERVER['HTTP_HOST'] .$dir .'/' .$GLOBALS['subsys_dir'];
    } else {
        $xsl_params['help_root'] = $protocol .$_SERVER['HTTP_HOST'] .dirname($_SERVER['PHP_SELF']);
    } // if

    $xsl_params['menu_root'] = $protocol .$_SERVER['HTTP_HOST'] .$dir .'/menu';

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
    if (isset($orderby)) {
        $xsl_params['orderby'] = $orderby;
        $xsl_params['order']   = $orderby_seq;
    } // if

    if ($settings) {
        // merge $settings array with $xsl_params array
        $xsl_params = array_merge($settings, $xsl_params);
    } // if

    // calculate the function's elapsed time
    list($usec, $sec) = explode(' ', microtime());
    $script_end = (float) $sec + (float) $usec;
    $xsl_params['script_time'] = round($script_end - $_SESSION['script_start'], 5);
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

                // convert from internal coding to UTF-8
                $value1 = convertEncoding($value1, DEFAULT_CHARSET, 'UTF-8');

                $text = $doc->create_text_node($value1);
                $text = $child1->append_child($text);
        	} // foreach
        } else {
            // convert from internal coding to UTF-8
            $value = convertEncoding($value, DEFAULT_CHARSET, 'UTF-8');

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
    global $css_files;
    global $current_menu;
    global $current_task;
    global $menu_buttons;
    global $mode;
    global $nav_buttons;
    global $pagination;
    global $remove_buttons;
    global $screen;
    global $scrolling;
    global $task_id;
    global $xsl_file;

    $xsl_params = array();

    // create a new XML document
    $xml_doc = domxml_new_doc('1.0');

    // get name of XSL file
    $structure = '';
    $xsl_file = getXSLfile($xml_doc, $xsl_file, $screen, $structure);

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
        $xsl_params = array_merge_recursive($xsl_params, $object->xsl_params);
    } // foreach

    // insert list of CSS files
    setCSSfiles($xml_doc, $root, $css_files);

    if (isset($_GET['action']) and $_GET['action'] == 'print') {
	    // skip
    } else {
        // insert action buttons
        if (isset($act_buttons)) {
            setActBar($xml_doc, $root, $act_buttons);
        } // if

        // insert menu buttons
        if (isset($menu_buttons)) {
            setMenuBar($xml_doc, $root, $menu_buttons, $current_menu, $current_task);
        } // if
    } // if

    if (isset($object) and is_object($object)) {
        if ($mode == 'logon') {
            // no navigation buttons exist on the logon screen
        } else {
            if (isset($_GET['action']) and $_GET['action'] == 'print') {
	            $xsl_params['noshow']        = 'true';
	            $xsl_params['noselect']      = 'true';
	            $xsl_params['print-preview'] = 'true';
            } else {
                // get navigation buttons from last $object
                $nav_buttons = $object->getNavButtons($task_id);
                if ($object->getErrors()) {
                    $errors = array_merge($errors, $object->getErrors());
                } // if
            } // if
        } // if
        // insert navgation buttons
        if (isset($nav_buttons)) {
            setNavBar($xml_doc, $root, $nav_buttons, $remove_buttons);
        } // if
    } // if

    // insert scrolling details for any number of objects (optional)
    if (isset($scrolling)) {
        setScrollbar($xml_doc, $root, $scrolling);
    } // if

    // insert pagination details for any number of objects (optional)
    if (isset($pagination)) {
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
			if (is_array($rowdata[key($rowdata)])) {
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

                // convert from internal coding to UTF-8
                $msg = convertEncoding($msg, DEFAULT_CHARSET, 'UTF-8');

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

            // convert from internal coding to UTF-8
            $msg = convertEncoding($msg, DEFAULT_CHARSET, 'UTF-8');

            $value = $xml_doc->create_text_node($msg);
            $value = $child->append_child($value);
        } // foreach
    } // if

    if (isset($screen)) {
        // process file containing screen structure
        setScreenStructure($xml_doc, $root, $structure);
    } // if

    // look for optional HEADER.TXT
    if (file_exists('header.txt')) {
        $header = file_get_contents('header.txt');
        if (!empty($header)) {
            $occ = $xml_doc->create_element('header');
            $occ = $root->append_child($occ);
            $child = $xml_doc->create_cdata_section($header);
            $child = $occ->append_child($child);
        } // if
    } // if

    // look for optional FOOTER.TXT
    if (file_exists('footer.txt')) {
        $footer = file_get_contents('footer.txt');
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

    if ($_SERVER['SERVER_NAME'] == 'localhost'
    or  $_SERVER['REMOTE_ADDR'] == '80.177.120.119') {
        // write XML data to a disk file in XSL subdirectory for debugging
        $fname = './xsl/' . basename($_SERVER['PHP_SELF']) . '.xml' ;
        if (!$fp = fopen($fname, 'w')) {
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
function getXSLfile ($xml_doc, $xsl_file, $screen=null, &$structure)
// extract name of XSL file from screen structure.
// $structure is passed BY REFERENCE so that it can be updated
{
    if (isset($screen)) {
    	// get subdirectory which matches user's language code
        $subdir = getLanguageSubDir ('./screens');

        $screen = "$subdir/$screen";  // look in subirectory for this screen name
        if (!file_exists($screen)) {
            // 'File $screen cannot be found'
            trigger_error(getLanguageText('sys0056', $screen), E_USER_ERROR);
        } // if

        require $screen;              // import contents of disk file
        if (isset($structure['xsl_file'])) {
            $xsl_file = $structure['xsl_file'];
        } // if
    } // if

    global $protocol;       // HTTP or HTTPS

    // does a local variation of this XSL file exist?
    $filename = './xsl/' .$xsl_file;
    if (!file_exists($filename)) {
        // no, so load from standard area
        $dir = getParentDIR();
        $filename = $_SERVER['DOCUMENT_ROOT'] .$dir .'/xsl/' .$xsl_file;
        $xsl_file = $protocol . $_SERVER['HTTP_HOST'] .$dir .'/xsl/' .$xsl_file;
    } // if

    if (is_true($_SESSION['XSLT_client_side'])) {
    	$pi = $xml_doc->create_processing_instruction('xml-stylesheet', 'type="text/xsl" href="' .$xsl_file .'"');
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

        // convert from internal coding to UTF-8
        $label = convertEncoding($label, DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->create_text_node(trim($label));
        $value = $child->append_child($value);
    } // foreach

    return;

} // setActBar

// ****************************************************************************
function setCSSfiles ($doc, $root, $css_files)
// add contents of $css_files to the current XML document
{
    global $protocol;       // HTTP or HTTPS

    // convert from string to array, if necessary
    if (!is_array($css_files)) {
        $css_files = (array)$css_files;
    } // if

    // if no custom stylesheet is specified use 'style_custom.css' in local directory
    if (empty($css_files)) {
        $css_files[] = $protocol .$_SERVER['SERVER_NAME'] .dirname($_SERVER['PHP_SELF']) .'/style_custom.css';
    } // if

    // prepend the default stylesheet name from base directory
    $dir = getParentDIR();
    array_unshift($css_files, $protocol .$_SERVER['SERVER_NAME'] .$dir .'/style_default.css');

    // add element containing action buttons
    $occ = $doc->create_element('cssfiles');
    $occ = $root->append_child($occ);

    foreach ($css_files as $filename) {
        // add each filename to the xml document
        $child = $doc->create_element('filename');
        $child = $occ->append_child($child);

        // convert from internal coding to UTF-8
        $filename = convertEncoding($filename, DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->create_text_node($filename);
        $value = $child->append_child($value);
    } // foreach

    return;

} // setCSSfiles

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

        // convert from internal coding to UTF-8
        $task_desc = convertEncoding($task_desc, DEFAULT_CHARSET, 'UTF-8');

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
            $data['task_desc'] = getLanguageText($data['task_desc']);

            // convert from internal coding to UTF-8
            $data['task_desc'] = convertEncoding($data['task_desc'], DEFAULT_CHARSET, 'UTF-8');

            $value = $doc->create_text_node(trim($data['task_desc']));
            $value = $child->append_child($value);
        } // foreach
    } // if

    return;

} // setMenuBar

// ****************************************************************************
function setNavBar ($doc, $root, $nav_buttons, $remove_buttons=null)
// add contents of $nav_button array to the current XML document
{
    // remove nominated buttons (if necessary)
    if (count($remove_buttons) > 0) {
        // examine each nominated button
        foreach ($remove_buttons as $script_id) {
            // remove from button array (if found)
        	foreach ($nav_buttons as $num => $button) {
        		if ($button['script_id'] == $script_id) {
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

        // convert from internal coding to UTF-8
        $button['button_text'] = convertEncoding($button['button_text'], DEFAULT_CHARSET, 'UTF-8');

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
        // add this table name as a child to the structure element
        $table = $xml_doc->create_element(strtolower($zone));
        $table = $occ->append_child($table);
        $table->set_attribute('id', strtolower($id));
        // set column values for this table, if present
        if (isset($structure[$zone]['columns'])) {
            $columns = $xml_doc->create_element('columns');
            $columns = $table->append_child($columns);
            foreach ($structure[$zone]['columns'] as $row => $array) {
                $array = array_change_key_case($array, CASE_LOWER);
                foreach ($array as $attrname => $attrvalue) {
                    if ($attrname != 'nosort') {
                        $column = $xml_doc->create_element('column');
                        $column = $columns->append_child($column);
                        $column->set_attribute($attrname, $attrvalue);
                    } // if
                } // foreach
            } // foreach
        } // if

        // test for 'old' format file
        if (is_string(key($structure[$zone]['fields']))) {
            // "FIELDS array for zone '$zone' in screen structure file is not indexed by rownum"
            trigger_error(getLanguageText('sys0053', $zone), E_USER_ERROR);
        } // if

        // extract field details one row at a time
        foreach ($structure[$zone]['fields'] as $row => $rowdata) {
        	$rowocc = $xml_doc->create_element('item');
            $rowocc = $table->append_child($rowocc);
            $key = key($rowdata);
            if (is_string($key)) {
            	// not indexed by cell number, so assume 'fieldid' => 'label'

            	$rowdata = array_change_key_case($rowdata, CASE_LOWER);

            	foreach ($rowdata as $fieldname => $fieldlabel) {
                    if (preg_match('/^(nosort)$/i', $fieldname, $regs)) {
                        // ignore 'nosort' entry
                    } elseif (preg_match('/^(imagewidth|imageheight|colspan|rowspan|size|display-empty)$/i', $fieldname, $regs)) {
                        // write these out as attributes on the current cell
                        $cell->set_attribute($regs[0], $fieldlabel);
                    } else {
                        $cell = $xml_doc->create_element('cell');
                        $cell = $rowocc->append_child($cell);

                        // convert text into output language
                        $fieldlabel = getLanguageText($fieldlabel);

                        // convert from internal coding to UTF-8
                        $fieldlabel = convertEncoding($fieldlabel, DEFAULT_CHARSET, 'UTF-8');
                        $cell->set_attribute('label', $fieldlabel);

                        if (array_key_exists('nosort', $rowdata)) {
                        	$cell->set_attribute('nosort', 'y');
                        } // if

                        $cell = $xml_doc->create_element('cell');
                        $cell = $rowocc->append_child($cell);

                        $cell->set_attribute('field', $fieldname);

                    } // if
                } // foreach
            } else {
                // there is a separate entry for each cell in the current row
                foreach ($rowdata as $cellno => $cellspec) {
                    // create XML element for a new cell
                    $cell = $xml_doc->create_element('cell');
                    $cell = $rowocc->append_child($cell);

                    $cellspec = array_change_key_case($cellspec, CASE_LOWER);

                	foreach ($cellspec as $celltype => $cellvalue) {
                	    if ($celltype == 'label') {
                	    	// convert text into output language
                            $cellvalue = getLanguageText($cellvalue);
                	    } // if
                		// add this entry as an attribute to the current cell
                	    $cell->set_attribute($celltype, $cellvalue);
                	} // foreach
                } // foreach
            } // if
        } // foreach

        // insert tree node data names, if supplied
        if (isset($structure[$zone]['node_data_names'])) {
            $columns = $xml_doc->create_element('node_data_names');
            $columns = $table->append_child($columns);
            foreach ($structure[$zone]['node_data_names'] as $item => $value) {
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

    // disable any caching by the browser
    header('Expires: Mon, 14 Oct 2002 05:00:00 GMT'); // Date in the past
    header('Last-Modified: ' . gmdate("D, d M Y H:i:s") . ' GMT'); // always modified
    header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP 1.1
    header('Cache-Control: post-check=0, pre-check=0', false);
    header('Pragma: no-cache'); // HTTP 1.0

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
    $xsl_time = round($xsl_end - $xsl_start, 5);

    // insert this value into the HTML output
    $result = str_replace('$xsl$', $xsl_time, $result);

    echo $result;

    return;

} // XSLTransform

// ****************************************************************************
?>