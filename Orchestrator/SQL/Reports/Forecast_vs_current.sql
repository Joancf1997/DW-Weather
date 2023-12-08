SELECT 
	date_trunc('day', d.date_day) as date,
	s.station,
	f.temp_max,
	m.temp,
	f.temp_min
FROM forecast_daily_dim f
INNER JOIN measurements_daily_dim m
ON f.id_station = m.id_station
AND f.id_date = m.id_date
INNER JOIN stations_dim s 
ON f.id_station = s.id
INNER JOIN date_daily_dim d 
ON f.id_date = d.datekey
WHERE f.id_station = 4
ORDER BY date_trunc('day', d.date_day);
