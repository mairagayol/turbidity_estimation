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

1. Download the ACOLITE software from the following page, where you can also download the manual:

https://odnature.naturalsciences.be/remsem/software-and-data/acolite

ACOLITE is a generic processor developed at RBINS for atmospheric correction and processing for coastal and inland water applications. It currently supports many sensors, including Landsat (5/7/8), Sentinel-2 (A/B), Sentinel-3 (A/B), PlanetScope, Pléiades, and WorldView. ACOLITE performs atmospheric correction by default using the "dark spectrum fitting" approach (Vanhellemont and Ruddick, 2018, 2021; Vanhellemont, 2019a, 2019b, 2020), but can be configured to use the "exponential extrapolation" method (Vanhellemont and Ruddick, 2014, 2015, 2016).

2. To batch process all the images that need correction, you must have a ".txt" file listing the directory of all images. For example, the file "list_landsat8.txt" contains the following image paths:
   
D:\img\chascomus\L8\225_85\085\LC08_L1TP_225085_20180112_20180119_01_T1
D:\img\chascomus\L8\225_85\085\LC08_L1TP_225085_20180128_20180207_01_T1
D:\img\chascomus\L8\225_85\085\LC08_L1TP_225085_20180213_20180222_01_T1
D:\img\chascomus\L8\225_85\085\LC08_L1TP_225085_20180301_20180308_01_T1

3. You must also have a settings file, containing instructions for processing the images (e.g., "settings_landsat8.txt"), where you can specify the area of the image to be processed and where the corrected images should be stored (among other specifications).

4. On Windows, open the terminal (by typing "cmd" in the search bar) and navigate to the folder containing the ACOLITE software using the following command:

cd C:\Users\DELL\Downloads\acolite_py_win_20231023.0\acolite_py_win

5. Then, run the following command, and the corrected images will be saved in the folder specified in the "settings_landsat8.txt" file (remember to change the file paths and names according to your specifications):
   
dist\acolite\acolite.exe --cli --settings=D:\img\corregidas\settings_l8.txt --inputfile=D:\one\Escritorio\list_landsat8.txt

## 3. Comparing satellite images from different sensors
