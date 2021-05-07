library(twitteR)
library(purrr)
library(dplyr)

library(ggplot2)
library(rtweet)
library(formattable)
library(data.table)

consumerKey = "5PNvlGgIZMwhIN3BtntJerxRB"  
consumerSecret = "TU7GVfelw42fmw7jWRptWsRQK6qbVicxSGkF9ffq2QWX8bPwGB"
accessToken = "1333915496765218821-8DedtJvgQEGjGfPxxRQIIZ4yJ4yZvL"
accessSecret = "sicaVBRWhXeYENENBJrHaRgtrVb0LkVGH0dgKiTt010nV"
options(httr_oauth_cache=TRUE)
setup_twitter_oauth(consumer_key = consumerKey, consumer_secret = consumerSecret,
                    access_token = accessToken, access_secret = accessSecret)


# Using search Twitter function to find data on different types of Stoic hashtags
# Leaving out retweets since only original tweets are wanted.

philosophy_quotes <- searchTwitter("#philosophy exclude:retweets", n=3200)

stoicism_quotes <- searchTwitter("#stoicism exclude:retweets", n=3200)

stoic_quotes <- searchTwitter("#Stoic exclude:retweets", n=3200)

Seneca_quotes <- searchTwitter("#Seneca exclude:retweets", n=3200)

Marcus_quotes <- searchTwitter("#Aurelius exclude:retweets", n=3200)

Epictetus <- searchTwitter("#Epictetus exclude:retweets", n=3200)

Musonius <- searchTwitter("#Musonius exclude:retweets", n=3200)

Socrates <- searchTwitter("#Socrates exclude:retweets", n=3200)

#Since philosophy maxed out moves up number returned to max number which it is under.

philosophy_full <- searchTwitter("#philosophy exclude:retweets", n=18000)

Seneca_kw <- searchTwitter("Seneca exclude:retweets", n=18000)

Epictetus_kw <- searchTwitter("Epictetus exclude:retweets", n=18000)

Aurelius_kw <- searchTwitter("Aurelius exclude:retweets", n=18000)

Musonius_kw <- searchTwitter("Musonius exclude:retweets", n=18000)

Socrates_kw <- searchTwitter("Socrates exclude:retweets", n=18000)

# Turning the data returned into data frames.

stoicism_hashtags_df <- tbl_df(map_df(stoicism_quotes, as.data.frame))

write.csv(stoicism_hashtags_df, "stoicismhashtags.csv")

philosophy_hashtags_df <- tbl_df(map_df(philosophy_full, as.data.frame))

write.csv(philosophy_hashtags_df, "philosophyhashtags.csv")

aurelius_kw_df <- tbl_df(map_df(Aurelius_kw, as.data.frame))

write.csv(aurelius_kw_df, "aurelius_kw_df.csv")

aurelius_tags_df <- tbl_df(map_df(Marcus_quotes, as.data.frame))

write.csv(aurelius_tags_df, "aurelius_tags_df.csv")

seneca_kw_df <- tbl_df(map_df(Seneca_kw, as.data.frame))

write.csv(seneca_kw_df, "seneca_kw_df.csv")

epictetus_kw_df <- tbl_df(map_df(Epictetus_kw, as.data.frame))

write.csv(epictetus_kw_df, "epictetus_kw_df.csv")

musonius_kw_df <- tbl_df(map_df(Musonius_kw, as.data.frame))

write.csv(musonius_kw_df, "musonius_kw_df.csv")

socrates_kw_df <- tbl_df(map_df(Socrates_kw, as.data.frame))

write.csv(socrates_kw_df, "socrates_kw_df.csv")





