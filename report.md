## Project Report

## How SAFE are you?

We hear everyday on the news different types of crimes happening. 
But what is happening in your country?
What are the facts and how safe are we walking at night nowadays?
Can we find some explanations for the high or low crime rates?

The project consist by collecting the crime rate and prison population figures for every country on the world.
We want to collect country informations such as GDP, size, latitude, longitude, density, med age, fertility and hapiness.
Once collected we could compare the countries to find a pattern.

We also want to collect crime informations more specifically for Australia

As a bonus, we will collect drug seizure informations for every coutry. 
We would like to have an idea how import crimes are in every country.

### Data sources

**E**xtract:
The data sources we used to extract informations are the following:

* Happiness reports csv's from Kaggle
* Country info csv downloaded from www.worldometers.info
* Country names lat and longitude csv from Kaggle
* Crime rate scraped from https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&displayColumn=0
* Drug seizure csv from Kaggle
* Country gdp scraped from https://www.imf.org/external/datamapper/NGDP_RPCH@WEO/OEMDC/ADVEC/WEOWORLD
* Prison pop scraped from https://www.prisonstudies.org/world-prison-brief-data

We mainly used 2 different formats: 
    - csv
    - html (web scraping)

## Data Cleanup 
**T**ransform
The transformation consisted in 3 steps :

* Select the columns/informations we want to keep in the database.
* Cleanup the nan values, the country names, and the data types of the different informations loaded in dataframe
with pandas.
* Use a function to add the country ISO CODES foreign keys in every table/dataframe according to the country names found in the dataframes. The functions works for 95% of the countries. We added the last 5 to 6 countries manually.

## Data Loading 
**L**oad:

We decided to load the database on pgADMIN with SQLALCHEMY and to create a crime.db file within the SQL directory.
The reason behind is that our project consist in collecting information per country. 
There is a relation between all the table, with the country ISO codes.
For every data sources we collected the county names as well and we added an ISO CODE for uniformity.
This make it easier to query and join table, filter etc...

## Query examples

You can find a query code in the main.py file.
The main script contains 2 ways of querying:

 ===> Crime.db

    -> Requirements.
    -> Creates a connection to the crime.db file.
    -> Reflect and retrieves the available tables and columns
    -> Shows how to create a query and load in a data frame.

    example : 
        stmt = session.query(crime_rate.crime_index,country_names.country,happiness.score ).\
                filter(crime_rate.country_code == country_names.code).\
                    join(happiness,country_names.code == happiness.country_code).\
                        order_by(crime_rate.crime_index.desc()).statement

        df = pd.read_sql_query(stm,con)

 ===> PG ADMIN

    -> Requirements
    -> Creates and load the tables on the crimedb in you pgAdmin.
    -> Reflect and retrieves the available tables and columns
    -> Shows how to create a query and load in a data frame.

    example : 
        stmt = session.query(crime_rate.crime_index,country_names.country,happiness.score ).\
                filter(crime_rate.country_code == country_names.code).\
                    join(happiness,country_names.code == happiness.country_code).\
                        order_by(crime_rate.crime_index.desc()).statement

        df = pd.read_sql_query(stm,con)



