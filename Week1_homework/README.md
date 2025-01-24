## Module 1 Homework Solutions

Q1. What's the version of pip in the image?

Answer - 24.3.1
Command
    docker run -it python:3.12.8 bash
    pip --version


Q2 Given the following docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?

Answer - postgres:5432

Q3 Trip Segmentation Count

Answer - 104,802; 198,924; 109,603; 27,678; 35,189

Code - 

SELECT COUNT(*) 
FROM green_taxi_trips 
WHERE lpep_pickup_datetime >= DATE'2019-10-01' 
AND lpep_dropoff_datetime< DATE'2019-11-01'
AND trip_distance < 1

SELECT COUNT(*) 
FROM green_taxi_trips 
WHERE lpep_pickup_datetime >= DATE'2019-10-01' 
AND lpep_dropoff_datetime< DATE'2019-11-01'
AND trip_distance > 10


Q4 Longest trip for each day
Answer- 2019-10-31

Code-

SELECT DATE(lpep_pickup_datetime) 
FROM green_taxi_trips 
WHERE trip_distance = 
(SELECT MAX(trip_distance) FROM green_taxi_trips)


Q5. Three biggest pickup zones

Answer- East Harlem North, East Harlem South, Morningside Heights

Code -

SELECT taz."Zone", SUM(total_amount)
FROM green_taxi_trips gtt
JOIN taxi_zones taz ON gtt."PULocationID" = taz."LocationID"
WHERE lpep_pickup_datetime >= DATE'2019-10-18' AND lpep_pickup_datetime < DATE'2019-10-19'
GROUP BY taz."Zone"
HAVING SUM(total_amount) > 13000

Q6: Largest tip

Answer JFK Airport

Code -

SELECT tazd."Zone" drop_location, tip_amount
FROM green_taxi_trips gtt
JOIN taxi_zones tazp ON gtt."PULocationID" = tazp."LocationID"
JOIN taxi_zones tazd ON gtt."DOLocationID" = tazd."LocationID"
WHERE lpep_pickup_datetime >= DATE'2019-10-01' 
AND lpep_pickup_datetime < DATE'2019-11-01'
AND tazp."Zone" = 'East Harlem North'
ORDER BY tip_amount DESC 
LIMIT 1

Q7  Terraform Workflow
terraform init, terraform apply -auto-approve, terraform destroy