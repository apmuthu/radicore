<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_subsystem extends Default_Table
{
    var $count;         // record count for PDF output

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_subsystem ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_subsystem';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_subsystem

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (strpos($fieldarray['subsys_dir'], '/') or strpos($fieldarray['subsys_dir'], '\\')) {
            // only a single directory name is required
            $this->errors['subsys_dir'] = getLanguageText('e0034');
        } // if

//        if (!is_dir('../' .$fieldarray['subsys_dir'])) {
//            // Directory name does not exist
//            $this->errors['subsys_dir'] = getLanguageText('e0035');
//        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
//        if ($fieldarray['count'] <= 50) {
//            $css_array['count'] = 'red';
//            $css_array['subsys_desc'] = 'red';
//        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'subsys_id') {
            // get data from the database
            $this->sql_select     = 'subsys_id, subsys_desc';
            $this->sql_orderby    = 'subsys_desc';
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
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        $array['subsys_desc'] = 'Total count for all Subsystems:';
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
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {
        // no logging for this 'erase'
        $this->audit_logging = false;

        return $fieldarray;

    } // _cm_pre_eraseRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
