ALTER TABLE `wf_case` ADD `rdcaccount_id` INT( 11 ) UNSIGNED NOT NULL DEFAULT '1' FIRST ;
ALTER TABLE `wf_case` ADD INDEX ( `rdcaccount_id` ) ;

ALTER TABLE `wf_token` ADD `rdcaccount_id` INT( 11 ) UNSIGNED NOT NULL DEFAULT '1' FIRST ;
ALTER TABLE `wf_token` ADD INDEX ( `rdcaccount_id` ) ;

ALTER TABLE `wf_workitem` ADD `rdcaccount_id` INT( 11 ) UNSIGNED NOT NULL DEFAULT '1' FIRST ;
ALTER TABLE `wf_workitem` ADD INDEX ( `rdcaccount_id` ) 
