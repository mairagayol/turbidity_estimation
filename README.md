# Turbidity estimation from satellite data

## Landsat and Sentinel image acquisition and processing

This repository contains workflows and instructions for satellite image acquisition and processing, used in the manuscript *"Temporal and spatial variability of turbidity in a highly productive and turbid shallow lake (Chascomús, Argentina) using a long time-series of Landsat and Sentinel-2 data"* by Gayol Maira P.; Dogliotti Ana I., Lagomarsino L. & Zagarese H.E.  
(in revision in the journal Hydrobiologia)


Contact: mairagayol@gmail.com

## 1. Downloading images from Google Cloud Services
1.	Install gsutil from the following page:

https://cloud.google.com/storage/docs/gsutil_install
 
Download the appropriate installer (Windows, Linux, Mac, etc). Follow the installer instructions (Recommendation: when given the option to use "gcloud init," do not select it).

2.	Find where the files of interest that we want to download are located. From this page, you can find the addresses for each type of data: 

https://cloud.google.com/storage/docs/public-datasets/

3.	Open the Google Cloud SDK shell terminal installed on the computer and run the following command to log in with your Gmail account:

gcloud auth login 

A page will open where you need to log in.

4.	From the Google Cloud SDK shell terminal, to download the files of interest to our computer, we must use the cp command: EXAMPLE to download all Landsat 5 images for path row 224/85

gsutil -m cp -r gs://gcp-public-data-landsat/LT05/01/224/085/ D:\img\lagunas\L5\224_085\ 

With this command, we copy what is in the "gcp-public-data-landsat/LC08/01/224/085/" folder on your computer to the folder "D:\img\lagunas\L5\224_085".
Note: This process may take a long time (24 hours or more) as it downloads all available images in that folder.

## 2. Image correction using ACOLITE software

## 3. Comparing satellite images from different sensors
