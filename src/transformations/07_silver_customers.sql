CREATE OR REFRESH STREAMING TABLE silver.customers_enriched
AS
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,

    g.latitude,
    g.longitude

FROM STREAM(bronze.customers) c

LEFT JOIN silver.geolocation_clean g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix;