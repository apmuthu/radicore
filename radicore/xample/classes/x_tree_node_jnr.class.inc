<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_tree_node.class.inc';
class x_tree_node_jnr extends x_tree_node
{
    // ****************************************************************************
    function _cm_deleteSelection ($selection)
    // delete/update a selection of records.
    {
        // $where must contain at least one occurrence of 'node_id='
        if (substr_count($selection, 'node_id=') < 1) {
            // 'Nothing has been selected yet'
            return getlanguageText('sys0081');
        } // if

        // delete relationships by setting NODE_ID_SNR to NULL on selected records.
        $count = $this->_dml_updateSelection($selection, 'node_id_snr=NULL');

        // "$count rows were updated"
        return getLanguageText('sys0006', $count, $this->tablename);

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        // do NOT clear out the contents of $where
        //$where = '';

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        $settings['select_one'] = false;

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple records in a single operation
    {
        //DebugBreak();
        $replace = str_replace('node_id=', 'node_id_snr=', $replace);

        $count = $this->_dml_updateSelection($selection, $replace);

        // "$count rows were updated"
        return getLanguageText('sys0006', $count, $this->tablename);

    } // _cm_updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
