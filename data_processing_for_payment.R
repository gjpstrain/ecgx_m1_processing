library(tidyverse)

process_for_payment <- function (raw_df, identifier) {
  
  raw <- read_csv(raw_df) %>%
    select(c("participant", "unique_item_no", "AC_button.numClicks")) %>%
    filter(unique_item_no %in% c(121:128)) 
  
  total_correct_df <- raw %>% group_by(participant) %>%
    summarise(total_correct_AC = sum(AC_button.numClicks)) %>%
    mutate(passed = case_when(
      total_correct_AC >= 5 ~ TRUE,
      total_correct_AC <= 4 ~ FALSE
    )) %>%
    arrange(passed)
  
  write_csv(total_correct_df, paste0("exp_data/passed", identifier,".csv"))
  
}

process_for_payment("exp_data/ECG_X_EXP1_m1_ST.csv", "ST")

process_for_payment("exp_data/ECG_X_EXP1_m1_JT.csv", "JT")

process_for_payment("exp_data/ECG_X_EXP1_m1_STJ.csv", "STJ")




