library(stm)

extractSTM <- function(
    model,
    meta,
    doc_col='text',
    n_words=10,
    n_docs=4
    ) {

  # extract mean thetas per topic
  model$expected <- data.frame(colMeans(model$theta))
  model$expected$name <- 1:model$settings$call$K
  colnames(model$expected)[1] <- 'mean_theta'
  model$expected <- model$expected[order(model$expected$mean_theta, decreasing=T),]

  # extract `n_words` prob & FREX words and `n_docs` documents from the model and meta
  alabel = c()
  for (i in 1:n_docs){alabel = c(alabel, paste('document_', i, sep = ''))}
  header = c('nr', 'name', 'prevalence', 'frex', 'top_terms', alabel, 'label', 'trash')
  df <- data.frame()
  for (i in model$expected$name){

    ft = findThoughts(model, meta[[doc_col]], topics=i, n=n_docs)
    top_docs = ft$docs[[1]]
    labeled = labelTopics(model, topics=model$expected$name, n=n_words)
    frex = paste(labeled$frex[i,], collapse=' ')
    top_w = paste(labeled$prob[i,], collapse=' ')
    prev <- model$expected[i, 'mean_theta']
    label <- ''
    trash <- FALSE
    line = c(i, paste('Topic', i, sep=' '), prev, frex, top_w, top_docs, label, trash)
    df <- rbind(df, line)
  }
  colnames(df) <- header
  df$nr <- as.numeric(df$nr)
  df <- df[order(df$nr, decreasing=FALSE),]
  rownames(df) <- df$nr
  return(df)
}
