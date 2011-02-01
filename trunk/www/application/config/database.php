<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------
| DATABASE CONNECTIVITY SETTINGS
| -------------------------------------------------------------------
| This file will contain the settings needed to access your database.
|
| For complete instructions please consult the 'Database Connection'
| page of the User Guide.
|
| -------------------------------------------------------------------
| EXPLANATION OF VARIABLES
| -------------------------------------------------------------------
|
|	['hostname'] The hostname of your database server.
|	['username'] The username used to connect to the database
|	['password'] The password used to connect to the database
|	['database'] The name of the database you want to connect to
|	['dbdriver'] The database type. ie: mysql.  Currently supported:
				 mysql, mysqli, postgre, odbc, mssql, sqlite, oci8
|	['dbprefix'] You can add an optional prefix, which will be added
|				 to the table name when using the  Active Record class
|	['pconnect'] TRUE/FALSE - Whether to use a persistent connection
|	['db_debug'] TRUE/FALSE - Whether database errors should be displayed.
|	['cache_on'] TRUE/FALSE - Enables/disables query caching
|	['cachedir'] The path to the folder where cache files should be stored
|	['char_set'] The character set used in communicating with the database
|	['dbcollat'] The character collation used in communicating with the database
|	['swap_pre'] A default table prefix that should be swapped with the dbprefix
|	['autoinit'] Whether or not to automatically initialize the database.
|	['stricton'] TRUE/FALSE - forces 'Strict Mode' connections
|							- good for ensuring strict SQL while developing
|
| The $active_group variable lets you choose which connection group to
| make active.  By default there is only one group (the 'default' group).
|
| The $active_record variables lets you determine whether or not to load
| the active record class
*/

$active_group = 'db_mysql';
$active_record = TRUE;

$db['db_mysql']['hostname'] = 'localhost';
$db['db_mysql']['username'] = 'myrmecore';
$db['db_mysql']['password'] = '';
$db['db_mysql']['database'] = 'myrmecore';
$db['db_mysql']['dbdriver'] = 'mysqli';
$db['db_mysql']['dbprefix'] = '';
$db['db_mysql']['pconnect'] = TRUE;
$db['db_mysql']['db_debug'] = TRUE;
$db['db_mysql']['cache_on'] = FALSE;
$db['db_mysql']['cachedir'] = '';
$db['db_mysql']['char_set'] = 'utf8';
$db['db_mysql']['dbcollat'] = 'utf8_general_ci';
$db['db_mysql']['swap_pre'] = '';
$db['db_mysql']['autoinit'] = TRUE;
$db['db_mysql']['stricton'] = FALSE;

$db['db_postgres']['hostname'] = "localhost";
$db['db_postgres']['username'] = "myrmecore";
$db['db_postgres']['password'] = "";
$db['db_postgres']['database'] = "myrmecore";
$db['db_postgres']['dbdriver'] = "postgre";
$db['db_postgres']['dbprefix'] = "";
$db['db_postgres']['pconnect'] = TRUE;
$db['db_postgres']['db_debug'] = TRUE;
$db['db_postgres']['cache_on'] = FALSE;
$db['db_postgres']['cachedir'] = "";
$db['db_postgres']['char_set'] = "utf8";
$db['db_postgres']['dbcollat'] = "utf8_general_ci";
$db['db_postgres']['swap_pre'] = '';
$db['db_postgres']['autoinit'] = TRUE;
$db['db_postgres']['stricton'] = FALSE;


/* End of file database.php */
/* Location: ./application/config/database.php */