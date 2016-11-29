
# set the working directory
setwd("/home/anshu/Coursera/GettingAndCleaningData")

# Download project data
zipName <- "projectData.zip"
if(!file.exists(zipName)) {
    dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(dataURL, zipName, method="curl")
}
# Unzip dataset
if(!file.exists("UCI HAR Dataset")) {
    unzip(zipName)
}

# Load feature vector and locate means and standard deviations
features <- read.table("UCI HAR Dataset/features.txt")
meanAndStdIndexes <- grep("mean|std", features[,2])

# Load training set and only choose means and stds, add activity ids and subjects to data set
training <- read.table("UCI HAR Dataset/train/X_train.txt")[, meanAndStdIndexes]
trainingLabel <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainingSubject, trainingLabel, training)

# Load test set and only choose means and stds, add activity ids and subjects to data set
test <- read.table("UCI HAR Dataset/test/X_test.txt")[, meanAndStdIndexes]
testLabel <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubject, testLabel, test)

# Merge test and training and add labels
mergedData <- rbind(training, test)
colnames(mergedData) <- c("Subject", "Activity", as.character(features[meanAndStdIndexes,2]))

# Transform activity codes to words
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
mergedData$Activity <- sapply(mergedData$Activity, function(x) activityLabels[x, 2])

# Group data with respect to subject and activity and take mean
secondData <- aggregate(. ~Subject+Activity, mergedData, mean)

# create a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(secondData, "tidySet.txt", row.names=F, sep="\t")

