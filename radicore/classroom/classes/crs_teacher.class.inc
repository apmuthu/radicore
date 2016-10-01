<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_teacher extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'crs_teacher';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        $method = getEntryPoint($this);
        if (strtolower($method) == 'getdata') {
            if (!isset($fieldarray['teacher_name'])) {
                $fieldarray['teacher_name'] = $fieldarray['title']
                                        .' ' .$fieldarray['first_name']
                                        .' ' .$fieldarray['initials']
                                        .' ' .$fieldarray['last_name'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('title', $this->lookup_data)) {
            // get array for task_type and put into LOOKUP_DATA
            $array = $this->getValRep('title');
            $this->lookup_data['title'] = $array;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set id to next available number
        $count = $this->getCount("SELECT max(teacher_id) FROM $this->tablename");
        $fieldarray['teacher_id'] = $count + 1;

        $this->fieldspec['teacher_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        // provide values for dropdown list

        if (strtolower($item) == 'title') {
//            $array['Mr']   = 'Mr';
//            $array['Mrs']  = 'Mrs';
//            $array['Ms']   = 'Ms';
//            $array['Miss'] = 'Miss';
//            $array['Dr']   = 'Doctor';
//            $array['Prof'] = 'Professor';
//            $array['Rev']  = 'Reverend';
            $array = getLanguageArray('title');
            return $array;
        } // if

        if (strtolower($item) == 'teacher_id') {
            // get data from the database
            $this->sql_select     = 'teacher_id, title, first_name, initials, last_name';
            $this->sql_orderby    = 'last_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = "$rowvalues[1] $rowvalues[2] $rowvalues[3] $rowvalues[4]";
            } // foreach

            return $array;
        } // if

        return array();

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
        	$this->sql_select = "*, CONCAT(title, ' ', first_name, ' ', last_name) as teacher_name ";
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
