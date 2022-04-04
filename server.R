source("important_data2.R")


RFUp_model<-readRDS("rfupmodel.rds")

rf_model<-readRDS("rfmodel.rds")

XGBUP_model<-readRDS("xgbupmodel.rds")

train_data<-readRDS("churnnew2.rds")

#train_data<-readRDS("train_data.rds")





# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    #observe(addHoverAnim(session, 'shinyLogo', 'pulse'))
    
    
    
    
    
    output$mytable2 <- DT::renderDataTable({
        DT::datatable(MetricTable)%>%formatStyle(columns = colnames(MetricTable), color = 'white', background = 'black', target = 'row')
        
    })
    
    
    output$greeting<-renderText({
        
        paste("Select one of the four models to make new predictions. Each model
      was tested on new data. The bar graph to the right display the results of
      each model.
      ")
        
    })
    
    
    
    
    
    
    
    output$chartie<-renderHighchart({ plot(highchartie)})
    
    
    output$PlotResults<- renderPlot({if (input$MODELCHOICE == "RANDOM_FOREST") {
        
        RF_RESULTS} else if (input$MODELCHOICE == "RF_UP") {
            
            
            RF_UP_RESULTS} else if (input$MODELCHOICE == "XGB_UP") {XGB_UP_RESULTS}
        
    })
    
    
    
    
    #apply break_down algorithm for models
    output$EASIER <- renderPlot({
        
        req(input$row_index)
        
        
        
        
        if (input$plot_features == "Random_Forest") {  
            
            
            
            randomf_features <- break_down(explainer_rf,
                                           train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
            
            plot(randomf_features)
            
            
        } else if (input$plot_features == "Random_Forest_Up") { randomfUP_features <- break_down(explainer_rfup,
                                                                                                 train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
        plot(randomfUP_features)   } else if (input$plot_features == "Xgb_Up") { xgbUP_features <- break_down(explainer_rfup,
                                                                                                              train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
        plot(xgbUP_features)
        
        
        
        
        
        
        
        } })
    
    
    
    
    #apply break_down algorithm for models
    output$ACCUMULATEDDEPENDENCE <- renderPlot({
        
        
        req(input$VariableOPT)
        
        
        
        
        
        rf <- accumulated_dependence(explainer_rf, variables = input$VariableOPT)
        rf_up<- accumulated_dependence(explainer_rfup, variables = input$VariableOPT)
        XGB_up<- accumulated_dependence(explainer_xgbup, variables = input$VariableOPT)
        
        plot(rf, rf_up, XGB_up)+
            ggtitle("ALE profiles")
        
    })
    
    
    
    
    
    
    
    #conditional colour change of text based on prediction
    output$some_text <- renderText({ 
        
        if(pred_result()[[2]] < 0.5){
            return(paste("<span style=\"color:#21F8F6\">The model predicts that customer will stay</span>"))
            
        }else{
            return(paste("<span style=\"color:red\">The model predicts that customer will leave</span>"))
        }
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #provide descriptions for break_down algorithm
    output$DESCRIBEVARY<-renderUI({
        
        req(input$row_index)
        
        if (input$plot_features == "Random_Forest") {
            
            
            brd_da11 <- break_down(explainer_rf, train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
            br()
            HTML(paste(strong("Summary of above:"),  
                       br(),
                       describe(brd_da11,
                                label = "the probability of the customer leaving equates to:",
                                short_description = FALSE,
                                display_values =  TRUE,
                                display_numbers = TRUE,
                                display_distribution_details = FALSE)))
            
        } else if (input$plot_features == "Random_Forest_Up") {
            
            
            brd_da22 <- break_down(explainer_rfup, train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
            br()
            HTML(paste(strong("Summary of above:"),  
                       br(),
                       br(),
                       describe(brd_da22,
                                short_description = FALSE,
                                display_values =  TRUE,
                                display_numbers = TRUE,
                                display_distribution_details = FALSE)))  } else if (input$plot_features == "Xgb_Up") {
                                    
                                    
                                    brd_da22 <- break_down(explainer_xgbup, train_data[input$row_index, ], check_interactions = FALSE, keep_distributions = TRUE)
                                    br()
                                    HTML(paste(strong("Summary of above:"),  
                                               br(),
                                               describe(brd_da22,
                                                        short_description = FALSE,
                                                        display_values =  TRUE,
                                                        display_numbers = TRUE,
                                                        display_distribution_details = FALSE)))  }
        
        
        
    })
    
    
    
    
    
    
    
    
    
    
    #nested modal information regarding ALE models
    observeEvent(input$vimpress, {
        # Show a modal when the button is pressed
        shinyalert(
            title = " Variable importance seeks to capture the overall importance of a variable towards predicting the dependent variable, in this case 'Churn'. ", type = "info",
            callbackR = function(value) { shinyalert(paste("  If differing algorithms agree that a variable is important, we can be more confident that something meaningful is being revealed"))
            })  
    })
    
    
    
    #breakdown info
    observeEvent(input$preview, {
        # Show a modal when the button is pressed
        shinyalert(
            title = " Breakdown plots illustrate how the contributions associated with individual predictors alter the model's prediction  ", type = "info",
            callbackR = function(value) { shinyalert(paste(" The breakdown profile is specific to individual customers."))
            })  
    })
    
    
    
    observeEvent(input$velvet, {
        shinyalert("This works.", type = "info") })
    
    observeEvent(input$CONFINFO, {
        shinyalert("Sensitivity/Recall is the ratio of customers correctly identified as positive (churned) out of the total that actually churned. Specificity describes the ratio of true negatives to total negatives.", type = "info") })
    
    
    
    
    #nested modal information regarding ALE models
    observeEvent(input$ALEpress, {
        # Show a modal when the button is pressed
        shinyalert(
            title = "With an ALE plot, the y-axis illustrates the change we expect in the predicted probability of churn occurring, in relation to the x-axis change.", type = "info",
            callbackR = function(value) { shinyalert(paste("ALE shows the differences in prediction. E.g. if an x value equates to -1 on the y-axis, the prediction for that x value is -1 below the average prediction for that value."))
            })  
    })
    
    
    
    
    
    
    #nested modal information regarding metrics
    observeEvent(input$metricmessage, {
        # Show a modal when the button is pressed
        shinyalert(
            title = "Sensitivity captures the ratio of actual churners who are correctly identified as such  by a model (true positivity rate). Specificity refers to the ratio of non-churners who are correctly classified (true negativity rate).", type = "info",
            callbackR = function(value) { shinyalert(paste("An airport security system will prioritise sensitivity, where the detection of dangerous items is paramount. Unfortunately, this can increase false alarms (false positives). Likewise, higher specificity generally increases the number of false negatives."))
            })  
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    #create reactive data frame
    filtered <- reactive({
        train_data %>%
            filter(MonthlyCharges >= input$MonthlyChargesInput[1],
                   MonthlyCharges <= input$MonthlyChargesInput[2],
                   TotalCharges >= input$TotalChargesInput[1],
                   TotalCharges <= input$TotalChargesInput[2],
                   tenure >= input$TenureInput[1],
                   tenure <= input$TenureInput[2]
                   
                   
            )
    })
    
    #create reactive data frame for new predictions with alternative models
    pred_result <- reactive({
        
        df = data.frame(MonthlyCharges = input$MonthlyChargesIn,
                        gender = input$GenderIn,
                        PaymentMethod = input$PaymentMethodChoice,
                        SeniorCitizen=input$SeniorCitizenChoice,
                        PaperlessBilling=input$PaperlessBillingChoice,
                        Contract=input$ContractChoice,
                        MultipleLines=input$MultipleLinesChoice,
                        Dependents=input$DependentsChoice,
                        Partner=input$PartnerChoice,
                        DeviceProtection=input$DeviceProtectionChoice,
                        InternetService=input$InternetServiceChoice,
                        OnlineSecurity=input$OnlineSecurityChoice,
                        TechSupport=input$TechSupportChoice,
                        OnlineBackup=input$OnlineBackupChoice,
                        StreamingTV=input$StreamingTVChoice,
                        StreamingMovies=input$StreamingMoviesChoice,
                        tenure=input$TenureIn,
                        TotalCharges=input$TotalChargesIn,
                        PhoneService=input$PhoneServiceChoice)
        
        
        result <- if (input$MODELCHOICE == "RANDOM_FOREST") {predict(rf_model,newdata = df,type = 'prob')}
        else if (input$MODELCHOICE == "RF_UP")
        {predict(RFUp_model,newdata = df,type = 'prob')} else if (input$MODELCHOICE == "XGB_UP")
        {predict(XGBUP_model,newdata = df,type = 'prob')}
        
        #print(result)
        return(result)
    })
    
    
    #PROBABILITY GAUGE
    output$GAUGER = renderGauge({
        
        
        gauge(round(pred_result()[[2]],2),
              min = 0,
              max = 1,
              sectors = gaugeSectors(danger = c(0.5, 1),
                                     warning = c(0.3, 0.5),
                                     success = c(0, 0.3))
              
              
        )
        
    })
    
    
    
    
    
    
    #textual translation of numeric prediction
    forlabel <- reactive({
        f_3(pred_result()[[2]])
    }) 
    
    
    output$forlabelresult <- renderText({
        forlabel()
    })
    
    
    
    
    
    #render images
    output$image_choice<-renderPlot({
        if (input$VariableOPT == "tenure"){
            tenure_src
            
        } else if (input$VariableOPT == "MonthlyCharges") {
            MonthlyCharges_src
            
        } else if (input$VariableOPT == "TotalCharges") {
            TotalCharges_src
            
        }  })
    
    
    
    
    
    
    
    
    
    
    
    #MULTIPLE PLOT OPTIONS
    output$HIGHCHARTOPT<- renderHighchart({ if (input$HIGHCHARTCHOICE == "Electronic Count") {
        
        
        filtered()%>%
            dplyr::count(PaymentMethod)%>%
            arrange(n)%>%
            hchart(type = "bar", hcaes(x = PaymentMethod , y =n, color = PaymentMethod))%>%
            hc_exporting(enabled = FALSE)%>%
            hc_add_theme(hc_theme_chalk())%>% hc_title(
                text = "Payment Method by Count"
            )  } else if (input$HIGHCHARTCHOICE == "Multiple Lines")
            {
                filtered()%>%
                    dplyr::count(MultipleLines)%>%
                    arrange(n)%>%
                    hchart(type = "bar", hcaes(x = MultipleLines , y =n, color = MultipleLines))%>%
                    hc_exporting(enabled = FALSE)%>%
                    hc_add_theme(hc_theme_chalk())%>% hc_title(
                        text = "Multiple Lines Count"
                    ) 
            } else if (input$HIGHCHARTCHOICE=="Churn Proportion Variation")
                
            {filtered()%>%
                    group_by(Churn) %>%
                    summarise(total = n()) %>%
                    mutate(percentage = round((total/sum(total))*100,2))%>%
                    hchart(type = "bar", hcaes(x = Churn , y = percentage, group = Churn), color = c("#af3dff", "#a65c7c"))%>%
                    hc_exporting(enabled = FALSE)%>%
                    hc_add_theme(hc_theme_chalk())%>% hc_title(
                        text = "Percentage of Churn/Remain"
                    )  } else if (input$HIGHCHARTCHOICE=="Count Compare") {countcomp <- dplyr::count(filtered(), PaymentMethod, Churn)
                    
                    hchart(countcomp,type = "column", hcaes(x = PaymentMethod, y = n, group = Churn), color = c("#401482", "#ce8021"))%>%
                        hc_exporting(enabled = FALSE)%>%
                        hc_add_theme(hc_theme_chalk())%>% hc_title(
                            text = "Payment Method Variation"
                            
                        )}  else if (input$HIGHCHARTCHOICE=="InternetService Variation")
                            
                        {filtered()%>%
                                group_by(InternetService,Churn)%>%
                                summarise(total = n()) %>%
                                mutate(percentage = round((total/sum(total))*100,2))%>%
                                hchart(type = "bar", hcaes(x = InternetService , y = percentage, group = Churn), color = c("#39ff14", "#eb0450"))%>%
                                hc_exporting(enabled = FALSE)%>%
                                hc_add_theme(hc_theme_chalk())%>% hc_title(
                                    text = "Percentage of Churn/Remain"
                                ) %>%
                                hc_subtitle(
                                    text = "Explore the variation in Churn by filtering"
                                ) } else if (input$HIGHCHARTCHOICE=="Churn Count Variation")
                                    
                                {filtered()%>%
                                        group_by(Churn) %>%
                                        summarise(total = n())%>%
                                        
                                        hchart(type = "bar", hcaes(x = Churn , y = total, group = Churn), color = c("#bc13fe", "#fffc00"))%>%
                                        hc_exporting(enabled = FALSE)%>%
                                        hc_add_theme(hc_theme_chalk())%>% hc_title(
                                            text = "Count of Churn/Remain"
                                        ) %>%
                                        hc_subtitle(
                                            text = "Explore the variation in Churn by count"
                                        ) }  
        
        
        
        
        
        
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #ALE comparison plots
    output$ALENEW<- renderPlot({ if (input$VariableOPT == "tenure") {
        
        
        Tenure_ALE } else if (input$VariableOPT == "TotalCharges")
        {
            TotalCharges_ALE} else if (input$VariableOPT == "MonthlyCharges") {
                
                MonthlyCharges_ALE}
    })
    
    
    #animation effect
    #observe(addHoverAnim(session, 'shinywobble', 'pulse'))
    
    
    
    #delay appearance of TABWELCOME
    delay(6000, runjs("$('#navbar li a[data-value=TABWELCOME]').show();"))
    
    #delay appearance of STARTPAGETAB
    delay(7000, runjs("$('#navbar li a[data-value=STARTPAGETAB]').show();"))
    
    
    #delay appearance of VISUALSTAB
    delay(8000, runjs("$('#navbar li a[data-value=STARTPAGETAB]').show();"))
    
    
    
    
    # observe({
    #    if(!is.na(input$PaymentMethodChoice) & input$PaymentMethodChoice != "Electronic Count"){color <- "solid #DAF7A6"} else {color <- ""}
    #     runjs(paste0("document.getElementById('PaymentMethodChoice').style.border ='", color ,"'"))
    # })
    
    
    
    #variable info
    observeEvent(input$infovar, {
        # Show a modal when the button is pressed
        shinyalert("Filter away!",
                   
                   "Explore the variation in data as you vary the spectrum of data examined
              ",
                   type = "info", imageWidth=250)
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #CALL VARIABLE IMPORTANCE PLOTS
    output$PlotImportance<- renderPlot({
        if (input$VARIABLE_IMPORTANCE_COMP == "Random Forest") {
            
            RF_IMP_PLOT  } else if (input$VARIABLE_IMPORTANCE_COMP == "Random Forest Up") {
                
                RF_UP_IMP_PLOT}   else if (input$VARIABLE_IMPORTANCE_COMP == "XGB Up")
                    
                { XGB_UP_IMP_PLOT}
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    observeEvent(input$showalert, {
        shinyalert::shinyalert(title = 'Alert', className = 'alert')
    })
    
})




