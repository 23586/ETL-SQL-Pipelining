{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  order_id,
  order_item_id,
  product_id,
  seller_id,

  -- Extract date from timestamp
  CASE
    WHEN shipping_limit_date IS NULL THEN NULL
    ELSE DATE(TIMESTAMP(shipping_limit_date))
  END AS shipping_limit_date,

  -- Extract time from timestamp
  CASE
    WHEN shipping_limit_date IS NULL THEN NULL
    ELSE TIME(TIMESTAMP(shipping_limit_date))
  END AS shipping_limit_time,

  -- Replace null price with average
  CASE
    WHEN price IS NULL THEN (
      SELECT AVG(price)
      FROM `e-commerce-etl.bronze.olist_order_items_dataset`
      WHERE price IS NOT NULL
    )
    ELSE price
  END AS price,

  -- Replace null freight_value with average
  CASE
    WHEN freight_value IS NULL THEN (
      SELECT AVG(freight_value)
      FROM `e-commerce-etl.bronze.olist_order_items_dataset`
      WHERE freight_value IS NOT NULL
    )
    ELSE freight_value
  END AS freight_value

FROM `e-commerce-etl.bronze.olist_order_items_dataset`
WHERE order_id IS NOT NULL
  AND order_item_id IS NOT NULL
  AND product_id IS NOT NULL
  AND seller_id IS NOT NULL
