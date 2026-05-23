library(tidyverse)
library(gtsummary)

# Balance table
df %>%
  tbl_summary(
    by = bal,
    include = c(pre_totnorm, male, age),
    statistic = all_continuous() ~ "{mean} ({sd})"
  ) %>%
  add_p()
