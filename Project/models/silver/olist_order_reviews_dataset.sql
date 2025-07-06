{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  review_id,
  order_id,
  review_score,

  -- Extract date only
  CASE
    WHEN review_creation_date IS NULL THEN NULL
    ELSE DATE(TIMESTAMP(review_creation_date))
  END AS review_creation_date,

  CASE
    WHEN review_answer_timestamp IS NULL THEN NULL
    ELSE DATE(TIMESTAMP(review_answer_timestamp))
  END AS review_answer_timestamp,

  -- Extract time part separately
  CASE
    WHEN review_answer_timestamp IS NULL THEN NULL
    ELSE TIME(TIMESTAMP(review_answer_timestamp))
  END AS review_answer_time,

  -- Fill missing or empty title
  CASE
    WHEN review_comment_title IS NULL OR TRIM(review_comment_title) = '' THEN 'No title provided'
    ELSE review_comment_title
  END AS review_comment_title,

  -- Fill missing or empty comment
  CASE
    WHEN review_comment_message IS NULL OR TRIM(review_comment_message) = '' THEN 'No comment provided'
    ELSE review_comment_message
  END AS review_comment_message

FROM `e-commerce-etl.bronze.olist_order_reviews_dataset`

-- Filter for required data
WHERE review_id IS NOT NULL
  AND order_id IS NOT NULL
  AND review_score IS NOT NULL
  AND review_creation_date IS NOT NULL
  AND review_answer_timestamp IS NOT NULL
