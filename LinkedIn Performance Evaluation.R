# LinkedIn Performance Overview

names(LinkedIn_Campaign_OCT_NOV_17) <- str_replace_all(names(LinkedIn_Campaign_OCT_NOV_17),"[ ()-]","")

# Summarise Performance

LinkedIn_Campaign_OCT_NOV_17 %>% 
  group_by(CampaignName) %>% 
  summarise(sImpr=sum(Impressions),sClicks=sum(Clicks),sEngagements=sum(TotalEngagements),CTR=sClicks/sImpr,sEng_Rate=sEngagements/sImpr,sCov=sum(Conversions),sCost=sum(TotalSpent))

# Visualize Campaign Performance

LinkedIn_Campaign_OCT_NOV_17 %>% 
  group_by(CampaignName) %>% 
  summarise(sImpr=sum(Impressions),sClicks=sum(Clicks),sEngagements=sum(TotalEngagements),CTR=sClicks/sImpr,sEng_Rate=sEngagements/sImpr,sCov=sum(Conversions),sCost=sum(TotalSpent)) %>% ggplot(aes(sImpr,sEngagements,col=CampaignName,label=sCov)) + 
  geom_point() + geom_label() + labs(x="Total Impressions",y="Total Engagements",title = "Retail Mall ads have higher engagement rate and higher conversions")


