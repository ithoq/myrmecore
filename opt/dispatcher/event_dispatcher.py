#!/usr/bin/python

# MyrmeCore
#
# A Web-based Wireless Sensor Network Management System
# 
# @package                      MyrmeCore
# @authors                      Juan F. Duque <jfelipe@grupodyd.com>
# @copyright            		Copyright (c) 2012, Dinamica y Desarrollo Ltda.
# @license                      http://www.myrmecore.com/license/
# @link                         http://www.myrmecore.com
# @since                        Version 1.0

# event_dispatcher.py - Event monitoring script with hardware communication capabilities

import os
import ConfigParser
import logging
import time
from time import sleep, strftime, localtime
import datetime
import serial
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import sqlalchemy
from sqlalchemy import *
from sqlalchemy import exc
from prettytable import PrettyTable

# Read event_dispatcher.conf configuration file
Config = ConfigParser.ConfigParser()
Config.read("/opt/myrmecore/event_dispatcher.conf")

# Write PID
pidfile = Config.get("main","PIDFile")
pid = str(os.getpid())
f = open(pidfile, 'w')
f.write(pid)
f.close()

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

metadata = MetaData(engine)

settings = Table('settings', metadata, autoload=True)
strings = Table('strings', metadata, autoload=True)
events = Table('events', metadata, autoload=True)
actions = Table('actions', metadata, autoload=True)
action_logs = Table('action_logs', metadata, autoload=True)
action_sets = Table('action_sets', metadata, autoload=True)
templates = Table('templates', metadata, autoload=True)
readings = Table('readings', metadata, autoload=True)

transductors = Table('transductors', metadata, autoload=True)
transductor_class = Table('transductor_class', metadata, autoload=True)
sensors = Table('sensors', metadata, autoload=True)
groups = Table('groups', metadata, autoload=True)
nodes = Table('nodes', metadata, autoload=True)
zones = Table('zones', metadata, autoload=True)


def send_sms(args):
	logger.debug('SMS to ' + args + ' status: SENDING')
	return True

def send_email(email,message):
	mail_type = select([settings.c.value]).where(settings.c.name == 'mail_type').execute().fetchone().value
	if mail_type == 'gmail':
                mail_username = select([settings.c.value]).where(settings.c.name == 'mail_username').execute().fetchone().value
                mail_password = select([settings.c.value]).where(settings.c.name == 'mail_password').execute().fetchone().value
                mail_from_addr = select([settings.c.value]).where(settings.c.name == 'mail_from_addr').execute().fetchone().value
                mail_server = select([settings.c.value]).where(settings.c.name == 'mail_server').execute().fetchone().value
		logger.debug('E-Mail to ' + email + ' status: SENDING')

		msg_to_send = MIMEMultipart('alternative')
		msg_to_send['Subject'] = select([settings.c.value]).where(settings.c.name == 'mail_subject').execute().fetchone().value
		msg_to_send['From'] = mail_from_addr
		msg_to_send['To'] = email

		part1 = MIMEText(message, 'html')
		msg_to_send.attach(part1)

		try:
			server = smtplib.SMTP(mail_server)  
			server.starttls()  
			server.login(mail_username,mail_password)  
			server.sendmail(mail_from_addr, email, msg_to_send.as_string())  
			server.quit() 
		except smtplib.SMTPAuthenticationError:
			logger.error('SMTP authentication error! E-Mail message was NOT sent!')
			return False
	return True

def send_packet():
	print 'Packet sent'
	return True

logger.info('-------------------- MYRMECORE EVENT DISPATCHER READY --------------------')
loop = "True"
while (loop == "True"):

	num_events = events.select().where(events.c.cleared == 'False').execute().rowcount

	# SELECT DISTINCT action_set FROM events WHERE cleared = false;
	action_sets_found = select([events.c.action_set]).distinct().where(events.c.cleared == 'False').execute()
    	
	if num_events > 0:
		logger.info('Found ' + str(num_events) + ' unattended events')
		for action_set_id in action_sets_found:
			# SELECT events_to_run FROM action_sets WHERE id = action_set_id[0]
			num_events_to_run = select([action_sets.c.events_to_run]).where(action_sets.c.id == action_set_id[0]).execute().fetchone()[0]
			
			# SELECT id FROM events WHERE cleared = false AND action_set = action_set_id[0] ORDER BY id ASC
			matching_events = select([events.c.id]).where(events.c.cleared == 'False').where(events.c.action_set == action_set_id[0]).order_by(events.c.id.asc()).execute()			
			num_matching_events = matching_events.rowcount
			
			if num_matching_events >= num_events_to_run:
				logger.debug('Found ' + str(num_matching_events) + ' of ' + str(num_events_to_run) + ' needed to run action_set ID: ' + str(action_set_id[0]) + '. RUNNING')

				# Mark events as cleared
				trans = connection.begin()
				try:
					cleared_event_ids = []
					for event in matching_events:
						cleared_event_ids.append(event.id)
						events.update().values(cleared = 'True').where(events.c.id == event.id).execute()
						logger.debug('Event(' + str(event.id) + '): CLEARED')
						trans.commit()
				except:
					trans.rollback()
					logger.warning('Action ID: ' + str(action.id) + ' failed to process')
					raise

				# SELECT * FROM actions WHERE set = action_set_id[0] AND enabled = true
				set_actions = actions.select().where(actions.c.set == action_set_id[0]).where(actions.c.enabled == 'True').execute()
				for action in set_actions:
					action_done = False
					logger.info('Action(' + str(action.id) + '): RUNNING')

					if action.action == 'SEND_SMS':
						if send_sms(action.args):
							logger.debug('SMS to ' + action.args + ' status: SENT')
							action_done = True
                                		else:
							logger.warning('SMS to ' + args + ' status: FAILED')
							action_done = False

                        		elif action.action == 'SEND_EMAIL':
						template = select([templates.c.body]).where(templates.c.id == action.template).execute().fetchone().body

						classname_string = strings.select().where(strings.c.name == "classname").execute().fetchone().text
						value_string = strings.select().where(strings.c.name == "value").execute().fetchone().text
						class_string = strings.select().where(strings.c.name == "class").execute().fetchone().text
						node_string = strings.select().where(strings.c.name == "node").execute().fetchone().text
						zone_string = strings.select().where(strings.c.name == "zone").execute().fetchone().text
						group_string = strings.select().where(strings.c.name == "group").execute().fetchone().text
						sensor_string = strings.select().where(strings.c.name == "sensor").execute().fetchone().text
						date_string = strings.select().where(strings.c.name == "date").execute().fetchone().text
						
						table = PrettyTable(["ID", classname_string, value_string, class_string, zone_string, node_string, group_string, sensor_string, date_string])
						table.format = True
						reading_values = []
						for event_id in cleared_event_ids:
							event_record = events.select().where(events.c.id == event_id).execute().fetchone()
							event_reading = readings.select().where(readings.c.id == event_record.reading).execute().fetchone()
							event_transductor = transductors.select().where(transductors.c.id == event_reading.transductor_id).execute().fetchone()
							
							# ID
							event_reading_id = event_reading.id
							
							# ClassName
							event_class_name = event_classes.select().where(event_classes.c.id == event_record.CLASS).execute().fetchone().name
							
							# Value 
							event_reading_value = event_reading.value
							
							# Class (temperature, humidity, pressure, etc.)
							event_transductor_class_name = transductor_class.select().where(transductor_class.c.id == event_transductor.CLASS).execute().fetchone().name
							
							# Sensor name
							event_sensor = sensors.select().where(sensors.c.id == event_reading.sensor_id).execute().fetchone()
							event_sensor_name = event_sensor.name
							
							# Group name
							event_group = event_group = groups.select().where(groups.c.id == event_sensor.group).execute().fetchone()
							event_group_name = event_group.name
							
							# Node name
							event_node = nodes.select().where(nodes.c.id == event_group.node).execute().fetchone()
							event_node_name = event_node.name
													
							# Zone name
							event_zone = zones.select().where(zones.c.id == event_node.zone).execute().fetchone()
							event_zone_name = event_zone.name
							
							# Date string
							event_struct_time = time.strptime(str(event_reading.timestamp), '%Y-%m-%d %H:%M:%S.%f')
							event_date = time.strftime('%Y-%m-%d %I:%M:%S %p', event_struct_time)

							table.add_row([event_reading_id, event_class_name, event_reading_value, event_transductor_class_name, event_zone_name, event_node_name, event_group_name, event_sensor_name, event_date])
						
						time = strftime("%I:%M:%S %p", localtime())
						time24 = strftime("%H:%M:%S", localtime())
						date = strftime("%d-%b-%Y", localtime())

						timestamp = strftime("%a, %d %b %Y %H:%M:%S", localtime())
						msg = template.replace("_reading_", str(table.get_html_string())).replace("_name_", action.name).replace("_time_", time).replace("_time24_", time24).replace("_date_", date)
                                		
						if send_email(action.args,msg):
							logger.debug('E-Mail to ' + action.args + ' status: SENT')
							action_done = True
                                		else:
							logger.warning('E-Mail to ' + action.args + ' status: FAILED')
							action_done = False

                        		elif action.action == 'SEND_PACKET':
                                              	if send_packet(action.args):
                                                        print "Packet Sent"
							action_done = True
                                                else:
                                                        print "Packet NOT Sent"


					if action_done == True:
						logger.info('Action(' + str(action.id) + '): COMPLETED')
					else:
						print "Action NOT DONE"
			else:
				logger.debug('Found ' + str(num_matching_events) + ' out of ' + str(num_events_to_run) + ' needed to run action_set ID: ' + str(action_set_id[0]) + '. WAITING FOR MORE')
	else:
		logger.debug('NO unattended events found')
    	sleep(5)
