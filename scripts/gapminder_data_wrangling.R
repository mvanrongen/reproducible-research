library(tidyverse)

read_csv("data/gapminder_1950_2018.csv")
gapminder <- read_csv("data/processed/gapminder1930_onwards.csv")

head(gapminder)

gapminder %>% 
  select(country_id, country, world_region, year, income_groups, income_per_person, life_expectancy) %>% 
  drop_na() %>% 
  filter(year >=1950) %>% 
  group_by(world_region) %>% 
  summarise(n = n_distinct(country))
  
  
  ggplot(aes(income_per_person, life_expectancy)) +
  geom_point(aes(colour = income_groups))
  
  read_csv("data/gapminder_1950_2018.csv")
