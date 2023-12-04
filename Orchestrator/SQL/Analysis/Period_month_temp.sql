
/*
    Compare the average temp of every station every month
*/

DROP TABLE IF EXISTS temp_month;

CREATE TABLE temp_month
(
	id_station smallint,
	country character varying(50), 
	station character varying(20),
	date character varying(7),
	year int,
	month int,
	avg_temp float
);


INSERT INTO temp_month
SELECT  
	id_station,
	s.country,
	s.station,
	date,
	year,
	month,
	avg_temp
FROM 
(
	SELECT 
		id_station,
		max(month) as date,
		max(year) as year, 
		max(monthnum) as month,
		avg(temp) as avg_temp
	FROM measurements_daily_dim m 
	INNER JOIN date_daily_dim d
	ON m.id_date = d.datekey
	GROUP BY id_station, month
) d
INNER JOIN stations_dim s
ON d.id_station = s.id
ORDER BY s.station, date;