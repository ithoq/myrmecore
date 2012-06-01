#!/usr/bin/python

# MyrmeCore
#
# A Web-based Wireless Sensor Network Management System
# 
# @package                      MyrmeCore
# @authors                      Juan F. Duque <jfelipe@grupodyd.com>, Andres M. Eusse <aeusse@grupodyd.com>
# @copyright            	Copyright (c) 2012, Dinamica y Desarrollo Ltda.
# @license                      http://www.myrmecore.com/license/
# @link                         http://www.myrmecore.com
# @since                        Version 1.0
# @filesource

# event_dispatcher.py - Event monitoring script with hardware communication capabilities

import os
import ConfigParser
import logging
import time
from time import sleep
import serial
import sqlalchemy
from sqlalchemy import *
from sqlalchemy import exc

# Read basic.conf configuration file
Config = ConfigParser.ConfigParser()
Config.read("event_dispatcher.conf")

# Create logger
logLevel = Config.get("main","Level")
logPath = Config.get("main","Logpath")

logger = logging.getLogger("event_dispatcher")
logger.setLevel(int(logLevel))
logEfLevel = logger.getEffectiveLevel()
filehandler = logging.FileHandler(os.path.join(logPath,'event_dispatcher.log'),'a')
formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
filehandler.setFormatter(formatter)
logger.addHandler(filehandler)

logger.debug('Event Dispatcher Status: STARTED')
logger.info('Logging Level: ' + logging.getLevelName(int(logLevel)))
logger.info('Logging Effective Level: ' + str(logEfLevel))
logger.info('Logging Filename: ' + logPath + "event_dispatcher.log")

# event_dispatcher.conf parsing
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
	except exc.SQLAlchemyError as exc:
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
	time.sleep(1)

# __init__(port=None, baudrate=9600, bytesize=EIGHTBITS, parity=PARITY_NONE, stopbits=STOPBITS_ONE, timeout=None, 
# xonxoff=False, rtscts=False, writeTimeout=None, dsrdtr=False, interCharTimeout=None)
	
ifok = "False"
while (ifok == "False"):

        # Connection attempt
        try:
            logger.debug('Opening ' + ifdev + ' port')
	    s = serial.Serial(ifdev, ifspeed)
            s.close()           
	    ifok = "True"
	except serial.SerialException:
          logger.debug('Failed to open ' + ifdev)
          logger.critical('Serial interface connection failed')
          raise

        logger.info('Serial interface connection established')

def send_sms(args):
        print 'SMS sent to: ' + args
	return True

def send_email(args):
	print 'E-mail sent to: ' + args
	return True

def send_packet():
	print 'Packet sent'
	return True

metadata = MetaData(engine)

events = Table('events', metadata, autoload=True)
actions = Table('actions', metadata, autoload=True)
action_logs = Table('action_logs', metadata, autoload=True)
action_sets = Table('action_sets', metadata, autoload=True)

loop = "True"
while (loop == "True"):

	num_events = events.select().where(events.c.cleared == 'False').execute().rowcount

	# SELECT DISTINCT action_set FROM events WHERE cleared = false;
    	action_sets_found = select([events.c.action_set]).distinct().where(events.c.cleared == 'False').execute()
	if num_events > 0:
		logger.info('Found ' + str(num_events) + ' unattended events')
		for action_set_id in action_sets_found:
			# SELECT events_to_run FROM action_sets WHERE id = action_set_id[0]
			num_events_to_run = select([action_sets.c.events_to_run]).where(action_sets.c.id == action_set_id[0]).execute()
			num_events_to_run = num_events_to_run.fetchone()[0]
			# SELECT id FROM events WHERE cleared = false AND action_set = action_set_id[0] ORDER BY id ASC
			matching_events = select([events.c.id]).where(events.c.cleared == 'False').where(events.c.action_set == action_set_id[0]).order_by(events.c.id.asc()).execute()
			num_matching_events = matching_events.rowcount
			if num_matching_events >= num_events_to_run:
				logger.debug('Found ' + str(num_matching_events) + ' of ' + str(num_events_to_run) + ' needed to run action_set ID: ' + str(action_set_id[0]) + '. RUNNING')
				# SELECT * FROM actions WHERE set = action_set_id[0] AND enabled = true
				set_actions = actions.select().where(actions.c.set == action_set_id[0]).where(actions.c.enabled == 'True').execute()
				for action in set_actions:
					logger.info('Running action ID: ' + str(action.id) + ', named: ' + action.name)
		                        if action.action == 'SEND_SMS':
                		                if send_sms(action.args):
                                		        trans = connection.begin()
		                                        try:
               		                                	i = action_logs.insert().execute({'action':action.id, 'message':'SMS sent successfully to' + str(action.args)})
														for event in matching_events:
															events.update().values(cleared = 'True').where(events.c.id == event.id).execute()
															logger.debug('Event ID: ' + str(event.id) + ' has been marked as CLEARED')
                                                		trans.commit()
                                        		except:
                                                		trans.rollback()
                                                		logger.warning('Action ID: ' + str(action.id) + ' failed to process')
                                                		raise
                                		else:
                                        		print 'ERROR'
                        		elif action.action == 'SEND_EMAIL':
                                		if send_email(action.args):
                                        		print 'OK'
                                		else:
                                        		print 'ERROR'
                        		elif action.action == 'SEND_PACKET':
                                		send_packet(action.args)
			else:
				logger.debug('Found ' + str(num_matching_events) + ' of ' + str(num_events_to_run) + ' needed to run action_set ID: ' + str(action_set_id[0]) + '. WAITING FOR MORE')
	else:
		logger.info('NO unattended events found')
    	sleep(5)
