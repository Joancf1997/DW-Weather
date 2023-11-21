# Project Title
Data Management Technologies - Data Warehouse Project

# Overview
The objective of this project is to design, implement and query a weather data warehouse. This project covers not only the development of the data warehouse, it also covers and development of the data collection, data processing and data visualization modules, simulating the development of a real life implementation for a business in an automated maner. 

This project is designed to efficiently collect and store data from https://openweathermap.org/api in more than 20 cities all over the world, process it using SQL and multiple python services, and store the final results in a data warehouse. As of the last step being a visualization module that allows users to explore and analyze the processed data through charts and graphs.

## Technologies Used

### Python 
    Python version: 3.11.5 
    Homebrew install: https://docs.brew.sh/Homebrew-and-Python

    For the data collection and preprocessing phase two python services where developed, one to collect the current data and the second one to collect the forecast, both of them collecting data for all available stations. All the libraries used are listen in the requirements.txt

### Postgresql
    Postgresql version: stable 15.4
    Homebrew install: https://formulae.brew.sh/formula/postgresql@15

    For the data processing and the data ware house modules Postgresql is use to work with the collected data, this is the main focus of the project specially the data ware house module.
    

# Getting Started

To get started with the project is necesary:
- Install the services mentioned above, both python and Postgresql.
- (Optional) Create conda enviroment >> conda create -n "DMT_Project" python=3.11.5
- Install the python dependencies >> pip3 install -r requirements.txt
- Populate the local Database DB_create.sql
- Execute the python services 

