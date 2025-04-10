-- create dimension location_dim
CREATE TABLE IF NOT EXISTS location_dim (
    lga_code INT PRIMARY KEY,
    state VARCHAR(50),
    lga_name VARCHAR(100)
);

-- create dimension date_dim
CREATE TABLE IF NOT EXISTS date_dim (
    dateID INT PRIMARY KEY,
    year INT,
    month INT
);

-- create dimension rush_dim
CREATE TABLE IF NOT EXISTS rush_dim (
    rushID INT PRIMARY KEY,
    time_cat VARCHAR(20)
);

-- create dimension age_dim
CREATE TABLE IF NOT EXISTS age_dim (
    ageID INT PRIMARY KEY,
    age_group VARCHAR(20)
);

-- create dimension daytime_dim
CREATE TABLE IF NOT EXISTS daytime_dim (
    daytimeID INT PRIMARY KEY,
    time_of_day VARCHAR(20)
);

-- create dimension road_type_dim
CREATE TABLE IF NOT EXISTS road_type_dim (
    road_typeID INT PRIMARY KEY,
    road_type VARCHAR(30)
);

-- create dimension speed_limit_dim
CREATE TABLE IF NOT EXISTS speed_limit_dim (
    speed_limitID INT PRIMARY KEY,
    speed_limit VARCHAR(20)
);

-- create dimension holiday_dim
CREATE TABLE IF NOT EXISTS holiday_dim (
    holidayID INT PRIMARY KEY,
    holiday VARCHAR(50)
);

-- create dimension vehicle_type_dim
CREATE TABLE IF NOT EXISTS vehicle_type_dim (
    vehicle_typeID INT PRIMARY KEY,
    vehicle_type_involved VARCHAR(50)
);

-- create fact table fatalities_df
CREATE TABLE IF NOT EXISTS fatalities_df(
    crash_ID INT,
    victim_number INT,
    lga_code INT,
    dateID INT,
    rushID INT,
    ageID INT,
    daytimeID INT,
    road_typeID INT,
    speed_limitID INT,
    holidayID INT,
    vehicle_typeID INT,
    -- WHAT IS OUR MEASURE? OR we have FACTLESS FACT TABLE?
    -- foreign keys
    FOREIGN KEY (lga_code) REFERENCES location_dim(lga_code),
    FOREIGN KEY (dateID) REFERENCES date_dim(dateID),
    FOREIGN KEY (rushID) REFERENCES rush_dim(rushID),
    FOREIGN KEY (ageID) REFERENCES age_dim(ageID),
    FOREIGN KEY (daytimeID) REFERENCES daytime_dim(daytimeID),
    FOREIGN KEY (road_typeID) REFERENCES road_type_dim(road_typeID),
    FOREIGN KEY (speed_limitID) REFERENCES speed_limit_dim(speed_limitID),
    FOREIGN KEY (holidayID) REFERENCES holiday_dim(holidayID),
    FOREIGN KEY (vehicle_typeID) REFERENCES vehicle_type_dim(vehicle_typeID),
    -- primary key
    PRIMARY KEY (crash_ID, victim_number)
