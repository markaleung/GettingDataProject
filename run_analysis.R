activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
meanStd <- grepl("mean()", features$V2, fixed = TRUE) | grepl("std()", features$V2, fixed = TRUE)

getAggTable <- function(folder){
	y_test <- read.table(paste0(folder, "/y_", folder, ".txt"))
	y_test <- sapply(y_test, function(x) activity_labels[x,2])
	subject_test <- read.table(paste0(folder, "/subject_", folder, ".txt"))
	aggTable <- data.frame(Activity = y_test[,1], Subject = as.factor(subject_test$V1))	
}

getDataTable <- function(folder) {
	x_test <- read.table(paste0(folder, "/X_", folder, ".txt"))
	x_test <- x_test[,meanStd]
	names(x_test) <- features[meanStd,"V2"]
	x_test
}
activityAndSubject <- rbind(getAggTable("train"), getAggTable("test"))
measurementData <- rbind(getDataTable("train"), getDataTable("test"))
tidyTable <- aggregate(measurementData, activityAndSubject, mean)
write.table(tidyTable, file = "tidy data.txt", sep = "\t", quote = FALSE, row.names = FALSE)
