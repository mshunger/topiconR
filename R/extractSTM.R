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
  header = c('name', 'prevalence', 'FREX', 'prob', alabel, 'label', 'trash')

  df <- data.frame()
  for (i in model$expected$name){

    ft = findThoughts(model, meta[[doc_col]], topics=i, n=n_docs)
    docs = ft$docs[[1]]
    labeled = labelTopics(model, topics=model$expected$name, n=n_words)
    frex = paste(labeled$frex[i,], collapse=' ')
    prob = paste(labeled$prob[i,], collapse=' ')
    prev <- model$expected[i, 'mean_theta']
    label <- ''
    trash <- FALSE
    line = c(paste('Topic', i, sep=' '), prev, frex, prob, docs, label, trash)
    df <- rbind(df, line)
  }
  colnames(df) <- header
  return(df)
}
