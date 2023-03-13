*** Settings ***
Documentation    Object repository for swagger doc page

*** Variables ***
#Buttons
${btn_expand_calculator_swagger}    //h4[@id='operations-tag-calculator-controller']
${btn_expand_insert_swagger}        //span[text() = '/calculator/insert']
${btn_expand_insert_multi_swagger}  //span[text() = '/calculator/insertMultiple']
${btn_expand_tax_relief_swagger}    //span[text() = '/calculator/taxRelief']
${btn_try_swagger}                  (//button[@class='btn try-out__btn'])[1]
${btn_execute_swagger}              (//button[@class='btn execute opblock-control__btn'])[1]

#Inputs
${input_body_swagger}               (//textarea[@class='body-param__text'])[1]

#Labels
${label_response_body_swagger}      //h5[text() = 'Response body']/following-sibling::pre[contains(@class,'microlight')]