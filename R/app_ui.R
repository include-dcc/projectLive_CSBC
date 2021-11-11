app_ui <- function(req) {
  projectlive.modules::oauth_ui(req, ui_function, OAUTH_LIST)
}

ui_function <- function(){
  shiny::tagList(
    golem_add_external_resources(),
    # waiter::use_waiter(),
    # waiter::waiter_show_on_load(html = span(
    #   style="color:white;",
    #   waiter::spin_pulsar(),
    #   shiny::h3("logging in...")
    # )),
    shiny::navbarPage(
      title = shiny::strong("projectLive"), selected = "Test",
    #   shiny::tabPanel(
    #     "About",
    #     projectlive.modules::synapse_module_ui("synapse_module"),
    #     icon = shiny::icon("info-circle")
    #   ),
      shiny::tabPanel(
        "Test",
        DT::dataTableOutput("htp_table"),
        icon = shiny::icon("info-circle")
      ),
      collapsible = TRUE,	inverse = TRUE,
      windowTitle = "projectLive"
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  shiny::addResourcePath(
    'www', system.file('app/www', package = 'projectLive')
  )
  
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    # add the next line to enable collection of synapse session token from browser cookie
    includeScript(system.file("inst/app/www/readCookie.js", package = "projectLive")), 
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
    )
}
