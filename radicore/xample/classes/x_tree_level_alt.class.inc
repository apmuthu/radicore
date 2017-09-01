<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_tree_level_alt extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'xample';
        $this->tablename   = 'x_tree_level_alt';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('language_id', $this->lookup_data)) {
            // get options for language_code
            //$array = getLanguageArray('languages');
            $dbobject = RDCsingleton::getInstance('mnu_language');
            $array = $dbobject->getValRep('language_id');
            $array = array_change_key_case($array, CASE_LOWER);
            $this->lookup_data['language_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        	$selection = null;
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if (preg_match('/(add2)/i', $pattern_id)) {
            $where_array = where2array($where);
         	// remove fields included from $selection instead of $where
            if (isset($fieldarray['language_id'])) {
            	unset($fieldarray['language_id']);
            } // if
            $where = array2where($where_array);
        } // if

        return $where;

    } // _cm_initialise

// ****************************************************************************
} // end class
// ****************************************************************************

?>
