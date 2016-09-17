if [ -d "gen" ]; then
  rm -r gen
fi
mkdir gen
echo "Starting the database build..."
sqlite3 metrolink.db < output_stations.sql
echo "Database generated.  Beginning output to CSV"

IFS="," 
while read col0 col1 col2 col3 col4 col5 col6
do
        no_quotes=${col6//\"}
        no_ampersands=${no_quotes//&/and}
        url_friendly=${no_ampersands// /_}
        echo "$url_friendly"
        WEEKDAY_FILE_NAME="gen/$url_friendly-mf.csv"
        WEEKEND_FILE_NAME="gen/$url_friendly-ss.csv"

        # we want to exclude any arrivals to stations at the end of the line
        END_OF_LINE_EXCLUSIONS="( NOT (stop_name like '%SHREWSBURY%' AND trip_headsign like '%SHREWSBURY%')) AND ( NOT (stop_name like '%EMERSON%' AND trip_headsign like '%EMERSON%')) AND ( NOT ( stop_name like '%CIVIC CENTER%' AND trip_headsign like '%CIVIC CENTER%')) AND ( NOT (stop_name like '%FAIRVIEW HEIGHTS%' AND trip_headsign like '%FAIRVIEW_HEIGHTS%')) AND ( NOT ( stop_name like '%GRAND%' AND trip_headsign like '%GRAND%')) AND ( NOT ( stop_name like '%SHILOH%' AND trip_headsign like '%SHILOH%')) AND ( NOT (stop_name like '%WASHINGTON PARK%' AND trip_headsign like '%WASHINGTON PARK%')) AND ( NOT ( stop_name like '%LAMBERT MAIN%' and trip_headsign like '%TERMINAL #1%'))" 

        WEEKDAY_QUERY="select * from metrolink_stops where stop_name=$col5 and service_id='1' and $END_OF_LINE_EXCLUSIONS order by arrival_time;"
        echo $WEEKDAY_QUERY
        sqlite3 -csv  metrolink.db <<< $WEEKDAY_QUERY | tee "$WEEKDAY_FILE_NAME" 
        sqlite3 -csv  metrolink.db <<< "select * from metrolink_stops where stop_name=$col5 and service_id='2' and $END_OF_LINE_EXCLUSIONS order by arrival_time;" | tee "$WEEKEND_FILE_NAME" 
done < gen/stations.csv
