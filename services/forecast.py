import requests
import json
from random import randint
from datetime import datetime
import time
import psycopg2    #pip3 install psycopg2-binary / https://pypi.org/project/psycopg2-binary/


#Python version 3.11.5 

# Variables de la api - https://api.openweathermap.org/data/2.5/onecall?lat=41.902782&lon=12.496366&appid=b0941dea317734e2ce97e02fd8782f8c&units=metric
weather_api = 'https://api.openweathermap.org/data/2.5/onecall'
api_key = 'b0941dea317734e2ce97e02fd8782f8c'
metrics = 'metric'


# Postgres DB connection 
class DB():
    def __init__(self): 
        self.conn = None
        self.cursor = None

    # Connecto to the DB 
    def connect(self): 
        try:
            self.conn = psycopg2.connect(database='DMT', host='localhost',user='joseandres', password='', port='5432')
            self.cursor = self.conn.cursor()

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

    # Disconnect from the DB 
    def disconect(self):
        self.cursor.close()
        if self.conn is not None:
            self.conn.close()
            print('Database connection closed.')
        else: 
            print('Database is not connected.')
    
    # Get all stations available
    def get_stations(self):
        self.cursor.execute('SELECT * from Stations;')
        return self.cursor.fetchall()

    # Insert forecasted values requested
    def insert_forecasted_measurements(self, values):
        sql_vals = ",".join(self.cursor.mogrify("(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", x).decode('utf-8') for x in values)
        self.cursor.execute("INSERT INTO Forecast (time, forcasted_timestamp, sunrise, sunset, temp_min, temp_max, preasure, humidity, dew_point, uvi, clouds, wind_speed, wind_deg, id_weather_class, id_station) VALUES " + sql_vals + ";")
        self.conn.commit()
        print("Values inserted...")



# Request forecast of current day from the list of stations 
def req_forecast_data():
    # Open connection to DB 
    db.connect()
    # Obtain all stations from DB 
    list_stations = db.get_stations()


    # List to store all current values and do only une insertion to the DB
    station_values = []
    for station in list_stations:
        print("Requesting forecast for " + station[1] + "...")
        lat = station[2]
        lon = station[3]
        request_url = weather_api + "?lat=" + str(lat) + "&lon=" + str(lon) + "&appid=" + api_key + "&units=" + metrics + "&only_current={false}"

        # Request the data
        res = requests.get(request_url)
        res_json = json.loads(res.text)

        # Validate and prepare the data
        if "cod" not in res_json:  # Good response

            # Store the forecast of the 7 days for each station
            for forecast in res_json["daily"]:

                values = ( 
                        datetime.utcfromtimestamp(res_json["current"]["dt"]), 
                        datetime.utcfromtimestamp(forecast["dt"]), 
                        datetime.utcfromtimestamp(forecast["sunrise"]), 
                        datetime.utcfromtimestamp(forecast["sunset"]), 
                        forecast["temp"]["min"], 
                        forecast["temp"]["max"],
                        forecast["pressure"],
                        forecast["humidity"], 
                        forecast["dew_point"],
                        forecast["uvi"],
                        forecast["clouds"],
                        forecast["wind_speed"],
                        forecast["wind_deg"],
                        forecast["weather"][0]["id"],
                        station[0])

                # append all 
                station_values.append(values)
        time.sleep(20)

    # Insert values
    db.insert_forecasted_measurements(station_values)
    db.disconect()



if __name__ == '__main__':
    # DB Conection parameters 
    db = DB()

    # First request and schedule the requests every 5 minutes
    req_forecast_data()
    
