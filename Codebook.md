Codebook
========================================================

### Data  

The dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone. There are 30 subjects, each doing 6 different activities. The measured variables pertain to body acceleration and orientation. The front of each variable is denoted with either a `t` or a `f`, with `t` representing time and `f` representing frequency. XYZ attached to some ends of variables denotes axial signals in different directions. More detailed information can be found from the `features_info.txt` file.
-----
### Script

Warnings were turned off for more os a clean run.  
The warnings pertained to taking the mean of a character vector that took place.  
The dataframes were created through a series of column binding and row binding.  
Factors were added to Subject and Activity_Code to make it easier to implement  
a `for` loop to calculate the mean of each subject's activity's data.  
The final product is an independent "tidy" dataset of the values written in a `.txt` extension with comma separated values.

The labels in the tidy dataset remain that of those of the original as I could not fully comprehend what each variable truly meant.
