{{ config(materialized='view', schema='view') }}
{{ log("📊 Creating KPI: Average Total Payment Value", info=True) }}

SELECT 
  ROUND(AVG(total_payment_value), 2) AS avg_payment_value
FROM `e-commerce-etl.gold.fact_orders`
