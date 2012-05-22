--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: readings_insert_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION readings_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
current_month INTEGER;
BEGIN
current_month := date_part('month', NEW.timestamp);
    IF current_month = 1 THEN
        INSERT INTO readings_january VALUES (NEW.*);
    ELSIF current_month = 2 THEN
        INSERT INTO readings_february VALUES (NEW.*);
    ELSIF current_month = 3 THEN
				INSERT INTO readings_march VALUES (NEW.*);
    ELSIF current_month = 4 THEN
        INSERT INTO readings_april VALUES (NEW.*);
    ELSIF current_month = 5 THEN
				INSERT INTO readings_may VALUES (NEW.*);
    ELSIF current_month = 6 THEN
        INSERT INTO readings_june VALUES (NEW.*);
    ELSIF current_month = 7 THEN
				INSERT INTO readings_july VALUES (NEW.*);
    ELSIF current_month = 8 THEN
        INSERT INTO readings_august VALUES (NEW.*);
    ELSIF current_month = 9 THEN
				INSERT INTO readings_september VALUES (NEW.*);
    ELSIF current_month = 10 THEN
        INSERT INTO readings_october VALUES (NEW.*);
    ELSIF current_month = 11 THEN
				INSERT INTO readings_november VALUES (NEW.*);
    ELSIF current_month = 12 THEN
        INSERT INTO readings_december VALUES (NEW.*);
    ELSE
        RAISE EXCEPTION 'Date out of range.';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.readings_insert_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: action_sets; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE action_sets (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.action_sets OWNER TO postgres;

--
-- Name: action_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE action_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.action_sets_id_seq OWNER TO postgres;

--
-- Name: action_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE action_sets_id_seq OWNED BY action_sets.id;


--
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action character varying(32) DEFAULT ''::character varying NOT NULL,
    args character varying NOT NULL,
    set integer DEFAULT 0 NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.actions OWNER TO postgres;

--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actions_id_seq OWNER TO postgres;

--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE api_keys (
    key character varying(40) DEFAULT ''::character varying NOT NULL,
    level smallint DEFAULT 0 NOT NULL,
    ignore_limits smallint DEFAULT 0 NOT NULL,
    date_created integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.api_keys OWNER TO postgres;

--
-- Name: api_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE api_logs_id_seq
    START WITH 113
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_logs_id_seq OWNER TO postgres;

--
-- Name: api_logs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE api_logs (
    id integer DEFAULT nextval('api_logs_id_seq'::regclass) NOT NULL,
    uri character varying(255) DEFAULT ''::character varying NOT NULL,
    method character varying(255) DEFAULT ''::character varying NOT NULL,
    params text NOT NULL,
    api_key character varying(40) DEFAULT ''::character varying NOT NULL,
    ip_address inet NOT NULL,
    "time" integer DEFAULT 0 NOT NULL,
    authorized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.api_logs OWNER TO postgres;

--
-- Name: event_classes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE event_classes (
    id integer NOT NULL,
    transductor_class integer DEFAULT 0 NOT NULL,
    relation character varying DEFAULT ''::character varying NOT NULL,
    value numeric DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    action_set integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.event_classes OWNER TO postgres;

--
-- Name: event_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_classes_id_seq OWNER TO postgres;

--
-- Name: event_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_classes_id_seq OWNED BY event_classes.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    reading bigint DEFAULT 0 NOT NULL,
    class integer DEFAULT 0 NOT NULL,
    action_set smallint DEFAULT 0 NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    cleared boolean DEFAULT false NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE groups (
    id integer DEFAULT nextval('groups_id_seq'::regclass) NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    node integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE news_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_id_seq OWNER TO postgres;

--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE news (
    id integer DEFAULT nextval('news_id_seq'::regclass) NOT NULL,
    date timestamp(6) without time zone DEFAULT now() NOT NULL,
    role character varying(8) DEFAULT 'PUBLIC'::character varying NOT NULL,
    reach character varying(8) DEFAULT 'SYSTEM'::character varying NOT NULL,
    reach_id smallint DEFAULT 0 NOT NULL,
    title character varying(100) NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE nodes_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nodes_id_seq OWNER TO postgres;

--
-- Name: nodes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nodes (
    id integer DEFAULT nextval('nodes_id_seq'::regclass) NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    zone integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.nodes OWNER TO postgres;

--
-- Name: readings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE readings_id_seq
    START WITH 100019
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.readings_id_seq OWNER TO postgres;

--
-- Name: readings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings (
    id bigint DEFAULT nextval('readings_id_seq'::regclass) NOT NULL,
    sensor_id smallint DEFAULT 0 NOT NULL,
    transductor_id smallint DEFAULT 0 NOT NULL,
    "timestamp" timestamp(6) without time zone DEFAULT now() NOT NULL,
    value numeric DEFAULT 0 NOT NULL
);


ALTER TABLE public.readings OWNER TO postgres;

--
-- Name: readings_april; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_april (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_april OWNER TO postgres;

--
-- Name: readings_august; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_august (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_august OWNER TO postgres;

--
-- Name: readings_december; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_december (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_december OWNER TO postgres;

--
-- Name: readings_february; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_february (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_february OWNER TO postgres;

--
-- Name: readings_january; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_january (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_january OWNER TO postgres;

--
-- Name: readings_july; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_july (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_july OWNER TO postgres;

--
-- Name: readings_june; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_june (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_june OWNER TO postgres;

--
-- Name: readings_march; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_march (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_march OWNER TO postgres;

--
-- Name: readings_may; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_may (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_may OWNER TO postgres;

--
-- Name: readings_november; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_november (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_november OWNER TO postgres;

--
-- Name: readings_october; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_october (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_october OWNER TO postgres;

--
-- Name: readings_september; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE readings_september (
    id bigint DEFAULT nextval('readings_id_seq'::regclass),
    sensor_id smallint DEFAULT 0,
    transductor_id smallint DEFAULT 0,
    "timestamp" timestamp(6) without time zone DEFAULT now(),
    value numeric DEFAULT 0
)
INHERITS (readings);


ALTER TABLE public.readings_september OWNER TO postgres;

--
-- Name: sensor_models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sensor_models_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sensor_models_id_seq OWNER TO postgres;

--
-- Name: sensor_models; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sensor_models (
    id integer DEFAULT nextval('sensor_models_id_seq'::regclass) NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    details text NOT NULL
);


ALTER TABLE public.sensor_models OWNER TO postgres;

--
-- Name: sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sensors_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sensors_id_seq OWNER TO postgres;

--
-- Name: sensors; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sensors (
    id integer DEFAULT nextval('sensors_id_seq'::regclass) NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    hwaddress character varying(16) DEFAULT ''::character varying NOT NULL,
    model integer DEFAULT 0 NOT NULL,
    "group" integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.sensors OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sessions (
    session_id character varying(40) DEFAULT 0 NOT NULL,
    ip_address character varying(16) DEFAULT 0 NOT NULL,
    user_agent character varying(255) NOT NULL,
    last_activity integer DEFAULT 0 NOT NULL,
    user_data text NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE settings_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE settings (
    id integer DEFAULT nextval('settings_id_seq'::regclass) NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    name character varying(20) DEFAULT ''::character varying NOT NULL,
    value character varying(20) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: strings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE strings_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strings_id_seq OWNER TO postgres;

--
-- Name: strings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE strings (
    id integer DEFAULT nextval('strings_id_seq'::regclass) NOT NULL,
    lang character varying(8) DEFAULT ''::character varying NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL,
    text character varying(100) DEFAULT NULL::character varying NOT NULL
);


ALTER TABLE public.strings OWNER TO postgres;

--
-- Name: transductor_class; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE transductor_class (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.transductor_class OWNER TO postgres;

--
-- Name: transductor_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transductor_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transductor_class_id_seq OWNER TO postgres;

--
-- Name: transductor_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE transductor_class_id_seq OWNED BY transductor_class.id;


--
-- Name: transductor_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transductor_types_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transductor_types_id_seq OWNER TO postgres;

--
-- Name: transductor_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE transductor_types (
    id integer DEFAULT nextval('transductor_types_id_seq'::regclass) NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL,
    size_bytes smallint DEFAULT 1 NOT NULL,
    conversion character varying(100) DEFAULT '(X)'::character varying NOT NULL,
    units character varying(25) DEFAULT ''::character varying NOT NULL,
    details text NOT NULL,
    picture bytea
);


ALTER TABLE public.transductor_types OWNER TO postgres;

--
-- Name: transductors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transductors_id_seq
    START WITH 19
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transductors_id_seq OWNER TO postgres;

--
-- Name: transductors; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE transductors (
    id integer DEFAULT nextval('transductors_id_seq'::regclass) NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    sensor integer DEFAULT 0 NOT NULL,
    class integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.transductors OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    login character varying(10) NOT NULL,
    email character varying(100) NOT NULL,
    salt character varying(8) NOT NULL,
    hash character varying(128) NOT NULL,
    role character varying(10) NOT NULL,
    phone character varying(20) DEFAULT ''::character varying NOT NULL,
    preferences text DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE zones_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zones_id_seq OWNER TO postgres;

--
-- Name: zones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE zones (
    id integer DEFAULT nextval('zones_id_seq'::regclass) NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.zones OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_sets ALTER COLUMN id SET DEFAULT nextval('action_sets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_classes ALTER COLUMN id SET DEFAULT nextval('event_classes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transductor_class ALTER COLUMN id SET DEFAULT nextval('transductor_class_id_seq'::regclass);


--
-- Name: action_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY action_sets
    ADD CONSTRAINT action_sets_pkey PRIMARY KEY (id);


--
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (key);


--
-- Name: api_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY api_logs
    ADD CONSTRAINT api_logs_pkey PRIMARY KEY (id);


--
-- Name: event_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event_classes
    ADD CONSTRAINT event_classes_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: readings_april_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_april
    ADD CONSTRAINT readings_april_pkey PRIMARY KEY (id);


--
-- Name: readings_august_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_august
    ADD CONSTRAINT readings_august_pkey PRIMARY KEY (id);


--
-- Name: readings_december_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_december
    ADD CONSTRAINT readings_december_pkey PRIMARY KEY (id);


--
-- Name: readings_february_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_february
    ADD CONSTRAINT readings_february_pkey PRIMARY KEY (id);


--
-- Name: readings_january_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_january
    ADD CONSTRAINT readings_january_pkey PRIMARY KEY (id);


--
-- Name: readings_july_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_july
    ADD CONSTRAINT readings_july_pkey PRIMARY KEY (id);


--
-- Name: readings_june_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_june
    ADD CONSTRAINT readings_june_pkey PRIMARY KEY (id);


--
-- Name: readings_march_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_march
    ADD CONSTRAINT readings_march_pkey PRIMARY KEY (id);


--
-- Name: readings_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_master_pkey PRIMARY KEY (id);


--
-- Name: readings_may_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_may
    ADD CONSTRAINT readings_may_pkey PRIMARY KEY (id);


--
-- Name: readings_november_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_november
    ADD CONSTRAINT readings_november_pkey PRIMARY KEY (id);


--
-- Name: readings_october_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_october
    ADD CONSTRAINT readings_october_pkey PRIMARY KEY (id);


--
-- Name: readings_september_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY readings_september
    ADD CONSTRAINT readings_september_pkey PRIMARY KEY (id);


--
-- Name: sensor_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sensor_models
    ADD CONSTRAINT sensor_models_pkey PRIMARY KEY (id);


--
-- Name: sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: strings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY strings
    ADD CONSTRAINT strings_pkey PRIMARY KEY (id);


--
-- Name: transductor_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transductor_class
    ADD CONSTRAINT transductor_class_pkey PRIMARY KEY (id);


--
-- Name: transductor_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transductor_types
    ADD CONSTRAINT transductor_types_pkey PRIMARY KEY (id);


--
-- Name: transductors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transductors
    ADD CONSTRAINT transductors_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: april_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX april_sensor_id_idx ON readings_april USING btree (sensor_id);


--
-- Name: april_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX april_timestamp_idx ON readings_april USING btree ("timestamp");


--
-- Name: april_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX april_transductor_id_idx ON readings_april USING btree (transductor_id);


--
-- Name: august_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX august_sensor_id_idx ON readings_august USING btree (sensor_id);


--
-- Name: august_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX august_timestamp_idx ON readings_august USING btree ("timestamp");


--
-- Name: august_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX august_transductor_id_idx ON readings_august USING btree (transductor_id);


--
-- Name: date_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX date_idx ON news USING btree (date);


--
-- Name: december_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX december_sensor_id_idx ON readings_december USING btree (sensor_id);


--
-- Name: december_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX december_timestamp_idx ON readings_december USING btree ("timestamp");


--
-- Name: december_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX december_transductor_id_idx ON readings_december USING btree (transductor_id);


--
-- Name: enabled_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX enabled_idx ON users USING btree (preferences);


--
-- Name: events_action_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX events_action_idx ON events USING btree (action_set);


--
-- Name: events_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX events_class_idx ON events USING btree (class);


--
-- Name: events_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX events_timestamp_idx ON events USING btree ("timestamp");


--
-- Name: february_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX february_sensor_id_idx ON readings_february USING btree (sensor_id);


--
-- Name: february_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX february_timestamp_idx ON readings_february USING btree ("timestamp");


--
-- Name: february_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX february_transductor_id_idx ON readings_february USING btree (transductor_id);


--
-- Name: january_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX january_sensor_id_idx ON readings_january USING btree (sensor_id);


--
-- Name: january_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX january_timestamp_idx ON readings_january USING btree ("timestamp");


--
-- Name: january_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX january_transductor_id_idx ON readings_january USING btree (transductor_id);


--
-- Name: july_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX july_sensor_id_idx ON readings_july USING btree (sensor_id);


--
-- Name: july_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX july_timestamp_idx ON readings_july USING btree ("timestamp");


--
-- Name: july_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX july_transductor_id_idx ON readings_july USING btree (transductor_id);


--
-- Name: june_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX june_sensor_id_idx ON readings_june USING btree (sensor_id);


--
-- Name: june_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX june_timestamp_idx ON readings_june USING btree ("timestamp");


--
-- Name: june_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX june_transductor_id_idx ON readings_june USING btree (transductor_id);


--
-- Name: login_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX login_idx ON users USING btree (login);


--
-- Name: march_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX march_sensor_id_idx ON readings_march USING btree (sensor_id);


--
-- Name: march_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX march_timestamp_idx ON readings_march USING btree ("timestamp");


--
-- Name: march_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX march_transductor_id_idx ON readings_march USING btree (transductor_id);


--
-- Name: may_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX may_sensor_id_idx ON readings_may USING btree (sensor_id);


--
-- Name: may_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX may_timestamp_idx ON readings_may USING btree ("timestamp");


--
-- Name: may_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX may_transductor_id_idx ON readings_may USING btree (transductor_id);


--
-- Name: model_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX model_idx ON sensors USING btree (model);


--
-- Name: name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX name_idx ON strings USING btree (name);


--
-- Name: november_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX november_sensor_id_idx ON readings_november USING btree (sensor_id);


--
-- Name: november_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX november_timestamp_idx ON readings_november USING btree ("timestamp");


--
-- Name: november_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX november_transductor_id_idx ON readings_november USING btree (transductor_id);


--
-- Name: october_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX october_sensor_id_idx ON readings_october USING btree (sensor_id);


--
-- Name: october_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX october_timestamp_idx ON readings_october USING btree ("timestamp");


--
-- Name: october_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX october_transductor_id_idx ON readings_october USING btree (transductor_id);


--
-- Name: reach_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX reach_idx ON news USING btree (reach, reach_id);


--
-- Name: role_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX role_idx ON users USING btree (role);


--
-- Name: sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sensor_id_idx ON readings USING btree (sensor_id);


--
-- Name: september_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX september_sensor_id_idx ON readings_september USING btree (sensor_id);


--
-- Name: september_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX september_timestamp_idx ON readings_september USING btree ("timestamp");


--
-- Name: september_transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX september_transductor_id_idx ON readings_september USING btree (transductor_id);


--
-- Name: timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX timestamp_idx ON readings USING btree ("timestamp");


--
-- Name: transductor_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX transductor_id_idx ON readings USING btree (transductor_id);


--
-- Name: zone_enabled_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX zone_enabled_idx ON zones USING btree (enabled);


--
-- Name: insert_readings_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_readings_trigger BEFORE INSERT ON readings FOR EACH ROW EXECUTE PROCEDURE readings_insert_trigger();


--
-- Name: action_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT action_fkey FOREIGN KEY (action_set) REFERENCES action_sets(id);


--
-- Name: action_set_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_classes
    ADD CONSTRAINT action_set_fkey FOREIGN KEY (action_set) REFERENCES action_sets(id);


--
-- Name: class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT class_fkey FOREIGN KEY (class) REFERENCES event_classes(id);


--
-- Name: groups_node_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_node_fkey FOREIGN KEY (node) REFERENCES nodes(id);


--
-- Name: nodes_zone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_zone_fkey FOREIGN KEY (zone) REFERENCES zones(id);


--
-- Name: reading_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT reading_fkey FOREIGN KEY (reading) REFERENCES readings(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_april
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_august
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_december
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_february
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_january
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_july
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_june
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_march
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_may
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_november
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_october
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_september
    ADD CONSTRAINT readings_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES sensors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_april
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_august
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_december
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_february
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_january
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_july
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_june
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_march
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_may
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_november
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_october
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: readings_transductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY readings_september
    ADD CONSTRAINT readings_transductor_id_fkey FOREIGN KEY (transductor_id) REFERENCES transductors(id);


--
-- Name: sensors_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sensors
    ADD CONSTRAINT sensors_group_fkey FOREIGN KEY ("group") REFERENCES groups(id);


--
-- Name: sensors_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sensors
    ADD CONSTRAINT sensors_model_fkey FOREIGN KEY (model) REFERENCES sensor_models(id);


--
-- Name: set_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT set_fkey FOREIGN KEY (set) REFERENCES action_sets(id);


--
-- Name: transductor_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_classes
    ADD CONSTRAINT transductor_class_fkey FOREIGN KEY (transductor_class) REFERENCES transductor_class(id);


--
-- Name: transductors_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transductors
    ADD CONSTRAINT transductors_class_fkey FOREIGN KEY (class) REFERENCES transductor_class(id);


--
-- Name: transductors_sensor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transductors
    ADD CONSTRAINT transductors_sensor_fkey FOREIGN KEY (sensor) REFERENCES sensors(id);


--
-- Name: transductors_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transductors
    ADD CONSTRAINT transductors_type_fkey FOREIGN KEY (type) REFERENCES transductor_types(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

