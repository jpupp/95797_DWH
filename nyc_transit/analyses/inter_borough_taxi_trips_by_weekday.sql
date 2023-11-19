WITH TripData AS ( SELECT WEEKDAY(pickup_datetime) AS weekday, CASE WHEN pu_loc.Borough != do_loc.Borough THEN 1 ELSE 0 END AS is_diff_borough
FROM {{ ref('mart__fact_all_taxi_trips')}} AS all_taxi_trips
JOIN {{ ref('mart__dim_locations')}} AS pu_loc ON CAST(all_taxi_trips.PUlocationID AS INT) = pu_loc.LocationID
JOIN {{ ref('mart__dim_locations')}} AS do_loc ON CAST(all_taxi_trips.DOlocationID AS INT) = do_loc.LocationID
)
SELECT weekday,COUNT(*) AS total_trips,SUM(is_diff_borough) AS diff_borough_trips,(SUM(is_diff_borough) * 100.0 / COUNT(*)) AS percent_diff_borough
FROM TripData
GROUP BY weekday;
