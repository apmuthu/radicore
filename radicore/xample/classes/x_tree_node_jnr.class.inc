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
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(output6)/i', $pattern_id)) {
            if (!empty($selection)) {
                $where     = $selection;    // use $selection instead of $where
                $selection = null;          // no longer required
            } // if
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
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
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_from)) {
            $this->sql_select  = '1 AS level, x_tree_node.node_id, x_tree_node.node_desc, x_tree_level.tree_level_seq, COUNT(child.node_id) AS child_count';
            $this->sql_from    = 'x_tree_node '
                               . 'LEFT JOIN x_tree_level ON (x_tree_level.tree_type_id=x_tree_node.tree_type_id AND x_tree_level.tree_level_id=x_tree_node.tree_level_id) '
                               . 'LEFT JOIN x_tree_node AS child ON (x_tree_node.node_id=child.node_id_snr) ';
            $this->sql_where   = '';
            $this->sql_groupby = 'x_tree_node.node_id, x_tree_node.node_desc, x_tree_node.tree_level_id, x_tree_level.tree_level_seq';
            $this->sql_having  = '';
            $this->sql_orderby = 'x_tree_node.tree_level_id, x_tree_node.node_id';

            if (!empty($this->alt_language_table)) {
                if ($_SESSION['user_language'] != $_SESSION['default_language']) {
                    // link to table which provides text in an alternative language
                    $pkey_array = array();
                    foreach ($this->primary_key as $fieldname) {
                        $pkey_array[$fieldname] = $fieldname;
                    } // foreach
                    $new_relation = array('parent' => $this->alt_language_table,
                                          'parent_field' => $this->alt_language_cols,
                                          'fields' => $pkey_array);
                    $new_relation['this'] = 'x_tree_node';
                    $this->sql_select = $this->_sqlSelectAlternateLanguage($this->sql_select, $new_relation);
                } // if
            } // if

            if (array_key_exists('tree_type_id', $where_array)) {
                // look for nodes at the first level
                $where_array['tree_level_seq'] = 1;
                $where = array2where($where_array);
            } // if
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_getNodeKeys ($keys)
    // identify the field names for the SENIOR to JUNIOR relationship
    {
        $keys['snr_id'] = 'node_id_snr';
        $keys['jnr_id'] = 'node_id';

        return $keys;

    } // _cm_getNodeKeys

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
