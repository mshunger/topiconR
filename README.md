# topiconR
___
This package is supposed to contain a few **con**venience funtions to help with understanding and labeling **topic**s in **R**.

For now, the roadmap is as follows:

- [x] extractor function for the *stm* package resulting in a dataframe containing topic numbers, prevalences, top prob and FREX words, top documents, an empty column for the labels and a *trash* column

- [x] extractor function for the *btm* package, similar to the stm extractor function
	- the function returns a dataframe with topic numbers, top words, top documents, an empty column for the labels and a *trash* column

- [x] extractor function for *lda*  models from the *topicmodels* package, similar to the functions above

- [ ] a shiny application that can
  - [ ] import the extracted data
  - [ ] display the extracted information topic by topic
  - [ ] label topics
  - [ ] export labeled topic data to .csv and .feather
