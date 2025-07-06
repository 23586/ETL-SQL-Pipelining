{{ config(materialized='view', schema='view') }}
{{ log("📊 Creating KPI: Average Review Score by Product Category", info=True) }}

SELECT 
  product_category_name,
  ROUND(AVG(review_score), 2) AS avg_rating
FROM `e-commerce-etl.gold.fact_orders`
WHERE review_score IS NOT NULL
GROUP BY product_category_name
ORDER BY avg_rating DESC
