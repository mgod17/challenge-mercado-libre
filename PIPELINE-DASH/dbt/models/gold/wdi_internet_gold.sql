{{ 
  config(
    materialized = 'view',

  )
}}

select
  date,
  internet_users_perc,
  mobile_subs_perc,
  broadband_subs,
  gdp_per_capita,
  safe_divide(mobile_subs_perc, broadband_subs) as mobile_to_broadband_ratio,

from `{{ var('project_id') }}.{{ var('prefix') }}_silver.{{ var('prefix') }}_silver`