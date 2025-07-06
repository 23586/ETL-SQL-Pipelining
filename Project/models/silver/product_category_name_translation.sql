{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  product_category_name,
  product_category_name_english
FROM `e-commerce-etl.bronze.product_category_name_translation`
WHERE product_category_name IS NOT NULL
  AND product_category_name_english IS NOT NULL
