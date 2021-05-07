
# Removing the columns that have the reply to with a SN with the keyword.
# These are not referencing the Stoic but the twitter user in the tweet.

aurelius_no_sn <- aurelius_kw_df %>% filter(!grepl('Aurelius|aurelius', replyToSN))

# Removing screennames with the Stoic name since they show up as well

aurelius_fixed <- aurelius_no_sn %>% filter(!grepl('Aurelius|aurelius', screenName))

# Selecting the columns that are needed from the dataframe that will be looked at.

aurelius_df <- select(aurelius_fixed, favoriteCount, retweetCount, screenName)
head(aurelius_df)

# Seneca requires a number of extra filters not only on screennames but text.
# There are roads named seneca, sports, schools, and a confusion over vaccine spelling.

seneca_no_sn <- seneca_kw_df %>% filter(!grepl('Seneca|seneca', replyToSN))

seneca_no_screen <- seneca_no_sn %>% filter(!grepl('Seneca|Astro|Astra', screenName, ignore.case = TRUE))

seneca_no_sports <- seneca_no_screen %>% filter(!grepl('Football|Baseball|Softball|Basketball', screenName, ignore.case = TRUE))

seneca_no_sports_text <- seneca_no_sports %>% filter(!grepl('Football|Baseball|Softball|Basketball|Soccer', text, ignore.case = TRUE))

seneca_no_streets <- seneca_no_sports_text %>% filter(!grepl('St|Ave|Blvd|Rd', text, ignore.case = TRUE))

seneca_vaccine <- seneca_no_streets %>% filter(!grepl('Astra|dose|shot|vaccine|Hum', text, ignore.case = TRUE))

seneca_other_words <- seneca_vaccine %>% filter(!grepl('Valley|High|Score|School|College|Team', text, ignore.case = TRUE))

seneca_df <- select(seneca_other_words, favoriteCount, retweetCount, screenName)


epictetus_no_sn <- epictetus_kw_df %>% filter(!grepl('Epictetus', replyToSN, ignore.case = TRUE))


epictetus_fixed <- epictetus_no_sn %>% filter(!grepl('Epictetus', screenName, ignore.case = TRUE))


epictetus_df <- select(epictetus_fixed, favoriteCount, retweetCount, screenName)
head(epictetus_df)

musonius_no_sn <- musonius_kw_df %>% filter(!grepl('Musonius', replyToSN, ignore.case = TRUE))


musonius_fixed <- musonius_no_sn %>% filter(!grepl('Musonius', screenName, ignore.case = TRUE))


musonius_df <- select(musonius_fixed, favoriteCount, retweetCount, screenName)
head(musonius_df)

socrates_no_sn <- socrates_kw_df %>% filter(!grepl('Socrates', replyToSN, ignore.case = TRUE))

# Socrates needed some texts removed for a politician, athlete and bank.

socrates_no_text <- socrates_no_sn %>% filter(!grepl('Jose|José|@socrates|Bancos|Brito', text, ignore.case = TRUE))

socrates_fixed <- socrates_no_text %>% filter(!grepl('Socrates', screenName, ignore.case = TRUE))


socrates_df <- select(socrates_fixed, favoriteCount, retweetCount, screenName)
head(socrates_df)

# Adding columns to each dataframe for who the philosopher is and if they are a stoic

socrates_final <- socrates_df

socrates_final$philosopher <- 'Socrates'
socrates_final$Stoic <- 'No'
head(socrates_final)

musonius_final <- musonius_df

musonius_final$philosopher <- 'Musonius Rufus'
musonius_final$Stoic <- 'Yes'
head(musonius_final)

epictetus_final <- epictetus_df

epictetus_final$philosopher <- 'Epictetus'
epictetus_final$Stoic <- 'Yes'
head(epictetus_final)

seneca_final <- seneca_df

seneca_final$philosopher <- 'Seneca'
seneca_final$Stoic <- 'Yes'
head(seneca_final)

aurelius_final <- aurelius_df

aurelius_final$philosopher <- 'Marcus Aurelius'
aurelius_final$Stoic <- 'Yes'

head(aurelius_final)

# Putting all the philosopher data together in one dataframe.

final_philosopher <- rbind(socrates_final, musonius_final, epictetus_final, seneca_final, aurelius_final)

View(final_philosopher)




