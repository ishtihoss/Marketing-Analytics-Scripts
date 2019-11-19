# Feedback from Jane Gan:

## Questions 5,7,8 [from the polls]

# Loading poll data

library(readxl)
Marketing_in_2020_s_Economic_Landscape_1_191_ <- read_excel("C:/Users/IshtiaqueHossain/Downloads/Marketing in 2020's Economic Landscape(1-191).xlsx")

# Clean the data

m20 <- Marketing_in_2020_s_Economic_Landscape_1_191_ 
names(m20) <- str_replace_all(names(m20),"[ ?]","")

# Question 5 Viz

summary_m20 <- m20 %>% group_by(Areyoustrugglingtoacquiremorecustomersinthecurrenteconomiclandscape) %>% 
  summarise(n=n()) %>% arrange(desc(n)) %>% mutate(Per_centage=n/sum(n)*100)

summary_m20 %>% ggplot(aes(x=reorder(Areyoustrugglingtoacquiremorecustomersinthecurrenteconomiclandscape,Per_centage),y=Per_centage,fill=Per_centage)) + 
  geom_bar(stat="identity") + coord_flip() + 
  scale_fill_distiller(palette = "Spectral", "% of respondents") + 
  geom_text(aes(label=round(Per_centage,2),hjust=-.01)) + 
  labs(x="",y="",title = "Are you struggling to acquire more customers in the current economic landscape?") + 
  ggthemes::theme_wsj()

