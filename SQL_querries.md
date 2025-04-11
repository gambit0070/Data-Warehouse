### SQL-queries

1. Количество смертей по LGA штатам и годам Roll Up
2. Количество ДТП по штатам днем и ночью c участием Heavy vehicle
3. Количество ДТП в праздники по штатам в 2024.
4. Какая возрастная категория больше попадает в ДТП в RUSH hours.
5. В 2024 разбивка количества аварий по штатам и скоростным режимам.
6. Какая смертность на 100000 человек по штатам в 2020 году

1. What is the total number of road fatalities by state, and year?

SELECT 
    d.year,
    l.state,
    COUNT(*) AS total_fatalities
FROM fatalities_fact f
JOIN date_dim d ON f.dateID = d.dateID
JOIN location_dim l ON f.lga_code = l.lga_code

GROUP BY ROLLUP (d.year, l.state)
ORDER BY total_fatalities DESC;


2. How many road crashes involving heavy vehicles occurred during the day and night across each state?

SELECT 
    l.state,
    d.time_of_day,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN location_dim l ON f.lga_code = l.lga_code
JOIN daytime_dim d ON f.daytimeID = d.daytimeID
JOIN vehicle_type_dim v ON f.vehicle_typeID = v.vehicle_typeID
WHERE v.vehicle_type_involved = 'Heavy Vehicle Involved'
GROUP BY l.state, d.time_of_day
ORDER BY l.state, d.time_of_day;

-- 3. How many road crashes occurred during holidays in each state in 2024?

SELECT 
    l.state,
    h.holiday_type,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN location_dim l ON f.lga_code = l.lga_code
JOIN holiday_dim h ON f.holidayID = h.holidayID
JOIN date_dim d ON f.dateID = d.dateID
WHERE d.year = 2024
AND h.holiday_type = 'Holiday'
GROUP BY l.state, h.holiday_type
ORDER BY total_crashes DESC;

4. Which age group is most frequently involved in road crashes during rush hours?

SELECT 
    a.age_group,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN rush_dim r ON f.rushID = r.rushID
JOIN age_dim a ON f.ageID = a.ageID
WHERE r.time_cat = 'Rush'
GROUP BY a.age_group
ORDER BY total_crashes DESC;

5. How many road crashes occurred at each speed limit in each Australian state during the year 2024?

SELECT 
    l.state,
    s.speed_limit,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN location_dim l ON f.lga_code = l.lga_code
JOIN speed_limit_dim s ON f.speed_limitID = s.speed_limitID
JOIN date_dim d ON f.dateID = d.dateID
WHERE d.year = 2024
GROUP BY l.state, s.speed_limit
ORDER BY l.state, total_crashes DESC;

6. Какая смертность на 100000 человек по штатам в 2020 году

WITH population_per_state AS (
    SELECT 
        l.state,
        SUM(p.population) AS total_population
    FROM population_fact p
    JOIN location_dim l ON p.lga_code = l.lga_code
    WHERE p.year = 2020
    GROUP BY l.state
),
fatalities_per_state AS (
    SELECT 
        l.state,
        COUNT(f.crash_ID) AS total_deaths
    FROM fatalities_fact f
    JOIN location_dim l ON f.lga_code = l.lga_code
    JOIN date_dim d ON f.dateID = d.dateID
    WHERE d.year = 2020
    GROUP BY l.state
)
SELECT 
    pps.state,
    pps.total_population,
    fps.total_deaths,
    ROUND(fps.total_deaths * 100000.0 / NULLIF(pps.total_population, 0), 2) AS fatalities_per_100k
FROM population_per_state pps
JOIN fatalities_per_state fps ON pps.state = fps.state
ORDER BY fatalities_per_100k DESC;