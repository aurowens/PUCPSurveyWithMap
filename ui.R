
library(shiny)
library(shinyjs)
library(rjson)  
library(leaflet)

shinyUI(fluidPage(
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  
  titlePanel("Portland Urban Coyote Project"),
  div(
    id = "consentform",
    fluidRow(
      column(12,
             #img(src = "www/Consent(1).jpg", height = 1600, width = 711),
             tags$b("The Portland State University"),
             h3(""),
             tags$b("Consent to Participate in Research"),
             h3(""),
             tags$b("Portland Urban Coyote Project Sighting Research"),
             h3(""),
             p("March 4, 2015"),
             h3(""),
             tags$b("INTRODUCTION"),
             p("You are being asked to participate in a research study that is being done by Dr. Barbara Brower, who 
               is the Principal Investigator and graduate student researcher, Zuriel Rasmussen, from the Department of Geography, 
               at Portland State University in Portland, Oregon. This research is studying human-coyote interactions in Portland."),
             p("You are being asked to participate in the study because you may have observed a coyote in the Portland metropolitan area."),
             p("This form will explain the research study and will also explain the possible risks as well as the possible benefits to you.
               We encourage you to talk with your family and friends before you decide to take part in this research study. 
               If you have any questions, please ask one of the study investigators."),
             tags$b("I don't have a coyote observation to report, but I would like to contact the researchers behind the project"),
             p("You can contact the researchers by phone at 503-725-8044 or by email at portlandcoyote@gmail.com. Click here to be 
               directed back to the main site."), 
             tags$b("What will happen if I decide to participate?"),
             p("If you agree to participate, the following things will happen: On the next page you will be asked a few questions about 
               your coyote observation."),
             tags$b("How long will I be in this study?"),
             p("Participation in this study will take a total of 5-10 minutes"),
             tags$b("What are the risks or side effects of being in this study?"),
             p("There are risks of stress, emotional distress, inconvenience and possible loss of privacy and confidentiality associated with 
               participating in a research study."),
             p("For more information about risks and discomforts, ask the investigator."),
             tags$b("What are the benefits to being in this study?"),
             p("There are no direct benefits of being in this study. However, you will help us learn more about coyotes in Portland."),
             tags$b("How will my information be kept confidential?"),
             p("We will take measures to protect the security of all your personal information, but we cannot guarantee confidentiality of all study data.
               All of your responses from the survey will be secured in a password-protected database."),
             tags$b("Information contained in your study records is used by study staff. The Portland State University Institutional Review Board (IRB) that oversees
                    human subject research and/or other entities may be permitted to access your records, and there may be times when we are required by law to share your
                    information. It is the investigator's legal obligation to report child abuse, child neglect, elder abuse, harm to self or others or any life-threatening
                    situation to the appropriate authorities, and; therefore, your confidentiality will not be maintained."),
             h3(""),
             tags$b("Your name will not be used in any published reports about this study."),
             h3(""),
             tags$b("Will I be paid for taking part in this study?"),
             p("No."),
             tags$b("Can I stop being in the study once I begin?"),
             p("Your participation in this study is completely voluntary. You have the right to choose not to participate or to withdraw your participation at any point in this study
               without penalty or loss of benefits to which you are otherwise entitled."),
             tags$b("Whom can I call with questions or complaints about this study?"),
             p("If you have any questions, concerns, or complaints at any time about the research study, Dr. Barbara Brower, or his/her associates will be glad to answer them at 
               503-725-8044"),
             p("If you need to contact someone after business hours or on weekends, please call 503-725-8044 and ask for Dr. Brower."),
             tags$b("Whom can I call with questions about my rights as a research participant?"),
             p("If you have questions regarding your rights as a research participant, you may call the PSU Office for Research Integrity at 
               (503) 725-2227 or 1(877) 480-4400. The ORI is the office that supports the PSU Institutional Review Board (IRB). The IRB is a group
               of people from PSU and the community who provide independent oversight of safety and ethical issues related to research involving human
               participants. For more information, you may also access the IRB website at"),
             tags$a("https://sites.google.com/a/pdx.edu/research/integrity"),
             h3(""),
             tags$b("CONSENT"),
             p("You are making a decision whether to participate in this study. Your signature below indicates that you have read the information provided (or the information 
               was read to you). By signing this consent form, you are not waiving any of your legal rights as a research participant."),
             p("You have had an opportunity to ask questions and all questions have been answered to your satisfaction. By selecting, 'Yes, I consent to participate in this study 
               by reporting my sighting' below, you agree to participate in this study."),
             h3("Do you consent to participate in this study?"),
             
             fluidRow(
               column(6,
                      actionLink("give_consent", "Yes, I consent to participate in this study by reporting my sighting."),
                      fluidRow(
                        column(6, 
                               actionLink("no_consent",  "No, I do not want to participate in this study.")))))))),
  
  shinyjs::hidden(
    
    div(
      id = "form",
      #DT::dataTableOutput("responsesTable"),
      #downloadButton("downloadBtn", "Download responses"),
      h2("Report your coyote sighting"),
      h3("In this section, we will ask you five questions about the coyote you saw."),
      h4("Please enter the address, intersection, or landmark of sighting and check that the position on the map is correct. Once the map marker is in the 
         right location, move on to the next question."),
      textInput("location", labelMandatory("include street address, city, and zip code when possible")),
      actionButton("viewlocal", "View location on map"),
      leafletOutput("mymap"),
      h4("Please give your best estimate of the time and date of the sighting"),
      dateInput(inputId = "Date", label = labelMandatory("On what day you see the coyote(s)?"), max = today, min = today - 60, format = "mm/dd/yy"),
      textInput("time", labelMandatory("At what time did you see the coyote(s)?"), value = "12:00 AM"),
      
      radioButtons("number_of_coyotes", label = labelMandatory("How many coyotes did you see?"),
                   choices = c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4, "Five or More" = 5)),
  
      #p(),
      #includeHTML("include.html"),
      textInput("notes", "What was (were) the coyote(s) doing when you observed it (them)?"),
      radioButtons("recurrent", "Have you seen coyotes in this location before?", choices = c("Yes"= 1, "No" = 2)),
      h2("Tell us a bit about yourself."),
      textInput("zipcode", ("What is your zip code?")),
      radioButtons("hear_about_us", label = "How did you hear about this study?", 
                   choices = c("Audubon", "Internet Search",  "Facebook", "Twitter", "Portland State University Website", "Other")),
      textInput("other","If you selected 'Other', please take the time to explain where you heard about us"),
      textInput("contact", ("If you would like us to contact you please leave a phone number or email address where we can reach you")),
      textInput("comments", "Comments?"),
      actionButton("submit", "Submit", class = "btn-primary"),
      
      shinyjs::hidden(
        span(id = "submit_msg", "Submitting..."),
        div(id = "error",
            div(br(), tags$b("Error: "), span(id = "error_msg"))
        )
      )
    )
  ),
  div(id = "form"),
  shinyjs::hidden(
    div(
      id = "thankyou_msg",
      h3("Thanks, your response was submitted successfully!"),
      actionLink("submit_another", "Submit another report"),
      h3("Your coyote sighting will take some time to be processed before it will be visable on our site. 
        In the meantime, have you seen the other coyote observations made by Portlanders participating in this project?"), 
      tags$a(href = "http://pdxedu.maps.arcgis.com/apps/Viewer/index.html?appid=afc621b8067b48e9bbed171b2505b51a", 
             "Click here to be directed to the interactive map.")
      
    )
  ),
  shinyjs::hidden(
    div(
      id = "thank_you_no_consent",
      h3("Thank you for your interest in our project.")
    )
  )
  
             )
             )
