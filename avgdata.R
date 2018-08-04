
avgdata <- function(tidydataframe){
        
#Created by DR, 2018/08/03
#NOTE: tidydata is a data frame created by teh function defined within tidydata.r
#LOAD LIBRARIES
library(dplyr) #for select,filter,arrange,mutate,summarise,etc.
        
#CREATE TIDY AVERAGED DATA SET
#TASK 6: Create a second, independent tidy data set ("avgtestandtrain") with the average of each variable for each activity and each subject.
avgtestandtrain <- tidydataframe
avgtestandtrain <- select(avgtestandtrain ,-subset) #remove subset column which sould not be part of the averaged data
avgtestandtrain<-group_by(avgtestandtrain,subject,activity)#group data frame by subject and acivity columns.
avgtestandtrain<-summarize_all(avgtestandtrain,mean)#summarize using mean() for the grouped data frame (180 average obsevations of 81 variables)
avgtestandtrain<-arrange(avgtestandtrain,subject,activity) #sort by subject and activity in ascending order for both columns.
return(avgtestandtrain)

}




