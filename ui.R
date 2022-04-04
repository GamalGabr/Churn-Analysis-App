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
library(hover)
source("css_churn2.R")

source("important_data2.R")


library(shiny)





CSS <- "
.morecontent span {
    display: none;
}
.morelink {
    display: block;
}
"





#jscode<-"shinyjs.init=function() {

#"$('#navbar li a[data-value=TABWELCOME]').hide();});

#}"
















JS <- '
$(document).ready(function() {
    // Configure/customize these variables.
    var showChar = 143;  // How many characters are shown by default
    var ellipsestext = "...";
    var moretext = "Show more >";
    var lesstext = "Show less";
    
    $(".more").each(function() {var content = $(this).html();
        if(content.length > showChar) {
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);
            var html = c + "<span class=\\\"moreellipses\\\">" + ellipsestext 
              + "&nbsp;</span><span class=\\\"morecontent\\\"><span>" + h 
              + "</span>&nbsp;&nbsp;<a href=\\\"\\\" class=\\\"morelink\\\">" 
              + moretext + "</a></span>";
            $(this).html(html);
        }
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
});
'


JS2 <- '



'









#my_theme <- bs_theme(bootswatch = "darkly",
#base_font = font_google("Righteous"))

# Let thematic know to update the fonts, too
#thematic_shiny(font = "auto")



shinyUI(fluidPage(
    


    tags$style(HTML(CSS)), 
    tags$script(HTML(JS)),
    #tags$script(HTML(JS2)),
    
    
    
    
    #theme = bslib::bs_theme(bootswatch = "darkly"),
    #theme = shinytheme("cyborg"),
    tags$style(cssUPGRADE),
    # Pass that theme object to UI function
    #theme = my_theme,
    #extendShinyjs(text = jscode, functions = "init"),
    
    useShinyjs(),
    tags$head(HTML("<script type='text/javascript'>

shinyjs.init=function() {
 
const navbar = document.querySelector('.nav-fixed');
window.onscroll = () => {
    if (window.scrollY > 300) {
        navbar.classList.add('nav-active');
    } else {
        navbar.classList.remove('nav-active');
    }
};
}
</script>")),
    
    
    
    
    
    
    
    
    
    useShinyjs(),
    
    useShinyalert(force=TRUE),
    
    navbarPage(
        id = "navbar",
        "Churn Analytics",
        tabPanel(title = "Welcome",      
                 value="TABWELCOME",
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 br(),
                 br(),
                 br(),
                 #opening page intro with moving text
                 HTML("<div class='center'> <h1>
        <span>This</span>
        <span>project</span>
        <span>sought</span>
        <span>to</span>
        <span>reveal</span>
        <span>what</span>
        <span>variables</span>
        <span>are</span>
        <span>the</span>
        <span>key</span>
        <span>predictors</span>
        <span>driving</span>
        <span>the</span>
        <span>phenomenon</span>
        <span>of</span>
        <span>Churn</span>
        <span>within</span>
        <span>a</span>
        <span>telecommunications</span>
        <span>company.</span>
        <span>The</span>
        <span>rate</span>
        <span>of</span>
        <span>Churn</span>
        <span>indicates</span>
        <span>the</span>
        <span>proportion</span>
        <span>of</span>
        <span>subscribers</span>
        <span>of</span>
        <span>a</span>
        <span>service</span>
        <span>that</span>
        <span>are</span>
        <span>leaving.</span>
        <span></span>
        <span></span>
         </h1></div>"),
        
        
        
        
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
        ),
        tabPanel(title="Start Page",
                 value="STARTPAGETAB",
                 
                 
                 
                 HTML("
                  <div class='zebra'>
  <h1>WELCOME</h1>
</div>

               "),
                 
                 HTML("<br>"),
                 HTML("<br>"),
                 
                 
                 tags$span(
                     class = "more", 
                     HTML( "Welcome to this Churn analysis app! The original IBM dataset contained the information of 7043 
                  fictional telecommunications customers, with 21 variables relating to whether or not they churned. 
                 This app employs cutting-edge artifical intelligence to uncover key relationships between Churn and 
                 a range of variables. In keeping with traditional data analytics, the original dataset was partitioned 
                 into a training and test set. Three algorithms were trained: using the original dataset with its inherent 
                 class imbalance of churners/non-churners, a random forest model was constructed. In addition, using 
                 upsampled data (oversampling of the minority class of churners), a gradient boosting and a random forest 
                 model were also trained. After training, all of the models were evaluated on the unseen test set.<br>
                 <br>
              
              Upsampling produces a balanced dataset, with the aim of eliminating the predictive bias produced by imbalanced 
              datasets. Churn, the dependent variable, signifies whether or not a customer terminated their contract within 
              the last month. The response , No ,  signifies the customers who did not leave the company within the last month, 
              while the response, Yes , indicates clients that decided to terminate their relations with the company. Gauging the 
              likelihood of customer churn is of primary concern for large companies; the potential impact on revenue, particularly 
              in the telecommunications sector, is of paramount importance. Whilst the definition of most terms are likely to be clear, 
              clarification of some potentially confusing terms is given below: <br>
              <br>  
          <ul>
          <li> Tenure - Number of months the customer has stayed with the company</li>
          <li> Multiple lines - Whether the customer has multiple lines or not (Yes, No, No phone service)</li>
          <li> Monthly Charges - The amount charged to the customer monthly</li>
          <li> Total Charges - The total amount charged to the customer</li>
          <li> Churn - Whether the customer churned or not, i.e. left the company (Yes or No)</li> 
          <li> XGB_UP - Extreme Gradient Boosting, a type of tree-based algorithm that was trained using upsampled data</li> 
          <li> Random Forest- Random Forest algorithm trained on the original data</li>
          <li> Random_Forest_Up - Random Forest algorithm trained on upsampled data</li>
          </ul>
          
          
                       
                       
              
              
              
              
              
              
              
              
              
              
              " )),
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
        ),
        
        
        
        tabPanel(title="Visuals",
                 value="VISUALTAB",
                 
                 sidebarPanel(width = 3,
                              
                              tags$style(".well {background-color: #808080  ;}"),
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              selectInput(inputId="HIGHCHARTCHOICE", label="Select Plot:", choices =c("Count Compare", "Churn Proportion Variation", "Churn Count Variation", "Electronic Count", "Multiple Lines",  "InternetService Variation"),  selected = "Count Compare", width =  '350px'),  
                              
                              sliderInput("MonthlyChargesInput", "Monthly Charges",  min = min(train_data$MonthlyCharges), max = max(train_data$MonthlyCharges) , c(min(train_data$MonthlyCharges), max = max(train_data$MonthlyCharges)),
                                          pre = "$"),
                              
                              
                              
                              sliderInput("TotalChargesInput", "Total Charges",  min = min(train_data$TotalCharges), max = max(train_data$TotalCharges) , c(min = min(train_data$TotalCharges), max = max(train_data$TotalCharges)),
                                          pre = "$"),
                              
                              sliderInput("TenureInput", "Tenure",  min = min(train_data$tenure), max = max(train_data$tenure), c(min = min(train_data$tenure), max = max(train_data$tenure)),
                                          pre = "Months"),
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                 ),
                 mainPanel(
                     
                     
                     
                     br(),
                     br(),
                     br(),
                     withSpinner(highchartOutput("HIGHCHARTOPT", height = "700%", width="115%")),  
                     br(),
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     br(),
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                 )
        ),
        
        tabPanel("Key Variables",
                 sidebarPanel(width = 3,
                              
                              
                              
                              radioButtons(inputId = "VARIABLE_IMPORTANCE_COMP",
                                           label = "Compare Variable Importance",
                                           choices = c("Random Forest", "Random Forest Up","XGB Up")),
                              
                              withAnim(),
                              
                              
                              
                              
                              
                 ),
                 mainPanel(
                     
                     
                     #moving text effect
                     HTML("<h2 style='text-align:center' class='shiny'>Most Important Variables</h2>"),
                     
                     #<button class="glow-on-hover" type="button">HOVER ME, THEN CLICK ME!</button>
                     hr(),
                     #fluidRow(column(12, div(actionButton("vimpress", icon("info"),
                     #                                     style="color: #fff; background-color: #9D00FF; width:70px; height:80px; border-color: #2e6da4"), style = "float: right"))),
                     fluidRow(column(12, div(shiny::actionButton("vimpress", class='glow-on-hover',
                                                                 label='Info', width = "60px",
                                                                 style = 'float: right')))),
                     
                     br(),
                     br(),
                     plotOutput("PlotImportance"),
                     br(),
                     br(),
                     
                     
                     
                     
                     
                     
                     
                 )
        ),
        
        tabPanel("ALE Plots",
                 sidebarPanel(width=3,
                              
                              
                              
                              
                              
                              selectInput(inputId = "VariableOPT",
                                          label = "Variable choose : ",
                                          choices = c("tenure", "TotalCharges","MonthlyCharges","PaymentMethod","Contract","InternetService","MultipleLines"),
                                          selected = "", width =  '200px'),
                              
                              
                              
                              
                              
                              
                              
                              
                              
                 ),
                 mainPanel(
                     HTML("<h2 style='text-align: center;'>ALE plot insight</h2>"),
                     
                     #HTML("<div class='button'>HOVER ME</div>"),
                     hr(),
                     
                     
                     
                     
                     
                     
                     br(),
                     withSpinner(plotOutput("ACCUMULATEDDEPENDENCE", height="400px")), 
                     
                     
                     
                     br(),
                     HTML("<h2 style='text-align: center;'>What are ALE plots?</h2>"),
                     
                     
                     hr(),
                     
                     HTML("<p>
                  Accumulated local effects (ALE) illustrate how variables impact the predicted outcome of a machine learning model on average.
                  For numerical variables, the ALE algorithm averages the difference in small windows of a variable's range. ALE graphs are centered 
                  at 0. If the reading on the X-axis, at the point X=3 translates as -4 , this can roughly be interpreted as indicating that the 
                  prediction at this value is lower than the average prediction by 4 units. In a nutshell, ALE plots illustrate how the predictions of 
                  a machine learning model alter between subsections of an independent variable's overall range. The impact of categorical features can 
                  be similarly interpreted: each bar represents the average modification in the model's predicition when the respective feature is present 
                  .</p>"),
                     
                     
                     
                     
                 )
                 
        ),    
        tabPanel("BreakDown Profiles",
                 verticalLayout(
                 ),
                 sidebarLayout(
                     sidebarPanel(width=3,
                                  
                                  
                                  
                                  radioButtons("plot_features",
                                               label = HTML('<FONT color="#21F8F6"><FONT size="5pt">Select model type:</FONT></FONT>'),
                                               choices =  c("Random_Forest","Random_Forest_Up","Xgb_Up"),
                                               selected = "Random_Forest",
                                               inline = T,
                                               width = "100%"),
                                  
                                  
                                  
                                  
                                  numericInput(inputId="row_index",
                                               label= HTML("<p>Select customer <br> (1-5000)</p>"),
                                               value=1,
                                               min=1, max=20,  width = '150px')  
                                  
                                  
                                  
                                  
                     ),
                     mainPanel(
                         
                         
                         br(),
                         HTML("<h2 style='text-align: center;'>Breakdown Profiles</h2>"),
                         
                         
                         
                         
                         hr(),
                         
                         
                         
                         
                         
                         br(),
                         withSpinner(plotOutput("EASIER", height="400px")), 
                         
                         
                         
                         br(),
                         br(),
                         
                         htmlOutput("DESCRIBEVARY"),
                         
                         br(),
                         br(),
                         HTML("<h3 style='text-align: center;'>What are Breakdown Plots conveying?</h3>"),
                         hr(),
                        
                         HTML("<p class=reduced>There are two broad types of model explanatory tools, namely local and global.
                             For instance, ALE plots are a form of global explanation in that they yield an overall 
                             understanding of a model's predictions aggregated over an entire dataset. Alternatively, 
                             the breakdown algorithm provides local explanations: in other words, this algorithm provides 
                             information in relation to a single observation/customer. The breakdown algorithm helps unveil 
                             which particular variables contribute the most to a specific observation/prediction.<br>
                             <br>
                             The breakdown plots featured above can be interpreted as follows: the intercept row indicates 
                             the overall mean value of predictions for a model when trained on the entire dataset. The green 
                             and red bars signify the relative contribution of each variable towards the overall prediction. 
                             Red bars indicate that the respective variable decreases the probability that a particular customer 
                             will churn, whereas green bars represent variables that increase the likelihood a customer will churn. 
                             The purple bar shows the prediction for the particular customer being evaluated.
                             </p>"),
                         
                         
                         
                         
                         
                     )  
                 )     
        ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        tabPanel("New Predictions",
                 fluidPage(
                     
                     #tags$h2("Select a model, and enjoy making new predictions!"),
                     HTML("<h2 class='shiny'>Test Results</h2>"),
                     
                     
                     hr(),
                     #fluidRow(column(12, div(actionButton("metricmessage", icon("info"), style="color: #fff; width:70px; height:80px; background-color: #9D00FF; border-color: #2e6da4"), style = "float: right"))),                                  
                     fluidRow(column(12, div(shiny::actionButton("metricmessage", class='glow-on-hover',
                                                                 label='Info', width = "70px",
                                                                 style = 'float: right')))),
                     br(),
                     
                     
                     
                     
                     
                     #fluidRow(
                     # column(3, offset=4,tags$b("Performance results from test data shown below!"),)),
                     #textOutput('greeting'),
                     br(),
                     #tags$h3(class="shiny","Predicted Probability of Churn:"),
                     #textOutput(outputId = "forlabelresult"),
                     
                     fluidRow(
                         column(2, radioButtons(inputId = "MODELCHOICE",
                                                label = HTML('<FONT color="#21F8F6"><FONT size="5pt">Select model:</FONT></FONT>'),
                                                choices = c("RANDOM_FOREST","RF_UP","XGB_UP"))),
                         
                         
                         #column(1, offset=1, withAnim(),
                         #div( id = 'shinyLogo', tags$img(src= "https://hineon.com/wp-content/uploads/2019/09/neon-arrow.jpg", width = "100px", height = "100px"))),      
                         
                         column(6, offset=2, withSpinner(plotOutput("PlotResults", width = "600px", height = "300px"))),
                         
                         br(),
                         
                         
                         
                         
                     ),
                     
                     
                     
                     hr(),
                     
                     HTML("<h5>Make informed decisions.</h5>"),
                     
                     fluidRow(
                         column(3, #offset = 1,
                                
                                h4(class="glow","Probability of Churn:"),
                                #textOutput(outputId = "forlabelresult"),
                                withSpinner(gaugeOutput("GAUGER", width = "200px", height = "100px")),
                                br(),
                                #textOutput(outputId = "forlabelresult"),
                                htmlOutput("some_text"),
                                hr(),
                                #radioButtons(inputId = "MODELCHOICE",
                                #label = HTML('<FONT color="#9B59F6"><FONT size="5pt">Select model type</FONT></FONT>'),
                                #choices = c("RANDOM_FOREST","RF_UP","XGB_UP")),
                                
                                tags$div(id='my_div',
                                         class='my_class',selectInput(inputId="PaperlessBillingChoice", label="Paperless Billing:", choices =levels(train_data$PaperlessBilling),  selected = "Yes", width =  '100px')),  
                                selectInput(inputId="PhoneServiceChoice", label="Phone Service:", choices =levels(train_data$PhoneService),  selected = "Yes", width =  '100px'),
                                
                                
                                
                                
                                
                                
                                
                         ),
                         column(2,
                                
                                selectInput(inputId="DependentsChoice", label="Dependents:", choices =levels(train_data$Dependents),  selected = "No", width =  '100px'),  
                                selectInput(inputId="PaymentMethodChoice", label="Payment Method:", choices =levels(train_data$PaymentMethod),  selected = "Electronic Count", width =  '100px'),
                                selectInput(inputId="MultipleLinesChoice", label="Multiple Lines:", choices =levels(train_data$MultipleLines),  selected = "No", width =  '100px'),
                                selectInput(inputId="OnlineSecurityChoice", label="Online Security:", choices =levels(train_data$OnlineSecurity),  selected = "No", width =  '100px'),
                                
                                
                         ),
                         column(2,
                                selectInput(inputId="ContractChoice", label="Contract:", choices =levels(train_data$Contract),  selected = "Yes", width =  '100px'),  
                                selectInput(inputId="OnlineBackupChoice", label="Online Backup:", choices =levels(train_data$OnlineBackup),  selected = "Yes", width =  '100px'),
                                selectInput(inputId="StreamingMoviesChoice", label="Streaming Movies", choices =levels(train_data$StreamingMovies),  selected = "Yes", width =  '100px'),
                                
                                selectInput(inputId="DeviceProtectionChoice", label="Device Protection:", choices =levels(train_data$DeviceProtection),  selected = "Yes", width =  '100px'),
                                
                                
                                
                         ),
                         column(2,
                                selectInput(inputId="PartnerChoice", label="Partner:", choices =levels(train_data$Partner),  selected = "No", width =  '100px'),  
                                
                                selectInput(inputId="StreamingTVChoice", label="Streaming TV:", choices =levels(train_data$StreamingTV),  selected = "Yes", width =  '100px'),
                                br(),
                                selectInput(inputId="SeniorCitizenChoice", label="Senior Citizen:", choices =levels(train_data$SeniorCitizen),  selected = "Yes", width =  '100px'),
                                
                                selectInput(inputId="TechSupportChoice", label="Tech Support:", choices =levels(train_data$TechSupport),  selected = "Yes", width =  '100px'),
                                br(),
                                selectInput(inputId="InternetServiceChoice", label="Internet Service:", choices =levels(train_data$InternetService),  selected = "No", width =  '100px'),
                                
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
                         
                         p(class = "scaledown", "This web application was designed and built by",
                           span("Gamal Gabr", style = "color:#21F8F6"),
                           ". If you would like to explore more of my data science work, please click on the link featured below:"),
                         
                         tags$a(href = "https://github.com/GamalGabr?tab=repositories", "Take me to GitHub", icon("github")),
                         br(),
                         br(),
                     )
             )    )
        )
    )
)
