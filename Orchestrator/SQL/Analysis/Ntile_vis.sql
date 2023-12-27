/*
    Classify in 5 groups the  visibility range of all the stations
*/

DROP TABLE IF EXISTS ntile_vis;

CREATE TABLE ntile_vis
(
	id_station smallint,
	continent character varying(7),
	country character varying(50), 
    country_acronym character varying(3),
	station character varying(20),
	avg_vis int,
	gruop_vis int
);


INSERT INTO ntile_vis
SELECT
	id_station,
	continent,
	country,
	country_acronym,
	station, 
	avg_vis,
	gruop_vis
FROM 
(
	SELECT
		id_station,
		ROUND(avg(visibility), -3) AS avg_vis,
		NTILE(5) OVER(ORDER BY ROUND(avg(visibility), -3)) AS gruop_vis
	FROM measurements_daily_fact m
	GROUP BY id_station
) m
INNER JOIN stations_dim s
ON m.id_station = s.id;