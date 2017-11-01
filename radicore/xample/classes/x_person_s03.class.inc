<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s03 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_upd(js).php
    // it demonstrates the inclusion of javascript from the fckeditor library
    // ****************************************************************************

    // ****************************************************************************
    function _cm_setJavaScript ($javascript)
    // insert any javascript to be included in the <HEAD> or <BODY> elements.
    {
        global $mode;

        // specify external js files to be loaded
        //$path = 'javascript/FCKeditor/';
        //$javascript['head'][]['file'] = $path .'fckeditor.js';
        $path = 'javascript/ckeditor/';
        $javascript['head'][]['file'] = $path .'ckeditor.js';

        $code = <<< EOD
CKEDITOR.replace( 'fckeditor_test',
{
    toolbar : 'Basic',
    uiColor : '#9AB8F3'
});
EOD;

        $option = 2;

        if ($option == 1) {

            $this->fieldspec['fckeditor_test']['javascript'] = array('javascript' => "$code");

        } else {

            $javascript['head'][]['code'] = 'window.onload = function()'
                                           ."\n{\n"
                                           .$code
                                           ."\n}\n";

        } // if

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
