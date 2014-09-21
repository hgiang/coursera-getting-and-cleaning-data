Getting & Cleaning Data - Course Project
----------------------------------------

This document describes the process of run_analysis.R to clean data. The step as the followings:

### 1. Merges the training and the test sets to create one data set.

* The training and testing dataset are first read into two variables, train and test, respectively
* The training & testing dataset are then merged using rbind into a single variable named all
Here, in the first part of the code, I only merged X_train & X_test. y_train and y_test, subject_train, subject_test are merged into all later in part 3 for coding convenience.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

* First the list of all feature names are read into variable features
* Then the features with mean and standard deviation are found using regular expression. The column indices are stored in variable good_columns
* Variable all is subsetted with good_columns
Notes:

In here I extracted 66 columns. There are columns "meanFreq" that I purposely excluded. Only columns that has "mean()" and "std()" in its name are included.

### 3. Uses descriptive activity names to name the activities in the data set. 
### 4. Appropriately labels the data set with descriptive activity names.

* First the English names of the activites are read into variable activity_labels.
* After that, activity_labels are used to labels y_train and y_test, and then merged into all
* Next, subject are read and merged into subject_all
* Finally, subject_all is merged into all. After this step, all contains all the information that we need to merge

###  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* The average are calculated using function aggregate. The result is stored in variable tidy which will be then stored into a file named "tidy_data.txt"
* Tidy data  has 180 rows. This is because: There are 30 subject and 6 activities, thus there are 30\*6 = 180 averages for each variable.
