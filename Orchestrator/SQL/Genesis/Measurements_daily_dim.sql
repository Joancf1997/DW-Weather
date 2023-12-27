DROP TABLE IF EXISTS measurements_daily_fact;


CREATE TABLE measurements_daily_fact
(
	-- Keys
	id_station smallint,
	id_date int, 
	id_weather_class int, 
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
	wind_deg int,
	-- Dimension tables references
	FOREIGN KEY (id_station) REFERENCES stations_dim(id),
	FOREIGN KEY (id_date) REFERENCES date_daily_dim(dateKey),
	FOREIGN KEY (id_weather_class) REFERENCES weather_class_dim(id)
);


COMMENT ON TABLE measurements_daily_fact
    IS 'Weather measurements daily dimensions table to compare with forecast measurements table';
