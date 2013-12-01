<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2013 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s06 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person(multi5).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // all fields in this zone are 'noedit'
        $this->xsl_params['inner_noedit'] = 'y';

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // customisable code goes here
        if (!empty($fieldarray['star_sign'])) {
            $where_array['star_sign'] = $fieldarray['star_sign'];
        } // if
        if (!empty($fieldarray['pers_type_id'])) {
            $where_array['pers_type_id'] = $fieldarray['pers_type_id'];
        } // if
        $where = array2where($where_array);
        $where1 = array2where($where_array, null, $this);
        $where2 = array2where($where_array, null, null, true);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
