DROP TABLE IF EXISTS forecast_daily_fact;


CREATE TABLE forecast_daily_fact
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
	wind_deg int,
	-- Dimension tables references
	FOREIGN KEY (id_station) REFERENCES stations_dim(id),
	FOREIGN KEY (id_date) REFERENCES date_daily_dim(dateKey),
	FOREIGN KEY (id_weather_class) REFERENCES weather_class_dim(id)
);


COMMENT ON TABLE forecast_daily_fact
    IS 'Weather forecast daily dimensions table to compare with current measurements table';
