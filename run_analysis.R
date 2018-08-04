run_analysis <- function(datapath,functionpath){
#Created by DR, 2018/08/03        
#NOTE: datapath is path to the UCI HAR Dataset directory" 
#NOTE: function path is path to the location of tidydata.R and avgdata.R  
        
#TASK: source the de required functions tidydata.R and avgdata.R
setwd(functionpath)
source('tidydata.R')
source('avgdata.R')
        
#TASK: function calls
tidydataframe <- tidydata(datapath)#call to dedicated function that creates the tidy data frame for the training and test data
avgdataframe  <- avgdata(tidydataframe)# call to dedicated function that creates the averaged tidy data frame 

#TASK:view results
View(tidydataframe)
View(avgdataframe)
write.csv(avgdataframe, file = "avgdataframe.csv")#write the avgdataframe.csv file to the functionpath directory.
#NOTE: use "read.csv("avgdataframe.csv", row.names = 1)" to read the averaged data back into R.
run_analysis <- list(tidydataframe,avgdataframe)#function returns a list containing the two dataframes 

}