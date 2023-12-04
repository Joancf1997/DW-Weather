DROP TABLE IF EXISTS forecast;

CREATE TABLE forecast
(
    id serial PRIMARY KEY,
	time timestamp,
	forcasted_timestamp timestamp,
	sunrise timestamp,
	sunset timestamp,
	temp_min float,
	temp_max float,
	preasure int,
	humidity smallint,
	dew_point float,
	uvi	float,
	clouds smallint,
	wind_speed float,
	wind_deg int,
	id_weather_class int,
	id_station smallint NOT NULL,
	FOREIGN KEY (id_weather_class) REFERENCES Weather_alerts(id),
	FOREIGN KEY (id_station) REFERENCES Stations(id)
);


COMMENT ON TABLE forecast
    IS 'Forecast measurements table.';
