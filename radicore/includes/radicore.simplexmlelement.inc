<?php
// ****************************************************************************
// This is used to convert an array into an XML document.
// ****************************************************************************
// Author:          Tony Marston <tony@radicore.org>
// Version:         1.2
// Date created:    15th June 2013
// Date amended:    6th October 2013

class radicore_SimpleXMLElement extends SimpleXMLElement
{
    var $cdata_elements  = array();
    var $index_attribute = false;

    // ****************************************************************************
    function set_cdata_elements ($input)
    // this has to use a global as a class property will not work.
    {
        if (is_array($input)) {
            $GLOBALS['cdata_section_elements'] = $input;
        } else {
            $array = preg_split('/([ ]| ,)/', $input);
            $array = array_map('trim', $array);
            $GLOBALS['cdata_section_elements'] = $array;
        } // if
        return;
    } // set_cdata_section_elements

    // ****************************************************************************
    function set_index_attribute ($input)
    // flag to include 'index' attribute in _element_has_children() method.
    {
        $this->index_attribute = (boolean)$input;
        return;
    } // set_index_attribute

    // ****************************************************************************
    function addArray ($node, $array)
    // convert an array to XML and add to specified node
    {
        foreach ($array as $key => $value) {
            if (is_numeric($key)) {
                $index = $key;                          // save index number
                $key = 'index';                         // change number to 'index'
            } else {
                $index = null;                          // there is no index number
                $key = str_replace(' ', '__', $key);    // changes spaces to underscores
            } // if
            if ($key == '@attributes') {
                foreach ($value as $attr_name => $attr_value) {
                    $node->addAttribute($attr_name, $attr_value);
                } // if
            } else {
                if (empty($value)) {
                    // simple 'name=value'
                    $node->addChild($key, '');

                } elseif (is_array($value)) {
                    if ($this->all_numeric_keys($value)) {
                        // indexed array, so this is a repeated element
                        $node = $this->_element_is_repeated($node, $key, $value);

                    } elseif ($this->is_simple_element_with_attributes($value)) {
                        // element has attributes and a string value
                        $node = $this->_element_has_text ($node, $key, $value);

                    } else {
                        // element has one or more child elements
                        $node = $this->_element_has_children ($node, $key, $value, $index);

                    } // if

                } else {
                    // simple 'name=value'
                    //$node->addChild($key, $value);
                    $this->addChildText($node, $key, $value);
                } // if
            } // if
        } // foreach

        unset($this->index_attribute);
        unset($this->$cdata_elements);

        return $node;
    } // addArray

    // ************************************************************************
    function addChildText($xml, $name, $text)
    // create a child node and add text or CDATA text to it.
    {
        $cdata_elements =& $GLOBALS['cdata_section_elements'];

        if (!empty($cdata_elements) AND is_array($cdata_elements) AND in_array($name, $cdata_elements)) {
            $child = $xml->addChild($name);
            $node = dom_import_simplexml($child);
            $no   = $node->ownerDocument;
            $node->appendChild($no->createCDATASection($text));
        } else {
            $child = $xml->addChild($name, htmlspecialchars($text, ENT_NOQUOTES | ENT_XHTML));
        } //if
        return $child;
    } // addChildText

    // ************************************************************************
    private function _element_is_repeated ($xml, $node_name, $array)
    // this $node element is repeated.
    {
        foreach ($array as $ix => $value) {
            if (is_array($value)) {
                if ($this->all_numeric_keys($value)) {
                    // indexed array, so this is a repeated element
                    $child = $xml->addChild($node_name);
                    $child = $this->_element_is_repeated($child, $node_name, $value);

                } elseif ($this->is_simple_element_with_attributes($value)) {
                    // element has attributes and a string value
                    $xml = $this->_element_has_text ($xml, $node_name, $value);

                } else {
                    // element has one or more child elements
                    if ($this->index_attribute == true) {
                        // include index number as an attribute
                        $xml = $this->_element_has_children ($xml, $node_name, $value, $ix);
                    } else {
                        $xml = $this->_element_has_children ($xml, $node_name, $value);
                    } // if

                } // if

            } else {
                //$child = $xml->addChild($node_name, $value);
                $child = $this->addChildText($xml, $node_name, $value);
            } // if
        } // foreach

        return $xml;

    } // _element_is_repeated

    // ************************************************************************
    private function _element_has_text ($xml, $node_name, $array)
    // element has attributes and a string value
    {
        if (array_key_exists('@attributes', $array)) {
            $attributes = $array['@attributes'];
            $text       = $array['@value'];
        } else {
            $attributes = array();
            $text       = $array;
        } // if

        //$child = $xml->addChild($node_name, $text);
        $child = $this->addChildText($xml, $node_name, $text);
        foreach ($array['@attributes'] as $attr_name => $attr_value) {
            $child->addAttribute($attr_name, $attr_value);
        } // foreach

        return $xml;

    } // _element_has_text

    // ************************************************************************
    private function _element_has_children ($xml, $node_name, $array, $index=null)
    // element has one or more children.
    // If $index is supplied then set this as an attribute with the name 'index'.
    {
        $child = $xml->addChild($node_name);
        if (is_numeric($index)) {
            $child->addAttribute('index', $index);
        } // if
        if (array_key_exists('@attributes', $array)) {
            foreach ($array['@attributes'] as $attr_name => $attr_value) {
                $child->addAttribute($attr_name, $attr_value);
            } // foreach
            unset($array['@attributes']);
        } // if

        foreach ($array as $key2 => $value2) {
            $index = null;
            if (is_numeric($key2)) {
                if (!is_array($value2)) {
                    // numeric names are invalid, so change it to a string
                    $value2 = array('@value' => $value2);
                    $value2['@attributes']['index'] = $key2;  // make the numeric key into an attribute
                    $key2 = 'entry';
                } // if
            } // if
            if (is_array($value2)) {
                if ($this->all_numeric_keys($value2)) {
                    // indexed array, so this is a repeated element
                    $child = $this->_element_is_repeated($child, $key2, $value2, $index);

                } elseif ($this->is_simple_element_with_attributes($value2)) {
                    // element has attributes and a string value
                    $child = $this->_element_has_text ($child, $key2, $value2);

                } else {
                    // element has one or more child elements
                    $child = $this->_element_has_children ($child, $key2, $value2);

                } // if

            } else {
                //$child2 = $child->addChild($key2, $value2);
                $child2 = $this->addChildText($child, $key2, $value2, $index);
            } // if
        } // foreach

        return $xml;

    } // _element_has_children

    // ************************************************************************
    function all_numeric_keys($array)
    // Check if all keys of an array are numeric
    {
        foreach ($array as $key => $value) {
            if (!is_numeric($key)) {
                return false;
            } // if
        } // foreach
        return true;
    } // all_numeric_keys

    // ************************************************************************
    function is_simple_element_with_attributes ($array)
    // look for the following in $array:
    // '$attributes' = array(...)
    // '@value' = string or number
    {
        $keys = array_keys($array);
        if (count($keys) == 2) {
            if (in_array('@attributes', $keys)) {
                if (array_key_exists('@value', $array)) {
                    return true;
                } // if
            } // if
        } // if
        return false;
    } // is_simple_element_with_attributes

} // class: radicore_SimpleXMLElement

?>