# Complete all of the items below
# Use comments where you're having trouble or questions

# 1. Read your data set into R
mydata <- read.csv("mydataHW2.csv")

# 2. Peek at the top few rows
head(mydata)

# 3. Peek at the top few rows for only a few columns
head(mydata[,1:3])

# 4. How many rows does your data have?
nrow(mydata) # I assume you'll be running this script and see the output, but just in case, my dataframe has 18432 rows

# 5. Get a summary for every column
summary(mydata)

# 6. Get a summary for one column
summary(mydata[,"AvgEngProf"])

# 7. Are any of the columns giving you unexpected values?
#    - missing values? (NA)
# I'm not sure what you mean by unexpected values, but I do have missing values - specifically, in columns DELE, AvgEngProf, AvgSpanProf, CSFreqSpeech, and CSExposureSpeech, as shown by the "NA's" in the summary() output

# 8. Select a few key columns, make a vector of the column names
myvector<-c(colnames(mydata[1:3]))

# 9. Create a new data.frame with just that subset of columns
#    from #7
#    - do this in at least TWO different ways
mydf<-data.frame(mydata[,c("DELE","AvgEngProf","AvgSpanProf","CSFreqSpeech","CSExposureSpeech")])

mydf2<-data.frame(mydata$DELE, mydata$AvgEngProf, mydata$AvgSpanProf, mydata$CSFreqSpeech, mydata$CSExposureSpeech)

mydf3<-subset(mydata[13:17])

# 10. Create a new data.frame that is just the first 10 rows
#     and the last 10 rows of the data from #8
temp<-nrow(mydata)-9
mydf4<-mydata[c(1:10,temp:nrow(mydata)),myvector]

# 11. Create a new data.frame that is a random sample of half of the rows.
mydf5<-mydata[sample(nrow(mydata),nrow(mydata)/2), ]

# 12. Find a comparison in your data that is interesting to make
#     (comparing two sets of numbers)
#     - run a t.test for that comparison
#     - decide whether you need a non-default test
#       (e.g., Student's, paired)
#     - run the t.test with BOTH the formula and "vector"
#       formats, if possible
#     - if one is NOT possible, say why you can't do it

# I'm not sure what you mean by the formula and vector formats, but I used two different methods that I think correspond to what you mean.
# Comparing overall reaction times (RTs) for bilinguals (B) and monolinguals (M):
# Method 1:
Q12ttestA<-t.test(RT ~ LangCond, data = mydata)

# Method 2:
Q12ttestB<-with(mydata, t.test(x = RT[LangCond == "M"], y = RT[LangCond == "B"]), alternative = c("less"))

# 13. Repeat #10 for TWO more comparisons
#     - ALTERNATIVELY, if correlations are more interesting,
#       do those instead of t-tests (and try both Spearman and
#       Pearson correlations)

# Calculating correlation between bilingual participants' self-reported Spanish proficiency and English proficiency:
bilingdf<-subset(mydata,LangCond=="B")
Q13cor1Spearman<-cor.test(bilingdf$AvgEngProf, bilingdf$AvgSpanProf, method = "spearman")
Q13cor1Pearson<-cor.test(bilingdf$AvgEngProf, bilingdf$AvgSpanProf, method = "pearson")

# Calculating correlation between bilingual participants' self-reported codeswitching frequency in speech and frequency of exposure to codeswitching in speech:
Q13cor2Spearman<-cor.test(bilingdf$CSFreqSpeech, bilingdf$CSExposureSpeech, method = "spearman")
Q13cor2Pearson<-cor.test(bilingdf$CSFreqSpeech, bilingdf$CSExposureSpeech, method = "pearson")

# 14. Save all results from #12 and #13 in an .RData file
x<-list(Q12ttestA,Q12ttestB,Q13cor1Spearman,Q13cor1Pearson,Q13cor2Spearman,Q13cor2Pearson)
save(x, file = "HW2workspace.RData")

# 15. Email me your version of this script, PLUS the .RData
#     file from #14