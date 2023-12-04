SELECT l.Borough, l.Zone as Pickup_Zone, COUNT(*) as trip_count, AVG(t.duration_min) as avg_duration_min 
FROM {{ ref('mart__fact_all_taxi_trips') }} t
JOIN {{ ref('mart__dim_locations') }} l ON t.PUlocationID = l.LocationID 
GROUP BY l.Borough, l.Zone;