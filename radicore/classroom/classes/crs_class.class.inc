<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_class extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_class ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_class';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_class

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'class_id') {
            // get data from the database
            $this->sql_select     = 'class_id, class_name';
            $this->sql_orderby    = 'class_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = "$rowvalues[1]";
            } // foreach

            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_select  = null;
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
            // get count of students in this class
            $this->sql_select .= ", (SELECT COUNT(student_id) FROM crs_student WHERE crs_student.class_id=crs_class.class_id ) AS student_count";
            // get count of lessons for this class
            $this->sql_select .= ", (SELECT COUNT(lesson_id) FROM crs_class_lesson WHERE crs_class_lesson.class_id=crs_class.class_id ) AS lesson_count";
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
