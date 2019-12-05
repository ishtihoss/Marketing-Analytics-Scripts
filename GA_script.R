## setup
library(googleAnalyticsR)

## This should send you to your browser to authenticate your email. Authenticate with an email that has access to the Google Analytics View you want to use.
ga_auth()

## get your accounts
account_list <- ga_account_list()

## account_list will have a column called "viewId"
account_list$viewId

## View account_list and pick the viewId you want to extract data from. 
ga_id <- 195315687
## simple query to test connection
google_analytics(ga_id,
                 date_range = c("2019-01-01", "2019-06-25"),
                 metrics = "sessions",
                 dimensions = "date")

# All Relevant Dimensions

ga_data <- google_analytics(ga_id, 
                            date_range = c("2019-01-01", "2019-12-05"),
                            metrics = c("users","newUsers","percentNewSessions","sessionsPerUser","sessions","bounces","bounceRate","sessionDuration","avgSessionDuration","organicSearches","pageviewsPerSession","uniquePageviews","timeOnPage","avgTimeOnPage","exits","exitRate"),
                            dimensions = c("userType","sessionCount","daysSinceLastSession","userDefinedValue","userBucket","sessionDurationBucket","referralPath","fullReferrer","campaign","source","medium","keyword","adContent","socialNetwork","hasSocialSourceReferral","browser","browserVersion","operatingSystem","operatingSystemVersion","mobileDeviceBranding","mobileDeviceModel","mobileInputSelector","mobileDeviceInfo","mobileDeviceMarketingName","deviceCategory","browserSize","dataSource","country","region"
                            ,"metro","city","networkDomain","networkLocation","screenResolution","hostname","pagePath","pageTitle","landingPagePath","secondPagePath","exitPagePath","previousPagePath","pagePathLevel1","pagePathLevel2","pagePathLevel3","pagePathLevel4","pageDepth","userAgeBracket","userGender","interestOtherCategory","interestAffinityCategory","interestInMarketCategory","day","month","dayOfWeek"),
                            anti_sample = TRUE)

# Shortened Dimensions on Audience and Source

ga_data <- google_analytics(ga_id, 
                            date_range = c("2019-01-01", "2019-12-05"),
                            metrics = c("pageviews",'pageviewsPerSession',"timeOnPage","avgTimeOnPage"),
                            dimensions = c("userAgeBracket","userGender","interestInMarketCategory"),
                            anti_sample = TRUE)

# Dash 1: Unique Page Views by Source

ga_data %>% group_by(fullReferrer) %>% summarise(tpv=sum(uniquePageviews)) %>% 
  filter(tpv>100) %>% ggplot(aes(reorder(fullReferrer,tpv),tpv,fill=tpv)) + 
  geom_bar(stat="identity") + coord_flip(y=c(0,20000)) + 
  labs(x="",y="Total Unique Page Views",title="Unique Page View Sources for 2019") + 
  geom_text(aes(label=tpv),hjust=-0.10)    

# Pull page metrics

page_metrics <- google_analytics(ga_id, 
                            date_range = c("2019-01-01", "2019-12-05"),
                            metrics = c("entrances","entranceRate","pageviews","pageviewsPerSession", 
                                        "uniquePageviews", "timeOnPage", "avgTimeOnPage", "exits", "exitRate"),
                            dimensions = c("pagePath","country","landingPagePath","secondPagePath","exitPagePath",
                                           "previousPagePath","pageDepth"),
                            anti_sample = TRUE)

# Cleaned Page Metrics

cpm <- page_metrics %>% 
  filter(country %in% c("Malaysia","Indonesia","Bangladesh","Singapore","Sri Lanka","Philippines","Cambodia","South Korea","Thailand")) %>% 
  group_by(landingPagePath,country) %>% 
  summarise(total_upv=sum(uniquePageviews) ,top_mins=sum(timeOnPage/60),total_depth=sum(as.numeric(pageDepth)),total_entrances=sum(entrances),total_exits=sum(exits)) %>% 
  mutate(avg_time_per_entrance=top_mins/total_entrances)


# Page metrics country specific dash

cpm %>% filter(total_upv>100) %>% ggplot(aes(total_upv,avg_time_per_entrance)) + 
  geom_point() + scale_x_continuous(trans="log10") + 
  ggrepel::geom_text_repel(aes(label=landingPagePath)) + facet_wrap(~country)


