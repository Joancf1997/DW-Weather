DROP TABLE IF EXISTS measurements_daily_delta_ready;

CREATE TEMPORARY TABLE measurements_daily_delta_ready 
(
    -- KEY Dimensions
    id_station smallint,
    id_date int,
	id_weather_class int,
    -- Measurements
	temp float,
	feels_like float,
	pressure int,
	humidity  smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	visibility int,
	wind_speed float,
	wind_deg int
);

INSERT INTO measurements_daily_delta_ready
SELECT 
    -- Dimensions
	m.id_station,
	d.datekey as id_date,
	m.id_weather_class,
	-- measurements avg 
	m.temp,
	m.feels_like,
	m.pressure,
	m.humidity,
	m.dew_point,
	m.uvi,
	m.clouds,
	m.visibility,
	m.wind_speed,
	m.wind_deg
from measurements_delta_daily m
INNER JOIN date_daily_dim d
ON m.date_day = d.date_day
ORDER BY d.datekey;