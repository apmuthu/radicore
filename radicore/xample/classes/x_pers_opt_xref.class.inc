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
        if (eregi('star_sign', $this->sql_select)) {
            if (!array_key_exists('star_sign', $this->lookup_data)) {
                // get lookup list for star_sign
                $dbobject =& singleton::getInstance('x_person');
                $data = $dbobject->getValRep('star_sign');
                $this->lookup_data['star_sign'] = $data;
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        // clear out the contents of $where
        $where = '';

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        $settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_updateLinkdata ($rows, $postarray)
    // perform custom processing after multiple database records have been updated.
    {
        // get record count for the workflow test
        $person_id = addslashes($rows[0]['person_id']);
        $count = $this->getCount("person_id='$person_id'");
        $rows['count'] = $count;

        return $rows;

    } // _cm_post_updateLinkData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
