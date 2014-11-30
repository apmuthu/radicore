<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require_once 'tcpdf/tcpdf_php4.php';
} else {
    // PHP 5 uses different code
    require_once 'tcpdf/tcpdf_php5.php';
} // if

class PDF extends TCPDF
{
    // member variables
    var $previous_row;              // used by the printFooter() method
    var $dbobject;                  // the database object from which this is being activated
    var $default_padding;           // default padding betwe tex and cell border
    var $pdf_destination = 'I';     // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String
    var $fieldarray = array();      // array of field data
    var $filename = '';             // filename (if destination = D or F)
    var $last_height;               // last line height
    var $line_width = .2;           // width for line drawing (borders, boxes, etc)
    var $new_page = false;          // set to TRUE when a new page has been started
    var $new_page_fill;             // set to TRUE when a new page has been started
    var $printable_width;           // width of printable area (without margins)
    var $save_y_pos = array();      // save 'y' positions for reuse
    var $structure = array();       // report structure
    var $style = array();           // array of print styles
    var $total_width = 0;           // total width of all cells

    var $print_header = FALSE;      // do not print page header
    var $print_footer = FALSE;      // do not print page footer

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function PDF ($structure, &$dbobject, $pdfout=null)
    // validate contents of $report structure file
    {
    	$this->style = $this->loadStyleFile();

        $structure = $this->validateStructure($structure);

        // make sure that the two objects can communicate with each other
        $this->dbobject      =& $dbobject;
        $this->dbobject->pdf =& $this;

        $this->report_structure     =& $structure;
        $dbobject->report_structure =& $structure;

        if (!empty($pdfout)) {
            $this->pdf_filename     = $pdfout;
        } // if

        $dbobject->pdf_destination  =& $this->pdf_destination;
        $dbobject->pdf_filename     =& $this->pdf_filename;

        return;

    } // PDF

    // ****************************************************************************
    function AddPage ($orientation=null, $format=null, $keepmargins=false, $tocpage=false)
    // start a new page.
    {
        $save_last_height = $this->last_height;
        parent::AddPage ($orientation, $format, $keepmargins, $tocpage);
        $this->last_height = $save_last_height;

    } // addPage

    // ****************************************************************************
    function addUnderscore($array)
    // insert an underscore to change all occurrences of 'marginX' to 'margin_X'.
    {
        $array = array_change_key_case($array, CASE_LOWER);

        if (isset($array['marginleft'])) {
        	$array['margin_left'] = $array['marginleft'];
        	unset($array['marginleft']);
        } // if

        if (isset($array['marginright'])) {
        	$array['margin_right'] = $array['marginright'];
        	unset($array['marginright']);
        } // if

        if (isset($array['margintop'])) {
        	$array['margin_top'] = $array['margintop'];
        	unset($array['margintop']);
        } // if

        if (isset($array['marginbottom'])) {
        	$array['margin_bottom'] = $array['marginbottom'];
        	unset($array['marginbottom']);
        } // if

        if (isset($array['paddingleft'])) {
        	$array['padding_left'] = $array['paddingleft'];
        	unset($array['paddingleft']);
        } // if

        if (isset($array['paddingright'])) {
        	$array['padding_right'] = $array['paddingright'];
        	unset($array['paddingright']);
        } // if

        if (isset($array['paddingtop'])) {
        	$array['padding_top'] = $array['paddingtop'];
        	unset($array['paddingtop']);
        } // if

        if (isset($array['paddingbottom'])) {
        	$array['padding_bottom'] = $array['paddingbottom'];
        	unset($array['paddingbottom']);
        } // if

        return $array;

    } // addUnderscore

    // ****************************************************************************
    function adjustColumnWidths ($columns)
    // examine all column widths to turn pecentages into numbers.
    {
        $width_used = 0;
        $col_remainder = array();  // columns which have width set to '*'

        foreach ($columns as $colnum => $coldata) {
            if (is_array($coldata)) {
                if (array_key_exists('width', $coldata)) {
                    if (preg_match('/^(\*)$/', $coldata['width'])) {
                        // width is '*', to be set to remainder after all other columns have been done
                        $col_remainder[] = $colnum;
                    } else {
                        if (preg_match('/(%)$/', $coldata['width'])) {
                            // contains a percentage, so turn it into a number
                            $percent = substr($coldata['width'], 0, -1);  // strip off trailing '%' character
                            $coldata['width'] = $this->printable_width * ($percent / 100);
                            // update input array - this is required for PHP 4
                            $columns[$colnum]['width'] = $coldata['width'];
                        } // if
                        // accumulate total width used
                        $width_used += $coldata['width'];
                    } // if
                } // if
            } // if
        } // foreach

        if (!empty($col_remainder)) {
            // divide the remainder by the number of columns
            $remainder = ($this->printable_width - $width_used) / count($col_remainder);
            // set all specified columns to take up the remainder equally
            foreach ($col_remainder as $colnum) {
                $columns[$colnum]['width'] = $remainder;
            } // foreach
        } // if

        return $columns;

    } // adjustColumnWidths

    // ****************************************************************************
    function adjustColumnWidthsDetailView ($structure)
    // examine all column widths to turn pecentages into numbers.
    {
        if (!empty( $structure['columns'])) {
            $structure['columns'] = $this->adjustColumnWidths($structure['columns']);
        } // if

        if (array_key_exists('body', $structure)) {
            foreach ($structure['body']['fields'] as $column => $columndata) {
                if (is_string(key($columndata))) {
                    // not indexed by cell number, so assume 'fieldname' => 'labeltext'
                } else {
                    // examine column widths for percentages and turn them into numbers
                    $columndata = $this->adjustColumnWidths($columndata);
                } // if
                $structure['body']['fields'][$column] = $columndata;
            } // foreach
        } // if

        // examine any optional additional entries named 'multi1' to 'multi99'
        for ($i = 1; $i <= 100; $i++) {
            $zone = 'multi' .$i;
            if (!array_key_exists($zone, $structure)) {
                break;  // not found, so stop processing
            } // if
            foreach ($structure[$zone]['fields'] as $column => $columndata) {
                if (is_string(key($columndata))) {
                    // not indexed by cell number, so assume 'fieldname' => 'labeltext'
                } else {
                    // examine column widths for percentages and turn them into numbers
                    $columndata = $this->adjustColumnWidths($columndata);
                } // if
                $structure[$zone]['fields'][$column] = $columndata;
            } // foreach
        } // for

        return $structure;

    } // adjustColumnWidthsDetailView

    // ****************************************************************************
    function Cell ($w, $h=0, $txt='', $border=0, $ln=0, $align='', $fill=0, $link='', $stretch=0, $ignore_min_height=false, $calign='T', $valign='M')
    // this is a wrapper for the parent method
    {
        // reduce to single character, upper case
        $align  = strtoupper(substr($align, 0, 1));
        $calign = strtoupper(substr($calign, 0, 1));
        $valign = strtoupper(substr($valign, 0, 1));
        if (!empty($stretch)) {
        	$stretch = 4;  // forced character spacing
        } // if

        parent::Cell ($w, $h, $txt, $border, $ln, $align, $fill, $link, $stretch, $ignore_min_height, $calign, $valign);

    } // Cell

    // ****************************************************************************
    function detailView (&$dbobject, $resource)
    // output data in DETAIL view (one record per page, labels on left, data on right)
    {
        $this->structure  =& $this->report_structure;

        // examine column widths for percentages and turn them into numbers
        $this->structure = $this->adjustColumnWidthsDetailView($this->structure);

        if (method_exists($this, 'AliasNbPages')) {
            // turn on page header and footer
            $this->AliasNbPages();
        } // if
        if (isset($this->structure['title'])) {
            foreach ($this->structure['title'] as $key => $value) {
            	 if (is_integer($key)) {
            	     $this->print_header = true;
            	     break;
            	 } // if
            } // foreach
        } // if
        if (isset($this->structure['foot1']) OR isset($this->structure['foot2'])) {
            $this->print_footer = true;
        } // if

        $fieldspec = $dbobject->fieldspec;

        $first_body_line = true;
        $border = 1;
        $fill = 1;

        $save_party_language = $GLOBALS['party_language'];

        // add each row to the document in a separate page
        while ($fieldarray = $dbobject->fetchRow($resource)) {
            if ($dbobject->errors) return;

            if ($GLOBALS['party_language'] != $save_party_language) {
                $save_destination = $this->pdf_destination;
                // reload report structure in the customer's language
                $this->structure = getFileStructure($GLOBALS['report'], './reports');
            	$this->structure = $this->validateStructure($this->structure);
            	$this->structure = $this->adjustColumnWidthsDetailView($this->structure);
                $this->style = $this->loadStyleFile();  // reload 'pdf.styles.inc' file
                $result = $this->replaceFonts($GLOBALS['party_language']);
                $this->pdf_destination = $save_destination;
                $save_party_language = $GLOBALS['party_language'];
            } // if

            // perform any formatting on retrieved data
            $style_array = array();
            $fieldarray_formatted = $dbobject->formatData($fieldarray, $style_array);
            $fieldarray_formatted = array_change_key_case($fieldarray_formatted, CASE_LOWER);
            $this->fieldarray = $fieldarray_formatted;  // make this accessible to Header() method
            $this->dbobject->fieldarray = $fieldarray_formatted;    // make this accessible to dbobject
            $this->AddPage();      // start a new page for each record
            if (array_key_exists('body', $this->structure) AND array_key_exists('fields', $this->structure['body'])) {
                // output each field in the required order
                foreach ($this->structure['body']['fields'] as $column => $columndata) {
                    if ($first_body_line) {
                        if (array_key_exists('title', $this->structure)) {
                            if (isset($this->structure['title']['body_gap'])) {
                        	    $gap = $this->structure['title']['body_gap'];
                        	} else {
                        	    $gap = $this->millimeters2units(1);  // default is 1mm
                        	} // if
                        	if ($gap > 0) {
                        		$this->setY($this->getY() + $gap);  // leave a gap under the title
                        	} // if
                        } // if
                	    $first_body_line = false;
                    } // if
                    if (is_string(key($columndata))) {
                	    // not indexed by cell number, so assume 'fieldname' => 'labeltext'

                	    $columndata = array_change_key_case($columndata, CASE_LOWER);
                	    $fieldname  = key($columndata);
                	    $fieldlabel = $columndata[$fieldname];

                	    // construct a row containing a label and a data cell
                        $print_array = array();

                        // start with label
                        $cellspec = $this->structure['columns'][0];
                        $cellspec['default_style'] = $this->structure['label']['style'];
                        $cellspec['text']  = getLanguageText($fieldlabel);

                	    if (!isset($cellspec['width'])) {
                            // not set, so default to 1/4 of page width
                		    $cellspec['width'] = $this->printable_width / 4;
                	    } // if

                        if (isset($cellspec['align'])) {
                            // 'align' is deprecated, use 'halign' instead
                            $cellspec['halign'] = $cellspec['align'];
                            unset($cellspec['align']);
                        } // if

                        $print_array[0] = $cellspec;

                        // follow with field data
                        $cellspec = $this->structure['columns'][1];
                        $cellspec = array_merge($cellspec, $columndata);
                        $cellspec['default_style'] = $this->structure['data']['style'];
                        if (array_key_exists('ignore_if_empty', $this->style[$cellspec['default_style']])) {
                    	    $cellspec['ignore_if_empty'] = $this->style[$cellspec['default_style']]['ignore_if_empty'];
                        } // if
                        if (array_key_exists($fieldname, $style_array)) {
                    	    $cellspec['style'] = $style_array[$fieldname];
                        } // if

                        if (isset($fieldarray_formatted[$fieldname])) {
                    	    $cellspec['text'] = $fieldarray_formatted[$fieldname];
                        } else {
                            $cellspec['text'] = '';
                        } // if

                        if (array_key_exists($fieldname, $fieldspec)) {
                		    $cellspec['fieldspec'] = $fieldspec[$fieldname];
                	    } // if

                	    if (array_key_exists('notext', $columndata)) {
                	        // carry this specification change across
                		    $cellspec['fieldspec']['notext'] = 'y';
                	    } // if

                        if (!isset($cellspec['width'])) {
                            // not set, so default to 3/4 of page width
                            $cellspec['width'] = $this->printable_width / (3/4);
                        } // if

                	    if (isset($cellspec['align'])) {
                            // 'align' is deprecated, use 'halign' instead
                            $cellspec['halign'] = $cellspec['align'];
                            unset($cellspec['align']);
                        } // if

                        if (empty($cellspec['text']) AND array_key_exists('ignore_if_empty', $cellspec)) {
                            // do not print an empty line
                        } else {
                    	    $print_array[1] = $cellspec;
                    	    $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);
                        } // if

                    } else {
                        // there is a separate entry for each label or field in the current line

                        // construct a row of cells which are to be printed
                        $print_array = array();
                        foreach ($columndata as $cellno => $cellspec) {
                            // change all occurrences of 'marginX' to 'margin_X'
                            $cellspec = $this->addUnderscore($cellspec);

                            if (!isset($cellspec['width'])) {
                                if (!empty($this->structure['columns'])) {
                                	if (!empty($this->structure['columns'][$cellno]['width'])) {
                                	    $cellspec['width'] = $this->structure['columns'][$cellno]['width'];
                                	} // if
                                } // if
                                if (!isset($cellspec['width'])) {
                        		    // default is width divided by number of columns
                        	        $cellspec['width'] = $this->printable_width / count($columndata);
                                } // if
                    	    } // if

                            if (array_key_exists('label', $cellspec)) {
                                // this cell contains a label
                                $cellspec['default_style'] = $this->structure['label']['style'];
                                $cellspec['text']  = getLanguageText($cellspec['label']);

                            } elseif (array_key_exists('field', $cellspec)) {
                                // print a cell containing field data
                                $cellspec['default_style'] = $this->structure['data']['style'];
                        	    $fieldname = $cellspec['field'];
                                if (isset($fieldarray_formatted[$fieldname])) {
                            	    $cellspec['text'] = $fieldarray_formatted[$fieldname];
                                } else {
                                    $cellspec['text'] = '';
                                } // if
                	            if (array_key_exists($fieldname, $fieldspec)) {
                        		    $cellspec['fieldspec'] = $fieldspec[$fieldname];
                        	    } // if
                        	    if (array_key_exists('notext', $cellspec)) {
                        	        // carry this specification change across
                        		    $cellspec['fieldspec']['notext'] = 'y';
                        		    unset($cellspec['notext']);
                        	    } // if

                            } elseif (array_key_exists('barcode', $cellspec)) {
                                if (array_key_exists($cellspec['barcode'], $fieldarray)) {
                            	    $cellspec['barcode'] = $fieldarray[$cellspec['barcode']];
                                } else {
                                    $cellspec['barcode'] = '';
                                } // if

                            } // if

                            $print_array[] = $cellspec;

                        } // foreach

                        $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);

                    } // if
                } // foreach
            } // if

            // examine any optional additional entries named 'multi1' to 'multi99'
//            for ($i = 1; $i <= 100; $i++) {
//                $zone = 'multi' .$i;
//                if (!array_key_exists($zone, $this->structure)) {
//                	break;  // not found, so stop processing
//                } // if
//                $this->detailView_multi($dbobject, $zone, $fieldarray);
//            } // for
            // (perform them in the order in which they were defined in the structure file)
            foreach ($this->structure as $zone => $zone_spec) {
                if (preg_match('/(?<=multi)[0-9]{1,2}/i', $zone, $regs)) {
                    $zone_no = $regs[0];
                    $this->detailView_multi($dbobject, $zone, $fieldarray);
                } // if
            } // foreach

            $first_body_line = true;

        } // while

        return;

    } // detailView

    // ****************************************************************************
    function detailView_multi (&$dbobject, $zone, $current_row)
    // append additional data to the current page, where this additional data is
    // obtained by making callbacks to the database object.
    {
        // obtain a number of rows of data for this named area
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_output_multi')) {
                $newdata = $dbobject->custom_processing_object->_cm_output_multi($zone, $current_row);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $newdata = $dbobject->_cm_output_multi($zone, $current_row);
        } // if

        $fieldspec = $dbobject->fieldspec;

        $border = 1;
        $fill   = 1;

        $nbsp = chr(194).chr(160); // non-breaking space

        if (is_array($newdata)) {
            // process each row, which may produce multiple lines of output
            foreach ($newdata as $rownum => $fieldarray) {
                $style_array = array();
                $fieldarray = $dbobject->formatData($fieldarray, $style_array);
                // construct a row of cells which are to be printed
                foreach ($this->structure[$zone]['fields'] as $column => $columndata) {
                    $print_array = array();
                    // construct $cellspec for each cell, then add it to $print_array
                    foreach ($columndata as $cellno => $cellspec) {
                        if (empty($cellspec['field'])) {
                            $fieldname = null;
                        } else {
                            $fieldname = $cellspec['field'];
                            if (array_key_exists($fieldname, $style_array)) {
                                $cellspec['style'] = $style_array[$fieldname];
                            } // if
                        } // if
                        // change all occurrences of 'marginX' to 'margin_X'
                        $cellspec = $this->addUnderscore($cellspec);
                        if (!empty($cellspec['align'])) {
                            // rename 'align' to 'halign'
                    	    $cellspec['halign'] = $cellspec['align'];
                    	    unset($cellspec['align']);
                        } // if
                        if (array_key_exists('label', $cellspec)) {
                            $cellspec['default_style'] = $this->structure['label']['style'];
                            $cellspec['text'] = getLanguageText($cellspec['label']);

                        } elseif (array_key_exists('barcode', $cellspec)) {
                            if (array_key_exists($cellspec['barcode'], $fieldarray)) {
                                $cellspec['barcode'] = $fieldarray[$cellspec['barcode']];
                            } else {
                                $cellspec['barcode'] = '';
                            } // if

                        } elseif (array_key_exists('image', $cellspec)) {
                            $cellspec['default_style'] = $this->structure['data']['style'];
                            if (substr($cellspec['image'], 0, 2) == '%%') {
                                // replace field name with field data
                                $imagename = substr($cellspec['image'], 2);
                                if (isset($fieldarray[$imagename])) {
                                    $imagename = $fieldarray[$imagename];
                                } // if
                                $cellspec['image'] = $imagename;
                            } // if

                        } elseif (array_key_exists('field', $cellspec)) {
                            $cellspec['default_style'] = $this->structure['data']['style'];
                            if (array_key_exists($cellspec['field'], $fieldarray)) {
                        	    $cellspec['text'] = $fieldarray[$cellspec['field']];
                        	    // replace HTML non-breaking space with a blank character
                        	    $cellspec['text'] = str_replace('&nbsp;', $nbsp, $cellspec['text']);
                            } else {
                                $cellspec['text'] = '';
                            } // if
                            if (array_key_exists($cellspec['field'], $fieldspec)) {
                                // include field specifications
                                $cellspec['fieldspec'] = $fieldspec[$cellspec['field']];
                            } // if
                            if (array_key_exists('notext', $cellspec)) {
                    	        // carry this specification change across
                    		    $cellspec['fieldspec']['notext'] = 'y';
                    	    } // if

                        } else {
                            $cellspec['text'] = '';
                        } // if
                        if (!isset($cellspec['width'])) {
                		    // default is page width divided by number of columns
                	        $cellspec['width'] = $this->printable_width / count($columndata);
                	    } // if
                        $print_array[] = $cellspec;
                    } // foreach

                    // now print this row of cells
                    $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);

                } // foreach
            } // foreach
        } // if

        return;

    } // detailView_multi

    // ****************************************************************************
    function Error ($msg)
    // call standard error handler
    {
        trigger_error($msg, E_USER_ERROR);

    } // Error

    // ****************************************************************************
    function Footer ()
    // define a page footer
    {
        if (!is_True($this->print_footer)) {
        	return;  // do not print a page footer
        } // if

        if (!isset($this->structure['foot'])) {
            return;
        } // if

        // close bottom border on current line
        $this->Line($this->lMargin, $this->getY(), $this->lMargin + $this->total_width, $this->getY());

        // set print style for footer
        if (!isset($this->structure['foot']['style'])) {
        	$this->structure['foot']['style'] = 'default';
        } // if

        if (isset($this->structure['pdf']['margin_bottom'])) {
        	$this->SetY($this->h - $this->structure['pdf']['margin_bottom'] + $this->millimeters2units(1));
        } else {
            // Position at 15mm from bottom
            $this->SetY($this->h - $this->millimeters2units(15));
        } // if

        $this->printFooter('foot1');
        if (isset($this->structure['foot2'])) {
            $this->Ln();  // start new line
        	$this->printFooter('foot2');
        } // if

        return;

    } // Footer

    // ****************************************************************************
    function getLineCount ($celldata)
    // count the number of lines that this cell will use when printed.
    // individual lines are extracted and added to $celldata['line_array'].
    {
        // set current font to this cell's desired font
        $height  = 0;
        $halign  = 'Left';
        $valign  = 'Middle';
        $stretch = null;
        $draw    = null;

        if (isset($celldata['barcode_style'])) {
    		$result = $this->setBarcodeStyle($celldata['barcode_style']);
        	$celldata = array_merge($result, $celldata);
        } else {
            $result = $this->setPrintStyle($celldata['default_style']);
            $count = extract($result, EXTR_IF_EXISTS);
            if (isset($celldata['style'])) {
            	$result = $this->setPrintStyle($celldata['style'], $result);
            	$count = extract($result, EXTR_IF_EXISTS);
            } // if
        } // if

        if (isset($result['nofillcolour'])) {
            $celldata['nofillcolour'] = $result['nofillcolour'];
        } // if

        if (isset($result['padding_left']) AND !isset($celldata['padding_left'])) {
            $celldata['padding_left']   = $result['padding_left'];
        } // if
        if (isset($result['padding_right']) AND !isset($celldata['padding_right'])) {
            $celldata['padding_right']  = $result['padding_right'];
        } // if
        if (isset($result['padding_top']) AND !isset($celldata['padding_top'])) {
            $celldata['padding_top']    = $result['padding_top'];
        } // if
        if (isset($result['padding_bottom']) AND !isset($celldata['padding_bottom'])) {
            $celldata['padding_bottom'] = $result['padding_bottom'];
        } // if

        if (isset($result['margin_left']) AND !isset($celldata['margin_left'])) {
            $celldata['margin_left']   = $result['margin_left'];
        } // if
        if (isset($result['margin_right']) AND !isset($celldata['margin_right'])) {
            $celldata['margin_right']  = $result['margin_right'];
        } // if
        if (isset($result['margin_top']) AND !isset($celldata['margin_top'])) {
            $celldata['margin_top']    = $result['margin_top'];
        } // if
        if (isset($result['margin_bottom']) AND !isset($celldata['margin_bottom'])) {
            $celldata['margin_bottom'] = $result['margin_bottom'];
        } // if

        if (isset($celldata['height']) AND !isset($celldata['barcode_style'])) {
        	$this->last_height = $celldata['height'];
        } else {
            // use largest font height
            if ($this->last_height < $height) {
            	$this->last_height = $height;
            } // if
        } // if

        if (empty($celldata['height'])) {
        	$celldata['height'] = $height;
        } // if

        $paddings          = $this->getCellPaddings();
        if (isset($celldata['padding_left'])) {
            $paddings['L'] = $celldata['padding_left'];
        } // if
        if (isset($celldata['padding_right'])) {
            $paddings['R'] = $celldata['padding_right'];
        } // if

        // printable width excludes left and right padding
        $cell_width = $celldata['width'] - $paddings['L'] - $paddings['R'];

        if (isset($celldata['fieldspec']) AND isset($celldata['fieldspec']['subtype'])) {
    		if ($celldata['fieldspec']['subtype'] == 'image') {
    		    $image_width  = $this->pixelsToUnits($celldata['fieldspec']['imagewidth']);
    		    $image_height = $this->pixelsToUnits($celldata['fieldspec']['imageheight']);
    		    if (!isset($celldata['image_offset'])) {
    		        $celldata['image_offset'] = 0;
    		    } else {
    		        $image_width  = $image_width + ($celldata['image_offset'] * 2);   // include gap on left and right
    		    	$image_height = $image_height + ($celldata['image_offset'] * 2);  // include gap on top and bottom
    		    } // if
    		    // calculate the space left to contain any text
    			$celldata['width'] = $celldata['width'] - $image_width;
    			// insert height of image in current units
    			$celldata['imageheight_conv'] = $image_height;                          // converted from pixels to units
                $celldata['imageheight']      = $celldata['fieldspec']['imageheight'];  // unconverted
    		} // if
        } // if

        $text = str_replace("\r",'', $celldata['text']);  // remove carriage returns

        $line = '';
        $last_split = 0;
        for ($ix = 0; $ix < strlen($text); $ix++) {
            $char = substr($text, $ix, 1);  // extract next character from input string

            if ($char == ' ' OR $char == '_') {
                // record location of last space character (may be used in line splitting)
            	$last_split = $ix;
            } // if

            if ($char == "\n") {
                // newline required here, so close current line
            	$celldata['line_array'][] = trim($line);
            	$line = '';
            	$last_split = 0;
            } // if

            $line .= $char;  // append char to current line
            if ($this->GetStringWidth($line) > $cell_width - $this->millimeters2units(2.25) ) {
                if ($ix == 0) {
                	trigger_error("Cell width for '{$celldata['field']}' is too small", E_USER_ERROR);
                } // if
            	// this line is too long for current cell
            	if ($last_split > 0) {
            		// truncate current line at last split character
            		if ($char == '_') {
            			$split_point = $ix - $last_split +1;
            		} else {
            		    $split_point = $ix - $last_split;
            		} // if
            		$line = substr($line, 0, strlen($line) - $split_point);
            		if ($char == '_') {
            			$ix = $last_split -1;
            		} else {
            		    $ix = $last_split;
            		} // f
            	} // if
            	$celldata['line_array'][] = trim($line);
            	$line = '';
            	$last_split = 0;
            } // if

        } // for

        //if (!empty($line)) {
        if (strlen($line) > 0) {
            // append last fragment
        	$celldata['line_array'][] = trim($line);
        } // if

        if (!empty($celldata['min_lines'])) {
            // pad cell with empty lines up to value of 'min_lines'
            while (count($celldata['line_array']) < $celldata['min_lines']) {
        		$celldata['line_array'][] = '';
        		$celldata['text'] .= "\n ";
        	} // while
        } // if

        return $celldata;

    } // getLineCount

    // ****************************************************************************
    function getLinesRemaining ($line_height=null)
    // determine how many lines of a specific height are remaining on the current page.
    {
        if (empty($line_height)) {
        	$line_height = $this->last_height;
        } // if

        $lines_left = ($this->PageBreakTrigger - $this->getY()) / $line_height;

        return $lines_left;

    } // getLinesRemaining

    // ****************************************************************************
    function Header ()
    // define a page header (title)
    {
        $this->new_page = true;  // indicate that a new page has started

        if (!is_True($this->print_header)) {
        	return;  // do not print a page header
        } // if

        if (!isset($this->structure['title'])) {
            return;
        } // if

        // examine column widths for percentages and turn them into numbers
        $this->structure['title'] = $this->adjustColumnWidths($this->structure['title']);

        $dateobj =& RDCsingleton::getInstance('date_class');

        // get default style for the 'title' area
        $default_style = $this->style[$this->structure['title']['style']];

        // process each element in 'title' array
        $max_depth = 0;
        $imagebottom = 0;
        foreach ($this->structure['title'] as $element => $attributes) {
            if (is_integer($element) AND is_array($attributes)) {
            	// this is something that goes in the title area

            	// change all occurrences of 'marginX' to 'margin_X'
            	$attributes = $this->addUnderscore($attributes);

            	$height  = null;     // font height
            	$halign  = 'Left';   // horizontal alignment - Left, Center, Right
            	$valign  = 'Middle'; // vertical alignment - Top, Middle, Bottom
            	$stretch = null;     // no stretching of text within the cell
            	$draw    = null;     // line width for borders

            	if (isset($attributes['barcode_style'])) {
            		$result = $this->setBarcodeStyle($attributes['barcode_style']);
        	        $attributes = array_merge($result, $attributes);
            	} else {
            	    // set default style for whole title
            	    $attributes['default_style'] = $this->structure['title']['style'];
                	$result = $this->setPrintStyle($attributes['default_style']);
                	$count = extract($result, EXTR_IF_EXISTS);
                    if (isset($attributes['style'])) {
                        // override with attributes from specified style
                    	$result = $this->setPrintStyle($attributes['style'], $result);
                    	$count = extract($result, EXTR_IF_EXISTS);
                    } // if
            	} //if

            	// override individual attributes (if they have been specified)
                $count = extract($attributes, EXTR_IF_EXISTS);

                $this->last_height = $height;

            	if (isset($attributes['image'])) {
            	    $cell_width = $this->pixelsToUnits($attributes['imagewidth']);
            	} elseif (isset($attributes['width'])) {
            	    $cell_width = $attributes['width'];
            	} elseif (isset($attributes['text'])) {
            	    $cell_width = ceil($this->GetStringWidth($attributes['text']) + $this->millimeters2units(2));
            	} else {
            	    $cell_width = $this->millimeters2units(10);  // default
            	} // if

            	// save current XY values in case any adjustments need to be cancelled
            	$saveX = $this->getX();
            	$saveY = $this->getY();

                if (isset($attributes['y_save_top'])) {
                    if (preg_match('/pos[0-9]{1}/', $attributes['y_save_top'], $regs)) {
                        $pos = $attributes['y_save_top'];
                        $this->save_y_pos[$pos] = $this->getY() - $this->tMargin;
                    } // if
                } // if

                if (isset($attributes['y'])) {
                    if (preg_match_all('/pos[0-9]{1}/', $attributes['y'], $regs)) {
                        if (count($regs[0]) == 1) {
                            $saved_pos = $regs[0][0];  // only one, so fetch its value
                            if (array_key_exists($saved_pos, $this->save_y_pos)) {
                                $attributes['y'] = $this->save_y_pos[$saved_pos];
                            } else {
                                unset($attributes['y']);
                            } // if
                        } else {
                            // more than one, so use the highest value
                            $saved_pos = 0;
                            foreach ($regs[0] as $name) {
                                if ($this->save_y_pos[$name] > $saved_pos) {
                                    $saved_pos = $this->save_y_pos[$name];
                                } // if
                            } // foreach
                            if ($saved_pos > 0) {
                                $attributes['y'] = $saved_pos;
                            } else {
                                unset($attributes['y']);
                            } // if
                        } // if
                        //if (isset($attributes['ignore_if_empty'])) {
                        //    // do not print this cell if empty, but do not lose this position
                        //    $saveY = $saveY + $this->tMargin + $attributes['y'];
                        //} // if
                    } // if
                } // if

            	if (isset($attributes['align'])) {
            	    // absolute cell positioning on page - left, center or right
                	$palign = strtoupper(substr($attributes['align'], 0, 1));
                	unset($attributes['align']);
                	if ($palign == 'C') {
                	    // put cell in center of page
                        $X = ($this->printable_width - $cell_width) / 2;
                    	$this->setX($X + $this->lMargin);
                    } elseif ($palign == 'R') {
                        // put cell against the right margin
                        $X = ($this->printable_width - $cell_width);
                    	$this->setX($X + $this->lMargin);
                    } elseif ($palign == 'L') {
                        // put cell against the left margin
                    	$this->setX($this->lMargin);
                    } // if
                } else {
                    if (isset($attributes['x'])) {
                        // relative to page left margin
                	    $this->setX($this->lMargin + $attributes['x']);
            	    } // if
                } // if

            	if (isset($attributes['y'])) {
            	    // relative to top margin (i.e. absolute)
            	    $this->setXY($this->getX(), $this->tMargin + $attributes['y']);
                } // if
            	if (isset($attributes['y_relative'])) {
            	    // relative to last cell
                	$this->setXY($this->getX(), $this->getY() + $attributes['y_relative']);
                } // if

            	if (isset($attributes['margin_left'])) {
        	        // increase X coordinate to include this margin
        	    	$X = $this->getX() + $attributes['margin_left'];
        	    	unset($attributes['margin_left']);
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['border'])) {
        	    	$border = strtoupper($attributes['border']);
        	        if (is_True($border)) {
        	        	$border = 1;
        	        } // if
        	    } else {
        	        $border = 0;
        	    } // if

        	    $fill = 1;
                if (isset($attributes['default_style'])) {
                    if (empty($this->style[$attributes['default_style']]['fillcolour'])) {
        	            $fill = false;  // no fill colour specified, so turn fill off
        	        } // if
                } // if
        	    if (isset($attributes['style'])) {
        	        if (!empty($this->style[$attributes['style']]['fillcolour'])) {
        	        	// style override has been supplied, so force background colour to be filled in
        	            $fill = true;
        	        } else {
        	            $fill = false;
        	        } // if
        	    } // if
        	    if (isset($attributes['nofill'])) {
        	        $fill = false;  // turn fill off
        	    } // if

            	if (isset($attributes['image'])) {
            	    $imagewidth  = $this->pixelsToUnits($attributes['imagewidth']);
            	    $imageheight = $this->pixelsToUnits($attributes['imageheight']);
            	    $imagename   = $attributes['image'];
            	    if (substr($imagename, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($imagename, 2);
                    	if (isset($this->fieldarray[$fieldname])) {
                    		$imagename = $this->fieldarray[$fieldname];
                    	} // if
                    } // if
                    if (isset($attributes['image_border'])) {
                    	$image_border = 'LRTB';
                    } else {
                        $image_border = false;
                    } // if
            	    $this->Image($imagename, $this->getX(), $this->getY(), $imagewidth, $imageheight, '', '', '', false, 0, '', false, false, $image_border);
            		// write an empty cell around this image
            	    $this->Cell($imagewidth, $imageheight, '', $border, 0, '', 0);
            	    if (($imageheight + $this->getY()) > $imagebottom) {
            	    	$imagebottom = $imageheight + $this->getY();
            	    } // if
            	    $depth = $imageheight;

            	} elseif (isset($attributes['barcode'])) {
            	    $celldata = $attributes;
            	    unset($celldata['x']);
            	    unset($celldata['margin_left']);
            	    unset($celldata['margin_right']);

            	    $text = $celldata['barcode'];
                    if (substr($text, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($text, 2);
                    	if (isset($this->fieldarray[$fieldname])) {
                    		$text = $this->fieldarray[$fieldname];
                    	} // if
                    } // if
                    $celldata['barcode'] = $text;

                    $this->printCell($celldata, 0, 0, $border, $fill);
                    $depth             = $celldata['height'];
                    $this->last_height = $celldata['height'];

            	} elseif (isset($attributes['text']) OR isset($attributes['type'])) {
            	    if (isset($attributes['text'])) {
            	    	$text = $attributes['text'];
                        if (substr($text, 0, 2) == '%%') {
                            // replace field name with field data
                        	$fieldname = substr($text, 2);
                        	if (isset($this->fieldarray[$fieldname]) OR is_null($this->fieldarray[$fieldname])) {
                        		$text = $this->fieldarray[$fieldname];
                        		$attributes['text'] = $text;
                        		if (isset($attributes['print_only_once'])) {
                        		    // empty this field so that it is not output again if the page overflows
                        		    // (when used in conjunction with 'ignore_if_empty')
                        			$this->fieldarray[$fieldname] = '';
                        		} // if
                        	} // if
                        } // if
            	    } elseif (isset($attributes['type'])) {
            	        switch (strtolower($attributes['type'])) {
                	    	case 'pageno':
                	    		// Print 'Page n of n'
                                $text = getLanguageText('Page') .' ' .$this->getAliasNumPage() .' ' .getLanguageText('of') .' ' .$this->getAliasNbPages();
                	    		break;
                	    	case 'date':
                	    	    // get date in user-defined format
                                $text = $dateobj->getExternalDate(getTimeStamp('date'));
                	    	    break;
                	    	case 'time':
                                $text = getTimeStamp('time');
                                break;
                	    	default:
                	    	    $text = ' ';
                	    		break;
                	    } // switch
            	    } // if

                    if (empty($text) AND isset($attributes['ignore_if_empty'])) {
                    	// do not output this empty cell
                    	$depth = 0;
                        if (isset($attributes['y']) OR isset($attributes['y'])) {
                            // 'y' position was forced, so do not lose it
                            $this->setXY($saveX, $this->getY());
                            unset($attributes['newline']);
                        } else {
                    	    // cancel any adjustments to the XY coordinates
                    	    $this->setXY($saveX, $saveY);
                        } // if
                    } else {
                        // get number of lines that this text will produce
                        $attributes = $this->getLineCount($attributes);
                        if (isset($attributes['line_array'])) {
                        	$line_count = count($attributes['line_array']);
                        } else {
                            $line_count = 1;
                        } // if

                        if ($line_count == 1) {
                            // print a single-line cell
                        	$this->printCell($attributes, 0, 0, $border, $fill);
                        } else {
                            $line_count = $this->MultiCell($cell_width, $height, $text, $border, $halign, $fill);
                        } // if
                        $depth = $line_count * $height;
                    } // if

            	} // if

                if (isset($attributes['y_save_bottom'])) {
                    if (preg_match('/pos[0-9]{1}/', $attributes['y_save_bottom'])) {
                        $pos = $attributes['y_save_bottom'];
                        $this->save_y_pos[$pos] = $this->getY() - $this->tMargin + $depth;
                    } // if
                } // if

            	if ($depth > $max_depth) {
                	$max_depth = $depth;
                } // if

            	if (isset($attributes['margin_right'])) {
        		    // increase X coordinate to include this margin
        		    $X = $this->getX() + $attributes['margin_right'];
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['newline']) AND $max_depth > 0) {
        	        // new line required, so ...
        	        // position pointer at bottom of deepest cell in current line
        	        $this->Ln($max_depth);
        	        $max_depth = 0;
        	    } // if
            } else {
                // ignore this entry
            } // if

        } // foreach

        // position pointer at bottom of deepest cell in current line
        $this->Ln($max_depth);

        return;

    } // Header

    // ****************************************************************************
    function labelView (&$dbobject, $resource)
    // output data in LABEL view (one label per record, several labels per page)
    {
        $this->structure =& $this->report_structure;

        if (!isset($this->structure['pdf']['label_print'])) {
            // "LABEL_PRINT has not been defined in report structure file"
            trigger_error(getanguageText('sys0210'), E_USER_ERROR);
        } // if

        if ($this->structure['pdf']['label_print'] != abs((int)$this->structure['pdf']['label_print'])) {
            // "LABEL_PRINT in Report Structure File is not a positive number"
            trigger_error(getanguageText('sys0211'), E_USER_ERROR);
        } // if

        // examine column widths for percentages and turn them into numbers
        $this->structure = $this->adjustColumnWidthsDetailView($this->structure);

        $this->print_header = false;
        $this->print_footer = false;

    	// set bottom margin to be same as top margin
    	$this->SetAutoPageBreak(true, $this->tMargin);

        $fieldspec = $dbobject->fieldspec;

        $border = 1;  // assume ON unless turned OFF
        $fill   = 1;  // assume ON unless turned OFF
        $last_page = false;

        $save_party_language = $GLOBALS['party_language'];

        // add print a line of labels where each label comes from a different record
        while ($fieldarray = $dbobject->fetchRow($resource) OR !$last_page) {
            if ($dbobject->errors) return;

            if ($GLOBALS['party_language'] != $save_party_language) {
            	$save_destination = $this->pdf_destination;
                // reload report structure in the customer's language
                $this->structure = getFileStructure($GLOBALS['report'], './reports');
            	$this->structure = $this->validateStructure($this->structure);
            	$this->structure = $this->adjustColumnWidthsDetailView($this->structure);
                $this->style     = $this->loadStyleFile();  // reload 'pdf.styles.inc' file
                $result          = $this->replaceFonts($GLOBALS['party_language']);
                $this->pdf_destination = $save_destination;
                $save_party_language = $GLOBALS['party_language'];
            } // if

            if (empty($fieldarray) AND !$last_page) {
                $last_page = true;
            	// look to see if there are any unprinted labels
            	$fieldarray = $dbobject->_cm_post_lastRow();
            	if (empty($fieldarray)) {
            		break;  // no more labels, so stop printing now
            	} // if
            } // if

            // perform any formatting on retrieved data
            $style_array = array();
            $fieldarray_formatted = $dbobject->formatData($fieldarray, $style_array);
            $fieldarray_formatted = array_change_key_case($fieldarray_formatted, CASE_LOWER);
            $this->fieldarray = $fieldarray_formatted;  // make this accessible to Header() method

            if ($this->page == 0) {
            	$this->AddPage();  // start a new page for the first record
            } // if

            if (array_key_exists('body', $this->structure) AND array_key_exists('fields', $this->structure['body'])) {
                // output each field in the required order
                foreach ($this->structure['body']['fields'] as $column => $columndata) {

                    // construct a row of cells which are to be printed
                    $print_array = array();
                    foreach ($columndata as $cellno => $cellspec) {

                        // change all occurrences of 'marginX' to 'margin_X'
                        $cellspec = $this->addUnderscore($cellspec);

                        if (!isset($cellspec['width'])) {
                            if (!empty($this->structure['columns'])) {
                            	if (!empty($this->structure['columns'][$cellno]['width'])) {
                            	    $cellspec['width'] = $this->structure['columns'][$cellno]['width'];
                            	} // if
                            } // if
                            if (!isset($cellspec['width'])) {
                    		    // default is width divided by number of columns
                    	        $cellspec['width'] = $this->printable_width / count($columndata);
                            } // if
                	    } // if

                        if (array_key_exists('label', $cellspec)) {
                            // this cell contains a label
                            $cellspec['default_style'] = $this->structure['label']['style'];
                            $cellspec['text']  = getLanguageText($cellspec['label']);

                        } elseif (array_key_exists('field', $cellspec)) {
                            // print a cell containing field data
                            $cellspec['default_style'] = $this->structure['data']['style'];
                    	    $fieldname = $cellspec['field'];
                            if (!empty($fieldname) AND isset($fieldarray_formatted[$fieldname])) {
                        	    $cellspec['text'] = $fieldarray_formatted[$fieldname];
                            } else {
                                $cellspec['text'] = '';
                            } // if
            	            if (array_key_exists($fieldname, $fieldspec)) {
                    		    $cellspec['fieldspec'] = $fieldspec[$fieldname];
                    	    } // if
                    	    if (array_key_exists('notext', $cellspec)) {
                    	        // carry this specification change across
                    		    $cellspec['fieldspec']['notext'] = 'y';
                    		    unset($cellspec['notext']);
                    	    } // if

                        } elseif (array_key_exists('barcode', $cellspec)) {
                            $cellspec['default_style'] = $this->structure['label']['style'];
                            if (array_key_exists($cellspec['barcode'], $fieldarray)) {
                        	    $cellspec['barcode'] = $fieldarray[$cellspec['barcode']];
                            } else {
                                $cellspec['barcode'] = '';
                            } // if

                        } // if

                        if (empty($fieldname)) {
                            $print_array[] = $cellspec;  // print filler
                        } elseif (isset($fieldarray_formatted[$fieldname])) {
                            $print_array[] = $cellspec;  // print non-empty label
                        } // if

                    } // foreach

                    $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);

                } // foreach
            } // if
        } // while

        return;

    } // labelView

    // ****************************************************************************
    function listView (&$dbobject, $resource)
    // output data in LIST view (column heading, then one row per record)
    {
        $this->structure  =& $this->report_structure;

        // examine column widths for percentages and turn them into numbers
        $this->structure['columns'] = $this->adjustColumnWidths($this->structure['columns']);

        if (method_exists($this, 'AliasNbPages')) {
            // turn on page header and footer
            $this->AliasNbPages();
        } // if
        if (isset($this->structure['title'])) {
            $this->print_header = true;
        } // if
        if (isset($this->structure['foot1']) OR isset($this->structure['foot2'])) {
            $this->print_footer = true;
        } // if

        $this->setY($this->h);  // force first line to overflow current page and start a new one

        // set print style for main body
        if (isset($this->structure['body']['style'])) {
        	$body_style  = $this->structure['body']['style'];
        } elseif (isset($this->structure['data']['style'])) {
        	$body_style  = $this->structure['data']['style'];
        } else {
            $body_style  = 'default';
        } // if
        $height  = 0;
        $halign  = 'Left';
        $valign  = 'Middle';
        $stretch = null;
        $draw    = null;
        $result = $this->setPrintStyle($body_style);
        $count = extract($result, EXTR_IF_EXISTS);
        if (isset($this->style[$body_style]['font']['border'])) {
        	$border  =  $this->style[$body_style]['font']['border'];
        } else {
            $border  = 'LR';  // default is Left+Right
        } // if

        $fill = 0;  // fill is OFF for odd-numbered rows, ON for even-numbered rows

        $previous_row = array();                      // initialise previous row
        $style_array  = array();

        $save_party_language = $GLOBALS['party_language'];

        $current_row = $dbobject->fetchRow($resource);  // read first row

        // add each row to the document
        do {
            if ($dbobject->errors) return;

            if ($GLOBALS['party_language'] != $save_party_language) {
	            $save_destination = $this->pdf_destination;
	            // reload report structure in the designated language
	            $this->structure = getFileStructure($GLOBALS['report'], './reports');
	            $this->structure = $this->validateStructure($this->structure);
	            $this->style     = $this->loadStyleFile();  // reload 'pdf.styles.inc' file
		        $result          = $this->replaceFonts($GLOBALS['party_language']);
		        $this->pdf_destination = $save_destination;
		        $save_party_language = $GLOBALS['party_language'];
	        } // if

            $this->fieldarray = $current_row;  // make this data accessible to Header() method

            if (method_exists($dbobject, '_cm_ListView_pre_print')) {
                // **** THIS METHOD IS DEPRECATED (but left in for backwards compatibility) ****
            	// find out if any rows need to be printed before this one
                $before = $dbobject->_cm_ListView_pre_print($previous_row, $current_row);
                if (!empty($before)) {
                	$fill = $this->listView_print($before, $border, $fill, $style_array, $dbobject);
                } // if

                // print current row
                $fill = $this->listView_print($current_row, $border, $fill, $style_array, $dbobject);

                $previous_row = $current_row;
                $this->previous_row = $previous_row;  // save for printFooter()
                if (!empty($current_row)) {
                	$current_row = $dbobject->fetchRow($resource);
                    if (empty($current_row)) {
                        // save last row for possible use in Header() method
                    	$last_row = $previous_row;
                    } // if
                } // if

            } else {
                if (!empty($current_row)) {
                    $this->fieldarray = $current_row;  // make this data accessible to Header() method

                    // find out if any rows need to be printed before this one
                    $before = $dbobject->_cm_ListView_print_before($previous_row, $current_row);
                    if (!empty($before)) {
                    	$fill = $this->listView_print($before, $border, $fill, $style_array, $dbobject);
                    } // if

                	// print current row
                    $fill = $this->listView_print($current_row, $border, $fill, $style_array, $dbobject);

                    // read next row for comparison in 'print_after' method
                    $previous_row = $current_row;
                    $this->previous_row = $previous_row;  // save for printFooter()
                    if (!empty($current_row)) {
                    	$next_row = $dbobject->fetchRow($resource);
                        if (empty($next_row)) {
                            // save last row for possible use in Header() method
                        	$last_row = $previous_row;
                        } // if
                    } // if

                    // find out if any rows need to be printed after this one
                    $after = $dbobject->_cm_ListView_print_after($current_row, $next_row);
                    if (!empty($after)) {
                    	$fill = $this->listView_print($after, $border, $fill, $style_array, $dbobject);
                    } // if

                    $current_row = $next_row;
                } // if
            } // if

        } while (!empty($current_row));

        // close bottom border on current line
        $this->Line($this->lMargin, $this->getY(), $this->lMargin + $this->total_width, $this->getY());

        $this->previous_row = $last_row;  // save for printFooter()
        $this->fieldarray   = $last_row;  // make this data accessible to Header() method

        // look for a line of totals to be printed (optional)
        $fieldarray = $dbobject->_cm_ListView_total();
        if (!empty($fieldarray)) {
            $this->Ln($this->last_height);  // line break
            $print_array = array();
            foreach ($this->structure['body']['fields'] as $column => $columndata) {

                $print_array[] = $this->listView_assemble_row($column, $columndata, $fieldarray);

            } // foreach

            $border = 1;
            $fill =1;
            $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);  // print this row

        } // if

        return;

    } // listView

    // ****************************************************************************
    function listView_assemble_row ($column, $columndata, $fieldarray, $style_array=array())
    // assemble a row of data for the list view
    {
        // copy in any specs from the structure file (may only contain 'width')
        $cellspec = $this->structure['columns'][$column];

        $columndata = array_change_key_case($columndata, CASE_LOWER);
        if (isset($this->structure['pdf']['label_print'])) {
            $fieldname = $columndata['field'];
        } else {
            $fieldname = key($columndata);
        } // if

        if (isset($this->structure['pdf']['label_print'])) {
            if (!empty($fieldname) AND !isset($fieldarray[$fieldname])) {
                return false;
            } // if
        } // if

        if (isset($this->structure['body']['style'])) {
        	$cellspec['default_style']  = $this->structure['body']['style'];
        } elseif (isset($this->structure['data']['style'])) {
        	$cellspec['default_style']  = $this->structure['data']['style'];
        } else {
            $cellspec['default_style']  = 'default';
        } // if
        if (array_key_exists($fieldname, $style_array)) {
        	$cellspec['style'] = $style_array[$fieldname];
        } // if

        if (!isset($cellspec['width'])) {
            // default is width divided by number of columns
            $cellspec['width'] = $this->printable_width / count($this->structure['body']['fields']);
        } // if
        if (!isset($cellspec['halign'])) {
            if (isset($cellspec['align'])) {
                // use deprecated value
        	    $cellspec['halign'] = $cellspec['align'];
                unset($cellspec['align']);
            } // if
        } // if

        // change all occurrences of 'marginX' to 'margin_X'
        $cellspec = $this->addUnderscore($cellspec);

        if (isset($fieldarray[$fieldname])) {
        	$text = $fieldarray[$fieldname];
        } else {
            $text = '';
        } // if

    	if (isset($this->structure['pdf']['label_print'])) {
    	    $cellspec = array_merge($cellspec, $columndata);

    	} else {
    	    $text = str_replace("\n", ', ', $text);  // replace <newline> character
        	$cell_width = $cellspec['width'];
        	if (!isset($this->structure['columns'][$column]['overflow'])) {
        	    // field is not allowed to overflow, so truncate it to fit
        		while ($this->GetStringWidth($text) > $cell_width - $this->millimeters2units(2)) {
            		$text = substr($text, 0, strlen($text) - 2);
            	} // while
        	} // if
    	} // if

        $cellspec['text'] = $text;

        return $cellspec;

    } // listView_assemble_row

    // ****************************************************************************
    function listView_print($rows, $border, $fill, $style_array, $dbobject=null)
    // print a line for each entry in $rows
    {
        if (!is_int(key($rows))) {
            // input is not indexed, so set it to index zero
        	$array[] = $rows;
        	$rows    = $array;
        } // if

        foreach ($rows as $rowdata) {
            if (is_object($dbobject)) {
            	// format current row
                $style_array = array();
                $rowdata = $dbobject->formatData($rowdata, $style_array);
                if ($dbobject->errors) {
                    foreach ($dbobject->errors as $key => $value) {
                        $msg = "$key: $value";
                        trigger_error($msg, E_USER_ERROR);
                    } // foreach
                } // if
            } // if
            // assemble a row of column details
            $print_array = array();
            foreach ($this->structure['body']['fields'] as $column => $columndata) {
                if (is_string(key($columndata))) {
                	$print_array[] = $this->listView_assemble_row($column, $columndata, $rowdata, $style_array);
                } else {
                    foreach ($columndata as $column2 => $columndata2) {
                    	$result = $this->listView_assemble_row($column2, $columndata2, $rowdata, $style_array);
                    	if (!empty($result)) {
                    		$print_array[] = $result;
                    	} // if
                    } // foreach
                } // if
            } // foreach
            // now print this row of columns
            $result = $this->printRow($print_array, __FUNCTION__, $border, $fill);
            $fill = !$fill;     // toggle between ON and OFF
        } // foreach

        return $fill;

    } // listView_print

    // ****************************************************************************
    function loadStyleFile ()
    // load file(s) containing style details
    {
        // load file of default print styles
        require 'pdf.styles.inc';  // use standard styles

        // include additional project styles (optional)
        if (!empty($GLOBALS['project_code'])) {
        	// 1st alternative - look in the 'custom-processing' directory
            $fname = "reports/custom-processing/{$GLOBALS['project_code']}/pdf.styles.inc";
            if (file_exists($fname)) {
                require $fname;
            } else {
            	// 2nd alternative - look in the current working directory
	            $fname = "pdf.styles.{$GLOBALS['project_code']}.inc";
	            if (file_exists($fname)) {
	                require $fname;
	            } // if
			} // if
        } // if

        foreach ($style as $key => $value) {
        	if (isset($style[$key]['font']) AND is_array($style[$key]['font'])) {
        	    // change all occurrences of 'marginX' to 'margin_X'
            	$style[$key]['font'] = $this->addUnderscore($style[$key]['font']);
        	} // if
        } // foreach

        if (isset($font_replacement)) {
        	// replace fonts for specific languages (see replaceFonts() method)
        	$this->font_replacement = $font_replacement;
        } // if

        return $style;

    } // loadStyleFile

    // ****************************************************************************
    function millimeters2units ($mm)
    // convert millimeters to the current units
    {
        if (is_null($this->k)) {
            $this->setPageUnit($this->pdfunit);
        } // if

        return $mm * 2.8346 / $this->k;

    } // millimeters2units

    // ****************************************************************************
    function MultiCell ($width, $height, $text, $border=0, $align='J', $fill=0, $ln=1, $x='', $y='', $reseth=true, $stretch=0, $ishtml=false, $autopadding=true, $maxh=0, $valign='T', $fitcell=false)
    // this is a wrapper for the parent method
    {
        $align = strtoupper(substr($align, 0, 1));

        // save current X/Y coordinates
        $X = $this->getX();
        $Y = $this->getY();

        $cells = parent::MultiCell ($width, $height, $text, $border, $align, $fill, $ln, $x, $y, $reseth, $stretch, $ishtml, $autopadding, $maxh, $valign, $fitcell);

        $line_count = ($this->getY() - $Y) / $height;

        // Put the position to the right of the cell
        $this->SetXY($X + $width, $Y);

        return $line_count;

    } // MultiCell

    // ****************************************************************************
    function outputPDF_DetailView ($resource)
    // read database resource and output all records to a PDF file in DETAIL view
    // using the layout defined in the $structure
    {
        ob_start();  // turn on output buffering

        $dbobject =& $this->dbobject;

        // allow filename to be customised
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_pre_output')) {
                $this->pdf_filename = $dbobject->custom_processing_object->_cm_pre_output($this->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $this->pdf_filename = $dbobject->_cm_pre_output($this->pdf_filename);
        } // if

        if (preg_match('/(F|D)/i', $dbobject->pdf_destination)) {
            if (empty($this->pdf_filename)) {
                // set default file name for PDF output
                $this->pdf_filename = basename($_SERVER['PHP_SELF'], '.php') .'.pdf';
            } // if
        } // if

        // format data using DETAIL view
        $this->detailView($dbobject, $resource);
        if ($dbobject->errors) {
            return $dbobject->pdf_destination;
        } // if

        $dbobject->pdf_destination = strtoupper($dbobject->pdf_destination);

        $output = ob_get_contents();
        ob_end_clean();
        if (strlen($output) > 0) {
            // if output buffer contains a Byte Order Mark after including a file then remove it and continue
            $output = removeBOM($output);
            if (strlen($output) > 0) {
                echo $output;  // contains something other than a BOM
            } // if
        } // if

        // output the completed document
        $string = $this->Output($dbobject->pdf_filename, $dbobject->pdf_destination);
        if (!empty($this->error)) {
            $this->errors[] = 'PDF error: ' .$this->error;
        } // if

        if (preg_match('/(F)/i', $dbobject->pdf_destination)) {
            // "File x created"
            $this->messages[] = getLanguageText('sys0135', $dbobject->pdf_filename);
        } // if

        // perform any post processing, which may involve a database update
        if ($dbobject->dbname != 'default' AND !isset($GLOBALS['batch'])) {
            $dbobject->startTransaction();
        } // if
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_post_output')) {
                $string = $dbobject->custom_processing_object->_cm_post_output($string, $dbobject->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $string = $dbobject->_cm_post_output($string, $dbobject->pdf_filename);
        } // if

        // reset language it case it was changed
        $GLOBALS['party_language'] = $_SESSION['user_language'];

        if ($dbobject->dbname != 'default' AND !isset($GLOBALS['batch'])) {
            if (empty($dbobject->errors)) {
                $this->errors = $dbobject->commit();
            } // if
            if (!empty($this->errors)) {
                $dbobject->rollback();
            } // if
        } // if

        return $string;

    } // outputPDF_DetailView

    // ****************************************************************************
    function outputPDF_LabelView ($resource)
    // read database resource and output all records to a PDF file in LABEL view
    // using the layout defined in the report structure
    {
        ob_start();  // turn on output buffering

        $dbobject =& $this->dbobject;

        // allow filename to be customised
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_pre_output')) {
                $this->pdf_filename = $dbobject->custom_processing_object->_cm_pre_output($this->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $this->pdf_filename = $dbobject->_cm_pre_output($this->pdf_filename);
        } // if

        if (preg_match('/(F|D)/i', $dbobject->pdf_destination)) {
            if (empty($this->pdf_filename)) {
                // set default file name for PDF output
                $this->pdf_filename = basename($_SERVER['PHP_SELF'], '.php') .'.pdf';
            } // if
        } // if

        // format data using LABEL view
        $this->labelView($dbobject, $resource);
        if ($dbobject->errors) {
            return $dbobject->pdf_destination;
        } // if

        $dbobject->pdf_destination = strtoupper($dbobject->pdf_destination);

        $output = ob_get_contents();
        ob_end_clean();
        if (strlen($output) > 0) {
            // if output buffer contains a Byte Order Mark after including a file then remove it and continue
            $output = removeBOM($output);
            if (strlen($output) > 0) {
                echo $output;  // contains something other than a BOM
            } // if
        } // if

        // output the completed document
        $string = $this->Output($dbobject->pdf_filename, $dbobject->pdf_destination);
        if (!empty($this->error)) {
            $this->errors[] = 'PDF error: ' .$this->error;
        } // if

        if (preg_match('/(F)/i', $dbobject->pdf_destination)) {
            // "File x created"
            $this->messages[] = getLanguageText('sys0135', $dbobject->pdf_filename);
        } // if

        // perform any post processing, which may involve a database update
        if ($dbobject->dbname != 'default') {
            $dbobject->startTransaction();
        } // if
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_post_output')) {
                $string = $dbobject->custom_processing_object->_cm_post_output($string, $dbobject->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $string = $dbobject->_cm_post_output($string, $this->pdf_filename);
        } // if

        // reset language it case it was changed
        $GLOBALS['party_language'] = $_SESSION['user_language'];

        if ($dbobject->dbname != 'default') {
            if (empty($dbobject->errors)) {
                $this->errors = $dbobject->commit();
            } // if
            if (!empty($this->errors)) {
                $dbobject->rollback();
            } // if
        } // if

        return $string;

    } // outputPDF_LabelView

    // ****************************************************************************
    function outputPDF_ListView ($resource)
    // read database resource and output all records to a PDF file in LIST view
    // using the layout defined in the report structure
    {
        ob_start();  // turn on output buffering

        $dbobject =& $this->dbobject;

        // allow filename to be customised
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_pre_output')) {
                $this->pdf_filename = $dbobject->custom_processing_object->_cm_pre_output($this->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $this->pdf_filename = $dbobject->_cm_pre_output($this->pdf_filename);
        } // if

        if (preg_match('/(F|D)/i', $dbobject->pdf_destination)) {
            if (empty($this->pdf_filename)) {
                // set default file name for PDF output
                $this->pdf_filename = basename($_SERVER['PHP_SELF'], '.php') .'.pdf';
            } // if
        } // if

        // format data using LIST view
        $this->listView($dbobject, $resource);
        if ($dbobject->errors) {
            return $dbobject->pdf_destination;
        } // if

        // reset locale to user's language, not customer's language
        $locale = saveLocaleFormat($_SESSION['user_language_array'][0][2]);

        $dbobject->pdf_destination = strtoupper($dbobject->pdf_destination);

        $output = ob_get_contents();
        ob_end_clean();
        if (strlen($output) > 0) {
            // if output buffer contains a Byte Order Mark after including a file then remove it and continue
            $output = removeBOM($output);
            if (strlen($output) > 0) {
                echo $output;  // contains something other than a BOM
            } // if
        } // if

        // output the completed document
        $string = $this->Output($dbobject->pdf_filename, $dbobject->pdf_destination);
        if (!empty($this->error)) {
            $this->errors[] = 'PDF error: ' .$this->error;
        } // if

        if (preg_match('/(F)/i', $dbobject->pdf_destination)) {
            // "File x created"
            $this->messages[] = getLanguageText('sys0135', $dbobject->pdf_filename);
        } // if

        // perform any post processing, which may involve a database update
        $dbobject->startTransaction();
        if (is_object($dbobject->custom_processing_object)) {
            if (method_exists($dbobject->custom_processing_object, '_cm_post_output')) {
                $string = $dbobject->custom_processing_object->_cm_post_output($string, $dbobject->pdf_filename);
            } // if
        } // if
        if ($dbobject->custom_replaces_standard) {
            $dbobject->custom_replaces_standard = false;
        } else {
            $string = $dbobject->_cm_post_output($string, $dbobject->pdf_filename);
        } // if

        if (empty($dbobject->errors)) {
            $this->errors = $dbobject->commit();
        } // if
        if (!empty($this->errors)) {
            $dbobject->rollback();
        } // if

        return $string;

    } // outputPDF_ListView

    // ****************************************************************************
    function printBarcode ($celldata)
    // print a barcode
    {
        if (isset($celldata['barcode_style'])) {
            // merge with contents of entry in pdf.styles.inc (but don't replace existing entries)
        	$celldata = array_merge($this->style[$celldata['barcode_style']], $celldata);
        } // if

        if (!isset($celldata['type'])) {
        	$celldata['type']     = 'I25';
        } else {
            $celldata['type']     = strtoupper($celldata['type']);
        } // if
        if (!isset($celldata['xres'])) {
        	$celldata['xres']     = 2;
        } // if
        if (!isset($celldata['width'])) {
        	$celldata['width']    = $this->millimeters2units(80);
        } // if
        if (!isset($celldata['height'])) {
        	$celldata['height']   = $this->millimeters2units(25);
        } // if

        if (isset($celldata['fgcolor'])) {
        	$style['fgcolor'] = $celldata['fgcolor'];
        } else {
        	$style['fgcolor'] = array(0,0,0);  // default is black
        } // if
        if (isset($celldata['bgcolor'])) {
        	$style['bgcolor'] = $celldata['bgcolor'];
        } else {
        	$style['bgcolor'] = false;         // default is transparent
        } // if

        $X = $this->getX();
        $Y = $this->getY();
        $X_adjusted = $X;
        $Y_adjusted = $Y;

    	if (!empty($celldata['style'])) {
    	    // use predefined settings
			if (preg_match('/B/i', $celldata['style'])) {
			    $style['border'] = true;
			} // if
			if (isset($celldata['image_border'])) {
            	$style['border'] = true;
            } // if
		    if (preg_match('/D/i', $celldata['style'])) {
		        $style['text'] = true;
		        $style['font'] = 'courier';
		    } // if
			if (preg_match('/N/i', $celldata['style'])) {
			    // negative, so reverse the colours
			    $style['fgcolor'] = array(255,255,255);  // white
			    $style['bgcolor'] = array(0,0,0);        // black
			} else {
			    $style['fgcolor'] = array(0,0,0);        // black
			    $style['bgcolor'] = false;               // transparent
			} // if
			// image position = L/C/R/X (Left, Center, Right, Stretch Image)
			if (preg_match('/(L|C|R)/i', $celldata['style'], $regs)) {
			    $style['align']        = $regs[0];
			    $style['cellfitalign'] = $regs[0];
			} else {
			    $style['align']        = 'C';    // default is center
			    $style['cellfitalign'] = 'C';
			} // if
			if (preg_match('/X/i', $celldata['style'], $regs)) {
			    $style['stretch'] = true;  // stretch the barcode image to fit the cell
			} // if
			if (preg_match('/S/i', $celldata['style'], $regs)) {
			    $style['stretchtext'] = 4;  // forced character spacing
			} // if

    	} else {
    	    // use manual settings
            if (isset($celldata['align'])) {
                // alignment within the cell (does this work??)
            	$style['align'] = strtoupper($celldata['align']);
            } // if
            if (isset($celldata['cellfitalign'])) {
                // alignment of barcode within the cell
            	$style['cellfitalign'] = strtoupper($celldata['cellfitalign']);
            } // if
            if (isset($celldata['image_border'])) {
            	$style['border'] = true;
            } // if
            if (isset($celldata['font'])) {
                $style['font'] = $celldata['font'];
            } else {
                $style['font'] = 'courier';
            } // if
            if (isset($celldata['text'])) {
                $style['text'] = true;
            } // if
            if (isset($celldata['stretch'])) {
            	$style['stretch'] = $celldata['stretch'];
            } // if
            if (isset($celldata['stretchtext'])) {
            	$style['stretchtext'] = $celldata['stretchtext'];
            } // if
    	} // if

		// convert 'old' values to 'new'
		switch ($celldata['xres']) {
			case 1:     // small
				$celldata['xres'] = 0.3;
				break;
			case 2:     // medium
				$celldata['xres'] = 0.4;
				break;
			default:    // large
			    $celldata['xres'] = 0.5;
				break;
		} // switch

		if ($style['text']) {
		    $style['font'] = 'courier';
		    switch ($style['fontsize']) {
				case 1:     // small
				    $style['fontsize'] = 6;
					break;
				case 2:     // small+
				    $style['fontsize'] = 7;
					break;
				case 3:     // medium
				    $style['fontsize'] = 8;
					break;
				case 4:     // medium+
				    $style['fontsize'] = 9;
					break;
				default:    // large
				    $style['fontsize'] = 10;
					break;
			} // switch
		} // if

        if (isset($celldata['padding'])) {
        	$style['padding'] = $celldata['padding'];
        } elseif (isset($celldata['hpadding']) OR isset($celldata['vpadding'])) {
            // horizontal and vertical padding can be specified separately
            if (isset($celldata['hpadding'])) {
            	$style['hpadding'] = $celldata['hpadding'];
            } // if
            if (isset($celldata['vpadding'])) {
            	$style['vpadding'] = $celldata['vpadding'];
            } // if
        } else {
            $style['padding'] = $this->millimeters2units(1);
        } // if

        if (isset($celldata['image_offset'])) {
            $offset = (float)$celldata['image_offset'];
        	// make image 2 x $offset smaller than the cell it will appear in to provide a gap all the way around
        	$celldata['width']  = $celldata['width'] -($offset * 2);
        	$celldata['height'] = $celldata['height'] -($offset * 2);
        	// add a border all the way around which is $offset wide
        	$X_adjusted = ($X + $offset);
        	$Y_adjusted = ($Y + $offset);
        } // if

        // do *NOT* use 'position' as it sets alignment within the page.
//        if (isset($celldata['position'])) {
//          // alignment within the page
//        	$style['position'] = $celldata['position'];
//        } else {
//        	$style['position'] = 'C';
//        } // if

        $pointer_align = 'T';  // put pointer at top left of barcode image
        if (preg_match('/^(QRCODE|PDF417)/i', $celldata['type'], $regs)) {
            if (isset($celldata['module_width'])) {
            	$style['module_width'] = $celldata['module_width'];
            } else{
                $style['module_width'] = 1;  // in pts not units
            } // if
        	if (isset($celldata['module_height'])) {
            	$style['module_height'] = $celldata['module_height'];
            } else{
                $style['module_height'] = 1;  // in pts not units
            } // if
            if (isset($celldata['distort'])) {
            	$distort = $celldata['distort'];
            } else{
                $distort = false;
            } // if
        	$this->write2DBarcode($celldata['barcode'],
        	                      $celldata['type'],
        	                      $X_adjusted, $Y_adjusted,
        	                      $celldata['width'], $celldata['height'],
        	                      $style,
        	                      $pointer_align,
        	                      $distort);
        } else {
        	$this->write1DBarcode($celldata['barcode'],
        	                      $celldata['type'],
        	                      $X_adjusted, $Y_adjusted,
        	                      $celldata['width'], $celldata['height'],
        	                      $celldata['xres'],
        	                      $style,
        	                      $pointer_align);
        } // if

    	// reset Y to last known position
    	$this->setY($Y);

    	// set X to start plus column width
    	//$this->setX($X + $celldata['width'] +1);

        return;

    } // printBarcode

    // ****************************************************************************
    function printCell ($celldata, $line_no, $last_line, $border, $fill=1, $last_height=0, $function=null)
    // print a line from this cell using the contents of $celldata
    {
        // set print style for current cell
        $height  = 0;
        $halign  = 'Left';
        $valign  = 'Middle';
        $stretch = null;
        $draw    = null;

        if (isset($celldata['barcode_style'])) {
            $result = $this->setBarcodeStyle($celldata['barcode_style']);
        	$celldata = array_merge($result, $celldata);
        	if (is_null($draw) AND !empty($celldata['draw'])) {
            	$draw = $celldata['draw'];
            } // if
    	} else {
            $result = $this->setPrintStyle($celldata['default_style']);
            $count = extract($result, EXTR_IF_EXISTS);
            if (isset($celldata['style'])) {
                // use style override for this cell
            	$result = $this->setPrintStyle($celldata['style'], $result);
            	$count = extract($result, EXTR_IF_EXISTS);
            } // if
    	} // if

        if ($last_height <> 0) {
    	    // last line is shorter than normal, so adjust its height
    	    $height = $last_height;
        } else {
            if (isset($celldata['height'])) {
	            $height = $celldata['height'];
            } else {
                $height = $this->last_height;
            } // if
	    } // if

        if (isset($celldata['halign'])) {
            $halign = $celldata['halign'];
        } // if

        if (isset($celldata['valign'])) {
            $valign = $celldata['valign'];
        } // if

        if (!empty($celldata['stretch'])) {
            $stretch = $celldata['stretch'];
        } // if

        $calign = 'T';  // always 'cell top'

        if (isset($celldata['ignore_min_height']) OR $last_height <> 0) {
            // do not automatically adjust line height to fit font size
            $ignore_min_height = true;
            //if ($last_height <= $height) {
            //    // ensure last_height is set to this font's height
            //    $this->last_height = $height;
            //} // if
        } else {
        	$ignore_min_height = false;
        } // if

        if (isset($celldata['link'])) {
            $link = $celldata['link'];
        } else {
        	$link = null;
        } // if

        if (strtoupper($this->DrawColor) == strtoupper($this->FillColor)) {
            // both colours are the same, so do not write any borders
        	$draw = 0;
        } elseif (isset($celldata['border']) AND !is_True($celldata['border'])) {
            $draw = 0;
        } // if
        if ($draw > 0) {
        	$this->SetLineWidth($draw);
        } else {
            $border = false;
            $this->SetLineWidth(null);
        } // if

        if (isset($celldata['default_style']) AND !isset($this->style[$celldata['default_style']]['fillcolour'])) {
	        $fill = false;  // no fill colour specified, so turn fill off
	    } // if
	    if (isset($celldata['style'])) {
	        if (!empty($this->style[$celldata['style']]['fillcolour'])) {
	        	// style override has been supplied, so force background colour to be filled in
	            $fill = true;
	        } else {
	            $fill = false;
	        } // if
	    } // if
	    if (isset($celldata['nofill'])) {
	        $fill = false;  // turn fill off
	    } // if

        $cell_width = $celldata['width'];

        if (isset($celldata['x'])) {
            // relative to page left margin
    	    $this->setX($this->lMargin + $celldata['x']);
	    } elseif (isset($celldata['margin_left'])) {
	        // increase X coordinate to include this margin
	    	$X = $this->getX() + $celldata['margin_left'];
	    	$this->setX($X);
	    } // if

        if (isset($celldata['fieldspec'])) {
        	$fieldspec = $celldata['fieldspec'];
        } else {
            $fieldspec = array();
        } // if

        $paddings          = $this->default_padding;
        if (isset($celldata['padding_left'])) {
            $paddings['L'] = $celldata['padding_left'];
        } // if
        if (isset($celldata['padding_right'])) {
            $paddings['R'] = $celldata['padding_right'];
        } // if
        $this->setCellPaddings($paddings['L'], $paddings['T'], $paddings['R'], $paddings['B']);

        $X = $this->getX();
        $Y = $this->getY();

        if (isset($celldata['barcode'])) {
            if ($line_no == 0) {
                $this->printBarcode($celldata);
            	if ($this->error) {
            	    $text = $this->error;
            		$this->Cell($cell_width, $height, $text, $mod_border, 0, $valign, $fill);
            	} // if
            } else {
                $celldata['height'] = $last_height;
            } // if

            if ($line_no == 0 OR $this->new_page) {
                if ($border == 1 OR preg_match('/T/i', $border)) {
                	// draw line along top border of 1st cell in 1st line, or 1st line of new page
                	$this->Line($X, $Y, $X + $cell_width, $Y);
                } // if
            } // if

    	    if ($border == 1 OR preg_match('/L/i', $border)) {
    	    	// draw line along left hand border
            	$this->Line($X, $Y, $X, $Y + $celldata['height']);
    	    } // if
    	    if ($border == 1 OR preg_match('/T/i', $border)) {
    	    	// draw line along right hand border
            	$this->Line($X + $cell_width, $Y, $X + $cell_width , $Y + $celldata['height']);
    	    } // if

    	    $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
            if ($line_no >= $last_line OR $lines_left < 2) {
                if ($border == 1 OR preg_match('/B/i', $border)) {
                	// draw line along bottom border of last cell
                	$Y = $Y + $height;
                    $this->Line($X, $Y, $X + $cell_width, $Y);
                } // if
            } //if

    	    // move to start of next cell
            $this->setX($X + $cell_width);

        } elseif (isset($celldata['image'])) {
            $imagewidth  = $this->pixelsToUnits($celldata['imagewidth']);
            $imageheight = $this->pixelsToUnits($celldata['imageheight']);
            $image_offset =& $celldata['image_offset'];
            if ($line_no == 0) {
                // output image on first line only
                $imagename   = $celldata['image'];
                $image_border = null;
                $this->Image($imagename, $this->getX()+$image_offset, $this->getY()+$image_offset, $imagewidth, $imageheight, '', '', '', false, 0, '', false, false, $image_border);
            } // if
            // advance X coordinate to cover image width
            if (isset($celldata['width'])) {
                $this->setX($X + $celldata['width']);
            } else {
                $this->setX($X + $imagewidth);
            } // if

        } elseif (isset($fieldspec['subtype']) and $fieldspec['subtype'] == 'image') {
            $imagewidth  = $this->pixelsToUnits($fieldspec['imagewidth']);
            $imageheight = $this->pixelsToUnits($fieldspec['imageheight']);
            $image_offset =& $celldata['image_offset'];
            if ($line_no == 0) {
                // output image on first line only
                $imagename   = $celldata['text'];
                if (strlen($imagename) > 0) {
                    if (isset($celldata['image_border'])) {
                    	$image_border = 'LRTB';
                    } else {
                        $image_border = false;
                    } // if
                	$this->Image($imagename, $this->getX()+$image_offset, $this->getY()+$image_offset, $imagewidth, $imageheight, '', '', '', false, 0, '', false, false, $image_border);
                } // if
        	} // if

            if ($line_no == 0) {
        	    if ($border == 1 OR preg_match('/T/i', $border)) {
        	    	// draw border above image
                	$this->Line($X, $Y, $X + $imagewidth + ($image_offset * 2), $Y);
        	    } // if
        	    if ($border == 1 OR preg_match('/L/i', $border)) {
        	    	// draw border to left of image
                	$this->Line($X, $Y, $X, $Y + $height);
        	    } // if
            } // if

            // move text to right of image
        	$this->setX($this->getX() + $imagewidth + ($image_offset * 2));
        	$X2 = $this->getX();
        	$mod_border = 'R';  // do not print border between image and text
            if (array_key_exists('fieldspec', $celldata) AND array_key_exists('notext', $celldata['fieldspec'])) {
            	// write a line without any text
            	$this->Cell($cell_width, $height, '',    $mod_border, 0, $halign, $fill);
            } else {
                if (isset($celldata['line_array'][$line_no])) {
                	$text = trim($celldata['line_array'][$line_no]);
                } else {
                    $text = '';
                } // if
                // output a line of text in the current cell
                $this->Cell($cell_width, $height, $text, $mod_border, 0, $halign, $fill, $link, $stretch, $ignore_min_height, $calign, $valign);
            } // if

        	if ($line_no == 0) {
        	    if ($border == 1 OR preg_match('/T/i', $border)) {
        	    	// draw border above image text
                	$this->Line($X2, $Y, $X2 + $cell_width, $Y);
        	    } // if
            } // if

            if ($line_no == $last_line OR $last_height > 0) {
        	    if ($border == 1 OR preg_match('/B/i', $border)) {
                	// draw line along bottom border of last cell
                	$Y = $this->getY() + $height;
                	$this->Line($X, $Y, $X + $imagewidth + ($image_offset * 2) + $cell_width, $Y);
        	    } // if
        	} //if

        } else {
            if (isset($this->structure['pdf']['label_print'])) {
                // print multi-line text in a single operation
                $line_count = $this->MultiCell($cell_width, $height, $celldata['text'], $border, $halign, $fill);

            } else {
                // print a line of text, so first set the border options
                if (preg_match('/^(detail)/i', $function)) {
                    // detail view
                    if ($border == false) {
                    	$mod_border = '';
                    } else {
                	    $mod_border = 'LR';
                    } // if
                } else {
                    // list view
                    // more than one line in each cell, so do not print horizontal lines in the middle of the cell
        	        if ($border == 1) $border = 'LRTB';
        	        if ($line_no > 0) {
        	            // not the first line, so do not print top border
        	            $border = str_replace('T', '', $border);
        	        } // if
        	        if ($line_no < $last_line) {
        	            // not the last line, so do not print bottom border
        	            $border = str_replace('B', '', $border);
        	        } // if
        	        if ($border == 'P') {
        	        	// put border around the whole page, not each individual cell
        	        	if (isset($celldata['cellno'])) {
        	        		if ($celldata['cellno'] == 0) {
        	        		    // first cell, so put border on the left
        	        			$border = 'L';
        	        		} elseif ($celldata['cellno'] == $celldata['lastcell']) {
        	        		    // last cell, so put border on the right
        	        			$border = 'R';
        	        		} else {
        	        		    $border = '';
        	        		} // if
        	        	} // if
        	        } // if
                    $mod_border = $border;
                } // if

                if (isset($celldata['line_array'][$line_no])) {
                	$text = trim($celldata['line_array'][$line_no]);
                } else {
                    $text = '';
                } // if
                $this->Cell($cell_width, $height, $text, $mod_border, 0, $halign, $fill, $link, $stretch, $ignore_min_height, $calign, $valign);

                if ($line_no == 0 OR $this->new_page) {
                    if ($border == 1 OR preg_match('/T/i', $border)) {
                    	// draw line along top border of 1st cell in 1st line, or 1st line of new page
                    	$this->Line($X, $Y, $X + $cell_width, $Y);
                    } // if
                } // if

                $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
                if ($line_no >= $last_line OR $lines_left < 2) {
                    if ($border == 1 OR preg_match('/B/i', $border)) {
                    	// draw line along bottom border of last cell
                    	$Y = $Y + $height;
                        $this->Line($X, $Y, $X + $cell_width, $Y);
                    } // if
                } //if
            } // if
        } // if

        if (isset($celldata['margin_right'])) {
	        // increase X coordinate to include this margin
	    	$X = $this->getX() + $celldata['margin_right'];
	    	$this->setX($X);
	    } // if

        return;

    } // printCell

    // ****************************************************************************
    function printFooter ($zone)
    // print a line in the page footer
    {
        $this->last_height = 0;

        $dateobj =& RDCsingleton::getInstance('date_class');

        foreach ($this->structure[$zone] as $element => $attributes) {
            if (is_integer($element)) {
                // change all occurrences of 'marginX' to 'margin_X'
            	$attributes = $this->addUnderscore($attributes);

                // use default style for whole title
                $height  = 0;
                $halign  = 'Left';
                $valign  = 'Middle';
                $stretch = null;
                $draw    = null;
                $nofillcolour = null;
                $result = $this->setPrintStyle($this->structure['foot']['style']);
            	$count = extract($result, EXTR_IF_EXISTS);
                if (isset($attributes['style'])) {
            	    // use style specified for this element
            	    $result = $this->setPrintStyle($attributes['style'], $result);
            	    $count = extract($result, EXTR_IF_EXISTS);
            	} // if

            	if ($draw > 0) {
            		$border = true;
            	} else {
            	    $border = false;
            	} // if

            	if (!empty($attributes['nofill']) or is_True($nofillcolour)) {
            	    $fill = false;
            	} else {
            	    $fill = true;
            	} // if

            	if (!empty($attributes['halign'])) {
            	    $halign = $attributes['halign'];
            	} // if
            	if (!empty($attributes['valign'])) {
            	    $valign = $attributes['valign'];
            	} // if
            	if (!empty($attributes['stretch'])) {
            	    $stretch = $attributes['stretch'];
            	} // if

            	if (isset($attributes['text'])) {
            		$text = $attributes['text'];
            		if (substr($text, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($text, 2);
                    	if ($GLOBALS['mode'] == 'pdf-detail') {
                    		if (isset($this->fieldarray[$fieldname])) {
                        		$text = $this->fieldarray[$fieldname];
                        	} // if
                    	} else {
                        	if (isset($this->previous_row[$fieldname])) {
                        		$text = $this->previous_row[$fieldname];
                        	} // if
                    	} // if
                    } // if

            	} elseif (isset($attributes['image'])) {
                    $imagewidth  = $this->pixelsToUnits($attributes['imagewidth']);
            	    $imageheight = $this->pixelsToUnits($attributes['imageheight']);
                    $cell_width  = $imagewidth;
                    $attributes['width']  = $imagewidth;
                    $attributes['height'] = $imageheight;

            	} else {
                	switch (strtolower($attributes['type'])) {
            	    	case 'pageno':
            	    		// Print 'Page n of n'
                            $text = getLanguageText('Page') .' ' .$this->getAliasNumPage() .' ' .getLanguageText('of') .' ' .$this->getAliasNbPages();
            	    		break;
            	    	case 'date':
            	    	    // get date in user-defined format
            	    	    $date = getTimeStamp('date');
            	    	    if (isset($_SESSION['timezone_server']) AND isset($_SESSION['timezone_client'])) {
            	    	        $date = convertTZdate($date, null, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
            	    	    } // if
            	    	    $text = $dateobj->getExternalDate($date);
            	    	    break;
            	    	case 'time':
                            $time = getTimeStamp('time');
                            if (isset($_SESSION['timezone_server']) AND isset($_SESSION['timezone_client'])) {
                                $time = convertTZtime(null, $time, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
                            } // if
                            $text = $time;
                            break;
            	    	default:
            	    	    $text = ' ';
            	    		break;
            	    } // switch
            	} // if

                if (isset($attributes['width'])) {
            		$cell_width = $attributes['width'];
            	} else {
                	$cell_width = ceil($this->GetStringWidth($text) + $this->millimeters2units(2));
        	    } // if

        	    while ($this->GetStringWidth($text) > $cell_width - $this->millimeters2units(2)) {
        	        // field is not allowed to overflow, so truncate it to fit
            		$text = substr($text, 0, strlen($text) - 2);
            	} // while

            	if (isset($attributes['height'])) {
                	$line_height = $attributes['height'];
                } else {
                    $line_height = $height;
                } // if

                if (isset($attributes['align'])) {
                    // absolute cell positioning on page - left, center or right
                	$palign = strtoupper(substr($attributes['align'], 0, 1));
                	unset($attributes['align']);
                	if ($palign == 'C') {
                	    // put cell in center of page
                        $X = ($this->printable_width - $cell_width) / 2;
                    	$this->setX($X + $this->lMargin);
                    } elseif ($palign == 'R') {
                        // put cell against the right margin
                        $X = ($this->printable_width - $cell_width);
                    	$this->setX($X + $this->lMargin);
                    } elseif ($palign == 'L') {
                        // put cell against the left margin
                    	$this->setX($this->lMargin);
                    } // if
                } else {
                	if (isset($attributes['x'])) {
                	    // adjujst position relative to left margin
                	    $this->setX($this->lMargin + $attributes['x']);
                	} // if
                } // if

            	if (isset($attributes['margin_left'])) {
        	        // increase X coordinate to include this margin
        	    	$X = $this->getX() + $attributes['margin_left'];
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['border'])) {
        	        $border = strtoupper($attributes['border']);
        	        if ($border == 'Y') {
        	        	$border = 'LRTB';
        	        } // if
        	    } // if

        	    if (isset($attributes['image'])) {
        	    	$imagewidth  = $this->pixelsToUnits($attributes['imagewidth']);
            	    $imageheight = $this->pixelsToUnits($attributes['imageheight']);
            	    $imagename   = $attributes['image'];
            	    if (substr($imagename, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($imagename, 2);
                    	if (isset($this->fieldarray[$fieldname])) {
                    		$imagename = $this->fieldarray[$fieldname];
                    	} // if
                    } // if
            	    if (isset($attributes['image_border'])) {
                    	$image_border = 'LRTB';
                    } else {
                        $image_border = false;
                    } // if
            	    $this->Image($imagename, $this->getX(), $this->getY(), $imagewidth, $imageheight, '', '', '', false, 0, '', false, false, $image_border);
            		//$this->Image($imagename, $this->getX(), $this->getY(), $imagewidth, $imageheight);

        	    } else {
            	    // if text is too long it must be truncated
            	    $str_width = $this->GetStringWidth($text);
            	    while ($str_width > $cell_width - $this->millimeters2units(1)) {
                		$text = substr($text, 0, strlen($text) - 1);
                		$str_width = $this->GetStringWidth($text);
                	} // while

                	$link              = null;
                	$ignore_min_height = false;
                	$calign            = 'T';

                    $this->Cell($cell_width, $line_height, $text, $border, 0, $halign, $fill, $link, $stretch, $ignore_min_height, $calign, $valign);
        	    } // if

                if (isset($attributes['margin_right'])) {
        		    // increase X coordinate to include this margin
        		    $X = $this->getX() + $attributes['margin_right'];
        	    	$this->setX($X);
        	    } // if
            } // if
        } // foreach

        return;

    } // printFooter

    // ****************************************************************************
    function printRow ($print_array, $function, $border, &$fill)
    // print a row containing one or more cells of data.
    // NOTE: $fill is passed BY REFERENCE as it may be changed.
    // NOTE: $function contains the name of the calling function.
    {
        $max_lines         = 1;
        $image_height      = 0;
        $this->last_height = 0;
        $height            = 0;
        $max_height        = 0;
        $paddings          = $this->default_padding;

        // calculate number of lines required for each cell in this row
        foreach ($print_array as $cellno => $celldata) {
        	$celldata = $this->getLineCount($celldata);
        	$print_array[$cellno] = $celldata;  // update array element (required for PHP4)
        	if (isset($celldata['imageheight'])) {
                if (isset($celldata['imageheight_conv'])) {
                    $imageheight_conv = $celldata['imageheight_conv'];
                } else {
                    $imageheight_conv = $this->pixelsToUnits($celldata['imageheight']);
                } // if
        	    if (preg_match('/(multi)$/i', $function)) {
        	        // keep image size independent of $line_count
        	        $line_count   = 0;
    	    	    $image_height = $imageheight_conv;
    	    	    //$height       = $celldata['imageheight'];
                    $height       = $celldata['height'];
        	    } else {
            		// include image size in $line_count
            	    $line_count   = $imageheight_conv / $this->last_height;
            	    $image_height = 0;
            	    $height       = $imageheight_conv;
                    //$height = $celldata['imageheight'];
        	    } // if
        	} elseif (isset($celldata['barcode'])) {
        	    if (isset($celldata['height'])) {
        	        if (preg_match('/(multi)$/i', $function)) {
        	            // keep barcode size independent of $line_count
        	            $line_count   = 0;
                	    $image_height = $celldata['height'];
                	    $height       = $celldata['height'];
        	        } else {
                        // include barcode size in $line_count
            	    	$line_count   = $celldata['height'] / $this->last_height;
            	    	$image_height = 0;
            	    	$height       = $celldata['height'];
        	        } // if
        	    } // if
        	} else {
        	    if (isset($celldata['line_array'])) {
        	    	$line_count = count($celldata['line_array']);
        	    } else {
        	        $line_count = 0;
        	    } // if
        	    $height = $celldata['height'];
        	} // if

            if (isset($celldata['padding_top'])) {
                if ($celldata['padding_top'] > $paddings['T']) {
                    $paddings['T'] = $celldata['padding_top'];
                } // if
            } // if
            if (isset($celldata['padding_bottom'])) {
                if ($celldata['padding_bottom'] > $paddings['B']) {
                    $paddings['B'] = $celldata['padding_bottom'];
                } // if
            } // if

        	if ($line_count > $max_lines) {
        		$max_lines = $line_count;
        	} // if
        	if ($height > $max_height) {
        		$max_height = $height;
        	} // if
        	if (isset($celldata['y'])) {
            	$set_Y = $celldata['y'];
            } // if
            if (isset($celldata['y_minimum'])) {
            	$set_Y_minimum = $celldata['y_minimum'];
            } // if
            if (isset($celldata['y_relative'])) {
            	$set_Y_relative = $celldata['y_relative'];
            } // if
        } // foreach

        if (isset($set_Y_minimum)) {
        	if ($this->getY() > $set_Y_minimum) {
        	    // too far down current page, so start a new page
        	    $this->addPage();
        	} // if
        } // if
        if (isset($set_Y)) {
        	$this->setY($set_Y);
        } elseif (isset($set_Y_relative)) {
        	$this->setY($this->getY() + $set_Y_relative);
        } // if

        // will this row fit on the current page?
        if (isset($image_height) AND $image_height > 0) {
            $space_left = ($this->PageBreakTrigger - $this->getY()) - $image_height;
            if ($space_left < 1) {
        	 	$this->AddPage();  // start a new page
        	} // if
        } // if

        if ($paddings['T'] > 0) {
            $max_lines++;  // add an extra blank line for padding_top
            foreach ($print_array as $cellno => $celldata) {
                array_unshift($celldata['line_array'], '');
                $print_array[$cellno] = $celldata;
            } // foreach
        } // if
        if ($paddings['B'] > 0) {
            $max_lines++;  // add an extra blank line for padding_bottom
            foreach ($print_array as $cellno => $celldata) {
                $celldata['line_array'][] = '';
                $print_array[$cellno] = $celldata;
            } // foreach
        } // if

        if (isset($this->structure['pdf']['label_print'])) {
            $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
            if ($max_lines > $lines_left) {
                $this->AddPage();  // start a new page
            } // if

            // print each multi-line cell in a single operation
            foreach ($print_array as $cellno => $celldata) {
                $celldata['cellno']   = $cellno;
                $celldata['lastcell'] = count($print_array)-1;
                $this->printCell($celldata, 0, 0, $border, $fill, 0, $function);
            } // foreach
            $this->Ln($this->lasth);
            $margins = $this->getCellMargins();
            if ($margins['B'] > 0) {
            	$this->Ln($margins['B']);  // include space for bottom margin
            } // if

        } else {
            $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
            if ($max_lines > $lines_left) {
                if ($max_lines < 3) {
                    $this->AddPage();  // start a new page
                } // if
            } // if

            for ($i = 0; $i < $max_lines; $i++) {
                $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
                if ($lines_left < 1) {
                    $this->AddPage();
                    if (isset($this->structure['title'])) {
                    	if (isset($this->structure['title']['body_gap'])) {
                    	    $gap = $this->structure['title']['body_gap'];
                    	} else {
                    	    $gap = $this->millimeters2units(1);  // default is 1mm
                    	} // if
                    	if ($gap > 0) {
                    		$this->setY($this->getY() + $gap);  // leave a gap under the title
                        } // if
                    } // if
                } // if
                if ($this->new_page_fill == true) {
                	$fill = 0;
                	$this->new_page_fill = false;
                } // if
                if ($i+1 == $max_lines AND $max_lines > 1) {
                    $last_height = $this->last_height;
                } elseif ($i+1 > $max_lines) {
                	// this is the last line, but what is its depth?
                	$last_height = $max_height - ($i * $this->last_height);
                } else {
                    $last_height = 0;
                } // if

                // reset padding to defaults
                $this->setCellPaddings($this->default_padding['L'], $this->default_padding['T'], $this->default_padding['R'], $this->default_padding['B']);

                // print one line from each cell before advancing to next line
                unset($cell_padding);
                foreach ($print_array as $cellno => $celldata) {
                    if (isset($celldata['nofillcolour'])) {
                        $cell_fill = 0;
                    } else {
                        $cell_fill = $fill;
                    } // if
                    if ($paddings['T'] > 0 AND $i == 0) {
                        // add an empty line for the top padding
                        $cell_padding = array('default_style' => $celldata['default_style']);
                        $cell_padding['line_array']        = $celldata['line_array'];
                        $cell_padding['width']             = $celldata['width'];
                        $cell_padding['height']            = $paddings['T'];
                        $cell_padding['ignore_min_height'] = true;
                        $this->printCell($cell_padding, $i, $max_lines-1, $border, $cell_fill, $cell_padding['height'], $function);
                    } elseif ($paddings['B'] > 0 AND $i == $max_lines-1) {
                        // add an empty line for the bottom padding
                        $cell_padding = array('default_style' => $celldata['default_style']);
                        $cell_padding['line_array']        = $celldata['line_array'];
                        $cell_padding['width']             = $celldata['width'];
                        $cell_padding['height']            = $paddings['B'];
                        $cell_padding['ignore_min_height'] = true;
                        $this->printCell($cell_padding, $i, $max_lines-1, $border, $cell_fill, $cell_padding['height'], $function);
                    } else {
                        // add normal lines between the top and bottom padding
                        $celldata['cellno']   = $cellno;
                        $celldata['lastcell'] = count($print_array)-1;
                        $this->printCell($celldata, $i, $max_lines-1, $border, $cell_fill, $last_height, $function);
                    } // if
                } // foreach
                // end of current line, so move to start of next line
                if (isset($cell_padding) AND is_array($cell_padding)) {
                    $this->Ln($cell_padding['height']);
                } elseif ($last_height <> 0) {
                	$this->Ln($last_height);
                } elseif (preg_match('/(multi)$/i', $function)) {
                    if ($max_height > $this->last_height) {
                        $this->Ln($max_height);
                    } else {
                        $this->Ln($this->last_height);
                    } // if
                } else {
                    $this->Ln($this->last_height);
                } // if
                $this->new_page = false;
            } // for
        } // if

        $this->new_page = false;

        return;

    } // printRow

    // ****************************************************************************
    function replaceFonts ($language)
    // examine $this->style and replace all font names
    {
    	if (is_array($this->font_replacement) AND !empty($this->font_replacement)) {
    		if (array_key_exists($language, $this->font_replacement)) {
    			$new_font = $this->font_replacement[$language];
			} else {
				return FALSE;
    		} // if
		} else {
			return FALSE;
    	} // if

    	foreach ($this->style as $style => $style_data) {
    		if (isset($style_data['font']) AND isset($style_data['font']['family'])) {
    			//if (!isset($style_data['font']['no_font_replacement'])) {
                if (isset($style_data['font']['font_replacement'])) {
    				$this->style[$style]['font']['family'] = $new_font;
    			} // if
    		} // if
    	} // foreach

    	return TRUE;

	} // replaceFonts

    // ****************************************************************************
    function setBarcodeStyle ($style)
    // set barcode style (font, colours, etc)
    {
        $result = array();
        if (!array_key_exists($style, $this->style)) {
            return $result;
        } // if

        $result = $this->style[$style];

        if (isset($this->style[$style]['drawcolour'])) {
            if (!empty($this->style[$style]['drawcolour'])) {
                $this->SetDrawColor($this->style[$style]['drawcolour'][0], $this->style[$style]['drawcolour'][1], $this->style[$style]['drawcolour'][2]);
            } else {
                $this->DrawColor = null;
                unset($result['draw']);
            } // if
        } // if

        return $result;

    } // setBarcodeStyle

    // ****************************************************************************
    function setFooter ()
    // override the method in the parent class (which is corrupt!)
    {
        $this->InFooter = true;
        if ($this->print_footer) {
            $lasth = $this->lasth;
            $this->_out("q");
            $this->Footer();
            $this->_out("Q");
            $this->lasth = $lasth;
        } // if
        $this->InFooter = false;

    } // setFooter

    // ****************************************************************************
    function setHeader ()
    // override the method in the parent class (which is corrupt!)
    {
        if ($this->print_header) {
            $lasth = $this->lasth;
            $this->_out("q");
            $this->Header();
            $this->_out("Q");
            $this->lasth = $lasth;
        } // if

    } // setHeader

    // ****************************************************************************
    function setPrintStyle ($style, $prev_style=null)
    // set print style (font, colours, etc)
    {
        $result = array();
        if (!array_key_exists($style, $this->style)) {
            $style = 'default';
        } // if

        if (!is_array($this->style[$style]['font'])) {
        	return $result;
        } // if

        if (is_array($prev_style) AND !empty($prev_style)) {
            // load in previous style which may be overridden
            $result = $prev_style;
        } // if

    	if (isset($this->style[$style]['font']['family'])) {
            $result['family'] = $this->style[$style]['font']['family'];
            $result['style']  = $this->style[$style]['font']['style'];
            $result['size']   = $this->style[$style]['font']['size'];
        } // if

        if (isset($this->style[$style]['font']['style'])) {
        	$result['style'] = $this->style[$style]['font']['style'];
        } // if

        if (isset($this->style[$style]['font']['size'])) {
            $result['size']  = $this->style[$style]['font']['size'];
        } // if

        if (isset($result['family']) AND isset($result['style']) AND isset($result['size'])) {
            $this->SetFont($result['family'], $result['style'], $result['size']);
        } // if

        if (isset($this->style[$style]['font']['height'])) {
            // set line height for cells which use this font
            $result['height'] = $this->style[$style]['font']['height'];
//            if ($result['height'] > $this->last_height) {
//                $this->last_height = $result['height'];
//            } // if
        } // if

        if (isset($this->style[$style]['font']['draw'])) {
        	// set width for border lines
            $this->SetLineWidth($this->style[$style]['font']['draw']);
            $result['draw'] = $this->style[$style]['font']['draw'];
        } // if
        if (isset($this->style[$style]['font']['align'])) {
        	// switch from 'align' to 'halign'
            $result['halign'] = $this->style[$style]['font']['align'];
        } // if

        if (isset($this->style[$style]['font']['halign'])) {
        	// set horizotal alignment for text within current cell
            $result['halign'] = $this->style[$style]['font']['halign'];
        } // if

        if (isset($this->style[$style]['font']['valign'])) {
        	// set vertical alignment for text within current cell
            $result['valign'] = $this->style[$style]['font']['valign'];
        } // if

        if (isset($this->style[$style]['font']['stretch'])) {
        	// set stretch for text within current cell
            $result['stretch'] = $this->style[$style]['font']['stretch'];
        } // if

        if (isset($this->style[$style]['fillcolour'])) {
            if (!empty($this->style[$style]['fillcolour'])) {
            	$this->SetFillColor($this->style[$style]['fillcolour'][0], $this->style[$style]['fillcolour'][1], $this->style[$style]['fillcolour'][2]);
            } else {
                $this->FillColor = null;
                $result['nofillcolour'] = 'y';
            } // if
        } // if

        if (isset($this->style[$style]['drawcolour'])) {
            if (!empty($this->style[$style]['drawcolour'])) {
            	$this->SetDrawColor($this->style[$style]['drawcolour'][0], $this->style[$style]['drawcolour'][1], $this->style[$style]['drawcolour'][2]);
            } else {
                $this->DrawColor = null;
                unset($result['draw']);
            } // if
        } // if

        if (isset($this->style[$style]['textcolour'])) {
        	$this->SetTextColor($this->style[$style]['textcolour'][0], $this->style[$style]['textcolour'][1], $this->style[$style]['textcolour'][2]);
        } // if

        //$paddings = $this->getCellPaddings();
        $paddings = $this->default_padding;

        if (isset($this->style[$style]['font']['padding_left'])) {
            $paddings['L']            = $this->style[$style]['font']['padding_left'];
            $result['padding_left']   = $paddings['L'];
        } // if
        if (isset($this->style[$style]['font']['padding_right'])) {
            $paddings['R']            = $this->style[$style]['font']['padding_right'];
            $result['padding_right']  = $paddings['R'];
        } // if
        if (isset($this->style[$style]['font']['padding_top'])) {
            $paddings['T']            = $this->style[$style]['font']['padding_top'];
            $result['padding_top']    = $paddings['T'];
        } // if
        if (isset($this->style[$style]['font']['padding_bottom'])) {
            $paddings['B']            = $this->style[$style]['font']['padding_bottom'];
            $result['padding_bottom'] = $paddings['B'];
        } // if
        $this->setCellPaddings($paddings['L'], $paddings['T'], $paddings['R'], $paddings['B']);

        $margins = $this->getCellMargins();

        if (isset($this->style[$style]['font']['margin_left'])) {
            $margins['L']            = $this->style[$style]['font']['margin_left'];
            $result['margin_left']   = $margins['L'];
        } // if
        if (isset($this->style[$style]['font']['margin_right'])) {
            $margins['R']            = $this->style[$style]['font']['margin_right'];
            $result['margin_right']  = $margins['R'];
        } // if
        if (isset($this->style[$style]['font']['margin_top'])) {
            $margins['T']            = $this->style[$style]['font']['margin_top'];
            $result['margin_top']    = $margins['T'];
        } // if
        if (isset($this->style[$style]['font']['margin_bottom'])) {
            $margins['B']            = $this->style[$style]['font']['margin_bottom'];
            $result['margin_bottom'] = $margins['B'];
        } // if
        $this->setCellMargins($margins['L'], $margins['T'], $margins['R'], $margins['B']);

        return $result;

    } // setPrintStyle

    // ****************************************************************************
    function validateStructure ($structure)
    // check that the report structure is valid.
    {
        // read report structure from external file
        if (empty($structure)) {
            // 'Report structure has not been defined'
            trigger_error(getLanguageText('sys0160'), E_USER_ERROR);
        } // if

        // validate report structure details
        if (isset($structure['pdf']['orientation'])) {
        	$orientation = $structure['pdf']['orientation'];
        } else {
            // orientation has not been defined in $report
            trigger_error(getLanguageText('sys0161', $report), E_USER_ERROR);
        } // if

        if (isset($structure['pdf']['units'])) {
        	$units = $structure['pdf']['units'];
        } else {
            // units have not been defined in $report
            trigger_error(getLanguageText('sys0162', $report), E_USER_ERROR);
        } // if

        if (isset($structure['pdf']['format'])) {
        	$format = $structure['pdf']['format'];
        } else {
            // format has not been defined in $report
            trigger_error(getLanguageText('sys0163', $report), E_USER_ERROR);
        } // if

        if (!empty($structure['pdf']['name'])) {
        	$this->filename = $structure['pdf']['name'];
        } else {
            $this->filename = 'doc.pdf';
        } // if

        if (isset($structure['pdf']['destination'])) {
        	$this->pdf_destination = $structure['pdf']['destination'];
        } else {
            $this->pdf_destination = 'I';
        } // if

        $this->units = $units;

        if (isset($structure['main']['line']['width'])) {
            $this->line_width = $structure['main']['line']['width'];
        } else {
        	$this->line_width = $this->millimeters2units(0.2);
        } // if

        // load default style
        $this->style['default']['font'] = array('family' => 'Helvetica',// Courier, Helvetica, Times
                                                'style' => '',          // blank=Regular, B=Bold, I=Italic, U=Underline
                                                'size' => 11,           // size in points
                                                'height' => 5,          // line height in units
                                                'draw' => .2,           // width of drawn lines
                                                'halign' => 'left');    // horizontal text alignment

        $this->style['default']['fillcolour'] = false;                  // transparent background
        $this->style['default']['textcolour'] = array(0,0,0);           // colour for foreground
        $this->style['default']['drawcolour'] = array(0,0,0);           // colour for line drawing

        if (!empty($this->fontlist)) {
            // constructor has already been called, so don't call it again
        } else {
        	// now call constructor in parent class
            if (version_compare(phpversion(), '5.0.0', '<')) {
			    parent::TCPDF($orientation, $units, $format, true, 'UTF-8', false, false);
			} else {
			    parent::__construct($orientation, $units, $format, true, 'UTF-8', false, false);
			} // if
        } // if

        // change all occurrences of 'marginX' to 'margin_X'
        $structure['pdf'] = $this->addUnderscore($structure['pdf']);

        if (isset($structure['pdf']['margin_left'])) {
    	    $this->SetLeftMargin($structure['pdf']['margin_left']);
        } // if
    	if (isset($structure['pdf']['margin_right'])) {
    	    $this->SetRightMargin($structure['pdf']['margin_right']);
        } // if
        if (isset($structure['pdf']['margin_top'])) {
    	    $this->SetTopMargin($structure['pdf']['margin_top']);
        } // if
        if (isset($structure['pdf']['margin_bottom'])) {
    	    $this->SetAutoPageBreak($this->AutoPageBreak, $structure['pdf']['margin_bottom']);
        } // if

        $this->default_padding = $this->getCellPaddings();

        $this->printable_width = $this->w - ($this->lMargin + $this->rMargin);

        return $structure;

    } // validateStructure

// ****************************************************************************
} // end class
// ****************************************************************************

?>
