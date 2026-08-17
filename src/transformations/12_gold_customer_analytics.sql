CREATE OR REFRESH MATERIALIZED VIEW olist_cdp.gold.customer_analytics
AS
WITH order_metrics AS (
    SELECT
        customer_id,

        COUNT(*) AS total_orders,

        SUM(COALESCE(total_payment_value, 0))
            AS total_spent,

        AVG(COALESCE(total_payment_value, 0))
            AS average_order_value,

        AVG(delivery_days)
            AS average_delivery_days,

        MAX(purchase_timestamp)
            AS last_purchase_timestamp

    FROM olist_cdp.gold.order_analytics

    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.customer_unique_id,

    c.customer_city,
    c.customer_state,

    c.latitude,
    c.longitude,

    COALESCE(o.total_orders, 0) AS total_orders,
    COALESCE(o.total_spent, 0) AS total_spent,
    COALESCE(o.average_order_value, 0) AS average_order_value,

    o.average_delivery_days,
    o.last_purchase_timestamp

FROM olist_cdp.silver.customers_enriched c

LEFT JOIN order_metrics o
    ON c.customer_id = o.customer_id;