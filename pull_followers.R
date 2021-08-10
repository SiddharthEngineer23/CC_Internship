library(rvest)

url = "https://rvest.tidyverse.org/articles/starwars.html"

page = read_html(url)

sections <- page %>% html_elements("section")
