-- Temporary table to work with the delta of the measurements 
-- The delta is obtained from the update_control control table (last row)

DROP TABLE IF EXISTS measurements_delta;

CREATE TEMPORARY TABLE measurements_delta
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
	id_station smallint
);


INSERT INTO measurements_delta
SELECT
    m.id,
    m.times, 
    m.time_zone_offset,
    m.sunrise,
    m.sunset,
    m.temp,
    m.feels_like,
    m.pressure,
    m.humidity,
    m.dew_point,
    m.uvi,
    m.clouds,
    m.visibility,
    m.wind_speed,
    m.wind_deg,
    m.id_weather_class,
    m.id_alert,
    m.id_sensor,
    m.id_station
FROM measurements m
where m.id > (select max(last_source_id) from update_control)
