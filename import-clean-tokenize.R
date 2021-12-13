library(tidyverse)
library(fs)

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


# cleaning with function --------------------------------------------------

headlines <- clean_data(headlines)


# tokenizing --------------------------------------------------------------

headlines <- headlines %>% 
  unnest_tokens(output = word, input = headline) %>% 
  anti_join(stop_words)


# test graph --------------------------------------------------------------

gen_plot <- headlines %>% 
  count(word, sort = TRUE, name = "n")

gen_plot %>% 
  arrange(desc(n)) %>% 
  slice(1:10) %>% 
  ggplot(aes(x = reorder(word, -n), y = n)) +
  geom_bar(stat = "identity")
