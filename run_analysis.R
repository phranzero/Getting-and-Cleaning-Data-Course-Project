## Load packages
library(dplyr)

## File download and decompression
if(!file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile="getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
}
if(!file.exists("./UCI HAR Dataset")) {unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")}

## Step 1 - Merge training & test sets to create one data set.
subject_train <- scan("UCI HAR Dataset/train/subject_train.txt", integer())
subject_test <- scan("UCI HAR Dataset/test/subject_test.txt", integer())
subject_combined <- c(subject_train, subject_test)

y_train <- scan("UCI HAR Dataset/train/y_train.txt", integer())
y_test <- scan("UCI HAR Dataset/test/y_test.txt", integer())
y_combined <- c(y_train, y_test)

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = "numeric",  
                      comment.char = "", nrows = 7352)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric",  
                     comment.char = "", nrows = 2947)
x_combined <- rbind(x_train, x_test)

## Combine all into one data set
activitydata <- cbind(subject = subject_combined, activityID = y_combined, x_combined)

## Step 2 - Extract only the measurements on the mean & standard deviation for each measurement.
## And only where a measurement has both mean and standard deviation
features <- read.table("UCI HAR Dataset/features.txt", 
                       colClasses = c("integer","character"), 
                       comment.char = "", nrows= 561)  ## Read in column names for subsetting

features$V1 <- features$V1 + 2  #adjusting column index to match with activitydata column indices

keep <- grepl("mean\\(\\)|std\\(\\)",features[,2])
featurestokeep <- features[keep,]
activitydata <- activitydata[,c(1,2,featurestokeep[[1]])]


## Step 3 - Use descriptive activity names to name the activities in the data set
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activity"),
                             colClasses = c("integer","factor"))
activitydata <- merge(activitylabels,activitydata)
activitydata$activityID <- NULL  #Remove activity ID column as we now have descriptive activity names

## Step 4 - Appropriately label the data set with descriptive variable names.
featurestokeep$V2 <- gsub("mean\\(\\)", "Mean", featurestokeep$V2)
featurestokeep$V2 <- gsub("std\\(\\)", "StandardDev", featurestokeep$V2)
featurestokeep$V2 <- gsub("Acc", "Acceleration", featurestokeep$V2)
featurestokeep$V2 <- gsub("tBody", "TimeDomain-Body", featurestokeep$V2)
featurestokeep$V2 <- gsub("tGravity", "TimeDomain-Gravity", featurestokeep$V2)
featurestokeep$V2 <- gsub("fBody", "FrequencyDomainBody", featurestokeep$V2)
featurestokeep$V2 <- gsub("Gyro", "AngularVelocity", featurestokeep$V2)
featurestokeep$V2 <- gsub("X", "onXAxis", featurestokeep$V2)
featurestokeep$V2 <- gsub("Y", "onYAxis", featurestokeep$V2)
featurestokeep$V2 <- gsub("Z", "onZAxis", featurestokeep$V2)
featurestokeep$V2 <- gsub("Mag", "3DMagnitude", featurestokeep$V2)

colnames(activitydata) <- c("activity","subject", featurestokeep$V2)

activitydata <- arrange(activitydata, subject, activity)

## Step 5 - creates a second, independent tidy data set with the average of each
## variable for each activity and each subject.

tidydata <- group_by(activitydata, activity, subject)
tidydataResult <- summarise_each(tidydata,funs(mean))

write.table(tidydataResult, file = "ActivityData.txt", row.name=FALSE)