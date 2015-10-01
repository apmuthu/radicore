<?PHP
/*The contents of this document are free for use by anyone for any purpose they choose.
no warranty is implied, nor will one be honored.  The author assumes no liability for
any consequences that may arise from the use of contents of this document.  Events not
covered include but are not limited to: system crashes, system slowdown, system failure,
fires, explosions, floods, earthquakes, boiling seas, intestinal inflammation, cold coffee,
and total protonic inversion.
Any questions, comments, or improvements are appreciated and can be directed to:

Tim Thorpe
blushift@netins.net
*/

/*
This script implements the 56-bit DES encryption algorithm,
created from scratch based on interpretation of the original
specification document.

des_encrypt_ecb("my key", "my text");
and
mcrypt_ecb (MCRYPT_DES, "my key", "my text", MCRYPT_ENCRYPT, str_pad("", 8, chr(0x00)));
are functionally identical.

Because PHP is lacking in bitwise operators, this set of routines
makes use of data that has been expanded so that a byte becomes an 8-byte string.

The script performs the transformations, and then condenses the data back to a usable form.
Apologies for a lack of comments in the bulk of the functions.
*/////////////////////////////////////////////////////////////////////////////

function des_encrypt_ecb($key, $clearText) {
//Function to implement Electronic Code Book encoding
//I haven't had occasion to add any other methods or a decoder for that matter,
//but all of the underlying functions were written to be universal to all encoding methods,
//so adding other methods should be easy if you need them.

    if (strlen($key) < 7)
        $key = str_pad(substr($key, 0, 7), 7, chr(0x00));  //We need 7 bytes for a key; no more, no less
        
    if (strlen($key) == 7) $key = des_add_parity($key);
	
	$keys = des_make_subkeys (des_bits_to_bytes ($key));  //Chew the key into the subkeys needed for DES
	$blockCount = (int) (strlen($clearText) / 8);  //Figure out how many blocks of 8 bytes we need to encode
	if (strlen ($clearText) % 8) {  //Check to see if there are any leftovers
		$blockCount++;  //Add another block for them
		$clearText = str_pad($clearText, $blockCount * 8, chr(0x00));  //Pad it out with zeroes
	}
	for ($i = 0; $i < $blockCount; $i++) {  //Cycle through the blocks
		$clearBlock = substr($clearText, $i * 8, 8);  //Grab a block from the input
		$cypherBlock = des_block_encode(des_bits_to_bytes ($clearBlock), $keys);  //Encrypt it
		$cypherText .= des_bytes_to_bits ($cypherBlock);  //Convert the result back to a useful form
	}
	return ($cypherText);  //Cough it up
}

function des_block_encode($clearText, $subKeys) {
	$ip_table = array(58, 50, 42, 34, 26, 18, 10,  2,
			  60, 52, 44, 36, 28, 20, 12,  4,
			  62, 54, 46, 38, 30, 22, 14,  6,
			  64, 56, 48, 40, 32, 24, 16,  8,
			  57, 49, 41, 33, 25, 17,  9,  1,
			  59, 51, 43, 35, 27, 19, 11,  3,
			  61, 53, 45, 37, 29, 21, 13,  5,
			  63, 55, 47, 39, 31, 23, 15,  7);

	$ip1_table = array(40,  8, 48, 16, 56, 24, 64, 32,
			   39,  7, 47, 15, 55, 23, 63, 31,
			   38,  6, 46, 14, 54, 22, 62, 30,
			   37,  5, 45, 13, 53, 21, 61, 29,
			   36,  4, 44, 12, 52, 20, 60, 28,
			   35,  3, 43, 11, 51, 19, 59, 27,
			   34,  2, 42, 10, 50, 18, 58, 26,
			   33,  1, 41,  9, 49, 17, 57, 25);

	foreach ($ip_table as $bit) {
		$ip .= $clearText[$bit - 1];
	}
	$l[0] = substr($ip, 0, 32);
	$r[0] = substr($ip, 32);
	for ($index = 1; $index <= 16; $index++) {
		$l[$index] = $r[$index - 1];
		$r[$index] = des_xor($l[$index - 1], des_transform($r[$index - 1], $subKeys[$index]));
	}

	foreach ($ip1_table as $bit) {
		$concat	= $r[16] . $l[16];
		$cypherBlock .= $concat[$bit - 1];
	}
	return ($cypherBlock);
}

function des_make_subkeys($key) {
	$pc1 = array(57, 49, 41, 33, 25, 17,  9,
		      1, 58, 50, 42, 34, 26, 18,
		     10,  2, 59, 51, 43, 35, 27,
		     19, 11,  3, 60, 52, 44, 36,
		     63, 55, 47, 39, 31, 23, 15,
		      7, 62, 54, 46, 38, 30, 22,
		     14,  6, 61, 53, 45, 37, 29,
		     21, 13,  5, 28, 20, 12,  4);

	$pc2 = array(14, 17, 11, 24,  1,  5,
		      3, 28, 15,  6, 21, 10,
		     23, 19, 12,  4, 26,  8,
		     16,  7, 27, 20, 13,  2,
		     41, 52, 31, 37, 47, 55,
		     30, 40, 51, 45, 33, 48,
		     44, 49, 39, 56, 34, 53,
		     46, 42, 50, 36, 29, 32);

	$shifts = array(1, 1, 2, 2,
			2, 2, 2, 2,
			1, 2, 2, 2,
			2, 2, 2, 1);
	foreach ($pc1 as $bit) {
		$k .= $key[$bit - 1];
	}
	$index = 0;
	$c[$index] = substr($k, 0, 28);
	$d[$index] = substr($k, 28);
	unset ($k);
	foreach ($shifts as $positions) {
		$index++;
		$c[$index] = des_rotate_left ($c[$index - 1], $positions);
		$d[$index] = des_rotate_left ($d[$index - 1], $positions);
	}
	for ($i = 1; $i <= 16; $i++) {
		foreach ($pc2 as $bit) {
			$concat = $c[$i] . $d[$i];
			$k[$i] .= $concat[$bit - 1];
		}
	}
	return ($k);
}

function des_transform($data, $key) {
	$e_table = array(32,  1,  2,  3,  4,  5,
			  4,  5,  6,  7,  8,  9,
			  8,  9, 10, 11, 12, 13,
			 12, 13, 14, 15, 16, 17,
			 16, 17, 18, 19, 20, 21,
			 20, 21, 22, 23, 24, 25,
			 24, 25, 26, 27, 28, 29,
			 28, 29, 30, 31, 32,  1);

	$s = array(array(14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7,
			  0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8,
			  4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0,
			 15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13),
		   array(15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10,
			  3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5,
			  0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15,
			 13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9),
		   array(10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8,
			 13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1,
			 13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7,
			  1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12),
		   array( 7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15,
			 13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9,
			 10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4,
			  3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14),
		   array( 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9,
			 14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6,
			  4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14,
			 11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3),
		   array(12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11,
			 10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8,
			  9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6,
			  4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13),
		   array( 4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1,
			 13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6,
			  1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2,
			  6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12),
		   array(13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0,  12,  7,
			  1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2,
			  7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13,  15, 3,  5,  8,
			  2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11));

	$p_table = array(16,  7, 20, 21,
                         29, 12, 28, 17,
                          1, 15, 23, 26,
                          5, 18, 31, 10,
                          2,  8, 24, 14,
                         32, 27,  3,  9,
                         19, 13, 30,  6,
                         22, 11,  4, 25);

	$nybbles = array(chr(0x00).chr(0x00).chr(0x00).chr(0x00), chr(0x00).chr(0x00).chr(0x00).chr(0x01),
			 chr(0x00).chr(0x00).chr(0x01).chr(0x00), chr(0x00).chr(0x00).chr(0x01).chr(0x01),
			 chr(0x00).chr(0x01).chr(0x00).chr(0x00), chr(0x00).chr(0x01).chr(0x00).chr(0x01),
			 chr(0x00).chr(0x01).chr(0x01).chr(0x00), chr(0x00).chr(0x01).chr(0x01).chr(0x01),
			 chr(0x01).chr(0x00).chr(0x00).chr(0x00), chr(0x01).chr(0x00).chr(0x00).chr(0x01),
			 chr(0x01).chr(0x00).chr(0x01).chr(0x00), chr(0x01).chr(0x00).chr(0x01).chr(0x01),
			 chr(0x01).chr(0x01).chr(0x00).chr(0x00), chr(0x01).chr(0x01).chr(0x00).chr(0x01),
			 chr(0x01).chr(0x01).chr(0x01).chr(0x00), chr(0x01).chr(0x01).chr(0x01).chr(0x01));


	foreach ($e_table as $bit) {
		$e .= $data[$bit - 1];
	}
	$ek = des_xor($e, $key);
	for ($i = 0; $i < 8; $i++) {
		$offset = $i * 6;
		$sAddress = ord($ek[$offset]) * 0x20 +
			    ord($ek[$offset + 1]) * 0x08 +
			    ord($ek[$offset + 2]) * 0x04 +
			    ord($ek[$offset + 3]) * 0x02 +
			    ord($ek[$offset + 4]) +
			    ord($ek[$offset + 5]) * 0x10;
		$sResult .= $nybbles[$s[$i][$sAddress]];
	}
	foreach ($p_table as $bit) {
		$p .= $sResult[$bit - 1];
	}
	return ($p);
}

function des_bits_to_bytes($bitStream) {
	for ($i = 0; $i < strlen($bitStream); $i++) {
		$val = ord($bitStream[$i]);
		if ($val & 0x80) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x40) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x20) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x10) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x08) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x04) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x02) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
		if ($val & 0x01) {$byteStream .= chr(0x01);} else {$byteStream .= chr(0x00);}
	}
	return ($byteStream);
}

function des_bytes_to_bits($byteStream) {
	for ($i = 0; $i < (strlen($byteStream) / 8); $i++) {
		$offset	= $i * 8;
		$value = ord($byteStream[$offset]) * 0x80 +
			 ord($byteStream[$offset + 1]) * 0x40 +
			 ord($byteStream[$offset + 2]) * 0x20 +
			 ord($byteStream[$offset + 3]) * 0x10 +
			 ord($byteStream[$offset + 4]) * 0x08 +
			 ord($byteStream[$offset + 5]) * 0x04 +
			 ord($byteStream[$offset + 6]) * 0x02 +
			 ord($byteStream[$offset + 7]);
		$bitStream .= chr($value);

	}
	return ($bitStream);
}

function des_rotate_left($input, $positions) {
	return substr($input, $positions) . substr($input, 0, $positions);
}

function des_xor($a, $b) {
	for ($i = 0; $i < strlen($a); $i++) {
		$xor .= $a[$i] ^ $b[$i];
	}
	return $xor;
}

// DES helper function
// input: 7-Bytes Key without parity
// ouput: 8-Bytes Key with parity
function des_add_parity($key) 
{
    static $odd_parity = array(
        1,  1,  2,  2,  4,  4,  7,  7,  8,  8, 11, 11, 13, 13, 14, 14,
        16, 16, 19, 19, 21, 21, 22, 22, 25, 25, 26, 26, 28, 28, 31, 31,
        32, 32, 35, 35, 37, 37, 38, 38, 41, 41, 42, 42, 44, 44, 47, 47,
        49, 49, 50, 50, 52, 52, 55, 55, 56, 56, 59, 59, 61, 61, 62, 62,
        64, 64, 67, 67, 69, 69, 70, 70, 73, 73, 74, 74, 76, 76, 79, 79,
        81, 81, 82, 82, 84, 84, 87, 87, 88, 88, 91, 91, 93, 93, 94, 94,
        97, 97, 98, 98,100,100,103,103,104,104,107,107,109,109,110,110,
        112,112,115,115,117,117,118,118,121,121,122,122,124,124,127,127,
        128,128,131,131,133,133,134,134,137,137,138,138,140,140,143,143,
        145,145,146,146,148,148,151,151,152,152,155,155,157,157,158,158,
        161,161,162,162,164,164,167,167,168,168,171,171,173,173,174,174,
        176,176,179,179,181,181,182,182,185,185,186,186,188,188,191,191,
        193,193,194,194,196,196,199,199,200,200,203,203,205,205,206,206,
        208,208,211,211,213,213,214,214,217,217,218,218,220,220,223,223,
        224,224,227,227,229,229,230,230,233,233,234,234,236,236,239,239,
        241,241,242,242,244,244,247,247,248,248,251,251,253,253,254,254);

    for ($i = 0; $i < strlen($key); $i++) {
        $bin .= sprintf('%08s', decbin(ord($key{$i})));
    }

    $str1 = explode('-', substr(chunk_split($bin, 7, '-'), 0, -1));
    foreach($str1 as $s) {
        $x .= sprintf('%02s', dechex($odd_parity[bindec($s . '0')]));
    }

    return pack('H*', $x);

}
