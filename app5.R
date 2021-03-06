library(shiny)
library(RgeoProfile)
library(ggmap)
rm(list=ls(all=TRUE))


# Define UI for app that draws a histogram ----
ui <- fluidPage(

  tags$head(
    tags$style(HTML("hr {border-top: 1px solid #000000;}"))
  ),

  # App title ----
  #titlePanel("RgeoProfile!"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

	# Input: Slider for the zoom ----
	sliderInput(inputId = "zoom",
                  label = "Plot size:",
                  min = 200,
                  max = 1000,
                  value = 600),

	hr(),

	h4("Load Data"),
	fluidRow(
		column (6,
			fileInput("File1", "Events")
			),
		column (6,
			fileInput("File2", "Sources")
			)

	),

	hr(),

	h4("Generate Data"),

	fluidRow(
		column (4,
			numericInput("Latitude", "Latitude", "51.5235505")
			),
		column (4,
			numericInput("Longitude", "Longitude", "-0.04217491")
			),
		column (4,
			numericInput("numPoints", "numPoints", "50")
			),
		column (4,
			numericInput("Alpha", "Alpha", "1")
			),
		column (4,
			numericInput("Sigma", "Sigma", "1")
			),
		column (4,
			numericInput("Tau", "Tau", "3")
			),
		column (4,
			actionButton("generateButton", "Generate!")
			)
	),

	hr(),
	h4("Plot Data"),
actionButton("goButton", "Go!"),


	hr(),

	fluidRow(
		column (6,
			h4("Events"),
			tableOutput (outputId = "events")
			),
		column (6,
			h4("Sources"),
			tableOutput (outputId = "sources")
			)
	)
    ),

    # Main panel for displaying outputs ----
    mainPanel(
      # Output: RgeoProfile map ----
      imageOutput(outputId = "distPlot")

    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output, session) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plo


   x    <- faithful$waiting
  scale <- reactive ({input$zoom})

      observeEvent(input$goButton, {
		inFile <- input$File1
		d <- attr (session, "d")
		inFile <- input$File2
		s <- attr (session,"s")
		p <- geoParams(data = d, sigma_mean = 1.0, sigma_squared_shape = 2)
		m <- geoMCMC(data = d, params = p, lambda=0.05)

  		output$distPlot <- renderPlot({

			geoPlotMap(params = p, data = d, source = s, surface = m$geoProfile,
                		breakPercent = seq(0, 50, 5), mapType = "roadmap",
                		crimeCol = "black", crimeCex = 2, sourceCol = "red", sourceCex = 2)},height = scale, width = scale
    )
      })

      observeEvent(input$generateButton, {
		lattude <- input$Latitude
		longtude <- input$Longitude
		numPoints <- input$numPoints
		Alpha <- input$Alpha
		Sigma <- input$Sigma
		Tau <- input$Tau
		sim <-rDPM(numPoints, priorMean_longitude = longtude, priorMean_latitude = lattude, alpha=Alpha, sigma=Sigma, tau=Tau)
		attr (session,"d") <- geoData(sim$longitude, sim$latitude)
		attr (session,"s") <- geoData(sim$source_lon, sim$source_lat)
		d <- attr (session, "d")
		s <- attr (session,"s")

  		output$events <- renderTable(d)
  		output$sources <- renderTable(s)
      })

      observeEvent(input$File1, {
  		output$events <- renderTable({
			inFile <- input$File1
			attr (session,"d") <- read.table(inFile$datapath)
		})
	})

      observeEvent(input$File2, {
  		output$sources <- renderTable({
			inFile <- input$File2
			attr (session,"s") <- read.table(inFile$datapath)
		})
	})
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
