{{ 
  config(
    materialized = 'incremental',
    unique_key   = 'date',
    partition_by = {'field':'date','data_type':'date'}
  ) 
}}

SELECT
  date,

  MAX(IF(series_code='IT.NET.USER.ZS', value, NULL))    AS internet_users_perc,
  MAX(IF(series_code='IT.CEL.SETS.P2', value, NULL))    AS mobile_subs_perc,
  MAX(IF(series_code='IT.NET.BBND',    value, NULL))    AS broadband_subs,
  MAX(IF(series_code='NY.GDP.PCAP.CD', value, NULL))    AS gdp_per_capita,
  MAX(IF(series_code='SP.URB.TOTL.IN.ZS', value, NULL)) AS urban_pop_perc

FROM `{{ var('project_id') }}.{{ var('prefix') }}_bronze.{{ var('prefix') }}_raw`

{% if is_incremental() %}
  WHERE date > (SELECT MAX(date) FROM {{ this }})
{% endif %}

GROUP BY date
