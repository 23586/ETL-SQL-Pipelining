{{ config(materialized='view', schema='view') }}
{{ log("📊 Creating KPI: total_revenue", info=True) }}

SELECT 
  ROUND(SUM(price + freight_value), 2) AS total_revenue
FROM `e-commerce-etl.gold.fact_orders`
