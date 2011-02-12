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

# basic.py - Basic Data Harvester
#
# This is a basic harvester, designed for single gateway environments, connected via serial port and 
# with direct database access. The configuration of this script must be done directly on basic.ini file.

import ConfigParser
import logging

# Read basic.ini configuration file
Config = ConfigParser.ConfigParser()
Config.read("basic.ini")


