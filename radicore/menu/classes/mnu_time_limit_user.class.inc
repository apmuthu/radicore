<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_time_limit_user extends Default_Table
{
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'menu';
        $this->tablename   = 'mnu_time_limit_user';

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
            // do not display these as checkboxes (see _cm_formatData() method to see values changed)
            $dow[] = 'scheduled_monday';
            $dow[] = 'scheduled_tuesday';
            $dow[] = 'scheduled_wednesday';
            $dow[] = 'scheduled_thursday';
            $dow[] = 'scheduled_friday';
            $dow[] = 'scheduled_saturday';
            $dow[] = 'scheduled_sunday';
            foreach ($dow as $day) {
                unset($this->fieldspec[$day]['control']);
                $this->fieldspec[$day]['type'] = 'string';
            } // foreach
            // replace screen labels with correct language
            $day_names = getLanguageArray('day_names_short');
            $replace['scheduled_monday']    = $day_names['mon'];
            $replace['scheduled_tuesday']   = $day_names['tue'];
            $replace['scheduled_wednesday'] = $day_names['wed'];
            $replace['scheduled_thursday']  = $day_names['thu'];
            $replace['scheduled_friday']    = $day_names['fri'];
            $replace['scheduled_saturday']  = $day_names['sat'];
            $replace['scheduled_sunday']    = $day_names['sun'];
            $result = replaceScreenHeadings($replace);
        } else {
            // replace screen labels with correct language
            $day_names = getLanguageArray('day_names_long');
            $this->fieldspec['scheduled_monday']['label']    = $day_names['monday'];
            $this->fieldspec['scheduled_tuesday']['label']   = $day_names['tuesday'];
            $this->fieldspec['scheduled_wednesday']['label'] = $day_names['wednesday'];
            $this->fieldspec['scheduled_thursday']['label']  = $day_names['thursday'];
            $this->fieldspec['scheduled_friday']['label']    = $day_names['friday'];
            $this->fieldspec['scheduled_saturday']['label']  = $day_names['saturday'];
            $this->fieldspec['scheduled_sunday']['label']    = $day_names['sunday'];
        } // if

        if ($GLOBALS['mode'] == 'search') {
            // checkboxes become radio groups in search screens, so switch to vertical alignment
            $this->fieldspec['scheduled_monday']['align_hv']    = 'v';
            $this->fieldspec['scheduled_tuesday']['align_hv']   = 'v';
            $this->fieldspec['scheduled_wednesday']['align_hv'] = 'v';
            $this->fieldspec['scheduled_thursday']['align_hv']  = 'v';
            $this->fieldspec['scheduled_friday']['align_hv']    = 'v';
            $this->fieldspec['scheduled_saturday']['align_hv']  = 'v';
            $this->fieldspec['scheduled_sunday']['align_hv']    = 'v';
            // put text to the right of the radio button
            $this->fieldspec['scheduled_monday']['align_lr']    = 'r';
            $this->fieldspec['scheduled_tuesday']['align_lr']   = 'r';
            $this->fieldspec['scheduled_wednesday']['align_lr'] = 'r';
            $this->fieldspec['scheduled_thursday']['align_lr']  = 'r';
            $this->fieldspec['scheduled_friday']['align_lr']    = 'r';
            $this->fieldspec['scheduled_saturday']['align_lr']  = 'r';
            $this->fieldspec['scheduled_sunday']['align_lr']    = 'r';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if ($fieldarray['scheduled_start_time'] > $fieldarray['scheduled_end_time']) {
            // 'Start Time cannot be later than End Time';
            $this->errors['scheduled_start_time'] = getLanguageText('sys0218');
            // 'End Time cannot be earlier than Start Time';
            $this->errors['scheduled_end_time']   = getLanguageText('sys0219');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if ($GLOBALS['mode'] == 'list') {
            // do not display these as checkboxes
            $dow[] = 'scheduled_monday';
            $dow[] = 'scheduled_tuesday';
            $dow[] = 'scheduled_wednesday';
            $dow[] = 'scheduled_thursday';
            $dow[] = 'scheduled_friday';
            $dow[] = 'scheduled_saturday';
            $dow[] = 'scheduled_sunday';
            foreach ($dow as $day) {
                if (isset($fieldarray[$day])) {
                    if (is_True($fieldarray[$day])) {
                        $fieldarray[$day] = 'X';
                    } else {
                        $fieldarray[$day] = '-';
                    } // if
                } // if
            } // foreach
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set seq_no to next available number
        if (!empty($fieldarray['user_id'])) {
            $where = "user_id='{$fieldarray['user_id']}'";
            $query = "SELECT max(seq_no) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['seq_no'] = $count + 1;
            $this->retry_on_duplicate_key = 'seq_no';
        } // if

        return $fieldarray;

    } // _cm_getInitialData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
