{{ config(materialized='table') }}
{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT
  geolocation_zip_code_prefix,
  ANY_VALUE(geolocation_city) AS geolocation_city,
  ANY_VALUE(geolocation_state) AS geolocation_state,
  ROUND(AVG(geolocation_lat), 6) AS avg_latitude,
  ROUND(AVG(geolocation_lng), 6) AS avg_longitude
FROM `e-commerce-etl.silver.olist_geolocation_dataset`
WHERE geolocation_zip_code_prefix IS NOT NULL
  AND geolocation_city IS NOT NULL
  AND geolocation_state IS NOT NULL
  AND geolocation_lat IS NOT NULL
  AND geolocation_lng IS NOT NULL
GROUP BY geolocation_zip_code_prefix
