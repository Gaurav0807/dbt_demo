-- models/my_incremental_model.sql
{{ 
  config(
    materialized='incremental',
    unique_key='order_id'
  ) 
}}

with source_data as (
    select *
    from {{ ref('orders') }}
    where last_updated > (select coalesce(max(last_updated), '1900-01-01') from {{ this }})
)

select * from source_data
