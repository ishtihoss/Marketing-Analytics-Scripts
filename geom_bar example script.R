edx_genre_split %>% group_by(genres) %>% 
  summarise(n=n()) %>% arrange(desc(n)) %>% 
  ggplot(aes(x=reorder(genres, n), y=n)) +
  geom_bar(stat='identity', fill="blue") + 
  coord_flip(y=c(0, 6000000)) +
  labs(x="", y="Number of Movies") +
  geom_text(aes(label= n), hjust=-0.1, size=3) +
  labs(title="Number of movies by genre" , caption = "source data: edx set")