# How run_Analysis.R is working

If you run the file, it will do the following:

1.	Downloads and unzips file:
   	The data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and 		stored as "HARDataset.zip" in the working directory.
	Afterwards it is unzipped which creates a folder named "HARDataset" which contains the data.

2. 	Reads in data to R:
	The following files are read in:
	** "./HARDataset/UCI HAR Dataset/features.txt": List of value column names for training and test data
	** "./HARDataset/UCI HAR Dataset/activity_labels.txt": List to translate activity number to clear name
	
	** "./HARDataset/UCI HAR Dataset/test/X_train.txt": measured values for training group
	** "./HARDataset/UCI HAR Dataset/test/subject_train.txt": list of subjects(people) that matches with measured values for 		training group
	** "./HARDataset/UCI HAR Dataset/test/y_train.txt": list of activities that matches with measured values for training 			group
	
	** "./HARDataset/UCI HAR Dataset/test/X_test.txt": measured values for testing group
	** "./HARDataset/UCI HAR Dataset/test/subject_test.txt": list of subjects(people) that matches with measured values for 		testing group
	** "./HARDataset/UCI HAR Dataset/test/y_test.txt": list of activities that matches with measured values for testing 			group
	
	Each set for training and testing are completed:
	** The columns are labeled with correct names corresponding to "./HARDataset/UCI HAR Dataset/features.txt"
	** The list of subjects are added
	** The list of activities are added
	
3. 	Merges the training and the test sets to create one data set

4.	Uses descriptive activity names to name the activities in the data set
	For better understanding the activities which up to now are integer values are converted to factors using 			"./HARDataset/UCI HAR Dataset/activity_labels.txt"

5. 	Extracts only the measurements on the mean and standard deviation for each measurement
	The data.frame is reduced to variables which names contain "mean" or "std" and end with ()
	
6. 	A second, independent tidy data set is created with the average of each variable for each activity and each subject
	The tidy data respects the rules for tidy data according to Hadley Wickham (https://www.google.de/url?sa=t&rct=j&q=&		esrc=s&source=web&cd=2&ved=0ahUKEwi_vfXXxd7VAhWGsxQKHaXWBmgQFgguMAE&url=https%3A%2F						%2Fwww.jstatsoft.org%2Farticle%2Fview%2Fv059i10%2Fv59i10.pdf&usg=AFQjCNGJCmyjRW1EPmG-O4BZ6hnwfjxcxA)
	1. Each variable forms a column.
	2. Each observation forms a row.
	3. Each type of observational unit forms a table.
	
7. 	Writes tidy data to txt-File "meanHARData.txt" on the working directory

# Further information on data
For more information about the data, please refer to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and to the README that can be found in "./HARDataset/UCI HAR Dataset" once the data is downloaded and unzipped.

# Read in "meanHARData.txt"
For a correct reading in to R, please use: read.table(file = "./meanHARData.txt", header = TRUE)
