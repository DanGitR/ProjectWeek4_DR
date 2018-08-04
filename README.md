---
title: "README for run_analysis.R"
author: "Daniel J. R."
date: "August 4, 2018"
output: html_document
---
#Summary
A processing script *run_analysis.R* has been created that transforms data downloaded from a UCI data set repository. 

The repository contains data collected from the accelerometers from the Samsung Galaxy S smartphone. 
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

A full description is available at the site where the data was obtained:  
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

#*run_analysis.R*

###Description
The script sources two functions **tidydata.R** and **avgdata.R** that implement the necessary transformations. The necessary *dplyr* library is also loaded by the script.
A call to **avgdata.R** is followed by a call to **avgdata.R**
The data frames created by **tidydata.R** and **avgdata.R** are then displayed within R Studio using *View()*.
The script writes a data frame file named *avgdataframe.csv* to the directory specified by *functionpath*.  
One can use *read.csv("avgdataframe.csv", row.names = 1)* to read the averaged data frame back into R. 
The script also returns a list *run_analysis* containing The data frames created by **tidydata.R** and **avgdata.R**.

###Usage

run_analysis <- function(datapath,functionpath)

###Arguments
*datapath*   Contains the path to UCI HAR Data set directory that contains the train and test sub directories. 
            For example, *datapath <- "C:/GettingAndCleaningData/Project/UCI HAR Dataset"*
            
*functionpath*   Contains the path to the directory that contains the **tidydata.R** and **avgdata.R** scripts.  This is also the path where *avgdataframe.csv* is created by *run_analysis.R*.
            For example, *datapath <- "C:/GettingAndCleaningData/Project"*
            
###Details
The script was created for use within R Studio Version 1.1.453 running version 3.5.1 of R, along with the *dplyr* library.
            
***            

#Transformations implemented within **tidydata.R** and **avgdata.R**

## **tidydata.R**

###Description
A step by step description of the transformations implemented within **tidydata.R** is included within *CodeBook.md*.

###Usage 

*tidydataframe <- tidydata(datapath)*

###Arguments 

*datapath*  Contains the path to UCI HAR Data set that contains the train and test sub directories. 
            For example, *datapath <- "C:/GettingAndCleaningData/Project/UCI HAR Dataset"*
            
###Details

The transformations implemented within **tidydata.R** create a merged data frame from the separate training and the test data obtained from the original repository. The function returns a tidy merged data frame that consists of 10299 observations of 82 variables. 
The function **tidydata.R** is called within **run_analysis.R** 


## **avgdata.R**

###Description
A step by step description of the transformations implemented within **avgdata.R** is included within *CodeBook.md*.

###Usage

*avgdataframe  <- avgdata(tidydataframe)*

###Arguments

*tidydataframe* This is a tidy data frame containing 10299 observations of 82 variables returned by **tidydata.R**

###Details

The transformations implemented within **avgdata.R** create a summary data frame from the merged data frame returned by tidydata.R . The function returns a tidy average data frame that consists of 180 observations of 81 variables. 
The function **avgdata.R** is called within **run_analysis.R**.



