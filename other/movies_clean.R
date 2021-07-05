
movies <- read_csv("data/movies_original.csv")

movies <- movies %>%
  select(title, tagline, release_date,
         production_companies, 
         production_countries, 
         genres,
         budget, revenue, spoken_languages,
         runtime, status, keywords,
         vote_average, vote_count
  )


genres <- str_extract_all(movies$genres, "\"name\": \"[\\w[:space:]]*")
companies <- str_extract_all(movies$production_companies, "\"name\": \"[\\w[:space:]]*")
countries <- str_extract_all(movies$production_countries, "\"name\": \"[\\w[:space:]]*")
keywords <- str_extract_all(movies$keywords, "\"name\": \"[\\w[:space:]]*")

# every entry starts with this phrase
phrase <- "\"name\": \\"

de_jsonify <- function(vec) { 
  
  # first, delete name intro string
  xx <- sapply(vec, function(x) {str_sub(x, 10)})
  
  # then, turn list into character vector
  xxv <- lapply(xx, function(x) {
    paste(x, collapse = ", ")
  })
  
  unlist(xxv)
}

movies$genres <- de_jsonify(genres)
movies$production <- de_jsonify(companies); movies$production_companies <- NULL
movies$countries <- de_jsonify(countries); movies$production_countries <- NULL
movies$keywords <- de_jsonify(keywords)

# most are English, so just make indicator
table(str_detect(movies$spoken_languages, "English"))
movies$english <- ifelse(str_detect(movies$spoken_languages, "English"), 1, 0)
movies$spoken_languages <- NULL

movies$budget <- ifelse(movies$budget == 0, NA, movies$budget)
movies$revenue <- ifelse(movies$revenue == 0, NA, movies$revenue)

movies <- movies %>% filter(!is.na(genres) & genres != "" &
                              !is.na(production) & !is.na(keywords) &
                              keywords != "" & production != "")

# write.csv(movies, "../lessons/data/movies.csv", row.names = FALSE)
