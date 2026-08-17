CREATE OR REFRESH MATERIALIZED VIEW olist_cdp.gold.order_analytics
AS
WITH item_summary AS (
    SELECT
        order_id,
        COUNT(*) AS total_items,
        SUM(price) AS total_product_value,
        SUM(freight_value) AS total_freight_value
    FROM olist_cdp.silver.order_items_enriched
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,

    o.order_status,

    o.purchase_timestamp,
    o.approved_timestamp,
    o.delivered_carrier_timestamp,
    o.delivered_customer_timestamp,
    o.estimated_delivery_timestamp,

    o.purchase_year,
    o.purchase_month,

    o.delivery_days,
    o.delivery_delay_days,

    i.total_items,
    i.total_product_value,
    i.total_freight_value,

    p.total_payment_value,
    p.payment_count,
    p.max_installments,
    p.payment_types,

    c.customer_city,
    c.customer_state,
    c.latitude,
    c.longitude

FROM olist_cdp.silver.orders_clean o

LEFT JOIN item_summary i
    ON o.order_id = i.order_id

LEFT JOIN olist_cdp.silver.payments_clean p
    ON o.order_id = p.order_id

LEFT JOIN olist_cdp.silver.customers_enriched c
    ON o.customer_id = c.customer_id;