.separator ,
.mode csv
.output gen/stations.csv
select s.stop_lat, s.stop_id, s.stop_lon, s.stop_id, s.stop_desc, s.stop_name, replace(replace(lower(s.stop_name), " ", "_"), "&", "and")
 from routes r
join trips t on t.route_id = r.route_id
join stop_times st on st.trip_id = t.trip_id
join stops s on s.stop_id = st.stop_id
where r.route_type = 2 group by stop_name;
