CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.silver.order_items_enriched
AS
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,

    CAST(oi.shipping_limit_date AS TIMESTAMP) AS shipping_limit_timestamp,

    oi.price,
    oi.freight_value,

    p.product_category_name,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    ct.product_category_name_english

FROM STREAM(olist_cdp_dev.bronze.order_items) oi

LEFT JOIN olist_cdp_dev.bronze.products p
    ON oi.product_id = p.product_id

LEFT JOIN olist_cdp_dev.bronze.category_translation ct
    ON p.product_category_name = ct.product_category_name;