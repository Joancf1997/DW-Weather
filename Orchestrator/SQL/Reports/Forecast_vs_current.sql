SELECT 
	date_trunc('day', d.date_day) as date,
	MAX(s.station) as station,
	AVG(f.temp_max) as temp_max,
	AVG(m.temp) as temp,
	AVG(f.temp_min) as temp_min
FROM forecast_daily_fact f
INNER JOIN measurements_daily_fact m
ON f.id_station = m.id_station
AND f.id_date = m.id_date
INNER JOIN stations_dim s 
ON f.id_station = s.id
INNER JOIN date_daily_dim d 
ON f.id_date = d.datekey
WHERE f.id_station = 4
GROUP BY date_trunc('day', d.date_day)
ORDER BY date_trunc('day', d.date_day);