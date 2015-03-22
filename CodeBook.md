
# Code book

This is the code book for the course project

# Study design
I collected the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
You can read more about the data from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Code book

dane.test - data from 'test/X_test.txt': Test set.\
labels.test - data from 'test/y_test.txt': Test labels.
subject.test - data from 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


dane.train - data from 'train/X_train.txt': Training set.
labels.train - data from 'train/y_train.txt': Training labels.
subject.train - data from 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

features.names - data from 'features.txt': List of all features.
activity.labels - data from 'activity_labels.txt': Links the class labels with their activity name.

dane - merge data - test and train set together

names.chosen - names of variables that has mean and std in name (represents the mean and standard deviation) - but not meanFreq
final.data - final data - all cases but as variables we take only names.chosen and Subject and Activities

column.names - changed column name (more description than earlier)
by1 - temporary variable
by2 - temporary variable
i,j,k - temporary variable

group - almost tidy data
tidy.dataset - final tidy dataset with averages of the variables that we had to show in the groups of Activities and Subjects 
