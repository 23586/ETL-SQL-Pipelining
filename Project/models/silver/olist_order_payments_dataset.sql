{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  order_id,
  payment_sequential,
  payment_type,

  -- Replace nulls with column average
  CASE
    WHEN payment_value IS NULL THEN (
      SELECT AVG(payment_value)
      FROM `e-commerce-etl.bronze.olist_order_payments_dataset`
      WHERE payment_value IS NOT NULL
    )
    ELSE payment_value
  END AS payment_value,

  payment_installments

FROM `e-commerce-etl.bronze.olist_order_payments_dataset`

-- Remove rows with nulls (except payment_value)
WHERE order_id IS NOT NULL
  AND payment_sequential IS NOT NULL
  AND payment_type IS NOT NULL
  AND payment_installments IS NOT NULL
