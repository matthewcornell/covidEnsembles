% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/retrospective_utils.R
\name{load_retrospective_ensemble_forecasts}
\alias{load_retrospective_ensemble_forecasts}
\title{Load retrospective ensemble forecasts that were made on or before}
\usage{
load_retrospective_ensemble_forecasts(
  submissions_root,
  forecast_dates,
  all_locations,
  spatial_scales = c("national", "state", "state_national", "county", "euro_countries"),
  response_vars = NULL
)
}
\arguments{
\item{submissions_root}{path to a folder containing submission files from
retrospective ensemble fits.  It should have subdirectories for each spatial
unit grouping used for estimation, i.e., "national", "state",
"state_national", and/or "county".  Within those folders, we expect a
sub-folder for each ensemble specification}

\item{response_vars}{character vector of response variables for which to
retrieve forecasts.  If missing or NULL, retrieves all appropriate for each
spatial scale}
}
\value{
data frame of forecasts in format suitable for use with covidHubUtils
functions
}
\description{
Load retrospective ensemble forecasts that were made on or before
}
