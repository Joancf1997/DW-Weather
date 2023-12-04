-- Dimension table 
DROP TABLE IF EXISTS alerts_dim CASCADE;
DROP TABLE IF EXISTS stations_dim CASCADE;
DROP TABLE IF EXISTS sensors_dim CASCADE;
DROP TABLE IF EXISTS weather_class_dim CASCADE;
DROP TABLE IF EXISTS date_daily_dim CASCADE;
DROP TABLE IF EXISTS date_hourly_dim CASCADE;





-- measurements tables 
DROP TABLE IF EXISTS measurements_daily_dim CASCADE;
DROP TABLE IF EXISTS measurements_hourly_dim CASCADE;
DROP TABLE IF EXISTS forecast_daily_dim CASCADE;