features<-read.table("./UCI HAR Dataset/features.txt")

# ID and Name of activity correspondence
activityName<-read.table("./UCI HAR Dataset/activity_labels.txt")

# TEST SET

xtest<-read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features$V2)  

# Subject ID data
testID<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="SubjectID")

# ID of the activity(1:6)
activityID<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names="ActID")

# Matching activity names to IDs
activityID$ActNames<-activityName$V2[match(activityID$ActID, activityName$V1)]

testset<-cbind(testID, activityID, xtest)

# TRAIN SET

xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features$V2)  

# Subject ID data
trainID<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="SubjectID")

# ID of the activity(1:6)
TactivityID<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names="ActID")

# Matching activity names to IDs
TactivityID$ActNames<-activityName$V2[match(TactivityID$ActID, activityName$V1)]

trainset<-cbind(trainID, TactivityID, xtrain)

dataset<-rbind(testset,trainset)

# mean and standard deviation set

new<-cbind(dataset[,c(1,3)],dataset[,grep(".*mean()|.*std()", colnames(dataset))])

# average datas (5)

library(dplyr)

mean <- new %>% group_by(ActNames, SubjectID) %>% summarize_all(funs(mean))
write.table(mean, file="meandata.txt", row.names=FALSE)



