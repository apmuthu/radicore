<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_pattern extends Default_Table
{
    var $count;         // total count in PDF report

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_pattern ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_pattern';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_pattern

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=nul)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'pattern_id') {
            // get data from the database
            $this->sql_select     = 'pattern_id, pattern_desc';
            $this->sql_orderby    = 'pattern_desc';
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
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['pattern_desc'] = 'Total count for all Patterns:';
        $array['count'] = $this->count;

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        if ($GLOBALS['mode'] == 'pdf-list') {
            // accumulate totals for PDF report
            $this->count += $fieldarray['count'];
        } // if

        return $fieldarray;

    } // _cm_post_fetchRow

// ****************************************************************************
} // end class
// ****************************************************************************

?>
