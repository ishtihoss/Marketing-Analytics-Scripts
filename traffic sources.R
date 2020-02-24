# Traffic Sources
library(lubridate)
library(googleAnalyticsR)
library(googleAuthR)
library(RAdwords)
library(caret)
library(tidyverse)

## pull data

traffic_sources <- google_analytics(ga_id, 
                                    date_range = c("2019-07-01", "2020-02-24"),
                                    metrics = c("entrances","users","pageviews","organicSearches", 
                                                "uniquePageviews", "timeOnPage", "avgTimeOnPage","sessions","sessionDuration","newUsers"),
                                    dimensions = c("pagePath","country","landingPagePath","pageTitle","sourceMedium",
                                                   "date","pageDepth","hour","adMatchedQuery"),
                                    anti_sample = TRUE)

## cleaning

tfs <- traffic_sources %>% 
  filter(country %in% c("Malaysia","Singapore","Philippines","Thailand","Indonesia","Cambodia","Thailand","South Korea","Bangladesh", "Sri Lanka")) 
## adding Month

tfs <- tfs %>% mutate(month=months(date),week=weeks(date))


## baseline viz

tfs %>% group_by(date,sourceMedium) %>% summarise(total_users=sum(users)) %>%
  ggplot(aes(date,total_users,col=sourceMedium)) + geom_line()

# Thailand Viz

tfs  %>% group_by(date,sourceMedium) %>% 
  filter(country=="Thailand") %>% summarise(total_users=sum(users)) %>% 
  filter(total_users>5) %>% ggplot(aes(date,total_users,col=sourceMedium,label=sourceMedium)) + 
  geom_line() + geom_text() + 
  labs(x="Date",y="Total Number of Users",title="Traffic Fluctuation by Source and Day in Thailand",caption = "Date Range = 1st Oct to 20th Dec, 2019")

# Base Code for Function

tfs %>% filter(country=="Cambodia") %>% group_by(date,sourceMedium) %>% summarise(total_users=sum(users)) %>%
  ggplot(aes(date,total_users,col=sourceMedium,label=sourceMedium)) + geom_line() + geom_text()

# Create Function

tfs_country <- function(country_name){
  tfs %>% filter(country==country_name) %>% 
    group_by(date,sourceMedium) %>% 
    summarise(total_users=sum(users)) %>% 
    ggplot(aes(date,total_users,col=sourceMedium,label=sourceMedium)) + 
    geom_line() + geom_text()
}

# identifying top ten traffic sources

top_source_thai <- tfs %>% filter(country=="Thailand") %>% 
  group_by(sourceMedium) %>% summarise(total_users=sum(users)) %>%
  arrange(desc(total_users)) %>% slice(1:10) %>% .$sourceMedium

# Top source by country function

top_source_ <- function(country,n){
  tfs %>% filter(country==country) %>% 
  group_by(sourceMedium) %>% summarise(total_users=sum(users)) %>%
  arrange(desc(total_users)) %>% slice(1:n) %>% .$sourceMedium
}


# Country specific traffic source per month

tfs %>% filter(country=="Malaysia") %>%
  group_by(country,sourceMedium) %>% 
  summarise(total_users=sum(users)) %>% 
  ggplot(aes(reorder(sourceMedium,total_users),total_users,fill=total_users)) + 
  geom_bar(stat='identity') + coord_flip()

# Clean top source geom_line country specific viz

tfs %>% filter(country=="Malaysia") %>% group_by(date,sourceMedium) %>% 
  summarise(total_users=sum(users)) %>% 
  filter(sourceMedium %in% top_source_("Malaysia",5)) %>% 
  ggplot(aes(date,total_users,col=sourceMedium,label=date)) + 
  geom_line() 

# Hourly breakdown

tfs %>% filter(country=="Indonesia") %>% group_by(hour,sourceMedium) %>% 
  summarise(total_users=sum(users)) %>% 
  filter(sourceMedium %in% top_source_("Malaysia",10)) %>% 
  ggplot(aes(hour,total_users,col=sourceMedium,fill=sourceMedium)) + 
  geom_bar(stat="identity") + coord_flip()

# Total Users vs Average Time Per User

tfs %>% 
  group_by(sourceMedium,date) %>% 
  summarise(total_users=sum(users),total_time=sum(timeOnPage),atps=total_time/total_users) %>% 
  filter(total_users>100 & total_time>0) %>% ggplot(aes(date,atps,col=sourceMedium))  + 
  geom_line() + ggthemes::theme_solarized_2()

