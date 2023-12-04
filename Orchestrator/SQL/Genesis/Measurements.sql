DROP TABLE IF EXISTS measurements;

CREATE TABLE measurements
(
    id serial PRIMARY KEY,
	times timestamp,
	time_zone_offset int,
	sunrise  timestamp,
	sunset timestamp,
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
	id_weather_class int,
	id_alert smallint,
	id_sensor smallint,
	id_station smallint,
	FOREIGN KEY (id_weather_class) REFERENCES Weather_alerts(id),
	FOREIGN KEY (id_alert) REFERENCES Alerts(id),
	FOREIGN KEY (id_sensor) REFERENCES Sensors(id),
	FOREIGN KEY (id_station) REFERENCES Stations(id)
);

COMMENT ON TABLE measurements
    IS 'Weather measurements table';

