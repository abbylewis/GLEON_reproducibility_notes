#### Plot song data
# Written by Abby Lewis
# Fall 2026

#### Load packages ####
library(tidyverse)

#### Load data ####
lyrics_long <- read_csv(here::here("01b_Compiled_data", "lyrics_classified.csv"))

#### Set plot theme ####
theme_eco <- egg::theme_article() +
  theme(plot.background = element_rect(fill = "white"))

#### Calculate prevalence ####
prevalence_by_term <- lyrics_long %>%
  group_by(term) %>%
  summarise(
    n_songs = length(unique(song_id)),
    n_with_term = length(unique(song_id[present])),
    prevalence = n_with_term / n_songs,
    .groups = "drop"
  ) 

#### Plot ####
prevalence_by_term %>%
  ggplot(
    aes(
      x = term,
      y = prevalence
    )
  ) +
  geom_col() +
  scale_y_continuous(
    labels = scales::percent_format()
  ) +
  ylab("Songs containing term") +
  theme_eco +
  theme(
    legend.position = "none",
    axis.title.x = element_blank()
  )

ggsave(here::here("03_Figures", "prevalence_by_term.png"), width = 3, height = 3)
