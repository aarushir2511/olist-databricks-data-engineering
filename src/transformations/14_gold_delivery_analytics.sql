CREATE OR REFRESH MATERIALIZED VIEW olist_cdp.gold.delivery_analytics
AS
SELECT
    c.customer_state,

    COUNT(o.order_id) AS total_orders,

    AVG(o.delivery_days) AS average_delivery_days,

    AVG(o.delivery_delay_days) AS average_delivery_delay_days,

    SUM(
        CASE
            WHEN o.delivery_delay_days > 0 THEN 1
            ELSE 0
        END
    ) AS delayed_orders,

    SUM(
        CASE
            WHEN o.delivery_delay_days <= 0 THEN 1
            ELSE 0
        END
    ) AS on_time_orders

FROM olist_cdp.silver.orders_clean o

LEFT JOIN olist_cdp.silver.customers_enriched c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_state;