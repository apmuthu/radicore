<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_nav_button extends Default_Table
{

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'mnu_nav_button';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function getNavButtons ($task_id, $object)
    // retrieve any navigation buttons for the current script.
    {
        $this->errors = array();

        // MNU_NAV_BUTTON contains a list of task_id's which can be loaded into
        // the current screen's navigation bar.

        // first we must obtain the user's current security setting
        $dbrole = RDCsingleton::getInstance('mnu_role');
        $dbrole_data = $dbrole->getRole();
        if ($dbrole->errors) {
        	$this->errors = $dbrole->errors;
        	return FALSE;
        } // if

        $role_id       = $dbrole_data['role_id'];
        $role_list     = $dbrole_data['role_list'];
        $global_access = $dbrole_data['global_access'];

        $having_array = array();

        if (is_True($global_access)) {
            // if global_access is ON then all buttons can be accessed without restriction
            // (unless a task has been disabled)
            $this->sql_select = 'x.task_id, x.task_name, x.script_id, x.pattern_id, x.is_disabled, mnu_nav_button.button_text, mnu_nav_button.context_preselect';
            $this->sql_from   = 'mnu_nav_button '
                              . 'LEFT JOIN mnu_task ON (mnu_task.task_id = mnu_nav_button.task_id_snr) '
                              . 'LEFT JOIN mnu_task AS x ON (x.task_id = mnu_nav_button.task_id_jnr) ';
            //$where = "x.is_disabled='N'";
            $having_array['x.is_disabled'] = 'N';
        } else {
            // if global_access is OFF then a button cannot be loaded unless it has an
            // entry on MNU_ROLE_TASK for the current role
            // (or if it has been disabled)
            $this->sql_select = 'x.task_id, x.task_name, x.script_id, x.pattern_id, x.is_disabled, mnu_nav_button.button_text, mnu_nav_button.context_preselect'
                              .", CASE WHEN EXISTS(SELECT 1 FROM mnu_role_task WHERE task_id=mnu_nav_button.task_id_jnr AND role_id IN($role_list) ) THEN 'Y' ELSE 'N' END AS access_allowed";
            $this->sql_from   = 'mnu_nav_button'
                              .' LEFT JOIN mnu_task ON (mnu_task.task_id = mnu_nav_button.task_id_snr) '
                              .' LEFT JOIN mnu_task AS x ON (x.task_id = mnu_nav_button.task_id_jnr) ';
            //$where = "x.is_disabled='N'";
            $having_array['x.is_disabled'] = 'N';
            $having_array['access_allowed'] = 'Y';
        } // if

        if (!empty($_SESSION['empty_tables']) AND array_key_exists('mnu_task_ip_address', $_SESSION['empty_tables'])) {
            // table is empty, so no lookup is required
        } else {
            // lookup on MNU_TASK_IP_ADDRESS to see if this IP address is valid
            $ip_address = getRealIPAddress();
            $this->sql_select .= ", CASE WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE mnu_task_ip_address.task_id=mnu_nav_button.task_id_jnr) = 0 THEN 'Y'"
                                      ." WHEN (SELECT count(ip_address) FROM mnu_task_ip_address WHERE mnu_task_ip_address.task_id=mnu_nav_button.task_id_jnr AND ip_address='$ip_address') = 1 THEN 'Y'"
                                      ." ELSE 'N'"
                                 ." END AS ip_address_valid";
            $having_array['ip_address_valid'] = 'Y';
        } // if

        if ($_SESSION['user_language'] != $_SESSION['default_language']) {
            // obtain some text in an alternative language
            $this->sql_select .= ", COALESCE((SELECT task_name FROM mnu_task_alt WHERE mnu_task_alt.task_id=mnu_nav_button.task_id_jnr AND mnu_task_alt.language_id='{$_SESSION['user_language']}'), x.task_name) AS task_name";
            // extract all elements within current SELECT clause into an associative array
            $select_array = extractSelectList($this->sql_select);
            $select_array = removeDuplicateNameFromSelect($select_array, 'x.task_name');
            // convert array back into a string
            $this->sql_select = implode(', ', $select_array);
        } // if

        $this->sql_orderby = 'mnu_nav_button.sort_seq';

        $this->sql_select .= ', mnu_nav_button.sort_seq';  // required by postgres

        $this->sql_having = array2where($having_array);

        //$buttons = $this->getData_raw("$where AND mnu_task.task_id='$task_id'");
        $buttons = $this->getData_raw("mnu_task.task_id='$task_id'");

        if (count($buttons) > 0) {
            if (!empty($object->sql_search_table)) {
            	$search_table = $object->sql_search_table;
            } else {
                $search_table = $object->tablename;
            } // if
            if ($count = preg_match("/\w+ as \w+/i", $search_table, $regs)) {
                // entry contains 'table AS alias', so use original table table
            	list($original, $alias) = preg_split('/ as /i', $regs[0]);
            	$search_table = $original;
            } // if
            if (isset($_SESSION['search']) AND is_array($_SESSION['search']) AND !empty($_SESSION['search'][$search_table])) {
                if (preg_match("/^curr_or_hist[ ]*=[ ]*[']?\w[']?$/i", $_SESSION['search'][$search_table])) {
                    // contains only "curr_or_hist='X'", so ignore it
                } else {
                    // previous search data is available, so create extra button
                    $buttons = addPreviousSearchButton($buttons);
                } // if
            } // if
        } // if

        return $buttons;

    } // getNavButtons

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;

        if ($mode == 'search') {
            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['task_id_jnr']['noedit']);
            unset($fieldarray['task_id_jnr']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE
    {
        //DebugBreak();
        if ($fieldarray['task_id_snr'] == $fieldarray['task_id_jnr']) {
            $this->errors[] = getLanguageText('e0012'); // 'Cannot add a task to itself';
            return $fieldarray;
        } // if

        if (array_key_exists('task_type', $orignaldata)) {
            if ($orignaldata['task_type'] == 'MENU') {
                $this->errors[] = getLanguageText('e0013'); // 'Cannot add a task of type MENU';
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        if (isset($fieldarray['selected']) AND !is_True($fieldarray['selected'])) {
            $fieldarray['sort_seq'] = null;  // not selected, so this field is blank instead of zero
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array['READ'][] = 'mnu_pattern';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (!empty($fieldarray['task_id_snr'])) {
            // get next available value for SORT_SEQ
            $query = "SELECT max(sort_seq) FROM $this->tablename "
                   . "WHERE task_id_snr='{$fieldarray['task_id_snr']}'";
            $count = $this->getCount($query);
            $fieldarray['sort_seq'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $pattern_id = getPatternId();
        switch (strtolower($pattern_id)) {
            // may need to change the contents of $where
        	case 'link1':
                // alter sort criteria
        		//$this->sql_orderby = str_replace('mnu_nav_button.task_id_jnr', 'task_id_jnr', $this->sql_orderby);
        		break;

            default:
                $where = str_replace('task_id=', 'task_id_snr=', $where);
        } // switch

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted
    {

        if (array_key_exists('task_id', $fieldarray)) {
            // change fieldname in $fieldarray from 'task_id' to 'task_id_jnr'
            $fieldarray['task_id_jnr'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        if (array_key_exists('task_id_jnr', $fieldarray) AND !array_key_exists('button_text', $fieldarray)) {
            $task_id_jnr = $fieldarray['task_id_jnr'];
            // get default button text from mnu_task table
            $dbobject = RDCsingleton::getInstance('mnu_task');
            $dbobject->sql_select = 'button_text,task_type,pattern_id';
            $data = $dbobject->getData("task_id='$task_id_jnr'");
            $fieldarray = array_merge($fieldarray, $data[0]);
            if (strlen($fieldarray['button_text']) > $this->fieldspec['button_text']['size']) {
                $fieldarray['button_text'] = substr($fieldarray['button_text'], 0, $this->fieldspec['button_text']['size']);
            } // if

            if (!array_key_exists('context_preselect', $fieldarray)) {
                // get default context_preselect from mnu_pattern table
                $pattern_id = $fieldarray['pattern_id'];
                $dbobject = RDCsingleton::getInstance('mnu_pattern');
                $dbobject->sql_select = 'context_preselect';
                $data = $dbobject->getData("pattern_id='$pattern_id'");
                $fieldarray = array_merge($fieldarray, $data[0]);
            } // if
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateLinkdata ($fieldarray, &$postarray)
    // $fieldarray is an array of field data (multiple rows).
    // $postarray is an array of entries which have been selected.
    // NOTE: $postarray is passed BY REFERENCE so that it may be modified.
    {
        // remove any selection which links an item to itself
        foreach ($postarray['select'] as $row => $switch) {
            if ($fieldarray[$row-1]['task_id_snr'] == $fieldarray[$row-1]['task_id_jnr']) {
                unset($postarray['select'][$row]);
                $this->messages[] = getLanguageText('e0012'); // 'Cannot add a task to itself';
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_pre_updateLinkData

    // ****************************************************************************
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings, $offset)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        $where = '';

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        $settings['select_one'] = false;

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        return $where;

    } // _cm_popupCall

// ****************************************************************************
} // end class
// ****************************************************************************

?>
