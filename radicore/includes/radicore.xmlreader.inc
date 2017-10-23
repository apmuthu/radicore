<?php
// ****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// ****************************************************************************
// This is used to convert an XML document into an array.
// ****************************************************************************
// Author:          Tony Marston <tony@radicore.org>
// Version:         1.2
// Date created:    15th June 2013
// Date amended:    6th October 2013

class radicore_XMLReader extends XMLReader
// @usage
//
//
//
// (1) - one element at a time
//      $xml = new ajm_XMLReader();
//      $xml->xml($input);
//      do {
//          // extract data for one product at a time
//          $product = $xml->xml_to_array('Product');
//          ... process product
//      } while (!empty($product));
//
// (2) - everything at once
//      $xml = new ajm_XMLReader();
//      $xml->xml($input);
//      $everything = $xml->xml_to_array();
//
{
    var $hasChildren;

    // ************************************************************************
    function read ()
    // ovverride standard method to provide 'hasChildren' property.
    {
        $result = @parent::read();
        $this->hasChildren = $this->hasChildren();
        return $result;
    } // read
    // ************************************************************************
    function hasChildren ($innerXML=null)
    // examine results of $this->innerXML() to see if it has children.
    {
        if (empty($innerXML)) {
            $innerXML = $this->readInnerXML();
        } // if
        if (!empty($innerXML)) {
            $cdata_offset = strlen($innerXML);  // default value is end of string
            if (preg_match('/<!\[CDATA\[.*\]\]>/i', $innerXML, $regs, PREG_OFFSET_CAPTURE)) {
                $cdata_offset = $regs[0][1];
            } // if
            if (preg_match('/<.*>/m', $innerXML, $regs, PREG_OFFSET_CAPTURE)) {
                $tag_offset = $regs[0][1];
                if ($tag_offset < $cdata_offset) {
                    return TRUE;  // XML tag found before a CDATA tag, so this has child elements
                } // if
            } // if
        } // if
        return FALSE;
    } // hasChildren

    // ****************************************************************************
    function xml_to_array ($node='*', $start_child=false)
    // read XML document and output data as an array.
    // $node = string identifying single node to be extracted (eg: 'Product').
    // $start_child = TRUE/FALSE
    {
        if ($node == '*' OR $start_child === true) {
            $array = array();   // start extracting now
        } else {
            $array = null;      // do not start until $node is found
        } // if

        $last_localName = null;
        $last_nodeType  = null;
        while ($this->read()) {
            $localName = $this->localName;
            $nodeType  = $this->nodeType;
            if ($this->nodeType == XMLREADER::ELEMENT) {
                // start element
                $last_localName = $localName;
                $last_nodeType  = 'start';
                if (!is_array($array)) {
                    // have not reached the right element yet
                    if ($this->localName == $node) {
                        $array = array();  // now we have
                    } // if
                } else {
                    if ($this->hasChildren) {
                        $node_value = $this->xml_to_array($localName, true);
                    } else {
                        $node_value = $this->readString();
                    } // if
                    if ($this->hasAttributes) {
                        // attributes are put into an array with the key '@attributes'
                        $attributes = array();
                        while($this->moveToNextAttribute()) {
                            $attributes[$this->name] = $this->value;
                        } // while
                        if (is_array($node_value)) {
                            // node has child elements
                            $new = array('@attributes' => $attributes);
                            $new = array_merge($new, $node_value);
                        } else {
                            // node has a simple value
                            $new = array('@attributes' => $attributes,
                                         '@value' => $node_value);
                        } // if
                        $node_value = $new;
                    } // if
                    if (array_key_exists($localName, $array)) {
                        if (is_array($array[$localName]) AND is_long(key($array[$localName]))) {
                            // array is already indexed
                            $array[$localName][] = $node_value;
                        } else {
                            // this is a 2nd element with the same name, so change array from associative to indexed
                            $new = array(0 => $array[$localName]);  // replace first element at index zero
                            unset($array[$localName]);
                            $array[$localName] = $new;
                            $array[$localName][] = $node_value;     // insert new element
                        } // if
                    } else {
                        $array[$localName] = $node_value;
                        //$last_nodeType = 'end';
                    } // if
                    $here = true;
                } // if

            } elseif ($this->nodeType == XMLREADER::END_ELEMENT) {
                if ($this->localName == $last_localName AND $last_nodeType == 'start') {
                    $last_nodeType  = 'end';  // end of current element, so stay and look for another
                    $last_localName = '';
                } else {
                    break;  // end of children for this node, so stop here
                } //if
            } // if
        } // while

        return $array;

    } // xml_to_array
    // ************************************************************************
} // class: radicore_XMLReader

?>