-- Selecting individual fare amount and calculating average fare amounts
SELECT yel_trip.fare_amount indiv_fare
,AVG(yel_trip.fare_amount) OVER (PARTITION BY loc.Borough) AS borough_avg_fare
,AVG(yel_trip.fare_amount) OVER (PARTITION BY loc.Zone) AS zone_avg_fare
,AVG(yel_trip.fare_amount) OVER () AS overall_avg_fare
FROM {{ ref('stg__yellow_tripdata') }} yel_trip
--limiting to 100 rows to be able to push to github
JOIN {{ ref('mart__dim_locations') }} loc ON yel_trip.PUlocationID = loc.LocationID LIMIT 100;