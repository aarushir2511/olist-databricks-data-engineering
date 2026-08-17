CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.products_clean
AS
SELECT
    product_id,

    product_category_name,

    product_name_lenght AS product_name_length,
    product_description_lenght AS product_description_length,

    product_photos_qty,

    CAST(product_weight_g AS DOUBLE) AS product_weight_g,
    CAST(product_length_cm AS DOUBLE) AS product_length_cm,
    CAST(product_height_cm AS DOUBLE) AS product_height_cm,
    CAST(product_width_cm AS DOUBLE) AS product_width_cm,

    (
        CAST(product_length_cm AS DOUBLE)
        * CAST(product_height_cm AS DOUBLE)
        * CAST(product_width_cm AS DOUBLE)
    ) AS product_volume_cm3

FROM STREAM(olist_cdp.bronze.products)

WHERE product_id IS NOT NULL;