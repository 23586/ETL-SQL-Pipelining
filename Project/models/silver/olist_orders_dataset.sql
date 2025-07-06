{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

-- models/silver/olist_orders_dataset.sql

SELECT DISTINCT
  order_id,
  customer_id,
  order_status,

  -- 1. order_purchase_timestamp ➝ date + time
  DATE(TIMESTAMP(order_purchase_timestamp)) AS order_purchase_timestamp,
  TIME(TIMESTAMP(order_purchase_timestamp)) AS order_purchase_time,

  -- 2. order_approved_at ➝ date + time
  DATE(TIMESTAMP(order_approved_at)) AS order_approved_at,
  TIME(TIMESTAMP(order_approved_at)) AS order_approved_time,

  -- 3. order_delivered_carrier_date ➝ date + time
  DATE(TIMESTAMP(order_delivered_carrier_date)) AS order_delivered_carrier_date,
  TIME(TIMESTAMP(order_delivered_carrier_date)) AS order_delivered_carrier_time,

  -- 4. order_delivered_customer_date ➝ date + time
  DATE(TIMESTAMP(order_delivered_customer_date)) AS order_delivered_customer_date,
  TIME(TIMESTAMP(order_delivered_customer_date)) AS order_delivered_customer_time,

  -- 5. order_estimated_delivery_date ➝ date + time
  DATE(TIMESTAMP(order_estimated_delivery_date)) AS order_estimated_delivery_date,
  TIME(TIMESTAMP(order_estimated_delivery_date)) AS order_estimated_delivery_time

FROM `e-commerce-etl.bronze.olist_orders_dataset`

-- Remove rows with nulls in any column
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND order_status IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_approved_at IS NOT NULL
  AND order_delivered_carrier_date IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
