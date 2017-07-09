# Download data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

# Unzip data file
unzip("dataset.zip")

# Remove unnecessary file
file.remove("dataset.zip")


# Go into the dataset dir to start processing it
setwd("./UCI HAR Dataset")


# Load headers
headers <- read.csv("features.txt", header=F, sep="")
headers <- as.character(headers[, 2])

# Load test data
test_subject_ids <- read.csv("test/subject_test.txt", header=F, sep="")
test_activity_labels <- read.csv("test/y_test.txt", header=F, sep="")
test_data <- read.csv("test/X_test.txt", header=F, sep="")
# Merge all test data
test_data <- cbind(test_activity_labels, test_data, test_subject_ids)

# Load training data
train_subject_ids <- read.csv("train/subject_train.txt", header=F, sep="")
train_activity_labels <- read.csv("train/y_train.txt", header=F, sep="")
train_data <- read.csv("train/X_train.txt", header=F, sep="")
# Merge all training data
train_data <- cbind(train_activity_labels, train_data, train_subject_ids)

# Merge test and training data together
data <- rbind(test_data, train_data)
colnames(data) <- c("Activity.Label", headers, "Subject.ID")

# Extract mean and std measurements
means <- data[, grep("mean", colnames(data), ignore.case=T)]
stds <- data[, grep("std", colnames(data), ignore.case=T)]
data <- cbind(means, stds)


# Take the user back to its original dir
setwd("..")
