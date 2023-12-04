import requests
import json
from random import randint
from datetime import datetime
import time
import psycopg2    # pip3 install psycopg2-binary / https://pypi.org/project/psycopg2-binary/
import schedule    # pip3 install schedule  /  https://pypi.org/project/schedule/


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

    # Insert current values requested
    def insert_current_measurements(self, values):
        sql_vals = ",".join(self.cursor.mogrify("(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", x).decode('utf-8') for x in values)
        self.cursor.execute("INSERT INTO Measurements (times, time_zone_offset, sunrise, sunset, temp, feels_like, pressure, humidity, dew_point, uvi, clouds, visibility , wind_speed, wind_deg, id_weather_class, id_alert, id_sensor, id_station) VALUES " + sql_vals + ";")
        self.conn.commit()
        print("Values inserted...")
    
    # Insert forecasted values 
    def insert_forecast(self):
        print("Insert forecasted values, once a day")



# Extract list of stations 
def req_current_data():
    # Open connection to DB 
    db.connect()
    # Obtain all stations from DB 
    list_stations = db.get_stations()


    # List to store all current values and do only une insertion to the DB
    station_values = []
    for station in list_stations:
        print("Requesting infor for " + station[1] + "...")
        lat = station[2]
        lon = station[3]
        request_url = weather_api + "?lat=" + str(lat) + "&lon=" + str(lon) + "&appid=" + api_key + "&units=" + metrics + "&only_current={true}"

        # Request the data
        res = requests.get(request_url)
        res_json = json.loads(res.text)

        # Random sensor (1-4)
        sensor = randint(1, 4)

        # Validate and prepare the data
        if "cod" in res_json:   # Bad request
            values = ( None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, sensor, station[0])
        else:                   # Good response

            # Validate alerts
            alert = 1
            if 'alerts' in res_json:
                alert_name = res_json["alerts"][0]["tags"][0]

                match alert_name:
                    case 'Thunderstorm': 
                        alert = 2
                    case 'Drizzle': 
                        alert = 3
                    case 'Rain': 
                        alert = 4
                    case 'Snow': 
                        alert = 5
                    case 'Atmosphere': 
                        alert = 6
                    case 'Clear': 
                        alert = 7
                    case 'Clouds': 
                        alert = 8
                    case 'Wind': 
                        alert = 10
                    case _:
                        alert = 9

            values = ( 
                    datetime.utcfromtimestamp(res_json["current"]["dt"]), 
                    res_json["timezone_offset"],
                    datetime.utcfromtimestamp(res_json["current"]["sunrise"]), 
                    datetime.utcfromtimestamp(res_json["current"]["sunset"]), 
                    res_json["current"]["temp"], 
                    res_json["current"]["feels_like"],
                    res_json["current"]["pressure"],
                    res_json["current"]["humidity"], 
                    res_json["current"]["dew_point"],
                    res_json["current"]["uvi"],
                    res_json["current"]["clouds"],
                    res_json["current"]["visibility"], 
                    res_json["current"]["wind_speed"],
                    res_json["current"]["wind_deg"],
                    res_json["current"]["weather"][0]["id"],
                    alert,
                    sensor,
                    station[0])

        # append all 
        station_values.append(values)
        time.sleep(30)

    # Insert values
    db.insert_current_measurements(station_values)
    db.disconect()


if __name__ == '__main__':
    # DB Conection parameters 
    db = DB()

    # First request and schedule the requests every 5 minutes
    req_current_data()
    schedule.every(32).minutes.do(req_current_data)
    
    while True:
        schedule.run_pending()
        time.sleep(1)
    
