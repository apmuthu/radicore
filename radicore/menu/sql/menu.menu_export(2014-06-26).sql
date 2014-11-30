-- USE `menu`;

UPDATE `mnu_pattern` SET `pattern_desc`='TREE1 - List Tree Structure (similar to LIST1)' ,`pattern_long_desc`='This will list nodes in a tree structure and allow the user to expand and contract nodes individually.\n\nThis uses a stand-alone TREE_NODE table.\n\nThis uses the \'getNodeData\' method to retrieve the data for the selected nodes.' ,`revised_date`='2014-06-26 11:28:07' ,`revised_user`='AJM' WHERE pattern_id='TREE1';

UPDATE `mnu_pattern` SET `pattern_desc`='TREE2 - List Tree Structure (similar to LIST2)' ,`pattern_long_desc`='This will list nodes in a tree structure and allow the user to expand and contract nodes individually.\n\nThis uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.\n\nThe TREE_TYPE to be displayed will be passed down by the previous screen.\n\nThis uses the \'getNodeData\' method to retrieve the data for the selected nodes.' ,`revised_date`='2014-06-26 11:28:27' ,`revised_user`='AJM' WHERE pattern_id='TREE2';

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('N' ,'2014-06-26 11:30:07' ,'AJM' ,'N' ,'OUTPUT6 - Output records  from a Tree View to a CSV file' ,'OUTPUT6' ,'This will extract all available rows from a database table in Tree View and output them to a CSV file which will be downloaded to the client device.\n\nIt will use any search criteria that is passed down from the calling screen.' ,'N');
