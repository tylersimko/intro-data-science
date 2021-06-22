

wc <- read_csv("~/Downloads/world_cup.csv")
wc <- wc[1:361,]

wc_winners <- tibble(year = seq(1930, 2018, by = 4),
                     team = c("Uruguay", "Italy", "Italy",
                                "Not held", "Not held", 
                                "Uruguay", "Germany", 
                                "Brazil", "Brazil", "England",
                                "Brazil", "Germany", "Argentina",
                                "Italy", "Argentina", "Germany",
                                "Brazil", "France", "Brazil", "Italy", 
                                "Spain", "Germany", "France"),
                     wc_winner = TRUE)

colnames(wc) <- c("year", "team", "iso", "scored", "conceded",
                  "penalties", "matches", "shots_on_goal", "shots_wide",
                  "free_kicks", "offside", "corners", "won", "drawn", "lost")
wc$year <- as.numeric(wc$year)

wc <- wc %>%
  left_join(wc_winners, by = c("year", "team"))

wc$wc_winner <- ifelse(is.na(wc$wc_winner), FALSE, TRUE)
write_csv(wc, "~/Desktop/world_cups.csv")
