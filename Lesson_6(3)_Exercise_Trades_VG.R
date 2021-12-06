#Set working directory

setwd("C:/Users/valer/Desktop/Big Data Lessons Project/My_Project_Files")

#install Tydyverse, readr, and dplyr packages

install.packages("tidyverse")
install.packages("readr")
install.packages("dplyr")

#Load Tydyverse, readr, and dplyr packages to the library

library(readr)
library(tidyverse)
library(dplyr)

#Upload data file as a tibble

read_csv("sample_transactions.csv")

#Alternative option to upload file[read_csv("C:\\Users\\valer\\Desktop\\Big Data Lessons Project\\My_Project_Files\\sample_transactions.csv")]

#Give name to tibble

sample_transactions <-read_csv("C:\\Users\\valer\\Documents\\R\\sample_transactions.csv")
dput(sample_transactions)


str(sample_transactions)


#How many transactions does each person make? Produce a tibble that is sorted by the number of transactions. 
#Who traded the most? (Hint: think about how you might use group_by() to collect together all of the rows from the same
#trader. tally() is useful for counting rows.)

#Group data by account

by_account <- group_by(sample_transactions,account)

#Count the number of rows for each account using tally () and print

trades_by_account <- tally(by_account,,TRUE)
trades_by_account

#And now with pipes

trades_by_account <- sample_transactions %>% group_by(account) %>% tally() %>% arrange(-n)
trades_by_account


#Add a dummy column indicating whether the transaction is a buy or a sell.
#Use if/then logic. If value of a transaction is <o then it is 1 "Sell"

sample_transactions <- mutate (sample_transactions, sales = ifelse(transaction.value<0,1,0))
sample_transactions <- mutate (sample_transactions, purchases = ifelse(transaction.value>0,1,0))

#Group data by account and sum the number of Sales per account and print

by_account <- group_by(sample_transactions,account)
sales_by_account <- summarise(by_account,sum(sales))
sales_by_account

#Group data by account and sum the number of Sales per account and print

by_account <- group_by(sample_transactions,account)
purchases_by_account <- summarise(by_account,sum(purchases))
purchases_by_account

#And now with pipes and tally(): Sales

sales_by_account <- sample_transactions %>% group_by(account)%>% tally(sales) %>% arrange(-n)
sales_by_account

#And now with pipes and tally(): Purchases

purchases_by_account <- sample_transactions %>% group_by(account)%>% tally(sales) %>% arrange(-n)
purchases_by_account

#Calculate the day of the week is the most active trading day. (Hint: You could use wday from the lubridate package.) 
#Why are there no Saturdays or Sundays in the data?

#Install lubridate package

installed.packages("lubridate")

#Load lubridate package to the library

library(lubridate)

sample_transactions <- mutate (sample_transactions, week_day=weekdays(date))
sample_transactions

#Calculate most active day of the week (by no of trades)now with pipes and tally():

sales_by_day <- sample_transactions %>% group_by(week_day)%>% tally() %>% arrange(-n)
sales_by_day

# Calculate Which days of the week are people more likely to buy than sell. 
# Calculate this first for each account and then average over the account. 
# (Hint: If you average the sell dummy, it will give you the proportion of transactions that are sells.)    
