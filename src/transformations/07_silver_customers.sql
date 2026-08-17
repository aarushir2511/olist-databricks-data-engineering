CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.customers_enriched
AS
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,

    g.latitude,
    g.longitude

FROM STREAM(olist_cdp.bronze.customers) c

LEFT JOIN olist_cdp.silver.geolocation_clean g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix;