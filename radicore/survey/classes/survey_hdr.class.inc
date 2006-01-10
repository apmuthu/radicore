<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_hdr extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function survey_hdr ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'survey_hdr';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // survey_hdr

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get contents of foreign table SURVEY_TYPE and add as a LOOKUP list
        require_once 'survey_type.class.inc';
        $dbobject =& singleton::getInstance('survey_type');
        $data_array = $dbobject->getValRep('survey_type_id');
        $this->lookup_data['survey_type_id'] = $data_array;

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
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'survey_id') {
            // get data from the database
            $this->sql_select     = 'survey_id, survey_name';
            $this->sql_orderby    = 'survey_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            $array[''] = ' ';   // start with blank entry

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
