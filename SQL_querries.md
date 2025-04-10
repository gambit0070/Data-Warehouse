### SQL-queries

1. Какая смертность на 1000 человек от ДТП в Перте за последние 10 лет
2. Количество ДТП по штатам в день и ночь c участием Heavy vehicle
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


2. How many road crashes occurred in Perth during rush hours involving heavy vehicles?
(Focus on filtering by time category = Rush Hour and vehicle type = Heavy Vehicle.)

SELECT 
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN rush_dim r ON f.rushID = r.rushID
JOIN vehicle_type_dim v ON f.vehicle_typeID = v.vehicle_typeID
JOIN location_dim l ON f.lga_code = l.lga_code
WHERE l.lga_name = 'Perth'
AND r.time_cat = 'Rush'
AND v.vehicle_type_involved = 'Heavy Vehicle Involved';

3. What is the number of road crashes during holidays (day vs night) compared to non-holiday periods?
(Segment by holiday flag and time_of_day to compare patterns.)

SELECT 
    h.holiday,
    d.time_of_day,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN holiday_dim h ON f.holidayID = h.holidayID
JOIN daytime_dim d ON f.daytimeID = d.daytimeID
GROUP BY h.holiday, d.time_of_day
ORDER BY h.holiday, d.time_of_day;

4. Which age group is most frequently involved in road crashes during rush hours?
(Break down crashes by age group and filter where time_cat = Rush Hour.)

SELECT 
    a.age_group,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN rush_dim r ON f.rushID = r.rushID
JOIN age_dim a ON f.ageID = a.ageID
WHERE r.time_cat = 'Rush'
GROUP BY a.age_group
ORDER BY total_crashes DESC;

5. For each road type, what speed limits are associated with the highest number of crashes?
(Group by road_type and speed_limit, then count incidents.)

SELECT 
    rt.road_type,
    sl.speed_limit,
    COUNT(*) AS total_crashes
FROM fatalities_fact f
JOIN road_type_dim rt ON f.road_typeID = rt.road_typeID
JOIN speed_limit_dim sl ON f.speed_limitID = sl.speed_limitID
GROUP BY rt.road_type, sl.speed_limit
ORDER BY total_crashes DESC;
