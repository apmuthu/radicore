<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.tree_view2.popup.inc

// type = tree view 2 popup

// This will list nodes in a tree structure where the tables involved are:
// TREE_TYPE -> TREE_LEVEL -> TREE_NODE
// Each node belogs to a particular TYPE and LEVEL.
// A node can have only one parent but many children.
// The tree_type to be displayed will be passed in $selection.

// add extra buttons to action bar
$act_buttons['choose']     = 'choose';
$act_buttons['choosenull'] = 'choosenull';

require 'std.tree_view2.inc';           // activate page controller

?>
