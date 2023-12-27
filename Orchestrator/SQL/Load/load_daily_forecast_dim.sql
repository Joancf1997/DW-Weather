INSERT INTO forecast_daily_fact 
SELECT 
	-- KEY Dimensions
    id_station,
    id_date,
	id_weather_class,
    -- Measurements
	temp_max,
	temp_min,
	pressure,
	humidity,
	dew_point,
	uvi,
	clouds,
	wind_speed,
	wind_deg 
from forecast_daily_delta_ready;
