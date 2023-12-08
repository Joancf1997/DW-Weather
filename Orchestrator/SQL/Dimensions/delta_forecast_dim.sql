-- Temporary table to work with the delta of the forecasted data 
-- The delta is obtained from the update_control control table (last row)

DROP TABLE IF EXISTS forecast_delta;

CREATE TEMPORARY TABLE forecast_delta
(
    id serial PRIMARY KEY,
	time timestamp,
	forcasted_timestamp timestamp,
	sunrise timestamp,
	sunset timestamp,
	temp_min float,
	temp_max float,
	preasure int,
	humidity  smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	wind_speed float,
	wind_deg int,
	id_weather_class int,
	id_station smallint
);


INSERT INTO forecast_delta
SELECT 
	id,
	time,
	forcasted_timestamp,
	sunrise,
	sunset,
	temp_min,
	temp_max,
	preasure,
	humidity,
	dew_point,
	uvi,
	clouds,
	wind_speed,
	wind_deg,
	id_weather_class,
	id_station
FROM forecast
WHERE time > (select max(last_timestamp) from update_control) 
