
tidydata <- function(datapath){
#Created by DR, 2018/08/03        
#NOTE: datapath contains the path to UCI HAR Dataset that contains the train and test subdirectories        

#LOAD LIBRARIES
library(dplyr) #for select,filter,arrange,mutate,summarise,etc.

#READ DATA
#TASK 1:Read text files with "" as entry separator and "." for decimal number separator
setwd("C:/GettingAndCleaningData/Project")
# Read training  files
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".")
# Read test files
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".")
#Read feature names and activity labels
featurenames <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = "", dec = ".")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", dec = ".")


#CLEAN-UP VARIABLE NAMES
#TASK 2:Appropriately label the data set with descriptive variable names (add column labels to xtest and xtrain)
newnames <- featurenames$V2
newnames <- gsub("[[:punct:]]", "", newnames) #remove punctuation 
newnames <- tolower(newnames)# make all lower-case.
names(xtest) <- newnames #assign tidy variable names
names(xtrain) <- newnames #assign tidy variable names
rm(newnames)#remove from workspace to avoid confusion and free memory

#SELECTCOLUMNS
#TASK 3:Extract only the measurements on the mean and standard deviation for each measurement
#NOTE: did not limit selectig column names that contain "mean()" aor "std()" exactly. Intead,
#selected all names that contan "mean" or "std" using this regular expression: "^(.*)mean|std(.*)".
selxtest <- xtest[, grep("^(.*)mean|std(.*)", featurenames$V2)] #2947 obervations of 79 variables
rm(xtest)#remove from workspace to avoid confusion and free memory
selxtrain <- xtrain[, grep("^(.*)mean|std(.*)", featurenames$V2)] #7352 obervations of 79 variables
rm(xtrain)#remove from workspace to avoid confusion and free memory
#rm(featurenames)#remove from workspace to avoid confusion and free memory


#ACTIVITY NAMES
#TASK 4:Use descriptive activity names for the activities in ytrain and ytest
#NOTE:Used factor function as demonstrated here:https://www.statmethods.net/input/valuelabels.html
ytrain$V1 <- factor(ytrain$V1,levels = activitylabels$V1, labels = activitylabels$V2)#7352 obervations of 1 variable
ytest$V1 <- factor(ytest$V1,levels = activitylabels$V1, labels = activitylabels$V2) #2947 obervations of 1 variable


#CONSOLIDATE DATA SET (Training and Test observations)
#TASK 5:Add three columns for variables named and defined as follows:
#"activity" (factor class: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) ,
#"subject" (integer class: range [1:30]) 
#"subset" (factor class: train, test)  
bindselxtest <- mutate(selxtest, activity=ytest$V1 , subject=subjecttest[,1], subset=as.factor("test"))
rm(selxtest)#remove from workspace to avoid confusion and free memory
bindselxtrain <- mutate(selxtrain, activity=ytrain$V1 , subject=subjecttrain[,1], subset=as.factor("train"))
rm(selxtrain)#remove from workspace to avoid confusion and free memory
#TASK Merge the training and the test sets by rows to create one data set ("testandtrain") containing train and test observations of 82 variables 
testandtrain <- rbind(bindselxtrain, bindselxtest)#10299 observations of 82 variables
testandtrain <- select(testandtrain, subject, activity, subset, everything())# move three added columns to the left of the dataframe
rm(bindselxtrain)#remove from workspace to avoid confusion and free memory
rm(bindselxtest)#remove from workspace to avoid confusion and free memory
return(testandtrain)
}





