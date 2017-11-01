<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list2.popup.inc

// type = list2 popup

// This will list rows of MANY in a ONE-to-MANY relationship, with a CHOOSE button
// The primary key of ONE will be passed in $where from the previous screen.

// add extra buttons to action bar
$act_buttons['choose']     = 'choose';
$act_buttons['choosenull'] = 'choosenull';

require 'std.list2.inc';              // activate page controller

?>
