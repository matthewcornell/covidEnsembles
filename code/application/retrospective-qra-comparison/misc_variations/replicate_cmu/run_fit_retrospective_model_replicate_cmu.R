library(tidyr)
library(dplyr)
library(readr)
library(lubridate)
library(doParallel)
library(zeallot)
library(covidEnsembles)

registerDoParallel(cores = 28)

output_path <- "code/application/retrospective-qra-comparison/misc_variations/replicate_cmu/log/"

#spatial_resolution <- "state_no_territories"
spatial_resolution <- "state"

analysis_combinations <- dplyr::bind_rows(
  tidyr::expand_grid(
    response_var = "inc_death",
    forecast_week_end_date = as.character(
      lubridate::ymd("2020-10-05")), # + seq(from = 0, length = 21) * 7),
    intercept = "FALSE",
    combine_method = "convex",
    quantile_group_str = "3_groups",
    missingness = "mean_impute",
    window_size = c(4, 8),
    check_missingness_by_target = "TRUE",
    do_standard_checks = "FALSE",
    do_baseline_check = "FALSE"
  ),
  tidyr::expand_grid(
    response_var = "inc_death",
    forecast_week_end_date = as.character(
      lubridate::ymd("2020-10-05")), # + seq(from = 0, length = 21) * 7),
    intercept = "FALSE",
    combine_method = c("median", "ew"),
    quantile_group_str = "per_model",
    missingness = "by_location_group",
    window_size = 0,
    check_missingness_by_target = "FALSE",
    do_standard_checks = "FALSE",
    do_baseline_check = "FALSE"
  )
)

# analysis_combinations <- analysis_combinations %>%
#   dplyr::filter(
#     do_baseline_check == 'TRUE',
#     (window_size %in% c(0, 3, 4) & constraint == 'ew' & do_standard_checks == 'FALSE') |
#     (window_size %in% c(3, 4) & intercept == 'FALSE' & constraint == 'convex' & quantile_group_str == '3_groups' & do_standard_checks == 'FALSE') |
#     (window_size %in% c(3, 4) & intercept == 'TRUE' & constraint == 'positive' & quantile_group_str == '3_groups' & do_standard_checks == 'FALSE')
#   )

foreach(row_ind = seq_len(nrow(analysis_combinations))) %dopar% {
# foreach(row_ind = seq_len(2)) %dopar% {
  response_var <- analysis_combinations$response_var[row_ind]
  forecast_week_end_date <-
    analysis_combinations$forecast_week_end_date[row_ind]
  intercept <- analysis_combinations$intercept[row_ind]
  combine_method <- analysis_combinations$combine_method[row_ind]
  quantile_group_str <- analysis_combinations$quantile_group_str[row_ind]
  missingness <- analysis_combinations$missingness[row_ind]
  window_size <- analysis_combinations$window_size[row_ind]
  check_missingness_by_target <-
    analysis_combinations$check_missingness_by_target[row_ind]
  do_standard_checks <- analysis_combinations$do_standard_checks[row_ind]
  do_baseline_check <- analysis_combinations$do_baseline_check[row_ind]

  run_cmd <- paste0(
    "R CMD BATCH --vanilla \'--args ",
    response_var, " ",
    forecast_week_end_date, " ",
    intercept, " ",
    combine_method, " ",
    missingness, " ",
    quantile_group_str, " ",
    window_size, " ",
    check_missingness_by_target, " ",
    do_standard_checks, " ",
    do_baseline_check, " ",
    spatial_resolution,
    "\' code/application/retrospective-qra-comparison/misc_variations/replicate_cmu/fit_retrospective_model_replicate_cmu.R ",
    output_path, "output-", response_var, "-", forecast_week_end_date, "-",
    intercept, "-", combine_method, "-", missingness, "-", quantile_group_str,
    "-", window_size, "-", check_missingness_by_target, "-",
    do_standard_checks, "-", do_baseline_check, ".Rout")

  system(run_cmd)
}
