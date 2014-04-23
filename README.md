Getting-and-Cleaning-Data
=========================
Online Data Course by John Hopkins Bloomberg School of Public Health


The R script `run_analysis.R` reads the datasets from the "test/" and "train/" folders.  
It combines and appends the datasets then subsets the desired mean and standard deviation variables. The script then takes the average of variables in the data subset for each subject and activity. The script then outputs an independent `tidy` dataset with comma separated values.