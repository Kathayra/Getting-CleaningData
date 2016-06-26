# Getting-CleaningData
Course Project
##About runanalysis.R
This script works as long as the data is in a folder as the current working directory. It combines the multiple datasets that were parsed into text files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

1. First it loads the separate data sets into data frames. 
2. It starts with the lookup values for Features and and activity labels. Then it continues to put the columns that have "std" or "mean" into a vector to use later.
3. It reads in the test and train set data. Then it adds the contextual data of the subject and the activity to the test and train datasets.
4. Next it combines the datasets.
5. Ater combinging the data set is subset to only contain the columns in step 2.
6. The activity name is added to the subset of data
7. The data is split to create the means of the columns.


##Code Book
