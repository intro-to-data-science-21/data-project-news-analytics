# 01-scrape-data ----------------------------------------------------------

# define function
scrape <- function(x, y) {
  x = read_html(x)
  y = gsub('"', "'", y) # replace single quotation marks with double quotation marks to prevent syntax error
  hl = html_elements(x, xpath = y)
  hl_raw = html_text(hl)
  hl_raw = unique(hl_raw)
}

guardian <- scrape("https://www.theguardian.com/international",
                   "//*[contains(@class, 'u-faux-block-link__overlay js-headline-text')]")

nytimes <- scrape("https://www.nytimes.com", '//*[contains(concat(" ", @class, " " ),
                  concat( " ", "e1lsht870", " " ))] | //*[contains(concat( " ", @class, " " ),
                  concat(" ", "balancedHeadline", " " ))]')

times <- scrape("https://www.thetimes.co.uk/", '//*[contains(concat( " ", @class, " " ),
                concat( " ", "Item-headline", " " ))]//*[contains(concat( " ", @class, " " ),
                concat( " ", "js-tracking", " " ))]')

wsj <- scrape("https://www.wsj.com", '//*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--headline--nQ8J-FfZ", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "style--headline--2BxmSWrz", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--stipple__link--2vFfymvf", " " ))] | //*[contains(concat( " ", @class, " " ),
              concat( " ", "WSJTheme--headlineText--He1ANr9C", " " ))]')

independent <- scrape("https://www.independent.co.uk/", '//*[contains(concat( " ", @class, " " ),
                      concat( " ", "video-title", " " ))] | //*[contains(concat( " ", @class, " " ),
                      concat( " ", "title", " " ))]')

