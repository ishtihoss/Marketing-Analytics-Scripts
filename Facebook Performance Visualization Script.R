# Load Data

ada_Marketing_APAC_Ads_16_Oct_201911_Nov_2019_1_ <- read_excel("C:/Users/IshtiaqueHossain/Downloads/ada-Marketing-APAC-Ads-16-Oct-201911-Nov-2019 (1).xlsx")

# Clean the Headers 

FB_16OCT_11NOV <- ada_Marketing_APAC_Ads_16_Oct_201911_Nov_2019_1_
names(FB_16OCT_11NOV) <- str_replace_all(names(FB_16OCT_11NOV),"[() ]","_")
FB_16OCT_11NOV <- FB_16OCT_11NOV %>% mutate(Day_of_week=weekdays(FB_16OCT_11NOV$Reporting_starts))

# Day of the Week (Reporting Starts as Day 1)

FB_16OCT_11NOV %>%filter(!is.na(Landing_page_views)) %>% group_by(Day_of_week) %>% summarise(Total_LPVs=sum(Landing_page_views)) %>% arrange(desc(Total_LPVs)) %>% ggplot(aes(x=reorder(Day_of_week,Total_LPVs),y=Total_LPVs,fill=Total_LPVs)) + geom_bar(stat="identity") + coord_flip() + scale_fill_distiller(palette = "Spectral", "Number of Landing Page Views") + labs(x="Day of the Week",y="Total Landing Page Views")

# Ad Performance Summary

FB_Summary <- FB_16OCT_11NOV %>% filter(!is.na(Landing_page_views)) %>% group_by(Ad_name) %>% summarise(sImpr=sum(Impressions),sClicks=sum(Clicks__all_),CTR=sClicks/sImpr,sCost=sum(Amount_spent__USD_),Total_LPVs=sum(Landing_page_views),CPR=Total_LPVs/sCost) 

# Cost Per Click Visualization

FB_Summary %>% mutate(CPR=Total_LPVs/sCost) %>% arrange(CPR) %>% group_by(Ad_name) %>% ggplot(aes(x=reorder(Ad_name,CPR),y=CPR,fill=Total_LPVs)) + geom_bar(stat="identity")+ geom_text(aes(label=round(CPR,2),hjust=-.01,size=3)) + scale_fill_distiller(palette="Spectral") + labs(x="",y="Cost Per Results",title="Automotive Ad A has lowest Cost Per Landing Page View")

# FB Campaign Performance Visualization

FB_Summary %>% ggplot(aes(sImpr,sClicks,col=Ad_name,label=Total_LPVs)) + geom_point() + geom_text(aes(label=Total_LPVs,hjust=-0.5)) + labs(x="Total Impressions",y="Total Clicks",title = "Mall Ad A is your WORST performing ad!")+geom_text(aes(label=round(CPR,2),hjust=1.2))