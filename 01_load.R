# Balsakhi RCT Replication — Banerjee & Duflo (2007)
# Bombay Year 1
# ============================================

# Load libraries
library(haven)
library(tidyverse)
library(fixest)
library(modelsummary)
library(gtsummary)

# ============================================
# 1. LOAD DATA
# ============================================

df <- read_dta("data/finalbombayyr1_1obs.dta")
glimpse(df)
names(df)

# ============================================
# 2. BALANCE TABLE
# ============================================

df %>%
  tbl_summary(
    by = bal,
    include = c(pre_totnorm, male, age),
    statistic = all_continuous() ~ "{mean} ({sd})"
  ) %>%
  add_p()

# ============================================
# 3. ATTRITION CHECK
# ============================================

df <- df %>%
  mutate(missing_post = ifelse(is.na(post_totnorm), 1, 0))

attrition_check <- feols(
  missing_post ~ bal,
  cluster = ~schoolid,
  data = df
)

summary(attrition_check)

# Result: bal = -0.004, p = 0.76
# No differential attrition by treatment status
# ITT estimates unlikely to be biased by selective dropout

# ============================================
# 4. ITT REGRESSION
# ============================================

# Without controls
m1 <- feols(post_totnorm ~ bal,
            cluster = ~schoolid, data = df)

# With baseline controls
m2 <- feols(post_totnorm ~ bal + pre_totnorm + male + age,
            cluster = ~schoolid, data = df)

# ============================================
# 5. HETEROGENEOUS EFFECTS BY GENDER
# ============================================

m3 <- feols(
  post_totnorm ~ bal + i(male, bal) + pre_totnorm + age,
  cluster = ~schoolid,
  data = df
)

# ============================================
# 6. ROBUSTNESS CHECK — HETEROSKEDASTIC SEs
# ============================================

m4 <- feols(
  post_totnorm ~ bal + pre_totnorm + male + age,
  vcov = "hetero",
  data = df
)

# ============================================
# 7. FINAL TABLE
# ============================================

modelsummary(list("No Controls" = m1,
                  "With Controls" = m2,
                  "Heterogeneous" = m3,
                  "Robust SEs" = m4),
             stars = TRUE,
             output = "outputs/regression_tables.docx")
