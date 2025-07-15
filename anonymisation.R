library(tidyverse)

anonymise_function <- function (df, passed_df, identifier) {

data <- read_csv(df)

passed <- read_csv(passed_df)

passed_yes <- passed %>%
  filter(passed == TRUE)

just_passed <- inner_join(data, passed_yes, by = "participant")

final_data <- just_passed %>%
  group_by(participant) %>%
  dplyr::mutate(ID = cur_group_id())

final_data$participant <- NULL

final_data <- final_data %>%
  rename(participant = ID)

write_csv(final_data, paste0("exp_data/ECG_X_EXP1_m1_anon_", identifier,".csv"))

}

anonymise_function("exp_data/ECG_X_EXP1_m1_ST.csv", "exp_data/passedST.csv", "ST")

anonymise_function("exp_data/ECG_X_EXP1_m1_JT.csv", "exp_data/passedJT.csv", "JT")

anonymise_function("exp_data/ECG_X_EXP1_m1_SJT.csv", "exp_data/passedSJT.csv", "SJT")





