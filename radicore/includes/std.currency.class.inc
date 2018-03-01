<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class currency_class
{
    var $func_currency;         // currency of issuing party
    var $func_scale;            // scale of amounts in $func_currency
    var $tran_currency;         // currency of receiving party
    var $tran_scale;            // scale of amounts in $tran_currency
    var $exchange_rate;         // exchange rate from $func_currency to $tran_currency

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // nothing here

        return;

    } // __construct

    // ****************************************************************************
    function flip_currency($fieldarray, $columns, $fn_suffix='_fn', $tx_suffix='_tx')
    // flip values between two currencies for one or more columns
    // $fieldarray = associative array containing current data
    // $columns = an array of column names with the scale value
    // $fn_suffix = column suffix for values in home/functional currency
    // $tx_suffix = column suffix for values in transaction currency
    {
        $pattern_id = getPatternId();

        if (empty($this->exchange_rate)) $this->exchange_rate = 1;

        if (!isset($_SESSION['display_foreign_currency']) OR $_SESSION['display_foreign_currency'] === false) {
            // all values are displayed in functional currency
            $fieldarray['currency_code_v1'] = $this->func_currency;
            foreach ($columns as $name => $scale) {
                $name_fn = $name.$fn_suffix;
                $name_tx = $name.$tx_suffix;
                if (!array_key_exists($name_fn, $fieldarray)) {
                    $fieldarray[$name_fn] =& $fieldarray[$name];  // "<name>_fn" not found, so copy from "<name>"
                } // if
                if (empty($fieldarray[$name_fn]) AND !empty($fieldarray[$name_tx])) {
                    // convert to functional currency from transaction currency
                    $fieldarray[$name_fn] = $this->_convert($fieldarray[$name_tx], 1/$this->exchange_rate, $scale, $this->func_scale);
                } else {
                    $fieldarray[$name_fn] = (double)number_unformat($fieldarray[$name_fn]);
                } // if
                $fieldarray[$name_fn] = number_format($fieldarray[$name_fn], $scale, '.', '');
                if (preg_match('/(list)/i', $pattern_id)) {
                    // for LIST forms apppend the currency code to the value
                    if ($fieldarray[$name] == 0) {
                        $fieldarray[$name] = '0 '.$this->func_currency;
                    } else {
                        $fieldarray[$name] = $fieldarray[$name_fn].' '.$this->func_currency;
                    } // if
                } else {
                    // for other forms display the currency code in a separate field (currency_code_v1)
                    $fieldarray[$name]     = $fieldarray[$name_fn];
                } // if
            } // foreach
        } else {
            // all values are displayed in transaction currency
            $fieldarray['currency_code_v1'] = $this->tran_currency;
            foreach ($columns as $name => $scale) {
                $name_tx = $name.$tx_suffix;
                if (preg_match('/(add)/i', $pattern_id)) {
                    // do not change any input values
                } else {
                    // strip out any thousands separator
                    $value_tx = (double)number_unformat($fieldarray[$name_tx]);
                    $value    = (double)number_unformat($fieldarray[$name]);
                    if (!empty($value_tx) AND $value_tx <> 0) {
                        // use value as input
                        $value_tx = number_format($value_tx, $scale, '.', '');
                        $fieldarray[$name] = $value_tx;
                    } elseif (!empty($value)) {
                        // convert to transaction currency from functional currency
                        $value = $this->_convert($value, $this->exchange_rate, $scale, $this->tran_scale);
                        $fieldarray[$name] = $value;
                    } // if
                    if (preg_match('/(list)/i', $pattern_id)) {
                        if ($fieldarray[$name] == 0) {
                            $fieldarray[$name] = '0 '.$this->tran_currency;
                        } else{
                            // for LIST forms append the currency code to the value
                            $fieldarray[$name] = $fieldarray[$name].' '.$this->tran_currency;
                        } // if
                    } // if
                } // if
            } // foreach
        } // if

        return $fieldarray;

    } // flip_currency

    // ****************************************************************************
    function _convert($value, $exchange_rate, $scale1, $scale2)
    // convert value using supplied exchange rate, then format using scale
    // $scale1 = default scale
    // $scale2 = alternative scale
    {
        $value = number_unformat($value);
        $value = $value * $exchange_rate;

        if (is_numeric($scale2)) {
            if ($scale2 == $scale1) {
                // no rounding necessary
            } else {
                $temp = round($value, $scale2);
                $value = $temp;
            } // if
        } // if

        $value = number_format($value, $scale1, '.', '');

        return $value;

    } // _convert

} // class: currency_class
?>
