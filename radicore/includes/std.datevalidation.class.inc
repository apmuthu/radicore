<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class date_class {

    // private variables
    var $monthalpha;            // array of 3-character month names
    var $internaldate;          // date as held in the database (yyyymmdd)
    var $externaldate;          // date as shown to the user (dd Mmm yyyy)
    var $errors;                // error messages
    var $date_format = 'dmy';   // date format - 'dmy', 'mdy' or 'ymd'

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

    } // date_class

    // ****************************************************************************
    // accessor functions
    // ****************************************************************************
    function formatDate ($dd, $mm, $ccyy)
    // convert a date into the format required by the user
    {
        $format     = strtolower($this->date_format);
        $monthalpha = $this->monthalpha;

        switch ($format) {
        	case 'dmy':
        	    $mm     = (int)$mm;
        		$output = "$dd $monthalpha[$mm] $ccyy";
        		break;

        	case 'mdy':
        	    $mm     = (int)$mm;
        		$output = "$monthalpha[$mm] $dd $ccyy";
        		break;

        	case 'dd/mm/yyyy':
        		$output = "$dd/$mm/$ccyy";
        		break;

        	case 'dd.mm.yyyy':
        		$output = "$dd.$mm.$ccyy";
        		break;

        	case 'dd/mm/yy':
        	    $yy = substr($ccyy, 2);
        		$output = "$dd/$mm/$yy";
        		break;

        	case 'ymd':
        	default:
        	    $mm     = (int)$mm;
        	    $output = "$ccyy $monthalpha[$mm] $dd";
        		break;
        } // switch

        return $output;

    } // formatDate

    // ****************************************************************************
    function getInternalDate ($input)
    // convert date from external format (as input by user)
    // to internal format (as used in the database)
    {
        // look for d(d)?m(m)?(yyyy) format (may also be m(m)?d(d)?y(yyy) format)
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{0,4}$)';     // 0 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            if (eregi('^(dmy|dd/mm/yyyy|dd\.mm\.yyyy|dd/mm/yy)$', $this->date_format)) {
                $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            } else { // assume 'mdy'
                $result = $this->verifyDate($regs[3], $regs[1], $regs[5]);
            } // if
            return $result;
        } // if

        // look for d(d)?MMM?(yyyy) format
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{0,4}$)';     // 0 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for d(d)MMM(yyyy) format
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([0-9]{0,4}$)';     // 0 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
            return $result;
        } // if

        // look for MMM?d(d)?(yyyy) format
        $pattern = '(^[a-zA-Z]{1,})'    // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,4}$)';     // 0 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[3], $regs[1], $regs[5]);
            return $result;
        } // if

        // look for MMMddyyyy format
        $pattern = '(^[a-zA-Z]{1,})'    // 1 or more alpha
                 . '([0-9]{2})'         // 2 digits
                 . '([0-9]{4}$)';       // 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[2], $regs[1], $regs[3]);
            return $result;
        } // if

        // look for yyyy?m(m)?d(d) format
        $pattern = '(^[0-9]{4})'        // 4 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2}$)';     // 1 to 2 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[5], $regs[3], $regs[1]);
            return $result;
        } // if

        if (eregi('^(dmy|mdy)$', $this->date_format)) {
            // look for ddmmyyyy format (may also be mmddyyyy format)
            $pattern = '(^[0-9]{2})'        // 2 digits
                     . '([0-9]{2})'         // 2 digits
                     . '([0-9]{4}$)';       // 4 digits
            if (ereg($pattern, $input, $regs)) {
                if (eregi('^(dmy)$', $this->date_format)) {
                    $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
                } else { // assume 'mdy'
                    $result = $this->verifyDate($regs[2], $regs[1], $regs[3]);
                } // if
                return $result;
            } // if
        } // if

        if (eregi('^(ymd)$', $this->date_format)) {
            // look for yyyymmdd format
            $pattern = '(^[0-9]{4})'        // 4 digits
                     . '([0-9]{2})'         // 2 digits
                     . '([0-9]{2}$)';       // 2 digits
            if (ereg($pattern, $input, $regs)) {
                $result = $this->verifyDate($regs[3], $regs[2], $regs[1]);
                return $result;
            } // if
        } // if

        // look for yyyy?MMM?d(d) format
        $pattern = '(^[0-9]{4})'        // 4 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2}$)';     // 1 to 2 digits
        if (ereg($pattern, $input, $regs)) {
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
        $pattern = '(^[0-9]{2})'        // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2})'         // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2}$)';       // 2 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for HHMMSS format
        $pattern = '(^[0-9]{2})'        // 2 digits
                 . '([0-9]{2})'         // 2 digits
                 . '([0-9]{2}$)';       // 2 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[2], $regs[3]);
            return $result;
        } // if

        // look for HH?MM format
        $pattern = '(^[0-9]{2})'        // 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{2}$)';       // 2 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[3], '00');
            return $result;
        } // if

        // look for HHMM format
        $pattern = '(^[0-9]{2})'        // 2 digits
                 . '([0-9]{2}$)';       // 2 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyTime($regs[1], $regs[2], '00');
            return $result;
        } // if

        $this->errors = getLanguageText('sys0041'); // 'This is not a valid time'

        return false;

    } // getInternalTime

    // ****************************************************************************
    function getInternalDateTime ($input)
    // convert datetime from external format (as input by user)
    // to internal format (as used in the database)
    {
        // look for last space as a delimiter between date and time portions
        $pos = strrpos($input, ' ');

        // now split the input into its two portions
        $date = substr($input, 0, $pos);
        $time = substr($input, $pos);

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
        if (eregi('([a-z]{3})', $month)) {
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
    function getExternalDate ($input)
    // convert date from internal format (as used in the database)
    // to external format (as shown to the user))
    {
        $monthalpha = $this->monthalpha;

        // input may be 'yyyy-mm-dd' or 'yyyymmdd'  or 'dd-Mmm-yy', so
        // check the length and process accordingly

        if (strlen($input) == 8) {
            // test for 'yyyymmdd'
            $pattern = '(^[0-9]{4})'    // 4 digits (yyyy)
                     . '([0-9]{2})'     // 2 digits (mm)
                     . '([0-9]{2}$)';   // 2 digits (dd)
            if (ereg($pattern, $input, $regs)) {
                if ($input == '00000000') {
                	return '';
                } elseif (!checkdate($regs[2], $regs[3], $regs[1])) {
                    $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
                    return false;
                } else {
                    $this->externaldate = $this->formatDate($regs[3], $regs[2], $regs[1]);
//                    $monthnum = (int)$regs[2];
//                    if (eregi('^(dmy)$', $this->date_format)) {
//                        $this->externaldate = "$regs[3] $monthalpha[$monthnum] $regs[1]";
//                    } elseif (eregi('^(mdy)$', $this->date_format)) {
//                        $this->externaldate = "$monthalpha[$monthnum] $regs[3] $regs[1]";
//                    } else { // assume 'ymd'
//                        $this->externaldate = "$regs[1] $monthalpha[$monthnum] $regs[3]";
//                    } // if
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0046'); // Invalid date format: expected 'yyyymmdd
            return false;
        } // if

        if (strlen($input) == 9) {
            // test for 'dd-Mmm-yy'
            $pattern = '(^[0-9]{2})'    // 2 digits (dd)
                     . '([^0-9])'       // not a digit
                     . '([a-zA-Z]{3})'  // 3 alpha (Mmm)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2}$)';   // 2 digits (yy)
            if (ereg($pattern, $input, $regs)) {
                if ($result = $this->verifyDate($regs[1], $regs[3], $regs[5])) {
                	$this->externaldate = $this->getExternalDate($result);
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0049'); // Invalid date format: expected 'dd-Mmm-yy'
            return false;
        } // if

        if (strlen($input) == 10) {
            // test for 'yyyy-mm-dd'
            $pattern = '(^[0-9]{4})'    // 4 digits (yyyy)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2})'     // 2 digits (mm)
                     . '([^0-9])'       // not a digit
                     . '([0-9]{2}$)';   // 2 digits (dd)
            if (ereg($pattern, $input, $regs)) {
                if ($input == '0000-00-00') {
                	return '';
                } elseif (!checkdate($regs[3], $regs[5], $regs[1])) {
                    $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
                    return false;
                } else {
                    $this->externaldate = $this->formatDate($regs[5], $regs[3], $regs[1]);
//                    $monthnum = (int)$regs[3];
//                    if (eregi('^(dmy)$', $this->date_format)) {
//                        $this->externaldate = "$regs[5] $monthalpha[$monthnum] $regs[1]";
//                    } elseif (eregi('^(mdy)$', $this->date_format)) {
//                        $this->externaldate = "$monthalpha[$monthnum] $regs[5] $regs[1]";
//                    } else { // assume 'ymd'
//                        $this->externaldate = "$regs[1] $monthalpha[$monthnum] $regs[5]";
//                    } // if
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0047'); // Invalid date format: expected 'dd-mm-yyyy'
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
        list ($month, $day, $year) = split ('[/]', $gregorian);

        // convert back into standard format
        $result = $this->getInternaldate("$day/$month/$year");

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
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

// ****************************************************************************
} // end date_class
// ****************************************************************************

?>
