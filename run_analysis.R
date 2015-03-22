
# preparing datasets

setwd("D:/Coursera/Getting and Cleaning Data/Project/test")

dane.test <- read.table("X_test.txt",header=FALSE)
labels.test <- read.table("Y_test.txt",header=FALSE)
subject.test <- read.table("subject_test.txt",header=FALSE)

setwd("D:/Coursera/Getting and Cleaning Data/Project/train")

dane.train <- read.table("X_train.txt",header=FALSE)
labels.train <- read.table("Y_train.txt",header=FALSE)
subject.train <- read.table("subject_train.txt",header=FALSE)

setwd("D:/Coursera/Getting and Cleaning Data/Project")

features.names <- read.table("features.txt",header=FALSE)
activity.labels <- read.table("activity_labels.txt",header=FALSE)

names(dane.test) <- t(t(features.names[,2]))
names(dane.train) <- t(t(features.names[,2]))

dane.test$CzyTestowy <- 1
dane.train$CzyTestowy <- 0

dane.test[,"Subject"] <- subject.test
dane.train[,"Subject"] <- subject.train

dane.test[,"Activity"] <- labels.test
dane.train[,"Activity"] <- labels.train

# 1: Merges the training and the test sets to create one data set.

dane <- rbind(dane.test,dane.train)


for (i in 1:6) {
  dane[dane$Activity==i,"ActivityDescription"] <- activity.labels[activity.labels[,1]==i,2]
}

for (j in 1:30) {
  dane[dane$Subject==j,"SubjectDescrition"] <- paste("Subject no",j)
}

# 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

names.chosen <- names(dane)[(grepl("mean",names(dane))==TRUE | grepl("std()",names(dane))==TRUE) & grepl("meanFreq",names(dane))==FALSE]
# names only this with mean and std but without meanFreq

final.data <- dane[,c("SubjectDescrition","ActivityDescription",names.chosen)]

final.data

# 3: Uses descriptive activity names to name the activities in the data set

# !!! activities were renamed earlier

table(final.data$ActivityDescription)

# 4: Appropriately labels the data set with descriptive variable names.

column.names <- names(final.data)

for (k in 1:length(column.names)) {
  column.names[k] = gsub("\\()","",column.names[k])
  column.names[k] = gsub("-std()","_StdDev",column.names[k])
  column.names[k] = gsub("-mean()","_Mean",column.names[k])
  column.names[k] = gsub("^(t)","time",column.names[k])
  column.names[k] = gsub("^(f)","FFT",column.names[k])
  column.names[k] = gsub("Acc","Acceleration",column.names[k])
  column.names[k] = gsub("Mag","Magnitude",column.names[k])
}

names(final.data) <- column.names

# 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

by1 <- names(table(final.data$ActivityDescription))
by2 <- sort(names(table(final.data$SubjectDescrition)))

aggregate(x = final.data, by = list(by1, by2), FUN = "mean")

group <- aggregate(x = final.data, by = list(final.data$ActivityDescription,final.data$SubjectDescrition), FUN = "mean")

names(group)[1] <- "ActivityDescription_Group"
names(group)[2] <- "SubjectDescrition_Group"

tidy.dataset <- group[,-c(3,4)]

write.table(tidy.dataset,"tidy_dataset.txt",row.names=FALSE)



