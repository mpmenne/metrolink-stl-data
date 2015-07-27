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
        sqlite3 -csv  metrolink.db <<< "select * from metrolink_stops where stop_name=$col5 and service_id='1_merged_2038871';" | tee "$WEEKDAY_FILE_NAME" 
        sqlite3 -csv  metrolink.db <<< "select * from metrolink_stops where stop_name=$col5 and service_id='2_merged_2038873';" | tee "$WEEKEND_FILE_NAME" 
done < gen/stations.csv
