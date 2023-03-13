*** Settings ***
Documentation       Keyword file for home page
Library             SeleniumLibrary
Library             Collections
Resource            ../objectRepository/homeObject.robot
Resource            ../keywords/generic.robot
Resource            ../keywords/apiRequest.robot

*** Keywords ***
Open Browser With URL
    Create Webdriver    ${execution_profile_chrome_name}    ${execution_profile_chrome_path}
    Navigate To Home

Navigate To Home
    Go To       http://localhost:8080

Upload Csv File From UI
    Choose File    ${input_upload_file_home}    ${data_working_class_hero_10}

Verify Whether The Data Is Populated
    Click Element    ${btn_refresh_table_home}
    Wait Until Page Does Not Contain Element    ${label_empty_record_message_home}
    Scroll Element Into View    ${table_header_natid_home}
    Element Should Be Visible   ${table_header_natid_home}
    Element Should Be Visible   ${table_header_relief_home}
    Scroll Element Into View    ${label_total_relief_message_home}
    Element Should Be Visible   ${table_body_home}
    ${totalWorkingClassHeroes}  ${totalTaxReliefAmount}=    Get Tax Relief Summary Via API
    ${summaryMessage}=   Set Variable    ${totalTaxReliefAmount} will be dispensed to ${totalWorkingClassHeroes} Working Class
    Element Should Contain    ${label_relief_summary_home}  ${summaryMessage}

Navigate To Swagger Doc
    Click Element   ${btn_visit_swagger_home}

Verifying Dispense Now Button Colour And Text
    ${elemObjectDispenseNow}     Get Webelement      ${btn_dispense_now_home}
    ${btnDispenseNowColor}    Call Method    ${elemObjectDispenseNow}    value_of_css_property    background-color
    ${btnDispenseNowText}=    Get Text    ${btn_dispense_now_home}
    Should Be Equal As Strings    ${btnDispenseNowColor}    rgba(220, 53, 69, 1)
    Should Be Equal As Strings    ${btnDispenseNowText}    Dispense Now
    Log    ${btnDispenseNowColor}\nElement Text: ${btnDispenseNowText}\n\n

Dispense Tax Relief
    Scroll Element Into View   ${btn_dispense_now_home}
    Click Element    ${btn_dispense_now_home}
    Element Text Should Be    ${label_cash_dispensed_dispensed_page}    Cash dispensed
    ${url}=   Get Location
    Should Be Equal As Strings    ${url}    http://localhost:8080/dispense

Verify Number Of Heroes After Dispense
    Navigate To Home
    Scroll Element Into View    ${label_relief_summary_home}
    ${labelReliefSummary}=   Get Text    ${label_relief_summary_home}
    ${totalWorkingClassHeroes}      ${totalTaxReliefAmount}     Get Tax Relief Summary via API

    Should Be Equal As Strings    ${labelReliefSummary}         £0 will be dispensed to 0 Working Class Hero/s
    Should Be Equal As Numbers    ${totalWorkingClassHeroes}    0

