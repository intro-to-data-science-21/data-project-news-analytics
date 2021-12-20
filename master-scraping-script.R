# 00-install-packages-from-CRAN  -----------------------------------------------------------------
library(cronR)
library(tidyverse)
library(xml2)
library(rvest)
library(stringr)
library(httr)

# 01-scrape-data ----------------------------------------------------------

# define function
scrape <- function(x, y) {
  rvest_session <- session(x, 
                           add_headers(`From` = "koenoosthoek@gmail.com", 
                                       `UserAgent` = R.Version()$version.string))
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

# AUS newspapers

heraldsun <- scrape("https://www.heraldsun.com.au/", '//*[contains(concat( " ", @class, " " ),
                    concat( " ", "storyblock_title_link", " " ))]')

dailytelegraph <- scrape("https://www.dailytelegraph.com.au/",
                         '//*[contains(concat( " ", @class, " " ),
                         concat( " ", "storyblock_title_link", " " ))]')

financialreview <- scrape("https://www.afr.com/", '//h3//a')

couriermail <- scrape("https://www.couriermail.com.au/", '//*[contains(concat( " ", @class, " " ),
                      concat( " ", "storyblock_title_link", " " ))]')

westaustralian <- scrape("https://thewest.com.au/", '//*[contains(concat( " ", @class, " " ), concat( " ", "e1w8lw9x7", " " ))]')

advertiser <- scrape("https://www.adelaidenow.com.au/", '//*[contains(concat( " ", @class, " " ), concat( " ", "storyblock_title_link", " " ))]')

# Canada newspapers

globeandmail <- scrape("https://www.theglobeandmail.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "c-card__hed", " " ))]')

thestar <- scrape("https://www.thestar.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "c-mediacard__heading", " " ))]//span')

nationalpost <- scrape("https://nationalpost.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "article-card__headline-clamp", " " ))]')

torontosun <- scrape("https://torontosun.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "article-card__headline-clamp", " " ))]')

vancouversun <- scrape("https://vancouversun.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "article-card__headline-clamp", " " ))]')

montrealgazette <- scrape("https://montrealgazette.com/", '//*[contains(concat( " ", @class, " " ), concat( " ", "article-card__headline-clamp", " " ))]')

# NZ newspapers 

nzherald <- scrape("https://www.nzherald.co.nz/", '//*[contains(concat( " ", @class, " " ), concat( " ", "story-card__heading__link", " " ))]')

waikato <- scrape("https://www.stuff.co.nz/waikato-times", '//*[contains(concat( " ", @class, " " ), concat( " ", "it-article-headline", " " ))]//a')

businessreview <- scrape("https://www.nbr.co.nz/", '//*[contains(concat( " ", @class, " " ), concat( " ", "headline", " " ))]//a')

gisborneherald <- scrape("https://www.gisborneherald.co.nz/", '//*[contains(concat( " ", @class, " " ), concat( " ", "mostread__headline-marker", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "latestnews__headline-marker", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "teaser__headline-marker", " " ))]')

dominionpost <- scrape("https://www.stuff.co.nz/dominion-post", '//*[contains(concat( " ", @class, " " ), concat( " ", "ATF", " " ))]//a | //*[contains(concat( " ", @class, " " ), concat( " ", "reorder-disabled", " " ))]//a')

thepress <- scrape("https://www.stuff.co.nz/the-press", '//*[(@id = "left_col")]//*[contains(concat( " ", @class, " " ), concat( " ", "it-article-headline", " " ))]//a')

# 02-process-data ---------------------------------------------------------

headlines <- list(guardian, times, dailymail, independent, mirror, telegraph,
                  nytimes, wsj, usatoday, washingtonpost, latimes, tampabay,
                  heraldsun, dailytelegraph, financialreview, couriermail, westaustralian, advertiser,
                  globeandmail, thestar, nationalpost, torontosun, vancouversun, montrealgazette,
                  nzherald, waikato, businessreview, gisborneherald, dominionpost, thepress)

headlines <- stringi::stri_list2matrix(headlines)
headlines <- as.data.frame(headlines)
headlines <- rename(headlines, 
                    guardian = V1,
                    times = V2,
                    dailymail = V3,
                    independent = V4,
                    mirror = V5,
                    telegraph = V6,
                    nytimes = V7,
                    wsj = V8,
                    usatoday = V9,
                    washingtonpost = V10,
                    latimes = V11,
                    tampabay = V12,
                    heraldsun = V13,
                    dailytelegraph = V14,
                    financialreview = V15,
                    couriermail = V16,
                    westaustralian = V17,
                    advertiser = V18,
                    globeandmail = V19,
                    thestar = V20,
                    nationalpost = V21,
                    torontosun = V22,
                    vancouversun = V23,
                    montrealgazette = V24,
                    nzherald = V25,
                    waikato = V26,
                    businessreview = V27,
                    gisborneherald = V28,
                    dominionpost = V29,
                    thepress = V30)

headlines <- pivot_longer(headlines, cols = everything())

headlines <- drop_na(headlines)

headlines$time <- Sys.time()

datetime <- format(as.POSIXct(Sys.time(), tz = Sys.timezone()), usetz = TRUE)  %>% as.character() %>% str_replace_all("[ :]", "-")



# 03-download-data --------------------------------------------------------

write.csv(headlines, file = paste0("headlines-", datetime, ".csv"))






