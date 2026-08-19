CREATE OR REFRESH STREAMING TABLE silver.payments_clean
AS
SELECT
    order_id,

    SUM(payment_value) AS total_payment_value,
    COUNT(*) AS payment_count,

    MAX(payment_installments) AS max_installments,

    COLLECT_SET(payment_type) AS payment_types

FROM STREAM(bronze.order_payments)

GROUP BY order_id;