DROP TABLE IF EXISTS stations;

CREATE TABLE stations
(
    id serial PRIMARY KEY,
    name character varying(20) NOT NULL,
    lat float NOT NULL,
    lon float NOT NULL,
	time_zone_offset int NOT Null,
	id_country smallint NOT Null,
	FOREIGN KEY (id_country) REFERENCES Country(id)
);

COMMENT ON TABLE stations
    IS 'Table of stations in a country.';


insert into stations (name, lat, lon, time_zone_offset, id_country)
values  ('Rome', 41.902782, 12.496366, 3600, 1),
		('Napoli', 40.85631, 14.24641, 3600, 1),
		('Berlin', 52.520008, 13.404954, 3600, 2),
		('Munich', 48.137154, 11.576124, 3600 ,2),
		('Chicago', 41.881832, -87.623177, -21600, 3),
		('Los Angeles', 34.052235, -118.2437, -28800 ,3),
		('Mexico City', 19.432608, -99.133209, -21600, 4),
		('Jamaica', 17.8101, 76.4093, -18000, 5),
		('Sao Paulo', -15.7939, -47.8828, -10800, 6),
		('Buenos Aires', -34.6037, 58.3816, -10800, 7),
		('Reykjavik', 65, -18, 0, 8),
		('Lisbon', 38.7369, -9.1427, 0, 9),
		('Harare', -17.8249, 31.053, 7200, 10),
		('Bangkok', 13.7367, 100.5232, 25200, 11),
		('kabul', 34.5439, 69.1607, 16200, 12),
		('Moscow', 55.7512, 37.6184, 10800, 13),
		('Magadan', 59.5602, 150.7986, 39600, 13),
		('Auckland', -36.8485, 174.7633, 46800, 14),
		('Tongatapu', -21.179, -175.1982, 46800, 15),
		('Helsinki', 60.1921, 24.9458, 7200, 16),
		('Algiers', 36.7372, 3.0865, 3600, 17);
