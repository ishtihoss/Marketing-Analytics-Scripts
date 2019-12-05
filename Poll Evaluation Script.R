# Feedback from Jane Gan:

## Questions 5,7,8 [from the polls]

# Loading poll data

library(readxl)
Marketing_in_2020_s_Economic_Landscape_1_191_ <- read_excel("C:/Users/IshtiaqueHossain/Downloads/Marketing in 2020's Economic Landscape(1-191).xlsx")

# Clean the data

m20 <- Marketing_in_2020_s_Economic_Landscape_1_191_ 
names(m20) <- str_replace_all(names(m20),"[ ?']","")

# Question 5 Viz

summary_m20 <- m20 %>% group_by(Areyoustrugglingtoacquiremorecustomersinthecurrenteconomiclandscape) %>% 
  summarise(n=n()) %>% arrange(desc(n)) %>% mutate(Per_centage=n/sum(n)*100)

summary_m20 %>% ggplot(aes(x=reorder(Areyoustrugglingtoacquiremorecustomersinthecurrenteconomiclandscape,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip() + 
  scale_fill_distiller(palette = "Spectral", "% of respondents") + 
  geom_text(aes(label=round(Per_centage,2),hjust=-.01)) + 
  labs(x="",y="",title = "Are you struggling to acquire more customers in the current economic landscape?") + 
  ggthemes::theme_economist()

# Question 7 Viz

summary_m20_q7 <- m20 %>% group_by(Doyouforeseehavingenoughbudgetforthemarketingactivitiesyoudliketorunin2020) %>% 
  summarise(n=n()) %>% arrange(desc(n)) %>% mutate(Per_centage=n/sum(n)*100)

summary_m20_q7 %>% ggplot(aes(x=reorder(Doyouforeseehavingenoughbudgetforthemarketingactivitiesyoudliketorunin2020,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip() + 
  scale_fill_distiller(palette = "Spectral", "% of respondents") + 
  geom_text(aes(label=round(Per_centage,2),hjust=-.01)) + 
  labs(x="",y="",title = "Do you foresee having enough budget for the marketing activities you'd like to run in 2020?
") +   ggthemes::theme_economist()

# Question 8 Viz

summary_m20_q8 <- m20 %>% group_by(Whatdoyouthinktheeconomicgrowthforyourcountrywilllooklikein2020) %>% 
  summarise(n=n()) %>% arrange(desc(n)) %>% mutate(Per_centage=n/sum(n)*100)

summary_m20_q8 %>% ggplot(aes(x=reorder(Whatdoyouthinktheeconomicgrowthforyourcountrywilllooklikein2020,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip() + 
  scale_fill_distiller(palette = "Spectral", "% of respondents") + 
  geom_text(aes(label=round(Per_centage,2),hjust=-.01)) + 
  labs(x="",y="",title = "What do you think the economic growth for your country will look like in 2020?
") +   ggthemes::theme_economist()

# Industry Specific Slowing Growth, SEA level aggregation

m20 %>% group_by(Whatindustryareyouoperatingin) %>% 
  summarise(Count=n()) %>% mutate(Per_centage=Count/sum(Count)*100) %>% 
  filter(Count>2) %>% ggplot(aes(x=reorder(Whatindustryareyouoperatingin,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip(y=c(0,20))  + geom_text(aes(label= round(Per_centage,2)), hjust=-0.1, size=3) +
  scale_fill_distiller(palette = "Spectral") + 
  labs(y="Per Centage of Responders Reporting Slowing Growth",x="",title = "Financial Services, Telco and FMCG are experiencing slowest customer growth in SEA") + 
  ggthemes::theme_economist()
 
# Industry Specific Slowing Growth, country level breakdown
m20 %>% group_by(Whatindustryareyouoperatingin,Whichcountryareyouoperatingin) %>% 
  summarise(Count=n()) %>% mutate(Per_centage=Count/sum(Count)*100) %>%
  filter(Count>2) %>% ggplot(aes(x=reorder(Whatindustryareyouoperatingin,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip(y=c(0,50))  + geom_text(aes(label= round(Per_centage,2)), hjust=-0.1, size=3) +
  scale_fill_distiller(palette = "Spectral") + 
  labs(y="Per Centage of Responders Reporting Slowing Growth",x="",title = "Financial Services, Telco and FMCG are experiencing slowest customer growth in SEA") + 
  facet_wrap(~Whichcountryareyouoperatingin) +  ggthemes::theme_economist()

