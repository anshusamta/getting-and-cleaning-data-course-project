Getting and Cleaning Data Course Project

The r-script "run_analysis" creates a txt file "tidySet.txt".  The script does the following to produce the file:

1. Downloads the project's data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzips it.
2. Loads the feature vector and locates the means and standard deviations in that vector
3. Loads the training data set and chooses means and standard deviations. Also adds subject and activity id:s to the data table.
4. Loads the test data set and chooses means and standard deviations. Also adds subject and activity id:s to the data table.
5. Merges test and training data sets and adds column labels
6. Translates activity ids to plain English
7. Groups the data with respect to subject and activity and takes mean of each activity and subject pair.
8. Exports this grouped and averaged data into a txt file.
