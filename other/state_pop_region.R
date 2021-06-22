states <- read_csv("state_population.csv")

elections

ne <- c("CT", "ME", "MA", "NH",
        "RI", "VT", "NJ", "NY",
        "PA")
mw <- c("IL", "IN", "MI", "OH",
        "WI", "IA", "KS", "MN",
        "MO", "NE", "ND", "SD")
so <- c("DE", "FL", "GA", "MD",
        "NC", "SC", "VA", "DC",
        "WV", "AL", "KY", "MS",
        "TN", "AR", "LA", "OK",
        "TX")
we <- c("AZ", "CO", "ID", "MT",
        "NV", "NM", "UT", "WY",
        "AK", "CA", "HI", "OR",
        "WA")

states <- states %>%
  mutate(region = case_when(state %in% ne ~ "Northeast",
                            state %in% mw ~ "Midwest",
                            state %in% so ~ "South",
                            state %in% we ~ "West"))
write_csv(states, "state_population.csv")