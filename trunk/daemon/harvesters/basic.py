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

import os
import ConfigParser
import logging
from sqlalchemy import *
from sqlalchemy.exceptions import SQLAlchemyError

# Read basic.ini configuration file
Config = ConfigParser.ConfigParser()
Config.read("basic.ini")

# Create logger
logLevel = Config.get("main","Level")
logPath = Config.get("main","Logpath")

logger = logging.getLogger("basic_harvester")
logger.setLevel(int(logLevel))
logEfLevel = logger.getEffectiveLevel()
filehandler = logging.FileHandler(os.path.join(logPath,'basic_harvester.log'),'a')
formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
filehandler.setFormatter(formatter)
logger.addHandler(filehandler)

logger.debug('Harvester Status: STARTED')
logger.info('Logging Level: ' + logging.getLevelName(int(logLevel)))
logger.info('Logging Effective Level: ' + str(logEfLevel))
logger.info('Logging Filename: ' + logPath + "basic_harvester.log")

# Connect to Database

dbDriver = Config.get("database","Driver")
dbhost = Config.get("database","Hostname")
dbuser = Config.get("database","Username")
dbpass = Config.get("database","Password")
dbname = Config.get("database","Database")
dbenco = Config.get("database","Charset")

uri = dbDriver + "://" + dbuser + ":" + dbpass + "@" + dbhost + "/" + dbname
logger.debug('SQLAlchemy URI: ' + uri)

engine = create_engine(uri,encoding=dbenco)
logger.debug('SQLAlchemy Starting Connection')

try: 
  connection = engine.connect()
except SQLAlchemyError:
  logger.debug('SQLAlchemy failed to connect using URI ' + uri)
  logger.critical('SQLAlchemy failed to connect to database server')
