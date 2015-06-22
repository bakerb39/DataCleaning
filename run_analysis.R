library(plyr)

# Step 1: Merges the training and the test sets to create one data set

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")

y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

# create data sets
x_datasetset <- rbind(x_train, x_test)
y_datasetset <- rbind(y_train, y_test)
subject_datasetset <- rbind(subject_train, subject_test)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")

# use only columns with mean() or std() in their names
mean_std <- grep("-(mean|std)\\(\\)", features[,2])

# subset the columns
x_dataset <- x_dataset[, mean_std]

# fix column names
names(x_dataset) <- features[mean_std, 2]

# Step 3: Use descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")

# update values with new activity names
y_dataset[, 1] <- activities[y_dataset[,1],2]

# fix column name
names(y_dataset) <- "activity"

# Step 4: Appropriately label the data set with descriptive variable names

# correct column name
names(subject_dataset) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_dataset, y_dataset, subject_dataset)

# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

# all columns but activity, subject
average_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[,1:66]))

write.table(average_data, "tidy_data.txt", row.name=FALSE)

