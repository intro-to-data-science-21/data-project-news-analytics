# 00-install-packages-from-CRAN  -----------------------------------------------------------------

p_needed <- c("tidyverse", "xml2", "rvest", "tidytext", "stringr", "gtools", "qpcR", "croR")  # tidyverse packages

packages <- rownames(installed.packages())
p_to_install <- p_needed[!(p_needed %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}
lapply(p_needed, require, character.only = TRUE)

# 01-scrape-data ----------------------------------------------------------

# define function
scrape <- function(x, y) {
  x = read_html(x)
  y = gsub('"', "'", y) # replace single quotation marks with double quotation marks to prevent syntax error
  hl = html_elements(x, xpath = y)
  hl_raw = html_text(hl)
  hl_raw = unique(hl_raw)
}

# UK newspapers
guardian <- scrape("https://www.theguardian.com/international",
                   "//*[contains(@class, 'u-faux-block-link__overlay js-headline-text')]")

times <- scrape("https://www.thetimes.co.uk/", '//*[contains(concat( " ", @class, " " ),
                concat( " ", "Item-headline", " " ))]//*[contains(concat( " ", @class, " " ),
                concat( " ", "js-tracking", " " ))]')

dailymail <- scrape("https://www.dailymail.co.uk/home/index.html",
                    '//*[contains(concat( " ", @class, " " ),
                    concat( " ", "articleHeadline-2YOjz", " " ))] | //*[contains(concat( " ", @class, " " ),
                    concat( " ", "title_parRW", " " ))] | //*[contains(concat( " ", @class, " " ),
                    concat( " ", "headline_3jlV2", " " ))] | //strong | //*[contains(concat( " ", @class, " " ),
                    concat( " ", "linkro-darkred", " " ))]//a')

independent <- scrape("https://www.independent.co.uk/", '//*[contains(concat( " ", @class, " " ),
                      concat( " ", "video-title", " " ))] | //*[contains(concat( " ", @class, " " ),
                      concat( " ", "title", " " ))]')

mirror <- scrape("https://www.mirror.co.uk/", '//*[contains(concat( " ", @class, " " ), concat( " ", "story__title", " " ))]')

telegraph <- scrape("https://www.telegraph.co.uk/", '//*[contains(concat( " ", @class, " " ), concat( " ", "u-clickable-area__link", " " ))]')

# US newspapers

nytimes <- scrape("https://www.nytimes.com", '//*[contains(concat(" ", @class, " " ),
                  concat( " ", "e1lsht870", " " ))] | //*[contains(concat( " ", @class, " " ),
                  concat(" ", "balancedHeadline", " " ))]')

wsj <- scrape("https://www.wsj.com", '//*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--headline--nQ8J-FfZ", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "style--headline--2BxmSWrz", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--stipple__link--2vFfymvf", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--headlineText--He1ANr9C", " " ))]')

usatoday <- scrape("https://eu.usatoday.com/news/", '//*[contains(concat( " ", @class, " " ),
                   concat( " ", "p12-title", " " ))] | //*[contains(concat( " ", @class, " " ),
                   concat( " ", "p13-text-wrap", " " ))] | //*[contains(concat( " ", @class, " " ),
                   concat( " ", "p1-title-spacer", " " ))]')

washingtonpost <- scrape("https://www.washingtonpost.com/", '//*[contains(concat( " ", @class, " " ),
                         concat( " ", "left", " " )) and contains(concat( " ", @class, " " ),
                         concat( " ", "relative", " " ))]//span')

latimes <- scrape("https://www.latimes.com/", '//*[contains(concat( " ", @class, " " ),
                  concat( " ", "promo-title", " " ))]//*[contains(concat( " ", @class, " " ),
                  concat( " ", "link", " " ))]')

tampabay <- scrape("https://www.tampabay.com/", '//*[contains(concat( " ", @class, " " ),
                   concat( " ", "headline", " " ))]//a | //*[contains(concat( " ", @class, " " ),
                   concat( " ", "ui__headline", " " ))]')

startribune <- scrape("https://www.startribune.com/",
                      '//*[(@id = "home_main_video_link")] | //*[contains(concat( " ", @class, " " ),
                      concat( " ", "headline", " " ))] | //*[contains(concat( " ", @class, " " ),
                      concat( " ", "tease-headline", " " ))]')

# AUS newspapers

heraldsun <- scrape("https://www.heraldsun.com.au/", '//*[contains(concat( " ", @class, " " ),
                    concat( " ", "storyblock_title_link", " " ))]')

dailytelegraph <- scrape("https://www.dailytelegraph.com.au/",
                         '//*[contains(concat( " ", @class, " " ),
                         concat( " ", "storyblock_title_link", " " ))]')

financialreview <- scrape("https://www.afr.com/", '//h3//a')

couriermail <- scrape("https://www.couriermail.com.au/", '//*[contains(concat( " ", @class, " " ),
                      concat( " ", "storyblock_title_link", " " ))]')


# Canada newspapers

# 02-process-data ---------------------------------------------------------

headlines <- qpcR:::cbind.na(guardian, times, dailymail, independent, mirror, telegraph,
                             nytimes, wsj, usatoday, washingtonpost, latimes, tampabay, startribune)

headlines <- as.data.frame(headlines)

headlines <- pivot_longer(headlines, cols = everything())

headlines <- drop_na(headlines)

headlines$time <- Sys.time()



# 03-download-data --------------------------------------------------------

write.csv(headlines, file = "headlines.csv")






