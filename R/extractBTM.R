library(BTM)

extractBTM <- function(
    model,
    data,
    meta,
    text_col='text',
    doc_id_col='doc_id',
    n_words=10,
    n_docs=4
    ) {

  scores <- predict(model, newdata=data)
  df <- data.frame(scores)
  top_words <- terms(model, top_n=n_words)

  alabel <- c()
  for (i in 1:n_docs){alabel = c(alabel, paste('document_', i, sep = ''))}
  header <- c('nr', 'name', 'top_terms', alabel, 'label', 'trash')
  to_ret <- data.frame()

  for (topic in 1:ncol(df)) {
    top_doc_ids <- rownames(df[order(df[,topic], decreasing=TRUE),][1:n_docs,])
    top_docs <- c()
    for (doc in top_doc_ids) {
      doctext <- meta[meta[[doc_id_col]]==doc,][[text_col]]
      top_docs <- c(top_docs, doctext)
    }

    top_w <- paste(top_words[[topic]]$token, collapse=' ')

    label <- ''
    trash <- FALSE
    line = c(topic, paste('Topic', topic, sep=' '), top_w, top_docs, label, trash)
    to_ret <- rbind(to_ret, line)
  }
  colnames(to_ret) <- header
  to_ret$nr <- as.numeric(to_ret$nr)
  to_ret <- to_ret[order(to_ret$nr, decreasing=FALSE),]
  rownames(to_ret) <- to_ret$nr
  return(to_ret)
}
