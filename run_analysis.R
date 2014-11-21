run_analysis <- function() {
    
    ## Load data
    SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
    SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
    XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    YTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
    YTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
    
    XTotal <- rbind(XTest, XTrain)
    YTotal <- rbind(YTest, YTrain)
    SubjectTotal <- rbind(SubjectTest, SubjectTrain)
    
    ## Add column names 
    names <- read.table("UCI HAR Dataset/features.txt")
    colnames(XTotal) <- names[,2]
    colnames(SubjectTotal) <- c("subject")
    colnames(YTotal) <- c("activity")
    
    ## Add columns for Y and subject data, step 1 complete
    untidyOne <- cbind(XTotal, YTotal, SubjectTotal)
    
    ## select onlu mean and std columnd, step 2 complete
    meanOnly <- untidyOne[,grepl("mean", colnames(untidyOne))]
    stdOnly <- untidyOne[,grepl("std", colnames(untidyOne))]
    meanandstd <- cbind(meanOnly, stdOnly)
    
    ## Replace values in YTotal with activity text
    YTotal$activity[YTotal$activity == 1] <- "WALKING"
    YTotal$activity[YTotal$activity == 2] <- "WALKING_UPSTAIRS"
    YTotal$activity[YTotal$activity == 3] <- "WALKING_DOWNSTAIRS"
    YTotal$activity[YTotal$activity == 4] <- "SITTING"
    YTotal$activity[YTotal$activity == 5] <- "STANDING"
    YTotal$activity[YTotal$activity == 6] <- "LAYING"
    
    ## add the activity and subject columns back, step 3 complete
    meanandstd <- cbind(meanandstd, YTotal, SubjectTotal)
    
    ## rename to valid columns, step 4 complete
    validNames <- make.names(colnames(meanandstd), unique = TRUE)
    colnames(meanandstd) <- validNames
    
    ## Convert to data.table and group
    msDT <- data.table(meanandstd)
    setkey(msDT, subject, activity)
    
    ## nice and tidy, step 5 complete
    tidy <- msDT[,lapply(.SD, mean), by=list(subject,activity)]
    
    ## write to working directory
    write.table(tidy, "tidydata.txt", row.names=FALSE)
    return(tidy)
}