# 1. Merges the training and the test sets to create one data set.
# Read training dataset
train <- read.table("train/X_train.txt", sep="", header=F)

# Read testing dataset
test <- read.table("test/X_test.txt", sep="", header=F)

# Merge train & test dataset
all <- rbind(train, test)

# Remove variables train and test to save space, as they are no longer needed
remove(train)
remove(test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Read features and make the feature names better suited for R with some substitutions
features <- read.csv("features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])
features <- features$V2

# Get only the data on mean and std. dev.
good_columns <- grep(".*Mean.*|.*Std.*", features)
# First reduce the features table to what we want
features <- features[good_columns]

# Select only mean & std columns
all <- all[, good_columns]

# Give headings to the combined dataset
names(all) <- features

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 

# Read the activity labels:
activity_labels <- read.table("activity_labels.txt", sep="", header=F)
activity_labels <- activity_labels$V2

# Read y_train and y_test
y_train <- read.table("train/y_train.txt", sep="", header=F)
y_test <- read.table("test/y_test.txt", sep="", header=F)
y_all <- rbind(y_train, y_test)

# Add column to all
all[,"Activity"] <- lapply(y_all, function(t) { activity_labels[t] })

# Remove y_all, y_train, y_test as they are no longer needed
remove(y_all)
remove(y_train)
remove(y_test)

# Read the subject
subject_train <- read.table("train/subject_train.txt", sep="", header=F)
subject_test <- read.table("test/subject_test.txt", sep="", header=F)
subject_all <- rbind(subject_train, subject_test)
all[,"Subject"] <- subject_all

# Remove subject_train, subject_test, subject_all as they are no longer needed
remove(subject_all)
remove(subject_train)
remove(subject_test)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(all[,c(1:66)], by=list(all$Activity, all$Subject), FUN=mean)

# Rename column 1 and 2 of tidy (from Group.1 to Activity and Group.2 to Subject)
colnames(tidy)[1] <- "Activity"
colnames(tidy)[2] <- "Subject"

# Store the tidied data
write.table(tidy, "tidy_data.txt")