-- 1. ORDERS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.orders
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_orders_dataset.csv'
);


-- 2. CUSTOMERS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.customers
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_customers_dataset.csv'
);


-- 3. ORDER ITEMS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.order_items
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_order_items_dataset.csv'
);


-- 4. ORDER PAYMENTS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.order_payments
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_order_payments_dataset.csv'
);


-- 5. ORDER REVIEWS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.order_reviews

AS

SELECT *

FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    multiLine => true,
    quote => '"',
    escape => '"',
    pathGlobFilter => 'olist_order_reviews_dataset.csv'
);


-- 6. PRODUCTS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.products
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_products_dataset.csv'
);


-- 7. SELLERS
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.sellers
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_sellers_dataset.csv'
);


-- 8. GEOLOCATION
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.geolocation
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'olist_geolocation_dataset.csv'
);


-- 9. CATEGORY TRANSLATION
CREATE OR REFRESH STREAMING TABLE olist_cdp_dev.bronze.category_translation
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/olist_cdp_dev/bronze/landing',
    format => 'csv',
    header => true,
    pathGlobFilter => 'product_category_name_translation.csv'
);