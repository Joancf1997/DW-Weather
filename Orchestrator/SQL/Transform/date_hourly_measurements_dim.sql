DROP TABLE IF EXISTS measurements_hourly_delta_ready;

CREATE TEMPORARY TABLE measurements_hourly_delta_ready 
(
    -- KEY Dimensions
    id_station smallint,
    id_date int,
	id_weather_class int,
	id_alert smallint,
	id_sensor smallint,
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

INSERT INTO measurements_hourly_delta_ready
SELECT 
    -- Dimensions
	m.id_station,
	d.datekey as id_date,
	m.id_weather_class,
	m.id_alert,
	m.id_sensor,
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
from measurements_delta_hourly m
INNER JOIN date_hourly_dim d
ON m.date_hour = d.date_hour
ORDER BY d.datekey;