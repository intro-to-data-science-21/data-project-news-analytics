library(tidyverse)
library(fs)
library(tidytext)

# importing csv files -----------------------------------------------------
file_paths <- fs::dir_ls("data")
file_paths

file_contents <- list()

for (i in seq_along(file_paths)) {
  file_contents[[i]] <- read_csv(
    file = file_paths[[i]]
  )
}

file_contents <- set_names(file_contents, file_paths)

headlines <- do.call(rbind, file_contents)


# cleaning with function - before tokenizing! --------------------------------------------------

clean_data <- function(x) { # x = path
  df <- x
  df$time <- as.POSIXct(df$time) %>% as.character() %>% str_replace_all("[ :]", "-")
  df <- select(df, -"...1")
  df$value <- gsub("<.*?>", "", df$value) # remove html tages
  df$value <- gsub(' +',' ', df$value) # remove more than one space
  df$value <- str_trim(df$value, side = c("both", "left", "right")) # remove spaces at start and end
  df[df == ""] <- NA #adding NAs to blank cells
  df <- na.omit(df) # remove NAs
  df <- rename(df, headline = value)
}


headlines <- clean_data(headlines)

headlines <- headlines %>% # maximum of 5500 headlines to avoid distortion, escecially of uk newspaper dailymail
  group_by(name) %>% 
  slice(1:5500) %>%  # change this number when importing last datasets!!
  ungroup() %>% 
  mutate(country = dplyr::case_when(name == "guardian" ~ "UK",
                                    name == "times" ~ "UK",
                                    name == "dailymail" ~ "UK",
                                    name == "independent" ~ "UK",
                                    name == "mirror" ~ "UK",
                                    name == "telegraph" ~ "UK",
                                    name == "nytimes" ~ "US",
                                    name == "wsj" ~ "US",
                                    name == "usatoday" ~ "US",
                                    name == "washingtonpost" ~ "US",
                                    name == "latimes" ~ "US",
                                    name == "tampabay" ~ "US",
                                    name == "heraldsun" ~ "Australia",
                                    name == "dailytelegraph" ~ "Australia",
                                    name == "financialreview" ~ "Australia",
                                    name == "couriermail" ~ "Australia",
                                    name == "westaustralian" ~ "Australia",
                                    name == "advertiser" ~ "Australia",
                                    name == "globeandmail" ~ "Canada",
                                    name == "thestar" ~ "Canada",
                                    name == "nationalpost" ~ "Canada",
                                    name == "torontosun" ~ "Canada",
                                    name == "vancouversun" ~ "Canada",
                                    name == "montrealgazette" ~ "Canada",
                                    name == "nzherald" ~ "New-Zealand",
                                    name == "waikato" ~ "New-Zealand",
                                    name == "businessreview" ~ "New-Zealand",
                                    name == "gisborneherald" ~ "New-Zealand",
                                    name == "dominionpost" ~ "New-Zealand",
                                    name == "thepress" ~ "New-Zealand"),
         
          format = dplyr::case_when(name == "dailymail" ~ "tabloid",
                                    name == )
m
  

tabloid
- dailymail
- mirror
- couriermail
- west-australian
- advertiser
- toronto
- new zealand herald
                                               
# tokenizing --------------------------------------------------------------

headlines_tok <- headlines %>% 
  unnest_tokens(output = word, input = headline) %>% 
  anti_join(stop_words) 

# clean -------------------------------------------------------------------

headlines_tok <- headlines_tok %>% 
  filter(!grepl('content|subscriber|read|star|10|9|min|l.a|wa|nz|canada|uk|west', word))  # dailymail uses the word star everywhore


# test graph --------------------------------------------------------------
gen_plot <- headlines_tok %>%  
  count(word, sort = TRUE, name = "n")

gen_plot %>% 
  arrange(desc(n)) %>% 
  slice(1:30) %>%
  ggplot(aes(x = reorder(word, -n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip()


lol <- headlines_sliced %>% 
  group_by(name) %>% 
  count()
