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
test_activity_ids <- read.csv("test/y_test.txt", header=F, sep="")
test_subject_ids <- read.csv("test/subject_test.txt", header=F, sep="")
test_data <- read.csv("test/X_test.txt", header=F, sep="", stringsAsFactors=F)
# Merge all test data
test_data <- cbind(test_activity_ids, test_subject_ids, test_data)

# Load training data
train_activity_ids <- read.csv("train/y_train.txt", header=F, sep="")
train_subject_ids <- read.csv("train/subject_train.txt", header=F, sep="")
train_data <- read.csv("train/X_train.txt", header=F, sep="", stringsAsFactors=F)
# Merge all training data
train_data <- cbind(train_activity_ids, train_subject_ids, train_data)

# Merge test and training data together
data <- rbind(test_data, train_data)

# Extract mean and std measurements
# We also need to keep the activity and subject info
colnames(data) <- c("Activity.ID", "Subject.ID", headers)
means <- data[, grep("-mean\\(", colnames(data), ignore.case=T)]
stds <- data[, grep("-std\\(", colnames(data), ignore.case=T)]
data <- cbind(Activity.ID=data$Activity.ID, Subject.ID=data$Subject.ID, means, stds)

# Use desriptive activity names
activity_labels <- read.csv("activity_labels.txt", header=F, sep="")
colnames(activity_labels) <- c("Activity.ID", "Activity.Label")
data <- merge(data, activity_labels)

# Use descriptive names for variables
colnames(data) <- sub("(.*)Acc(.*)", "\\1.Accelerometer\\2", colnames(data))
colnames(data) <- sub("(.*)Gyro(.*)", "\\1.Gyroscope\\2", colnames(data))
colnames(data) <- sub("(.*)Jerk(.*)", "\\1.Jerk\\2", colnames(data))
colnames(data) <- sub("(.*)Mag(.*)", "\\1.Magnitude\\2", colnames(data))
colnames(data) <- sub("^f(.*)", "\\1.Freq", colnames(data))
colnames(data) <- sub("^t(.*)", "\\1", colnames(data))
colnames(data) <- sub("(.*)-mean\\(\\)(.*)", "\\1.Mean\\2", colnames(data))
colnames(data) <- sub("(.*)-std\\(\\)(.*)", "\\1.Std\\2", colnames(data))
colnames(data) <- gsub("-", ".", colnames(data))


# Create tidy dataset
tidy_data <- aggregate(. ~ Activity.Label + Subject.ID, data, FUN=mean)

# Take the user back to its original dir and store
# the tidy data into its own file.
setwd("..")
write.table(tidy_data, file="tidy.txt", row.name=F)
