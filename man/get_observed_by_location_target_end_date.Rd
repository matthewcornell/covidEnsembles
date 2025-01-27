% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/truth.R
\name{get_observed_by_location_target_end_date}
\alias{get_observed_by_location_target_end_date}
\title{get observed cases and/or deaths}
\usage{
get_observed_by_location_target_end_date(as_of, targets, spatial_resolution)
}
\arguments{
\item{as_of}{character date with format 'yyyy-mm-dd';
indicates date for which retrieved truth data should be current}

\item{targets}{character vector of targets to retrieve, for example
c('1 wk ahead cum death', '2 wk ahead cum death')}

\item{spatial_resolution}{character vector specifying spatial unit types to
include: 'county', 'state', 'national', and/or 'euro_countries'}
}
\value{
data frame with columns location, base_target, target_end_date, and
observed
}
\description{
get observed cases and/or deaths
}
