#!/usr/bin/python

# MyrmeCore
#
# A Web-based Wireless Sensor Network Management System
# 
# @package                      MyrmeCore
# @authors                      Juan F. Duque <jfelipe@grupodyd.com>, Andres M. Eusse <aeusse@grupodyd.com>
# @copyright            	Copyright (c) 2011, Dinamica y Desarrollo Ltda.
# @license                      http://www.myrmecore.com/license/
# @link                         http://www.myrmecore.com
# @since                        Version 0.1
# @filesource

# basic.py - Basic Data Harvester
#
# This is a basic harvester, designed for single gateway environments, connected via serial port and 
# with direct database access. The configuration of this script must be done directly on basic.ini file.

import ConfigParser
import logging
from sqlalchemy import *

# Read basic.ini configuration file
Config = ConfigParser.ConfigParser()
Config.read("basic.ini")

# Create logger
logLevel = "logging." + Config.get("main","Level")
logFile = Config.get("main","Logfile")
basic_logger = logging.getLogger("basic_harvester")
basic_logger.setlevel = Config.get("main","Level")
logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',filename=logFile)

logging.debug('Harvester Status: STARTED')
logging.info('Harvester Status: STARTED')

# Connect to Database

dbDriver = Config.get("database","Driver")
print dbDriver

if dbDriver == "mysqli":
  logging.debug('MySQL driver selected')
  logging.info('MySQL driver selected')
  dbhost = Config.get("database","Hostname")
  dbuser = Config.get("database","Username")
  dbpass = Config.get("database","Password")
  dbname = Config.get("database","Database")
  db = create_engine('mysql://scott:tiger@localhost/demodb')
elif dbDriver == "postgres":
  logging.debug('PostgreSQL driver selected')
  logging.info('PostgreSQL driver selected')
  dbhost = Config.get("database","Hostname")
  dbuser = Config.get("database","Username")
  dbpass = Config.get("database","Password")
  dbname = Config.get("database","Database")
  db = create_engine('postgres://scott:tiger@localhost/demodb')
else:
  logging.debug('NO database driver has been selected')
  logging.info('NO database driver has been selected')

