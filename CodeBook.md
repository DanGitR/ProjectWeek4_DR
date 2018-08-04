---
title: "Accelerometer and Gyroscope Tidy Data Frames Code Book"
author: "Daniel J. R."
date: "August 3, 2018"
output: html_document
---

#Data
The original data was dowloaded from the UCI dataset repo:  
It contains data collected from the accelerometers from the Samsung Galaxy S smartphone. 
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

A full description is available at the site where the data was obtained:  
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

Separate Training and Test data files were used:

* Train Data  
        + *subject_train.txt* (7352 obervations of 1 variable)  
        + *X_train.txt* (7352 obervations of 561 feature varaibles)  
        + *y_train.txt* (7352 obervations of activity labels)  
        
* Test Data  
        + *subject_test.txt* (7352 obervations of 1 variable)  
        + *X_test.txt* (7352 obervations of 561 feature variables)  
        + *y_test.txt* (7352 obervations of activity labels)  

The data from the Inertial Signals Subirectories was not used for the analysis

# Variables
The features in *X_train.txt* and *X_test.txt* are 561 features derived from
the original inertial measurements of acceleration and angular velocity.
The 561 features were derived in the time and frequency domains 

#Transformations implemented within **tidydata.R**

##Read text files
The files were read using **read.table.R** with *""* as entry separator and *"."* for decimal number separator
To create partial dataframes labeled per the table below:

Text File           | Data Frame Name
--------------------|-----------
*subject_train.txt* |subjecttrain
*subject_test.txt*  |subjecttest
*X_train.txt*       |xtrain
*X_test.txt*        |xtest
*y_train.txt*       |ytrain
*y_test.txt*        |ytest

##Cleaned Up Feature Variable Names
Cleaned up original variabelnames provided within *features.txt*
Removed punctuation and made all of them lower case 

##Selected Columns from xtest and xtrain data frames  
Extracted only the features representging mean and standard deviation for each measurement  

* did not limit selectig column names that contain *"mean()"* or *"std()"* exactly.    
* selected all names that contained *"mean"* or *"std"*    

This resulted in the features count being reduced from 561 to 79

##Used Descriptive Activity Names 
Used descriptive activity names from *activity_labels.txt* for the activities in ytrain and ytest
Used **factor.R** function as demonstrated here:[link](https://www.statmethods.net/input/valuelabels.html)


##Consolidated Data Set (Training and Test observations)
Added three columns (increasing variable count to 82) to the trainig and test data frames as follows:

* "activity" (factor class: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)  
* "subject" (integer class: range [1:30])   
* "subset" (factor class: train, test)  

##Merged Data Set
Merged the training and the test sets by rows to create one data set  containing train and test observations
of 10299 observations of 82 variables.
Moved the three added columns to the left of the merged dataframe.

***

#Transformations implemented within **avgdata.R**
Created a tidy averaged data set from the output of **tidydata.R** as follows:  

* removed subset column which will not be part of the averaged data.  
* grouped the averaged data frame by subject and activity columns.  
* summarized using mean() acting on the grouped data frame to obtain 180 average obsevations of 81 variables. 
* sorted by "subject" then by "activity"" in ascending order.  

#Function Implementation
Refer to README.md for explanation of how **tidydata.R** and **avgdata.R** are called within **run_analysis.R** to complete the tranformtaion steps described within this document.