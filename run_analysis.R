library(dplyr)

###############################################################################
# Download and unzip file
###############################################################################
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,
              destfile='HARDataset.zip',
              #method="curl", # for OSX / Linux 
              mode="wb")
unzip(zipfile = "HARDataset.zip", exdir = "./HARDataset")


###############################################################################
# Read in test and training data
###############################################################################
# List of variables for training and test data
features <- read.table("./HARDataset/UCI HAR Dataset/features.txt")
# Translation for activity labels
activityLabels <- read.table("./HARDataset/UCI HAR Dataset/activity_labels.txt")

# Training Data including giving descriptive names to the columns (task 4)
trainData <- read.table("./HARDataset/UCI HAR Dataset/train/X_train.txt")
colnames(trainData) <- features$V2
# List of subjects (people) who performed the activity
trainSubject <- read.table("./HARDataset/UCI HAR Dataset/train/subject_train.txt",
                           col.names = 'subject')
# List of activities that were done
trainActivities <- read.table("./HARDataset/UCI HAR Dataset/train/y_train.txt",
                              col.names = 'activity')
# Complete training data
trainData <- cbind(trainData, c(trainSubject, trainActivities))


# Testing Data including giving descriptive names to the columns (task 4)
testData <- read.table("./HARDataset/UCI HAR Dataset/test/X_test.txt")
colnames(testData) <- features$V2
# List of subjects (people) who performed the activity
testSubject <- read.table("./HARDataset/UCI HAR Dataset/test/subject_test.txt",
                           col.names = 'subject')
# List of activities that were done
testActivities <- read.table("./HARDataset/UCI HAR Dataset/test/y_test.txt",
                              col.names = 'activity')
# Complete testing data
testData <- cbind(testData, c(testSubject, testActivities))

rm(features, testActivities, testSubject, trainActivities, trainSubject)


###############################################################################
# 1. Merge the training and the test sets to create one data set
###############################################################################
mergedData <- rbind(trainData, testData)


###############################################################################
# 3. Use descriptive activity names to name the activities in the data set
###############################################################################
mergedData$activity <- factor(mergedData$activity, levels = activityLabels$V1,
                              labels = activityLabels$V2)


###############################################################################
# 2.Extract only the measurements on the mean and standard 
#   deviation for each measurement
###############################################################################
# Interpretation: those labels who have mean or std and end with ())
mask <- grep("mean.*()|std.*()|activity|subject", colnames(mergedData))
mergedDataExtract <- mergedData[ , mask]


###############################################################################
# 5.From the data set in step 4, create a second, independent tidy data set 
#   with the average of each variable for each activity and each subject
###############################################################################
# Do not include subject and activity as they will be included anyway and factor leads to warning
meanMergedData <- aggregate(mergedDataExtract[, !names(mergedDataExtract) %in% c("subject", "activity")],
                            by = list(mergedDataExtract$activity,
                                   mergedDataExtract$subject),
                            FUN = "mean")
# Rename group columns for better understanding
meanMergedData <- rename(meanMergedData,
                         activity = Group.1,
                         subject = Group.2)


###############################################################################
# Write data.frame to txt-File
###############################################################################
write.table(meanMergedData, file = "./meanHARData.txt", row.name=FALSE)
