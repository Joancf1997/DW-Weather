/* 
    RANK(): Compute the ranking of the coldes and hottest stations.
*/

DROP TABLE IF EXISTS ranking_temp;

CREATE TABLE ranking_temp
(
	id_station smallint,
	continent character varying(7),
	country character varying(50), 
	country_acronym character varying(3),
	station character varying(20),
    avg_temp float,
	Coldest smallint,
	Hottet smallint
);

INSERT INTO ranking_temp
select
	id_station,
	continent,
	country,
	country_acronym,
	station, 
    avg_temp,
	Coldest,
	Hottet
from 
(
	select 
		id_station,
		avg(temp) as avg_temp,
		RANK() OVER (ORDER BY max(temp)) Coldest,
		RANK () OVER (ORDER BY max(temp) DESC) Hottet
	from measurements_daily_dim
	group by id_station
) m
inner join stations_dim s
on m.id_station = s.id;