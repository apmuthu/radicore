<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list2.popup.inc

// type = list2 popup

// This will list rows of MANY in a ONE-to-MANY relationship, with a CHOOSE button
// The primary key of ONE will be passed in $where from the previous screen.

// add 'choose' button to action bar
$act_buttons['choose'] = 'CHOOSE';

require 'std.list2.inc';              // activate page controller

?>
