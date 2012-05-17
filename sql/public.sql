/*
Navicat PGSQL Data Transfer

Source Server         : Dev
Source Server Version : 90103
Source Host           : localhost:5432
Source Database       : myrmecore
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90103
File Encoding         : 65001

Date: 2012-05-16 20:18:29
*/


-- ----------------------------
-- Sequence structure for "public"."api_logs_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."api_logs_id_seq";
CREATE SEQUENCE "public"."api_logs_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 28
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."groups_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."groups_id_seq";
CREATE SEQUENCE "public"."groups_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 3
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."news_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."news_id_seq";
CREATE SEQUENCE "public"."news_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 4
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."nodes_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."nodes_id_seq";
CREATE SEQUENCE "public"."nodes_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 2
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
-- Sequence structure for "public"."sensor_models_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."sensor_models_id_seq";
CREATE SEQUENCE "public"."sensor_models_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."sensors_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."sensors_id_seq";
CREATE SEQUENCE "public"."sensors_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 6
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."settings_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."settings_id_seq";
CREATE SEQUENCE "public"."settings_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 6
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."strings_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."strings_id_seq";
CREATE SEQUENCE "public"."strings_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 6
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."transductor_types_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."transductor_types_id_seq";
CREATE SEQUENCE "public"."transductor_types_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 4
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."transductors_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."transductors_id_seq";
CREATE SEQUENCE "public"."transductors_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 19
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."users_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."zones_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."zones_id_seq";
CREATE SEQUENCE "public"."zones_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 2
 CACHE 1;

-- ----------------------------
-- Table structure for "public"."api_keys"
-- ----------------------------
DROP TABLE "public"."api_keys";
CREATE TABLE "public"."api_keys" (
"key" varchar(40) DEFAULT ''::character varying NOT NULL,
"level" int2 DEFAULT 0 NOT NULL,
"ignore_limits" int2 DEFAULT 0 NOT NULL,
"date_created" int4 DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of api_keys
-- ----------------------------
INSERT INTO "public"."api_keys" VALUES ('75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '1', '1', '1337128163');

-- ----------------------------
-- Table structure for "public"."api_logs"
-- ----------------------------
DROP TABLE "public"."api_logs";
CREATE TABLE "public"."api_logs" (
"id" int4 DEFAULT nextval('api_logs_id_seq'::regclass) NOT NULL,
"uri" varchar(255) DEFAULT ''::character varying NOT NULL,
"method" varchar(255) DEFAULT ''::character varying NOT NULL,
"params" text NOT NULL,
"api_key" varchar(40) DEFAULT ''::character varying NOT NULL,
"ip_address" inet NOT NULL,
"time" int4 DEFAULT 0 NOT NULL,
"authorized" int2 DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of api_logs
-- ----------------------------
INSERT INTO "public"."api_logs" VALUES ('1', 'platform/getplatform', 'post', 'a:2:{s:8:"username";s:7:"usuario";s:8:"password";s:8:"12345678";}', '', '192.168.1.115', '1337134013', '0');
INSERT INTO "public"."api_logs" VALUES ('2', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134042', '1');
INSERT INTO "public"."api_logs" VALUES ('3', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134057', '1');
INSERT INTO "public"."api_logs" VALUES ('4', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134064', '1');
INSERT INTO "public"."api_logs" VALUES ('5', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134093', '1');
INSERT INTO "public"."api_logs" VALUES ('6', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134108', '1');
INSERT INTO "public"."api_logs" VALUES ('7', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134275', '1');
INSERT INTO "public"."api_logs" VALUES ('8', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134278', '1');
INSERT INTO "public"."api_logs" VALUES ('9', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134309', '1');
INSERT INTO "public"."api_logs" VALUES ('10', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134608', '1');
INSERT INTO "public"."api_logs" VALUES ('11', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134618', '1');
INSERT INTO "public"."api_logs" VALUES ('12', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337134808', '1');
INSERT INTO "public"."api_logs" VALUES ('13', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337135194', '1');
INSERT INTO "public"."api_logs" VALUES ('14', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337135846', '1');
INSERT INTO "public"."api_logs" VALUES ('15', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136240', '1');
INSERT INTO "public"."api_logs" VALUES ('16', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136296', '1');
INSERT INTO "public"."api_logs" VALUES ('17', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136314', '1');
INSERT INTO "public"."api_logs" VALUES ('18', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136332', '1');
INSERT INTO "public"."api_logs" VALUES ('19', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136335', '1');
INSERT INTO "public"."api_logs" VALUES ('20', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136368', '1');
INSERT INTO "public"."api_logs" VALUES ('21', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136373', '1');
INSERT INTO "public"."api_logs" VALUES ('22', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136402', '1');
INSERT INTO "public"."api_logs" VALUES ('23', 'platform/getplatform', 'get', 'a:0:{}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136413', '1');
INSERT INTO "public"."api_logs" VALUES ('24', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136432', '1');
INSERT INTO "public"."api_logs" VALUES ('25', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136479', '1');
INSERT INTO "public"."api_logs" VALUES ('26', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136558', '1');
INSERT INTO "public"."api_logs" VALUES ('27', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337136583', '1');
INSERT INTO "public"."api_logs" VALUES ('28', 'platform/getplatform/format/xml', 'get', 'a:1:{s:6:"format";s:3:"xml";}', '75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b', '192.168.1.115', '1337139245', '1');

-- ----------------------------
-- Table structure for "public"."groups"
-- ----------------------------
DROP TABLE "public"."groups";
CREATE TABLE "public"."groups" (
"id" int4 DEFAULT nextval('groups_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"node" int4 NOT NULL,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO "public"."groups" VALUES ('1', 'TEST_GROUP_1', '1', 't');
INSERT INTO "public"."groups" VALUES ('2', 'TEST_GROUP_2', '2', 't');

-- ----------------------------
-- Table structure for "public"."news"
-- ----------------------------
DROP TABLE "public"."news";
CREATE TABLE "public"."news" (
"id" int4 DEFAULT nextval('news_id_seq'::regclass) NOT NULL,
"date" timestamp(6) DEFAULT now() NOT NULL,
"role" varchar(8) DEFAULT 'PUBLIC'::character varying NOT NULL,
"reach" varchar(8) DEFAULT 'SYSTEM'::character varying NOT NULL,
"reach_id" int2 DEFAULT 0 NOT NULL,
"title" varchar(100) NOT NULL,
"content" text NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO "public"."news" VALUES ('2', '2012-05-15 19:45:19.526117', 'PUBLIC', 'SYSTEM', '0', 'Noticia 1', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
INSERT INTO "public"."news" VALUES ('3', '2012-05-15 19:45:35.894149', 'PUBLIC', 'SYSTEM', '0', 'Noticia 2', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
INSERT INTO "public"."news" VALUES ('4', '2012-05-15 19:45:50.630408', 'PUBLIC', 'SYSTEM', '0', 'Noticia 3', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

-- ----------------------------
-- Table structure for "public"."nodes"
-- ----------------------------
DROP TABLE "public"."nodes";
CREATE TABLE "public"."nodes" (
"id" int4 DEFAULT nextval('nodes_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"zone" int4 DEFAULT 0 NOT NULL,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of nodes
-- ----------------------------
INSERT INTO "public"."nodes" VALUES ('1', 'TEST_NODE_1', '1', 't');
INSERT INTO "public"."nodes" VALUES ('2', 'TEST_NODE_2', '2', 't');

-- ----------------------------
-- Table structure for "public"."readings"
-- ----------------------------
DROP TABLE "public"."readings";
CREATE TABLE "public"."readings" (
"id" int8 DEFAULT nextval('readings_id_seq'::regclass) NOT NULL,
"sensor_id" int2 DEFAULT 0 NOT NULL,
"transductor_id" int2 DEFAULT 0 NOT NULL,
"timestamp" timestamp(6) DEFAULT now() NOT NULL,
"value" numeric DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of readings
-- ----------------------------

-- ----------------------------
-- Table structure for "public"."sensor_models"
-- ----------------------------
DROP TABLE "public"."sensor_models";
CREATE TABLE "public"."sensor_models" (
"id" int4 DEFAULT nextval('sensor_models_id_seq'::regclass) NOT NULL,
"name" varchar(100) DEFAULT ''::character varying NOT NULL,
"details" text NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sensor_models
-- ----------------------------
INSERT INTO "public"."sensor_models" VALUES ('1', 'Primus', 'Basic multi-transductor sensor, with 6 slots and 2xAA batteries');

-- ----------------------------
-- Table structure for "public"."sensors"
-- ----------------------------
DROP TABLE "public"."sensors";
CREATE TABLE "public"."sensors" (
"id" int4 DEFAULT nextval('sensors_id_seq'::regclass) NOT NULL,
"name" varchar(100) DEFAULT ''::character varying NOT NULL,
"hwaddress" varchar(16) DEFAULT ''::character varying NOT NULL,
"model" int4 DEFAULT 0 NOT NULL,
"group" int4 NOT NULL,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sensors
-- ----------------------------
INSERT INTO "public"."sensors" VALUES ('1', 'TEST_SENSOR_1', '00:00:01', '1', '1', 't');
INSERT INTO "public"."sensors" VALUES ('2', 'TEST_SENSOR_2', '00:00:02', '1', '1', 't');
INSERT INTO "public"."sensors" VALUES ('3', 'TEST_SENSOR_3', '00:00:03', '1', '1', 't');
INSERT INTO "public"."sensors" VALUES ('4', 'TEST_SENSOR_4', '00:00:04', '1', '2', 't');
INSERT INTO "public"."sensors" VALUES ('5', 'TEST_SENSOR_5', '00:00:05', '1', '2', 't');
INSERT INTO "public"."sensors" VALUES ('6', 'TEST_SENSOR_6', '00:00:06', '1', '2', 't');

-- ----------------------------
-- Table structure for "public"."sessions"
-- ----------------------------
DROP TABLE "public"."sessions";
CREATE TABLE "public"."sessions" (
"session_id" varchar(40) DEFAULT 0 NOT NULL,
"ip_address" varchar(16) DEFAULT 0 NOT NULL,
"user_agent" varchar(255) NOT NULL,
"last_activity" int4 DEFAULT 0 NOT NULL,
"user_data" text NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO "public"."sessions" VALUES ('df68759a10ea4265ac84250e54c99a39', '192.168.1.115', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', '1337139245', 'a:9:{s:9:"user_data";s:0:"";s:2:"ID";s:1:"1";s:4:"Name";s:7:"Usuario";s:5:"Login";s:7:"usuario";s:5:"Email";s:17:"usuario@localhost";s:4:"Role";s:4:"USER";s:5:"Phone";s:13:"+573014457549";s:3:"Key";s:40:"75e287feb97e2dcf8eab1edb29f33abdb2f5bc9b";s:11:"Preferences";s:59:"{"lastRole":"USER","currentRole":"USER","language":"es_CO"}";}');

-- ----------------------------
-- Table structure for "public"."settings"
-- ----------------------------
DROP TABLE "public"."settings";
CREATE TABLE "public"."settings" (
"id" int4 DEFAULT nextval('settings_id_seq'::regclass) NOT NULL,
"visible" bool DEFAULT true NOT NULL,
"name" varchar(20) DEFAULT ''::character varying NOT NULL,
"value" varchar(20) DEFAULT ''::character varying NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO "public"."settings" VALUES ('1', 't', 'title', 'MyrmeCore Dev');
INSERT INTO "public"."settings" VALUES ('2', 't', 'default_language', 'es_CO');
INSERT INTO "public"."settings" VALUES ('3', 't', 'auth_mode', 'DB');
INSERT INTO "public"."settings" VALUES ('4', 'f', 'hash_loops', '3');
INSERT INTO "public"."settings" VALUES ('5', 'f', 'salt_size', '4');
INSERT INTO "public"."settings" VALUES ('6', 't', 'number_news', '3');

-- ----------------------------
-- Table structure for "public"."strings"
-- ----------------------------
DROP TABLE "public"."strings";
CREATE TABLE "public"."strings" (
"id" int4 DEFAULT nextval('strings_id_seq'::regclass) NOT NULL,
"lang" varchar(8) DEFAULT ''::character varying NOT NULL,
"name" varchar(50) DEFAULT ''::character varying NOT NULL,
"text" varchar(100) DEFAULT NULL::character varying NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of strings
-- ----------------------------
INSERT INTO "public"."strings" VALUES ('1', 'es_CO', 'empty_username', 'No ha especificado un nombre de usuario');
INSERT INTO "public"."strings" VALUES ('2', 'es_CO', 'empty_password', 'No ha especificado una contraseña');
INSERT INTO "public"."strings" VALUES ('3', 'es_CO', 'wrong_username', 'Nombre de usuario incorrecto');
INSERT INTO "public"."strings" VALUES ('4', 'es_CO', 'wrong_password', 'Contraseña incorrecta');
INSERT INTO "public"."strings" VALUES ('5', 'es_CO', 'already_authenticated', 'Usted ya está autenticado');
INSERT INTO "public"."strings" VALUES ('6', 'es_CO', 'authentication_required', 'Se requiere autenticación');

-- ----------------------------
-- Table structure for "public"."transductor_types"
-- ----------------------------
DROP TABLE "public"."transductor_types";
CREATE TABLE "public"."transductor_types" (
"id" int4 DEFAULT nextval('transductor_types_id_seq'::regclass) NOT NULL,
"name" varchar(50) DEFAULT ''::character varying NOT NULL,
"size_bytes" int2 DEFAULT 1 NOT NULL,
"conversion" varchar(100) DEFAULT '(X)'::character varying NOT NULL,
"units" varchar(25) DEFAULT ''::character varying NOT NULL,
"details" text NOT NULL,
"picture" bytea
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of transductor_types
-- ----------------------------
INSERT INTO "public"."transductor_types" VALUES ('1', 'Batt Level', '2', '(X)', 'mV', 'Digi XBee S2C', null);
INSERT INTO "public"."transductor_types" VALUES ('2', 'Batt Level', '2', '(X * 1200 / 1024)', 'mV', 'Digi XBee S2 (through hole)', null);
INSERT INTO "public"."transductor_types" VALUES ('3', 'High Precision Temperature', '2', '(175.72 * X / 65536 - 46.85)', '°C', 'SHT21 Humidity and Temperature Sensor (Temp: 14 bits, Hum: 12bits)', null);
INSERT INTO "public"."transductor_types" VALUES ('4', 'High Precision Humidity', '2', '(125.00 * X / 65536 - 6)', '%', 'SHT21 Humidity and Temperature Sensor (Temp: 14 bits, Hum: 12bits)', null);

-- ----------------------------
-- Table structure for "public"."transductors"
-- ----------------------------
DROP TABLE "public"."transductors";
CREATE TABLE "public"."transductors" (
"id" int4 DEFAULT nextval('transductors_id_seq'::regclass) NOT NULL,
"type" int4 DEFAULT 0 NOT NULL,
"sensor" int4 DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of transductors
-- ----------------------------
INSERT INTO "public"."transductors" VALUES ('1', '2', '1');
INSERT INTO "public"."transductors" VALUES ('2', '3', '1');
INSERT INTO "public"."transductors" VALUES ('3', '4', '1');
INSERT INTO "public"."transductors" VALUES ('4', '2', '2');
INSERT INTO "public"."transductors" VALUES ('5', '3', '2');
INSERT INTO "public"."transductors" VALUES ('6', '4', '2');
INSERT INTO "public"."transductors" VALUES ('7', '2', '3');
INSERT INTO "public"."transductors" VALUES ('8', '3', '3');
INSERT INTO "public"."transductors" VALUES ('9', '4', '3');
INSERT INTO "public"."transductors" VALUES ('10', '2', '4');
INSERT INTO "public"."transductors" VALUES ('11', '3', '4');
INSERT INTO "public"."transductors" VALUES ('12', '4', '4');
INSERT INTO "public"."transductors" VALUES ('13', '2', '5');
INSERT INTO "public"."transductors" VALUES ('14', '3', '5');
INSERT INTO "public"."transductors" VALUES ('15', '4', '5');
INSERT INTO "public"."transductors" VALUES ('16', '2', '6');
INSERT INTO "public"."transductors" VALUES ('17', '3', '6');
INSERT INTO "public"."transductors" VALUES ('18', '4', '6');

-- ----------------------------
-- Table structure for "public"."users"
-- ----------------------------
DROP TABLE "public"."users";
CREATE TABLE "public"."users" (
"id" int4 DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
"name" varchar(100) NOT NULL,
"login" varchar(10) NOT NULL,
"email" varchar(100) NOT NULL,
"salt" varchar(8) NOT NULL,
"hash" varchar(128) NOT NULL,
"role" varchar(10) NOT NULL,
"phone" varchar(20) DEFAULT ''::character varying NOT NULL,
"preferences" text DEFAULT ''::character varying NOT NULL,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES ('1', 'Usuario', 'usuario', 'usuario@localhost', 'd1u8', '46bab3ac3823c6464b654c1a3eae38a38d2e0f677e3d5297345dbdd8d631c651798a6a853af27e264b7dd6fa45ffb3999d96e2b29c95f7c5baa14df394c2bdd6', 'USER', '+573014457549', '{"lastRole":"USER","currentRole":"USER","language":"es_CO"}', 't');

-- ----------------------------
-- Table structure for "public"."zones"
-- ----------------------------
DROP TABLE "public"."zones";
CREATE TABLE "public"."zones" (
"id" int4 DEFAULT nextval('zones_id_seq'::regclass) NOT NULL,
"name" varchar(50) DEFAULT ''::character varying NOT NULL,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of zones
-- ----------------------------
INSERT INTO "public"."zones" VALUES ('1', 'TEST_ZONE_1', 't');
INSERT INTO "public"."zones" VALUES ('2', 'TEST_ZONE_2', 't');

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."api_logs_id_seq" OWNED BY "api_logs"."id";
ALTER SEQUENCE "public"."groups_id_seq" OWNED BY "groups"."id";
ALTER SEQUENCE "public"."news_id_seq" OWNED BY "news"."id";
ALTER SEQUENCE "public"."nodes_id_seq" OWNED BY "nodes"."id";
ALTER SEQUENCE "public"."readings_id_seq" OWNED BY "readings"."id";
ALTER SEQUENCE "public"."sensor_models_id_seq" OWNED BY "sensor_models"."id";
ALTER SEQUENCE "public"."sensors_id_seq" OWNED BY "sensors"."id";
ALTER SEQUENCE "public"."settings_id_seq" OWNED BY "settings"."id";
ALTER SEQUENCE "public"."strings_id_seq" OWNED BY "strings"."id";
ALTER SEQUENCE "public"."transductor_types_id_seq" OWNED BY "transductor_types"."id";
ALTER SEQUENCE "public"."transductors_id_seq" OWNED BY "transductors"."id";
ALTER SEQUENCE "public"."users_id_seq" OWNED BY "users"."id";
ALTER SEQUENCE "public"."zones_id_seq" OWNED BY "zones"."id";

-- ----------------------------
-- Primary Key structure for table "public"."api_keys"
-- ----------------------------
ALTER TABLE "public"."api_keys" ADD PRIMARY KEY ("key");

-- ----------------------------
-- Primary Key structure for table "public"."api_logs"
-- ----------------------------
ALTER TABLE "public"."api_logs" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."groups"
-- ----------------------------
ALTER TABLE "public"."groups" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table news
-- ----------------------------
CREATE INDEX "date_idx" ON "public"."news" USING btree ("date");
CREATE INDEX "reach_idx" ON "public"."news" USING btree ("reach", "reach_id");

-- ----------------------------
-- Primary Key structure for table "public"."news"
-- ----------------------------
ALTER TABLE "public"."news" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."nodes"
-- ----------------------------
ALTER TABLE "public"."nodes" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table readings
-- ----------------------------
CREATE INDEX "sensor_id_idx" ON "public"."readings" USING btree ("sensor_id");
CREATE INDEX "timestamp_idx" ON "public"."readings" USING btree ("timestamp");
CREATE INDEX "transductor_id_idx" ON "public"."readings" USING btree ("transductor_id");

-- ----------------------------
-- Primary Key structure for table "public"."readings"
-- ----------------------------
ALTER TABLE "public"."readings" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."sensor_models"
-- ----------------------------
ALTER TABLE "public"."sensor_models" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sensors
-- ----------------------------
CREATE INDEX "model_idx" ON "public"."sensors" USING btree ("model");

-- ----------------------------
-- Primary Key structure for table "public"."sensors"
-- ----------------------------
ALTER TABLE "public"."sensors" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."sessions"
-- ----------------------------
ALTER TABLE "public"."sessions" ADD PRIMARY KEY ("session_id");

-- ----------------------------
-- Primary Key structure for table "public"."settings"
-- ----------------------------
ALTER TABLE "public"."settings" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table strings
-- ----------------------------
CREATE INDEX "name_idx" ON "public"."strings" USING btree ("name");

-- ----------------------------
-- Primary Key structure for table "public"."strings"
-- ----------------------------
ALTER TABLE "public"."strings" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."transductor_types"
-- ----------------------------
ALTER TABLE "public"."transductor_types" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."transductors"
-- ----------------------------
ALTER TABLE "public"."transductors" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE INDEX "enabled_idx" ON "public"."users" USING btree ("preferences");
CREATE UNIQUE INDEX "login_idx" ON "public"."users" USING btree ("login");
CREATE INDEX "role_idx" ON "public"."users" USING btree ("role");

-- ----------------------------
-- Primary Key structure for table "public"."users"
-- ----------------------------
ALTER TABLE "public"."users" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."zones"
-- ----------------------------
ALTER TABLE "public"."zones" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Key structure for table "public"."groups"
-- ----------------------------
ALTER TABLE "public"."groups" ADD FOREIGN KEY ("node") REFERENCES "public"."nodes" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."nodes"
-- ----------------------------
ALTER TABLE "public"."nodes" ADD FOREIGN KEY ("zone") REFERENCES "public"."zones" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."readings"
-- ----------------------------
ALTER TABLE "public"."readings" ADD FOREIGN KEY ("sensor_id") REFERENCES "public"."sensors" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."readings" ADD FOREIGN KEY ("transductor_id") REFERENCES "public"."transductors" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."sensors"
-- ----------------------------
ALTER TABLE "public"."sensors" ADD FOREIGN KEY ("model") REFERENCES "public"."sensor_models" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."sensors" ADD FOREIGN KEY ("group") REFERENCES "public"."groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."transductors"
-- ----------------------------
ALTER TABLE "public"."transductors" ADD FOREIGN KEY ("type") REFERENCES "public"."transductor_types" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."transductors" ADD FOREIGN KEY ("sensor") REFERENCES "public"."sensors" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
