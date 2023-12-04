SELECT taxi_trips.*
FROM {{ ref('mart__fact_all_taxi_trips')}} taxi_trips
LEFT JOIN 'mart__dim_locations' loc ON taxi_trips.PUlocationID = loc.LocationID
--limiting to 100 rows to be able to push to github
WHERE loc.LocationID IS NULL LIMIT 100; -- Filtering rows where there is no match in the locations dimension table