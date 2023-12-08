DROP TABLE IF EXISTS forecast_delta_daily;

CREATE TEMPORARY TABLE forecast_delta_daily 
(
	-- Ids
    id_station smallint,
	date_day timestamp,
	id_weather_class int,
	-- Measurements
	temp_max float,
	temp_min float,
	preasure int,
	humidity  smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	wind_speed float,
	wind_deg int
);


INSERT INTO forecast_delta_daily
SELECT 
	id_station,
    date_trunc('day', forcasted_timestamp) as date_day,
	max(id_weather_class) as id_weather_class,
	-- measurements avg 
	avg(temp_max) as temp_max,
	avg(temp_min) as temp_min,
	avg(preasure) as preasure,
	avg(humidity) as humidity,
	avg(dew_point) as dew_point,
	avg(uvi) as uvi,
	avg(clouds) as clouds,
	avg(wind_speed) as wind_speed,
	avg(wind_deg) as wind_deg
FROM forecast_delta
GROUP BY id_station, date_trunc('day', forcasted_timestamp);
