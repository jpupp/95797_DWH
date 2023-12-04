WITH nxtttrip AS (
    SELECT PUlocationID,pickup_datetime,LAG(pickup_datetime, 1) OVER (PARTITION BY PUlocationID ORDER BY pickup_datetime) AS prev_pickup
    FROM {{ ref('mart__fact_all_taxi_trips' ) }}
)

,diff AS (
    SELECT PUlocationID, datediff('second', prev_pickup, pickup_datetime) AS dtdiff,
    FROM nxtttrip
    WHERE prev_pickup IS NOT NULL
)

SELECT loc.Zone,AVG(dtdiff) AS avg_btn_pickups
FROM diff td
JOIN {{ ref('mart__dim_locations') }} loc ON td.PUlocationID = loc.LocationID
GROUP BY loc.Zone
ORDER BY avg_btn_pickups;
