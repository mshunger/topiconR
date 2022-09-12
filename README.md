# topiconR
___
This package is supposed to contain a few **con**venience funtions to help with understanding and labeling **topic**s in **R**.

For now, the roadmap is as follows:

- [ ] extractor function for the *stm* package resulting in a dataframe and/or .csv file and/or .feather file containing topic numbers, prevalences, top prob and FREX words, top documents, an empty column for the labels and a *trash* column

- [ ] extractor function for the *btm* package, similar to the stm extractor function

- [ ] extractor function for the *lda* package, similar to the functions above

- [ ] a shiny application that can
  - [ ] import the extracted data
  - [ ] display the extracted information topic by topic
  - [ ] label topics
  - [ ] export labeled topic data to .csv and .feather
