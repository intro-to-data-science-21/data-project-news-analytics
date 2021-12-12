# 02-process-data ---------------------------------------------------------

headlines <- qpcR:::cbind.na(guardian, times, dailymail, independent, mirror, telegraph,
                             nytimes, wsj, usatoday, washingtonpost, latimes, tampabay, startribune)

headlines <- as.data.frame(headlines)

headlines <- pivot_longer(headlines, cols = everything())

headlines <- drop_na(headlines)

