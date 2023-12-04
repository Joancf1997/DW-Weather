DROP TABLE IF EXISTS stations_dim; 

CREATE TABLE stations_dim
(
    id serial PRIMARY KEY,
    continent character varying(7) NOT NULL,
    country character varying(50) NOT NULL,
    country_acronym character varying(3) NOT NULL,
    station character varying(20) NOT NULL,
    lat float NOT NULL,
    lon float NOT NULL,
    time_zone_offset int NOT Null
);

INSERT INTO stations_dim
SELECT 
    s.id,
    conti.name as continent,
    c.name as country,
    c.acronym as country_acronym,
    s.name as station,
    s.lat,
    s.lon,
    s.time_zone_offset
FROM stations s 
INNER JOIN country c
ON s.id_country = c.id
INNER JOIN continent conti
ON conti.id = c.id_continent;
