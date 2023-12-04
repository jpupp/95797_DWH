SELECT loc.Zone, COUNT(taxi_trips.PUlocationID) as trip_count
FROM {{ref('mart__fact_all_taxi_trips')}} taxi_trips
JOIN {{ref('mart__dim_locations')}} loc ON taxi_trips.PUlocationID = loc.LocationID
GROUP BY loc.Zone -- Grouping the results by Zone to aggregate trip counts for each zone
HAVING COUNT(taxi_trips.PUlocationID) < 100000; -- Filtering the grouped results to include only zones with trip counts less than 100,000
