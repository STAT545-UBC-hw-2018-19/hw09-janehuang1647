all: report.html
## since histogram.png depends on words.txt and histogram.tsv, so it is okay just put this in `all`.


clean: 
	rm -f words.txt histogram.tsv histogram.png first_letter_freq.png first_letter_frequency.tsv Rplots.pdf words.tsv report.html
## delete the data  -f is force removral
	
words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'


histogram.tsv: histogram.R words.txt
	Rscript histogram.R
	
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'


## $@ is the referring to the target and $< is referring to the first input.

###plots: histogram.png hist2.png   to do multiple plots
	
first_letter_frequency.tsv: analyse_Words.R words.txt
	Rscript $<


report.html: report.rmd histogram.tsv histogram.png first_letter_frequency.tsv
	Rscript -e 'rmarkdown::render("$<")'
	rm -f Rplots.pdf


