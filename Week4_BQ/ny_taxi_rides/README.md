## Module 4 Homework Solutions

**Question 1**: Understanding dbt model resolution

**Answer** - select * from myproject.my_nyc_tripdata.ext_green_taxi


**Question 2**: dbt Variables & Dynamic Models

**Answer** - Update the WHERE clause to pickup_datetime >= CURRENT_DATE - INTERVAL '{{ env_var("DAYS_BACK", var("days_back", "30")) }}' DAY

**Question 3**: dbt Data Lineage and Execution

**Answer** - dbt run --select models/staging/+

**Question 4**: dbt Macros and Jinja

**Answer** - 
    Setting a value for DBT_BIGQUERY_TARGET_DATASET env var is mandatory, or it'll fail to compile
    When using core, it materializes in the dataset defined in DBT_BIGQUERY_TARGET_DATASET
    When using stg, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET
    When using staging, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET

**Question 5**: Taxi Quarterly Revenue Growth

**Answer** 
green: {best: 2020/Q2, worst: 2020/Q1}, yellow: {best: 2020/Q2, worst: 2020/Q1}

**Code** 

```sql
with cte_base AS
(
  SELECT *
    , lag(qtr_revenue,4) OVER(partition by service_type order by yr,qtr) prev
  FROM `stellar-code-448120-s7.dbt_jacksonpaulp.fct_taxi_trips_quarterly_revenue` 
  WHERE yr IN (2019,2020)
)
SELECT service_type
    , yr_qtr
    , (prev-qtr_revenue)/qtr_revenue growth
    , rank() OVER(partition by service_type order by (prev-qtr_revenue)/qtr_revenue desc)
  FROM cte_base
  WHERE yr=2020
```

**Question 6** : P97/P95/P90 Taxi Monthly Fare

**Answer** - green: {p97: 55.0, p95: 45.0, p90: 26.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}

**Code**

```sql
with cte_1 AS (
  SELECT 
    service_type,
    PERCENTILE_CONT(fare_amount, 0.97) OVER(partition by service_type, yr, mnth) AS p97,
    PERCENTILE_CONT(fare_amount, 0.95) OVER(partition by service_type, yr, mnth) AS p95,
    PERCENTILE_CONT(fare_amount, 0.9) OVER(partition by service_type, yr, mnth) AS p90,
  FROM stellar-code-448120-s7.dbt_jacksonpaulp.fct_taxi_trips_monthly_fare_p95
  WHERE mnth=4 
    AND yr=2020
  )
SELECT service_type
,MIN(p97)
,MIN(p95)
,MIN(p90)
FROM cte_1
GROUP BY 1
```
**Question 7**: Top #Nth longest P90 travel time Location for FHV

**Answer** - LaGuardia Airport, Chinatown, Garment District

**Code**

```sql

with cte_1 AS 
( 
  SELECT *,
    PERCENTILE_CONT(trip_duration, 0.90) OVER(partition by yr, mnth, PUlocationID, DOlocationID) AS p90
  FROM stellar-code-448120-s7.dbt_jacksonpaulp.dim_fhv_trips 
  WHERE mnth=11 AND yr=2019 
 ), cte_2 AS
 ( 
  SELECT pickup_zone, 
   dropoff_zone, 
   min(p90) p90
  FROM cte_1 
  where pickup_zone IN ('Newark Airport', 'SoHo', 'Yorkville East')
  GROUP BY 1,2
 ), cte_3 AS
 (
  SELECT *, 
    rank() OVER(partition by pickup_zone order by p90 desc) rank_duration
  FROM cte_2
 )
 SELECT * 
 FROM cte_3 
 where rank_duration = 2
```