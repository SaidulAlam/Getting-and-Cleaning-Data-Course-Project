# Getting-and-Cleaning-Data-Course-Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this project
1. Set your working directory using ```setwd()``` function in RStudio.
2. Download the data file and keep it into a folder(project_data) in your working directory. You'll have a ```UCI HAR Dataset``` folder in your ```project_data``` folder.
3. Keep the  ```run_analysis.R``` file in your working directory.
4. Run the  ```script file("run_analysis.R")```, then it will create a new file ```tidy_data.txt``` in your working directory.

## Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```reshape2``` and ```data.table```. 
