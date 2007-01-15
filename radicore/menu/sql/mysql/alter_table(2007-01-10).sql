INSERT INTO mnu_pattern VALUES ('OTHER', 'Other - Miscellaneous - Undefined', 'This is for anything whch does not fall into any recognisable category.', 'N', 'N', 'N', '2007-01-10 18:21:02', 'AJM', NULL, NULL);

UPDATE mnu_task SET pattern_id='OTHER' WHERE task_id='date(current)';
UPDATE mnu_task SET pattern_id='OTHER' WHERE task_id='date(future)';
UPDATE mnu_task SET pattern_id='OTHER' WHERE task_id='date(historic)';


