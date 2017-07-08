# Download data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

# Unzip data file
unzip("dataset.zip")

# Remove unnecessary file
file.remove("dataset.zip")



