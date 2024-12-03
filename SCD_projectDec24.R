#load packages
install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("ggplot2")
install.packages("RColorBrewer")
#install.packages("textreadr")
install.packages("readtext")


# Load libraries
library(tm)
library(SnowballC)
library(wordcloud)
library(ggplot2)
library(RColorBrewer)
library(readtext)

# Select a file interactively
file_path <- file.choose()

# Read the Word file
doc_text <- readtext(file_path)

# Display the content of the Word file
print(doc_text$text)

#rename text doc
clinical_notes <- doc_text

# Create a text corpus
corpus <- Corpus(VectorSource(clinical_notes))

# Preprocess text
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

# Create a term-document matrix
tdm <- TermDocumentMatrix(corpus)
tdm_matrix <- as.matrix(tdm)

# Word Cloud
word_freq <- sort(rowSums(tdm_matrix), decreasing = TRUE)
wordcloud(names(word_freq), freq = word_freq, min.freq = 2, colors = brewer.pal(8, "Dark2"))
