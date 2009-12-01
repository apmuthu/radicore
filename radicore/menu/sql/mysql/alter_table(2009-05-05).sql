USE `menu`;

CREATE TABLE IF NOT EXISTS `mnu_motd` (
  `motd_id` int(11) unsigned NOT NULL auto_increment,
  `motd_subject` varchar(80) NOT NULL default '',
  `motd_message` text NOT NULL,
  `start_date` date NOT NULL default '2000-01-01',
  `end_date` date default '9999-12-31',
  `role_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`motd_id`)
) TYPE=MyISAM;

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_motd(show)'     
       FROM mnu_role 
      WHERE NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_motd(show)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_motd(list1)'     
       FROM mnu_role 
      WHERE NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_motd(list1)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_motd(search)'     
       FROM mnu_role 
      WHERE NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_motd(search)');

INSERT INTO mnu_role_task (role_id, task_id) 
     SELECT mnu_role.role_id, 'mnu_motd(enq1)'     
       FROM mnu_role 
      WHERE NOT EXISTS (SELECT 1 FROM mnu_role_task AS mrt 
                         WHERE mrt.role_id=mnu_role.role_id AND mrt.task_id='mnu_motd(enq1)');
