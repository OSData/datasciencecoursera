# load the library for melt/cast
library("reshape2")

# the measurements
train_measurements  <-read.table("./UCI HAR Dataset/train/X_train.txt")
test_measurements  <-read.table("./UCI HAR Dataset/test/X_test.txt")

# the numbered activities
train_activities	<-read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
test_activities	<-read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)

# the subjects
train_subjects	<-read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
test_subjects	<-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)

# the activity labels
activity_labels	<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE,header = FALSE)

# and the features, i.e. the measurement-names
features	<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE,header = FALSE)

# extract the feature names only by dropping the numbers
features	<- features[,2] 

#create the full set 

# first join the train and test sets
measurements	<- merge(train_measurements,test_measurements,all = TRUE,sort=FALSE)
activities	<- rbind(train_activities,test_activities)
subjects	<- rbind(train_subjects,test_subjects)

# create the full set
full	<- cbind(subjects,activities,measurements)

# set the proper column names
colnames(full)<-c("Subject","Activity",features)

# select only columns with mean() or std()
meanstd <- grep("mean()|std()", colnames(full))

full_meanstd	<-full[,c(1,2,meanstd)]

# use melt to create long set
melted_full_meanstd	<-melt(full_meanstd, id.var = c("Subject", "Activity"))

# use cast to recreate wide set with the means of the values per Subject and Activity 
cast_full_meanstd <- dcast(melted_full_meanstd , Subject + Activity ~ variable, mean)

# use loop to add activity names
for (i in seq(cast_full_meanstd[,2])) { 
  cast_full_meanstd[i,2]<- activity_labels[cast_full_meanstd[i,2],2]   
}

write.table(cast_full_meanstd,file = "final_set.txt",sep=",",row.names = FALSE)
