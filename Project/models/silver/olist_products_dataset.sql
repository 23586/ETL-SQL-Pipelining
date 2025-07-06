{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  product_id,
  product_category_name,

  -- Replace 0 weight with average weight (excluding zero)
  CASE
    WHEN product_weight_g = 0 THEN (
      SELECT AVG(product_weight_g)
      FROM `e-commerce-etl.bronze.olist_products_dataset`
      WHERE product_weight_g IS NOT NULL AND product_weight_g > 0
    )
    ELSE product_weight_g
  END AS product_weight_g,

  product_length_cm,
  product_height_cm,
  product_width_cm

FROM `e-commerce-etl.bronze.olist_products_dataset`

-- Remove rows with any nulls
WHERE product_id IS NOT NULL
  AND product_category_name IS NOT NULL
  AND product_weight_g IS NOT NULL
  AND product_length_cm IS NOT NULL
  AND product_height_cm IS NOT NULL
  AND product_width_cm IS NOT NULL
