/* 
    DENSE_RANK(): Compute the ranking of the rounded visibility of each station with rank and dense_rank
*/

DROP TABLE IF EXISTS ranking_visibility;

CREATE TABLE ranking_visibility
(
	id_station smallint,
	continent character varying(7),
	country character varying(50), 
    country_acronym character varying(3),
	station character varying(20),
	round_vis int,
	rank_visib int,
	dense_rank_visib int
);

INSERT INTO ranking_visibility
SELECT
	id_station,
	continent,
	country,
	country_acronym,
	station, 
	round_vis,
	rank_visib,
	dense_rank_visib
from 
(
	select
		id_station, 
		ROUND(avg(visibility), -3) as round_vis,
		RANK() OVER (ORDER BY ROUND(avg(visibility), -3)) rank_visib,
		DENSE_RANK() OVER (ORDER BY ROUND(avg(visibility), -3)) dense_rank_visib
	from measurements_daily_fact
	group by id_station
) m
inner join stations_dim s
on m.id_station = s.id;