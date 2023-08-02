# datasciencecoursera
Used for Coursera courses

In this repo you will find all the source files, as well as my script for this project.

Provided files:

* activity_labels.txt:  Contains the code for each activity measured  
* features.txt:  Contains the list of all the variables in the X_test and X_train files  
* features_info:  Discusses the variables in the data set and what they are  
* subject_test:  Contains the subject numbers for all the variables in test group  
* Subject_train:  Contains the subject numbers for all the variables in train group  
* X_test:  Contains the subject measurements for all the variables from the test group  
* X_train:  Contains the subject measurements for all the variables from the train group  
* y_test:  Contains the codes for the activities of each of the subjects in the test group  
* y_train: Contains the codes for the activities of each of the subjects in the train group

These files were used to generate the run_analysis.R program and create the Activity_Means.csv file.

The R file inputs the data from the eight files above and then provides in the produced CSV file the average of each variable by subject and activity.  Only the variables in the original data set which were means or standard deviations were included.  

All the details about the project and r script can be found in the Codebook.rmd file.

