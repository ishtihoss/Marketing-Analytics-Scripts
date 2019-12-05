# Ada Campaign Level Performance via Keyword Performance Report

# Step 1 API Call (Check Dates)

body_kwd <- statement(select = c("Date","Criteria","CampaignName","AdGroupName","KeywordMatchType","CreativeQualityScore","Impressions","SearchImpressionShare","SearchExactMatchImpressionShare","AveragePageviews","AveragePosition","AverageTimeOnSite","BounceRate","Clicks","Ctr","Cost","AllConversions"),
                      report = "KEYWORDS_PERFORMANCE_REPORT",
                      start = "2019-11-14",
                      end = "2019-11-25")

kwd_data <- getData(clientCustomerId = '253-381-0284',
                    google_auth = doAuth(),
                    statement = body_kwd,
                    transformation= T,
                    changeNames = T)

names(kwd_data) <- str_replace_all(names(kwd_data),"[/()]","_")

# Step 2: Select ADA Campaigns

ADA_Campaigns_kwd <- kwd_data %>% filter(Campaign %in% c("ADA Marketing Team_Search_Malaysia (MY)","ADA Marketing Team_Search_Philippines (PH)","ADA Marketing Team_Search_Singapore (SG)","ADA Marketing Team_Search_Thailand (TH)")) 

# Step 3: Clean Country Names

ADA_Campaigns_kwd$Campaign <- str_replace_all(ADA_Campaigns_kwd$Campaign,"ADA Marketing Team_Search_","")

# Step 4: Visualize Adgroup performance by Country

ADA_Campaigns_kwd %>% group_by(Adgroup) %>% ggplot(aes(Impressions,Clicks,col=Adgroup,size=Cost)) + geom_point() + facet_grid(~Campaign)

# Step 5: High Level Campaign Overview

ADA_Campaigns_kwd %>% group_by(Campaign) %>% summarise(sImpr=sum(Impressions),sClicks=sum(Clicks),sCost=sum(Cost)) %>% ggplot(aes(sImpr,sClicks,size=sCost,col=Campaign,label=Campaign)) + geom_point() 

# Step 7: CPC VS Clicks

ADA_Campaigns_kwd %>% group_by(Campaign) %>% summarise(sImpr=sum(Impressions),sClicks=sum(Clicks),sCost=sum(Cost),CPC=sClicks/sCost) %>% ggplot(aes(sClicks,CPC,label=Campaign)) + geom_point() + geom_label() + labs(x="Total Clicks",y="Cost Per Click")

# Campaign Performance by Time Spent and Pages

ADA_Campaigns_kwd %>% group_by(Campaign) %>% 
  summarise(sTotal_Time=sum(Avg.sessionduration_seconds_)/60,Total_Pages=sum(Pages_session),Total_sessions=sum(Avg.sessionduration_seconds_>0)) %>% 
  ggplot(aes(Total_Pages,sTotal_Time,col=Campaign)) + geom_point() + labs(x="Total Number of Pages per Session",y="Total Time Spent in Minutes",title = "Search Campaign Performance by Pages Per Session and Time Spent. Between Nov 14 to Nov 25")

# Time Spect and Total Pages Per Sessions on Keyword by Campaign

ADA_Campaigns_kwd %>% 
  group_by(Campaign,Keyword) %>% 
  summarise(sTotal_Time=sum(Avg.sessionduration_seconds_)/60,Total_Pages=sum(Pages_session),Total_sessions=sum(Avg.sessionduration_seconds_>0)) %>% filter(sTotal_Time>0) %>% 
  ggplot(aes(x=reorder(Keyword,sTotal_Time),y=sTotal_Time,fill=Total_Pages)) + geom_bar(stat="identity") + coord_flip() + scale_fill_distiller(palette = "Spectral","Total Pages Per Session") + 
  labs(x="Total Time in Minutes",y="Keywords") + facet_wrap(~Campaign) + ggthemes::theme_economist())