-- PostgreSQL database structure for MyrmeCore

-- MyrmeCore
-- A Web-based Wireless Sensor Network Management System
 
-- @package			MyrmeCore
-- @author 			Juan F. Duque <jfelipe@grupodyd.com>
-- @copyright   		Copyright (c) 2011, Dinamica y Desarrollo Ltda.
-- @license			http://www.myrmecore.com/license/
-- @link                	http://www.myrmecore.com
-- @since				Version 0.1
-- @filesource


-- ----------------------------
-- Sequence structure for "alerts_id_seq"
-- ----------------------------
DROP SEQUENCE "alerts_id_seq";
CREATE SEQUENCE "alerts_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "locations_id_seq"
-- ----------------------------
DROP SEQUENCE "locations_id_seq";
CREATE SEQUENCE "locations_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "nodes_id_seq"
-- ----------------------------
DROP SEQUENCE "nodes_id_seq";
CREATE SEQUENCE "nodes_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "readings_id_seq"
-- ----------------------------
DROP SEQUENCE "readings_id_seq";
CREATE SEQUENCE "readings_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Table structure for "alerts"
-- ----------------------------
DROP TABLE "alerts";
CREATE TABLE "myrmecore"."alerts" (
"id" int8 DEFAULT nextval('alerts_id_seq'::regclass) NOT NULL,
"sensor_id" int4 DEFAULT NULL NOT NULL,
"node_id" int2 DEFAULT NULL NOT NULL,
"timestamp" timestamp DEFAULT NULL NOT NULL,
"cleared" bool DEFAULT NULL NOT NULL,
CONSTRAINT "alerts_pkey" PRIMARY KEY ("id", "cleared"),
CONSTRAINT "alerts_id_key" UNIQUE ("id")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "myrmecore"."alerts" OWNER TO "postgres";;

-- ----------------------------
-- Records of alerts
-- ----------------------------

-- ----------------------------
-- Table structure for "locations"
-- ----------------------------
DROP TABLE "locations";
CREATE TABLE "myrmecore"."locations" (
"id" int4 DEFAULT nextval('locations_id_seq'::regclass) NOT NULL,
"name" varchar(50) DEFAULT NULL::character varying NOT NULL,
"latitude" float4 DEFAULT NULL NOT NULL,
"longitude" float4 DEFAULT NULL NOT NULL,
"height" int2 DEFAULT NULL NOT NULL,
CONSTRAINT "locations_pkey" PRIMARY KEY ("id", "name"),
CONSTRAINT "locations_id_key" UNIQUE ("id")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "myrmecore"."locations" OWNER TO "postgres";;

-- ----------------------------
-- Records of locations
-- ----------------------------

-- ----------------------------
-- Table structure for "nodes"
-- ----------------------------
DROP TABLE "nodes";
CREATE TABLE "myrmecore"."nodes" (
"id" int4 DEFAULT nextval('nodes_id_seq'::regclass) NOT NULL,
"location" int4 DEFAULT NULL NOT NULL,
"name" varchar(50) DEFAULT NULL::character varying NOT NULL,
CONSTRAINT "nodes_pkey" PRIMARY KEY ("id")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "myrmecore"."nodes" OWNER TO "postgres";;

-- ----------------------------
-- Records of nodes
-- ----------------------------

-- ----------------------------
-- Table structure for "readings"
-- ----------------------------
DROP TABLE "readings";
CREATE TABLE "myrmecore"."readings" (
"id" int8 DEFAULT nextval('readings_id_seq'::regclass) NOT NULL,
"sensor_id" int4 DEFAULT NULL NOT NULL,
"node_id" int4 DEFAULT NULL NOT NULL,
"timestamp" timestamp DEFAULT NULL NOT NULL,
"value" float4 DEFAULT NULL NOT NULL,
CONSTRAINT "readings_pkey" PRIMARY KEY ("id", "timestamp", "value"),
CONSTRAINT "readings_id_key" UNIQUE ("id")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "myrmecore"."readings" OWNER TO "postgres";;

-- ----------------------------
-- Records of readings
-- ----------------------------
