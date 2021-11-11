require(magrittr)
require(rlang)

app_server <- shinyServer(function(input, output, session) {
  
  access_token = projectlive.modules::get_oauth_access_token(
    oauth_list = OAUTH_LIST, session = session
  )
  
  syn <- synapseclient$Synapse()
  syn$login(authToken = access_token)
  
  output$title <- shiny::renderUI({
    shiny::titlePanel(sprintf("Welcome, %s", syn$getUserProfile()$userName))
  })
  
  # projectlive.modules::synapse_module_server(
  #   id = "synapse_module",
  #   syn = syn,
  #   config = shiny::reactive(
  #     jsonlite::read_json("inst/synapse_module.json")
  #   )
  # )
  
  googledrive::drive_auth(email = "andrew.lamb@sagebase.org")
  
  googledrive::drive_download(
    "https://docs.google.com/spreadsheets/d/10RVYIuW3lW7wV6yIEDirhiyhrrL1_vvO/edit#gid=1091731933",
    path = "htp.xlxs"
  )

  htp_tbl <- readxl::read_excel("htp.xlxs", skip = 6)
  file.remove("htp.xlxs")

  output$htp_table = DT::renderDataTable({
    htp_tbl
  })
  

  

})
