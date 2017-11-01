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
//***************************************************
// This version modified by A J Marston, July 2005
//             and again by A J Marston, July 2008
//             and again by A J Marston, October 2017
//***************************************************
function get_user_languages($input)
{
	// change underscore to hyphen
    $input = str_replace('_', '-', strtolower($input));

	$a_languages = load_language_data();  // get the list of possible languages codes
	$index = '';
	$complete = '';
	$found = false;  // set to default value

	$user_languages = array();

	// check to see if language is set
	if (!empty($input)) {
		// explode languages into array
		$languages = strtolower($input);
        $languages = str_replace( ' ', '', $languages );  // remove spaces to avoid error
		$languages = explode( ",", $languages );
		foreach ($languages as $language_list) {
			// pull out the language, place languages into array of full and primary string structure:
			$temp_array = array();
			// slice out the part before ; on first step, the part before - on second, place into array
			$temp_array[0] = substr( $language_list, 0, strcspn( $language_list, ';' ) ); //full language
			$temp_array[1] = substr( $language_list, 0, 2 ); // cut out primary language
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

} // get_user_languages

function load_language_data()
// return the list of possible languages codes.
{
    // important note: you must have the default language as the last item in each major language,
    // so that 'en' would appear after all the 'en-??' entries.

    // the values enclosed in '[' and ']' are the equivalent locale names
    $languages =  array('af' => 'Afrikaans [af]',
                        'sq' => 'Albanian [sq]',
                        'am' => 'Amharic [am]',
                        'ar-dz' => 'Arabic (Algeria) [ar_DZ]',
                        'ar-bh' => 'Arabic (Bahrain) [ar_BH]',
                        'ar-eg' => 'Arabic (Egypt) [ar_EG]',
                        'ar-iq' => 'Arabic (Iraq) [ar_IQ]',
                        'ar-jo' => 'Arabic (Jordan) [ar_JO]',
                        'ar-kw' => 'Arabic (Kuwait) [ar_KW]',
                        'ar-lb' => 'Arabic (Lebanon) [ar_LB]',
                        'ar-ly' => 'Arabic (libya) [ar_LY]',
                        'ar-ma' => 'Arabic (Morocco) [ar_MA]',
                        'ar-om' => 'Arabic (Oman) [ar_OM]',
                        'ar-qa' => 'Arabic (Qatar) [ar_QA]',
                        'ar-sa' => 'Arabic (Saudi Arabia) [ar_SA]',
                        'ar-sy' => 'Arabic (Syria) [ar_SY]',
                        'ar-tn' => 'Arabic (Tunisia) [ar_TN]',
                        'ar-ae' => 'Arabic (U.A.E.) [ar_AE]',
                        'ar-ye' => 'Arabic (Yemen) [ar_YE]',
                        'ar' => 'Arabic [ar]',
                        'hy' => 'Armenian [hy]',
                        'as' => 'Assamese [as]',
                        'az' => 'Azeri [az]',
                        'eu' => 'Basque [es_EU]',
                        'be' => 'Belarusian [be_BE]',
                        'bn' => 'Bengali [bn]',
                        'bs' => 'Bosnian [bs]',
                        'bg' => 'Bulgarian [bg]',
                        'my' => 'Burmese [my]',
                        'ca' => 'Catalan [es_CA]',
                        'zh-cn' => 'Chinese (China) [zh_CN]',
                        'zh-hk' => 'Chinese (Hong Kong SAR) [zh_HK]',
                        'zh-mo' => 'Chinese (Macau SAR) [zh_MO]',
                        'zh-sg' => 'Chinese (Singapore) [zh_SG]',
                        'zh-tw' => 'Chinese (Taiwan) [zh_TW]',
                        'zh' => 'Chinese [zh]',
                        'hr' => 'Croatian [hr]',
                        'cs' => 'Chech [cs]',
                        'da' => 'Danish [da]',
                        'div' => 'Divehi [div]',
                        'nl-be' => 'Dutch (Belgium) [nl_BE]',
                        'nl' => 'Dutch (Netherlands) [nl]',
                        'en-au' => 'English (Australia) [en_AU]',
                        'en-bz' => 'English (Belize) [en_BR]',
                        'en-ca' => 'English (Canada) [en_CA]',
                        'en-cb' => 'English (Caribbean) [en_CB]',
                        'en-in' => 'English (India) [en_IN]',
                        'en-ie' => 'English (Ireland) [en_IE]',
                        'en-jm' => 'English (Jamaica) [en_JM]',
                        'en-nz' => 'English (New Zealand) [en_NZ]',
                        'en-ph' => 'English (Philippines) [en_PH]',
                        'en-za' => 'English (South Africa) [en_ZA]',
                        'en-tt' => 'English (Trinidad) [en_TT]',
                        'en-gb' => 'English (United Kingdom) [en_GB]',
                        'en-us' => 'English (United States) [en_US]',
                        'en-zw' => 'English (Zimbabwe) [en_ZW]',
                        'en' => 'English [en]',
                        'us' => 'English (United States) [en_US]',
                        'et' => 'Estonian [et]',
                        'fo' => 'Faeroese [fo]',
                        'fa' => 'Farsi [fa]',
                        'fi' => 'Finnish [fi]',
                        'fr-be' => 'French (Belgium) [fr_BE]',
                        'fr-ca' => 'French (Canada) [fr_CA]',
                        'fr-lu' => 'French (Luxembourg) [fr_LU]',
                        'fr-mc' => 'French (Monaco) [fr_MC]',
                        'fr-ch' => 'French (Switzerland) [fr_CH]',
                        'fr' => 'French (France) [fr]',
                        'mk' => 'FYRO Macedonian [mk]',
                        'gd' => 'Gaelic [gd]',
                        'ka' => 'Georgian [ka]',
                        'de-at' => 'German (Austria) [de_AT]',
                        'de-li' => 'German (Liechtenstein) [de_LI]',
                        'de-lu' => 'German (luxembourg) [de_LU]',
                        'de-ch' => 'German (Switzerland) [de_CH]',
                        'de' => 'German (Germany) [de]',
                        'el' => 'Greek [el]',
                        'gn' => 'Guarani (Paraguay) [gn]',
                        'gu' => 'Gujarati [gu]',
                        'he' => 'Hebrew [he]',
                        'hi' => 'Hindi [hi]',
                        'hu' => 'Hungarian [hu]',
                        'is' => 'Icelandic [is]',
                        'id' => 'Indonesian [id]',
                        'it-ch' => 'Italian (Switzerland) [it_CH]',
                        'it' => 'Italian (Italy) [it]',
                        'ja' => 'Japanese [ja]',
                        'kn' => 'Kannada [kn]',
                        'kk' => 'Kazakh [kk]',
                        'kok' => 'Konkani [kk]',
                        'ko' => 'Korean [ko]',
                        'kz' => 'Kyrgyz [kz]',
                        'lo' => 'Lao [lo]',
                        'la' => 'Latin [la]',
                        'lv' => 'Latvian [lv]',
                        'lt' => 'Lithuanian [lt]',
                        'ms-bn' => 'Malay (Brunei) [ms_BN]',
                        'ms-my' => 'Malay (Malaysia) [ms_MY]',
                        'ms' => 'Malay [ms]',
                        'ml' => 'Malayalam [ml]',
                        'mt' => 'Maltese [mt]',
                        'mi' => 'Maori [mi]',
                        'mr' => 'Marathi [mr]',
                        'mn' => 'Mongolian (Cyrillic) [mn]',
                        'ne' => 'Nepali (India) [ne]',
                        'nb-no' => 'Norwegian (Bokmal) [nb_NO]',
                        'nn-no' => 'Norwegian (Nynorsk) [nn_NO]',
                        'no' => 'Norwegian (Bokmal) [no]',
                        'or' => 'Oriya [or]',
                        'pl' => 'Polish [pl]',
                        'pt-br' => 'Portuguese (Brazil) [pt_BR]',
                        'pt' => 'Portuguese (Portugal) [pt]',
                        'pa' => 'Punjabi [pa]',
                        'rm' => 'Rhaeto-Romanic [rm]',
                        'ro-md' => 'Romanian (Moldova) [ro_MD]',
                        'ro' => 'Romanian [ro]',
                        'ru-md' => 'Russian (Moldova) [ru_MD]',
                        'ru' => 'Russian [ru]',
                        'sa' => 'Sanskrit [sa]',
                        'sr' => 'Serbian[sr]',
                        'sd' => 'Sindhi [sd]',
                        'si' => 'Sinhala [si]',
                        'sk' => 'Slovak [sk]',
                        'ls' => 'Slovenian [ls]',
                        'so' => 'Somali [so]',
                        'sb' => 'Sorbian [sb]',
                        'es-ar' => 'Spanish (Argentina) [es_AR]',
                        'es-bo' => 'Spanish (Bolivia) [es_BO]',
                        'es-cl' => 'Spanish (Chile) [es_CL]',
                        'es-co' => 'Spanish (Colombia) [es_CO]',
                        'es-cr' => 'Spanish (Costa Rica) [es_CR]',
                        'es-do' => 'Spanish (Dominican Republic) [es_DO]',
                        'es-ec' => 'Spanish (Ecuador) [es_EC]',
                        'es-sv' => 'Spanish (El Salvador) [es_SV]',
                        'es-gt' => 'Spanish (Guatemala) [es_GT]',
                        'es-hn' => 'Spanish (Honduras) [es_HN]',
                        'es-mx' => 'Spanish (Mexico) [es_MX]',
                        'es-ni' => 'Spanish (Nicaragua) [es_NI]',
                        'es-pa' => 'Spanish (Panama) [es_PA]',
                        'es-py' => 'Spanish (Paraguay) [es_PY]',
                        'es-pe' => 'Spanish (Peru) [es_PE]',
                        'es-pr' => 'Spanish (Puerto Rico) [es_PR]',
                        'es-us' => 'Spanish (United States) [es_US]',
                        'es-uy' => 'Spanish (Uruguay) [es_UY]',
                        'es-ve' => 'Spanish (Venezuela) [es_VE]',
                        'es' => 'Spanish (Spain) [es]',
                        'sx' => 'Sutu [sx]',
                        'sw' => 'Swahili [sw]',
                        'sv-fi' => 'Swedish (Finland) [sv_FI]',
                        'sv' => 'Swedish [sv]',
                        'syr' => 'Syriac [syr]',
                        'tg' => 'Tajik [tg]',
                        'ta' => 'Tamil [ta]',
                        'tt' => 'Tatar [tt]',
                        'te' => 'Telugu [te]',
                        'th' => 'Thai [th]',
                        'bo' => 'Tibetan [bo]',
                        'ts' => 'Tsonga [ts]',
                        'tn' => 'Tswana [tn]',
                        'tr' => 'Turkish [tr]',
                        'tk' => 'Turkmen [tk]',
                        'uk' => 'Ukrainian [uk]',
                        'ur' => 'Urdu [ur]',
                        'uz' => 'Uzbek [uz]',
                        'vi' => 'Vietnamese [vi]',
                        'cy' => 'Welsh [cy]',
                        'xh' => 'Xhosa [xh]',
                        'yi' => 'Yiddish [yi]',
                        'zu' => 'Zulu [zu]' );

    return $languages;

} // load_language_data

// ****************************************************************************
function getBrowserLanguage ($directory)
// find a subdirectory which corresponds with a language defined in the browser.
{
    if (!isset($_SESSION['user_language_array'])) {
        if (empty($_SERVER["HTTP_ACCEPT_LANGUAGE"])) {
            return FALSE;  //not available, so cannot continue
        } else {
            // obtain language code from browser settings
            $_SESSION['user_language_array'] = get_user_languages($_SERVER["HTTP_ACCEPT_LANGUAGE"]);
        } // if
    } // if

    $found = array();
    if (is_dir($directory)) {
        // build an array of subdirectory names for specified $directory
        $dir = dir($directory);
        while (false !== ($entry = $dir->read())) {
            if ($entry == '.' or $entry == '..') {
                // ignore
            } else {
                if (is_dir("$directory/$entry")) {
                   $found[] = $entry;
                } // if
            } // if
        } // if
        $dir->close();
    } // if

    if (!empty($found)) {
        if (isset($_SESSION['user_language_array'])) {
            // scan $user_language_array looking for a matching entry
            $found_lang = matchBrowserLanguage ($_SESSION['user_language_array'], $found);
            if (!empty($found_lang)) {
                return $found_lang;
            } // if
        } // if
    } // if

    return FALSE;

} // getBrowserLanguage

// ****************************************************************************
function matchBrowserLanguage ($browser_array, $language_array)
// find first entry in $browser_array which has an entry in $language_array.
{
    if (is_array($browser_array)) {
        foreach ($browser_array as $browser_language) {
            // look for full language abbreviation (after replacing hyphen with underscore)
            $test_language = str_replace('-', '_', strtolower($browser_language[0]));
            foreach ($language_array as $supported_language) {
                $supported_language = str_replace('-', '_', $supported_language);
                if ($test_language == strtolower($supported_language)) {
                    return $test_language;
                } // if
            } // foreach
            // look for primary language (after replacing hyphen with underscore)
            $test_language = str_replace('-', '_', strtolower($browser_language[1]));
            foreach ($language_array as $supported_language) {
                $supported_language = str_replace('-', '_', $supported_language);
                if ($test_language == strtolower($supported_language)) {
                    return $test_language;
                } // if
            } // foreach
        } // foreach
    } // if

    return false;

} // matchBrowserLanguage

// ****************************************************************************
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

// ****************************************************************************
function saveLocaleFormat ($language, $user_language_array=null)
// store locale data based on user's preferred language.
{
    if (empty($user_language_array)) {
        $user_language_array = get_user_languages($language);
    } // if

    $locale = rdc_setLocale($user_language_array[0][2]);

    $localeconv = localeconv();
    if ($localeconv['thousands_sep'] == chr(160)) {
        // change non-breaking space into ordinary space
        $localeconv['thousands_sep'] = chr(32);
    } // if

    $GLOBALS['localeconv']['decimal_point'] = $localeconv['decimal_point'];
    $GLOBALS['localeconv']['thousands_sep'] = $localeconv['thousands_sep'];
    $GLOBALS['localeconv']['p_cs_precedes'] = $localeconv['p_cs_precedes'];
    $GLOBALS['localeconv']['n_cs_precedes'] = $localeconv['n_cs_precedes'];
    //$GLOBALS['localeconv']['currency_symbol'] = $localeconv['currency_symbol'];

    // set to locale where decimal point is '.' (as used internally)
    $internal_locale = rdc_setLocale("English (United Kingdom) [en_GB]");

    return $locale;

} // saveLocaleFormat

?>