CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.sellers_clean
AS
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state

FROM STREAM(olist_cdp.bronze.sellers)

WHERE seller_id IS NOT NULL;