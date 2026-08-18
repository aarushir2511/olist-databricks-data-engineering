CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.silver.sellers_clean
AS
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state

FROM STREAM(olist_cdp_dev.bronze.sellers)

WHERE seller_id IS NOT NULL;