fieldsMandatory <- c("Date", "time", "number_of_coyotes", "location")

today <- as.Date(Sys.Date())
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
appCSS <-
  ".mandatory_star { color: red; }
#error { color: red; }"

fieldsAll <- c("location","Date","time","number_of_coyotes","recurrent", "notes","zipcode", "hear_about_us","other", "contact", "comments")
responsesDir <- file.path("responses")
imDir <- file.path("www")
epochTime <- function() {
  (Sys.time())
}
loadData <- function() {
  # Grab the Google Sheet
  sheet <- gs_title(table)
  # Read the data
  gs_read_csv(sheet)
}

humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

table <- "PUCP Reports"

geocode_latlon <- function(x) geocode(x, output = "latlon")



