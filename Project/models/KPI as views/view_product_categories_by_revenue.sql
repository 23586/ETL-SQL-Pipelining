{{ config(materialized='view', schema='view') }}
{{ log("📊 Creating KPI: Top 10 Product Categories by Revenue", info=True) }}

SELECT 
  product_category_name,
  ROUND(SUM(price + freight_value), 2) AS revenue
FROM `e-commerce-etl.gold.fact_orders`
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 10
