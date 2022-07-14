library("sodium")
library("shinyauthr")
library("devtools")
library("shinymanager")
library("shiny")
library("DT")
#library("leaflet")
library("dplyr")
library("fontawesome")
library("shinydashboard")
library("shinycssloaders")
#.libPaths("/home/mbotos/R/x86_64-pc-linux-gnu-library/4.2/")
#install.packages("sodium")
#install.packages("leaflet",dependencies=TRUE)
#install_github("r-spatial/sf")

# r_colors <- rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

# textOutput("testloc")

# output$testloc <- renderText({ 
#   
#   paste("Last start inserted is", input$GPSs, "\nLast land inserted is", input$GPSl)
#   
# 
#   })
# 

inactivity <- "function idleTimer() {
var t = setTimeout(logout, 120000);
window.onmousemove = resetTimer; // catches mouse movements
window.onmousedown = resetTimer; // catches mouse movements
window.onclick = resetTimer;     // catches mouse clicks
window.onscroll = resetTimer;    // catches scrolling
window.onkeypress = resetTimer;  //catches keyboard actions

function logout() {
window.close();  //close the window
}

function resetTimer() {
clearTimeout(t);
t = setTimeout(logout, 120000);  // time is in milliseconds (1000 is 1 second)
}
}
idleTimer();"


# data.frame with credentials info
credentials <- data.frame(
  user = c("mbotos","fwieland"),
  password = c("volador","pass1"),
  start = c("2022-04-01","2022-04-01"),
  expire = c(NA,NA),
  admin = c(TRUE,FALSE),
  comment = "Simple and secure authentification mechanism
  for single ‘Shiny’ applications.",
  stringsAsFactors = FALSE
)

#initialiez a dataframe
# v <- reactiveValues()
# v$df <- data.frame(FlightNumber = numeric(),
#                    Date = character(),
#                    Country = character(),
#                    Region = character(),
#                    Hour = numeric(),
#                    StartPosition = character(),
#                    Brand = character(),
#                    Model = character(),
#                    Height = numeric(), 
#                    TimeFlying = numeric(),
#                    LandingPosition = character(),
#                    Comments = character(),
#                    GPSs = numeric(),
#                    GPSl = numeric(),
#                    stringsAsFactors = TRUE)

ui <- secure_app(head_auth = tags$script(inactivity),
                 dashboardPage(skin = "purple",
                               dashboardHeader(title = "Heart Injuries"),
                               dashboardSidebar(width = 300,
                                                sidebarMenu(
                                                  menuItem("Home",tabName = "home",icon = icon("home")),
                                                  menuItem("Dashboard",tabName = "dashboard",icon = icon("apple",lib = "glyphicon")),
                                                  menuItem("Amputation vs Sham",tabName = "amputated", icon = icon("map-marker",lib = "glyphicon")),#,icon = icon("calendar",lib = "glyphicon")),
                                                  menuItem("Ablation vs Sham",tabName = "ablated",icon = icon("map-marker",lib = "glyphicon")),
                                                  menuItem("Cryoiunjury vs Sham",tabName = "cryoinjured",icon = icon("map-marker",lib = "glyphicon")),
                                                  menuItem("Uninjured vs Sham",tabName = "uninjured",icon = icon("map-marker",lib = "glyphicon")),
                                                  menuItem("Heart core regeneration common genes ",tabName = "heartcore",icon = icon("map-marker",lib = "glyphicon")),
                                                  menuItem("About",tabName = "about",icon = icon("thumbtack"))
                                                )),
                               dashboardBody(
                                 tabItems(
                                   tabItem(tabName = "home",
                                           #home section and markdown
                                           includeMarkdown("/media/marius/Samsung_T5/PhD/Projects/prsa/Outputs/r/Cytoscape/Cleaned_Annotation_Ensembl_v4/ResultsCytoscape/PossibleShiny/RShinyCode/www/markdown_home.md")),
                                   
                                   #next tab
                                   tabItem(tabName = "dashboard",
                                           fluidRow(
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "blue_value_box")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "purple_value_box")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "red_value_box")),
                                           ),
                                           fluidRow(
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_landing_spot1")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_landing_spot2")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_landing_spot3")),
                                             
                                           ),
                                           fluidRow(
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_start_spot1")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_start_spot2")),
                                             column(width = 4,valueBoxOutput(width = 12,outputId = "top_start_spot3")),
                                           )),
                                   
                                   
                                   #next tab
                                   #widths
                                   #https://stackoverflow.com/questions/70689513/how-to-have-shiny-dashboard-box-fill-the-entire-width-of-my-dashbaord
                                   #next tab
                                   tabItem(tabName = "amputated",
                                           #map part
                                           visNetworkOutput(outputId = "amputated_net",width = "100%", height = "1000px") %>% withSpinner()),
                                   
                                   tabItem(tabName = "ablated",
                                           #map part
                                           visNetworkOutput(outputId = "ablated_net",width = "100%", height = "1000px") %>% withSpinner()),
                                   
                                   tabItem(tabName = "cryoinjured",
                                           #map part
                                           visNetworkOutput(outputId = "cryoinjured_net",width = "100%", height = "1000px") %>% withSpinner()),
                                   
                                   tabItem(tabName = "uininjured",
                                           #map part
                                           visNetworkOutput(outputId = "uninjured_net",width = "100%", height = "1000px") %>% withSpinner()),
                                           # plotOutput(outputId = "uininjured_net",width = "1980px", height = "1000px")),
                                   
                                   
                                   tabItem(tabName = "heartcore",
                                           visNetworkOutput(outputId = "heartcore_net",width = "100%", height = "1000px") %>% withSpinner()),
                                           #map part
                                           # plotOutput(outputId = "heartcore_net",width = "1980px", height = "1000px",hover = TRUE)),
                                   
                                   #next tab
                                   tabItem(tabName = "about",
                                           h2("Created and scractched by: "),
                                           tags$a("Marius Botos",
                                                  href = "https://sporgelum.github.io/"))
                                 )# end tabItems
                                 # Add download button 
                               )# end dashboardBody
                 )# end dashboardPage
)#end all

require(visNetwork)
server <- function(input, output, session) {
  
  result_auth <- secure_server(check_credentials = check_credentials(credentials))
  
  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })
  
  
  output$amputated_net = renderVisNetwork({
    visNetwork::visIgraph(amp) |>  visOptions(selectedBy = "AA_C") |>   visInteraction(navigationButtons = TRUE) |> visNetwork::visLayout(randomSeed = 123456)
    
  })
  
  output$ablated_net = renderVisNetwork({
    visNetwork::visIgraph(unj) |>  visOptions(selectedBy = "AA_C") |>   visInteraction(navigationButtons = TRUE) |> visNetwork::visLayout(randomSeed = 123456)
    
  })
  
  output$cryoinjured_net = renderVisNetwork({
    visNetwork::visIgraph(unj) |>  visOptions(selectedBy = "AA_C") |>   visInteraction(navigationButtons = TRUE) |> visNetwork::visLayout(randomSeed = 123456)
    
  })
  output$uninjured_net = renderVisNetwork({
    visNetwork::visIgraph(unj) |>  visOptions(selectedBy = "AA_C") |>   visInteraction(navigationButtons = TRUE) |> visNetwork::visLayout(randomSeed = 123456)
    # l <- layout_with_fr(unj)
    # plot.igraph(unj,edge.color="green",layout=l,vertex.color = "white",vertex.size=8,
    #             mark.groups = groups_id,
    #             mark.col = group_color_fill,
    #             mark.border = group_color)
    # 
    # 
    # legend('topright', legend = names(groups_id),
    #        col = group_color,
    #        pch = 15, bty = "n",  pt.cex = 1.5, cex = 0.8,
    #        text.col = "black", horiz = FALSE)
  })
  
  # output$heartcore_net = renderPlot({
  output$heartcore_net = renderVisNetwork({
    visNetwork::visIgraph(core) |>  visOptions(selectedBy = "AA_C") |>   visInteraction(navigationButtons = TRUE) |> visNetwork::visLayout(randomSeed = 123456)

  })
  
  
  
  # 
  # 
  output$blue_value_box <- renderValueBox(valueBox(value = paste0("Selected genes: ",vertex_attr(unj)$`EnrichmentMap::Genes`[1]),color="blue",subtitle = "Enrichment Map Genes"))
  output$purple_value_box <- renderValueBox(valueBox(value = paste0("Interesting genes: ",unlist(vertex_attr(core)$`EnrichmentMap::Genes`[1])) ,color="purple",subtitle = "Enrichment Map Genes"))
  # output$red_value_box <- renderValueBox(valueBox(value = paste0("Sad flights: ",v$df %>% dplyr::filter(Feeling == "Sad") %>% dplyr::count()),color = "red",subtitle = "Sad"))
  # output$top_start_spot1 <- renderValueBox(valueBox(value = paste0("Start: ",v$df %>% dplyr::count(StartPosition,sort = TRUE) %>% slice(1) %>% pull(StartPosition)),color = "orange",subtitle = "Top-1"))
  # output$top_start_spot2 <- renderValueBox(valueBox(value = paste0("Start: ",v$df %>% dplyr::count(StartPosition,sort = TRUE) %>% slice(2) %>% pull(StartPosition)),color = "lime",subtitle = "Top-2"))
  # output$top_start_spot3 <- renderValueBox(valueBox(value = paste0("Start: ",v$df %>% dplyr::count(StartPosition,sort = TRUE) %>% slice(3) %>% pull(StartPosition)),color = "olive",subtitle = "Top-3"))
  # output$top_landing_spot1 <- renderValueBox(valueBox(value = paste0("Landing: ",v$df %>% dplyr::count(LandingPosition,sort = TRUE) %>% slice(1) %>% pull(LandingPosition)),color = "orange",subtitle = "Top-1"))
  # output$top_landing_spot2 <- renderValueBox(valueBox(value = paste0("Landing: ",v$df %>% dplyr::count(LandingPosition,sort = TRUE) %>% slice(2) %>% pull(LandingPosition)),color = "lime",subtitle = "Top-2"))
  # output$top_landing_spot3 <- renderValueBox(valueBox(value = paste0("Landing: ",v$df %>% dplyr::count(LandingPosition,sort = TRUE) %>% slice(3) %>% pull(LandingPosition)),color = "olive",subtitle = "Top-3"))
  
  
}

shinyApp(ui = ui, server = server) 