{{
    config(
        materialized='view'
    )
}}

with cte_1 as
(
    select service_type,
    yr,
    mnth,
    fare_amount
    FROM {{ ref('fact_trips') }}
    WHERE fare_amount>0
    AND trip_distance>0
    AND (payment_type = 1 OR payment_type = 2)
)

SELECT * FROM cte_1