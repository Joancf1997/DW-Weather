-- Continents table
CREATE TABLE public.Continent
(
    id serial PRIMARY KEY,
    name character varying(7) NOT NULL
);

ALTER TABLE IF EXISTS public.Continent
    OWNER to joseandres;

COMMENT ON TABLE public.Continent
    IS 'Table of continents.';

insert into Continent (name)
values ('Asia'), 
	   ('America'), 
	   ('Europe'), 
	   ('Africa'), 
	   ('Oceania');

select * 
from Continent;




-- Countries table 
CREATE TABLE public.Country
(
    id serial PRIMARY KEY,
    name character varying(50) NOT NULL,
    acronym character varying(3) NOT NULL,
    id_continent smallint NOT NULL,
	FOREIGN KEY (id_continent) REFERENCES Continent(id)
);

ALTER TABLE IF EXISTS public.Country
    OWNER to joseandres;

COMMENT ON TABLE public.Country
    IS 'Table of countries.';

insert into Country (name, acronym, id_continent)
values ('Italy', 'IT', 3), 
	   ('Germany', 'GER', 3),
	   ('United Stated of America', 'USA', 2),
	   ('Mexico', 'MEX', 2),
	   ('Jamaica', 'JAM', 2),
	   ('Brazil', 'BRA', 2),
	   ('Argentina', 'ARG', 2),
	   ('Islandia', 'ISL', 3),
	   ('Portugal', 'POR', 3),
	   ('Zimbabue', 'ZIM', 4),
	   ('Tailandia', 'TAI', 1),
	   ('Afganistan', 'AFG', 1),
	   ('Rusia', 'RUS', 3),
	   ('New Zeland', 'NZE', 5),
	   ('Tonga', 'TON', 5),
	   ('Finland', 'FIN', 3),
	   ('Argelia', 'ARL', 4);
	   
select * 
from Country;



-- Stations table 
CREATE TABLE public.Stations
(
    id serial PRIMARY KEY,
    name character varying(20) NOT NULL,
    lat float NOT NULL,
    lon float NOT NULL,
	time_zone_offset int NOT Null,
	id_country smallint NOT Null,
	FOREIGN KEY (id_country) REFERENCES Country(id)
);

ALTER TABLE IF EXISTS public.Stations
    OWNER to joseandres;

COMMENT ON TABLE public.Stations
    IS 'Table of stations in a country.';



insert into Stations (name, lat, lon, time_zone_offset, id_country)
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

select * 
from Stations;





-- Sensor table 
CREATE TABLE public.Sensors
(
    id serial PRIMARY KEY,
    name character varying(3) NOT NULL
);

ALTER TABLE IF EXISTS public.Sensors
    OWNER to joseandres;

COMMENT ON TABLE public.Sensors
    IS 'Table of sensors.';


insert into Sensors (name)
values ('APT'), 
	   ('SMT'), 
	   ('RK'), 
	   ('PMT');

select * 
from Sensors;





-- Alerts table 
CREATE TABLE public.Alerts
(
    id serial PRIMARY KEY,
    tag character varying(20) NOT NULL
);

ALTER TABLE IF EXISTS public.Alerts
    OWNER to joseandres;

COMMENT ON TABLE public.Alerts
    IS 'Table of API Alerts.';


insert into Alerts (tag)
values ('None'), 
	   ('Thunderstorm'), 
	   ('Drizzle'), 
	   ('Rain'), 
	   ('Snow'),
	   ('Atmosphere'), 
	   ('Clear'), 
	   ('Clouds'),
	   ('Wind'); 

select * 
from Alerts;





-- weather alerts table 
CREATE TABLE public.Weather_alerts
(
    id smallint NOT NULL PRIMARY KEY,
    main character varying(20) NOT NULL,
    description character varying(40) NOT NULL
);

ALTER TABLE IF EXISTS public.Weather_alerts
    OWNER to joseandres;

COMMENT ON TABLE public.Weather_alerts
    IS 'Table of API weather alerts.';


insert into Weather_alerts
values (200, 'Thunderstorm', 'thunderstorm with light rain'),
		(201, 'Thunderstorm', 'thunderstorm with rain'),
		(202, 'Thunderstorm', 'thunderstorm with heavy rain'),
		(210, 'Thunderstorm', 'light thunderstorm'),
		(211, 'Thunderstorm', 'thunderstorm'),
		(212, 'Thunderstorm', 'heavy thunderstorm'),
		(221, 'Thunderstorm', 'ragged thunderstorm'),
		(230, 'Thunderstorm', 'thunderstorm with light drizzle'),
		(231, 'Thunderstorm', 'thunderstorm with drizzle'),
		(232, 'Thunderstorm', 'thunderstorm with heavy drizzle'),
		(300, 'Drizzle', 'light intensity drizzle'),
		(301, 'Drizzle', 'drizzle'),
		(302, 'Drizzle', 'heavy intensity drizzle'),
		(310, 'Drizzle', 'light intensity drizzle rain'),
		(311, 'Drizzle', 'drizzle rain'),
		(312, 'Drizzle', 'heavy intensity drizzle rain'),
		(313, 'Drizzle', 'shower rain and drizzle'),
		(314, 'Drizzle', 'heavy shower rain and drizzle'),
		(321, 'Drizzle', 'shower drizzle'),
		(500, 'Rain', 'light rain'),
		(501, 'Rain', 'moderate rain'),
		(502, 'Rain', 'heavy intensity rain'),
		(503, 'Rain', 'very heavy rain'),
		(504, 'Rain', 'extreme rain'),
		(511, 'Rain', 'freezing rain'),
		(520, 'Rain', 'light intensity shower rain'),
		(521, 'Rain', 'shower rain'),
		(522, 'Rain', 'heavy intensity shower rain'),
		(531, 'Rain', 'ragged shower rain'),
		(600, 'Snow', 'light snow'),
		(601, 'Snow', 'snow'),
		(602, 'Snow', 'heavy snow'),
		(611, 'Snow', 'sleet'),
		(612, 'Snow', 'light shower sleet'),
		(613, 'Snow', 'shower sleet'),
		(615, 'Snow', 'light rain and snow'),
		(616, 'Snow', 'rain and snow'),
		(620, 'Snow', 'light shower snow'),
		(621, 'Snow', 'shower snow'),
		(62, 'Snow', 'heavy shower snow'),
		(70, 'Mist', 'mist'),
		(71, 'Smoke', 'smoke'),
		(721, 'Haze', 'haze'),
		(731, 'Dust', 'sand/dust whirls'),
		(741, 'Fog', 'fog'),
		(751, 'Sand', 'sand'),
		(761, 'Dust', 'dust'),
		(762, 'Ash', 'volcanic ash'),
		(771, 'Squall', 'squalls'),
		(781, 'Tornado', 'tornado'),
		(800, 'Clear', 'clear sky'),
		(801, 'Clouds', 'few clouds: 11-25%'),
		(802, 'Clouds', 'scattered clouds: 25-50%'),
		(803, 'Clouds', 'broken clouds: 51-84%'),
		(804, 'Clouds', 'overcast clouds: 85-100%');

select * 
from Weather_alerts;




-- Measurements table 
CREATE TABLE public.Measurements
(
    id serial PRIMARY KEY,
	times timestamp,
	time_zone_offset int,
	sunrise  timestamp,
	sunset timestamp,
	temp float,
	feels_like float,
	pressure int,
	humidity  smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	visibility int,
	wind_speed float,
	wind_deg int,
	id_weather_class int,
	id_alert smallint,
	id_sensor smallint,
	id_station smallint,
	FOREIGN KEY (id_weather_class) REFERENCES Weather_alerts(id),
	FOREIGN KEY (id_alert) REFERENCES Alerts(id),
	FOREIGN KEY (id_sensor) REFERENCES Sensors(id),
	FOREIGN KEY (id_station) REFERENCES Stations(id)
);

ALTER TABLE IF EXISTS public.Measurements
    OWNER to joseandres;

COMMENT ON TABLE public.Measurements
    IS 'Weather measurements table';
	
	
select *
from Measurements
where id_station = 1;




-- Forecast table 
CREATE TABLE public.Forecast
(
    id serial PRIMARY KEY,
	time timestamp,
	forcasted_timestamp timestamp,
	sunrise timestamp,
	sunset timestamp,
	temp_min float,
	temp_max float,
	preasure int,
	humidity smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	wind_speed float,
	wind_deg int,
	id_weather_class int,
	id_station smallint NOT NULL,
	FOREIGN KEY (id_weather_class) REFERENCES Weather_alerts(id),
	FOREIGN KEY (id_station) REFERENCES Stations(id)
);

ALTER TABLE IF EXISTS public.Forecast
    OWNER to joseandres;

COMMENT ON TABLE public.Forecast
    IS 'Forecast measurements table.';
	
	
select * 
from Forecast; 



-- Date dimension 

CREATE TABLE dateDim (
	dateKey int PRIMARY KEY,
	day DATE,
	month VARCHAR,
	quarter VARCHAR,
	year INT,
	dayOfMonth int,
	dayOfYear int,
	monthNum int,
	monthName VARCHAR,
	weekDayNum int,
	weekDayName VARCHAR,
	weekEndDay VARCHAR,
	weekOfYear int,
	quarterOfYear int,
	holidayIndicator VARCHAR,
	holiday VARCHAR
);

INSERT INTO dateDim
SELECT  ROW_NUMBER() OVER () as dateKey, 
        day::date as day, 
        EXTRACT(year FROM day) || '-' || LPAD(EXTRACT(month FROM day)::VARCHAR, 2, '0') as month,
        EXTRACT(year FROM day) || '-Q' || EXTRACT(quarter FROM day) as quarter,
        EXTRACT(year FROM day) as year,
        EXTRACT(day FROM day) as dayOfMonth, 
        EXTRACT(doy FROM day) as dayOfYear, 
        EXTRACT(month FROM day) as monthNum, 
        (ARRAY['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'])[EXTRACT(month FROM day)] as monthName,
        EXTRACT(isodow FROM day) as weekDayNum,
        (ARRAY['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])[EXTRACT(isodow FROM day)] as weekDayName,
        CASE WHEN EXTRACT(isodow FROM day) > 5 THEN 'Weekend day' ELSE 'Non-weekend day' END,
        EXTRACT(week FROM day) as weekOfYear,
        EXTRACT(quarter FROM day) as quarterOfYear,
        'Non-holiday' as holidayIndicator,
        NULL as holiday
FROM generate_series('2022-11-04'::date, '2023-11-03'::date, '1 day') AS day; -- generates all days between Nov 4th 2022 to Nov 3th 2023 and populates the date dimension

-- update non-movable holidays

UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'New Year'  WHERE monthNum = 1 AND dayOfMonth = 1;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Epiphany' WHERE monthNum = 1 AND dayOfMonth = 6;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Liberation Day of Italy' WHERE monthNum = 4 AND dayOfMonth = 25;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Labor Day' WHERE monthNum = 5 AND dayOfMonth = 1;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Day of the Republic' WHERE monthNum = 6 AND dayOfMonth = 2;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Assumption Day' WHERE monthNum = 8 AND dayOfMonth = 15;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'All Saints'' Day' WHERE monthNum = 11 AND dayOfMonth = 1;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'Immaculate conception' WHERE monthNum = 12 AND dayOfMonth = 8;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = '1st Christmas Holiday' WHERE monthNum = 12 AND dayOfMonth = 25;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = '2nd Christmas Holiday' WHERE monthNum = 12 AND dayOfMonth = 26;
UPDATE dateDim SET holidayIndicator = 'Holiday', holiday = 'New Year''s Eve' WHERE monthNum = 12 AND dayOfMonth = 31;








-- Validate inner joins 
select s.id, s.name, sen.name, m.times, w.main, a.tag, m.temp
from measurements m 
inner join stations s 
on m.id_station = s.id
inner join sensors sen 
on m.id_sensor = sen.id
inner join weather_alerts w 
on m.id_weather_class = w.id
inner join alerts a
on m.id_alert = a.id
order by s.id;







