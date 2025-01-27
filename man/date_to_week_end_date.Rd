% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/date_management.R
\name{date_to_week_end_date}
\alias{date_to_week_end_date}
\title{Calculate week end date (i.e., Saturday) for the MMWR epidemic week that is
offset a specified number of epidemic week from a specified date}
\usage{
date_to_week_end_date(
  forecast_date,
  week_offset = 0,
  return_type = "character"
)
}
\arguments{
\item{forecast_date}{vector of dates}

\item{week_offset}{integer vector of week offsets.  must be either length 1 or the same
length as timezero}

\item{return_type}{character specifying return type as "date" or "character"}
}
\value{
vector of dates in 'yyyy-mm-dd' format
}
\description{
Calculate week end date (i.e., Saturday) for the MMWR epidemic week that is
offset a specified number of epidemic week from a specified date
}
