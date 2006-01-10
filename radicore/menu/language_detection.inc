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
//*************************************************
function get_languages()
{
	// get the languages (now moved to file 'sys.language_array.inc'
	$a_languages = getLanguageArray('languages');
	$index = '';
	$complete = '';
	$found = false;// set to default value
	//prepare user language array
	$user_languages = array();

	//check to see if language is set
	if ( isset( $_SERVER["HTTP_ACCEPT_LANGUAGE"] ) )
	{
		//explode languages into array
		$languages = strtolower( $_SERVER["HTTP_ACCEPT_LANGUAGE"] );
		$languages = explode( ",", $languages );
		//$languages = explode( ",", $test);// this is for testing purposes only
		foreach ( $languages as $language_list )
		{
			// pull out the language, place languages into array of full and primary
			// string structure:
			$temp_array = array();
			// slice out the part before ; on first step, the part before - on second, place into array
			$temp_array[0] = substr( $language_list, 0, strcspn( $language_list, ';' ) );//full language
			$temp_array[1] = substr( $language_list, 0, 2 );// cut out primary language
			//place this array into main $user_languages language array
			$user_languages[] = $temp_array;
		} // foreach

		//start going through each one
		for ( $i = 0; $i < count( $user_languages ); $i++ )
		{
			foreach ( $a_languages as $index => $complete )
			{
				if ( $index == $user_languages[$i][0] )
				{
					// complete language, like english (canada)
					$user_languages[$i][2] = $complete;
					// extract working language, like english
					$user_languages[$i][3] = substr( $complete, 0, strcspn( $complete, ' (' ) );
				} // if
			} // foreach
		} // for
	} else {
	    // no langages found
		$user_languages[0] = array( '','','','' ); //return blank array.
	} // if

	// return parameters
	return $user_languages;

} // get_languages

?>