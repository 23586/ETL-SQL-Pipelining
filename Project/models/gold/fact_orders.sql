{{ config(materialized='table') }}
{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT
  -- Foreign Keys
  o.order_id,
  o.customer_id,
  c.customer_unique_id,
  c.customer_zip_code_prefix AS geolocation_zip_code_prefix,
  r.review_id,
  i.product_id,

  -- Product category in English
  COALESCE(t.product_category_name_english, p.product_category_name) AS product_category_name,

  -- Review score
  r.review_score,

  -- Facts / Metrics
  i.price,
  i.freight_value,
  pmt.total_payment_value

  

FROM `e-commerce-etl.silver.olist_orders_dataset` o

-- Join customers to get ZIP and customer unique ID
JOIN `e-commerce-etl.silver.olist_customers_dataset` c
  ON o.customer_id = c.customer_id

-- Join order items to get product_id, price, freight
JOIN `e-commerce-etl.silver.olist_order_items_dataset` i
  ON o.order_id = i.order_id

-- Join products to get category
JOIN `e-commerce-etl.silver.olist_products_dataset` p
  ON i.product_id = p.product_id

-- Join translation table to get English category name
LEFT JOIN `e-commerce-etl.silver.product_category_name_translation` t
  ON p.product_category_name = t.product_category_name

-- Join payments (aggregated total per order)
LEFT JOIN (
  SELECT
    order_id,
    SUM(payment_value) AS total_payment_value
  FROM `e-commerce-etl.silver.olist_order_payments_dataset`
  GROUP BY order_id
) pmt ON o.order_id = pmt.order_id

-- Join reviews
LEFT JOIN `e-commerce-etl.silver.olist_order_reviews_dataset` r
  ON o.order_id = r.order_id

WHERE 
  o.order_id IS NOT NULL
  AND o.customer_id IS NOT NULL
  AND i.product_id IS NOT NULL
