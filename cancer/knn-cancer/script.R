require("class")
setWorkingDir(path)
source("functions.R")
cancer <- read.csv("cancer/cancerData.csv", stringsAsFactors = F, header = T)
cancer <- cancer[-1] # Delete id column
cancer$diagnosis <- factor(cancer$diagnosis, levels = c("B", "M"), labels = c("Benign", "Malignant"))
# Apply normalize function to columns from 2 to 31
cancer_normalized <- as.data.frame(lapply(cancer[2:31], normalize))
# Split data into train and test
data <- splitIntoTrainAndTest(cancer_normalized, cancer["diagnosis"], 0.8)
cancer_train_data <- data[[1]]
cancer_test_data <- data[[2]]
cancer_train_labels <- data[[3]]$diagnosis
cancer_test_labels  <- data[[4]]$diagnosis
rm(data)
cancer_test_prediction <- knn(train = cancer_train_data, test = cancer_test_data, cl = cancer_train_labels, k = 21)
table(cancer_test_labels, cancer_test_prediction)