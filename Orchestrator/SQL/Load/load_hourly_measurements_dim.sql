INSERT INTO measurements_hourly_dim
SELECT 
    -- Dimensions
	id_station,
	id_date,
	id_sensor,
	id_alert,
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
from measurements_hourly_delta_ready;