# R code for Getting-and-Cleaning-Data-Course-Project

# Download the data file and keep the file in the project_data folder.


if(!file.exists("./project_data")){dir.create("./project_data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project_data/Dataset.zip")

# Unzip the file

if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipfile="./project_data/Dataset.zip",exdir="./project_data")
}

# see the list of the files in "UCI HAR Dataset" folder.

path_rf <- file.path("./project_data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

# Read data from the files and keep it into the respective variables.

# 1.Read the Activity files

dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

# 2.Read the Subject files

dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

# 3.Read Fearures files

dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


# Merges the training and the test sets for creating one data set

# 1.Concatenate the data tables by rows

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

# 2.set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# 3.Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# Extracts only the measurements on the mean and standard deviation for each measurement

# 1.Subset Name of Features by measurements on the mean and standard deviation

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# 2. Subset the data frame Data by seleted names of Features

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

# Uses descriptive activity names to name the activities in the data set

# 1.Read descriptive activity names from "activity_labels.txt"

activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

# Appropriately labels the data set with descriptive variable names

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# Creates a second,independent tidy data set and output it

library(plyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidy_data.txt",row.name=FALSE)
