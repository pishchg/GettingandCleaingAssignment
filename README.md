# GettingandCleaingAssignment

This scipt was written as an assignment for Getting and Cleaning Data Coursera Course.


To describe the input data, it is easiest to quote directly from the readme.txt file provided with the data:

'The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. '

In this repo I am including a script that can be used to:
1. Download the data from a web-site.
2. Load the contents of numerous separate files into R.
3. Combine the data in various files into a meaningful data frame.
4. Analyze the dataframe to acquire means for each numerical variable grouped by categorical variables (activity and subject).

I find it much easier to provide a detailed desciption the steps of the data analyses in the script.
See run_analysis.R to see the script with explanations and code_book.pdf for information on variables.

