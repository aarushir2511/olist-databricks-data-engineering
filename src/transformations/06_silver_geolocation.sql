CREATE OR REFRESH STREAMING TABLE silver.geolocation_clean
AS
SELECT
    geolocation_zip_code_prefix,

    ROUND(AVG(geolocation_lat), 6) AS latitude,
    ROUND(AVG(geolocation_lng), 6) AS longitude,


    MAX(geolocation_city) AS city,
    MAX(geolocation_state) AS state

FROM STREAM(bronze.geolocation)

GROUP BY geolocation_zip_code_prefix;