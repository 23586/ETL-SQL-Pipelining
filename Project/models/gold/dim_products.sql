{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}


SELECT
  p.product_id,
  -- Safely map category name
  COALESCE(t.product_category_name_english, p.product_category_name) AS product_category_name,
  p.product_weight_g,
  p.product_length_cm,
  p.product_height_cm,
  p.product_width_cm
FROM `e-commerce-etl.silver.olist_products_dataset` p
LEFT JOIN `e-commerce-etl.silver.product_category_name_translation` t
  ON p.product_category_name = t.product_category_name
WHERE p.product_id IS NOT NULL
