
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyjs)
library(googlesheets)
library(ggmap)

shinyServer(function(input, output) {
  
  observeEvent(input$give_consent, {
    shinyjs::show("form")
    shinyjs::hide("consentform")
  }) 
  observeEvent(input$no_consent,{
    shinyjs::show("thank_you_no_consent")
    shinyjs::hide("consentform")
  })
  observe({
    
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               if (class(input[[x]]) == "Date"){
                 !is.null(input[[x]]) 
               }else{
                 !is.null(input[[x]]) && input[[x]] != ""
               }
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    
    # enable/disable the submit button
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    lon = geocode_latlon(input$location)$lon
    lat = geocode_latlon(input$location)$lat
    data <- c(data, timestamp = epochTime(), lon = lon, lat= lat)
    data <- t(data)
    data
  })
  saveData <- function(data) {
    # Grab the Google Sheet
    sheet <- gs_title(table)
    # Add the data as a new row
    gs_add_row(sheet, input = data)
  }
  
  # action to take when submit button is pressed
  
  observeEvent(input$submit, {
    shinyjs::disable("submit")
    shinyjs::show("submit_msg")
    shinyjs::hide("error")
    
    tryCatch({
      saveData(formData())
      shinyjs::reset("form")
      shinyjs::hide("form")
      shinyjs::show("thankyou_msg")
    },
    error = function(err) {
      shinyjs::html("error_msg", err$message)
      shinyjs::show(id = "error", anim = TRUE, animType = "fade")
    },
    finally = {
      shinyjs::enable("submit")
      shinyjs::hide("submit_msg")
    })
  })
  output$responsesTable <- DT::renderDataTable(
    loadData(),
    rownames = FALSE,
    options = list(searching = FALSE, lengthChange = FALSE)
  ) 
  
  observeEvent(input$viewlocal, {
    output$mymap <- renderLeaflet({
      lc <- geocode_latlon(input$location)
      leaflet() %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
        addMarkers(lng=lc$lon, lat=lc$lat, popup=as.character(input$location))
    })
  })
  
  observeEvent(input$submit_another, {
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
  }) 
})
