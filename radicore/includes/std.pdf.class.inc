<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require 'tcpdf/tcpdf_php4.php';
} else {
    // PHP 5 uses different code
    require 'tcpdf/tcpdf_php5.php';
} // if

class PDF extends TCPDF
{
    // member variables
    var $dbobject;                  // the database object from which this is being activated
    var $destination = 'I';         // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String
    var $fieldarray = array();      // array of field data
    var $filename = '';             // filename (if destination = D or F)
    var $last_height;               // last line height
    var $line_width = .2;           // width for line drawing (borders, boxes, etc)
    var $new_page = false;          // set to TRUE when a new page has been started
    var $new_page_fill;             // set to TRUE when a new page has been started
    var $printable_width;           // width of printable area (without margins)
    var $structure = array();       // report structure
    var $style = array();           // array of print styles
    var $text_align;                // text alignment
    var $total_width = 0;           // total width of all cells

    var $print_header = FALSE;      // do not print page header
    var $print_footer = FALSE;      // do not print page footer

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function PDF ($structure)
    // validate contents of $report structure file
    {
        if (file_exists('pdf.styles.inc')) {
            // load file of print styles
        	require_once 'pdf.styles.inc';
        	$this->style = $style;
        } // if

        $this->validateStructure ($structure);

        return;

    } // PDF

    // ****************************************************************************
    function AddPage ($orientation=null, $format=null)
    // start a new page.
    {
        $save_last_height = $this->last_height;
        parent::AddPage ($orientation, $format);
        $this->last_height = $save_last_height;

    } // addPage

    // ****************************************************************************
    function Cell ($w, $h=0, $txt='', $border=0, $ln=0, $align='', $fill=0, $link='', $stretch=0)
    // this is a wrapper for the parent method
    {
        $align = strtoupper(substr($align, 0, 1));

        parent::Cell ($w, $h, $txt, $border, $ln, $align, $fill, $link, $stretch);

    } // Cell

    // ****************************************************************************
    function detailView (&$object, $resource)
    // output data in DETAIL view (one record per page, labels on left, data on right)
    {
        // turn on page header and footer
        $this->AliasNbPages();
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

        $fieldspec = $object->fieldspec;

        $first_body_line = true;
        $border = 1;
        $fill = 1;

        // add each row to the document in a separate page
        while ($fieldarray = $object->fetchRow($resource)) {
            if ($object->errors) {
                return;
            } // if
            if (empty($object->report_structure)) {
                // reload report structure is the customer's language
            	$object->report_structure = getReportSructure($GLOBALS['report']);
            	$this->validateStructure($object->report_structure);
            } // if
            // perform any formatting on retrieved data
            $style_array = array();
            $fieldarray_formatted = $object->formatData($fieldarray, $style_array);
            $this->fieldarray = $fieldarray_formatted;  // make this accessible to Header() method
            $this->AddPage();
            // output each field in the required order
            foreach ($this->structure['body']['fields'] as $column => $columndata) {
                if ($first_body_line) {
                	$this->setY($this->getY()+1);  // leave a gap under the title
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
                    $cellspec = array();
                    $cellspec['default_style'] = $this->structure['label']['style'];
                    $cellspec['text']  = getLanguageText($fieldlabel);

                    // extract width and alignment of label column
                	if (isset($this->structure['columns'][0]['width'])) {
                		$cellspec['width'] = $this->structure['columns'][0]['width'];
                	} else {
                	    // default is width is 1/3 page width
                    	$cellspec['width'] = $this->printable_width / 3;
                	} // if
                	if (isset($this->structure['columns'][0]['align'])) {
                    	$cellspec['align'] = $this->structure['columns'][0]['align'];
                    } // if

                    $print_array[0] = $cellspec;

                    // follow with field data
                    $cellspec = array();
                    $cellspec['default_style'] = $this->structure['data']['style'];
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

                	if (isset($this->structure['columns'][1]['width'])) {
                		$cellspec['width'] = $this->structure['columns'][1]['width'];
                	} else {
                	    // default is width is 2/3 page width
                    	$cellspec['width'] = $this->printable_width / (3/2);
                	} // if
                	if (isset($this->structure['columns'][1]['align'])) {
                    	$cellspec['align'] = $this->structure['columns'][1]['align'];
                    } // if

                	$print_array[1] = $cellspec;

                	$result = $this->printRow($print_array, __FUNCTION__, $border, $fill);

                } else {
                    // there is a separate entry for each label or field in the current line

                    // construct a row of cells which are to be printed
                    $print_array = array();
                    foreach ($columndata as $cellno => $cellspec) {
                        $cellspec = array_change_key_case($cellspec, CASE_LOWER);

                        if (!isset($cellspec['width'])) {
                    		// default is width divided by number of columns
                    	    $cell_width = $this->printable_width / count($columndata);
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
                            $cellspec['default_style'] = $this->structure['label']['style'];
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

            // examine any optional additional entries named 'multi1' to 'multi99'
            for ($i = 1; $i <= 100; $i++) {
                $zone = 'multi' .$i;
                if (!array_key_exists($zone, $this->structure)) {
                	break;  // not found, so stop processing
                } // if
                $this->detailView_multi($object, $zone, $fieldarray);
            } // for

            $first_body_line = true;

        } // while

        return;

    } // detailView

    // ****************************************************************************
    function detailView_multi (&$object, $zone, $current_row)
    // append additional data to the current page, where this additional data is
    // obtained by making callbacks to the database object.
    {
        // obtain a number of rows of data for this named area
        $newdata = $object->_cm_output_multi($zone, $current_row);

        $fieldspec = $object->fieldspec;

        $border = 1;
        $fill   = 1;

        $nbsp = chr(194).chr(160); // non-breaking space

        // process each row, which may produce multiple lines of output
        foreach ($newdata as $rownum => $fieldarray) {
            $style_array = array();
            $fieldarray = $object->formatData($fieldarray, $style_array);
            // construct a row of cells which are to be printed
            foreach ($this->structure[$zone]['fields'] as $column => $columndata) {
                $print_array = array();
                // construct $cellspec for each cell, then add it to $print_array
                foreach ($columndata as $cellno => $cellspec) {
                    $cellspec = array_change_key_case($cellspec, CASE_LOWER);
                    if (array_key_exists('label', $cellspec)) {
                        $cellspec['default_style'] = $this->structure['label']['style'];
                        $cellspec['text'] = getLanguageText($cellspec['label']);

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

                    } elseif (array_key_exists('barcode', $cellspec)) {
                        $cellspec['default_style'] = $this->structure['label']['style'];
                        if (array_key_exists($cellspec['barcode'], $fieldarray)) {
                        	$cellspec['barcode'] = $fieldarray[$cellspec['barcode']];
                        } else {
                            $cellspec['barcode'] = '';
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

        return;

    } // detailView_multi

    // ****************************************************************************
    function Error ($msg='')
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
        $height = $this->setPrintStyle($this->structure['foot']['style']);

        // Position at 1.5cm from bottom
        $this->SetY(-15);

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
        $height = $this->setPrintStyle($celldata['default_style']);
        if (isset($celldata['style'])) {
        	$height = $this->setPrintStyle($celldata['style']);
        } // if

        if (isset($celldata['height']) AND !isset($celldata['barcode'])) {
        	$this->last_height = $celldata['height'];
        } else {
            // use largest font height
            if ($this->last_height < $height) {
            	$this->last_height = $height;
            } // if
        } // if

        $cell_width = $celldata['width'];

        if (isset($celldata['fieldspec']) AND isset($celldata['fieldspec']['subtype'])) {
    		if ($celldata['fieldspec']['subtype'] == 'image') {
    			// this cell will also contain an image, so deduct image width from text width
    			// (this includes a 0.5mm margin on the left and right)
    			$cell_width = $cell_width - $this->Pixels2Units($celldata['fieldspec']['imagewidth']) -1;
    			$celldata['width'] = $cell_width;
    			// insert height of image in current units
    			$celldata['imageheight'] = ceil($this->Pixels2Units($celldata['fieldspec']['imageheight']));
    		} // if
        } // if

        $text = str_replace("\r",'', $celldata['text']);

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
            if ($this->GetStringWidth($line) > $cell_width-2.25 ) {
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

        if (!empty($line)) {
            // append last fragment
        	$celldata['line_array'][] = trim($line);
        } // if

        return $celldata;

    } // getLineCount

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

        $dateobj =& singleton::getInstance('date_class');

        // process each element in 'title' array
        $max_depth = 0;
        foreach ($this->structure['title'] as $element => $attributes) {
            if (is_integer($element)) {
            	// this is something that goes in the title area

            	// set default style for whole title
            	$height = $this->setPrintStyle($this->structure['title']['style']);
            	if (isset($attributes['style'])) {
            	    // use style specified for this element
            	    $height = $this->setPrintStyle($attributes['style']);
            	} // if

            	if (isset($attributes['image'])) {
            	    $cell_width = $this->Pixels2Units($attributes['imagewidth']);
            	} elseif (isset($attributes['width'])) {
            	    $cell_width = $attributes['width'];
            	} elseif (isset($attributes['text'])) {
            	    $cell_width = ceil($this->GetStringWidth($attributes['text']) + 2);
            	} else {
            	    $cell_width = 10;
            	} // if

            	if (isset($attributes['align'])) {
            	    // absolute positioning - left, center or right
                	$align = strtoupper(substr($attributes['align'], 0, 1));
                    if ($align == 'C') {
                        $X = ($this->printable_width - $cell_width) /2;
                    	$this->setX($X + $this->lMargin);
                    } elseif ($align == 'R') {
                        $X = ($this->printable_width - $cell_width);
                    	$this->setX($X + $this->lMargin);
                    } elseif ($align == 'L') {
                    	$this->setX($this->lMargin);
                    } // if
                } else {
                    if (isset($attributes['x'])) {
                        // relative to left margin
                	    $this->setX($this->lMargin + $attributes['x']);
            	    } // if
                } // if

            	if (isset($attributes['y'])) {
            	    // relative to top margin (i.e. absolute)
            	    $this->setXY($this->getX(), $this->tMargin + $attributes['y']);
            	} elseif (isset($attributes['y_relative'])) {
            	    // relative to last cell
                	$this->setXY($this->getX(), $this->getY() + $attributes['y_relative']);
                } // if

            	if (isset($attributes['marginleft'])) {
        	        // increase X coordinate to include this margin
        	    	$X = $this->getX() + $attributes['marginleft'];
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['border'])) {
        	    	$border = 1;
        	    } else {
        	        $border = 0;
        	    } // if

            	if (isset($attributes['image'])) {
            	    $imagewidth  = $this->Pixels2Units($attributes['imagewidth']);
            	    $imageheight = $this->Pixels2Units($attributes['imageheight']);
            	    $this->Image($attributes['image'], $this->getX(), $this->getY(), $imagewidth, $imageheight);
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

            	    $celldata['default_style'] = $this->structure['title']['style'];
            	    $text = $celldata['barcode'];
                    if (substr($text, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($text, 2);
                    	if (isset($this->fieldarray[$fieldname])) {
                    		$text = $this->fieldarray[$fieldname];
                    	} // if
                    } // if
                    $celldata['barcode'] = $text;

                    if (isset($celldata['nofill'])) {
                    	$fill = 0;
                    } else {
                        $fill = 1;
                    } // if
                    $this->printCell($celldata, 0, 0, $border, $fill);
                    $depth             = $celldata['height'];
                    $this->last_height = $celldata['height'];

            	} elseif (isset($attributes['text']) OR isset($attributes['type'])) {
            	    if (isset($attributes['text'])) {
            	    	$text = $attributes['text'];
                        if (substr($text, 0, 2) == '%%') {
                            // replace field name with field data
                        	$fieldname = substr($text, 2);
                        	if (isset($this->fieldarray[$fieldname])) {
                        		$text = $this->fieldarray[$fieldname];
                        	} // if
                        } // if
            	    } elseif (isset($attributes['type'])) {
            	        switch (strtolower($attributes['type'])) {
                	    	case 'pageno':
                	    		// Print 'Page n of n'
                                $text = getLanguageText('Page') .' ' .$this->PageNo() .' ' .getLanguageText('of') .' ' .$this->AliasNbPages;
                	    		break;
                	    	case 'date':
                	    	    // get date in user-defined format
                                $text = $dateobj->getExternalDate(date('Y-m-d'));
                	    	    break;
                	    	case 'time':
                                $text = date('H:i:s');
                                break;
                	    	default:
                	    	    $text = ' ';
                	    		break;
                	    } // switch
            	    } // if

                    if (isset($attributes['height'])) {
                    	$line_height = $attributes['height'];
                    } else {
                        $line_height = $height;
                    } // if

                    if (isset($attributes['nofill'])) {
                    	$fill = 0;
                    } else {
                        $fill = 1;
                    } // if

                    $line_count = $this->MultiCell($cell_width, $line_height, $text, $border, $this->text_align, $fill);
                    $depth = $line_count * $line_height;

            	} // if

            	if ($depth > $max_depth) {
                	$max_depth = $depth;
                } // if

            	if (isset($attributes['marginright'])) {
        		    // increase X coordinate to include this margin
        		    $X = $this->getX() + $attributes['marginright'];
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['newline'])) {
        	        $this->Ln($max_depth);
        	        $max_depth = 0;
        	    } // if
            } // if

        } // foreach

        // position pointer at bottom of deepest cell in current line
        $this->Ln($max_depth);

        return;

    } // Header

    // ****************************************************************************
    function listView (&$object, $resource)
    // output data in LIST view (column heading, then one row per record)
    {
        $this->dbobject =& $object;

        // turn on page header and footer
        $this->AliasNbPages();
        $this->print_header = true;
        if (isset($this->structure['foot1']) OR isset($this->structure['foot2'])) {
            $this->print_footer = true;
        } // if

        $this->setY($this->h);  // force first line to overflow current page and start a new one

        // set print style for main body
        if (!isset($this->structure['body']['style'])) {
        	$this->structure['body']['style'] = 'default';
        } // if
        $line_height = $this->setPrintStyle($this->structure['body']['style']);

        $fill = 0;
        $started = false;

        $previous_row = array();                     // initialise previous row
        $fieldarray = $object->fetchRow($resource);  // read first row
        // add each row to the document
        do {
            if ($object->errors) return;

            // perform any formatting on retrieved data
            $style_array = array();
            $fieldarray = $object->formatData($fieldarray, $style_array);
            $this->fieldarray = $fieldarray;  // make this data accessible to Header() method

            // find out if any rows need to be printed before this one
            $extra_rows = $object->_cm_ListView_pre_print ($previous_row, $fieldarray);

            // append current row then print them all
            if (!empty($fieldarray)) {
            	$extra_rows[] = $fieldarray;
            } // if
            foreach ($extra_rows as $rowdata) {
                // assemble a row of details
                $print_array = array();
                foreach ($this->structure['body']['fields'] as $column => $columndata) {
                    $print_array[] = $this->listView_assemble_row($column, $columndata, $rowdata, $style_array);
                } // foreach
                // now print this row
                $result = $this->printRow($print_array, __FUNCTION__, 'LR', $fill);
                $fill = !$fill;     // toggle between ON and OFF
            } // foreach

            $previous_row = $fieldarray;
            $fieldarray = $object->fetchRow($resource);

        } while (!empty($previous_row));

        // look for a line of totals to be printed (optional)
        $fieldarray = $object->_cm_ListView_total();
        if (!empty($fieldarray)) {
            // close bottom border on current line
            $this->Line($this->lMargin, $this->getY(), $this->lMargin + $this->total_width, $this->getY());
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
        $columndata = array_change_key_case($columndata, CASE_LOWER);
        $fieldname  = key($columndata);

        $cellspec = array();
        $cellspec['default_style'] = $this->structure['body']['style'];
        if (array_key_exists($fieldname, $style_array)) {
        	$cellspec['style'] = $style_array[$fieldname];
        } // if

        if (isset($this->structure['columns'][$column]['width'])) {
        	$cellspec['width'] = $this->structure['columns'][$column]['width'];
        } else {
            // default is width divided by number of columns
            $cellspec['width'] = $this->printable_width / count($this->structure['body']['fields']);
        } // if
        if (isset($this->structure['columns'][$column]['align'])) {
        	$cellspec['align'] = $this->structure['columns'][$column]['align'];
        } // if

        if (isset($fieldarray[$fieldname])) {
        	$text = $fieldarray[$fieldname];
        } else {
            $text = '';
        } // if

    	$text = str_replace("\n", ', ', $text);  // replace <newline> character
    	$cell_width = $cellspec['width'];
    	if (!isset($this->structure['columns'][$column]['overflow'])) {
    	    // field is not allowed to overflow, so truncate it to fit
    		while ($this->GetStringWidth($text) > $cell_width-2) {
        		$text = substr($text, 0, strlen($text) -2);
        	} // while
    	} // if

        $cellspec['text'] = $text;

        return $cellspec;

    } // listView_assemble_row

    // ****************************************************************************
    function MultiCell ($width, $height, $text, $border=0, $align='J', $fill=0)
    // this is a wrapper for the parent method
    {
        $align = strtoupper(substr($align, 0, 1));

        // save current X/Y coordinates
        $X = $this->getX();
        $Y = $this->getY();

        $cells = parent::MultiCell ($width, $height, $text, $border, $align, $fill);

        $line_count = ($this->getY() - $Y) / $height;

        // Put the position to the right of the cell
        $this->SetXY($X + $width, $Y);

        return $line_count;

    } // MultiCell

    // ****************************************************************************
    function Pixels2Units ($pixels)
    // convert value in pixels to current units
    {
        // this may be wrong, in which case each calculation may have to be changed
        switch ($this->units) {
        	case 'mm':
        		$output = $pixels/$this->k;
        		break;
        	case 'cm':
        	    $output = $pixels/$this->k;
        	    break;
        	case 'in':
        	    $output = $pixels/$this->k;
        	    break;
        	default:
        	    $output = $pixels/$this->k;
        		break;
        } // switch

        return $output;

    } // Pixels2nits

    // ****************************************************************************
    function printBarcode ($celldata)
    // print a barcode
    {
        if (isset($celldata['barcode_style'])) {
            // merge with contents of entry in pdf.styles.inc
        	$celldata = array_merge($this->style[$celldata['barcode_style']], $celldata);
        } // if

        if (!isset($celldata['type'])) {
        	$celldata['type']     = 'I25';
        } else {
            $celldata['type']     = strtoupper($celldata['type']);
        } // if
        if (!isset($celldata['xres'])) {
        	$celldata['xres']     = 0.4;
        } // if
        if (!isset($celldata['width'])) {
        	$celldata['width']    = 80;
        } // if
        if (!isset($celldata['height'])) {
        	$celldata['height']   = 25;
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
        if (isset($celldata['padding'])) {
        	$style['padding'] = $celldata['padding'];
        } else {
        	$style['padding'] = 1;
        } // if
        if (isset($celldata['position'])) {
        	$style['position'] = $celldata['position'];
        } else {
        	$style['position'] = 'C';
        } // if
        if (isset($celldata['border'])) {
        	$style['border'] = true;
        } // if
        if (isset($celldata['text'])) {
            $style['text'] = true;
            // font settings for text
            if (isset($celldata['font'])) {
                $style['font'] = $celldata['font'];
            } else {
            	$style['font'] = 'courier';
            	$style['fontstyle'] = 'B';
            } // if
            if (isset($celldata['fontstyle'])) {
                $style['fontstyle'] = $celldata['fontstyle'];
            } // if
            if (isset($celldata['fontsize'])) {
            	$style['fontsize'] = $celldata['fontsize'];
            } else {
            	$style['fontsize'] = 8;
            } // if
            if (isset($celldata['stretchtext'])) {
            	$style['stretchtext'] = $celldata['stretchtext'];
            } else {
            	$style['stretchtext'] = 0;  // no character spacing
            } // if
        } // if

        // make image 1 unit smaller than cell it will appear in to provide a small border
    	$celldata['width']  = $celldata['width'] -1;
    	$celldata['height'] = $celldata['height'] -1;

    	$X = $this->getX();
        $Y = $this->getY();

        // set up style details
    	if (!empty($celldata['style'])) {
			if (eregi('B', $celldata['style'])) $style['border'] = true;
		    if (eregi('D', $celldata['style'])) $style['text'] = true;
			if (eregi('N', $celldata['style'])) {
			    // negative, so reverse the colours
			    $style['fgcolor'] = array(255,255,255);  // white
			    $style['bgcolor'] = array(0,0,0);        // black
			} else {
			    $style['fgcolor'] = array(0,0,0);        // black
			    $style['bgcolor'] = false;               // transparent
			} // if
			// image position = L/C/R/X (Left, Center, Right, Stretch Image)
			if (eregi('L|C|R', $celldata['style'], $regs)) {
			    $style['position'] = $regs[0];
			} else {
			    $style['position'] = 'C';    // default is center
			} // if
			if (eregi('X', $celldata['style'], $regs)) {
			    $style['position'] = 'S';
			} // if
			if (eregi('S', $celldata['style'], $regs)) {
			    $style['stretchtext'] = 4;
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
			    $style['fontstyle'] = 'B';
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
    	} // if

    	$align = 'T';  // put pointer at top left of barcode image

    	$this->write1DBarcode($celldata['barcode'],
    	                      $celldata['type'],
    	                      $X+0.5, $Y+0.5, // offset to give 0.5 unit border all the way around
    	                      $celldata['width'], $celldata['height'],
    	                      $celldata['xres'],
    	                      $style,
    	                      $align);

    	// reset Y to last known position
    	$this->setY($Y);

    	// set X to start plus column width
    	//$this->setX($X + $celldata['width'] +1);

        return;

    } // printBarcode

    // ****************************************************************************
    function printCell ($celldata, $line_no, $last_line, $border, $fill=1, $height_diff=0)
    // print a line from this cell using the contents of $celldata
    {
        // set print style for current cell
        $height = $this->setPrintStyle($celldata['default_style']);
        if (isset($celldata['style'])) {
            // follow with overriding style
        	$height = $this->setPrintStyle($celldata['style']);  // set style override
        } // if

        if (strtoupper($this->DrawColor) == strtoupper($this->FillColor)) {
            // both colours are the same, so do not write any borders
        	$border = false;
        } // if

        if (isset($celldata['line_array'][$line_no])) {
        	$text = trim($celldata['line_array'][$line_no]);
        } else {
            $text = '';
        } // if
        $cell_width = $celldata['width'];
        if (isset($celldata['align'])) {
        	$align = $celldata['align'];
        } else {
            $align = $this->text_align;
        } // if
        if (isset($celldata['x'])) {
            // relative to left margin
    	    $this->setX($this->lMargin + $celldata['x']);
	    } // if

        if (isset($celldata['fieldspec'])) {
        	$fieldspec = $celldata['fieldspec'];
        } else {
            $fieldspec = array();
        } // if

        if (isset($fieldspec['subtype']) and $fieldspec['subtype'] == 'image') {
            $imagename   = $celldata['text'];
        	$imagewidth  = $this->Pixels2Units($fieldspec['imagewidth']);
            $imageheight = $this->Pixels2Units($fieldspec['imageheight']);
            if ($line_no == 0) {
                if (strlen($imagename) > 0) {
                	// output image on first line only
                    $this->Image($imagename, $this->getX()+0.5, $this->getY()+0.5, $imagewidth, $imageheight);
                } // if
        	} // if

        	$X = $this->getX();
        	$Y = $this->getY();
        	if ($line_no == 0) {
        	    if ($border == 1 OR eregi('T', $border)) {
        	    	// draw line along top border of 1st cell in 1st line, or 1st line of new page
                	$this->Line($X, $Y, $X + $imagewidth+1, $Y);
        	    } // if
            } // if
        	if ($line_no == $last_line) {
        	    if ($border == 1 OR eregi('B', $border)) {
                	// draw line along bottom border of last cell
                	$Y = $this->getY() + $height;
                	$this->Line($X, $Y, $X + $imagewidth+1, $Y);
        	    } // if
            } //if

        	// move text to right of image
        	$this->setX($this->getX() + $imagewidth+1);
        	$mod_border = 'R';  // do not print border between image and text
        } else {
            $mod_border = 'LR';
        } // if

        if (isset($celldata['height'])) {
	        $height = $celldata['height'];
	        if (!isset($celldata['barcode'])) {
	            // ignore this and retain height of previous cell
	        	$this->last_height = $height;
	        } // if
	    } // if

	    if (isset($celldata['marginleft'])) {
	        // increase X coordinate to include this margin
	    	$X = $this->getX() + $celldata['marginleft'];
	    	$this->setX($X);
	    } // if

	    if (isset($celldata['style'])) {
	        if (array_key_exists('fillcolour', $this->style[$celldata['style']])) {
	        	// style override has been supplied, so force background colour to be filled in
	           $fill = 1;
	        } // if
	    } // if

	    if ($height_diff <> 0) {
    	    // last line is shorter than normal, so adjust its height
    	    $height = $height * $height_diff;
        } // if

        $X = $this->getX();
        $Y = $this->getY();
        if (isset($celldata['barcode'])) {
            if ($line_no > 0) {
                // already processed, so do not repeat
            } else {
            	unset($celldata['default_style']);
            	$this->printBarcode($celldata);
            	if ($this->error) {
            	    $text = $this->error;
            		$this->Cell($cell_width, $height, $text, $mod_border, 0, $align, $fill);
            	} else {
            	    if ($border == 1 OR eregi('L', $border)) {
            	    	// draw line along left hand border
                    	$this->Line($X, $Y, $X, $Y + $celldata['height']);
            	    } // if
            	    if ($border == 1 OR eregi('T', $border)) {
            	    	// draw line along right hand border
                    	$this->Line($X + $celldata['width'], $Y, $X + $celldata['width'] , $Y + $celldata['height']);
            	    } // if
            	} // if
            } // if
            if (!$this->error) {
                $this->setX($X + $celldata['width']);
            } // if
        } else {
            if (array_key_exists('notext', $celldata['fieldspec'])) {
            	// write a line without any text
            	$this->Cell($cell_width, $height, '', $mod_border, 0, $align, $fill);
            } else {
                // output a line of text in the current cell
                $this->Cell($cell_width, $height, $text, $mod_border, 0, $align, $fill);
            } // if
        } // if

        if ($line_no == 0 OR $this->new_page) {
            if ($border == 1 OR eregi('T', $border)) {
            	// draw line along top border of 1st cell in 1st line, or 1st line of new page
            	$this->Line($X, $Y, $X + $cell_width, $Y);
            } // if
        } // if

        $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;

        if ($line_no >= $last_line OR $lines_left < 2) {
            if ($border == 1 OR eregi('B', $border)) {
            	// draw line along bottom border of last cell
            	$Y = $Y + ($height);
            	$this->Line($X, $Y, $X + $cell_width, $Y);
            } // if
        } //if

        if (isset($celldata['marginright'])) {
	        // increase X coordinate to include this margin
	    	$X = $this->getX() + $celldata['marginright'];
	    	$this->setX($X);
	    } // if

        return;

    } // printCell

    // ****************************************************************************
    function printFooter ($zone)
    // print a line in the page footer
    {
        $dateobj =& singleton::getInstance('date_class');

        foreach ($this->structure[$zone] as $element => $attributes) {
            if (is_integer($element)) {
                if (isset($attributes['style'])) {
            	    // use style specified for this element
            	    $height = $this->setPrintStyle($attributes['style']);
            	} else {
            	    // use default style for whole title
            	    $height = $this->setPrintStyle($this->structure['foot']['style']);
            	} // if

            	if (isset($attributes['text'])) {
            		$text = $attributes['text'];
            		if (substr($text, 0, 2) == '%%') {
                        // replace field name with field data
                    	$fieldname = substr($text, 2);
                    	if (isset($this->fieldarray[$fieldname])) {
                    		$text = $this->fieldarray[$fieldname];
                    	} // if
                    } // if

            	} else {
                	switch (strtolower($attributes['type'])) {
            	    	case 'pageno':
            	    		// Print 'Page n of n'
                            $text = getLanguageText('Page') .' ' .$this->PageNo() .' ' .getLanguageText('of') .' ' .$this->AliasNbPages;
            	    		break;
            	    	case 'date':
            	    	    // get date in user-defined format
                            $text = $dateobj->getExternalDate(date('Y-m-d'));
            	    	    break;
            	    	case 'time':
                            $text = date('H:i:s');
                            break;
            	    	default:
            	    	    $text = ' ';
            	    		break;
            	    } // switch
            	} // if

                if (isset($attributes['width'])) {
            		$cell_width = $attributes['width'];
            	} else {
                	$cell_width = ceil($this->GetStringWidth($text) + 2);
        	    } // if

        	    while ($this->GetStringWidth($text) > $cell_width-2) {
            		$text = substr($text, 0, strlen($text) -2);
            	} // while

            	if (isset($attributes['height'])) {
                	$line_height = $attributes['height'];
                } else {
                    $line_height = $height;
                } // if

                if (isset($attributes['align'])) {
                	$align = strtoupper(substr($attributes['align'], 0, 1));
                    if ($align == 'C') {
                        $X = ($this->printable_width - $cell_width) /2;
                    	$this->setX($X + $this->lMargin);
                    } elseif ($align == 'R') {
                        $X = ($this->printable_width - $cell_width);
                    	$this->setX($X + $this->lMargin);
                    } // if
                } else {
                    $align = 'L';
                	if (isset($attributes['x'])) {
                	    // relative to left margin
                	    $this->setX($this->lMargin + $attributes['x']);
                	} // if
                } // if

            	if (isset($attributes['marginleft'])) {
        	        // increase X coordinate to include this margin
        	    	$X = $this->getX() + $attributes['marginleft'];
        	    	$this->setX($X);
        	    } // if

        	    if (isset($attributes['border'])) {
        	    	$border = 1;
        	    } else {
        	        $border = 0;
        	    } // if

        	    // if text is too long it must be truncated
        	    $str_width = $this->GetStringWidth($text);
        	    while ($str_width > $cell_width-1) {
            		$text = substr($text, 0, strlen($text) -1);
            		$str_width = $this->GetStringWidth($text);
            	} // while

                $this->Cell($cell_width, $line_height, $text, $border, 0, $this->text_align, 1);

                if (isset($attributes['marginright'])) {
        		    // increase X coordinate to include this margin
        		    $X = $this->getX() + $attributes['marginright'];
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
        $max_lines = 1;
        $image_height = 0;
        $this->last_height = 0;

        // calculate number of lines required for each cell in this row
        foreach ($print_array as $cellno => $celldata) {
        	$celldata = $this->getLineCount($celldata);
        	$print_array[$cellno] = $celldata;  // required for PHP4
        	if (isset($celldata['imageheight'])) {
        		if (!eregi('multi$', $function)) {
    	            // include image size in $line_count
        	    	$line_count = $celldata['imageheight'] / $this->last_height;
    	    	} else {
    	    	    // keep image size independent of $line_count
    	    	    $image_height = $celldata['imageheight'] / $this->last_height;
    	    	    $line_count = $celldata['imageheight'] / $this->last_height;
        	    } // if
        	} elseif (isset($celldata['barcode'])) {
        	    if (isset($celldata['height'])) {
        	        if (!eregi('multi$', $function)) {
        	            // include barcode size in $line_count
            	    	$line_count = $celldata['height'] / $this->last_height;
        	    	} else {
        	    	    // keep barcode size independent of $line_count
        	    	    $image_height = $celldata['height'] / $this->last_height;
            	    } // if
        	    } // if
        	} else {
        	    if (isset($celldata['line_array'])) {
        	    	$line_count = count($celldata['line_array']);
        	    } else {
        	        $line_count = 0;
        	    } // if
        	} // if
        	if ($line_count > $max_lines) {
        		$max_lines = $line_count;
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
        $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
        if ($max_lines > $lines_left OR $image_height > $lines_left) {
            if ($max_lines < 3) {
                $this->AddPage();  // start a new page
            } // if
        } // if

        for ($i = 0; $i < $max_lines; $i++) {
            $lines_left = ($this->PageBreakTrigger - $this->getY()) / $this->last_height;
            if ($lines_left < 1) {
                $this->AddPage();
            } // if
            if ($this->new_page_fill == true) {
            	$fill = 0;
            	$this->new_page_fill = false;
            } // if
            if ($i+1 > $max_lines) {
            	// this is the last line, but what is its depth?
            	$height_diff = $max_lines - $i;
            } else {
                $height_diff = 0;
            } // if
            // print one line from each cell before advancing to next line
            foreach ($print_array as $cellno => $celldata) {
                $this->printCell($celldata, $i, $max_lines-1, $border, $fill, $height_diff);
            } // foreach
            if ($height_diff <> 0) {
            	$this->last_height = $this->last_height * $height_diff;
            } // if
            $this->Ln($this->last_height);  // line break
            $this->new_page = false;
        } // for

        return;

    } // printRow

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
    function setPrintStyle ($style)
    // set print style (font, colours, etc)
    {
        if (!array_key_exists($style, $this->style)) {
            $style = 'default';
        } // if

        if (isset($this->style[$style]['font']['family'])) {
        	// set font and colours
            $this->SetFont($this->style[$style]['font']['family'], $this->style[$style]['font']['style'], $this->style[$style]['font']['size']);
        } else {
            if (isset($this->style[$style]['font']['size'])) {
            	$this->SetFontSize($this->style[$style]['font']['size']);
            } // if
        } // if

        if (isset($this->style[$style]['fillcolour'])) {
        	$this->SetFillColor($this->style[$style]['fillcolour'][0], $this->style[$style]['fillcolour'][1], $this->style[$style]['fillcolour'][2]);
        } // if
        if (isset($this->style[$style]['textcolour'])) {
        	$this->SetTextColor($this->style[$style]['textcolour'][0], $this->style[$style]['textcolour'][1], $this->style[$style]['textcolour'][2]);
        } // if
        if (isset($this->style[$style]['drawcolour'])) {
        	$this->SetDrawColor($this->style[$style]['drawcolour'][0], $this->style[$style]['drawcolour'][1], $this->style[$style]['drawcolour'][2]);
        } // if

        if (isset($this->style[$style]['font']['height'])) {
        	// set line height for cells which use this font
            $height = $this->style[$style]['font']['height'];
            //$this->last_height = $height;
        } else {
            $height = $this->last_height;
        } // if

        if (isset($this->style[$style]['font']['align'])) {
        	// set alignment for text within current cell
            $this->text_align = strtoupper(substr($this->style[$style]['font']['align'],0 ,1));
        } else {
            $this->text_align = '';
        } // if

        if (isset($this->style[$style]['font']['draw'])) {
        	// set width for line drawing
            $this->SetLineWidth($this->style[$style]['font']['draw']);
        } // if

        return $height;

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
        	$this->destination = $structure['pdf']['destination'];
        } else {
            $this->destination = 'I';
        } // if

        if (isset($structure['main']['line']['width'])) {
            $this->line_width = $structure['main']['line']['width'];
        } else {
        	$this->line_width = .2;
        } // if

        $this->structure = $structure;
        $this->units     = $units;

        // load default style
        $this->style['default']['font'] = array('family' => 'Helvetica',    // Courier, Helvetica, Times
                                                'style' => '',          // blank=Regular, B=Bold, I=Italic, U=Underline
                                                'size' => 11,           // size in points
                                                'height' => 5,          // line height
                                                'draw' => .2,           // width of drawn lines
                                                'align' => 'left');     // text alignment

        $this->style['default']['fillcolour'] = array(255,255,255);     // colour for background
        $this->style['default']['textcolour'] = array(0,0,0);           // colour for foreground
        $this->style['default']['drawcolour'] = array(0,0,0);           // colour for line drawing

        // now call constructor in parent class
        if (version_compare(phpversion(), '5.0.0', '<')) {
            parent::TCPDF($orientation, $units, $format);
        } else {
            // PHP 5 uses different code
            parent::__construct($orientation, $units, $format);
        } // if

        $this->printable_width = $this->w - ($this->lMargin + $this->rMargin);

        return;

    } // validateStructure

// ****************************************************************************
} // end class
// ****************************************************************************

?>
