CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.geolocation_clean
AS
SELECT
    geolocation_zip_code_prefix,

    AVG(geolocation_lat) AS latitude,
    AVG(geolocation_lng) AS longitude,

    MAX(geolocation_city) AS city,
    MAX(geolocation_state) AS state

FROM STREAM(olist_cdp.bronze.geolocation)

GROUP BY geolocation_zip_code_prefix;