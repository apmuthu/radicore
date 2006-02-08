<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_pers_opt_xref extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function x_pers_opt_xref ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'x_pers_opt_xref';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // x_pers_opt_xref

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if (eregi('star_sign', $this->sql_select)) {
            // add star_sign to field list
            $this->fieldspec['star_sign']   = array('type' => 'string',
                                                    'noedit' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'star_sign',
                                                    'nondb' => 'y');
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if (eregi('star_sign', $this->sql_select)) {
            // get lookup list for star_sign
            require_once 'x_person.class.inc';
            $dbobject =& singleton::getInstance('x_person');
            $data = $dbobject->getValRep('star_sign');
            $this->lookup_data['star_sign'] = $data;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        // the default is to clear out the contents of $where
        $where = '';

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

//        // ensure that only one entry can be selected
//        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

// ****************************************************************************
} // end class
// ****************************************************************************

?>
