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
# with direct database access. The configuration of this script must be done directly on basic.conf file.

import os
import ConfigParser
import logging
import time
import serial
import sqlalchemy
from sqlalchemy import *
from sqlalchemy.exceptions import *

# Read basic.conf configuration file
Config = ConfigParser.ConfigParser()
Config.read("basic.conf")

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

# basic.conf parsing
dbDriver = Config.get("database","Driver")
dbhost = Config.get("database","Hostname")
dbuser = Config.get("database","Username")
dbpass = Config.get("database","Password")
dbname = Config.get("database","Database")
dbenco = Config.get("database","Charset")

ifdev = Config.get("interface","Device")
ifspeed = Config.get("interface","Speed")
ifdata = Config.get("interface","DataBits")
ifpar = Config.get("interface","Parity")
ifstop = Config.get("interface","StopBit")

uri = dbDriver + "://" + dbuser + ":" + dbpass + "@" + dbhost + "/" + dbname
logger.debug('SQLAlchemy Version: ' + sqlalchemy.__version__ )
logger.debug('SQLAlchemy URI: ' + uri)

dbok = "False"
while (dbok == "False"):

	# Connection attempt
	try: 
          engine = create_engine(uri,encoding=dbenco)
          logger.debug('SQLAlchemy Attempting Connection')
	  connection = engine.connect()
	except SQLAlchemyError as exc:
	  logger.debug('SQLAlchemy failed to connect using URI ' + uri)
	  logger.critical('Database connection failed')
	  logger.critical('Error: ' + exc[0])  
	  raise
	
	logging.getLogger('sqlalchemy.connection').setLevel(logging.DEBUG)
	logger.info('Database connection established')
	
	# Check connection status
	try:
 	    logger.debug('SQLAlchemy Connection Test')
	    result = connection.execute("SELECT NOW()")
	    for row in result: 
    	    	logger.debug('SQLAlchemy Test result: ' + str(row))
 	    result.close()
	    logger.debug('SQLAlchemy Test SUCCEEDED ')
	    dbok = "True"
	except:
	    logger.debug('SQLAlchemy Test FAILED ')
	    raise
	time.sleep(2)

# __init__(port=None, baudrate=9600, bytesize=EIGHTBITS, parity=PARITY_NONE, stopbits=STOPBITS_ONE, timeout=None, 
# xonxoff=False, rtscts=False, writeTimeout=None, dsrdtr=False, interCharTimeout=None)
	
ifok = "False"
while (ifok == "False"):

        # Connection attempt
        try:
            logger.debug('Opening ' + ifdev + ' port')
	    # TODO: Concat ifdev, ifspeed, etc... into i
	    s = serial.Serial(i)
            available.append( (i, s.portstr)) 
            s.close()           
	except serial.SerialException:
          logger.debug('Failed to open ' + ifdev)
          logger.critical('Serial interface connection failed')
          raise

        logger.info('Serial interface connection established')
