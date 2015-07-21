.separator ,
.mode csv
.output gen/stations.csv
select stop_name, lower(stop_name) from stops where stop_name like '%METROLINK STATION%' group by stop_name; 
