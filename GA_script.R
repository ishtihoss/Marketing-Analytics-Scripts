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
                            metrics = c("users","newUsers","percentNewSessions","sessionsPerUser"),
                            dimensions = c("userType","sessionCount","daysSinceLastSession","userDefinedValue","userBucket"),
                            anti_sample = TRUE)