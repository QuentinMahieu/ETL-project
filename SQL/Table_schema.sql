
DROP TABLE IF EXISTS country_names;
CREATE TABLE "country_names" (
    "code" VARCHAR(3)   NOT NULL,
    "country" VARCHAR(50)   NOT NULL,
    "latitude" FLOAT   NOT NULL,
    "longitude" FLOAT   NOT NULL,
    CONSTRAINT "pk_country_names" PRIMARY KEY (
        "code"
     )
);

COPY country_names
FROM '/Users/quentinmahieu/Public/Data/country_names.csv'
DELIMITER','
CSV HEADER;

DROP TABLE IF EXISTS country_info;
CREATE TABLE "country_info" (
    "id"  SERIAL  NOT NULL,
    "country_code" VARCHAR(3),
    "population" BIGINT ,
    "density" FLOAT,
    "size" BIGINT,
    "fert_rate" VARCHAR,
    "med_age" VARCHAR,
    "urban_pop" FLOAT,
    "world_pop" FLOAT,
    CONSTRAINT "pk_country_info" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "country_info" ADD CONSTRAINT "fk_country_info_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY country_info
FROM '/Users/quentinmahieu/Public/Data/country_info.csv'
DELIMITER','
CSV HEADER;

DROP TABLE IF EXISTS country_gdp;
CREATE TABLE "country_gdp" (
    "id"  SERIAL  NOT NULL,
    "country_code" VARCHAR(3),
    "gdp" FLOAT,
    CONSTRAINT "pk_country_gdp" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "country_gdp" ADD CONSTRAINT "fk_country_gdp_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY country_gdp
FROM '/Users/quentinmahieu/Public/Data/country_gdp.csv'
DELIMITER','
CSV HEADER;

DROP TABLE IF EXISTS happiness;
CREATE TABLE "happiness" (
    "id"  SERIAL  NOT NULL,
    "country_code" VARCHAR(3),
    "rank" INT ,
    "score" FlOAT,
    "GDP" FLOAT,
    "social_support" FLOAT,
    "life_expenctancy" FLOAT,
    "freedom" FLOAT,
    "trust_governement" FLOAT,
    "generosity" FLOAT,
    "year" INT,
    CONSTRAINT "pk_happiness" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "happiness" ADD CONSTRAINT "fk_happiness_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY happiness
FROM '/Users/quentinmahieu/Public/Data/happiness.csv'
DELIMITER','
CSV HEADER ;

DROP TABLE IF EXISTS prison_pop;
CREATE TABLE "prison_pop" (
    "id"  SERIAL,
    "country_code" VARCHAR(3),
    "prison_pop" INT,
    "prison_rate" INT,
    "pre_trial_detainees" FLOAT,
    "women_percent" FLOAT,
    "minors_percent" FLOAT,
    "foreigns_percent" FLOAT,
    "number_institutions" INT,
    "capacity" INT,
    "occupancy" FLOAT,
    CONSTRAINT "pk_prison_pop" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "prison_pop" ADD CONSTRAINT "fk_prison_pop_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY prison_pop
FROM '/Users/quentinmahieu/Public/Data/prison_pop.csv'
DELIMITER','
CSV HEADER ;

DROP TABLE IF EXISTS crime_rate;
CREATE TABLE "crime_rate" (
    "id"  SERIAL  NOT NULL,
    "country_code" VARCHAR(3),
    "crime_index" FLOAT,
    CONSTRAINT "pk_crime_rate" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "crime_rate" ADD CONSTRAINT "fk_crime_rate_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY crime_rate
FROM '/Users/quentinmahieu/Public/Data/crime_rate.csv'
DELIMITER','
CSV HEADER ;

DROP TABLE IF EXISTS drug_seizures;
CREATE TABLE "drug_seizures" (
    "id"  SERIAL  NOT NULL,
    "country_code" VARCHAR(30),
    "quantity" FLOAT,
    CONSTRAINT "pk_drug_seizures" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "drug_seizures" ADD CONSTRAINT "fk_drug_seizures_country_code" FOREIGN KEY("country_code")
REFERENCES "country_names" ("code");

COPY drug_seizures
FROM '/Users/quentinmahieu/Public/Data/drug_seizures.csv'
DELIMITER','
CSV HEADER ;




















