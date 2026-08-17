CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.orders_clean
AS
SELECT
    order_id,
    customer_id,
    order_status,

    CAST(order_purchase_timestamp AS TIMESTAMP) AS purchase_timestamp,
    CAST(order_approved_at AS TIMESTAMP) AS approved_timestamp,
    CAST(order_delivered_carrier_date AS TIMESTAMP) AS delivered_carrier_timestamp,
    CAST(order_delivered_customer_date AS TIMESTAMP) AS delivered_customer_timestamp,
    CAST(order_estimated_delivery_date AS TIMESTAMP) AS estimated_delivery_timestamp,

    YEAR(CAST(order_purchase_timestamp AS TIMESTAMP)) AS purchase_year,
    MONTH(CAST(order_purchase_timestamp AS TIMESTAMP)) AS purchase_month,

    DATEDIFF(
        CAST(order_delivered_customer_date AS DATE),
        CAST(order_purchase_timestamp AS DATE)
    ) AS delivery_days,

    DATEDIFF(
        CAST(order_delivered_customer_date AS DATE),
        CAST(order_estimated_delivery_date AS DATE)
    ) AS delivery_delay_days

FROM STREAM(olist_cdp.bronze.orders)
WHERE order_id IS NOT NULL;