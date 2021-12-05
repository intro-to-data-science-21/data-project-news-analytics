# 02-process-data ---------------------------------------------------------

headlines <- qpcR:::cbind.na(guardian, nytimes, times, wsj, independent)

headlines <- as.data.frame(headlines)

headlines <- pivot_longer(headlines, cols = everything())

headlines <- drop_na(headlines)

