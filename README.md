I wanted to try the GCP tool as I was curious on how they work. Being interested in the video gaming industry, I took datasets from that field as example.

**Architecture:**
![image](https://github.com/valentinjoseph/gamespot/assets/96952537/5d37f354-211b-414c-9b92-37045eeb77aa)


**Process:**
1. csv files are loaded into a Google Cloud Storage Bucket
2. a Google Cloud Function is triggered once a file is loaded into the GCS and loads the data from the CSV to a database in BigQuery
3. BigQuery is used to create views based on SQL queries
4. PowerBI is connected to the BigQuery Database and fetch the results from the queries in order to generate reports and dashboards
   (please note that the viz could be done in Looker Studio as it's a Google tool, just as easily, but I wanted to work with PowerBI)

**Improvements:**
1. create a web portal to load the CSV files directly to the GCS
2. work with APIs to get data to the GCS

----------------------------------------------------------------------------------------------------------------

**<p align="center">DEVELOPMENT PROCESS</p>**

----------------------------------------------------------------------------------------------------------------

I first loaded the CSV file in a Google Cloud Storage bucket as STG_GAMESPOT

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/8d31c3c5-f93a-4320-8e6e-21bc478eeab3)

----------------------------------------------------------------------------------------------------------------

Then, I needed to create a Google Cloud Function to trigger the pipeline whenever a file is loaded in the bucket STG_GAMESPOT
=> see 'functions.py' for details

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/0202f5bb-1ff9-4f7c-ba5a-79b3d2f17c13)

----------------------------------------------------------------------------------------------------------------

I also needed to make sure that the requirements were as shown in:
=> see 'requirements.py' for details

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/84e3f553-fbb6-4616-b7ca-f1caf7944e17)

----------------------------------------------------------------------------------------------------------------

Of course, before executing this, I had to create the GAMESPOT dataset in Bigquery

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/24cbf9b9-058e-451b-917f-689aa7810601)

----------------------------------------------------------------------------------------------------------------

And sure enough, when I loaded the GAMES.CSV file, it appeared in the logs 

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/47c00d15-0f0d-44fe-8692-7ee556b775ad)

----------------------------------------------------------------------------------------------------------------

And the GCF also created the GAMES table in the GAMESPOT dataset, using the header as columns

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/e95fba6e-b8cb-465f-b318-da01966112e6)


The original table is presented as such

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/08f8583e-df37-41de-adbe-559d3894033e)

----------------------------------------------------------------------------------------------------------------

CONSOLE (there can be many), the game name, the review and the score.
I am not a big fan of having multiples values in one column so for better visibility, I normalized this in a new view

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/2346e67b-577c-4ebc-85dd-7e24761a5f87)

----------------------------------------------------------------------------------------------------------------

I then created separate views for PC, PS4, XBOX ONE games. Because there were some data quality issues like2 exact titles, one having GOOD review and the other GREAT review (as an example) because they came from 2 rows, I used a RANK() function to get the best results out of both

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/3900ee08-697c-41e1-adc9-f97885177a9f)

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/d8115d20-18a4-49bd-966f-04a79849aca3)

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/22999c32-3097-4eac-a3f3-bc9543f5aa0a)

----------------------------------------------------------------------------------------------------------------

I also created a view to get the number of top scorers

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/cc94ee42-4c48-4e21-bed5-107d2073c0ac)

----------------------------------------------------------------------------------------------------------------

I also wanted to find the repartition of score per console so I created another view

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/f5766c24-064c-4908-94fd-555e857e937d)

----------------------------------------------------------------------------------------------------------------

Anyway, the idea here is just to get data moving end to end.

----------------------------------------------------------------------------------------------------------------

I then connected BigQuery to PowerBI for data viz

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/26ee6c8b-d87a-417d-b30e-9a571d5c0a0c)

----------------------------------------------------------------------------------------------------------------
 and here is the result
 
 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/baa815a5-05d6-440a-be8c-2c5f807b110a)

----------------------------------------------------------------------------------------------------------------

BONUS: you can also directly connect to Looker, I used powerBi because I like that tool but you can just do it with Looker for simplicity
So now, let’s connect to Lookup Studio for the visualization
I initiated a new report and connected to BigQuery

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/0283dd24-74cb-48fd-914f-c7533c36797d)

![image](https://github.com/valentinjoseph/gamespot/assets/96952537/6b2ed329-dff9-4109-8a23-e46047f4f50a)

----------------------------------------------------------------------------------------------------------------

And here is an up to date visualization of what the queries return in BigQuery

 ![image](https://github.com/valentinjoseph/gamespot/assets/96952537/962924c7-0517-4bf8-91fe-f121b320c1fd)


