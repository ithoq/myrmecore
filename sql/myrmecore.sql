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
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."transductor_types_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."transductor_types_id_seq";
CREATE SEQUENCE "public"."transductor_types_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for "public"."transductors_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."transductors_id_seq";
CREATE SEQUENCE "public"."transductors_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
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
 START 1
 CACHE 1;

-- ----------------------------
-- Table structure for "public"."groups"
-- ----------------------------
DROP TABLE "public"."groups";
CREATE TABLE "public"."groups" (
"id" int4 DEFAULT nextval('groups_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"node" int4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of groups
-- ----------------------------

-- ----------------------------
-- Table structure for "public"."nodes"
-- ----------------------------
DROP TABLE "public"."nodes";
CREATE TABLE "public"."nodes" (
"id" int4 DEFAULT nextval('nodes_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"zone" int4 DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of nodes
-- ----------------------------

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

-- ----------------------------
-- Table structure for "public"."sensors"
-- ----------------------------
DROP TABLE "public"."sensors";
CREATE TABLE "public"."sensors" (
"id" int4 DEFAULT nextval('sensors_id_seq'::regclass) NOT NULL,
"name" varchar(100) DEFAULT ''::character varying NOT NULL,
"hwaddress" varchar(16) DEFAULT ''::character varying NOT NULL,
"model" int4 DEFAULT 0 NOT NULL,
"group" int4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sensors
-- ----------------------------

-- ----------------------------
-- Table structure for "public"."sessions"
-- ----------------------------
DROP TABLE "public"."sessions";
CREATE TABLE "public"."sessions" (
"session_id" varchar(40) DEFAULT 0 NOT NULL,
"ip_address" varchar(16) DEFAULT 0 NOT NULL,
"user_agent" varchar(100) NOT NULL,
"last_activity" int4 DEFAULT 0 NOT NULL,
"user_data" text NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of sessions
-- ----------------------------

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
"preferences" text,
"enabled" bool DEFAULT true NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES ('1', 'Usuario', 'usuario', 'usuario@localhost', 'd1u8', '46bab3ac3823c6464b654c1a3eae38a38d2e0f677e3d5297345dbdd8d631c651798a6a853af27e264b7dd6fa45ffb3999d96e2b29c95f7c5baa14df394c2bdd6', 'USER', null, 't');

-- ----------------------------
-- Table structure for "public"."zones"
-- ----------------------------
DROP TABLE "public"."zones";
CREATE TABLE "public"."zones" (
"id" int4 DEFAULT nextval('zones_id_seq'::regclass) NOT NULL,
"name" varchar(50) DEFAULT ''::character varying NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of zones
-- ----------------------------

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."groups_id_seq" OWNED BY "groups"."id";
ALTER SEQUENCE "public"."nodes_id_seq" OWNED BY "nodes"."id";
ALTER SEQUENCE "public"."readings_id_seq" OWNED BY "readings"."id";
ALTER SEQUENCE "public"."sensor_models_id_seq" OWNED BY "sensor_models"."id";
ALTER SEQUENCE "public"."sensors_id_seq" OWNED BY "sensors"."id";
ALTER SEQUENCE "public"."transductor_types_id_seq" OWNED BY "transductor_types"."id";
ALTER SEQUENCE "public"."transductors_id_seq" OWNED BY "transductors"."id";
ALTER SEQUENCE "public"."users_id_seq" OWNED BY "users"."id";
ALTER SEQUENCE "public"."zones_id_seq" OWNED BY "zones"."id";

-- ----------------------------
-- Primary Key structure for table "public"."groups"
-- ----------------------------
ALTER TABLE "public"."groups" ADD PRIMARY KEY ("id");

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
CREATE INDEX "enabled_idx" ON "public"."users" USING btree ("enabled");
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
ALTER TABLE "public"."readings" ADD FOREIGN KEY ("transductor_id") REFERENCES "public"."transductors" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."readings" ADD FOREIGN KEY ("sensor_id") REFERENCES "public"."sensors" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."sensors"
-- ----------------------------
ALTER TABLE "public"."sensors" ADD FOREIGN KEY ("group") REFERENCES "public"."groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."sensors" ADD FOREIGN KEY ("model") REFERENCES "public"."sensor_models" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."transductors"
-- ----------------------------
ALTER TABLE "public"."transductors" ADD FOREIGN KEY ("type") REFERENCES "public"."transductor_types" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
