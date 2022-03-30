library(shinycssloaders)
library(shiny)
library(dplyr)
library(shinythemes)
library(plotly)
library(DT)
library(tidyverse)
library(purrr)
library(bbplot)
library(tidymodels)
library(ingredients)
library(ISLR)
library(DALEX)
library(caret)
library(DALEXtra)
library(iBreakDown)
library(gridExtra)
library(highcharter)
library(themis)
library(shinyalert)
library(flexdashboard)
library(shinyjs)
library(forcats)
library(ggplot2)
library(thematic)
library(bslib)
library(showtext)
library(anicon)
library(shinyanimate)
library(xgboost)
library(randomForest)
library(shinycustomloader)

source("css_churn2.R")

source("important_data2.R")












#my_theme <- bs_theme(bootswatch = "darkly",
#base_font = font_google("Righteous"))

# Let thematic know to update the fonts, too
#thematic_shiny(font = "auto")



ui<-fluidPage(
  
  #theme = bslib::bs_theme(bootswatch = "darkly"),
  #theme = shinytheme("cyborg"),
  tags$style(cssUPGRADE),
  # Pass that theme object to UI function
  #theme = my_theme,
  #extendShinyjs(text = jscode, functions = "init"),
  
tags$head(HTML("<script type='text/javascript'>

shinyjs.init=function() {
 
$('#navbar li a[data-value=tab1]').hide();

$('#navbar li a[data-value=tab2]').hide();

$('#navbar li a[data-value=tab3]').hide();

}
</script>")),
  
  
  useShinyjs(),
  
  #useShinyalert(force=TRUE),
  
  navbarPage(
    id="navbar",
    "Churn Analytics",
    tabPanel(title = "Welcome",      
             value = "tab1",
             
             
             
             
    
          
          
          
               
             br(),
             br(),
             br(),
             #opening page intro with moving text
             HTML("<h1>
        <span>There</span>
        <span>are</span>
        <span>no</span>
        <span>limits</span>
        <span>to</span>
        <span>what</span>
        <span>you</span>
        <span>can</span>
        <span>accomplish,</span>
        <span>except</span>
        <span>the</span>
        <span>limits</span>
        <span>you</span>
        <span>place</span>
        <span>on</span>
        <span>your</span>
        <span>own</span>
        <span>thinking,</span>
        <span>are</span>
        <span>no</span>
        <span>limits</span>
        <span>to</span>
        <span>what</span>
        <span>you</span>
        <span>can</span>
        <span>accomplish,</span>
        <span>except</span>
        <span>the</span>
        <span>limits.</span>
          </h1>"),
             
             
             
             
             
             
             
                              
             
              
             
             
             
    
    ),
    tabPanel(title="Start Page",
            value = "tab2",
    
             
             HTML("<h2 class='glowIn'>Most Important Variables</h2>"),
             
             
             HTML("<p>Welcome to this Churn analysis app! The original IBM dataset contained the information of 7043 fictional telecommunications customers, with 21 variables relating to whether or not they churned. This app employs cutting-edge artifical intelligence to uncover key relationships between Churn and a range of variables.
                 In keeping with traditional data analytics, the original dataset was partitioned into a training and test set.</p>
                    <details>
                    <summary>Read more</summary>
                 Three algorithms were trained: using the original dataset with its inherent class imbalance of churners/non-churners, a random forest
                 model was constructed. In addition, using upsampled data (oversampling of the minority class of churners), a
                 gradient boosting and a random forest model were also trained."),
             
             br(),
             
             
             p("Upsampling produces a balanced dataset, and aims to
                 eliminate the predictive bias produced by imbalanced datasets.The dependent variable Churn signifies whether the customer departed within the last month or not.
                 The response,",span("No", style = "color:#BB86FC")," ,signifies the customers who did not leave the company last month, while the response, ",span("Yes", style = "color:#BB86FC"),", indicates the clients that decided to terminate their relations with the company. Gauging the likelihood of customer churn is of primary concern for large companies; the potential impact on revenue, particularly in the telecommunications sector, is of paramount importance.
                                                                                                                                                               Whilst the definition of most terms are likely to be clear, clarification of some potentially confusing terms is given below :"),    
             tags$ul(
               tags$li(tags$b("Tenure"), " - Number of months the customer has stayed with the company"),
               tags$li(tags$b("Multiple lines"), " - Whether the customer has multiple lines or not (",span("Yes, No, No phone service", style = "color:#BB86FC"),")"),
               tags$li(tags$b("Monthly Charges"), " - The amount charged to the customer monthly"),
               tags$li(tags$b("Total Charges"), " - The total amount charged to the customer"),
               tags$li(tags$b("Churn"), " - Whether the customer churned or not, i.e. left the company (",span("Yes or No", style = "color:#BB86FC"),")"),
               tags$li(tags$b("XGB_UP"), " - Extreme Gradient Boosting, a type of tree-based algorithm that was trained using upsampled data "),
               tags$li(tags$b("Random_Forest_Up"), " - Random Forest algorithm trained on upsampled data 
                       
                       
                       
                       
                       
                  </details>")),
             
             p("Welcome to this Churn analysis app! The original IBM dataset contained the information of 7043 fictional telecommunications customers, with 21 variables relating to whether or not they churned. This app employs cutting-edge artifical intelligence to uncover key relationships between Churn and a range of variables.
                 In keeping with traditional data analytics, the original dataset was partitioned into a training and test set. Three algorithms were trained: using the original dataset with its inherent class imbalance of churners/non-churners, a random forest
                 model was constructed. In addition, using upsampled data (oversampling of the minority class of churners), a
                 gradient boosting and a random forest model were also trained."),
             
             br(),
             
             
             p("Upsampling produces a balanced dataset, and aims to
                 eliminate the predictive bias produced by imbalanced datasets. The dependent variable Churn signifies whether the customer departed within the last month or not.
                 The response,",span("No", style = "color:#BB86FC")," ,signifies the customers who did not leave the company last month, while the response, ",span("Yes", style = "color:#BB86FC"),", indicates the clients that decided to terminate their relations with the company. Gauging the likelihood of customer churn is of primary concern for large companies; the potential impact on revenue, particularly in the telecommunications sector, is of paramount importance.
                                                                                                                                                               Whilst the definition of most terms are likely to be clear, clarification of some potentially confusing terms is given below :"),    
             tags$ul(
               tags$li(tags$b("Tenure"), " - Number of months the customer has stayed with the company"),
               tags$li(tags$b("Multiple lines"), " - Whether the customer has multiple lines or not (",span("Yes, No, No phone service", style = "color:#BB86FC"),")"),
               tags$li(tags$b("Monthly Charges"), " - The amount charged to the customer monthly"),
               tags$li(tags$b("Total Charges"), " - The total amount charged to the customer"),
               tags$li(tags$b("Churn"), " - Whether the customer churned or not, i.e. left the company (",span("Yes or No", style = "color:#BB86FC"),")"),
               tags$li(tags$b("XGB_UP"), " - Extreme Gradient Boosting, a type of tree-based algorithm that was trained using upsampled data "),
               tags$li(tags$b("Random_Forest_Up"), " - Random Forest algorithm trained on upsampled data "),
             ),
             
             
             
             
             
    ),
    
    tabPanel(title="Visuals",
             value="tab3",
         
             sidebarPanel(
               
               tags$style(".well {background-color: #1F1B24  ;}"),
               
               
               
               
               
               
               
               
               
               
               
               
               
               
               selectInput(inputId="HIGHCHARTCHOICE", label="Select Plot:", choices =c("Count Compare", "Churn Proportion Variation", "Churn Count Variation", "Electronic Count", "Multiple Lines",  "InternetService Variation"),  selected = "Churn Proportion Variation", width =  '350px'),  
               
               sliderInput("MonthlyChargesInput", "Monthly Charges",  min = min(train_data$MonthlyCharges), max = max(train_data$MonthlyCharges) , c(min(train_data$MonthlyCharges), max = max(train_data$MonthlyCharges)),
                           pre = "$"),
               
               
               
               sliderInput("TotalChargesInput", "Total Charges",  min = min(train_data$TotalCharges), max = max(train_data$TotalCharges) , c(min = min(train_data$TotalCharges), max = max(train_data$TotalCharges)),
                           pre = "$"),
               
               sliderInput("TenureInput", "Tenure",  min = min(train_data$tenure), max = max(train_data$tenure), c(min = min(train_data$tenure), max = max(train_data$tenure)),
                           pre = "Months"),
               
               
               
               
               
               
               
               
               
               
               
             ),
             mainPanel(
               
               
               
               
               br(),
               
               withSpinner(highchartOutput("HIGHCHARTOPT", height = "160%", width="100%")),  
               br(),
               
               
               
               
               
               
               
               
               
               
               
               
               
               br(),
               
               
               
               
               
               
               
               
               
               
             )
    ),
    
    tabPanel("Key Variables",
             sidebarPanel(
               
               
               
               radioButtons(inputId = "VARIABLE_IMPORTANCE_COMP",
                            label = "Compare Variable Importance",
                            choices = c("Random Forest", "Random Forest Up","XGB Up")),
               
               withAnim(),
               
               
               
               
               
             ),
             mainPanel(
               
               
               #moving text effect
               HTML("<h2 class='glowIn'>Most Important Variables</h2>"),
                  
               
               hr(),
               fluidRow(column(12, div(actionButton("vimpress", icon("info"),
                                                    style="color: #fff; background-color: #9D00FF; width:70px; height:80px; border-color: #2e6da4"), style = "float: right"))),
               
               br(),
               plotOutput("PlotImportance"),
               br(),
               
               
               
               
               
               
               
               
             )
    ),
    
    tabPanel("ALE Plots",
             sidebarPanel(
               
               
               
               
               
               selectInput(inputId = "VariableOPT",
                           label = "Variable choose : ",
                           choices = c("tenure", "TotalCharges","MonthlyCharges","PaymentMethod","Contract","InternetService","MultipleLines"),
                           selected = "", width =  '200px'),
               
               
               
               
               
               
               
               
               
             ),
             mainPanel(
               
               tags$h2("ALE plot insight!"),
               HTML("<div class='button'>HOVER ME</div>"),
               hr(),
               
               fluidRow(column(12, div(shiny::actionButton(
               'ALEpress', 
                                                    class='button', label='i',  style= 
                                                    'float: right')))),
               
               
               
               
               br(),
               withSpinner(plotOutput("ACCUMULATEDDEPENDENCE", height="100px")), 
               
             
               
               br(),
               h2("What are ALE plots?"),
               hr(),
               tags$div(HTML("<p><strong><span style='color:white;'>Accumulated local effects (ALE) illustate how variables impact the predicted outcome of an machine learning algorithm on average.<p><details>
                    <summary>Read more</summary>
                          For numerical variables, the ALE algorithm averages the difference in small windows of a variable's range. ALE graphs are centered at 0.
                          If the reading for variable X, at the point X=3, translates as -4, this can roughly be interpreted as indicating that the prediction at this value is lower than the average prediction by 4 units. In a nutshell,
                          ALE plots illustate how the predictions of a machine learning model alter between subsections of an independent variable's overall range. The impact of categorical features can be similarly interpreted: each bar
                          indicates the modification in the model's predicition when the respective feature possesses the respective property.</span></strong></details>")),
               
               
               
               
             )
             
    ),    
    tabPanel("BreakDown Profiles",
             verticalLayout(
             ),
             sidebarLayout(
               sidebarPanel(
                 
                 
                 
                 radioButtons("plot_features",
                              label = HTML('<FONT color="#BB86FC"><FONT size="6pt">Select model type:</FONT></FONT>'),
                              choices =  c("Random_Forest","Random_Forest_Up","Xgb_Up"),
                              selected = "Random_Forest",
                              inline = T,
                              width = "100%"),
                 
                 
                 
                 
                 numericInput(inputId="row_index",
                              label= "Select customer (1-5000)",
                              value=1,
                              min=1, max=20,  width = '150px')  
                 
                 
                 
                 
               ),
               mainPanel(
                 
                 
                 br(),
                 
                 tags$h2("Breakdown Profiles"),
                 hr(),
                 
                 
                 
                 
                 
                 br(),
                 withSpinner(plotOutput("EASIER", height="100px")), 
                 
                 
                 
                 br(),
                 br(),
                 
                 htmlOutput("DESCRIBEVARY"),
                 
                 
                 br(),
                 h2("What are Breakdown Plots conveying?"),
                 hr(),
                 HTML("<p><strong><span style='color:white;'>There are two broad types of model explanatory tools, namely local and global. For instance,
                         ALE plots yield an overall understanding of a model's predictions aggregated over an entire dataset.</p>
                    <details>
                    <summary>Read more</summary>The breakdown algorithm provides local explanations: in other words, they help provide information
                         about a prediction for a single observation. This algorithm helps unveil which particular variables contribute the most to a specific observation/prediction. From the top down of the breakdown plots featured above: the intercept row indicates the overall mean value of predictions for the model when trained on the entire dataset. The green and red bars signify the contribution of each variable towards the overall prediction. Red bars
                         indicate that the respective variable decreases the probability that the particular customer will churn, whereas green bars represent variables that increase the likelihood a customer will churn. The purple bar shows the prediction for the particular customer in question. The numerical values
                         capture the extent of influence of respective variables. </span></strong></details>"),
                 
                 
                 
                 
         
                 
                 
                 br(),
                 br(),
                 
                 
                 
               )
             )
    ),
    
    
    
    tabPanel("New Predictions",
             fluidPage(
               
               tags$h2("Select a model, and enjoy making new predictions!"),
               
               
               hr(),
               fluidRow(column(12, div(actionButton("metricmessage", icon("info"), style="color: #fff; width:70px; height:80px; background-color: #9D00FF; border-color: #2e6da4"), style = "float: right"))),                                  
               
               br(),
               
               
               
               
               
               fluidRow(
                 column(3, offset=4,tags$b("Performance results from test data shown below!"),)),
               textOutput('greeting'),
               br(),
               #tags$h3(class="shiny","Predicted Probability of Churn:"),
               #textOutput(outputId = "forlabelresult"),
               
               fluidRow(
                 column(2, radioButtons(inputId = "MODELCHOICE",
                                        label = HTML('<FONT color="#BB86FC"><FONT size="6pt">Select model:</FONT></FONT>'),
                                        choices = c("RANDOM_FOREST","RF_UP","XGB_UP"))),
                 
                 
                 #column(1, offset=1, withAnim(),
                 #div( id = 'shinyLogo', tags$img(src= "https://hineon.com/wp-content/uploads/2019/09/neon-arrow.jpg", width = "100px", height = "100px"))),      
                 
                 column(6, offset=2, withSpinner(plotOutput("PlotResults", width = "500px", height = "300px"))),
                 
                 
                 
                 
                 
                 
               ),
               
               
               
               hr(),
               
               fluidRow(
                 column(3, #offset = 1,
                        
                        h4(class="glow","Predicted Probaility of Churn:"),
                        #textOutput(outputId = "forlabelresult"),
                        withSpinner(gaugeOutput("GAUGER", width = "300px", height = "100px")),
                        br(),
                        #textOutput(outputId = "forlabelresult"),
                        htmlOutput("some_text"),
                        hr(),
                        #radioButtons(inputId = "MODELCHOICE",
                        #label = HTML('<FONT color="#9B59F6"><FONT size="5pt">Select model type</FONT></FONT>'),
                        #choices = c("RANDOM_FOREST","RF_UP","XGB_UP")),
                        
                        selectInput(inputId="PaperlessBillingChoice", label="Paperless Billing:", choices =levels(train_data$PaperlessBilling),  selected = "Yes", width =  '100px'),  
                        selectInput(inputId="PaymentMethodChoice", label="Payment Method:", choices =levels(train_data$PaymentMethod),  selected = "Electronic Count", width =  '100px'),
                        
                        
                        
                        
                        
                 ),
                 column(2,
                        selectInput(inputId="DependentsChoice", label="Dependents:", choices =levels(train_data$Dependents),  selected = "No", width =  '100px'),  
                        selectInput(inputId="PartnerChoice", label="Partner:", choices =levels(train_data$Partner),  selected = "No", width =  '100px'),  
                        
                        selectInput(inputId="OnlineSecurityChoice", label="Online Security:", choices =levels(train_data$OnlineSecurity),  selected = "No", width =  '100px'),
                        selectInput(inputId="ContractChoice", label="Contract:", choices =levels(train_data$Contract),  selected = "Yes", width =  '100px'),  
                        selectInput(inputId="InternetServiceChoice", label="Internet Service:", choices =levels(train_data$InternetService),  selected = "No", width =  '100px'),
                 ),
                 column(2,
                        
                        selectInput(inputId="StreamingMoviesChoice", label="Streaming Movies", choices =levels(train_data$StreamingMovies),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="PhoneServiceChoice", label="Phone Service:", choices =levels(train_data$PhoneService),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="DeviceProtectionChoice", label="Device Protection:", choices =levels(train_data$DeviceProtection),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="MultipleLinesChoice", label="Multiple Lines:", choices =levels(train_data$MultipleLines),  selected = "No", width =  '100px'),
                        
                        
                 ),
                 column(2,
                        
                        selectInput(inputId="OnlineBackupChoice", label="Online Backup:", choices =levels(train_data$OnlineBackup),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="StreamingTVChoice", label="Streaming TV:", choices =levels(train_data$StreamingTV),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="SeniorCitizenChoice", label="Senior Citizen:", choices =levels(train_data$SeniorCitizen),  selected = "Yes", width =  '100px'),
                        selectInput(inputId="TechSupportChoice", label="Tech Support:", choices =levels(train_data$TechSupport),  selected = "Yes", width =  '100px'),
                 ),
                 column(3,
                        
                        
                        
                        
                        sliderInput("TenureIn", "Tenure",  min = min(train_data$tenure), max = max(train_data$tenure) , value = min(train_data$tenure)
                        ),
                        sliderInput("TotalChargesIn", "Total Charges",  min = min(train_data$TotalCharges), max = max(train_data$TotalCharges) , value = min(train_data$TotalCharges)
                                    , pre = "$"),
                        sliderInput("MonthlyChargesIn", "Monthly Charges",  min = min(train_data$MonthlyCharges), max = max(train_data$MonthlyCharges) , value = min(train_data$MonthlyCharges)
                                    , pre = "$"),
                        
                        radioButtons("GenderIn", "Gender",
                                     choices = c("Male","Female"),
                                     selected = "Male")),
               ) ,
               
               fluidRow(
                 br(),
                 
                 p("This web application was designed and built by",
                   span("Gamal Gabr", style = "color:orange"),
                   ". If you would like me to build you a customised app, please feel free to contact me via", span ("gamal.gabr444@outlook.com", style = "color:orange")),
                 
               )
               
             )
             
    )
  )
  
  
)
