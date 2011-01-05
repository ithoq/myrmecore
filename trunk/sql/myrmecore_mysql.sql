-- MySQL database structure for MyrmeCore

-- MyrmeCore
-- A Web-based Wireless Sensor Network Management System
 
-- @package			MyrmeCore
-- @author 			Juan F. Duque <jfelipe@grupodyd.com>
-- @copyright   		Copyright (c) 2011, Dinamica y Desarrollo Ltda.
-- @license			http://www.myrmecore.com/license/
-- @link                	http://www.myrmecore.com
-- @since				Version 0.1
-- @filesource

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `alerts`
-- ----------------------------
DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sensor_id` mediumint(3) unsigned NOT NULL,
  `node_id` smallint(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cleared` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`,`cleared`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of alerts
-- ----------------------------

-- ----------------------------
-- Table structure for `locations`
-- ----------------------------
DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `latitude` float(9,6) NOT NULL DEFAULT '0.000000',
  `longitude` float(9,6) NOT NULL DEFAULT '0.000000',
  `height` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of locations
-- ----------------------------

-- ----------------------------
-- Table structure for `nodes`
-- ----------------------------
DROP TABLE IF EXISTS `nodes`;
CREATE TABLE `nodes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `location` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of nodes
-- ----------------------------

-- ----------------------------
-- Table structure for `readings`
-- ----------------------------
DROP TABLE IF EXISTS `readings`;
CREATE TABLE `readings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sensor_id` mediumint(3) unsigned NOT NULL,
  `node_id` smallint(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `value` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=ARCHIVE DEFAULT CHARSET=latin1 ROW_FORMAT=COMPRESSED
/*!50100 PARTITION BY HASH (id)
PARTITIONS 8 */;

-- ----------------------------
-- Records of readings
-- ----------------------------
