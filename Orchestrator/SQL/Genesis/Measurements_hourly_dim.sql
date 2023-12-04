DROP TABLE IF EXISTS measurements_hourly_dim;

CREATE TABLE measurements_hourly_dim
(
	-- Keys
	id_station smallint,
	id_date int, 
	id_sensor smallint, 
	id_alert smallint,
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
	FOREIGN KEY (id_date) REFERENCES date_hourly_dim(dateKey),
	FOREIGN KEY (id_sensor) REFERENCES sensors_dim(id),
	FOREIGN KEY (id_alert) REFERENCES alerts_dim(id),
	FOREIGN KEY (id_weather_class) REFERENCES weather_class_dim(id)
);

COMMENT ON TABLE measurements_hourly_dim
    IS 'Weather measurements dimensions table';
