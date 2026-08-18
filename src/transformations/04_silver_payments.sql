CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.silver.payments_clean
AS
SELECT
    order_id,

    SUM(payment_value) AS total_payment_value,
    COUNT(*) AS payment_count,

    MAX(payment_installments) AS max_installments,

    COLLECT_SET(payment_type) AS payment_types

FROM STREAM(olist_cdp_dev.bronze.order_payments)

GROUP BY order_id;