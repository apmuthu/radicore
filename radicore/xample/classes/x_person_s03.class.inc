<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s03 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_upd(js).php
    // it demonstrates the inclusion of javascript capabilties
    // ****************************************************************************

    // ****************************************************************************
    function _cm_setJavaScript ($javascript)
    // insert any javascript to be included in the <HEAD> or <BODY> elements.
    {
        global $mode;

        // specify external js files to be loaded
        //$javascript['head'][]['file'] = 'javascript/usableforms.js';
        $javascript['head'][]['file'] = 'javascript/FCKeditor/fckeditor.js';
        $javascript['head'][]['code'] = 'document.write();';

        $option = 1;

        if ($option == 1) {

            $code = "
            var oFCKeditor = new FCKeditor( 'fckeditor_test' ) ;
            oFCKeditor.BasePath = 'javascript/FCKeditor/' ;
            oFCKeditor.Height = 300 ;
            oFCKeditor.Value	= 'this is the iniial value' ;
            oFCKeditor.Create() ;
            ";

            $this->fieldspec['fckeditor_test']['javascript'] = array('javascript' => "$code",
                                                                     'hidecontrol' => 'y');
        } else {

            $code = "
            var oFCKeditor = new FCKeditor( 'fckeditor_test' ) ;
            oFCKeditor.BasePath = '/javascript/FCKeditor/' ;
            oFCKeditor.Height = 300 ;
            oFCKeditor.ReplaceTextarea() ;
            ";

            $this->fieldspec['fckeditor_test']['javascript'] = array('javascript' => "$code");

        } // if

        // specify scripting events on <body> tag
        //$javascript['body']['onload'] = 'prepareForm()';
        //$javascript['body']['onunload'] = 'finish()';

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
