# List of steps to be exetuted 
import matplotlib.pyplot as plt

class Steps(): 
    def __init__(self):
        self.payload = None
        self.helper = None
    
    # Drop all table in source and DW
    def DropAll(self):
        pass
    
    # Create the initial tables for the project
    def Genesis(self):
        pass

    # Regenerate the dimensions in the DW (catalogs)
    def Dimensions(self):
        pass
        
    # Execute the transacctions to the measurements deltas
    def Transform(self):
        pass

    # Load the fact deltas to the fact table
    def Load(self):
        pass

    def Analysis(self):
        pass

    def Rep_temp_evol(self):
        #=========================== Temperature evolution during the months ===========================
        temp_intermonth = self.helper.execute_sql_select("SQL/Reports/Temp_intermonth.sql")
        # Pivot the dataframe to have separate columns for each month
        df_pivot = temp_intermonth.pivot(index='station', columns='date', values='avg_temp')
        fig, ax = plt.subplots(figsize=(15, 13)) # Create a bar plot
        df_pivot.plot(kind='bar', ax=ax)  # Plot bars for each station
        # Set labels and title
        ax.set_xlabel('Station')
        ax.set_ylabel('Average Temperature')
        ax.set_title('Average Temperature Comparison for Each Station every month')
        fig.savefig('IMG/Report_temp_evolution.png')   
        plt.close(fig)  



    def Rep_temp_diff(self): 
        temp_diff = self.helper.execute_sql_select("SQL/Reports/Temp_diff.sql")
        # Pivot the dataframe to have separate columns for each month
        temp_diff = temp_diff.set_index("station")
        avg_temp = temp_diff.iloc[1]['avg_temp']
        temp_diff = temp_diff.drop('avg_temp', axis=1)
        fig, ax = plt.subplots(figsize=(15, 13)) # Create a bar plot
        temp_diff.plot(kind='bar', ax=ax)  # Plot bars for each station
        plt.axhline(y=avg_temp, color='red', linestyle='--', label='Avg Temp')
        # Set labels and title
        ax.set_xlabel('Station')
        ax.set_ylabel('Temperature')
        ax.set_title('Average temperature vs temperature station')

        fig.savefig('IMG/Report_temp_diff.png')   
        plt.close(fig)  


    def Rep_visibility_rank(self): 
        vis_rank = self.helper.execute_sql_select("SQL/Reports/Visibility_ranking.sql")

        vis_rank = vis_rank.set_index("station")
        fig, ax = plt.subplots(figsize=(15, 13)) # Create a bar plot
        vis_rank.plot(kind='bar', ax=ax)  # Plot bars for each station
        # Set labels and title
        ax.set_xlabel('Station')
        ax.set_ylabel('Rounded Avg visibility')
        ax.set_title('Visibility for each station')
        fig.savefig('IMG/Report_visibility_ranking.png')   
        plt.close(fig) 


    def Rep_feels_like_america_overtime(self):
        feels_like = self.helper.execute_sql_select("SQL/Reports/Feels_like_america_overtime.sql")
        feels_like_piv = feels_like.pivot(index="date_day", columns="station", values="feels_like")
        fig, ax = plt.subplots(figsize=(15, 13)) # Create a bar plot
        feels_like_piv.plot(ax=ax)  # Plot bars for each station
        # Set labels and title
        ax.set_xlabel('Station')
        ax.set_ylabel('Feels like')
        ax.set_title('Feels like evolution over time')
        fig.savefig('IMG/feels_like_america.png')   
        plt.close(fig) 

    def Rep_uvi_europe_overtime(self):
        uvi_eu = self.helper.execute_sql_select("SQL/Reports/Uvi_europ_overtime copy.sql")
        uvi_eu = uvi_eu.pivot(index="date_day", columns="station", values="uvi")
        fig, ax = plt.subplots(figsize=(15, 13)) # Create a bar plot
        uvi_eu.plot(ax=ax)  # Plot bars for each station
        # Set labels and title
        ax.set_xlabel('Station')
        ax.set_ylabel('UVI - Ultraviolet (UV) Index')
        ax.set_title('UVI evolution in Europ over time')
        fig.savefig('IMG/Uvi_europe.png')   
        plt.close(fig) 


    def Drop(self): 
        pass
    



