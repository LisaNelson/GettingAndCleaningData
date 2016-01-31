#Getting And Cleaning Data
##Project for Getting and Cleaning Data | Coursera | Johns Hopkins
##Lisa Nelson 

==================================================================
# Based on data and documentation by: 
  Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
  Human Activity Recognition Using Smartphones Dataset
  Smartlab - Non Linear Complex Systems Laboratory
  DITEN - Università degli Studi di Genova.
  Via Opera Pia 11A, I-16145, Genoa, Italy.
  activityrecognition@smartlab.ws
  www.smartlab.ws
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
   The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
   The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

=================================================================
##Other Resources:
  Thoughtful Bloke: 	https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
  "Tidy Data" paper: 	http://vita.had.co.nz/papers/tidy-data.pdf
  Code Book info: 		https://github.com/jtleek/datasharing
   
=================================================================
##Assignment Files:
	README.md      - this documentation
	CodeBook.txt   - Code book for the tidy data file
	tidyset2.txt   - tidy data set with average mean and std values data in wide format
	run_analysis.R - code to create the data set  

##Supporting Files:
  activity_labels.txt
  features.txt  
  
=====================================================================
##How to read tidy data file: 
  file_path <- "./tidyset2.txt"
  data <- read.table(file_path, header = TRUE) 
  View(data)
======================================================================
##Script description 
The code is run with a single script, run_analysis.R.  Which performs the following steps:

    1.  Merges the training and the test sets to create one data set.
x, y and subject files are read for both test and train.  These are combined using cbind and rbind.
	
    2.  Extracts only the measurements on the mean and standard deviation for each measurement.
Column names are read in from features.txt.  Special characters are striped, and some renaming performed for readability.  
Columns in the combined train and test data are renamed to these.  
Besides the Subject and Activity, only columns contining "mean" or "std" are kept
	
    3.  Uses descriptive activity names to name the activities in the data set
Activity numbers are replaced with Activity names from activity_lables.txt using merge.  

    4.  Appropriately labels the data set with descriptive variable names.
These are loaded as described in #2 above.  	
	
    5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This is created using melt and dcast to create a wide tidy data set.  