INSERT INTO measurements_daily_dim 
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
from measurements_daily_delta_ready;
