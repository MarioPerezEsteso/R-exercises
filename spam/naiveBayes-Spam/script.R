# install.packages('tm')
library(tm)
library(wordcloud)
setwd("~/Dropbox//Documents//COM//ejercicios//R")
source("functions.R")
spamLog <- read.csv("spam/sms_spam.csv", stringsAsFactors = FALSE)
# Convert type into factors "ham" and "spam"
spamLog$type <- factor(spamLog$type)
# Creating a corpus of text messages
spamCorpus <- Corpus(VectorSource(spamLog$text))
# UpperCase to Lower case
cleanCorpus <- tm_map(spamCorpus, content_transformer(tolower))
cleanCorpus <- tm_map(cleanCorpus, content_transformer(removeNumbers))
cleanCorpus <- tm_map(cleanCorpus, content_transformer(removeWords), stopwords())
cleanCorpus <- tm_map(cleanCorpus, content_transformer(removePunctuation))
cleanCorpus <- tm_map(cleanCorpus, content_transformer(stripWhitespace))
spamTermMatrix <- TermDocumentMatrix(cleanCorpus)

spamRawTrain <- spamLog[1:4169, ]
spamRawTest <- spamLog[4170:5559, ]
spamTermMatrixTrain <- spamTermMatrix[1:4169, ]
spamTermMatrixTest <- spamTermMatrix[4170:5559, ]
spamCorpusTrain <- cleanCorpus[1:4169]
spamCorpusTest <- cleanCorpus[4170:5559]

# Creating a dictionary after removing words which appear less than 5 times
freqTerms <- findFreqTerms(spamTermMatrixTrain, 5)

spamTrain <- DocumentTermMatrix(spamCorpusTrain, list(dictionary = freqTerms))
spamTest <- DocumentTermMatrix(spamCorpusTest, list(dictionary = freqTerms))

convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
  return(x)
}

spamTrain <- apply(spamTrain, MARGIN = 2, convert_counts)
spamTest <- apply(spamTest, MARGIN = 2, convert_counts)

# Training Naive Bayes model on the data
library(e1071)
spamClassifier <- naiveBayes(spamTrain, spamRawTrain$type)

# Evaluating model performance
spamTestPred <- predict

# Improving model performance with Laplace = 1
spamClassifier2 <- naiveBayes(spamTrain, spamRawTrain$type, laplace = 1)
spamTestPred2 <- predict(spamClassifier2, spamTest)

table(spamRawTest$type, spamTestPred2)
