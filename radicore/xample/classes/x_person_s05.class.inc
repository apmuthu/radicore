<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s05 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_upd(js).php
    // it demonstrates the inclusion of javascript from the tiny-mce library
    // ****************************************************************************

    // ****************************************************************************
    function _cm_setJavaScript ($javascript)
    // insert any javascript to be included in the <HEAD> or <BODY> elements.
    {
        global $mode;

        // specify external js files to be loaded
        $javascript['head'][]['file'] = 'javascript/tiny_mce/tinymce.min.js';
        $javascript['head'][]['code'] = 'tinyMCE.init({
        selector: "textarea",
        theme : "modern",
        relative_urls: true,
        plugins: [
        "advlist autolink lists link image charmap preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern imagetools"
        ],
        toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link imagepreview | forecolor backcolor emoticons",
        image_advtab: true
});';

        return $javascript;

    } // _cm_setJavaScript

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // this is deliberately empty

        return $fieldarray;

    } // _cm_getExtraData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
