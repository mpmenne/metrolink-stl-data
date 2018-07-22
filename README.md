# About the St. Louis metrolink data

All of the data is compiled from the GTFS (Google Transit Feed Specification) which is a nationwide format for aggregating transit data.

The data contained in this repository was obtained by the GTFS exchange.  The last update to this repo was July 18th, 2018

http://www.metrostlouis.org/About/DeveloperResource.aspx

## The Data

The GTFS CSV data can easily be imported into a sqlite database and embedded in the application of your choice.

If you are using the [NextMetro app](https://github.com/MoMenne/metrolink-stl-ios), CSV files are embedded instead of an actual sqlite database.

To generate the sqlite database, run the command
```
generate_database.sh
```
This will create the database as well as populate all of the data contained in the raw directory.

To export the data to CSV, run the following command
```
export_to_csv.sh
```
This will generate all of the stop times for the St. Louis Metrolink per station.  Each station will have two files, one file representing the stop times for weekday service and the other file representing stop times for weekend service.

## Instructions on how to use sqlite3

To view the database navigate to the directory of the database file and type on the command line

`sqlite3 metrolink.db`

To exit the database type

`.exit`

To view the schema of the database type

`.schema`

To view the schema of a single table type

`.schema {table name}`

## helpful commands


`.schema`             -shows all tables schemas

`.schema stops`       -shows the schema for the stops table

`.headers ON`         -shows headers of the tables

`.exit`               -returns to the command prompt

`.mode csv`           -sets output to csv

`.mode stdout`        -returns output to standard out (console)

`.output some.txt`    -the file that you would like the csv to occupy
