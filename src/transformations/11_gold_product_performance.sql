CREATE OR REFRESH MATERIALIZED VIEW olist_cdp.gold.product_performance
AS
WITH sales AS (
    SELECT
        product_id,

        COUNT(*) AS items_sold,

        COUNT(DISTINCT order_id) AS unique_orders,

        SUM(price) AS product_revenue,

        SUM(freight_value) AS freight_revenue

    FROM olist_cdp.silver.order_items_enriched

    GROUP BY product_id
),

reviews AS (
    SELECT
        oi.product_id,

        AVG(r.review_score) AS average_review_score,

        COUNT(r.review_id) AS review_count

    FROM olist_cdp.silver.order_items_enriched oi

    LEFT JOIN olist_cdp.silver.reviews_clean r
        ON oi.order_id = r.order_id

    GROUP BY oi.product_id
)

SELECT
    p.product_id,

    p.product_category_name,

    p.product_weight_g,
    p.product_volume_cm3,
    p.product_photos_qty,

    COALESCE(s.items_sold, 0) AS items_sold,
    COALESCE(s.unique_orders, 0) AS unique_orders,

    COALESCE(s.product_revenue, 0) AS product_revenue,
    COALESCE(s.freight_revenue, 0) AS freight_revenue,

    COALESCE(r.average_review_score, 0) AS average_review_score,
    COALESCE(r.review_count, 0) AS review_count

FROM olist_cdp.silver.products_clean p

LEFT JOIN sales s
    ON p.product_id = s.product_id

LEFT JOIN reviews r
    ON p.product_id = r.product_id;