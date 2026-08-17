CREATE OR REFRESH STREAMING TABLE olist_cdp.silver.reviews_clean
AS
SELECT
    review_id,
    order_id,

    CAST(review_score AS INT) AS review_score,

    review_comment_title AS comment_title,
    review_comment_message AS comment_message,

    CAST(review_creation_date AS TIMESTAMP) AS review_created_at,
    CAST(review_answer_timestamp AS TIMESTAMP) AS review_answered_at,

    CASE
        WHEN review_score >= 4 THEN 'positive'
        WHEN review_score = 3 THEN 'neutral'
        WHEN review_score <= 2 THEN 'negative'
        ELSE 'unknown'
    END AS sentiment_category,

    DATEDIFF(
        CAST(review_answer_timestamp AS DATE),
        CAST(review_creation_date AS DATE)
    ) AS response_days

FROM STREAM(olist_cdp.bronze.order_reviews)

WHERE review_id IS NOT NULL
  AND order_id IS NOT NULL
  AND review_score BETWEEN 1 AND 5;