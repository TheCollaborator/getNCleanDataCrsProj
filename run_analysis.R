# You should create one R script called run_analysis.R that does the following: 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#       average of each variable for each activity and each subject.
library(stringr)
#read in teh features file with all the x column names
#create a new column with all the names changed to lower case
ftrs = read.table("UCI HAR Dataset/features.txt", col.names=c("Vnum","feature"))
#remove anything not a lowercase letter or numeral
ftrs$feature = gsub("[^a-z0-9]","",tolower(ftrs$feature))

#read the .txt files into dataframes using read.table
#column names are assigned to the y and s files as they will otherwise
#     come in with "V1" just like the first element of x and create
#     an issue if attempting to rename later
#combine the 3 columns
xtest = read.table("UCI HAR Dataset/test/X_test.txt", col.names = ftrs$feature)
ytest = read.table("UCI HAR Dataset/test/y_test.txt",col.names = c("label"))
stest = read.table("UCI HAR Dataset//test/subject_test.txt",col.names = c("subject"))
xystest = cbind(stest,ytest,xtest)

xtrain = read.table("UCI HAR Dataset//train/X_train.txt", col.names = ftrs$feature)
ytrain = read.table("UCI HAR Dataset//train/y_train.txt",col.names = c("label"))
strain = read.table("UCI HAR Dataset//train/subject_train.txt",col.names = c("subject"))
xystrain = cbind(strain,ytrain,xtrain)

#merge the dfs by the subject column will all set to T since the subjects are
#     different in the different dfs
#mxystt = merge(xystest,xystrain,by.x="subject",by.y="subject",all=TRUE)
mergedset = merge(xystest,xystrain,all=TRUE)

#identify the features with "mean" and "std" in the names
#     combine the mean and std
mftrs <- ftrs[grepl("mean",ftrs$feature),]
sftrs <- ftrs[grepl("std",ftrs$feature),]
#smftrs <- c(mftrs,sftrs)
smftrs <- merge(mftrs,sftrs,all=T)
#now i have a character vector of all the col.names i want
cols2pull = smftrs$Vnum + 2
cols2pull = c(1,2,cols2pull)
mergedset2 = mergedset[,cols2pull]
#clean up some memory
rm(mergedset)
rm(xtest)
rm(ytest)
rm(stest)
rm(strain)
rm(xtrain)
rm(ytrain)
rm(xystest)
rm(xystrain)

#read in the activity labels and reassign the 
aLabels = read.table("UCI HAR Dataset//activity_labels.txt", col.names=c("actNum","activity"))

j <- function(x) {as.character(aLabels$activity[x])}
mergedset2$fulllabels = lapply(mergedset2$label, FUN = j)

#now subset the data by subject and activity
dataavg <- aggregate(mergedset2[,3:88],list(mergedset2$subject,mergedset2$label),mean)
datastd <- aggregate(mergedset2[,3:88],list(mergedset2$subject,mergedset2$label),sd)
#change the names of the grouped on columns to something more descriptive
colnames(dataavg)[1] <- "subjectid"
colnames(datastd)[1] <- "subjectid"
colnames(dataavg)[2] <- "activityid"
colnames(datastd)[2] <- "activityid"
#do the conversion from activityid# to activityname again for the mean and std data
actid = lapply(dataavg$activityid, FUN = j)
actid2 = lapply(datastd$activityid, FUN = j)
#dat_avg2 <- as.data.frame(append(dat_avg, actid, after = 1),stringsAsFactors = F) #odd that this gives 268 cols not 89
dataavg2 <- as.data.frame(append(dataavg, list(unlist(actid)), after = 1),stringsAsFactors = F)
datastd2 <- as.data.frame(append(datastd, list(unlist(actid2)), after = 1),stringsAsFactors = F)
colnames(dataavg2)[2] <- "activityname"
colnames(datastd2)[2] <- "activityname"

#append the term 'average' to all the column names ??
k <- function(y) {paste(str_trim(y),"AVERAGE",sep = "")}
l <- function(z) {paste(str_trim(z),"STDEV",sep = "")}
newcolnamesave = lapply(colnames(dataavg2), FUN = k)
newcolnamesstd = lapply(colnames(datastd2), FUN = l)
colnames(dataavg2) <- newcolnamesave
colnames(datastd2) <- newcolnamesstd
colnames(dataavg2)[1] <- "subjectid"
colnames(datastd2)[1] <- "subjectid"
colnames(dataavg2)[2] <- "activityid"
colnames(datastd2)[2] <- "activityid"

final = merge(dataavg2,datastd2,all=TRUE)
write.table(final, file = "testANDtrainMeanANDSTDEV.txt", row.name=F)















