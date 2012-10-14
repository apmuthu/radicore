<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2012 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_language extends Default_Table
{
    // ****************************************************************************
    function mnu_language ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_language';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_language

    // ****************************************************************************
    function getFieldSpec_original ()
    // set the specifications for this database table.
    {
        $fieldspec = parent::getFieldSpec_original();

        foreach ($this->child_relations as $index => $relation) {
        	if (isset($relation['subsys_dir'])) {
                $classname = '../'. $relation['subsys_dir'] .'/classes/' .$relation['child'] .'.class.inc';
                if (!file_exists($classname)) {
                    // does not exist in this installation, so remove this reference
                	unset($this->child_relations[$index]);
                } // if
        	} // if
        } // foreach

        return $fieldspec;

    } // getFieldSpec_original

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'insert') {
            $this->fieldspec['language_name']['nodisplay'] = 'y';
        } else {
            // do not use dropdown if not in INSERT screen
        	unset($this->fieldspec['language_id']['control']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('language_id', $this->lookup_data)) {
            // get options for language_code
            $array = getLanguageArray('languages');
            $this->lookup_data['language_id'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'language_id') {
            // get data from the database
            $this->sql_select     = 'language_id, language_name';
            $this->sql_orderby    = 'language_id';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        //if (empty($rowdata['language_name'])) {
            // default value is description from lookup array
            $rowdata['language_name'] = $this->lookup_data['language_id'][$rowdata['language_id']];
        //} // if

        return $rowdata;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
