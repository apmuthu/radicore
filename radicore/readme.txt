Unzip the file, but remember to retain the directory structure.

You should end up with this:-

  [DODUMENT_ROOT]
    - radicore
      - audit
      - classroom
      - default
      - dict
      - images
      - includes
      - menu
      - product
      - survey
      - workflow
      - xample
      - xsl

It would be a good idea to move the INCLUDES directory to a point outside the web root if you are going to deploy this on a publicly-accessible web server.

HTACCESS.TXT contains some Apache directives. This can be renamed to .htaccess in a *nix environment, or for Windows you can insert the following lines into your httpd.conf (Apache configuration) file:

  #AccessFileName .htaccess
  AccessFileName htaccess.txt
  #
  # The following lines prevent .htaccess and .htpasswd files from being 
  # viewed by Web clients. 
  #
  #<Files ~ "^\.ht">
  <Files ~ "^htaccess\.">
      Order allow,deny
      Deny from all
  </Files>

The HTACCESS.TXT file should be amended as necessary to define the correct include_path to be used for your installation.

You need to create all the databases and run the supplied sql scripts to load the data, although here is no data in AUDIT.

The only file you need to amend should be CONFIG.INC (in the INCLUDES directory) to specify the username and password for your database. You can rename CONFIG.INC.DEFAULT to CONFIG.INC to provide a starting version.

NOTE: this code will work for both PHP 4 and PHP 5, and (if using a MyQL database) automatically detect if you have loaded the old 'mysql' extension or the new 'mysqli' extension.

To logon for the first time use the following:
User = MGR
Pswd = password (case sensitive)

You can then create your own user id and password.

As well as the RBAC (menu) system, the Audit Logging system, Workflow system and Data Dictionary there are a few prototype applications:

- Example application (based on my smaller sample application)
- Classroom Scheduling system
- Survey/Questonnaire system
- Product database

The DEFAULT directory simply contains an example of the directory structure you should use for any new subsystems, plus some sample scripts for various objects. The file DEFAULT.CLASS.INC is actually used by the Data Dictionary in the export process.

By default all XSL transformations are performed by the server, but if you have a web browser that supports XSLT then you can switch to client-side XSL transformations by adding "csxslt=on" to the URL. This will stay on until is is turned off wih "csxslt=off".

Enjoy!

Tony Marston
http://www.tonymarston.net