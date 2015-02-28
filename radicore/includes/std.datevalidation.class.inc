<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class date_class {

    // private variables
    var $monthalpha;            // array of 3-character month names
    var $internaldate;          // date as held in the database (yyyymmdd)
    var $externaldate;          // date as shown to the user (dd Mmm yyyy)
    var $errors;                // error messages
    var $date_format = 'dmy';   // date format from the CONFIG.INC file
    var $date_format_input;     // date format (input) from the LANGUAGE table
    var $date_format_output;    // date format (output) from the LANGUAGE table
    var $date_length = 12;      // length of date string on HTML form

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function date_class()
    {
        //$this->monthalpha = array(1 => 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
        $this->monthalpha = getLanguageArray('month_names_short');

        if (isset($GLOBALS['date_format'])) {
        	$this->date_format = $GLOBALS['date_format'];
        } // if
        if (isset($_SESSION['date_format_input'])) {
            $this->date_format_input = $_SESSION['date_format_input'];
        } // if
        if (isset($_SESSION['date_format_output'])) {
            $this->date_format_output = $_SESSION['date_format_output'];
        } // if

    } // date_class

    // ****************************************************************************
    // accessor functions
    // ****************************************************************************
    function _formatDate ($dd, $mm, $ccyy, $date_format)
    // convert a date into the output format required by the user
    {
        $format     = strtolower($date_format);
        $monthalpha = $this->monthalpha;

        // Japanese/Chinese characters
        $ja_day   = pack("CCC",0xe6,0x97,0xa5);
        $ja_month = pack("CCC",0xe6,0x9c,0x88);
        $ja_year  = pack("CCC",0xe5,0xb9,0xb4);
        // Korean characters
        $ko_day   = pack("CCC",0xec,0x9d,0xbc);
        $ko_month = pack("CCC",0xec,0x9b,0x94);
        $ko_year  = pack("CCC",0xeb,0x85,0x84);

        switch ($format) {
        	case 'dmy':
            case 'dd mmm yyyy':
        	    $mm     = (int)$mm;
        		$output = "$dd $monthalpha[$mm] $ccyy";
        		break;

        	case 'd mmm yyyy':
                $d      = (int)$dd;
                $mm     = (int)$mm;
                $output = "$d $monthalpha[$mm] $ccyy";
                break;

            case 'dd mm yyyy':
                $output = "$dd $mm $ccyy";
                break;

            case 'dd.mm.yyyy':
                $output = "$dd.$mm.$ccyy";
                break;

            case 'dd-mm-yyyy':
        		$output = "$dd-$mm-$ccyy";
        		break;

        	case 'dd/mm/yyyy':
                $output = "$dd/$mm/$ccyy";
                break;

            case 'd/mm/yyyy':
                $d = (int)$dd;
                $output = "$d/$mm/$ccyy";
                break;

            case 'dd/mm yyyy':
                $output = "$dd/$mm $ccyy";
                break;

            case 'dd/mm/yy':
        	    $yy = substr($ccyy, 2);
        		$output = "$dd/$mm/$yy";
        		break;

            case 'd.m.yyyy':
                $d = (int)$dd;
                $m = (int)$mm;
                $output = "$d.$m.$ccyy";
                break;

            case 'd. m. yyyy':
                $d = (int)$dd;
                $m = (int)$mm;
                $output = "$d. $m. $ccyy";
                break;

            case 'dd. mm. yyyy.':
                $output = "$dd. $mm. $ccyy.";
                break;

            case 'mdy':
            case 'mmm dd yyyy':
                $mm     = (int)$mm;
                $output = "$monthalpha[$mm] $dd $ccyy";
                break;

            case 'mm dd yyyy':
                $output = "$mm $dd $ccyy";
                break;

        	case 'm/d/yyyy':
                $m      = (int)$mm;
                $d      = (int)$dd;
                $output = "$m/$d/$ccyy";
                break;

            case 'm d yyyy':
                $m      = (int)$mm;
                $d      = (int)$dd;
                $output = "$m $d $ccyy";
                break;

            case 'ymd':
            case 'yyyy mmm dd':
        	    $mm     = (int)$mm;
        	    $output = "$ccyy $monthalpha[$mm] $dd";
        		break;

            case 'yyyy/mm/dd':
                $output = "$ccyy/$mm/$dd";
                break;

            case 'yyyy.mm.dd':
                $output = "$ccyy.$mm.$dd";
                break;

            case 'yyyy. mm. dd':
                $output = "$ccyy. $mm. $dd";
                break;

            case 'yyyy#mm#dd# [ja]':
                $output = $ccyy.$ja_year.$mm.$ja_month.$dd.$ja_day;
                break;

            case 'yyyy# mm# dd# [ko]':
                $output = $ccyy.$ko_year.' '.$mm.$ko_month.' '.$dd.$ko_day;
                break;

            case 'yyyy#m#d# [zh_xx]':
                $m      = (int)$mm;
                $d      = (int)$dd;
                $output = $ccyy.$ja_year.$m.$ja_month.$d.$ja_day;
                break;

            case 'yyyy-mm-dd':
            default:
                $output = "$ccyy-$mm-$dd";
                break;
        } // switch

        $this->date_length = strlen($output);

        return $output;

    } // _formatDate

    // ****************************************************************************
    function getInternalDate ($input, $date_format=null)
    // convert date from external format (as input by user)
    // to internal format (as used in the database)
    {
        if (empty($date_format)) {                      // AJM - 2014-04-22
            $date_format = $this->date_format_input;    // AJM - 2014-04-22
        } // if                                         // AJM - 2014-04-22

        $input = trim($input);

        // check if date is already in yyyy-mm-dd format
        $pattern = '/'
                 . '^'              // begins with
                 . '[0-9]{4}'       // 4 digit year
                 . '-'              // '-'
                 . '[0-9]{2}'       // 2 digit month
                 . '-'              // '-
                 . '[0-9]{2}'       // 2 digit day
                 . '$'              // ends with
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $date_format = 'yyyy-mm-dd';  //date is already in internal format
        } // if

        $date_format = strtolower($date_format);

        if (!empty($date_format)) {
            switch ($date_format) {
                case 'yyyy-mm-dd':
                case 'yyyy/mm/dd':
                case 'yyyy.mm.dd':
                    preg_match_all('/[0-9]+/', $input, $regs);
                    $year  = $regs[0][0];
                    $month = $regs[0][1];
                    $day   = $regs[0][2];
                    break;

                case 'dd mmm yyyy':
                case 'd MMM yyyy':
                    $array = explode(' ', $input, 3);
                    $day   = $array[0];
                    $month = $array[1];
                    $year  = $array[2];
                    break;

                case 'mmm dd yyyy':
                    $array = explode(' ', $input, 3);
                    $month = $array[0];
                    $day   = $array[1];
                    $year  = $array[2];
                    break;

                case 'dd mm yyyy':
                case 'dd.mm.yyyy':
                case 'dd-mm-yyyy':
                case 'dd/mm/yyyy':
                case 'd/mm/yyyy':
                case 'dd/mm yyyy':
                case 'dd/mm/yy':
                case 'd.m.yyyy':
                case 'd. m. yyyy':
                case 'dd. mm. yyyy.':
                    preg_match_all('/[0-9]+/', $input, $regs);
                    $day   = $regs[0][0];
                    $month = $regs[0][1];
                    $year  = $regs[0][2];
                    break;

                case 'mm dd yyyy':
                case 'm/d/yyyy':
                    preg_match_all('/[0-9]+/', $input, $regs);
                    $month = $regs[0][0];
                    $day   = $regs[0][1];
                    $year  = $regs[0][2];
                    break;

                case 'yyyy mmm dd':
                    $array = explode(' ', $input, 3);
                    $year  = $array[0];
                    $month = $array[1];
                    $day   = $array[2];
                    break;

                case 'yyyy. mm. dd':
                case 'yyyy#mm#dd# [ja]':
                case 'yyyy# mm# dd# [ko]':
                case 'yyyy#m#d# [zh_xx]':
                    preg_match_all('/[0-9]+/', $input, $regs);
                    $year  = $regs[0][0];
                    $month = $regs[0][1];
                    $day   = $regs[0][2];
                    break;

                default:
                    $this->errors = getLanguageText('sys0047', $date_format);
                    return false;
            } // switch
            $result = $this->verifyDate($day, $month, $year);
            if ($result === false) {
                // "Invalid date format, expecting 'xx xx xx'
                $this->errors = getLanguageText('sys0046', $date_format);
            } // if
            return $result;
        } // if

        if (empty($date_format)) {              // AJM - 2014-02-15
            $date_format = $this->date_format;  // AJM - 2014-02-15
        } // if                                 // AJM - 2014-02-15

        // look for d(d)?m(m)?(yyyy) format (may also be m(m)?d(d)?y(yyy) format)
        $pattern = '/'
                 . '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{0,4}$)'      // 0 to 4 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            if (preg_match('#^(dmy|dd/mm/yyyy|dd\.mm\.yyyy|dd/mm/yy)$#i', $date_format)) {
                $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            } else { // assume 'mdy'
                $result = $this->verifyDate($regs[3], $regs[1], $regs[5]);
            } // if
            return $result;
        } // if

        // look for d(d)?MMM?(yyyy) format
        $pattern = '/'
                 . '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{0,4}$)'      // 0 to 4 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for d(d)MMM(yyyy) format
        $pattern = '/'
                 . '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([0-9]{0,4}$)'      // 0 to 4 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
            return $result;
        } // if

        // look for MMM?d(d)?(yyyy) format
        $pattern = '/'
                 . '(^[a-zA-Z]{1,})'    // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,4}$)'      // 0 to 4 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[3], $regs[1], $regs[5]);
            return $result;
        } // if

        // look for MMMddyyyy format
        $pattern = '/'
                 . '(^[a-zA-Z]{1,})'    // 1 or more alpha
                 . '([0-9]{2})'         // 2 digits
                 . '([0-9]{4}$)'        // 4 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[2], $regs[1], $regs[3]);
            return $result;
        } // if

        // look for yyyy?m(m)?d(d) format
        $pattern = '/'
                 . '(^[0-9]{4})'        // 4 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2}$)'      // 1 to 2 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[5], $regs[3], $regs[1]);
            return $result;
        } // if

        if (preg_match('/^(dmy|mdy)$/i', $date_format)) {
            // look for ddmmyyyy format (may also be mmddyyyy format)
            $pattern = '/'
                     . '(^[0-9]{2})'        // 2 digits
                     . '([0-9]{2})'         // 2 digits
                     . '([0-9]{4}$)'        // 4 digits
                     . '/';
            if (preg_match($pattern, $input, $regs)) {
                if (preg_match('/^(dmy)$/i', $date_format)) {
                    $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
                } else { // assume 'mdy'
                    $result = $this->verifyDate($regs[2], $regs[1], $regs[3]);
                } // if
                return $result;
            } // if
        } // if

        if (preg_match('/^(ymd)$/i', $date_format)) {
            // look for yyyymmdd format
            $pattern = '/'
                     . '(^[0-9]{4})'        // 4 digits
                     . '([0-9]{2})'         // 2 digits
                     . '([0-9]{2}$)'        // 2 digits
                     . '/';
            if (preg_match($pattern, $input, $regs)) {
                $result = $this->verifyDate($regs[3], $regs[2], $regs[1]);
                return $result;
            } // if
        } // if

        // look for yyyy?MMM?d(d) format
        $pattern = '/'
                 . '(^[0-9]{4})'        // 4 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2}$)'      // 1 to 2 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[5], $regs[3], $regs[1]);
            return $result;
        } // if

        if (strlen($input) > 10) {
            // input is too long, so split into two pieces and process first piece
            list($date, $time) = explode(' ', $input);
            if (strlen($date) == strlen($input)) {
                // same length, so drop last character
            	$date = substr($date, 0, strlen($date)-1);
            } // if
            $this->internaldate = $this->getInternalDate($date);
            return $this->internaldate;
        } // if

        $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'

        return false;

    } // getInternalDate

    // ****************************************************************************
    function getInternalTime ($input)
    // convert time from external format (as input by user)
    // to internal format (as used in the database)
    {
        // look for HH?MM?SS format
        $pattern = '/'
                 . '(^[0-9]{2})'        // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2})'         // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2})'         // 2 digits
                 . '(\.[0-9]+)?$'       // optional '.nnn' microseconds (for SQL Server)
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for HHMMSS format
        $pattern = '/'
                 . '(^[0-9]{2})'        // 2 digits
                 . '([0-9]{2})'         // 2 digits
                 . '([0-9]{2}$)'        // 2 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[2], $regs[3]);
            return $result;
        } // if

        // look for HH?MM format
        $pattern = '/'
                 . '(^[0-9]{2})'        // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2}$)'        // 2 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[3], '00');
            return $result;
        } // if

        // look for HHMM format
        $pattern = '/'
                 . '(^[0-9]{2})'        // 2 digits
                 . '([0-9]{2}$)'        // 2 digits
                 . '/';
        if (preg_match($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[2], '00');
            return $result;
        } // if

        $this->errors = getLanguageText('sys0041'); // 'This is not a valid time'

        return false;

    } // getInternalTime

    // ****************************************************************************
    function getInternalDateTime ($input, $fieldspec=null)
    // convert datetime from external format (as input by user)
    // to internal format (as used in the database)
    {
        $pattern = '/'
                 . '^'              // begins with
                 . '(?<date>'       // start named pattern
                 . '[0-9]{4}-[0-9]{2}-[0-9]{2}' // '9999-99-99'
                 . ')'              // end named pattern
                 . '[ ]'            // space
                 . '(?<time>'       // start named pattern
                 . '([0-9]{2}:[0-9]{2}){1}'     // 'HH:MM'
                 . '(:[0-9]{2})?'               // optional ':SS'
                 . ')'              // end named pattern
                 . '/';

        // look for a time portion (ends with '99:99' or '99:99:99')
        if (preg_match($pattern, $input, $regs)) {
            $date = $regs['date'];
            $time = $regs['time'];
        } else {
            $date = $input;
            $time = null;
            // only a date given, so append the default time) if there is one)
            if (isset($fieldspec['default'])) {
                $time = substr($fieldspec['default'], 11, 8);
            } else {
                $time = '00:00:00';
            } // if
        } // if

        // validate the separate portions
        if (!$internaldate = $this->getInternalDate(trim($date))) {
            // fall through
        } elseif (!$internaltime = $this->getInternalTime(trim($time))) {
            // fall through
        } else {
            // set datetime to internal format
            $result = trim($internaldate) . ' ' . trim($internaltime);
            return $result;
        } // if

        $this->errors = getLanguageText('sys0048'); // 'This is not a valid datetime'

        return false;

    } // getInternalDateTime

    // ****************************************************************************
    function verifyDate ($day, $month, $year)
    {
        if (preg_match('/([a-z]{3})/i', $month)) {
        	// convert array from 'N=month' to 'month=N'
            $month_array = array_flip($this->monthalpha);
            // convert all month names to upper case
            $month_array = array_change_key_case($month_array, CASE_UPPER);

            $month = strtoupper($month);

            if (array_key_exists($month, $month_array)) {
            	$month_n = $month_array[$month];
            } else {
                $this->errors = getLanguageText('sys0042'); // 'Month name is invalid'
                return false;
            } // if
        } else {
            $month_n = $month;
        } // if

        // ensure that year has 4 digits
        if (strlen($year) == 4) {
            // do nothing
        } elseif (strlen($year) == 0) {
            $year = date('Y');
        } elseif (strlen($year) == 1) {
            $year = '200' . $year;
        } elseif (strlen($year) == 2) {
            if ($year > 50) {
            	$year = '19' . $year;
            } else {
                $year = '20' . $year;
            } // if
        } elseif (strlen($year) == 3) {
            $year = '2' . $year;
        } // if

        if (strlen($day) > 2) {
            $day = substr($day, 0, 2);
        } // if
        if (strlen($month_n) > 2) {
            $month_n = substr($month_n, 0, 2);
        } // if
        if (strlen($year) > 2) {
            $year = substr($year, 0, 4);
        } // if

        if (!checkdate($month_n, $day, $year)) {
            $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
            return false;
        } else {
            if (strlen($day) < 2) {
                $day = '0' . $day; // add leading zero
            } // if
            if (strlen($month_n) < 2) {
                $month_n = '0' . $month_n; // add leading zero
            } // if
            $this->internaldate = $year . '-' . $month_n . '-' . $day;
            return $this->internaldate;
        } // if

        return;

    } // verifyDate

    // ****************************************************************************
    function verifyTime ($hours, $minutes, $seconds)
    {
        if ($hours > 23) {
            $this->errors = getLanguageText('sys0043'); // 'Invalid HOURS'
            return false;
        } // if

        if ($minutes > 59) {
            $this->errors = getLanguageText('sys0044'); // 'Invalid MINUTES'
            return false;
        } // if

        if ($seconds > 59) {
            $this->errors = getLanguageText('sys0045'); // 'Invalid SECONDS'
            return false;
        } // if

        return "$hours:$minutes:$seconds";

    } // verifyTime

    // ****************************************************************************
    function getExternalDate ($input, $date_format=null)
    // convert date from internal format (as used in the database)
    // to external format (as shown to the user))
    {
        if (empty($date_format)) {                      // AJM - 2014-04-22
            $date_format = $this->date_format_output;   // AJM - 2014-04-22
        } // if                                         // AJM - 2014-04-22
        if (empty($date_format)) {              // AJM - 2014-02-15
            $date_format = $this->date_format;  // AJM - 2014-02-15
        } // if                                 // AJM - 2014-02-15

        // input may be 'yyyy-mm-dd' or 'yyyymmdd'  or 'dd-Mmm-yy', so
        // check the length and process accordingly

        $input = trim($input);

        if (strlen($input) == 8) {
            // test for 'yyyymmdd'
            $pattern = '/'
                     . '(^[0-9]{4})'    // 4 digits (yyyy)
                     . '([0-9]{2})'     // 2 digits (mm)
                     . '([0-9]{2}$)'    // 2 digits (dd)
                     . '/';
            if (preg_match($pattern, $input, $regs)) {
                if ($input == '00000000') {
                	return '';
                } elseif (!checkdate($regs[2], $regs[3], $regs[1])) {
                    $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
                    return false;
                } else {
                    $this->externaldate = $this->_formatDate($regs[3], $regs[2], $regs[1], $date_format);
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0046', 'yyyymmdd'); // Invalid date format: expected 'yyyymmdd'
            return false;
        } // if

        if (strlen($input) == 9) {
            // test for 'dd-Mmm-yy'
            $pattern = '/'
                     . '(^[0-9]{2})'    // 2 digits (dd)
                     . '([^0-9])'       // not a digit
                     . '([a-zA-Z]{3})'  // 3 alpha (Mmm)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2}$)'    // 2 digits (yy)
                     . '/';
            if (preg_match($pattern, $input, $regs)) {
                if ($result = $this->verifyDate($regs[1], $regs[3], $regs[5])) {
                	$this->externaldate = $this->getExternalDate($result);
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0046','dd-Mmm-yy'); // Invalid date format: expected 'dd-Mmm-yy'
            return false;
        } // if

        if (strlen($input) == 10) {
            // test for 'yyyy-mm-dd'
            $pattern = '/'
                     . '(^[0-9]{4})'    // 4 digits (yyyy)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2})'     // 2 digits (mm)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2}$)'    // 2 digits (dd)
                     . '/';
            if (preg_match($pattern, $input, $regs)) {
                if ($input == '0000-00-00') {
                	return '';
                } elseif (!checkdate($regs[3], $regs[5], $regs[1])) {
                    $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
                    return false;
                } else {
                    $this->externaldate = $this->_formatDate($regs[5], $regs[3], $regs[1], $date_format);
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0046','dd-mm-yyyy'); // Invalid date format: expected 'dd-mm-yyyy'
            return false;
        } // if

        if (strlen($input) == 11) {
        	// this could already be in external format, so leave it alone
        	return $input;
        } // if

        if (strlen($input) > 11) {
            // input is too long, so split into two pieces (after last ' ') and process first piece
            $time = strrchr($input, ' ');
            $date = substr($input, 0, strlen($input)-strlen($time));
            $this->externaldate = $this->getExternalDate($date);
            return $this->externaldate;
        } // if

        $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'

        return $input;

    } // getExternalDate

    // ****************************************************************************
    function addDays ($internaldate, $days)
    // add a number of days (may be negative) to $internaldate (YYYY-MM-DD)
    // and return the result in the same format
    {
        // ensure date is in internal format
        $internaldate = $this->getInternalDate($internaldate);

        // convert to the number of days since basedate (4714 BC)
        $julian = GregoriantoJD(substr($internaldate, 5, 2) , substr($internaldate, 8, 2) , substr($internaldate, 0, 4));

        $days = (int)$days;
        $julian = $julian + $days;

        // convert from Julian to Gregorian (format m/d/y)
        $gregorian = JDtoGregorian($julian);

        // split date into its component parts
        list ($month, $day, $year) = preg_split ('[/]', $gregorian);

        // convert back into standard format
        //$save_format = $this->date_format;      // AJM - 2014-01-23
        //$this->date_format = 'dmy';             // AJM - 2014-01-23
        $result = $this->getInternaldate("$day/$month/$year", 'dd/mm/yyyy');
        //$this->date_format = $save_format;      // AJM - 2014-01-23

        return $result;

    } // addDays

    // ****************************************************************************
    function addWeeks ($internaldate, $weeks)
    // add a number of days (may be negative) to $internaldate (YYYY-MM-DD)
    // and return the result in the same format
    {
        // multiply weeks by 7 to get days
        $result = $this->addDays($internaldate, $weeks*7);

        return $result;

    } // addWeeks

    // ****************************************************************************
    function addMonths ($internaldate, $months)
    // add a number of days (may be negative) to $internaldate (YYYY-MM-DD)
    // and return the result in the same format
    {
        // ensure date is in internal format
        $internaldate = $this->getInternalDate($internaldate);

        // adjust it by speciied number of months
        $timestamp = strtotime($internaldate .' + ' .$months .' months');

        // convert from unix timestamp into a human-readable date
        $result = date('Y-m-d', $timestamp);

        return $result;

    } // addMonths

    // ****************************************************************************
    function getDateLength ($format, $type)
    // return the size of the date field which changes depending on the format
    {
         // Japanese/Chinese characters
        $ja_day   = pack("CCC",0xe6,0x97,0xa5);
        $ja_month = pack("CCC",0xe6,0x9c,0x88);
        $ja_year  = pack("CCC",0xe5,0xb9,0xb4);
        // Korean characters
        $ko_day   = pack("CCC",0xec,0x9d,0xbc);
        $ko_month = pack("CCC",0xec,0x9b,0x94);
        $ko_year  = pack("CCC",0xeb,0x85,0x84);

        $format = strtolower($format);

        switch ($format) {
            case 'dd. mm. yyyy.':
                $length = strlen($format);
                break;

            case 'yyyy#mm#dd# [ja]':
                $output = 'yyyy'.$ja_year.'mm'.$ja_month.'dd'.$ja_day;
                $length = strlen($output);
                break;

            case 'yyyy# mm# dd# [ko]':
                $output = 'yyyy'.$ko_year.' mm'.ko_month.' dd'.$ko_day;
                $length = strlen($output);
                break;

            case 'yyyy#m#d# [zh_xx]':
                $output = 'yyyy'.$ja_year.'mm'.$ja_month.'dd'.$ja_day;
                $length = strlen($output);
                break;

            default:
                $length = 12;  // this is the default length
                break;
        } // switch

        if (preg_match('/time/i', $type)) {
            $length = $length + 8;
        } // if

        return $length;

    } // getErrors

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

// ****************************************************************************
} // end date_class
// ****************************************************************************

?>
