## Lisa Nelson
## Getting and Cleaning Data
## Course Project
## January, 2016

#setwd("C:/Users/Lisa/Documents/Coursera/Getting and Cleaning Data")
#load required libraries
library(dplyr)
library(data.table)  

#Read in train. Columns do not contain names in header.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

#Read in test. Columns do not contain names in header.
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#Create meaningful names for key columns y and subject  
names(y_train) <- "Activity"
names(y_test) <- "Activity"
names(subject_test) <- "SubjectID"
names(subject_train) <- "SubjectID"

#pull together
## Pull the each of the train and test data sets together by column using cbind
## Combine the test and train datasets using rbind
big_train <-     cbind(y_train, subject_train, x_train)
big_test <-      cbind(y_test, subject_test, x_test)
combined_data <- rbind(big_train, big_test)

#Get column names from features.txt
#Get rid of special chars that break computations and some basic substitutions to make more readable
colnames <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
colnames [,2]  <- gsub("-", "",  (colnames [,2])  )
colnames [,2]  <- gsub("\\(", "",  (colnames [,2])  )
colnames [,2]  <- gsub("\\)", "",  (colnames [,2])  )
colnames [,2]  <- gsub(",", "",  (colnames [,2])  )
colnames [,2]  <- gsub("^t", "time",  (colnames [,2])  )    
colnames [,2]  <- gsub("^f", "FFT",  (colnames [,2])  )

#Rename columns with modified names from features.txt, drop columns with duplicate names.  (They are not needed)
names (combined_data)[3:563] <- sprintf( as.character(colnames[1:561,2]) )
combined_data <- combined_data[ !duplicated(names(combined_data)) ]

#Create tidy set with just Activity, SubjectID and mean & std columns
tidy_set1 = select(combined_data, Activity, SubjectID, matches("(mean|std)")) 

#Write out a text file with first tidy data set
write.table(tidy_set1, file="./tidyset.txt", row.names=FALSE)

#Create averages for each variable by activity and subject.  Use wide format.  
ts2 <- as.data.table(tidy_set1) %>%
       melt(id=(1:2), measure=(3:72))  %>%
       dcast(SubjectID+Activity  ~ variable, mean)

#Substitute Activity numbers with names from activity_labels.txt
activitymap = read.table("./UCI HAR Dataset/activity_labels.txt", sep="", col.names = c("Activity", "ActivityName"))
tidy_set2 <- merge(ts2, activitymap, by.x="Activity" , by.y="Activity", all=TRUE ) %>%
             select (SubjectID, ActivityName, timeBodyAccmeanX:FFTBodyAccMagmeanFreq )

#Write out a text file with second tidy data set in wide format
write.table(tidy_set2, file="./tidyset2.txt", row.names=FALSE)

##test the read
#file_path <- "./tidyset2.txt"
#data <- read.table(file_path, header = TRUE) 

