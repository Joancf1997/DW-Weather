from Core.Orchestrator import Orchestrator
from Steps import Steps

steps = Steps()
# Steps 
orchestator = Orchestrator(
    [
        # Run to restart data
        #steps.DropAll,
        #steps.Genesis,

        # Run to update DW
        #steps.Dimensions,
        #steps.Transform,
        #steps.Load,

        # Run to generate analysis tables
        #steps.Analysis,

        # Run to generate the graphs
        steps.Rep_temp_evol,
        #steps.Rep_temp_diff,
        #steps.Rep_visibility_rank,
        #steps.Rep_feels_like_america_overtime,
        #steps.Rep_uvi_europe_overtime,
        #steps.Rep_current_vs_forecast_munich
    ]
)
# Only needed when working with datasets from DB in python
steps.helper = orchestator.get_hepler()

# Start execution
orchestator.execute()