### READ ME FILE for Coursera course "Getting and Cleaning Data" Course Project

The purpose of this file is to explain each step taken on version 1.0 of the [Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to arrive at the output file (ActivityData_Cleaned.txt) generated by the run_analysis.R script.
This file also serves the purpose to explain the reasoning for each step in this recipe.  The goal of this recipe is to generate a tidy data set.

The raw data set can be obtained at:
https://archive.ics.uci.edu/ml/machine-learning-databases/00240/ 
however to avoid load on the server the zip file can also be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The codebook for the original data set can be found here:
https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

Data processing was completed using the following tools:
  * R x64 Version 3.2.2
  * RStudio Version 0.99.467
  * Dplyr Package Version 0.4.2

####Step 1: Extract the raw data set, import the data and merge data sets together.

Load the following files in the following R data types:

| File Name | R Data Type |
----------------------------------------|---------------------------------------------------
| UCI HAR Dataset/train/subject_train.txt | Integer Vector |
| UCI HAR Dataset/test/subject_test.txt   | Integer Vector |
| UCI HAR Dataset/train/y_train.txt       | Integer Vector |
| UCI HAR Dataset/test/y_test.txt         | Integer Vector |
| UCI HAR Dataset/train/X_train.txt       | Data Frame with Numeric data type for both columns |
| UCI HAR Dataset/test/X_test.txt         | Data Frame with Numeric data type for both columns |

  * The files loaded as integer vectors were loaded using the R function "scan"
  * Data Frames were loaded using the "read.table" function with parameters comment.char = "" and nrows specified for each file to improve memory performance.
  
  Once all data files have been loaded, combine both the train and test versions of each file.  Be sure to combine in the same order for each file i.e. train data always comes before test data
  
  Step 1 Code:  
  ```R
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
  ```

####Step 2: Combine measurements(X) with subject(subject) and activity(Y) data into a single data frame using the R "cbind".

Step 2 Code:  
  ```R
  activitydata <- cbind(subject = subject_combined, activityID = y_combined, x_combined)
  ```
  
####Step 3: Load in column labels for the measurements and subset data. 
  
  Use the features.txt file and the "read.table" R function with parameters comment.char = "" and nrows specified to improve performance.  The first column in the file is imported as integer and the second as a character type.
  ```R
  features <- read.table("UCI HAR Dataset/features.txt", 
                       colClasses = c("integer","character"), 
                       comment.char = "", nrows= 561)
  ```
  As we combined the subject and activity data into the 1st and second columns, we want to adjust all the column indices in the features data to correspond with the same column indices in our data frame.  This is done by add 2 to each column index.
  ```R
  features$V1 <- features$V1 + 2
  ```
  We now want to specify which columns we want to keep in our data set.  This is done by using the logical grep function "grepl" to create a logical vector where each TRUE value represents a column we would like to keep in the data set.  To meet the requirements of the course project, we must include all mean and standard deviation measurements.  There were some mean measurements without associated standard deviation measurements that were not included.  We then subset the data using the remaining column indexes in our features data.
  ```R
  keep <- grepl("mean\\(\\)|std\\(\\)",features[,2])  ## Checks each element in the features data for "mean()" or "std()" and sets the output element to TRUE if there is a match
  featurestokeep <- features[keep,]  ## Use grep output to subset the features data
  activitydata <- activitydata[,c(1,2,featurestokeep[[1]])]  ## Use features data to subset the data set
  ```
  At this point, we now have an activity data set with activity IDs, subject IDs, and the measurements we are interested in.  However, column names and our activity data are not descriptive.
  
####Step 4:  Change Activity IDs (integers) into more descriptive Activity names

  Read in the activity_labels.txt file contained in the original data set.  This file contains the mapping of activity IDs to activity names.  These names are already descriptive and did not need to be reused for the tidy data set result.  This data was read into R using the "read.table" function.

  The "merge" function was then used to merge the activity labels dataframe with our activity data frame.  Note the order of data frames listed. The activity labels data frame was included first to ensure the activity names would appear as the first column in our overall data set.
  Lastly, we remove the old activity ID column as it is no longer useful for our purposes.

  ```R
  activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activity"),
                             colClasses = c("integer","factor"))
  activitydata <- merge(activitylabels,activitydata)
  activitydata$activityID <- NULL
  ```
  
####Step 5:  Change measurement names to be more descriptive and apply new measurement names as column headers to the data frame.

  The measurement names are modified with the following goals to create more descriptive names:
    * Remove any unecessary symbols like "()"
	* Expand statistic names i.e. "std" to "StandardDev"
	* Expand abbreviations: "Acc" to "Acceleration", "t" to "TimeDomain", "f" to "FrequencyDomain"
	* Replace words with more descriptive versions:
	  * "Gyro" to "AngularVelocity" to show what was actually being measured by the gyro
	  * "Mag" to "3D Magnitude"
	  
  The name adjustments were completed by using the "gsub" function on the features data frame.  Once the name adjustments have been made, set the column names of the data set.  Lastly, the data frame is sorted by subject then by activity as tidy data sets have observations organized in a meaningful order.
  
  ```R
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
  ```

####Step 6:  Summarize the data by taking the mean of all measurements by activity and subject.  As there are 30 subjects and 6 activities, our tidy data summary will have 180 rows.

  The dplyr package was used to utilize the "group_by" and "summarise_each" functions.  "group_by" allows us to specify which columns will be used to group our data.  "summarise_each" allows us to run a mean() function on all other columns in the data set that have not been specified as a grouping column.
  
  The tidy data set is then written to a file, ActivityData_Cleaned.txt
  
  ```R
  tidydata <- group_by(activitydata, activity, subject)
  tidydataResult <- summarise_each(tidydata,funs(mean))

  write.table(tidydataResult, file = "ActivityData_Cleaned.txt")
  ```
  
To view the tidy data set in R after running the script, use the following R commands:

  ```R
  data <- read.table("ActivityData_Cleaned.txt", header = TRUE)
  View(data)
  ```