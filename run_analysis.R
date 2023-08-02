# Load libraries
library(tidyr)
library(dplyr)

## Read the subject files and feature names into tables
subject_test_data <- read.table("subject_test.txt", col.names = "subject")
subject_train_data <- read.table("subject_train.txt", col.names = "subject")
feature_labels <- read.table("features.txt", col.names = c("code","feature"))

# clean variable names in feature_labels
feature_labels$feature <- gsub("tBodyAcc","TimeBodyAcceleration",feature_labels$feature)
feature_labels$feature <- gsub("tGravityAcc","TimeGravityAcceleration", feature_labels$feature)
feature_labels$feature <- gsub("tBodyGyro","TimeBodyGyroscope",feature_labels$feature)
feature_labels$feature <- gsub("fBodyAcc","FreqBodyAcceleration",feature_labels$feature)
feature_labels$feature <- gsub("fBodyGyro","FreqBodyGyroscope",feature_labels$feature)
feature_labels$feature <- gsub("fBodyBodyAccJerkMag","FreqBodyAccelerationJerkMagnitude",feature_labels$feature) 
feature_labels$feature <- gsub("fBodyBodyGyroMag","FreqBodyGyroscopeMagnitude",feature_labels$feature)
feature_labels$feature <- gsub("fBodyBodyGyroJerkMag","FreqBodyGyroscopeJerkMagnitude",feature_labels$feature)
feature_labels$feature <- gsub("-mean\\(\\)","Mean",feature_labels$feature)
feature_labels$feature <- gsub("-std\\(\\)","Std",feature_labels$feature)
feature_labels$feature <- gsub("-","",feature_labels$feature)

# Read x test and train data with feature labels applied to variable
x_test <- read.table("X_test.txt")
colnames(x_test) = feature_labels$feature
x_train <- read.table("X_train.txt")
colnames(x_train) = feature_labels$feature
y_test <- read.table("y_test.txt",col.names="activitycode")
y_train <- read.table("y_train.txt", col.names="activitycode")

# Read activity labels
activity_labels <- read.table("activity_labels.txt", col.names = c("activitycode","activity"))

# Bind test data into one table
test <- cbind(subject_test_data,activity=y_test$activitycode,x_test)

# Bind training data
train <- cbind(subject_train_data,activity =y_train$activitycode,x_train)

# Combine test and train
dat <- rbind(test,train)

# sort out mean and standard deviation variables
meanstd<-select(dat,(contains("Mean",ignore.case = FALSE)|contains("Std",ignore.case = FALSE))&!contains("angle")) 

meanstd <- cbind(dat[1:2],meanstd)

# Convert from code to activity names
for(i in 1:nrow(meanstd)) {
        meanstd$activity[i] <- activity_labels[meanstd$activity[i],2]
        }

# Group by, then summarize
meanstd <-group_by(meanstd, subject, activity)
sum_table <- summarize_each(meanstd,mean)
write.csv(sum_table, file="Activity_Means.csv")