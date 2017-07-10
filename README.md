# Course Project - Getting and Cleaning Data


## Introduction

This repository contains the R script and code book for the final
course project.


## Usage

Go to the repository directory, and launch `R` from inside it.
Then run the follwing command:

`source("run_analysis.R")`

This will produce the following:
1. Download the input data set, uncompress it and delete any temp files.
2. Cleanup the input data set.
3. Generate a new tidy data set grouped by subject ID and activity, and
calculating the average of the rest of the variables provided.
4. Output the new tidy data set into it's own file, named `tidy.csv`.
