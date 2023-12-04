DROP TABLE IF EXISTS measurements_delta_hourly;

CREATE TEMPORARY TABLE measurements_delta_hourly 
(
	-- Ids
    id_station smallint,
    date_hour timestamp,
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


INSERT INTO measurements_delta_hourly
SELECT 
	id_station,
	date_trunc('hour', times) as date_hour,
	max(id_weather_class) as id_weather_class,
	max(id_alert) as id_alert,
	max(id_sensor) as id_sensor,
	-- measurements avg 
	avg(temp) as temp,
	avg(feels_like) as feels_like,
	avg(pressure) as pressure,
	avg(humidity) as humidity,
	avg(dew_point) as dew_point,
	avg(uvi) as uvi,
	avg(clouds) as clouds,
	avg(visibility) as visibility,
	avg(wind_speed) as wind_speed,
	avg(wind_deg) as wind_deg
FROM measurements_delta
GROUP BY id_station, date_trunc('hour', times);