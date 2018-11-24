suppressPackageStartupMessages(library(tidyverse)) 
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(ggplot2))



## this R scripts return the most frequently first letter in the words.

words_dat <- readLines("words.txt")


## initialize a vector to store the results
letter_list <- rep(0, length(letters))



## transfer all the characters into lower case

for (i in words_dat){

# extract the first letter from each word and need 
# to make sure all of them are capitalized.
	first_letter <-  str_to_upper(str_sub(i, start= 1, end = 1))
  
	index <-  as.numeric(match(first_letter,LETTERS))
	# add the count by 1
	letter_list[index] <- letter_list[index]+1
	
}

x <-  data.frame(Letter = LETTERS, occurance = letter_list)

# write the result into table



write.table(x,"first_letter_frequency.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)

x %>% 
	arrange(occurance) %>% 
	ggplot(aes(Letter))+
	geom_bar(aes(weight = occurance))+
	theme_classic()+
	labs(x= "LETTER", y="Occurance", title = "The Occurance of Fist Letter of Words") 

  ggsave("first_letter_freq.png", width = 4, height = 4)
