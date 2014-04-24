# Suppress warnings (be cautious about using this)
options(warn = -1)

# Read test files
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

# Features contains the appropriate labels for our dataset
features <- read.table("features.txt")

# Add labels to dataset
names <- levels(features$V2)[features$V2]
names(x_test) <- names
names(y_test) <- c("Activity_Code")
names(subject_test) <- c("Subject")

# Create dataframe of data from Test
sub_y <- cbind(subject_test, y_test)
Activity <- rep("", length(y_test$Activity_Code))
Activity <- as.data.frame(Activity, stringsAsFactors=FALSE)
DF <- cbind(sub_y, Activity, x_test)

# Read train files
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

# Add labels to dataset
names(x_train) <- names
names(y_train) <- c("Activity_Code")
names(subject_train) <- c("Subject")

# Create dataframe of data from Train
t_sub_y <- cbind(subject_train, y_train)
Activity <- rep("", length(y_train$Activity_Code))
Activity <- as.data.frame(Activity, stringsAsFactors=FALSE)
DF2 <- cbind(t_sub_y, Activity, x_train)

# Combine the two datasets
appended_DF <- rbind(DF, DF2)

# What we want are the data regarding standard deviation and mean
# Grep provides a way to grab these data
std_pos <- grep("std\\(\\)",names(appended_DF))
mean_pos <- grep("mean\\(\\)",names(appended_DF))

# Create a new dataframe of the desired variables
mean_std_DF <- appended_DF[,sort(c(1:3,std_pos, mean_pos))]
mean_std_DF <- mean_std_DF[order(mean_std_DF$Subject, mean_std_DF$Activity_Code),]

# Turn Subject and Activity Code to factor variables
mean_std_DF$Subject <- factor(mean_std_DF$Subject)
mean_std_DF$Activity_Code <- factor(mean_std_DF$Activity_Code)

# Create as base table to append data to
extra <- as.table(sapply(mean_std_DF[(factor(mean_std_DF$Subject)==1 & factor(mean_std_DF$Activity_Code)==1),], mean))

# loops through all the data to grab the mean for the results for each 
# subject in each activity
for(id in levels(mean_std_DF$Subject)){
    for(A_C in levels(mean_std_DF$Activity_Code)){
      subset <- as.table(sapply(mean_std_DF[(factor(mean_std_DF$Subject)== as.integer(id) & factor(mean_std_DF$Activity_Code)==as.integer(A_C)),],mean))
      subset[1:2] <- c(as.integer(id), as.integer(A_C))
      extra <- rbind(extra, subset)
    } 
}

# Turn table into a dataframe
tidy <- as.data.frame(extra)

# Gets rid of the base row we first started with
tidy <- tidy[-1,]

# Tidy up the labels and add activity character vecter
row.names(tidy) <- 1:length(tidy$Subject)
tidy$Activity[tidy$Activity_Code == 1] <- "WALKING"
tidy$Activity[tidy$Activity_Code == 2] <- "WALKING_UPSTAIRS"
tidy$Activity[tidy$Activity_Code == 3] <- "WALKING_DOWNSTAIRS"
tidy$Activity[tidy$Activity_Code == 4] <- "SITTING"
tidy$Activity[tidy$Activity_Code == 5] <- "STANDING"
tidy$Activity[tidy$Activity_Code == 6] <- "LAYING"

# Updates column names
names(tidy) <- gsub(pattern="\\(\\)",replacement="",x=names(tidy))

# Writes data frame as a `Tidy` text file with comma separated values
write.table(tidy, file = "tidy.txt", sep = ",", col.names = colnames(tidy))