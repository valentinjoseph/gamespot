I wanted to try the GCP tool as I was curious on how they work. Being interested in the video gaming industry, I took datasets from that field as example.
Here is the overall architecture of the datapipeline
![image](https://github.com/valentinjoseph/gamespot/assets/96952537/55a29ddb-fd06-4e78-b625-63b5643c79e7)

Here is the process:
1. csv files are loaded into a Google Cloud Storage Bucket
2. a Google Cloud Function is triggered once a file is loaded into the GCS and loads the data from the CSV to a database in BigQuery
3. BigQuery is used to create views based on SQL queries
4. PowerBI is connected to the BigQuery Database and fetch the results from the queries in order to generate reports and dashboards
   (please note that the viz could be done in Looker Studio as it's a Google tool, just as easily, but I wanted to work with PowerBI)

Improvements:
1. create a web portal to load the CSV files directly to the GCS
2. work with APIs to get data to the GCS
