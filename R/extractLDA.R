library(topicmodels)
library(tidytext)

extractLDA <- function (
    model,
    meta,
    doc_col = 'text',
    n_words=10,
    n_docs=4
    ) {

  n_topics <- model@k
  tms <- as.data.frame(topicmodels::terms(model, n_words))

  model_gamma <- tidytext::tidy(model, matrix = "gamma")

  topics_gamma <- data.frame(as.data.frame(model@documents), as.data.frame(model@gamma))
  topic_vec <- paste("Topic", 1:n_topics, sep = " ")
  names(topics_gamma) <- c("id", topic_vec)

  meta$id <- c(paste('text', 1:nrow(meta), sep=''))
  meta_topics <- merge(meta, topics_gamma, all.x = T, by = "id")

  alabel = c()
  for (i in 1:n_docs){alabel = c(alabel, paste('document_', i, sep = ''))}
  header = c('nr', 'name', 'prevalence', 'top_terms', alabel, 'label', 'trash')

  df <- data.frame()
  num <- 1
  for (topic in topic_vec) {
    prev <- mean(meta_topics[[topic]])
    top_w <- paste(tms[[topic]], collapse = ' ')
    topic_docs <- meta_topics[order(meta_topics[,topic], decreasing=TRUE),][[doc_col]][1:n_docs]
    label <- ''
    trash <- FALSE
    line <- c(num, topic, prev, top_w, top_docs, label, trash)
    df <- rbind(df, line)
    num <- num + 1
  }
  colnames(df) <- header
  df$nr <- as.numeric(df$nr)
  df <- df[order(df$nr, decreasing=FALSE),]
  rownames(df) <- df$nr
  return(df)

}
