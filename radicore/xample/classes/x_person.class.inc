<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class x_person extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function x_person()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'xample';
        $this->tablename   = 'x_person';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // x_person

    // ****************************************************************************
    function getLastAddressNo ($where)
    // get number of last address for this person
    {
        // look for the current value for address_no on person_addr table
        $query = "SELECT max(address_no) FROM x_person_addr WHERE $where";
        $count = $this->getCount($query);

        return $count;

    } // getLastAddressNo

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;

        if ($mode == 'search') {
            $prev_script = getPreviousScript();
            if (basename($prev_script) == 'pers_opt_xref_link(b).php') {
                // add an extra field to the field list
                $this->fieldspec['selected'] = array('type' => 'boolean',
                                                     'true' => 'Y',
                                                     'false' => 'N');
            } // if
            // turn off 'noedit' attribute for search screen
            unset($this->fieldspec['last_addr_no']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        $start_date = $fieldarray['start_date'];
        $end_date   = $fieldarray['end_date'];

        if ($start_date > $end_date) {
            // 'Start Date cannot be later than End Date';
            $this->errors['start_date'] = getLanguageText('e0001');
            // 'End Date cannot be earlier than Start Date';
            $this->errors['end_date']   = getLanguageText('e0002');
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        if (!isset($fieldarray['person_name'])) {
            // merge first_name and last_name into person_name
            if (isset($fieldarray['first_name']) AND isset($fieldarray['last_name'])) {
                $fieldarray['person_name'] = $fieldarray['first_name']
                                           . ' '
                                           . $fieldarray['last_name'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = TRUE;     // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']) {
            case 'insert':
                $lock_array[] = $this->tablename;
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person_addr';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'x_person_addr';
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get enum list for star_sign and insert into lookup array
        $array = $this->getValRep('star_sign');
        $this->lookup_data['star_sign'] = $array;

        // get contents of foreign table PERS_TYPE and add to lookup array
        require_once 'x_pers_type.class.inc';
        $pers_type =& singleton::getInstance('x_pers_type');
        $pers_type_array = $pers_type->getValRep('pers_type_id');
        $this->lookup_data['pers_type_id'] = $pers_type_array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // this field is irrelevant for insert
        $this->fieldspec['last_addr_no']['nodisplay'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item='', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'star_sign') {
            // $array = $this->getEnum($item);
//            $array['']    = ' ';   // start with blank entry
//            $array['ARI'] = 'Aries';
//            $array['AQU'] = 'Aquarius';
//            $array['CAN'] = 'Cancer';
//            $array['CAP'] = 'Capricorn';
//            $array['GEM'] = 'Gemini';
//            $array['LEO'] = 'Leo';
//            $array['LIB'] = 'Libra';
//            $array['PIS'] = 'Pisces';
//            $array['SAG'] = 'Sagittarius';
//            $array['SCO'] = 'Scorpio';
//            $array['TAU'] = 'Taurus';
//            $array['VIR'] = 'Virgo';
            $array = getLanguageArray('star_sign');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where amy need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered.
    {
        if ($popupname == 'x_tree_structure(popup)') {
            // structure must be of type 'ORG'
            $where = "tree_type_id='ORG'";
        } // if

		// ensure that only one entry can be selected
        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database is updated.
    {
        // do nothing if there are no addresses yet
        if ($fieldarray['last_addr_no'] == 0) {
            return $fieldarray;
        } // if

        require_once 'x_person_addr.class.inc';
        $dbobject =& singleton::getInstance('x_person_addr');

        if ($fieldarray['start_date'] <> $old_data['start_date']) {
            // update start date on first address
            $first_array['person_id'] = $fieldarray['person_id'];
            $first_array['address_no'] = '1';
            $first_array['start_date'] = $fieldarray['start_date'];
        } // if

        if ($fieldarray['end_date'] <> $old_data['end_date']) {
            if ($this->last_addr_no == 1) {
                // update end date on first (only) address
                $first_array['person_id'] = $fieldarray['person_id'];
                $first_array['address_no'] = '1';
                $first_array['end_date'] = $fieldarray['end_date'];
            } else {
                // update end date on last address
                $last_array['person_id'] = $fieldarray['person_id'];
                $last_array['address_no'] = $this->last_addr_no;
                $last_array['end_date'] = $fieldarray['end_date'];
            } // if
        } // if

        if (isset($first_array)) {
            $dbobject->skip_validation = true;
            $first_array = $dbobject->updateRecord($first_array);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $fieldarray;
            } // if
        } // if

        if (isset($last_array)) {
            $dbobject->skip_validation = true;
            $last_array = $dbobject->updateRecord($last_array);
            if ($dbobject->errors) {
                $this->errors = $dbobject->errors;
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'x_person.*, x_tree_node.node_id, x_tree_node.node_desc';
            $this->sql_from   = 'x_person '
                               .'LEFT JOIN x_tree_node ON (x_tree_node.node_id=x_person.node_id)';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $orignaldata)
    // perform custom validation before update.
    {
        // get current value for 'last_addr_no'
        $this->last_addr_no = $fieldarray['last_addr_no'];

        // no validation required if $last_addr_no = 0 or 1
        if ($this->last_addr_no > 1) {
            // there is more than one address, so...
            require_once 'x_person_addr.class.inc';
            $dbobject =& singleton::getInstance('x_person_addr');

            // compare start date with first address
            $dbobject->sql_select = 'end_date';
            $where = "person_id='{$fieldarray['person_id']}' AND address_no='1'";
            $first_addr_data = $dbobject->getdata_unformatted($where);
            if ($dbobject->numrows <> 1) {
                // "Could not locate first ADDRESS record"
                $this->errors[] = getLanguageText('e0010');
                return $fieldarray;
            } // if

            // extract array for first occurrence only
            $first_addr_data = $first_addr_data[0];

            if ($fieldarray['start_date'] > $first_addr_data['end_date']) {
                $fieldarray['start_date'] = $first_addr_data['end_date'];
                // 'Start Date cannot be later than End Date of first address'
                $this->errors['start_date'] = getLanguageText('e0011');
                return $fieldarray;
            } // if

            // compare end date with last address
            $where = "person_id='{$fieldarray['person_id']}' AND address_no='{$this->last_addr_no}'";
            $dbobject->sql_select = 'start_date';
            $last_addr_data = $dbobject->getdata_unformatted($where);
            if ($dbobject->numrows <> 1) {
                // "Could not locate last ADDRESS record"
                $this->errors[] = getLanguageText('e0012');
                return $fieldarray;
            } // if

            // extract array for first occurrence only
            $last_addr_data = $last_addr_data[0];

            if ($fieldarray['end_date'] < $last_addr_data['start_date']) {
                $fieldarray['end_date'] = $last_addr_data['start_date'];
                // 'End Date cannot be earlier than Start Date of last address'
                $this->errors['end_date'] = getLanguageText('e0013');
                return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
