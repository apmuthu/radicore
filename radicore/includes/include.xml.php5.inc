<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains functions related to XML and XSL for use with PHP 5

// *****************************************************************************
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

    // get field specifications for current object (inluding item access details)
    $fieldspec = $dbobject->getFieldSpec();

    // get data array for current object (indexed by rownum)
    $objectdata = $dbobject->getFieldArray();

    // process the data one row at a time
    foreach ($objectdata as $rownum => $rowdata) {
        // add a node to identify the name of this database table
        $node = $doc->createElement(strtolower($objectname));
        $node = $parent->appendChild($node);
        if (!is_array($rowdata)) {
            // this is not an array, so output as data now

            // convert from internal coding to UTF-8
            $rowdata = convertEncoding($rowdata, DEFAULT_CHARSET, 'UTF-8');

            // insert as text element for the current node
            $value = $doc->createTextNode($rowdata);
            $value = $node->appendChild($value);
        } else {
            // add a child node for each field
            foreach ($rowdata as $fieldname => $fieldvalue) {
                $child = $doc->createElement($fieldname);
                $child = $node->appendChild($child);
                if (isset($fieldspec[$fieldname])) {
                    // field exists in $fieldspec, so get field specifications
                    $spec = array_change_key_case($fieldspec[$fieldname], CASE_LOWER);
                    // add field size as an attribute
                    if (isset($spec['size'])) {
                        $child->setAttribute('size', $spec['size']);
                    } // if

                    // look for noedit attribute
                    if (isset($spec['noedit'])) {
                        $child->setAttribute('noedit', 'y');
                    } else {
                        // look for primary key attribute
                        if (isset($spec['pkey'])) {
                            $child->setAttribute('pkey', 'y');
                        } // if
                        if (isset($spec['required'])) {
                            $child->setAttribute('required', 'y');
                        } // if
                        // option for password fields
                        if (isset($spec['password'])) {
                            $child->setAttribute('password', 'y');
                        } // if
                    } // if

                    // look for nodisplay/hidden attribute
                    if (isset($spec['nodisplay'])) {
                        $child->setAttribute('nodisplay', 'y');
                        $fieldvalue = '**hidden**';
                    } else {
                        // if an error message exists put it into the error attribute
                        if (!empty($object_errors)) {
                            if (array_key_exists($rownum, $object_errors) and is_array($object_errors[$rownum])) {
                                if (array_key_exists($fieldname, $object_errors[$rownum])) {
                                    $child->setAttribute("error", $object_errors[$rownum][$fieldname]);
                                    unset($object_errors[$rownum][$fieldname]);
                                } // if
                            } // if
                        } // if
                    } // if

                    if (isset($spec['type'])) {
                        if ($spec['type'] == 'boolean') {
                            if (!isset($spec['control'])) {
                                // no 'control' set, so default to radiogroup
                            	$spec['control']    = 'radiogroup';
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
                            $child->setAttribute('control', 'dropdown');
                            $child->setAttribute('optionlist', $spec['optionlist']);
                        } // if
                        // option for filename fields
                        if ($spec['control'] == 'filepicker') {
                            $child->setAttribute('control', 'filepicker');
                            if (isset($spec['task_id'])) {
                                $child->setAttribute('task_id', "task#{$spec['task_id']}");
                            } // if
                            if (isset($spec['subtype']) and $spec['subtype'] == 'image') {
                                $child->setAttribute('image', 'y');
                                if (isset($spec['imagewidth'])) {
                                    $child->setAttribute('imagewidth', $spec['imagewidth']);
                                } // if
                                if (isset($spec['imageheight'])) {
                                    $child->setAttribute('imageheight', $spec['imageheight']);
                                } // if
                            } // if
                        } // if
                        // options for multiline fields
                        if ($spec['control'] == 'multiline') {
                            $child->setAttribute('control', 'multiline');
                            $child->setAttribute('cols', $spec['cols']);
                            $child->setAttribute('rows', $spec['rows']);
                        } // if
                        // option for popup fields
                        if ($spec['control'] == 'popup') {
                            $child->setAttribute('control', 'popup');
                            if (isset($spec['foreign_field'])) {
                                $child->setAttribute('foreign_field', $spec['foreign_field']);
                            } // if
                            if (isset($spec['task_id'])) {
                                $child->setAttribute('task_id', "task#{$spec['task_id']}");
                            } // if
                        } // if
                        // option for radio buttons
                        if ($spec['control'] == 'radiogroup') {
                            $child->setAttribute('control', 'radiogroup');
                            $child->setAttribute('optionlist', $spec['optionlist']);
                            if (isset($spec['align'])) {
                            	$child->setAttribute('align', $spec['align']);
                            } // if
                        } // if
//                    } elseif (isset($spec['type'])) {
//                        if ($spec['type'] == 'boolean') {
//                            $child->setAttribute('control', 'boolean');
//                        } // if
                    } // if
                } else {
                    // field does not exist in $fieldspec, so make it non-editable
                    $child->setAttribute('noedit', 'y');
                } // if

                // convert from internal coding to UTF-8
                $fieldvalue = convertEncoding($fieldvalue, DEFAULT_CHARSET, 'UTF-8');

                // insert as text element for the current node
                $value = $doc->createTextNode($fieldvalue);
                $value = $child->appendChild($value);
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
    $node = $doc->createElement('lookup');
    $node = $root->appendChild($node);

    foreach ($lookup as $lookupname => $optionlist) {
        // add node to contain this list of options
        $occ = $doc->createElement($lookupname);
        $occ = $node->appendChild($occ);
        // add each option as a child node
        foreach ($optionlist as $id => $optvalue) {
            $child = $doc->createElement('option');
            $child = $occ->appendChild($child);
            $child->setAttribute('id', $id);

            // convert from internal coding to UTF-8
            $optvalue = convertEncoding($optvalue, DEFAULT_CHARSET, 'UTF-8');

            $value = $doc->createTextNode($optvalue);
            $value = $child->appendChild($value);
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
    $node = $doc->createElement('params');
    $node = $root->appendChild($node);

    foreach ($xsl_params as $name => $value) {
        // add node to contain this list of options
        $child = $doc->createElement($name);
        $child = $node->appendChild($child);
        if (is_array($value)) {
            // output each entry as a sub-element
            foreach ($value as $name1 => $value1) {
        		$child1 = $doc->createElement($name1);
                $child1 = $child->appendChild($child1);

                // convert from internal coding to UTF-8
                $value1 = convertEncoding($value1, DEFAULT_CHARSET, 'UTF-8');

                $text = $doc->createTextNode($value1);
                $text = $child1->appendChild($text);
        	} // foreach
        } else {
            // convert from internal coding to UTF-8
            $value = convertEncoding($value, DEFAULT_CHARSET, 'UTF-8');

            $text = $doc->createTextNode($value);
            $text = $child->appendChild($text);
        } // if
    } // foreach

    return;

} // addParams2XML

// ****************************************************************************
function buildXML ($xml_objects, $errors=null, $messages=null)
// build XML document using the database objects identified in $xml_objects
{
    // test that DOM XML funcions are available
    if (!class_exists('DomDocument')) {
        trigger_error(getLanguageText('sys0070', 'DOM'), E_USER_ERROR); // 'DOM functions are not available.'
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
    $xml_doc = new DomDocument('1.0', 'UTF-8');

    // get name of XSL file
    $structure = '';
    $xsl_file = getXSLfile($xml_doc, $xsl_file, $screen, $structure);

    // add root node
    $node_array['root'] = $xml_doc->createElement('root');
    $root = $xml_doc->appendChild($node_array['root']);

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
	            $xsl_params['print_preview'] = 'true';
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
        $occ = $xml_doc->createElement('errmsg');
        $occ = $root->appendChild($occ);
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
                $child = $xml_doc->createElement('line');
                $child = $occ->appendChild($child);

                // convert from internal coding to UTF-8
                $msg = convertEncoding($msg, DEFAULT_CHARSET, 'UTF-8');

                $value = $xml_doc->createTextNode($msg);
                $value = $child->appendChild($value);
            } // foreach
        } // foreach
    } // if

    if (!empty($messages)) {
        // add messages which are not errors to their own area
        if (!is_array($messages)) {
            $messages[] = $messages;
        } // if
        // add node to hold error lines
        $occ = $xml_doc->createElement('infomsg');
        $occ = $root->appendChild($occ);
        foreach ($messages as $rownum => $msg) {
            $child = $xml_doc->createElement('line');
            $child = $occ->appendChild($child);

            // convert from internal coding to UTF-8
            $msg = convertEncoding($msg, DEFAULT_CHARSET, 'UTF-8');

            $value = $xml_doc->createTextNode($msg);
            $value = $child->appendChild($value);
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
            $occ = $xml_doc->createElement('header');
            $occ = $root->appendChild($occ);
            $child = $xml_doc->createCDATASection($header);
            $child = $occ->appendChild($child);
        } // if
    } // if

    // look for optional FOOTER.TXT
    if (file_exists('footer.txt')) {
        $footer = file_get_contents('footer.txt');
        if (!empty($footer)) {
            $occ = $xml_doc->createElement('footer');
            $occ = $root->appendChild($occ);
            $child = $xml_doc->createCDATASection($footer);
            $child = $occ->appendChild($child);
        } // if
    } // if

    // add optional parameters
    addParams2XMLdoc ($xml_doc, $root, $xsl_params);

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
            fclose($fp);
            $xml_doc->formatOutput = true;
            if ($xml_doc->save($fname) === false) {
                // "Cannot write to file $fname"
                trigger_error(getLanguageText('sys0055', $fname));
            } // if
        } // if
    } // if

    if (is_true($_SESSION['XSLT_client_side'])) {
        // send XML file to the client for transformation there
        $xml_string = $xml_doc->saveXML();
        XSLclient($xml_string);
    } else {
        // transform XML document using XSL file
        XSLTransform($xml_doc, $xsl_file);
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
    	$pi = $xml_doc->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="' .$xsl_file .'"');
    	$xml_doc->appendChild($pi);
    } // if

    return $filename;

} // get XSLfile

// ****************************************************************************
function setActBar ($doc, $root, $act_buttons)
// add contents of $act_buttons to the current XML document
{
    // add element containing action buttons
    $occ = $doc->createElement('actbar');
    $occ = $root->appendChild($occ);

    foreach ($act_buttons as $button => $label) {
        // add each button to the xml document
        $child = $doc->createElement('button');
        $child = $occ->appendChild($child);
        $child->setAttribute('id', $button);

        // convert text into output language
        $label = getLanguageText($label);

        // convert from internal coding to UTF-8
        $label = convertEncoding($label, DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->createTextNode(trim($label));
        $value = $child->appendChild($value);
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
    $occ = $doc->createElement('cssfiles');
    $occ = $root->appendChild($occ);

    foreach ($css_files as $filename) {
        // add each filename to the xml document
        $child = $doc->createElement('filename');
        $child = $occ->appendChild($child);

        // convert from internal coding to UTF-8
        $filename = convertEncoding($filename, DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->createTextNode($filename);
        $value = $child->appendChild($value);
    } // foreach

    return;

} // setCSSfiles

// ****************************************************************************
function setMenuBar ($doc, $root, $menu_buttons, $current_menu, $current_task)
// add contents of $menu_buttons table to the current XML document.
{
    // add element containing navigation buttons
    $occ = $doc->createElement('menubar');
    $occ = $root->appendChild($occ);

    foreach ($menu_buttons as $task_id => $task_desc) {
        // add each button to the xml document
        $child = $doc->createElement('button');
        $child->setAttribute('id', $task_id);
        if ($task_id == $current_task) {
            $child->setAttribute('active', 'y');
        } // if
        $child = $occ->appendChild($child);

        // convert text into output language
        $task_desc = getLanguageText($task_desc);

        // convert from internal coding to UTF-8
        $task_desc = convertEncoding($task_desc, DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->createTextNode(trim($task_desc));
        $value = $child->appendChild($value);
    } // foreach

    if (isset($GLOBALS['page_stack'])) {
        // insert stack which identifies the sequence of pages used so far (aka 'breadcrumbs')
        $page_stack = $GLOBALS['page_stack'];
        foreach ($page_stack as $task_id => $data) {
            $child = $doc->createElement('stack');
            $child->setAttribute('id', $task_id);
            if ($task_id == $current_menu) {
                $child->setAttribute('active', "y");
            } // if
            $child = $occ->appendChild($child);

            // convert text into output language
            $data['task_desc'] = getLanguageText($data['task_desc']);

            // convert from internal coding to UTF-8
            $data['task_desc'] = convertEncoding($data['task_desc'], DEFAULT_CHARSET, 'UTF-8');

            $value = $doc->createTextNode(trim($data['task_desc']));
            $value = $child->appendChild($value);
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
    $occ = $doc->createElement('navbar');
    $occ = $root->appendChild($occ);

    foreach ($nav_buttons as $button) {
        // add each button to the xml document
        $child = $doc->createElement('button');
        $child->setAttribute('id', "task#{$button['task_id']}");
        $child->setAttribute('context_preselect', "{$button['context_preselect']}");
        $child = $occ->appendChild($child);

        // convert text into output language
        $button['button_text'] = getLanguageText($button['button_text']);

        // convert from internal coding to UTF-8
        $button['button_text'] = convertEncoding($button['button_text'], DEFAULT_CHARSET, 'UTF-8');

        $value = $doc->createTextNode(trim($button['button_text']));
        $value = $child->appendChild($value);
    } // foreach

    return;

} // setNavBar

// ****************************************************************************
function setPaginationBar ($xml_doc, $root, $pagination)
// insert (optional) pagination details for any number of objects
// into the current XML document
{
    $occ = $xml_doc->createElement('pagination');
    $occ = $root->appendChild($occ);

    // create a separate child node for each table
    foreach ($pagination as $object => $objectlist) {
        $child = $xml_doc->createElement('page');
        $child = $occ->appendChild($child);
        $child->setAttribute('id', $object);
        foreach ($objectlist as $itemname => $itemvalue) {
            if ($itemname <> 'where') {
                $child->setAttribute($itemname, $itemvalue);
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
    $occ = $xml_doc->createElement('structure');
    $occ = $root->appendChild($occ);

    // structure may contain one or more tables, so step through each one
    foreach ($structure['tables'] as $zone => $id) {
        // add this table name as a child to the structure element
        $table = $xml_doc->createElement(strtolower($zone));
        $table = $occ->appendChild($table);
        $table->setAttribute('id', strtolower($id));
        // set column values for this table, if present
        if (isset($structure[$zone]['columns'])) {
            $columns = $xml_doc->createElement('columns');
            $columns = $table->appendChild($columns);
            foreach ($structure[$zone]['columns'] as $row => $array) {
                $array = array_change_key_case($array, CASE_LOWER);
                foreach ($array as $attrname => $attrvalue) {
                    if ($attrname != 'nosort') {
                        $column = $xml_doc->createElement('column');
                        $column = $columns->appendChild($column);
                        $column->setAttribute($attrname, $attrvalue);
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
        	$rowocc = $xml_doc->createElement('item');
            $rowocc = $table->appendChild($rowocc);
            $key = key($rowdata);
            if (is_string($key)) {
            	// not indexed by cell number, so assume 'fieldname' => 'label'

            	$rowdata = array_change_key_case($rowdata, CASE_LOWER);

            	foreach ($rowdata as $fieldname => $fieldlabel) {
                    if (preg_match('/^(nosort)$/i', $fieldname, $regs)) {
                        // ignore 'nosort' entry
                    } elseif (preg_match('/^(imagewidth|imageheight|colspan|rowspan|size|display-empty)$/i', $fieldname, $regs)) {
                        // write these out as attributes on the current cell
                        $cell->setAttribute($regs[0], $fieldlabel);
                    } else {
                        $cell = $xml_doc->createElement('cell');
                        $cell = $rowocc->appendChild($cell);

                        // convert text into output language
                        $fieldlabel = getLanguageText($fieldlabel);

                        // convert from internal coding to UTF-8
                        $fieldlabel = convertEncoding($fieldlabel, DEFAULT_CHARSET, 'UTF-8');
                        $cell->setAttribute('label', $fieldlabel);

                        if (array_key_exists('nosort', $rowdata)) {
                        	$cell->setAttribute('nosort', 'y');
                        } // if

                        $cell = $xml_doc->createElement('cell');
                        $cell = $rowocc->appendChild($cell);

                        $cell->setAttribute('field', $fieldname);

                    } // if
                } // foreach
            } else {
                // there is a separate entry for each cell in the current row
                foreach ($rowdata as $cellno => $cellspec) {
                    // create XML element for a new cell
                    $cell = $xml_doc->createElement('cell');
                    $cell = $rowocc->appendChild($cell);

                    $cellspec = array_change_key_case($cellspec, CASE_LOWER);

                	foreach ($cellspec as $celltype => $cellvalue) {
                	    if ($celltype == 'label') {
                	    	// convert text into output language
                            $cellvalue = getLanguageText($cellvalue);
                	    } // if
                		// add this entry as an attribute to the current cell
                	    $cell->setAttribute($celltype, $cellvalue);
                	} // foreach
                } // foreach
            } // if
        } // foreach

        // insert tree node data names, if supplied
        if (isset($structure[$zone]['node_data_names'])) {
            $columns = $xml_doc->createElement('node_data_names');
            $columns = $table->appendChild($columns);
            foreach ($structure[$zone]['node_data_names'] as $item => $value) {
                // write the contents of the array as attributes
                $columns->setAttribute(strtolower($item), $value);
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
    $occ = $xml_doc->createElement('scrolling');
    $occ = $root->appendChild($occ);

    // create a separate child node for each table
    foreach ($scrolling as $object => $objectlist) {
        $child = $xml_doc->createElement('scroll');
        $child = $occ->appendChild($child);
        $child->setAttribute('id', strtolower($object));
        foreach ($objectlist as $itemname => $itemvalue) {
            if ($itemname <> 'where') {
                $child->setAttribute($itemname, $itemvalue);
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
function XSLTransform ($xml_doc, $xsl_file)
// transform XML into HTML using XSL file
// $xml_doc  = XML document
// $xsl_file = name of external xsl file
{
    // test that XSL funcions are available
    if (!class_exists('XsltProcessor')) {
        // 'XSL functions are not available.'
        trigger_error(getLanguageText('sys0070', 'XSL'), E_USER_ERROR);
    } // if

    set_error_handler('XML_errorHandler');

    // fetch the XSL stylesheet and load it into a DOM document
    $xsl = new DomDocument;
    $xsl->load($xsl_file);

    // create the XSLT processor and load the XSL file
    $xp = new XsltProcessor();
    $xp->importStylesheet($xsl);

    // set charset to display accented characters correctly
    header('content-type:text/html; charset=UTF-8');

    // disable any caching by the browser
    header('Expires: Mon, 14 Oct 2002 05:00:00 GMT');               // Date in the past
    header('Last-Modified: ' . gmdate("D, d M Y H:i:s") . ' GMT');  // always modified
    header('Cache-Control: no-store, no-cache, must-revalidate');   // HTTP 1.1
    header('Cache-Control: post-check=0, pre-check=0', false);
    header('Pragma: no-cache');                                     // HTTP 1.0

    // set start time of XSL transformation
    list($usec, $sec) = explode(' ', microtime());
    $xsl_start = (float) $sec + (float) $usec;

    // transform the XML into HTML using the XSL file
    if (!$html = $xp->transformToXML($xml_doc)) {
        // 'XSL transformation failed.'
        trigger_error(getLanguageText('sys0072'), E_USER_ERROR);
    } // if

    // free the resources occupied by the XSLT processor
    unset($xp);

    set_error_handler('errorHandler');

    // calculate the function's elapsed time
    list($usec, $sec) = explode(' ', microtime());
    $xsl_end = (float) $sec + (float) $usec;
    $xsl_time = round($xsl_end - $xsl_start, 5);

    // insert this value into the HTML output
    $html = str_replace('$xsl$', $xsl_time, $html);

    echo $html;

    return;

} // XSLTransform

// ****************************************************************************
?>