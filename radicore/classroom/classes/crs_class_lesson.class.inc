<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_class_lesson extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_class_lesson ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_class_lesson';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_class_lesson

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        // convert 'class=X' into 'year=Y'
        $object =& RDCsingleton::getInstance('crs_class');
        $object->sql_select = 'year';
        $data = $object->getData_raw($where);
        if (isset($data[0]['year']) and $data[0]['year'] > 0) {
            $where = "year=" .$data[0]['year'];
        } else {
            $where = '';
        } // if

        $settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

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
            // add extra fields to select list
            $this->sql_select .= ', crs_class.year';
            // get count of students in this class
            $this->sql_select .= ", (SELECT COUNT(student_id) FROM crs_student WHERE crs_student.class_id=crs_class_lesson.class_id ) AS student_count";
            // get count of lessons for this class
            $this->sql_select .= ", (SELECT COUNT(lesson_id) FROM crs_class_lesson WHERE crs_class_lesson.class_id=crs_class_lesson.class_id ) AS lesson_count";
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
