DROP TABLE IF EXISTS forecast_daily_delta_ready;

CREATE TEMPORARY TABLE forecast_daily_delta_ready 
(
    -- KEY Dimensions
    id_station smallint,
    id_date int,
	id_weather_class int,
    -- Measurements
	temp_max float,
	temp_min float,
	pressure int,
	humidity  smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	wind_speed float,
	wind_deg int
);

INSERT INTO forecast_daily_delta_ready
SELECT 
    -- Dimensions
	m.id_station,
	d.datekey as id_date,
	m.id_weather_class,
	-- measurements avg 
	m.temp_max,
	m.temp_min,
	m.preasure as pressure,
	m.humidity,
	m.dew_point,
	m.uvi,
	m.clouds,
	m.wind_speed,
	m.wind_deg
from forecast_delta_daily m
INNER JOIN date_daily_dim d
ON m.date_day = d.date_day
ORDER BY d.datekey;