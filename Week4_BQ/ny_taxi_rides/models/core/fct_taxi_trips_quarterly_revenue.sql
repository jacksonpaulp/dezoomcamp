{{
    config(
        materialized='view'
    )
}}

with qtr_revenue as
(
    select yr,
    qtr,
    yr_qtr,
    service_type,
    SUM(total_amount) qtr_revenue
    FROM {{ref('fact_trips')}}
    GROUP BY 1,2,3,4
)

SELECT * FROM qtr_revenue