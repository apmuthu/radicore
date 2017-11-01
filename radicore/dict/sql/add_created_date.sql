ALTER TABLE `xxxxxx` 
add `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
add `created_user` varchar(16) NOT NULL default 'UNKNOWN',
add `revised_date` datetime default NULL,
add `revised_user` varchar(16) default NULL;