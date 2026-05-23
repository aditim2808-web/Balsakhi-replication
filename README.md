# Replication: Balsakhi Remedial Education Programme
### Banerjee, Duflo, Cole & Linden (2007) — Bombay Year 1

## Research Question
Does assignment to a Balsakhi remedial tutor improve normalised test scores 
for low-performing primary school students in Mumbai?

## Data
Source: J-PAL Dataverse, Harvard University  
Dataset: finalbombayyr1_1obs.dta (Bombay Year 1, one observation per child)  
N: 4,774 students across treatment and control schools  
Link: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UV6IXY

## Methods
- Balance checks across treatment and control arms (pre_totnorm, male, age)
- Intent-to-treat (ITT) regression with and without baseline controls
- Standard errors clustered at school level using fixest (R equivalent of Stata reghdfe)
-Standard errors are clustered at the school level because students within the same school may share correlated shocks, teachers, or institutional environments.
-Failing to cluster could underestimate uncertainty and overstate statistical significance
- Heterogeneous effects by gender via interaction term (bal × male)
-- Robustness check using heteroskedasticity-robust standard errors (m4) 
  to verify results are not sensitive to clustering assumption

## Key Findings
The Balsakhi programme improved normalised test scores by approximately 0.12-0.13 SD 
for treatment students (p<0.1). Heterogeneous effects analysis found no statistically 
significant difference in programme effectiveness by gender (bal × male = -0.035, p>0.1).

The Balsakhi programme improved normalised test scores by approximately 
0.12 SD for treatment students. Results are robust to alternative 
standard error specifications — with heteroskedasticity-robust SEs 
the treatment effect is 0.116 SD (p<0.001), strengthening confidence 
in the main finding. Heterogeneous effects analysis found no 
statistically significant difference in programme effectiveness 
by gender (male = 0 × bal = 0.013, p>0.1).


## Replication Notes
- Replicated using Bombay Year 1 subsample only, not full paper sample
- Main ITT estimate (0.116-0.132) consistent with paper's reported range (0.14-0.28 SD)
- Small differences attributable to sample restriction and specification choices
- 345 observations dropped due to missing endline scores (attrition)
- An attrition check (regressing missing_post on treatment assignment) 
found no significant differential attrition by treatment status 
(bal = -0.004, p = 0.76), suggesting ITT estimates are unlikely 
to be biased by selective sample dropout.
- 885 additional observations dropped when baseline controls added

## Limitations
This replication uses a single city-year subsample, limiting generalisability to 
the full study findings. The ITT estimate captures the effect of assignment to 
treatment, not actual programme receipt — some assigned students may not have 
attended. The gender heterogeneity analysis was pre-specified as a single 
hypothesis to avoid multiple comparisons; results should be interpreted 
cautiously given marginal significance of the main effect.

## Requirements
R 4.5+  
Packages: haven, tidyverse, fixest, modelsummary, gtsummary