SELECT 
    DATE,
    -- Calculating values for precipitation over a 7-day moving window
    MIN(PRCP) OVER days_7 AS prcp_moving_min,
    MAX(PRCP) OVER days_7 AS prcp_moving_max,
    AVG(PRCP) OVER days_7 AS prcp_moving_avg,
    SUM(PRCP) OVER days_7 AS prcp_moving_sum,
    -- Calculating values for snow over a 7-day moving window
    MIN(SNOW) OVER days_7 AS snow_moving_min,
    MAX(SNOW) OVER days_7 AS snow_moving_max,
    AVG(SNOW) OVER days_7 AS snow_moving_avg,
    SUM(SNOW) OVER days_7 AS snow_moving_sum
FROM {{ ref('stg__central_park_weather') }}
WINDOW days_7 AS (ORDER BY DATE RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING);
