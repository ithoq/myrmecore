CREATE OR REPLACE FUNCTION "public"."readings_insert_trigger"()
  RETURNS "pg_catalog"."trigger" AS $BODY$DECLARE
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
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
;