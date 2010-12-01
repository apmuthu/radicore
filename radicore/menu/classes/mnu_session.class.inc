<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class mnu_session extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function mnu_session ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'mnu_session';
        $this->dbname      = 'menu';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // mnu_session

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // write XML document out to a disk file?
        $fieldspec['log_xml_document']      = array('type' => 'boolean');

        // write SQL queries out to a disk file?
        $fieldspec['log_sql_query']         = array('type' => 'boolean');

        // drop saved pages from memory?
        $fieldspec['drop_saved_pages']      = array('type' => 'boolean');

        // choose CSS file for theme/style
        $fieldspec['css_file']              = array('type' => 'string',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'css_file',
                                                    'required' => 'y');

        $this->fieldspec = $fieldspec;

//        if (empty($this->css_files)) {
//        	$this->css_files[] = 'alternate.css';
//        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // get list of *.css files in CSS directory
        $array = array();
        $dir = @opendir('../css');
        while (false !== ($file = readdir($dir))) {
            // only files of .css are appended to array
            if (preg_match('/css/i', $file, $regs)) {
                $file = basename($file, '.css');
                $array[$file] = $file;
            } // if
        } // endwhile
        closedir($dir);
        ksort($array);
        $this->lookup_data['css_file'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // do not try to read data from the database (there isn't any)
        $this->skip_getdata = true;

        // construct data manually instead
        $row['log_xml_document'] = $_SESSION['log_xml_document'];
        $row['log_sql_query']    = $_SESSION['log_sql_query'];
        $row['drop_saved_pages'] = false;
        $row['css_file']         = $_SESSION['css_file'];

        $this->fieldarray[0] = $row;

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_updateSelection($fieldarray, $replace)
    // update multiple rows in a single operation.
    {
        // perform standard validation
        $fieldarray = $this->_validateUpdate($fieldarray);
        if ($this->errors) {
        	return;
        } // if

        // store these values in the $_SESSION array
        $_SESSION['log_xml_document'] = $fieldarray['log_xml_document'];
        $_SESSION['log_sql_query']    = $fieldarray['log_sql_query'];

        if (is_True($fieldarray['drop_saved_pages'])) {
            // remove any tasks that have been placed in the queue
            unset($_SESSION['script_sequence']);
            // delete current scripts from memory
        	foreach ($_SESSION['pages'] as $key => $value) {
    		    switch (basename($key)) {
    		    	case 'logon.php':
    		    	case 'menu.php':
    		    	case basename($_SERVER['PHP_SELF']):
    		    	    // do not delete
    		    	    break;

    		    	default:
    		    	    // delete
    		    	    unset($_SESSION['pages'][$key]);
    		    		break;
    		    } // switch
        	} // foreach
        } // if

        // store name of selected CSS file
        $_SESSION['css_file'] = $fieldarray['css_file'];
        setcookie("theme", $fieldarray['css_file'], time()+7776000, '/');

        return;

    } // _cm_updateSelection

// ****************************************************************************
} // end class
// ****************************************************************************

?>
