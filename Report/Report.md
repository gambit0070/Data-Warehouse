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



### Schema, Starnet and query footprints

Schema looks like:

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Schema/ Schema.png" alt=" Schema" style="zoom:100%;" />

**Schema, Starnet and query footprints**: Provide and explain your StarNet diagrams and the query footprints. Discuss which schema you used and justify your choice with references.

Implement a star or snowflake schema using PostgreSQL. For the fact table and dimension tables, clearly state which ones are measures and dimensions, and indicate the dimension references.



The first fact table fatalities_fact has no numeric measures so it is factless fact table, which will describe fatalities itself. Attributes for this fact table will be:
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
year - year, part of composite primary key.
population - population measure.



Use the StarNet footprints to illustrate how the business queries can be answered with your design. 

1. What is the total number of road fatalities by state, and year?



2. How many road crashes involving heavy vehicles occurred during the day and night across each state?

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Stars/Star_q2.drawio.png" style="zoom:67%;" />

 



3. How many road crashes occurred during holidays in each state in 2024?

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Stars/Star_q3.drawio.png" style="zoom:67%;" />

4. Which age group is most frequently involved in road crashes during rush hours?

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Stars/Star_q4.drawio.png" style="zoom:67%;" />

5. How many road crashes occurred at each speed limit in each Australian state during the year 2024?

<img src="/Users/Kirill/Documents/GitHub/Data-Warehouse/Stars/Star_q5.drawio.png" style="zoom:67%;" />

## ETL

### Extraction

Importing libraries

```import pandas as pd
import pandas as pd
import numpy as np
```

Reading Files

```
# # Ensure the required library is installed 
# (Can we do it (openpyxl)? Will it be a problem?)
# %pip install openpyxl

# Read the Excel files
file_path = "bitre_fatalities_dec2024.xlsx"
df = pd.read_excel(file_path, sheet_name="BITRE_Fatality", skiprows=4)

file_path = "Population.xlsx"
population = pd.read_excel(file_path, sheet_name="Table 1", skiprows=5)
```

### Transformation

Changing column names for convinience

```
# Clean the columnnames
# Remove leading and trailing whitespace, convert to lowercase, and replace spaces with underscores

df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')

# change sa4_name_2021 to sa4_name, national_lga_name_2021 to lga_name
df.rename(columns={
    'national_lga_name_2021': 'lga_name',
    'national_road_type': 'road_type'
}, inplace=True)
df.columns

Index(['crash_id', 'state', 'month', 'year', 'dayweek', 'time', 'crash_type',
       'bus_involvement', 'heavy_rigid_truck_involvement',
       'articulated_truck_involvement', 'speed_limit', 'road_user', 'gender',
       'age', 'national_remoteness_areas', 'sa4_name_2021', 'lga_name',
       'road_type', 'christmas_period', 'easter_period', 'age_group',
       'day_of_week', 'time_of_day'],
      dtype='object')
```

Adding a victim number for each crash to make composite primary key.

```
df['victim_number'] = df.groupby('crash_id').cumcount() + 1

# move the victim_number column to the front
cols = df.columns.tolist()
cols.insert(1, cols.pop(cols.index('victim_number')))
df = df[cols]
```

Drop unnessasary columns

```
df.drop(columns=['age', 'gender', 'national_remoteness_areas', 'sa4_name_2021', 'day_of_week'], inplace=True)
```

#### Categorising variables

Create variable time_cat for **Rush hours** dimension. Rush hours is morning hours from 07:00 - 09:00 and evening hours 16:00 - 18:00 during working days.

```
# convert the 'time' column to datetime format
df['time'] = pd.to_datetime(df['time'], format='%H:%M:%S', errors='coerce').dt.time

Weekday = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

conditions = [
    (df['christmas_period'] == "No") & (df['easter_period'] == "No") & (df['dayweek'].isin(Weekday)) & (
    ((df['time'] >= pd.to_datetime("07:00:00", format='%H:%M:%S').time()) & (df['time'] <= pd.to_datetime("09:00:00", format='%H:%M:%S').time())) |
    ((df['time'] >= pd.to_datetime("16:00:00", format='%H:%M:%S').time()) & (df['time'] <= pd.to_datetime("18:00:00", format='%H:%M:%S').time()))
    ),
    (df['time'].isna())
]

choices = ["Rush", np.nan]

df['time_cat'] = np.select(conditions, choices, default="Not Rush")

# change 'nan' value to np.nan
df['time_cat'] = df['time_cat'].replace('nan', np.nan)

print(df['time_cat'].unique())

['Not Rush' 'Rush' nan]
```

Set NaN for all **missing values** in dataset. We decided to leave all Nan values since there are no meaninful option to replace in with mean or mode value, beacause every crash is unique event.

```
nan_values = ['Other/-9', '-9', 'Unknown', 'Undetermined', -9]
df.replace(nan_values, np.nan, inplace=True)
```

Checking for 'bad values' in speed_limit variable.

```
try :
    df['speed_limit'] = df['speed_limit'].astype(float)
except ValueError:
    # If conversion to int fails, print values that cannot be converted
    print("Values that cannot be converted to int:")
    print(df[~df['speed_limit'].apply(lambda x: isinstance(x, int) or pd.isna(x))]['speed_limit'].unique())
    
Values that cannot be converted to int:
['<40']
```

<40 means less than 40, which is 'low' speed category, just set this value to 40.

```
df['speed_limit'] = df['speed_limit'].replace('<40', 40)
```

Categorising road **speed limits** into 4 categories. According to local rules in NT state speed limit in build-up areas is 60 km/h, while in other states is 50 km/h. We sel "Low" for low speed zones 0-40 km/h, "Med" for 41-60 in NT and 41-50 in other states, 'High' fof 61-80 in NT and 51-80 in other states, and 'Very High' for 81 and upper for all states.

```
df['speed_limit'] = np.where(
    df['state'] != "NT",
    np.select(
        [
            (df['speed_limit'] > 0) & (df['speed_limit'] <= 40),
            (df['speed_limit'] >= 41) & (df['speed_limit'] <= 50),
            (df['speed_limit'] >= 51) & (df['speed_limit'] <= 80),
            (df['speed_limit'] > 80)
        ],
        ['Low', 'Med', 'High', 'Very High'],
        default=np.nan
    ),
    np.select(
        [
            (df['speed_limit'] > 0) & (df['speed_limit'] <= 40),
            (df['speed_limit'] >= 41) & (df['speed_limit'] <= 60),
            (df['speed_limit'] >= 61) & (df['speed_limit'] <= 80),
            (df['speed_limit'] > 80)
        ],
        ['Low', 'Med', 'High', 'Very High'],
        default=np.nan
    )
)

# change 'nan' value to np.nan
df['speed_limit'] = df['speed_limit'].replace('nan', np.nan)
```

Create **vehicle_type** column, which indicates if there were heavy vehicles involved in the accident.

```
conditions = [
    (df['bus_involvement'] == "Yes") | (df['heavy_rigid_truck_involvement'] == "Yes") | (df['articulated_truck_involvement'] == "Yes"),
    (df['bus_involvement'] == "No") & (df['heavy_rigid_truck_involvement'] == "No") & (df['articulated_truck_involvement'] == "No")
]

choices = ["Heavy Vehicle Involved", "No Heavy Vehicle Involved"]

df['vehicle_type_involved'] = np.select(conditions, choices, default=np.nan)
df['vehicle_type_involved'] = df['vehicle_type_involved'].replace('nan', np.nan)
```

#### Transform **population fact table** from wide format to long format.

```
print(population.head())

  Unnamed: 0             Unnamed: 1   2001   2002   2003   2004   2005   2006  \
0   LGA code  Local Government Area    no.    no.    no.    no.    no.    no.   
1      10050                 Albury  45265  45816  46180  46505  47004  47566   
2      10180               Armidale  27906  27774  27610  27410  27350  27377   
3      10250                Ballina  37856  38417  38870  39120  39305  39537   
4      10300              Balranald   2751   2703   2661   2596   2545   2507   

    2007   2008  ...   2014   2015   2016   2017   2018   2019   2020   2021  \
0    no.    no.  ...    no.    no.    no.    no.    no.    no.    no.    no.   
1  48140  48518  ...  50990  51486  52171  53056  53922  54657  55466  56067   
2  27468  27788  ...  29015  29160  29310  29519  29631  29701  29600  29332   
3  39824  40020  ...  41881  42336  42993  43652  44385  44997  45663  46196   
4   2473   2433  ...   2376   2364   2330   2338   2308   2287   2257   2208   

    2022   2023  
0    no.    no.  
1  56665  57517  
2  29361  29594  
3  46849  47279  
4   2210   2202  

[5 rows x 25 columns]
```

Create appropriate column names. Delete first row with 'no.' strings. Delete the last 2 rows with '© Commonwealth of Australia' and Total Australia measure.

```
# Clean the columnnames
year_colnames = population.columns[2:].tolist()  # Get the first row for year column names
lga_colnames = population.iloc[0, :2].tolist()  # Get the first two columns for LGA names

# change 'local_government_area' to 'lga_name'
lga_colnames[1] = 'lga_name'

for i in range(len(lga_colnames)):
    lga_colnames[i] = lga_colnames[i].strip().lower().replace(' ', '_').replace('/', '_')
population.columns = lga_colnames + year_colnames  # Combine the two lists
population = population[1:-2].reset_index(drop=True)
```

Transform population into long format.

```
population_long = population.melt(
    id_vars = ["lga_code", "lga_name"],
    var_name = "year",
    value_name = "population"
)
population_long


lga_code	lga_name	year	population
0	10050	Albury	2001	45265
1	10180	Armidale	2001	27906
2	10250	Ballina	2001	37856
3	10300	Balranald	2001	2751
4	10470	Bathurst	2001	35504
...	...	...	...	...
12576	74660	West Arnhem	2023	7407
12577	74680	West Daly	2023	3426
12578	79399	Unincorporated NT	2023	7713
12579	89399	Unincorporated ACT	2023	466566
12580	99399	Unincorp. Other Territories	2023	2516
12581 rows × 4 columns
```

#### Designing dimention tables

To design location dimension table we should add lag_code to our data in fatalities table. We merge df and population table. After that we found out that some LGA names are different in fatalities table and population table (for example, Armidale and Armidale Regional). For these values we serch for matching in first word and change the LGA name in fact table, so they can match population table and will not lead to NaN values.

```
df = df.merge(population_long[['lga_name', 'lga_code']].drop_duplicates(), on='lga_name', how='left')

def match_by_first_word(row):
    # Only try to match if lga_code is missing and lga_name exists
    if pd.isna(row['lga_code']) and pd.notna(row['lga_name']):
        first_word = row['lga_name'].split()[0]
        # Try to find match in population_long
        match = population_long[population_long['lga_name'].str.contains(rf'\b{first_word}\b', case=False, na=False)]
        if not match.empty:
            # If a match is found, update both lga_code and lga_name
            row['lga_code'] = match['lga_code'].values[0]
            row['lga_name'] = match['lga_name'].values[0]
    return row

# Apply the function row-wise
df = df.apply(match_by_first_word, axis=1)
# make lga_code to int, ignore NaN
df['lga_code'] = df['lga_code'].astype(pd.Int64Dtype())
```

Create location dimension table.

```
location_dim = population_long[['lga_code', 'lga_name']].drop_duplicates()
location_dim = location_dim.merge(df[['lga_code', 'state']].drop_duplicates(), on='lga_code', how='left')
location_dim = location_dim[['lga_code', 'state', 'lga_name']]
location_dim
```

![image-20250411141017319](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141017319.png)

Create date dimension table.

```
date_dim = df[['year', 'month']].drop_duplicates()
date_dim['dateID'] = df['year'].astype(str) + df['month'].astype(str)
date_dim = date_dim[['dateID', 'year', 'month']]
date_dim
```

![image-20250411141044991](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141044991.png)

Create Rush hours dimension table.

```
rush_dim = df[['time_cat']].drop_duplicates()
rush_dim['rushID'] = range(1, len(rush_dim) + 1)
rush_dim = rush_dim[['rushID', 'time_cat']]
rush_dim.dropna(subset=['time_cat'], inplace=True)
rush_dim

	rushID	time_cat
0	1	Not Rush
7	2	Rush
```

![image-20250411141055902](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141055902.png)

Create Age dimension table.

```
age_dim = df[['age_group']].drop_duplicates()
# sort by age_group
age_dim = age_dim.sort_values(by='age_group')
age_dim['ageID'] = range(1, len(age_dim) + 1)
age_dim = age_dim[['ageID', 'age_group']]
age_dim.dropna(subset=['age_group'], inplace=True)
age_dim
```

![image-20250411141109716](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141109716.png)

Create Daytime dimension table.

```
daytime_dim = df[['time_of_day']].drop_duplicates()
daytime_dim['daytimeID'] = range(1, len(daytime_dim) + 1)
daytime_dim = daytime_dim[['daytimeID', 'time_of_day']]
daytime_dim.dropna(subset=['time_of_day'], inplace=True)
daytime_dim
```

![image-20250411141125318](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141125318.png)

Create Road dimension table.

```
road_type_dim = df[['road_type']].drop_duplicates()
road_type_dim['road_typeID'] = range(1, len(road_type_dim) + 1)
road_type_dim = road_type_dim[['road_typeID', 'road_type']]
road_type_dim.dropna(subset=['road_type'], inplace=True)
road_type_dim
```

![image-20250411141139004](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141139004.png)

Create Speed dimension table.

```
speed_limit_dim = df[['speed_limit']].drop_duplicates().dropna()
speed_limit_dim['speed_limitID'] = range(1, len(speed_limit_dim) + 1)
speed_limit_dim = speed_limit_dim[['speed_limitID', 'speed_limit']]
speed_limit_dim.dropna(subset=['speed_limit'], inplace=True)
speed_limit_dim
```

![image-20250411141148669](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141148669.png)

Create Holiday dimension table.

```
holiday_dim = df[['holiday_type', 'holiday_name']].drop_duplicates().sort_values(by='holiday_type')
holiday_dim['holidayID'] = range(1, len(holiday_dim) + 1)
holiday_dim = holiday_dim[['holidayID', 'holiday_type', 'holiday_name']]
holiday_dim.dropna(subset=['holiday_type', 'holiday_name'], inplace=True)
holiday_dim
```

![image-20250411141203844](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141203844.png)

Create Vehicle type dimension table.

```
vehicle_type_dim = df[['vehicle_type_involved']].drop_duplicates().dropna()
vehicle_type_dim['vehicle_typeID'] = range(1, len(vehicle_type_dim) + 1)
vehicle_type_dim = vehicle_type_dim[['vehicle_typeID', 'vehicle_type_involved']]
vehicle_type_dim.dropna(subset=['vehicle_type_involved'], inplace=True)
vehicle_type_dim
```

![image-20250411141215837](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141215837.png)

### Load

#### Saving tables

Save all dimension tables to csv files

```
dimension_tables = {
    "location_dim": location_dim,
    "date_dim": date_dim,
    "rush_dim": rush_dim,
    "age_dim": age_dim,
    "daytime_dim": daytime_dim,
    "road_type_dim": road_type_dim,
    "speed_limit_dim": speed_limit_dim,
    "holiday_dim": holiday_dim,
    "vehicle_type_dim": vehicle_type_dim
}
# Save each DataFrame to a CSV file
for name, table in dimension_tables.items():
    output_file_path = f"data/{name}.csv"
    table.to_csv(output_file_path, index=False)
    print(f"{name} data saved to {output_file_path}")
```

Save the cleaned DataFrame for Algorithm Rule Mining

```
df_cleaned = df.copy()
```

Create fatalities_df fact table. 

```
fatalities_df = df.copy()
fatalities_df = fatalities_df.merge(date_dim, on=['year', 'month'], how='left')
fatalities_df = fatalities_df.merge(rush_dim, on=['time_cat'], how='left')
fatalities_df = fatalities_df.merge(age_dim, on=['age_group'], how='left')
fatalities_df = fatalities_df.merge(daytime_dim, on=['time_of_day'], how='left')
fatalities_df = fatalities_df.merge(road_type_dim, on=['road_type'], how='left')
fatalities_df = fatalities_df.merge(speed_limit_dim, on=['speed_limit'], how='left')
fatalities_df = fatalities_df.merge(holiday_dim, on=['holiday_type', 'holiday_name'], how='left')
fatalities_df = fatalities_df.merge(vehicle_type_dim, on=['vehicle_type_involved'], how='left')

# drop unnecessary columns
fatalities_df = fatalities_df[['crash_id', 'victim_number', 'lga_code', 'dateID', 'rushID', 'ageID', 'daytimeID', 'road_typeID', 'speed_limitID', 'holidayID', 'vehicle_typeID']]
# Convert all values to Int64 ingnoring NaN
fatalities_df = fatalities_df.astype(pd.Int64Dtype())
fatalities_df
```

![image-20250411141722345](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141722345.png)

Create population_df fact table. 

```
population_df = population_long.copy()
population_df = population_df[['lga_code', 'year', 'population']]
population_df
```

![image-20250411141821075](/Users/Kirill/Library/Application Support/typora-user-images/image-20250411141821075.png)

Save fact tables.

```
fact_tables = {
    "fatalities_fact": fatalities_df,
    "population_fact": population_df
}
# Save each DataFrame to a CSV file
for name, table in fact_tables.items():
    output_file_path = f"data/{name}.csv"
    table.to_csv(output_file_path, index=False)
    print(f"{name} data saved to {output_file_path}")
```

#### Load tables to PostgreSQL

_______________ - explain how to create DW

In the DW we create new database Project_1 and Create table with SQL queries:

```
-- DROP ALL TABLES
DROP TABLE IF EXISTS population_fact;
DROP TABLE IF EXISTS fatalities_fact;
DROP TABLE IF EXISTS location_dim;
DROP TABLE IF EXISTS date_dim;
DROP TABLE IF EXISTS rush_dim;
DROP TABLE IF EXISTS age_dim;
DROP TABLE IF EXISTS daytime_dim;
DROP TABLE IF EXISTS road_type_dim;
DROP TABLE IF EXISTS speed_limit_dim;
DROP TABLE IF EXISTS holiday_dim;
DROP TABLE IF EXISTS vehicle_type_dim;
DROP TABLE IF EXISTS population_fact;
DROP TABLE IF EXISTS fatalities_fact;

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
    holiday_type VARCHAR(50),
    holiday_name VARCHAR(50)
);

-- create dimension vehicle_type_dim
CREATE TABLE IF NOT EXISTS vehicle_type_dim (
    vehicle_typeID INT PRIMARY KEY,
    vehicle_type_involved VARCHAR(50)
);

-- create population fact table
CREATE TABLE IF NOT EXISTS population_fact (
    lga_code INT,
    year INT,
    population INT,
    FOREIGN KEY (lga_code) REFERENCES location_dim(lga_code),
    PRIMARY KEY (lga_code, year)


);

-- create fatalities fact table 
CREATE TABLE IF NOT EXISTS fatalities_fact(
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
    FOREIGN KEY (lga_code) REFERENCES location_dim(lga_code),
    FOREIGN KEY (dateID) REFERENCES date_dim(dateID),
    FOREIGN KEY (rushID) REFERENCES rush_dim(rushID),
    FOREIGN KEY (ageID) REFERENCES age_dim(ageID),
    FOREIGN KEY (daytimeID) REFERENCES daytime_dim(daytimeID),
    FOREIGN KEY (road_typeID) REFERENCES road_type_dim(road_typeID),
    FOREIGN KEY (speed_limitID) REFERENCES speed_limit_dim(speed_limitID),
    FOREIGN KEY (holidayID) REFERENCES holiday_dim(holidayID),
    FOREIGN KEY (vehicle_typeID) REFERENCES vehicle_type_dim(vehicle_typeID),
    PRIMARY KEY (crash_ID, victim_number)
```

Load data into the tables.

```
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
```

**Data cleaning, preprocessing, and ETL process**: Describe your ETL process in detail. Include descriptions of the techniques used, discuss your ETL principles, explain the reasoning behind the key steps, and provide screenshots illustrating the process flow with references. 

NOTE: During the ETL process, you may remove some rows from the dataset. However, the number of dropped rows should not exceed 5% of the total dataset. Removing too many rows will result in a low mark for the ETL section. 

## Visualisation

**Visual**
Use PostgreSQL to build a multi-dimensional analysis service solution, with a cube designed to answer your business queries. Make sure the concept hierarchies match your StarNet design.

Use Power BI/Tableau to visualise the data returned from your business queries.

**Visualisation of query results**: Present the findings from your business queries using appropriate charts, graphs, and other visualisations. Ensure the insights are clearly communicated and easily understandable to stakeholders.



## Association rules mining

**Association rules mining**: See the Association Rules Mining section above. 