
# Creating summary table with the tweets of each philosopher group together
# Calculating number of tweet, distinct users, total and average favorites and retweets


philosopher_summary <- final_philosopher%>%
  group_by(philosopher) %>%
  summarize(tweets = n(), distinct_users = n_distinct(screenName), avg_fav = mean_sd(favoriteCount, denote_sd = 'paren'), total_fav = sum(favoriteCount),
            avg_retweet = mean_sd(retweetCount, denote_sd = 'paren'), total_retweet = sum(retweetCount))

View(philosopher_summary)

install.packages('qwraps2')
library(qwraps2)

# Look at the Stoics versus Socrates in how the compare grouped up

stoics_vs_socrates <- final_philosopher%>%
  group_by(Stoic) %>%
  summarize(tweets = n(), distinct_users = n_distinct(screenName), avg_fav = mean(favoriteCount), 
            sd_fav = sd(favoriteCount), total_fav = sum(favoriteCount),
            avg_retweet = mean(retweetCount), sd_retweet = sd(retweetCount), total_retweet = sum(retweetCount))


View(stoics_vs_socrates)


# Looking at scatterplots of favoriteCount compared to retweetCount

socrates_plot <- ggplot(data = socrates_final) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))

print(socrates_plot)stoics_vs_socrates

aurelius_plot <- ggplot(data = aurelius_final) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))

print(aurelius_plot)

seneca_plot <- ggplot(data = seneca_final) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))

print(seneca_plot)

epictetus_plot <- ggplot(data = epictetus_final) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))

print(epictetus_plot)

musonius_plot <- ggplot(data = musonius_final) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))

print(musonius_plot)

# Performing Linear Regression models with favoriteCount as predictor and retweetCount as outcome

socrates_model <- lm(retweetCount ~ favoriteCount, socrates_final)
summary(socrates_model)

seneca_model <- lm(retweetCount ~ favoriteCount, seneca_final)
summary(seneca_model)

epictetus_model <- lm(retweetCount ~ favoriteCount, epictetus_final)
summary(epictetus_model)

aurelius_model <- lm(retweetCount ~ favoriteCount, aurelius_final)
summary(aurelius_model)

musonius_model <- lm(retweetCount ~ favoriteCount, musonius_final)
summary(musonius_model)

# Looking at the combined philosopher table for favoriteCount with retweetCount

combined_plot <- ggplot(data = final_philosopher) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))
print(combined_plot)

combined_model <- lm(retweetCount ~ favoriteCount, final_philosopher)

summary(combined_model)

best_fit <- ggplot(final_philosopher, aes(favoriteCount, retweetCount)) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount, color = philosopher)) +
  geom_smooth(method = "lm", se = FALSE, color = 'black') +
  ggtitle('Unfiltered Comparison') +
  xlab('Favorites') +
  ylab('Retweets')

print(best_fit)

# Due to some very few extreme outliers I filtered the data to under 1000 favoriteCount

philosopher_filtered <- filter(final_philosopher, favoriteCount <= 1000)

filtered_plot <- ggplot(data = philosopher_filtered) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount))
print(filtered_plot)

filtered_model <- lm(retweetCount ~ favoriteCount, philosopher_filtered)
summary(filtered_model)

best_fit_filtered <- ggplot(philosopher_filtered, aes(favoriteCount, retweetCount)) +
  geom_point(mapping = aes(x = favoriteCount, y = retweetCount, color = philosopher)) +
  geom_smooth(method = "lm", se = FALSE, color = 'black') +
  ggtitle('Filtered Comparison') +
  xlab('Favorites') +
  ylab('Retweets')

print(best_fit_filtered)

philosopher_summary_filtered <- philosopher_filtered%>%
  group_by(philosopher) %>%
  summarize(tweets = n(), distinct_users = n_distinct(screenName), avg_fav = mean_sd(favoriteCount, denote_sd = 'paren'),
            med_fav = median(favoriteCount), total_fav = sum(favoriteCount),
            avg_retweet = mean_sd(retweetCount, denote_sd = 'paren'),
            med_retweet = median(retweetCount), total_retweet = sum(retweetCount))


View(philosopher_summary_filtered)

stoic_versus_socrates_filtered <- philosopher_filtered%>%
  group_by(Stoic) %>%
  summarize(tweets = n(), distinct_users = n_distinct(screenName), avg_fav = mean_sd(favoriteCount, denote_sd = 'paren'), total_fav = sum(favoriteCount),
            avg_retweet = mean_sd(retweetCount, denote_sd = 'paren'), total_retweet = sum(retweetCount))

View(stoic_versus_socrates_filtered)

# Looking at the top users with the most counts that were cut out of the filtered

top_users <- filter(final_philosopher, favoriteCount > 1000)

View(top_users)


