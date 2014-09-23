path <- "path/to/R/folder/examples"

normalize <- function (x) {
  return ((x - min(x))/(max(x)-min(x)))
}

# Returns train and test data. Also train and test results
splitIntoTrainAndTest <- function (data, labels, probBinomTrain = 0.9) {
  useForTrain <- rbinom(n=dim(data)[[1]], size=1, probBinomTrain)>0
  train_data <- data.frame(subset(data,useForTrain))
  test_data <- data.frame(subset(data,!useForTrain))
  outcome_train_labels <- data.frame(subset(labels,useForTrain))
  outcome_test_labels <- data.frame(subset(labels,!useForTrain))
  myData <- list(train_data, test_data, outcome_train_labels, outcome_test_labels)
  return (myData)
}

setWorkingDir <- function(path) {
  setwd(path)
}