#### Compile song data
# Written by Abby Lewis
# Fall 2026

#### Load packages ####
library(tidyverse)

#### Load data ####
# https://www.kaggle.com/datasets/brianblakely/top-100-songs-and-lyrics-from-1959-to-2019?resource=download
lyrics_df <- read_csv(here::here("01a_Raw_data", "all_songs_data.csv")) %>%
  mutate(song_id = paste0(Year, "-", Rank))

#### Identify lake terms ####
lyrics_classified <- lyrics_df %>%
  mutate(
    lake = str_detect(Lyrics, "\\blakes?\\b"),
    reservoir = str_detect(Lyrics, "\\breservoirs?\\b"),
    pond = str_detect(Lyrics, "\\bponds?\\b"),
    wetland = str_detect(Lyrics, "\\bwetlands?\\b")
  )

lacustrine_terms <- c("lake", "pond", "reservoir", "wetland")

#### Format for downstream analyses ####
lyrics_long <- lyrics_classified %>%
  pivot_longer(
    cols = all_of(lacustrine_terms),
    names_to = "term",
    values_to = "present"
  ) %>%
  select(song_id, `Song Title`, Year, term, present)

#### Export ####
write_csv(
  lyrics_long,
  here::here("01b_Compiled_data", "lyrics_classified.csv")
)
