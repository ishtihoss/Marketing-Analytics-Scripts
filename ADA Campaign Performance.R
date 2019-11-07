# Ada Campaign Level Performance via Keyword Performance Report

# Step 1 API Call (Check Dates)

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

# Step 2: Select ADA Campaigns

ADA_Campaigns_kwd <- kwd_data %>% filter(Campaign %in% c("ADA Marketing Team_Search_Indonesia (ID)","ADA Marketing Team_Search_Malaysia (MY)","ADA Marketing Team_Search_Philippines (PH)","ADA Marketing Team_Search_Singapore (SG)","ADA Marketing Team_Search_Thailand (TH)")) 

# Step 3: Clean Country Names

ADA_Campaigns_kwd$Campaign <- str_replace_all(ADA_Campaigns_kwd$Campaign,"ADA Marketing Team_Search_","")

# Step 4: Visualize Adgroup performance by Country

ADA_Campaigns_kwd %>% group_by(Adgroup) %>% ggplot(aes(Impressions,Clicks,col=Adgroup,size=Cost)) + geom_point() + facet_grid(~Campaign)

# Step 5: High Level Campaign Overview

ADA_Campaigns_kwd %>% group_by(Campaign) %>% summarise(sImpr=sum(Impressions),sClicks=sum(Clicks),sCost=sum(Cost)) %>% ggplot(aes(sImpr,sClicks,size=sCost,col=Campaign,label=Campaign)) + geom_point() 

