## FB Annual Report

ada_Marketing_APAC_Ads_1_Jan_201927_Nov_2019_performance_clicks_by_day_ <- read_csv("C:/Users/IshtiaqueHossain/Downloads/ada-Marketing-APAC-Ads-1-Jan-201927-Nov-2019 (performance clicks by day).csv")

names(ada_Marketing_APAC_Ads_1_Jan_201927_Nov_2019_performance_clicks_by_day_) <- str_replace_all(names(ada_Marketing_APAC_Ads_1_Jan_201927_Nov_2019_performance_clicks_by_day_)," ","_")
FB_peformance_cbd <- ada_Marketing_APAC_Ads_1_Jan_201927_Nov_2019_performance_clicks_by_day_

## Best Day of the Week

FB_peformance_cbd %>% filter(!is.na(Landing_page_views)) %>% mutate(Day=weekdays(Reporting_starts)) %>% group_by(Day) %>% summarise(Total_LPVs=sum(Landing_page_views)) %>% ggplot(aes(x=reorder(Day,Total_LPVs),y=Total_LPVs,fill=Total_LPVs)) + geom_bar(stat="identity") + coord_flip() + labs(x="Day of the Week",y="Total Landing Page Views",title = "Thursdays and Fridays get most Landing Page Views") + scale_fill_distiller(palette = "RdYlBu")

## Best Ads

FB_peformance_cbd %>% filter(!is.na(Landing_page_views)) %>% group_by(Ad_name) %>% summarise(LPVs=sum(Landing_page_views),Total_Cost=sum(`Amount_spent_(USD)`)) %>% mutate(Rating= ifelse((LPVs>mean(LPVs) & Total_Cost<mean(Total_Cost)),"Great","OK")) %>% ggplot(aes(LPVs,Total_Cost,label=Ad_name,col=Rating)) + geom_point() + ggrepel::geom_text_repel()

## Best Organic Post

mj %>% filter(!true_engagement>1 & Lifetime_Post_Total_Impressions>5*median(Lifetime_Post_Total_Impressions)) %>% top_n(20,true_engagement) %>% select(Permalink,post_id,Post_Message,Type,Posted,Lifetime_Post_Total_Reach,Lifetime_Engaged_Users,true_engagement) %>% View()