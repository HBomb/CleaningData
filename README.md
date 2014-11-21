CleaningData
============

Class project for Getting and Cleaning Data

The R script follows the steps giving in the class project instructions. It loads the various data files and combines them into one data set.

From there it selects only the mean and std columns, adds columns names, replaces the activity column values with the matching text, then finally converts the data frame to a data.table and groups by subject and activity.

The tidy data is written to a text file in the current working directory and the function exits.

