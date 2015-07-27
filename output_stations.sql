.separator ,
.mode csv
.output gen/stations.csv
select stop_lat, stop_id, stop_lon, stop_id, stop_desc, stop_name, replace(replace(lower(stop_name), " ", "_"), "&", "and") from stops where stop_name like '%METROLINK STATION%' group by stop_name; 
