getNCleanDataCrsProj
====================
Course Project Repo for "Getting and Cleaning Data"
===================================================
The run_analysis.R script in this repo is designed to operate on the Samsung data set (see the README from that data set at the bottom of this file including the license info for use of that data).  The script loads the "stringr" package as its "str_trim" function will be used later.  It then reads in the "features.txt" file of the data set and performs a gsub on the column with the feature names to convert them all to lower case and remove any non-alphanumeric characters for ease of regex application and to prevent typos.  The x,y, and subject files for the test and train file sets are then loaded using read.table with column names assigned manually or using the lower case version of the feature names from the features.txt file.  The data frames from the reading in of the x,y, and subject files are then combined using cbind resulting in 2 dataframes, one for the test data and one for the train data.  These 2 data frames are then merged using merge and the setting "all=T" to ensure that all elements from both tables are captured.  Then using grepl, the feature names are identified that contain the terms "mean" or "std" and merged into a single dataframe.  The feature numbers which are equivalent to the column numbers in the merged test/train data frame for the mean/std columns are then increased by 2 to account for the 2 columns that were cbinded in earlier: label and subject.  These adjusted numbers are then combined into a vector with the numbers 1 and 2 at the beginning of the vector.  This will then be used to subset the columns of the merged dataset so that only the desired columns pertaining to means or standard deviations and the activity id and label remain.  Some memory cleanup is then conducted on unneeded variables.  



CODEBOOK
> names(final)
  [1] "subjectid"                                "activityid"                               "activityidAVERAGE"                       
  [4] "tbodyaccmeanxAVERAGE"                     "tbodyaccmeanyAVERAGE"                     "tbodyaccmeanzAVERAGE"                    
  [7] "tbodyaccstdxAVERAGE"                      "tbodyaccstdyAVERAGE"                      "tbodyaccstdzAVERAGE"                     
 [10] "tgravityaccmeanxAVERAGE"                  "tgravityaccmeanyAVERAGE"                  "tgravityaccmeanzAVERAGE"                 
 [13] "tgravityaccstdxAVERAGE"                   "tgravityaccstdyAVERAGE"                   "tgravityaccstdzAVERAGE"                  
 [16] "tbodyaccjerkmeanxAVERAGE"                 "tbodyaccjerkmeanyAVERAGE"                 "tbodyaccjerkmeanzAVERAGE"                
 [19] "tbodyaccjerkstdxAVERAGE"                  "tbodyaccjerkstdyAVERAGE"                  "tbodyaccjerkstdzAVERAGE"                 
 [22] "tbodygyromeanxAVERAGE"                    "tbodygyromeanyAVERAGE"                    "tbodygyromeanzAVERAGE"                   
 [25] "tbodygyrostdxAVERAGE"                     "tbodygyrostdyAVERAGE"                     "tbodygyrostdzAVERAGE"                    
 [28] "tbodygyrojerkmeanxAVERAGE"                "tbodygyrojerkmeanyAVERAGE"                "tbodygyrojerkmeanzAVERAGE"               
 [31] "tbodygyrojerkstdxAVERAGE"                 "tbodygyrojerkstdyAVERAGE"                 "tbodygyrojerkstdzAVERAGE"                
 [34] "tbodyaccmagmeanAVERAGE"                   "tbodyaccmagstdAVERAGE"                    "tgravityaccmagmeanAVERAGE"               
 [37] "tgravityaccmagstdAVERAGE"                 "tbodyaccjerkmagmeanAVERAGE"               "tbodyaccjerkmagstdAVERAGE"               
 [40] "tbodygyromagmeanAVERAGE"                  "tbodygyromagstdAVERAGE"                   "tbodygyrojerkmagmeanAVERAGE"             
 [43] "tbodygyrojerkmagstdAVERAGE"               "fbodyaccmeanxAVERAGE"                     "fbodyaccmeanyAVERAGE"                    
 [46] "fbodyaccmeanzAVERAGE"                     "fbodyaccstdxAVERAGE"                      "fbodyaccstdyAVERAGE"                     
 [49] "fbodyaccstdzAVERAGE"                      "fbodyaccmeanfreqxAVERAGE"                 "fbodyaccmeanfreqyAVERAGE"                
 [52] "fbodyaccmeanfreqzAVERAGE"                 "fbodyaccjerkmeanxAVERAGE"                 "fbodyaccjerkmeanyAVERAGE"                
 [55] "fbodyaccjerkmeanzAVERAGE"                 "fbodyaccjerkstdxAVERAGE"                  "fbodyaccjerkstdyAVERAGE"                 
 [58] "fbodyaccjerkstdzAVERAGE"                  "fbodyaccjerkmeanfreqxAVERAGE"             "fbodyaccjerkmeanfreqyAVERAGE"            
 [61] "fbodyaccjerkmeanfreqzAVERAGE"             "fbodygyromeanxAVERAGE"                    "fbodygyromeanyAVERAGE"                   
 [64] "fbodygyromeanzAVERAGE"                    "fbodygyrostdxAVERAGE"                     "fbodygyrostdyAVERAGE"                    
 [67] "fbodygyrostdzAVERAGE"                     "fbodygyromeanfreqxAVERAGE"                "fbodygyromeanfreqyAVERAGE"               
 [70] "fbodygyromeanfreqzAVERAGE"                "fbodyaccmagmeanAVERAGE"                   "fbodyaccmagstdAVERAGE"                   
 [73] "fbodyaccmagmeanfreqAVERAGE"               "fbodybodyaccjerkmagmeanAVERAGE"           "fbodybodyaccjerkmagstdAVERAGE"           
 [76] "fbodybodyaccjerkmagmeanfreqAVERAGE"       "fbodybodygyromagmeanAVERAGE"              "fbodybodygyromagstdAVERAGE"              
 [79] "fbodybodygyromagmeanfreqAVERAGE"          "fbodybodygyrojerkmagmeanAVERAGE"          "fbodybodygyrojerkmagstdAVERAGE"          
 [82] "fbodybodygyrojerkmagmeanfreqAVERAGE"      "angletbodyaccmeangravityAVERAGE"          "angletbodyaccjerkmeangravitymeanAVERAGE" 
 [85] "angletbodygyromeangravitymeanAVERAGE"     "angletbodygyrojerkmeangravitymeanAVERAGE" "anglexgravitymeanAVERAGE"                
 [88] "angleygravitymeanAVERAGE"                 "anglezgravitymeanAVERAGE"                 "activityidSTDEV"                         
 [91] "tbodyaccmeanxSTDEV"                       "tbodyaccmeanySTDEV"                       "tbodyaccmeanzSTDEV"                      
 [94] "tbodyaccstdxSTDEV"                        "tbodyaccstdySTDEV"                        "tbodyaccstdzSTDEV"                       
 [97] "tgravityaccmeanxSTDEV"                    "tgravityaccmeanySTDEV"                    "tgravityaccmeanzSTDEV"                   
[100] "tgravityaccstdxSTDEV"                     "tgravityaccstdySTDEV"                     "tgravityaccstdzSTDEV"                    
[103] "tbodyaccjerkmeanxSTDEV"                   "tbodyaccjerkmeanySTDEV"                   "tbodyaccjerkmeanzSTDEV"                  
[106] "tbodyaccjerkstdxSTDEV"                    "tbodyaccjerkstdySTDEV"                    "tbodyaccjerkstdzSTDEV"                   
[109] "tbodygyromeanxSTDEV"                      "tbodygyromeanySTDEV"                      "tbodygyromeanzSTDEV"                     
[112] "tbodygyrostdxSTDEV"                       "tbodygyrostdySTDEV"                       "tbodygyrostdzSTDEV"                      
[115] "tbodygyrojerkmeanxSTDEV"                  "tbodygyrojerkmeanySTDEV"                  "tbodygyrojerkmeanzSTDEV"                 
[118] "tbodygyrojerkstdxSTDEV"                   "tbodygyrojerkstdySTDEV"                   "tbodygyrojerkstdzSTDEV"                  
[121] "tbodyaccmagmeanSTDEV"                     "tbodyaccmagstdSTDEV"                      "tgravityaccmagmeanSTDEV"                 
[124] "tgravityaccmagstdSTDEV"                   "tbodyaccjerkmagmeanSTDEV"                 "tbodyaccjerkmagstdSTDEV"                 
[127] "tbodygyromagmeanSTDEV"                    "tbodygyromagstdSTDEV"                     "tbodygyrojerkmagmeanSTDEV"               
[130] "tbodygyrojerkmagstdSTDEV"                 "fbodyaccmeanxSTDEV"                       "fbodyaccmeanySTDEV"                      
[133] "fbodyaccmeanzSTDEV"                       "fbodyaccstdxSTDEV"                        "fbodyaccstdySTDEV"                       
[136] "fbodyaccstdzSTDEV"                        "fbodyaccmeanfreqxSTDEV"                   "fbodyaccmeanfreqySTDEV"                  
[139] "fbodyaccmeanfreqzSTDEV"                   "fbodyaccjerkmeanxSTDEV"                   "fbodyaccjerkmeanySTDEV"                  
[142] "fbodyaccjerkmeanzSTDEV"                   "fbodyaccjerkstdxSTDEV"                    "fbodyaccjerkstdySTDEV"                   
[145] "fbodyaccjerkstdzSTDEV"                    "fbodyaccjerkmeanfreqxSTDEV"               "fbodyaccjerkmeanfreqySTDEV"              
[148] "fbodyaccjerkmeanfreqzSTDEV"               "fbodygyromeanxSTDEV"                      "fbodygyromeanySTDEV"                     
[151] "fbodygyromeanzSTDEV"                      "fbodygyrostdxSTDEV"                       "fbodygyrostdySTDEV"                      
[154] "fbodygyrostdzSTDEV"                       "fbodygyromeanfreqxSTDEV"                  "fbodygyromeanfreqySTDEV"                 
[157] "fbodygyromeanfreqzSTDEV"                  "fbodyaccmagmeanSTDEV"                     "fbodyaccmagstdSTDEV"                     
[160] "fbodyaccmagmeanfreqSTDEV"                 "fbodybodyaccjerkmagmeanSTDEV"             "fbodybodyaccjerkmagstdSTDEV"             
[163] "fbodybodyaccjerkmagmeanfreqSTDEV"         "fbodybodygyromagmeanSTDEV"                "fbodybodygyromagstdSTDEV"                
[166] "fbodybodygyromagmeanfreqSTDEV"            "fbodybodygyrojerkmagmeanSTDEV"            "fbodybodygyrojerkmagstdSTDEV"            
[169] "fbodybodygyrojerkmagmeanfreqSTDEV"        "angletbodyaccmeangravitySTDEV"            "angletbodyaccjerkmeangravitymeanSTDEV"   
[172] "angletbodygyromeangravitymeanSTDEV"       "angletbodygyrojerkmeangravitymeanSTDEV"   "anglexgravitymeanSTDEV"                  
[175] "angleygravitymeanSTDEV"                   "anglezgravitymeanSTDEV"







Below the following double line is the README.txt from the original Samsung data set, which is included primarily for provenance and license info.
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

