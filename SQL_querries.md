### SQL-queries

1. Какая смертность на 1000 человек от ДТП в Перте за последние 10 лет
2. Количество ДТП по штатам днем и ночью c участием Heavy vehicle
3. Количество ДТП в праздники по штатам в 2024.
4. Какая возрастная категория больше попадает в ДТП в RUSH hours.
5. В 2024 разбивка количества аварий по штатам и скоростным режимам.

1. How do road fatality rates per 1,000 people vary across different geographic levels (State → LGA) and time periods (Year → Month), and where are the highest concentrations of fatalities relative to population?

SELECT 
    d.year,
    d.month,
    l.state,
    l.lga_name,
    COUNT(*) AS total_fatalities,
    SUM(p.population) AS total_population,
    ROUND(COUNT(*) * 1000.0 / NULLIF(SUM(p.population), 0), 2) AS fatalities_per_1000
FROM fatalities_fact f
JOIN date_dim d ON f.dateID = d.dateID
JOIN location_dim l ON f.lga_code = l.lga_code
JOIN population_fact p ON f.lga_code = p.lga_code AND d.year = p.year
GROUP BY ROLLUP (d.year, d.month, l.state, l.lga_name)
ORDER BY fatalities_per_1000 DESC


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
