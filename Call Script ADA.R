library(RAdwords)
library(tidyverse)
library(ggrepel)
library(stringr)


# Keyword Performance Report 

body_kwd <- statement(select = c("Criteria","CampaignName","AdGroupName","KeywordMatchType","CreativeQualityScore","Impressions","SearchImpressionShare","SearchExactMatchImpressionShare","AveragePageviews","AveragePosition","AverageTimeOnSite","BounceRate","Clicks","Ctr","Cost","AllConversions"),
                      report = "KEYWORDS_PERFORMANCE_REPORT",
                      start = "2019-10-01",
                      end = "2019-11-05")

kwd_data <- getData(clientCustomerId = '253-381-0284',
                    google_auth = doAuth(),
                    statement = body_kwd,
                    transformation= T,
                    changeNames = T)

names(kwd_data) <- str_replace_all(names(kwd_data),"[/()]","_")

# Search Query Performance Report

body_sqp <- statement(select=c("CampaignName",'Query','KeywordTextMatchingQuery',"AdGroupName",'QueryTargetingStatus','Impressions','Clicks','Ctr','Cost','Conversions','Date','DayOfWeek','Month','MonthOfYear'),
                      report="SEARCH_QUERY_PERFORMANCE_REPORT",
                      start="2019-10-01",
                      end="2019-11-05")
sqp_data <- getData(clientCustomerId='253-381-0284',
                    google_auth=doAuth(),
                    statement=body_sqp, #object created with statement()
                    transformation = T, #data are transformed from xml text to R dataframe
                    changeNames = T) #column names are changed to more useful expressions

names(sqp_data) <- str_replace_all(names(sqp_data),"[/()]","_")

# Ad performance report

body_adperformance <- statement(select=c("CampaignName","AdGroupName","HeadlinePart1","HeadlinePart2","AdType","Automated","Impressions","Clicks","Ctr","Cost","AllConversions","AveragePageviews","BounceRate"),
                                report = "AD_PERFORMANCE_REPORT",
                                start = "2019-01-01",end = "2019-11-05")
adperformance_data <- getData(clientCustomerId = '253-381-0284',google_auth = doAuth(),
                              statement=body_adperformance,
                              transformation = T,
                              changeNames = T)
names(adperformance_data) <- str_replace_all(names(adperformance_data),"[/()]","_")

# Adgroup Performance Report

body_agp <- statement(select=c('AdGroupName','BounceRate','CampaignName','Impressions','Clicks','Cost','Conversions','Date','AdGroupType'),
                      report="ADGROUP_PERFORMANCE_REPORT",
                      start="2019-10-01",
                      end="2019-11-05")
adgroup_data <- getData(clientCustomerId='253-381-0284',
                        google_auth=doAuth(),
                        statement=body_agp, #object created with statement()
                        transformation = T, #data are transformed from xml text to R dataframe
                        changeNames = T) #column names are changed to more useful expressions

names(adgroup_data) <- str_replace_all(names(adgroup_data),"[/()]","_")

# Audience Performance Report

body_aud <- statement(select=c('Criteria','CampaignName','Impressions','Clicks','Date','Ctr','CriteriaDestinationUrl','UserListName','Cost','AdGroupName','AdGroupName','AdNetworkType1','AdNetworkType2'),
                      report="AUDIENCE_PERFORMANCE_REPORT",
                      start="2019-10-01",
                      end="2019-11-05")
aud_data <- getData(clientCustomerId='253-381-0284',
                        google_auth=doAuth(),
                        statement=body_aud, #object created with statement()
                        transformation = T, #data are transformed from xml text to R dataframe
                        changeNames = T) #column names are changed to more useful expressions

names(aud_data) <- str_replace_all(names(aud_data),"[/()]","_")

