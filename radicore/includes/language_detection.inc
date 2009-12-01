<?php
/*
Script Name: Full User Agent language detection
Author: Harald Hope, Website: http://techpatterns.com/
Script Source URI: http://techpatterns.com/downloads/php_language_detection.php
Version 0.3.2
Copyright (C) 09 March 2005

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

Lesser GPL license text:
http://www.gnu.org/licenses/lgpl.txt

Coding conventions:
http://cvs.sourceforge.net/viewcvs.py/phpbb/phpBB2/docs/codingstandards.htm?rev=1.3
*/
/******************************************
this will return an array composed of a 4 item array for each language the os supports
1. full language abbreviation, like en-ca
2. primary language, like en
3. full language string, like English (Canada)
4. primary language string, like English
*******************************************/
//
//*************************************************
// This version modified by A J Marston, July 2005
//             and again by A J Marston, July 2008
//*************************************************
function get_languages($input)
{
	// change underscore to hyphen
    $input = str_replace('_', '-', strtolower($input));

	// get the languages (now moved to file 'sys.language_array.inc')
	$a_languages = getLanguageArray('languages');
	$index = '';
	$complete = '';
	$found = false;  // set to default value

	$user_languages = array();

	// check to see if language is set
	if (!empty($input)) {
		// explode languages into array
		$languages = strtolower($input);
		$languages = explode( ",", $languages );
		foreach ($languages as $language_list) {
			// pull out the language, place languages into array of full and primary string structure:
			$temp_array = array();
			// slice out the part before ; on first step, the part before - on second, place into array
			$temp_array[0] = substr( $language_list, 0, strcspn( $language_list, ';' ) );//full language
			$temp_array[1] = substr( $language_list, 0, 2 );// cut out primary language
			// place this array into main $user_languages array
			$user_languages[] = $temp_array;
		} // foreach
		// extract language details from array
		foreach ($user_languages as $key => $user_language) {
		    if (array_key_exists($user_language[0], $a_languages)) {
		    	$complete = $a_languages[$user_language[0]];
		    } elseif (array_key_exists($user_language[1], $a_languages)) {
		        $complete = $a_languages[$user_language[1]];
		    } // if
		    if (!empty($complete)) {
		        // insert complete language, like 'english (canada)'
		    	$user_languages[$key][2] = $complete;
		    	// insert working language, like 'english'
				$user_languages[$key][3] = substr( $complete, 0, strcspn( $complete, ' (' ) );
		    } // if
		} // foreach

	} else {
	    // no langages found, so set default
		$user_languages[0] = array( 'en-gb','en','English (United Kingdom)','English' );
	} // if

	return $user_languages;

} // get_languages

function rdc_setLocale ($language_string)
// set the locale according to the language string.
{
    $locale_array = array();

    if (preg_match('#\w+#', $language_string, $regs)) {
        // language is first word
        $language = $regs[0];
    } // if
    if (preg_match('#\((.+?)\)#', $language_string, $regs)) {
        // country name is enclosed in '(' and ')'
        $country_name = trim($regs[0], '()');
        $locale_array[] = $country_name;
        $locale_array[] = $language ."_$country_name";
        $locale_array[] = $language ."_$country_name.1252";
        $locale_array[] = $language ."_$country_name.UTF-8";
        $locale_array[] = $language ."_$country_name.ISO-8859-1";
        $locale_array[] = $language ." ($country_name)";
        $locale_array[] = $language ." ($country_name).1252";
        $locale_array[] = $language ." ($country_name).UTF-8";
        $locale_array[] = $language ." ($country_name).ISO-8859-1";
    } // if
    $locale_array[] = $language;

    if (preg_match('#\[(.+?)\]#', $language_string, $regs)) {
        // country code is enclosed in '[' and ']'
        $country_code = trim($regs[0], '[]');
        $locale_array[] = $country_code;
        $locale_array[] = $country_code.'.UTF-8';
        $locale_array[] = $country_code.'.1252';
        $locale_array[] = $country_code.'.ISO-8859-1';
        if (strlen($country_code) == 2) {
            // change 'xx' into 'xx_XX'
            if ($country_code == 'en') {
            	$country_code .= '_GB';  // instead of 'en_EN'
            } else {
                $country_code .= '_' .strtoupper($country_code);
            } // if
        	$locale_array[] = $country_code;
            $locale_array[] = $country_code.'.UTF-8';
            $locale_array[] = $country_code.'.1252';
            $locale_array[] = $country_code.'.ISO-8859-1';
        } // if
    } // if

    $locale = setLocale(LC_ALL, $locale_array);

    return $locale;

} // rdc_setLocale

?>