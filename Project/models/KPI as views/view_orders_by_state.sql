{{ config(materialized='view', schema='view') }}
{{ log("📊 Creating KPI: Total Orders by Customer State", info=True) }}

SELECT 
  c.customer_state,
  COUNT(DISTINCT f.order_id) AS total_orders
FROM `e-commerce-etl.gold.fact_orders` f
JOIN `e-commerce-etl.gold.dim_customers` c 
  ON f.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
