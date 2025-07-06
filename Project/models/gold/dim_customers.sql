{{ config(materialized='table') }}
{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT
  customer_id,
  customer_unique_id,
  customer_zip_code_prefix,
  customer_city,
  customer_state
FROM `e-commerce-etl.silver.olist_customers_dataset`
WHERE customer_id IS NOT NULL
  AND customer_unique_id IS NOT NULL
  AND customer_zip_code_prefix IS NOT NULL
  AND customer_city IS NOT NULL
  AND customer_state IS NOT NULL
