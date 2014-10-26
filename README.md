# Readme file for run_analysis.R

## Variables that are common to the data set

activity labels reads in the activity labels that correspond to the numerical activity labels in the Y\_test or Y\_train data set. Column 2 contains the label. 

features reads in the feature labels, that name the different columns  in X\_test or X\_train data sets. Column V2 contains the feature labels. 

meanStd uses two grep searches to pick out only the labels in features that contain "mean()" or that contain "std()". These features contain the mean and the standard deviation for a given signal. 

## getAggTable

This function takes in a folder as an argument, either "test" or "train". I use a paste0 to insert the folder into the path to read the files. 

y_test reads in the list of activity labels for the data set from file. 

I used an sapply to take each value in y_test (1 to 6) and pick out the corresponding activity label in activity\_labels, so that the activities would consist of descriptive names rather than numbers. 

subject_test reads in the list of subject numbers for the data set from file. 

The function returns a new data frame (aggTable) that contains the list of Activity (from y\_test) and Subject (from subject\_test) labels for the data set. 

## getDataTable

This function takes in a folder as an argument, either "test" or "train". I use a paste0 to insert the folder into the path to read the files. 

x_test reads in the measurement data for the data set from file. 

I use meanStd to filter the data columns that contain mean and standard deviation data. 

I then assign the filtered feature labels (from features) to the column names in x_test. 

The function returns the filtered data with column names. 

## Merging the test and train data sets. 

activityAndSubject uses rbind to produce a single table of activity and subject data from the test and train folders. 

measurementData uses rbind to produce a single table of measurement data from the test and train folders. 

I use the aggregate function to take measurementData, group it by every unique combination of activity and subject in activityAndSubject, and apply the mean function to each group of data (there is a separate mean for each column in measurementData). 

I then write the resulting tidyTable to file, using a tab (\t) as a separator so it is easy to read in excel, and removing quotes from factor variables. 
