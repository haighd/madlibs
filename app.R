library(shiny)
library(useself)

generate_story <- function(noun, verb, adjective, adverb) {
  story <- glue::glue("
    Once upon a time, in a land far, far, away, there was a {adjective} {noun} who loved to
    {verb} {adverb}. The {noun} was the {adjective}est {noun} in all of the land!
  ")

  cat(story, file = stderr())
  story
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")#,
      # actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- reactive({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  output$story <- renderText({
    req(input$noun1, input$verb, input$adjective, input$adverb)
    story()
  })
}

shinyApp(ui = ui, server = server)
