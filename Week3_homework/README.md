## Module 3 Homework Solutions

Q1. What is count of records for the 2024 Yellow Taxi Data?

Answer - 20,332,093


Q2 Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

Answer - 0 MB for the External Table and 155.12 MB for the Materialized Table

Q3 Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?

Answer - BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.

Q4 How many records have a fare_amount of 0?

Answer - 8,333

Code - SELECT COUNT(*) FROM stellar-code-448120-s7.ny_taxi.yellow_trip_data WHERE fare_amount = 0

Q5 What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)

Answer Partition by tpep_dropoff_datetime and Cluster on VendorID

Code 

CREATE OR REPLACE TABLE stellar-code-448120-s7.ny_taxi.yellow_trip_data_partitioned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY vendorid AS
SELECT * FROM stellar-code-448120-s7.ny_taxi.external_yellow_trip_data


Q6 Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)

Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?

Choose the answer which most closely matches.

Answer - 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table


Q7 Where is the data stored in the External Table you created?

Answer - GCP Bucket

Q8 It is best practice in Big Query to always cluster your data:

Answer - False