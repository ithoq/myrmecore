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
-- Table structure for "public"."groups"
-- ----------------------------
DROP TABLE "public"."groups";
CREATE TABLE "public"."groups" (
"id" int4 DEFAULT nextval('groups_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"location" int4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of groups
-- ----------------------------

-- ----------------------------
-- Table structure for "public"."locations"
-- ----------------------------
DROP TABLE "public"."locations";
CREATE TABLE "public"."locations" (
"id" int4 DEFAULT nextval('locations_id_seq'::regclass) NOT NULL,
"name" varchar DEFAULT ''::character varying NOT NULL,
"latitude" numeric DEFAULT 0 NOT NULL,
"longitud" numeric DEFAULT 0 NOT NULL,
"height" int2 DEFAULT 0 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of locations
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

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."groups_id_seq" OWNED BY "groups"."id";
ALTER SEQUENCE "public"."locations_id_seq" OWNED BY "locations"."id";
ALTER SEQUENCE "public"."users_id_seq" OWNED BY "users"."id";

-- ----------------------------
-- Primary Key structure for table "public"."groups"
-- ----------------------------
ALTER TABLE "public"."groups" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."locations"
-- ----------------------------
ALTER TABLE "public"."locations" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."sessions"
-- ----------------------------
ALTER TABLE "public"."sessions" ADD PRIMARY KEY ("session_id");

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
-- Foreign Key structure for table "public"."groups"
-- ----------------------------
ALTER TABLE "public"."groups" ADD FOREIGN KEY ("location") REFERENCES "public"."locations" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
