# Project 1 - Data Warehouse Design

Project 1 submitted by 
Butakov Kirill, Student ID: 24620697 
________, Student ID: ______.

Member Contribution: ________

The overall objectives of this project are to build a data warehouse using real-world datasets and to carry out a basic data mining activity, in this case, association rule mining.

## Datasets and Problem Domain

_________ problem

### Data Sources

Было предложено воспользоваться двумя датасетами от Australian Road Deaths Database - ARDD:
- ARDD: Fatal crashes—December 2024—XLSX
- ARDD: Fatalities—December 2024—XLSX
Датасет Fatalities оказался более полным так помимо информации о дтп включает информацию о самих жертвах, тогда как в датасете Fatal crashes этой информации нет. Мы выбрали использовать в дизайне дата вархауза только Fatalities датасет. Датасет доступен по ссылке: https://www.bitre.gov.au/sites/default/files/documents/bitre_fatalities_dec2024.xlsx
Дополнительно мы используем The population data from the Australian Bureau of Statistics (ABS). The ABS provides demographic data broken down by various geographic area types and years. Датасет доступен по ссылке: https://2182247241-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FxLnqk70bNUs4S0lWpxUJ%2Fuploads%2FeSVyshmTrAjo7GllI2uH%2FPopulation%20estimates%20by%20LGA%2C%20Significant%20Urban%20Area%2C%20Remoteness%20Area%2C%20Commonwealth%20Electoral%20Division%20and%20State%20Electoral%20Division%2C%202001%20to%202023.xlsx?alt=media&token=78877d58-b100-4cb3-962c-3d593024d3a5

## Data Warehousing Design and Implementation

### Identification of the modelling process

Процесс или еденица данных, которую мы будем анализировать - это смерть человека по причине дорожно-транспортного происществия. В исходном датасете есть следующие аттрибуты описывающие этот факт:
- Crash ID - National crash identifying number
- State - Australian jurisdiction
- Month - Month of crash 
- Year - Year of crash
- Dayweek - Day of week of crash
- Time - Time of crash
- Crash Type - Refers to the number of vehicles involved.
- Bus Involvement - Indicates involvement of a bus in the crash
- Heavy Rigid Truck Involvement - Indicates involvement of a heavy rigid truck in the crash
- Articulated Truck Involvement - Indicates involvement of an articulated truck in the crash
Speed Limit - Posted speed limit at location of crash
Road User - Road user type of killed person
Gender - Sex of killed person
Age - Age of killed person (years)
National Remoteness Areas - ABS Remoteness Structure
SA4 Name 2021 - Australian Statistical Geography Standard
National LGA Name 2021 - Australian Statistical Geography Standard
National Road Type - Geoscape Australia, Transport and Topography
Christmas Period - Indicates if crash occurred during the 12 days commencing on December 23rd 
Easter Period - Indicates if crash occurred during the 5 days commencing on the Thursday before Good Friday
Age Group - Standard age groupings used in the Road Deaths Australia monthly bulletin
Day of week - Indicates if crash occurred during the weekday or weekend. (Note: ‘Weekday’ refers to 6am Monday through to 5:59pm Friday)
Time of day - Indicates if crash occurred during the day or night (Note: ‘Day’ refers to 6am through to 5:59 pm)

Изучив данные, мы можем Think about a few business questions that our data warehouse could help answer. For example,

1. How do road fatality rates per 1,000 people vary across different geographic levels (State → LGA) and time periods (Year → Month), and where are the highest concentrations of fatalities relative to population?
2. How many road crashes involving heavy vehicles occurred during the day and night across each state?
3. How many road crashes occurred during holidays in each state in 2024?
4. Which age group is most frequently involved in road crashes during rush hours?
5. How many road crashes occurred at each speed limit in each Australian state during the year 2024?

Возможности проектируемого data warehouse не ограничиваются этими запросами.

### Determine the dimension tables.

В нашем случае мы будем использовать Galaxy schema woth two fact tables. Вторая факт таблица нужна для того, чтобы хранить population data с разбивкой по годам, чтобы можно было смотреть за ситуацией со смертностью на дорогах в динамике.

Определим измерения в нашем data warehouse schema иерархию:

Date - информация о дате происшествия. Состоит из года, мессяца.
Location - информация о месте происшествия. Состоит из штата, LGA.
Vehicle invoved - информация о виде траспорта, вовлеченном в дтп. Категориальная переменная, которая имеет 2 значения: Heavy Vehicle Involved - если в дтп участвовал Bus, Heavy Rigid Truck or Articulated Truck; No Heavy Vehicle Involved - если тяжелый транспорт не был вовлечен в дтп.
Speed - информация о скоростном режиме на месте дтп.
Road - информация о категирии дороги.
Holiday - информация о том, случилось ли дтп в праздничный период. Включает в себя holiday_type и holiday_name. NoHoliday для обычных дней. 
Daytime - случилось ли дтп днем или ночью.
Rush hours - случилось ли дтп в rush hours.
Age - информация о возрасте жертвы.

Мы не используем для анализа категории 'age', 'road_user', 'gender', 'national_remoteness_areas', 'sa4_name_2021', 'day_of_week'
____________ почему????

Star scheme including schema hierarchies shown on pic 1.

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Stars/Star.drawio.png" alt="Star.drawio" style="zoom:60%;" />

Concept hierarchies for dimensions shown below:





![Concept_Age.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_Age.drawio.png)

Concept Hierarchy - Age

![Concept_date.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_date.drawio.png)

Concept Hierarchy - Date



![Concept_daytime.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_daytime.drawio.png)

Concept Hierarchy - Daytime

![Concept_holiday.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_holiday.drawio.png)

Concept Hierarchy - Holiday

![Concept_location.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_location.drawio.png)

Concept Hierarchy - Location

![Concept_road.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_road.drawio.png)

Concept Hierarchy - Road

![Concept_rush.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_rush.drawio.png)

Concept Hierarchy - Rush hours

![Concept_speed.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_speed.drawio.png)

Concept Hierarchy - Speed

![Concept_vehicle.drawio](/Users/Kirill/Documents/GitHub/Data-Warehouse/Hierarchies/Concept_vehicle.drawio.png)

Concept Hierarchy - Vehicle invoved



**Design, implementation, and usage of the data warehouse**:  Explain and discuss the design, implementation, and usage of the data warehouse to answer your queries, such as the fact table, dimension tables, and concept hierarchies design. When designing your data warehouse, you may select any number of columns/attributes as dimensions and measures. **Please justify your design by explaining your assumptions or reasoning behind your choices with references**.


### Determine the grain at which facts can be stored.

The first fact table has no numeric measures so it is factless fact table, which will describe fatalities itself. Attributes for this fact table will be:
crash_id - National crash identifying number
victim_number - Victim number в дтп.
lga_code - location dimension
dateID - date dimension
rushID - Rush hours dimension
ageID - Age dimension
daytimeID - Daytime dimension
road_typeID - Road dimension
speed_limitID - Speed dimension
holidayID - Holiday dimension
vehicle_typeID - Vehicle invoved dimension

The second fact table is population fact table with population measure. Attributes for this fact table will be:
lga_code - location dimension.
year - year.
population - population.

### Schema, Starnet and query footprints

Schema looks like:



**Schema, Starnet and query footprints**: Provide and explain your StarNet diagrams and the query footprints. Discuss which schema you used and justify your choice with references.

Use the StarNet footprints to illustrate how the business queries can be answered with your design. 

Implement a star or snowflake schema using PostgreSQL. For the fact table and dimension tables, clearly state which ones are measures and dimensions, and indicate the dimension references.




## ETL

**Data cleaning, preprocessing, and ETL process**: Describe your ETL process in detail. Include descriptions of the techniques used, discuss your ETL principles, explain the reasoning behind the key steps, and provide screenshots illustrating the process flow with references. 

NOTE: During the ETL process, you may remove some rows from the dataset. However, the number of dropped rows should not exceed 5% of the total dataset. Removing too many rows will result in a low mark for the ETL section. 

**Visual**
Use PostgreSQL to build a multi-dimensional analysis service solution, with a cube designed to answer your business queries. Make sure the concept hierarchies match your StarNet design.

Use Power BI/Tableau to visualise the data returned from your business queries.

**Visualisation of query results**: Present the findings from your business queries using appropriate charts, graphs, and other visualisations. Ensure the insights are clearly communicated and easily understandable to stakeholders.

**Association rules mining**: See the Association Rules Mining section above. 