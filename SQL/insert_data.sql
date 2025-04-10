-- insert data into dimension tables
-- "location_dim", "date_dim", "rush_dim", "age_dim", "daytime_dim", "road_type_dim", "speed_limit_dim", "holiday_dim", "vehicle_type_dim", "fatalities_df"

COPY location_dim FROM '/tmp/location_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY date_dim FROM '/tmp/date_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY rush_dim FROM '/tmp/rush_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY age_dim FROM '/tmp/age_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY daytime_dim FROM '/tmp/daytime_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY road_type_dim FROM '/tmp/road_type_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY speed_limit_dim FROM '/tmp/speed_limit_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY holiday_dim FROM '/tmp/holiday_dim.csv' WITH (FORMAT CSV, HEADER FALSE);
COPY vehicle_type_dim FROM '/tmp/vehicle_type_dim.csv' WITH (FORMAT CSV, HEADER FALSE);

COPY fatalities_df FROM '/tmp/fatalities_df.csv' WITH (FORMAT CSV, HEADER FALSE);

