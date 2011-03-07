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
-- Sequence structure for "public"."alerts_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."alerts_id_seq";
CREATE SEQUENCE "public"."alerts_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."groups_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."groups_id_seq";
CREATE SEQUENCE "public"."groups_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."locations_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."locations_id_seq";
CREATE SEQUENCE "public"."locations_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."nodes_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."nodes_id_seq";
CREATE SEQUENCE "public"."nodes_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."readings_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."readings_id_seq";
CREATE SEQUENCE "public"."readings_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Table structure for "myrmecore"."alerts"
-- ----------------------------
DROP TABLE "myrmecore"."alerts";
CREATE TABLE "myrmecore"."alerts" (
"id" int8 DEFAULT nextval('alerts_id_seq'::regclass) NOT NULL,
"sensor_id" int4 NOT NULL,
"node_id" int2 NOT NULL,
"timestamp" timestamp(6) NOT NULL,
"cleared" bool NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of alerts
-- ----------------------------

-- ----------------------------
-- Table structure for "myrmecore"."groups"
-- ----------------------------
DROP TABLE "myrmecore"."groups";
CREATE TABLE "myrmecore"."groups" (
"id" int4 DEFAULT nextval('groups_id_seq'::regclass) NOT NULL,
"name" varchar(30) DEFAULT NULL::character varying NOT NULL,
"location" int4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of groups
-- ----------------------------

-- ----------------------------
-- Table structure for "myrmecore"."locations"
-- ----------------------------
DROP TABLE "myrmecore"."locations";
CREATE TABLE "myrmecore"."locations" (
"id" int4 DEFAULT nextval('locations_id_seq'::regclass) NOT NULL,
"name" varchar(50) DEFAULT NULL::character varying NOT NULL,
"latitude" float4 NOT NULL,
"longitude" float4 NOT NULL,
"height" int2 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of locations
-- ----------------------------

-- ----------------------------
-- Table structure for "myrmecore"."nodes"
-- ----------------------------
DROP TABLE "myrmecore"."nodes";
CREATE TABLE "myrmecore"."nodes" (
"id" int4 DEFAULT nextval('nodes_id_seq'::regclass) NOT NULL,
"location" int4 NOT NULL,
"name" varchar(50) DEFAULT NULL::character varying NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of nodes
-- ----------------------------

-- ----------------------------
-- Table structure for "myrmecore"."readings"
-- ----------------------------
DROP TABLE "myrmecore"."readings";
CREATE TABLE "myrmecore"."readings" (
"id" int8 DEFAULT nextval('readings_id_seq'::regclass) NOT NULL,
"sensor_id" int4 NOT NULL,
"node_id" int4 NOT NULL,
"timestamp" timestamp(6) NOT NULL,
"value" float4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of readings
-- ----------------------------

-- ----------------------------
-- Table structure for "myrmecore"."sessions"
-- ----------------------------
DROP TABLE "myrmecore"."sessions";
CREATE TABLE "myrmecore"."sessions" (
"session_id" varchar(40) DEFAULT '0'::character varying NOT NULL,
"ip_address" varchar(16) DEFAULT '0'::character varying NOT NULL,
"user_agent" varchar(50) DEFAULT NULL::character varying NOT NULL,
"last_activity" int4 DEFAULT 0 NOT NULL,
"user_data" text NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Uniques structure for table "myrmecore"."alerts"
-- ----------------------------
ALTER TABLE "myrmecore"."alerts" ADD UNIQUE ("id");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."alerts"
-- ----------------------------
ALTER TABLE "myrmecore"."alerts" ADD PRIMARY KEY ("id", "cleared");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."groups"
-- ----------------------------
ALTER TABLE "myrmecore"."groups" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table "myrmecore"."locations"
-- ----------------------------
ALTER TABLE "myrmecore"."locations" ADD UNIQUE ("id");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."locations"
-- ----------------------------
ALTER TABLE "myrmecore"."locations" ADD PRIMARY KEY ("id", "name");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."nodes"
-- ----------------------------
ALTER TABLE "myrmecore"."nodes" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table "myrmecore"."readings"
-- ----------------------------
ALTER TABLE "myrmecore"."readings" ADD UNIQUE ("id");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."readings"
-- ----------------------------
ALTER TABLE "myrmecore"."readings" ADD PRIMARY KEY ("id", "timestamp", "value");

-- ----------------------------
-- Primary Key structure for table "myrmecore"."sessions"
-- ----------------------------
ALTER TABLE "myrmecore"."sessions" ADD PRIMARY KEY ("session_id");
