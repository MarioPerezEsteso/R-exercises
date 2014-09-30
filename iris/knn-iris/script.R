require("class")
setwd("~/Dropbox//Documents//COM//ejercicios//R")
source("functions.R")
iris <- read.table("iris/iris.data", header = F, sep = ',')
colnames(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
iris_normalized <- as.data.frame(lapply(iris[1:4], normalize))
iris$Species <- factor(iris$Species, levels = c("Iris-setosa", "Iris-versicolor", "Iris-virginica"), labels = c("Setosa", "Versicolor", "Virginica"))
data <- splitIntoTrainAndTest(iris_normalized, iris["Species"], 0.8)
iris_train_data <- data[[1]]
iris_test_data <- data[[2]]
iris_train_labels <- data[[3]]$Species
iris_test_labels <- data[[4]]$Species
rm(data)
iris_test_prediction <- knn(train = iris_train_data, test = iris_test_data, cl = iris_train_labels, k = 2)
table(iris_test_labels, iris_test_prediction)