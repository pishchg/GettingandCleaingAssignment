
#First, acquire the data and unzip it.

url<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, dest='data.zip', method='curl')
unzip('data.zip')

# Load every file that's necessary:

##The next two files actually contain the data. The rest of the files help
##identify them. I will refer to these two as 'the master files'. There are two 
##of them because the researchers split the data to perform machine learning 
##experiments. We have other goals so we will later combine the two into one 
##later.

setwd("./UCI HAR Dataset")

#Test data
test<-read.table('./test/X_test.txt')

#Training data
train<-read.table('./train/X_train.txt')

#Remaining files:
#List of measurements performed (or calculated). These are listed in the same 
#order as the columns (variables) in the 'master files'. They are 
#basically the names of the variables. 
measurements<-as.vector(read.table('features.txt', colClasses = c('NULL', 
                                                                  'character')))

#The following two files contain vectors with IDs of subjects performing the
##activities. They are in the same order as observations (rows).
test_subjects<-read.table('./test/subject_test.txt')
train_subjects<-read.table('./train/subject_train.txt')

#The following two files contain codes of activities performed.
## They are in the same order as observations (rows)
test_activity<-read.table('./test/y_test.txt')
train_activity<-read.table('./train/y_train.txt')

##This file matches the activity with the code used.
activity_labels<-read.table('activity_labels.txt')


#Now that we have all the data loaded, first we will combine training and test
#data. That will satisfy assignment 1.
data<-rbind(train, test)

#As it turned out, some of the variable names (listed in 'measurements) are
#duplicated
sum(duplicated(measurements))

#Looking at the data closer I realized that although the names are duplicated
#the data are not (i.e. the readings in columns with the same name are different).
#To give duplicated names unique identifiers, I will add '1' at the end.
measurements[duplicated(measurements),]<-paste(measurements[duplicated
                                                            (measurements),], 1)

#That takes care of some, but not all of them, because some actually where
#'triplicated' (is that a word?)
sum(duplicated(measurements))

#I'll add another '1' at the end of these.
measurements[duplicated(measurements),]<-paste(measurements[duplicated
                                                            (measurements),], 1)
sum(duplicated(measurements))


#Now I will assign the the names to the variables. Note, that I decided against
#changing variable names. There are more than 500 of them. Changing them 
#one-by-one is too much work. Changing them in bulk is  likely to generate 
#undetected errors. That
names(data)<-measurements[[1]]

#Calculate means and standard deviation for each variable (assignment 2).
means<-colMeans(data)
sapply(data, sd)


# Now combine the vectors containing subject ID numbers. . Because these are
#anonymous, I will keep their ID numbers and convert them to factors.

subjectID<-rbind(train_subjects, test_subjects)
subjectID[[1]]<-as.factor(as.numeric(subjectID[[1]]))


#Combine activities and create a table which matches activity code for each
## observation with the desciptive name of the activity.
activity<-rbind(train_activity, test_activity)
activity<-merge(activity, activity_labels, sort=F)

##This following step adds subjectID and descriptive activity names to each 
##observation (assignment 3)
data<-cbind(subjectID, activity[2], data )

library(dplyr)

##Now give names to these new variables (assignment 4)
data<-rename(data, subjectID=V1, activity=V2)


##Finally, calculate means of each of the measurements separately for each
##activity and subject performing this activity. These are organized and tidy.
## We have one variable per column (activity, subject ID etc.) and each variable
##contains only one type of observation.
data<-tbl_df(data)

final_table<-data%>%group_by(activity, subjectID)%>%
        summarise_each(funs(mean))

##Save the resulting table in a .txt file
write.table(final_table, file='tidy_averages.txt', row.names=F)
