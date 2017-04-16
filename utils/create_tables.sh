#!/usr/bin/bash

mysql

-- tables

USE audit;
source /var/www/webroot/radicore/audit/sql/mysql/audit-schema.sql
USE dict;
source /var/www/webroot/radicore/dict/sql/mysql/dict-schema.sql
USE menu;
source /var/www/webroot/radicore/menu/sql/mysql/menu-schema.sql
USE workflow;
source /var/www/webroot/radicore/workflow/sql/mysql/workflow-schema.sql

USE classroom;
source /var/www/webroot/radicore/classroom/sql/mysql/classroom-schema.sql
USE product;
source /var/www/webroot/radicore/product/sql/mysql/product-schema.sql
USE survey;
source /var/www/webroot/radicore/survey/sql/mysql/survey-schema.sql
USE xample;
source /var/www/webroot/radicore/xample/sql/mysql/xample-schema.sql

-- data

-- No audit-data.sql

USE dict;
source /var/www/webroot/radicore/dict/sql/mysql/dict-data.sql
USE menu;
source /var/www/webroot/radicore/menu/sql/mysql/menu-data.sql
source /var/www/webroot/radicore/menu/sql/mysql/mnu-user.sql
USE workflow;
source /var/www/webroot/radicore/workflow/sql/mysql/workflow-data.sql

USE classroom;
source /var/www/webroot/radicore/classroom/sql/mysql/classroom-data.sql
USE product;
source /var/www/webroot/radicore/product/sql/mysql/product-data.sql
USE survey;
source /var/www/webroot/radicore/survey/sql/mysql/survey-data.sql
USE xample;
source /var/www/webroot/radicore/xample/sql/mysql/xample-data.sql

-- Dict and Menu import of exported data for prototypes
USE dict;
source /var/www/webroot/radicore/classroom/sql/classroom.dict_export.sql
source /var/www/webroot/radicore/product/sql/product.dict_export.sql
source /var/www/webroot/radicore/survey/sql/survey.dict_export.sql
source /var/www/webroot/radicore/xample/sql/xample.dict_export.sql
USE menu;
source /var/www/webroot/radicore/classroom/sql/crss.menu_export.sql
source /var/www/webroot/radicore/product/sql/product.menu_export.sql
source /var/www/webroot/radicore/survey/sql/survey.menu_export.sql
source /var/www/webroot/radicore/xample/sql/xample.menu_export.sql

quit

