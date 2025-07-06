{{ config(materialized='table') }}
{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT
  order_id,
  customer_id,
  order_status,
  order_purchase_timestamp,
  order_purchase_time,
  order_approved_at,
  order_delivered_carrier_date,
  order_delivered_customer_date,
  order_estimated_delivery_date
FROM `e-commerce-etl.silver.olist_orders_dataset`
WHERE order_id IS NOT NULL
