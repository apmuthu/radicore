<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class date_class {

    // private variables
    var $monthalpha;        // array of 3-character month names
    var $internaldate;      // date as held in the database (yyyymmdd)
    var $externaldate;      // date as shown to the user (dd Mmm yyyy)
    var $errors;            // error messages

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function date_class()
    {
        //$this->monthalpha = array(1 => 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
        $this->monthalpha = getLanguageArray('month_names_short');

    } // date_class

    // ****************************************************************************
    // accessor functions
    // ****************************************************************************
    function getInternalDate ($input)
    // convert date from external format (as input by user)
    // to internal format (as used in the database)
    {
        // look for d(d)?m(m)?y(yyy) format
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,4}$)';     // 1 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for d(d)?MMM?y(yyy) format
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,4}$)';     // 1 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[3], $regs[5]);
            return $result;
        } // if

        // look for d(d)MMMy(yyy) format
        $pattern = '(^[0-9]{1,2})'      // 1 or 2 digits
                 . '([a-zA-Z]{1,})'     // 1 or more alpha
                 . '([0-9]{1,4}$)';     // 1 to 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
            return $result;
        } // if

        // look for MMM?d(d)?y(yyy) format
        $pattern = '(^[a-zA-Z]{1,})'    // 1 or more alpha
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,2})'       // 1 or 2 digits
                 . '([^0-9a-zA-Z])'     // not alpha or numeric
                 . '([0-9]{1,4}$)';     // 1 to 4 digits
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

        // look for ddmmyyyy format
        $pattern = '(^[0-9]{2})'        // 2 digits
                 . '([0-9]{2})'         // 2 digits
                 . '([0-9]{4}$)';       // 4 digits
        if (ereg($pattern, $input, $regs)) {
            $result = $this->verifyDate($regs[1], $regs[2], $regs[3]);
            return $result;
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
        // convert alpha month to digits
        if (eregi('([a-z]{3})', $month)) {
            $month = ucfirst(strtolower($month));
            if (!$month = array_search($month, $this->monthalpha)) {
                $this->errors = getLanguageText('sys0042'); // 'Month name is invalid'
                return false;
            } // if
        } // if

        // ensure that year has 4 digits
        if (strlen($year) == 1) {
            $year = '200' . $year;
        } // if
        if (strlen($year) == 2) {
            $year = '20' . $year;
        } // if
        if (strlen($year) == 3) {
            $year = '2' . $year;
        } // if

        if (!checkdate($month, $day, $year)) {
            $this->errors = getLanguageText('sys0040'); // 'This is not a valid date'
            return false;
        } else {
            if (strlen($day) < 2) {
                $day = '0' . $day; // add leading zero
            } // if
            if (strlen($month) < 2) {
                $month = '0' . $month; // add leading zero
            } // if
            $this->internaldate = $year . '-' . $month . '-' . $day;
            return $this->internaldate;
        } // if

        return;

    } // verifyDate

    // ****************************************************************************
    function verifyTime ($hours, $minutes, $seconds)
    {
        if ($hours > 24) {
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

        // input may be 'yyyy-mm-dd' or 'yyyymmdd', so
        // check the length and process accordingly
        $len = strlen($input);

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
                    $monthnum = (int)$regs[2];
                    $this->externaldate = "$regs[3] $monthalpha[$monthnum] $regs[1]";
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0046'); // Invalid date format: expected 'yyyymmdd
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
                    $monthnum = (int)$regs[3];
                    $this->externaldate = "$regs[5] $monthalpha[$monthnum] $regs[1]";
                    return $this->externaldate;
                } // if
            } // if

            $this->errors = getLanguageText('sys0047'); // Invalid date format: expected 'dd-mm-yyyy'
            return false;
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
    function getErrors ()
    {
        return $this->errors;

    } // getErrMsg

// ****************************************************************************
} // end date_class
// ****************************************************************************

?>