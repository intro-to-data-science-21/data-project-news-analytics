# Cleaning data -----------------------------------------------------------



# loading packages --------------------------------------------------------

library(tidyverse)
library(stringr)
library(tidyr)


headlines <- read.csv("data/headlines-2021-12-08-15-01-14-CET .csv")

clean_data <- function(x) { # x = path
  df <- read_csv(x) 
  df$time <- as.POSIXct(df$time) %>% as.character() %>% str_replace_all("[ :]", "-")
  df <- select(df, -"...1")
  df$value <- gsub("<.*?>", "", df$value) # remove html tages
  df$value <- gsub(' +',' ', df$value) # remove more than one space
  df$value <- str_trim(df$value, side = c("both", "left", "right")) # remove spaces at start and end
  df[df == ""] <- NA #adding NAs to blank cells
  df <- na.omit(df) # remove NAs
  df <- rename(df, headline = value)
}

