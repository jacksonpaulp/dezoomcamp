## Module 1 Homework Solutions

Q1. Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file yellow_tripdata_2020-12.csv of the extract task)?

Answer - 128.3 MB


Q2 What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?

Answer - green_tripdata_2020-04.csv

Q3 How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?

Answer - 24,648,499

Code - 

SELECT COUNT(*) FROM public.yellow_tripdata WHERE SUBSTRING(filename,17,4)='2020'

Q4 How many rows are there for the Green Taxi data for all CSV files in the year 2020?

Answer- 1,734,051

Code-

SELECT COUNT(*) FROM public.green_tripdata WHERE SUBSTRING(filename,16,4)='2020'


Q5. How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

Answer- 1,925,152
Code -

SELECT COUNT(*) FROM public.yellow_tripdata WHERE filename = 'yellow_tripdata_2021-03.csv'


Q6. How would you configure the timezone to New York in a Schedule trigger?

Answer- Add a timezone property set to America/New_York in the Schedule trigger configuration