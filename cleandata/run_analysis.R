
setwd("C://Documents and Settings\Administrator\×ÀÃæ\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset")
## Load data
data1_labels <- read.table("./test/y_test.txt", col.names="data1_labels")
data1_subjects <- read.table("./test/subject_test.txt", col.names="data1_subjects")
data1_data <- read.table("./test/X_test.txt")
data2_labels <- read.table("./train/y_train.txt", col.names="data2_labels")
data2_subjects <- read.table("./train/subject_train.txt", col.names="data2_subjects")
data2_data <- read.table("./train/X_train.txt")

# Merge the data
data <- rbind(cbind(data1_subjects, data1_labels, data1_data),
              cbind(data2_subjects, data2_labels, data2_data))

# read the features
features <- read.table("./features.txt",sep="")
# only retain features of mean and standard deviation
mean_std <- features[grep("mean\\(\\)|std\\(\\)", features[,2]), ]
data_1<- data[, c(1, 2, mean_std[,1]+2)]

# read the labels (activities)
labels <- read.table("./activity_labels.txt")
# replace labels in data with label names
data_1$label <- labels[data_1$label, 2]

# first make a list of the current column names and feature names
data_colnames <- c("subject", "label", data_1[,2])
# then tidy that list
data_colnames <- tolower(gsub("[^[:alpha:]]", "", data_colnames))
colnames(data_1) <- data_colnames

# find the mean for each combination of subject and label
store_data <- aggregate(data_1[, 3:ncol(data_1)], by=list(subject = data_1$subject, label = data_1$label),
                       mean)
# write the data 
write.table(format(store_data, scientific=T), "tidy_data.txt",
            row.names=FALSE, col.names=FALSE,quote=2)