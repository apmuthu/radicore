# radicore
Tony Marston's Rapid Application Development using PHP and MySQL/Postgres/Oracle/MSSQL - [What](http://www.radicore.org/whatisradicore.php) | [Why](http://www.radicore.org/whyradicore.php) | [Who](http://www.radicore.org/whocanuseradicore.php)

* This is an unofficial mirror of key releases of the Radicore Framework
* [Home](http://www.radicore.org)
* [Forum](http://www.radicore.org/fud/)
* [Downloads](http://www.radicore.org/downloads.php)
* [Documentation](http://www.radicore.org/documentation.php)
* [Demo](http://www.radicore.org/demo.php)
* [Articles](http://www.radicore.org/archive.php?article_type_id=AR)
* [Tutorial](http://www.radicore.org/tutorial.php)
* Example Prototype Applications - [Product](http://www.tonymarston.net/php-mysql/product-prototype.html), [Survey](http://www.tonymarston.net/php-mysql/survey-prototype.html), [Classroom](http://www.tonymarston.net/php-mysql/classroom-prototype.html)
* [PHP Versions](http://www.tonymarston.net/php-mysql/support-for-php4-and-php7.html)
* [Author's Licensing](http://www.radicore.org/licensing.php)

RADICORE is an open source Rapid Application Development Toolkit for building Administrative Web Applications, sometimes known as Enterprise Applications, which are platform, browser and database agnostic.

The project's author has stated that he has no (current) plans to use GitHub and hence the unofficial mirror here. It is based on key releases only. It will be updated only when I have the time. Please use the official links above so as not to fracture the project's access and development.

The (current) purpose of [this repo](https://github.com/apmuthu/radicore) is to enable those who prefer the Git model of development to assist in testing and development, migration and incremental version management by forking the project in an open manner.

* Installation instructions are now contained in file `installation.html` and hence the `readme.txt` file stands removed.
* The readme-<YYYY-MM-DD>.txt file will now be the CHANGELOG file in the root folder.
* All component (and example prototype) versions are in the `version.txt` file in each folder like `audit` | `default` (test) | `dict` | `menu` | `workflow` | `product` | `survey` | `classroom` | `xample`
* Security backdoors and debugging aids (search for `80.177.120.119` in the files - some will be missing in some versions):
  * `menu/index.php`
  * `includes/include.xml.php4.inc`
  * `includes/include.xml.php5.inc`
  * `XMLRPC/allowed_ip_addr.inc`
  * `SOAP/allowed_ip_addr.inc`
* `phpinfo.php` if present (in the webroot of the Radicore installation), [will need to be removed](http://radicore.org/fud/index.php?t=msg&th=2608&goto=6305&#msg_6305) when all installation / debugging is done.
* `includes/config.inc` should not be part of the release but must be copied from `includes/config.inc.default` and edited as needed
* In some versions remove redundant files if they exist, like:
  * `survey/sql/oracle/Copy of survey-data.sql`
  * `htaccess.demo.txt` - keep if `htaccess.txt` is absent
  * `includes/config.copy.inc`
* `.htaccess` file is to be deleted for windows. It is meant for linux only and adjusted as needed
* `htaccess.demo.txt` or `htaccess.txt` is meant to be renamed as `.htaccess` for windows and adjusted as needed
* `includes/config.live.inc` is missing in some releases and is a template for some `includes/config.inc` implementations
* `classroom/sql/crss.menu_export.sql` where present, should actually be named `classroom/sql/classroom.menu_export.sql`
* `xample.menu_export.sql` and `xample.dict_export.sql` are present redundantly in `xample/sql` and `xample/sql/mysql` folders

As GitHub does not like empty folders, the following will need to be created manually:
* `logs`
* `audit/sql/logs`
* `classroom/sql/logs`
* `default/classes/custom-processing`
* `default/reports/custom-processing`
* `default/screens/custom-processing`
* `default/sql/logs`
* `default/sql/mysql`
* `default/sql/oracle`
* `default/sql/postgresql`
* `default/sql/sqlsrv`
* `default/text/custom-processing`
* `dict/sql/logs`
* `includes/tcpdf/cache`
* `menu/sql/logs`
* `product/sql/logs`
* `survey/sql/logs`
* `workflow/sql/log`
* `xample/files/upload`
* `xample/sql/logs`
* `xample/videos`

