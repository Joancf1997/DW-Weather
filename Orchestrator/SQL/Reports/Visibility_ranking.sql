select 
	station,
	round_vis,
	dense_rank_visib
from ranking_visibility
order by dense_rank_visib;
