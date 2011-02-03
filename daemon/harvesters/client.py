#!/usr/bin/python

# MyrmeCore
#
# A Web-based Wireless Sensor Network Management System
# 
# @package			MyrmeCore
# @authors			Juan F. Duque <jfelipe@grupodyd.com>, Andres M. Eusse <aeusse@grupodyd.com>
# @copyright		Copyright (c) 2011, Dinamica y Desarrollo Ltda.
# @license			http://www.myrmecore.com/license/
# @link				http://www.myrmecore.com
# @since			Version 0.1
# @filesource

# client.py - Client-Server Data Harvester (client-side)
#
# This is a most advanced harvester. It consists of a client-server architecture that allows bidirectional 
# communication, especially designed for more complex wireless sensor networks. This is the client-side part.

import ConfigParser

# Read client.ini configuration file
Config = ConfigParser.ConfigParser()
Config.read("client.ini")


