library(shiny)

generate_story <- function(noun, verb, adjective, adverb) {
  glue::glue("
    Once upon a time, in a land far, far, away, there was a {adjective} {noun} who loved to
    {verb} {adverb}. The {noun} was the {adjective}est {noun} in all of the land!
  ")
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
    shiny::validate(
      need(input(input$noun1 != '', 'Enter a noun.')),
      need(input(input$verb != '', 'Enter a verb.')),
      need(input(input$adjective != '', 'Enter an adjective.')),
      need(input(input$adverb != '', 'Enter a adverb.'))
    )
    story()
  })
}

shinyApp(ui = ui, server = server)
