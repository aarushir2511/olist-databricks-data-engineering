CREATE OR REFRESH MATERIALIZED VIEW gold.seller_performance
AS
WITH sales AS (
    SELECT
        seller_id,

        COUNT(*) AS items_sold,

        COUNT(DISTINCT order_id) AS unique_orders,

        SUM(price) AS total_sales,

        SUM(freight_value) AS total_freight

    FROM silver.order_items_enriched

    GROUP BY seller_id
),

reviews AS (
    SELECT
        oi.seller_id,

        AVG(r.review_score) AS average_review_score,

        COUNT(r.review_id) AS review_count

    FROM silver.order_items_enriched oi

    LEFT JOIN silver.reviews_clean r
        ON oi.order_id = r.order_id

    GROUP BY oi.seller_id
)

SELECT
    s.seller_id,

    s.seller_city,
    s.seller_state,

    COALESCE(sa.items_sold, 0) AS items_sold,
    COALESCE(sa.unique_orders, 0) AS unique_orders,

    COALESCE(sa.total_sales, 0) AS total_sales,
    COALESCE(sa.total_freight, 0) AS total_freight,

    COALESCE(r.average_review_score, 0) AS average_review_score,
    COALESCE(r.review_count, 0) AS review_count

FROM silver.sellers_clean s

LEFT JOIN sales sa
    ON s.seller_id = sa.seller_id

LEFT JOIN reviews r
    ON s.seller_id = r.seller_id;