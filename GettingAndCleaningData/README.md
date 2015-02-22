README for run_analysis.R

This script will load the required files from the UCI HAR Dataset. The files are expected to be in a subfolder of the working directory, called UCI HAR Dataset.

The structure of this folder is the same as in the zip file that the data comes from, i.e.:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

See http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names for a description of the dataset names.

The script will first load the reshape2 library, as this is used for melt/cast-operations in the script.

All files are loaded, first separately (the train and test versions of the files), and then joined and/or manipulated.

This creates a full set of subjects, activities and measurements. This set is then melted to create a 'long' set.

Then cast is used to recreate a 'wide' set with the means of the values per Subject and Activity 

Finally, a loop is used to add activity names to the final set, and the set is written out to a file.