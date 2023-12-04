/*
    CUBE (): obtaining the metrics (Min, Max, Avg) for station, weather class and sensor type (all combinations): 

*/
DROP TABLE IF EXISTS cube_uvi_analysis;

CREATE TABLE cube_uvi_analysis 
(
   	id_station smallint,
	country character varying(50), 
	station character varying(20),
	weather_class character varying(40),
	sensor character varying(3),
	min_uvi float,
	avg_uvi float,
	max_uvi float
);


INSERT INTO cube_uvi_analysis
SELECT
	id_station,
	country, 
	station,
	w.description as weather_class,
	sen.name as sensor,
	min_uvi,
	avg_uvi,
	max_uvi
FROM 
(
	SELECT 
		id_station,
		id_sensor,
		id_weather_class,
		min(uvi) as min_uvi,
		avg(uvi) as avg_uvi,
		max(uvi) as max_uvi
	FROM measurements_hourly_dim
	GROUP BY
		Cube (id_station, id_sensor, id_weather_class)
) m
INNER JOIN stations_dim s
ON m.id_station = s.id
INNER JOIN weather_class_dim w
ON m.id_weather_class = w.id
inner join sensors_dim sen 
on m.id_sensor = sen.id
ORDER BY id_station, w.description, id_sensor;
