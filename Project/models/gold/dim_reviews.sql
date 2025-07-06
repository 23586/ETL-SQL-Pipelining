{{ config(materialized='table') }}
{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT
  r.review_id,
  r.order_id,
   -- Use English category name if available
  COALESCE(t.product_category_name_english, p.product_category_name) AS product_category_name,
  r.review_score
  
 

FROM `e-commerce-etl.silver.olist_order_reviews_dataset` r
JOIN `e-commerce-etl.silver.olist_order_items_dataset` i
  ON r.order_id = i.order_id
JOIN `e-commerce-etl.silver.olist_products_dataset` p
  ON i.product_id = p.product_id
LEFT JOIN `e-commerce-etl.silver.product_category_name_translation` t
  ON p.product_category_name = t.product_category_name

WHERE r.review_id IS NOT NULL
  AND r.order_id IS NOT NULL
  AND r.review_score IS NOT NULL
