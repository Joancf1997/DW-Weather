-- Extract values from "overlapping" day
create TEMPORARY table overlapping_measurements_day as
select
	id_station,
	id_date,
	temp,
	feels_like,
	pressure,
	humidity,
	dew_point,
	uvi,
	clouds,
	visibility,
	wind_speed,
	wind_deg
from measurements_daily_fact
where id_date = (
	select min(id_date)
	from measurements_daily_delta_ready
);


-- average values of "overlapping" day 
create TEMPORARY table clean_measurements_day as
SELECT
    m.id_station,
	m.id_date,
	m.id_weather_class,
	CASE WHEN o.temp IS NOT NULL THEN (m.temp + o.temp) / 2 ELSE m.temp END as temp,
	CASE WHEN o.feels_like IS NOT NULL THEN (m.feels_like + o.feels_like) / 2 ELSE m.feels_like END as feels_like,
	CASE WHEN o.pressure IS NOT NULL THEN (m.pressure + o.pressure) / 2 ELSE m.pressure END as pressure,
	CASE WHEN o.humidity IS NOT NULL THEN (m.humidity + o.humidity) / 2 ELSE m.humidity END as humidity,
	CASE WHEN o.dew_point IS NOT NULL THEN (m.dew_point + o.dew_point) / 2 ELSE m.dew_point END as dew_point,
	CASE WHEN o.uvi IS NOT NULL THEN (m.uvi + o.uvi) / 2 ELSE m.uvi END as uvi,
	CASE WHEN o.clouds IS NOT NULL THEN (m.clouds + o.clouds) / 2 ELSE m.clouds END as clouds,
	CASE WHEN o.visibility IS NOT NULL THEN (m.visibility + o.visibility) / 2 ELSE m.visibility END as visibility,
	CASE WHEN o.wind_speed IS NOT NULL THEN (m.wind_speed + o.wind_speed) / 2 ELSE m.wind_speed END as wind_speed,
	CASE WHEN o.wind_deg IS NOT NULL THEN (m.wind_deg + o.wind_deg) / 2 ELSE m.wind_deg END as wind_deg
FROM measurements_daily_delta_ready m
LEFT JOIN overlapping_measurements_day o 
ON m.id_date = o.id_date
AND m.id_station = o.id_station
ORDER by id_date;



-- Delet "overlapping" day from fact table 
DELETE FROM measurements_daily_fact
WHERE id_date = (
	SELECT MIN(id_date)
	FROM measurements_daily_delta_ready
);


-- Insert delta info fact table
INSERT INTO measurements_daily_fact 
SELECT 
	-- Dimensions
	id_station,
	id_date,
	id_weather_class,
	-- measurements avg 
	temp,
	feels_like,
	pressure,
	humidity,
	dew_point,
	uvi,
	clouds,
	visibility,
	wind_speed,
	wind_deg
from clean_measurements_day;
