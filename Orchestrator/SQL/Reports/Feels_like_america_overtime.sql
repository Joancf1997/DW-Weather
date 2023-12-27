select 	
	s.station,
	d.date_day,
	m.feels_like
from measurements_daily_fact m
inner join stations_dim s
on m.id_station = s.id
inner join date_daily_dim d
on m.id_date = d.dateKey
where s.continent = 'America';