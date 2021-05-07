install.packages('paletteer')
library('gt')
library('paletteer')


# Changing up the names of the columns for better final appearance.

philosopher_prepped <- philosopher_summary %>%
  rename(Philosopher = philosopher,
         Tweets = tweets, Users = distinct_users, Avg_Fav = avg_fav, Favorites = total_fav,
         Avg_Retweet = avg_retweet, Retweets = total_retweet) %>%
  arrange(desc(Tweets))

# Rounding all the numbers from the different categories to two decimal places.

philosopher_final <- philosopher_prepped %>%
  select(Philosopher, Tweets, Users, Favorites, Avg_Fav, Retweets, Avg_Retweet) %>%
  mutate_if(is.numeric, ~ round(., 2))

# Using formatabble to create a table with color bars to show differences in values.

philosopher_unfiltered_table <- formattable(philosopher_final, 
                                          align =c("l","c","c","c","c", "c", "c", "c", "r"), 
                                          list(`Philosopher` = formatter ("span", style = ~ style(color = "black",font.weight = "bold")), 
                                               `Tweets`= color_bar("#3df6b2"), `Users` = color_bar("#ff1d1d"),
                                               'Favorites' = color_bar('#148afa'), Retweets = color_bar('#f10adb')))

print(philosopher_unfiltered_table)

# Completing the same conversions and create table with filtered data.

philosopher_prepped_filtered <- philosopher_summary_filtered %>%
  rename(Philosopher = philosopher,
         Tweets = tweets, Users = distinct_users, Avg_Fav = avg_fav, Favorites = total_fav,
         Avg_Retweet = avg_retweet, Retweets = total_retweet) %>%
  arrange(desc(Tweets))

philosopher_final_filtered <- philosopher_prepped_filtered %>%
  select(Philosopher, Tweets, Users, Favorites, Avg_Fav, Retweets, Avg_Retweet) %>%
  mutate_if(is.numeric, ~ round(., 2))

philosopher_filtered_table <- formattable(philosopher_final_filtered, 
                                          align =c("l","c","c","c","c", "c", "c", "c", "r"), 
                                          list(`Philosopher` = formatter ("span", style = ~ style(color = "black",font.weight = "bold")), 
                                               `Tweets`= color_bar("#3df6b2"), `Users` = color_bar("#ff1d1d"),
                                               'Favorites' = color_bar('#148afa'),
                                               Retweets = color_bar('#f10adb')))
print(philosopher_filtered_table)

# Creating a similar table with all the Stoic grouped versus Socrates with filtered data.

stoic_prepped_filtered <- stoic_versus_socrates_filtered %>%
  rename(Tweets = tweets, Users = distinct_users, Avg_Fav = avg_fav, Favorites = total_fav,
         Avg_Retweet = avg_retweet, Retweets = total_retweet) %>%
  arrange(desc(Tweets))

stoic_final_filtered <- stoic_prepped_filtered %>%
  select(Stoic, Tweets, Users, Favorites, Avg_Fav, Retweets, Avg_Retweet) %>%
  mutate_if(is.numeric, ~ round(., 2))

stoic_filtered_table <- formattable(stoic_final_filtered, 
                                          align =c("l","c","c","c", "c", "c", "c"), 
                                          list(`Philosopher` = formatter ("span", style = ~ style(color = "black",font.weight = "bold")), 
                                               `Tweets`= color_bar("#3df6b2"), `Users` = color_bar("#ff1d1d"),
                                               'Favorites' = color_bar('#148afa'),
                                               Retweets = color_bar('#f10adb')))
print(stoic_filtered_table)

#Plotting the Favorites to Retweets with line of best fit with unfiltered data.

plot_unfiltered <- ggplot(final_philosopher, aes(favoriteCount, retweetCount)) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount, color = philosopher)) +
  geom_smooth(method = "lm", se = FALSE, color = 'black', alpha = 0.5) +
  ggtitle('Unfiltered Comparison') + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab('Favorites') +
  ylab('Retweets')

print(plot_unfiltered)


best_fit_filtered <- ggplot(philosopher_filtered, aes(favoriteCount, retweetCount)) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount, color = philosopher)) +
  geom_smooth(method = "lm", se = FALSE, color = 'black') +
  ggtitle('Filtered Comparison (<1000 Favorites)') +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab('Favorites') +
  ylab('Retweets')

print(best_fit_filtered)



