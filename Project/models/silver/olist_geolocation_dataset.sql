{{ config(materialized='table') }}

{{ log("⚠️ Using schema: " ~ target.schema, info=True) }}

SELECT DISTINCT
  geolocation_zip_code_prefix,
  geolocation_lat,
  geolocation_lng,

  CASE
    WHEN LOWER(geolocation_city) IN ('4 centario', '4centenario', 'quatro centenario') THEN 'Quadra Centenário'
    WHEN LOWER(geolocation_city) IN ('sao paulo', 'são paulo', 'sao  paulo') THEN 'São Paulo'
    WHEN LOWER(geolocation_city) IN ('rj de janeiro') THEN 'Rio de Janeiro'
    WHEN LOWER(geolocation_city) IN ('bh') THEN 'Belo Horizonte'
    WHEN LOWER(geolocation_city) IN ('floripa') THEN 'Florianópolis'
    ELSE INITCAP(geolocation_city)
  END AS geolocation_city,

  CASE
    WHEN geolocation_state = 'AC' THEN 'Acre'
    WHEN geolocation_state = 'AL' THEN 'Alagoas'
    WHEN geolocation_state = 'AP' THEN 'Amapá'
    WHEN geolocation_state = 'AM' THEN 'Amazonas'
    WHEN geolocation_state = 'BA' THEN 'Bahia'
    WHEN geolocation_state = 'CE' THEN 'Ceará'
    WHEN geolocation_state = 'DF' THEN 'Distrito Federal'
    WHEN geolocation_state = 'ES' THEN 'Espírito Santo'
    WHEN geolocation_state = 'GO' THEN 'Goiás'
    WHEN geolocation_state = 'MA' THEN 'Maranhão'
    WHEN geolocation_state = 'MT' THEN 'Mato Grosso'
    WHEN geolocation_state = 'MS' THEN 'Mato Grosso do Sul'
    WHEN geolocation_state = 'MG' THEN 'Minas Gerais'
    WHEN geolocation_state = 'PA' THEN 'Pará'
    WHEN geolocation_state = 'PB' THEN 'Paraíba'
    WHEN geolocation_state = 'PR' THEN 'Paraná'
    WHEN geolocation_state = 'PE' THEN 'Pernambuco'
    WHEN geolocation_state = 'PI' THEN 'Piauí'
    WHEN geolocation_state = 'RJ' THEN 'Rio de Janeiro'
    WHEN geolocation_state = 'RN' THEN 'Rio Grande do Norte'
    WHEN geolocation_state = 'RS' THEN 'Rio Grande do Sul'
    WHEN geolocation_state = 'RO' THEN 'Rondônia'
    WHEN geolocation_state = 'RR' THEN 'Roraima'
    WHEN geolocation_state = 'SC' THEN 'Santa Catarina'
    WHEN geolocation_state = 'SP' THEN 'São Paulo'
    WHEN geolocation_state = 'SE' THEN 'Sergipe'
    WHEN geolocation_state = 'TO' THEN 'Tocantins'
    ELSE geolocation_state
  END AS geolocation_state

FROM `e-commerce-etl.bronze.olist_geolocation_dataset`

WHERE geolocation_zip_code_prefix IS NOT NULL
  AND geolocation_lat IS NOT NULL
  AND geolocation_lng IS NOT NULL
  AND geolocation_city IS NOT NULL
  AND geolocation_state IS NOT NULL
