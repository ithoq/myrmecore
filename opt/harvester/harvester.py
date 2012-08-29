#!/usr/bin/python
# -*- coding: UTF-8 -*-

#import MySQLdb
import os
import serial
import sys
from time import sleep, time
import ConfigParser
import logging
import sqlalchemy
from sqlalchemy import *
from sqlalchemy import exc


def harvest():

	# Read basic.conf configuration file
	Config = ConfigParser.ConfigParser()
	Config.read("/opt/myrmecore/harvester.conf")
	
	# Write PID
	pidfile = Config.get("main","PIDFile")
	pid = str(os.getpid())
	f = open(pidfile, 'w')
	f.write(pid)
	f.close()
	
	# Create logger
	logLevel = Config.get("main","Level")
	logPath = Config.get("main","Logpath")

	logger = logging.getLogger("harvester")
	logger.setLevel(int(logLevel))
	logEfLevel = logger.getEffectiveLevel()
	filehandler = logging.FileHandler(os.path.join(logPath,'harvester.log'),'a')
	formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
	filehandler.setFormatter(formatter)
	logger.addHandler(filehandler)
	
	logger.debug('Harvester status: STARTED')
	logger.info('Logging Level: ' + logging.getLevelName(int(logLevel)))
	logger.info('Logging Effective Level: ' + str(logEfLevel))
	logger.info('Logging Filename: ' + logPath + "harvester.log")
	
	# basic.conf parsing
	dbDriver = Config.get("database","Driver")
	dbhost = Config.get("database","Hostname")
	dbuser = Config.get("database","Username")
	dbpass = Config.get("database","Password")
	dbname = Config.get("database","Database")
	dbenco = Config.get("database","Charset")
	
	ifdev = Config.get("interface","Device")
	ifspeed = Config.get("interface","Speed")
	ifdata = int(Config.get("interface","DataBits"))
	ifpar = Config.get("interface","Parity")
	ifstop = int(Config.get("interface","StopBit"))
	iftimeout = float(Config.get("interface","Timeout"))
	ifcard = Config.get("interface","Card")
	
	uri = dbDriver + "://" + dbuser + ":" + dbpass + "@" + dbhost + "/" + dbname
	
	dbok = "False"
	while (dbok == "False"):
		# Connection attempt
		try: 
			engine = create_engine(uri,encoding=dbenco, echo=False, implicit_returning=False)
			logger.debug('SQLAlchemy Attempting Connection')
			dbConnection = engine.connect()
		except exc.SQLAlchemyError:
			logger.debug('SQLAlchemy failed to connect using URI ' + uri)
			logger.critical('Database connection failed')
			raise
		
		logging.getLogger('sqlalchemy.connection').setLevel(logging.DEBUG)
		logger.info('Database connection established')
		
		# Check connection status
		try:
			logger.debug('SQLAlchemy Connection Test')
			result = dbConnection.execute("SELECT NOW()")
			for row in result: 
				logger.debug('SQLAlchemy Test result: ' + str(row))
			result.close()
			logger.debug('SQLAlchemy Test SUCCEEDED ')
			dbok = "True"
		except:
			logger.debug('SQLAlchemy Test FAILED ')
			raise
			sleep(2)
	
	ifok = "False"
	while (ifok == "False"):
		# Connection attempt
		try:
		    logger.debug('Opening ' + ifdev + ' port')
		    ser = serial.Serial(ifdev, ifspeed, ifdata, ifpar, ifstop, iftimeout)	#
		    ifok = "True"
		except serial.SerialException:
		  logger.debug('Failed to open ' + ifdev)
		  logger.critical('Serial interface connection failed')
		  raise
	
		logger.info('Serial interface connection established')

	#Comando para poner el micro en modo RAW
	if ifcard == "botonera":
		ser.write(chr(0x00) + chr(0xdc))
	
	metadata = MetaData(engine)
	readingsT = Table('readings', metadata, autoload=True)
	sensorsT = Table('sensors', metadata, autoload=True)
	transTypeT = Table('transductor_types', metadata, autoload=True)
	transT = Table('transductors', metadata, autoload=True)

	logger.info('-------------------- MYRMECORE READING HARVESTER READY --------------------')

	#Bucle infinito
	paquete = [None]*50
	inicioCompleto = time()
	while 1:	

		try:
			index = 0
			ackLen = 0
			
			while 1:	#Bucle hasta que se complete un paquete
				ack = 0
				ack = ser.read(1)
				if ack != "":
					ack = ord(ack)
					
					if ack == 0x7E and index == 0:
						#paquete[0] = ack
						index = 1
						inicio = time()
					
					if index == 3:
						ackLen = ack
					
					print ("%02X" % ack) + " ",
					
					if (ackLen + 4) == index and index > 2:
						print " -*-"
						paquete[index - 1] = ack
						index = 0
						break
					
					if index > 0:
						paquete[index - 1] = ack
						index += 1
			
			
			#Si pasamos por acá es porque ya se recibió un paquete completo
			
			if paquete[3] == 0x8b:		#Si es un paquete de transmit status, lo ignoramos
				continue
			
			if paquete[3] != 0x90:		#Si no es una recepción, lo ignoramos (lo pongo específico para ver que se hace bien después)
				continue
			
			if paquete[15] != 0x02:		#Este byte dice que dispositivo de origen es, y tiene que ser 0x02 para llamador Clinum
				continue
			
			#Si pasamos por acá es porque debería ser legal el paquete
			
			i = 0
			sensorSource = ""
			for i in range(8):
				sensorSource += "%02X" % paquete[4 + i]
			sensorSourceShortAddr = ("%02X" % paquete[12]) + ("%02X" % paquete[13])
			sensorSourceBat = (paquete[20] * 256) + (paquete[21])
			sensorInfo = sensorsT.select((sensorsT.c.long_address == sensorSource)).execute().fetchone()
			
			if sensorInfo:
				if sensorInfo.enabled == True:
					sensorId = sensorInfo.id
					
					sensorSequence = sensorInfo.sequence_number
					#Actualizamos la nueva secuencia porque ya se capturó la anterior
					sensorsT.update().where(sensorsT.c.long_address == sensorSource).values(short_address = sensorSourceShortAddr, sequence_number = paquete[16]).execute()
					
					if paquete[17] == 0:	#O sea, cero medidas
						logger.debug('Received echo request from ' + sensorSource)
					else:
						if sensorSequence != paquete[16]:	#Por ahora lo pondremos en "distinto". Se podría evaluar que sea exclusivamente "== deviceSequence + 1", aunque hay que tener en cuenta que hay varios tipos de peticiones
							logger.debug('Accepted packet from sensor ' + str(sensorId))
							#Iteración para leer todas las medidas
							readings = paquete[17]
							i = 0
							valueIndex = 18
							for i in range(readings):
								transType = paquete[valueIndex]
								valueIndex += 1				
								transType = transTypeT.select((transTypeT.c.id == transType)).execute().fetchone()
								
								value = 0
								j = 0
								for j in range(transType.size_bytes):
									value = value * 256 + paquete[valueIndex]
									valueIndex += 1
								calculo = transType.conversion.replace('X', str(value))
								
								transRow = transT.select(and_(transT.c.type == transType.id, transT.c.sensor == sensorId)).execute().fetchone()
								readingsT.insert().values(sensor_id = sensorId, transductor_id = transRow.id, value = eval(calculo)).execute()
						else:
							logger.debug('Dropped petition from sensor ' + str(sensorId))
						
					# 0x00 para decirle que fue OK. Además es lo único que hace que no haga otro retry cuando es un request
					respuesta = 0x00
	
					# Para marcar cosas como por ejemplo warnings (como por ejemplo que ya se había atendido en software y alcanzó a entrar una finalización por hardware)
					respuestaAviso = 0x00	
					# Por ahora, así marque un FAILED el resultadoHttp, al llamador solamente le interesa saber si debe apagarse
				else:
					respuesta = 0x00
					# Para marcar cosas como por ejemplo warnings (como por ejemplo que se recibió la petición pero el llamador estaba deshabilitado)
					respuestaAviso = 0x01
			else:
				#Esto por aquí significa que no estaba en la base de datos, entonces podríamos aprovechar para agregarlo si es que se arrancó el harvester en modo ADD
				try:
					if sys.argv[1] == "add":
						print "INSERTANDO DISPOSITIVO ............."
						sensorsT.insert().values(model = 1, long_address = sensorSource, short_address = sensorSourceShortAddr, group = 1).execute()
				except:
					pass	#print "error de inserción!"	#Creo que este print no tiene que ser log ya que se correría el modo ADD a mano únicamente, pero el print se debe hacer capturando bien la excpeción
				# Enviando este en algo distinto a 0x00 haría que el llamador vuelva a mandar la petición
				respuesta = 0x00	

				# Para marcar cosas como por ejemplo warnings (como por ejemplo que se recibió la petición pero no está en base de datos o algo así)
				respuestaAviso = 0xff
			
			
			secuenciaPropia = paquete[16]
			checksum = 0xffff
			resp = [0x10, 0x01, paquete[4], paquete[5], paquete[6], paquete[7], paquete[8], paquete[9], paquete[10], paquete[11], paquete[12], paquete[13], 0x00, 0x00, 0x00, secuenciaPropia, 0x00, 0x05, 0x03]
			respLen = len(resp)
			i = 0
			for i in resp:
				checksum -= i
			
			logger.debug('Transmitting response to sensor')
			if ifcard == "botonera":
				ser.write(chr(0x00))
			ser.write(chr(0x7e) + chr(0x00) + chr(respLen))
			i = 0
			for i in range(respLen):
				ser.write(chr(resp[i]))
			ser.write(chr(0xff & checksum))
			

		except KeyboardInterrupt:
			logger.info('Harvester status: HALTED BY USER')
			if ifcard == "botonera":
				ser.write(chr(0x7e) + chr(0xff))
				sleep(0.2)
				
			ser.close();
			exit()



if __name__ == "__main__" :
	harvest()