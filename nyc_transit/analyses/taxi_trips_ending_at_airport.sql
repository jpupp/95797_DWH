SELECT count(*) AS airport_trips
FROM  {{ ref('mart__fact_all_taxi_trips')}} AS all_taxi_trips
JOIN {{ ref('mart__dim_locations')}} AS loc ON CAST(all_taxi_trips.DOlocationID AS INT) = loc.LocationID
WHERE loc.service_zone IN ('Airports', 'EWR')