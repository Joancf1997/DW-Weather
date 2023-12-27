/*
    WINDOWING (): Calculate the average temperature of each station and the difference of each station compare to the mean of the others.

*/
DROP TABLE IF EXISTS temp_avg;


CREATE TABLE temp_avg
(
	id_station smallint, 
	country character varying(50),
	station character varying(20),
	temp float, 
	avg_temp float,
	temp_diff float
);


INSERT INTO temp_avg
SELECT 
	id_station, 
	s.country,
	s.station,
	temp, 
	avg_temp,
	(temp - avg_temp) AS temp_diff
FROM 
(
	SELECT 
		id_station,
		avg(temp) AS temp,
		avg(avg(temp)) OVER() avg_temp
	FROM measurements_daily_fact
	GROUP BY id_station
) t
INNER JOIN stations_dim s
ON t.id_station = s.id;