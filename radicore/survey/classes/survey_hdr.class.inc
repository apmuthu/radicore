<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_hdr extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'survey';
        $this->tablename   = 'survey_hdr';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'list') {
            // display as plain text, not a multi-line box
        	unset($this->fieldspec['survey_long_name']['control']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('survey_type_id', $this->lookup_data)) {
            // get contents of foreign table SURVEY_TYPE and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('survey_type');
            $data_array = $dbobject->getValRep('survey_type_id');
            $this->lookup_data['survey_type_id'] = $data_array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set survey_id to next available number
        $count = $this->getCount("SELECT max(survey_id) FROM $this->tablename");
        $fieldarray['survey_id'] = $count + 1;

        $this->fieldspec['survey_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'survey_id') {
            // get data from the database
            $this->sql_select     = 'survey_id, survey_name';
            $this->sql_orderby    = 'survey_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

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
} // end class
// ****************************************************************************

?>
