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

# Experimental Chunk

ga_data <- google_analytics(ga_id, 
                            date_range = c("2019-01-01", "2019-12-05"),
                            metrics = c("users","newUsers","percentNewSessions","sessionsPerUser","sessions","bounces","bounceRate","sessionDuration","avgSessionDuration","organicSearches","pageviewsPerSession","uniquePageviews","timeOnPage","avgTimeOnPage","exits","exitRate"),
                            dimensions = c("userType","sessionCount","daysSinceLastSession","userDefinedValue","userBucket","sessionDurationBucket","referralPath","fullReferrer","campaign","source","medium","keyword","adContent","socialNetwork","hasSocialSourceReferral","browser","browserVersion","operatingSystem","operatingSystemVersion","mobileDeviceBranding","mobileDeviceModel","mobileInputSelector","mobileDeviceInfo","mobileDeviceMarketingName","deviceCategory","browserSize","dataSource","country","region"
                            ,"metro","city","networkDomain","networkLocation","screenResolution","hostname","pagePath","pageTitle","landingPagePath","secondPagePath","exitPagePath","previousPagePath","pagePathLevel1","pagePathLevel2","pagePathLevel3","pagePathLevel4","pageDepth","userAgeBracket","userGender","interestOtherCategory","interestAffinityCategory","interestInMarketCategory","day","month","dayOfWeek"),
                            anti_sample = TRUE)