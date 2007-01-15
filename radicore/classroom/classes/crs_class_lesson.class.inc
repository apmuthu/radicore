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
        $object =& singleton::getInstance('crs_class');
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
} // end class
// ****************************************************************************

?>
