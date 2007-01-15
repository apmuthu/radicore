<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require 'std.pdf.class.inc';
class PDF_list extends PDF
{
    // ****************************************************************************
    // this subclass contains additional processing for the LIST view
    // ****************************************************************************
    function Header ()
    // print a line of column headings across the page
    {
        $this->new_page = true;  // indicate that a new page has started

        if (!is_True($this->print_header)) {
        	return;  // do not print a page header
        } // if

        if (isset($this->structure['title'])) {
            // this code is in the parent class
            parent::header();
        } // if

        $this->setY($this->getY()+1);  // leave a gap under the title

        // set print style for heading
        if (!isset($this->structure['head']['style'])) {
            $this->structure['head']['style'] = 'default';
        } // if
        $height = $this->setPrintStyle($this->structure['head']['style']);

        $this->total_width = 0;

        $print_array = array();
        foreach ($this->structure['body']['fields'] as $column => $columndata) {
            $columndata = array_change_key_case($columndata, CASE_LOWER);
            $fieldname  = key($columndata);
            $fieldlabel = $columndata[$fieldname];

            $cellspec = array();
            $cellspec['default_style'] = $this->structure['head']['style'];

            if (isset($this->structure['columns'][$column]['width'])) {
            	$cellspec['width'] = $this->structure['columns'][$column]['width'];
            } else {
                // default is width divided by number of columns
                $cellspec['width'] = $this->printable_width / count($this->structure['body']['fields']);
            } // if
            $this->total_width = $this->total_width + $cellspec['width'];

//            if (isset($this->structure['columns'][$column]['align'])) {
//            	$cellspec['align'] = $this->structure['columns'][$column]['align'];
//            } // if

            $cellspec['text'] = getLanguageText($fieldlabel);

            $print_array[] = $cellspec;

        } // foreach

        $result = $this->printRow($print_array, 1, 1);  // print this row

        return;

    } // Header

// ****************************************************************************
} // end class
// ****************************************************************************

?>