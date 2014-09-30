library(tm)
library(RWeka)
library(SnowballC)
sms_raw <- read.csv("spam/sms_spam.csv", encoding = "utf-8", stringsAsFactors = FALSE)
str(sms_raw)
# convert spam/ham to factor.
sms_raw$type <- factor(sms_raw$type)

# examine the type variable more carefully
str(sms_raw$type)

table(sms_raw$type)
sms_corpus <- Corpus(VectorSource(sms_raw$text))


corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))

# create a document-term sparse matrix
sms_dtm <- DocumentTermMatrix(corpus_clean)

