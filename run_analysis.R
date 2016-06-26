## Getting and Cleaning Data Course Project

## You should create one R script called run_analysis.R that does the following.
  ## Merges the training and the test sets to create one data set.
  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  ## Uses descriptive activity names to name the activities in the data set
  ## Appropriately labels the data set with descriptive variable names.
  ## From the data set in step 4, creates a second, independent tidy data set with the average 
  ##  of each variable for each activity and each subject.

library(dplyr)
library(datasets)


##Load files into data sets
  activitylabels <- read.table("activity_labels.txt", sep = "", col.names = c("id","activity"))
  datasetCols <- read.table("features.txt", sep = "", col.names = c("id","Features"))
  ##find column numbers with "std" and "mean"
    stdcols <- grep("std",datasetCols$Features)
    meancols <- grep("mean",datasetCols$Features)
    displaycolumns <- sort((c(stdcols,meancols)))
    
  ##Test data sets
    testlabels <- read.table("./test/y_test.txt", sep=" ", col.names = "TestLabels")
    ##Does step 4 here, with col.names
    testset <- read.table("./test/x_test.txt", sep="", strip.white = TRUE, col.names = datasetCols$Features)
    testsubjects <- read.table("./test/subject_test.txt", sep="", col.names = "SubjectID")
    ##Add Contextual ID Columns (Subject,Label)
    ##testset <- cbind(id = seq(along = testset$tBodyAcc.mean...X),testset)
    testset <- cbind(SubjectID = testsubjects$SubjectID, testset)
    testset <- cbind(ActivityID = testlabels$TestLabels, testset)
  ##Train data sets
    trainlabels <- read.table("./train/y_train.txt", sep=" ", col.names = "TrainLabels")
    ##Does step 4 here, with col.names
    trainset <- read.table("./train/x_train.txt", sep="", strip.white = TRUE, col.names = datasetCols$Features)
    trainsubjects <- read.table("./train/subject_train.txt", sep="", col.names = "SubjectID")
    ##Add Contextual ID Columns (Subject, Label)
    trainset <- cbind(SubjectID = trainsubjects$SubjectID, trainset)
    trainset <- cbind(ActivityID = trainlabels$TrainLabels, trainset)
    
##Step 1: Merges the training and the test sets to create one data set.
    fulldataset <- merge(testset,trainset, all=TRUE)
##Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
    ##account for the additional columns added at the beginning of data
    displaycolumns<- displaycolumns + 2
    displaycolumns <- c(1,2,displaycolumns)
    ##subset for only those columns with the names
    meanstddataset <- fulldataset[,displaycolumns]
##Step 3: Uses descriptive activity names to name the activities in the data set
    ##Based on the ID, add the activity name
    activitydataset <- merge(meanstddataset,activitylabels, by.x = "ActivityID", by.y = "id")
##Step 4: Appropriately labels the data set with descriptive variable names.
    ##Done inline for ease.
    
##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
    ##  of each variable for each activity and each subject.
    activitydataset <- activitydataset[,2:82]
    activitydataset_m <- melt(activitydataset, id=c("SubjectID","activity"))
    tidydata <- dcast(activitydataset_m, SubjectID+activity ~ variable, mean)
    write.table(tidydata, row.name = FALSE)
