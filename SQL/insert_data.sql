-- insert data into dimension tables
-- "location_dim", "date_dim", "rush_dim", "age_dim", "daytime_dim", "road_type_dim", "speed_limit_dim", "holiday_dim", "vehicle_type_dim", "fatalities_df"

-- DELETE ALL DATA FROM DIMENSION TABLES

DELETE FROM fatalities_fact;
DELETE FROM population_fact;
DELETE FROM location_dim;
DELETE FROM date_dim;
DELETE FROM rush_dim;
DELETE FROM age_dim;
DELETE FROM daytime_dim;
DELETE FROM road_type_dim;
DELETE FROM speed_limit_dim;
DELETE FROM holiday_dim;
DELETE FROM vehicle_type_dim;



COPY location_dim FROM '/tmp/location_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY date_dim FROM '/tmp/date_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY rush_dim FROM '/tmp/rush_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY age_dim FROM '/tmp/age_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY daytime_dim FROM '/tmp/daytime_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY road_type_dim FROM '/tmp/road_type_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY speed_limit_dim FROM '/tmp/speed_limit_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY holiday_dim FROM '/tmp/holiday_dim.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY vehicle_type_dim FROM '/tmp/vehicle_type_dim.csv' WITH (FORMAT CSV, HEADER TRUE);

COPY fatalities_fact FROM '/tmp/fatalities_fact.csv' WITH (FORMAT CSV, HEADER TRUE);
COPY population_fact FROM '/tmp/population_fact.csv' WITH (FORMAT CSV, HEADER TRUE);

