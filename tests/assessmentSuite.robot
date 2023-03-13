*** Settings ***
Documentation       Test Suite for Assessment Purpose
Library             SeleniumLibrary
Resource            ../keywords/homePage.robot
Resource            ../keywords/swaggerDocPage.robot
Test Teardown    Teardown Keyword

*** Test Cases ***
Upload Csv File To The Portal
    Open Browser With URL
    Upload Csv File From UI
    Verify Whether The Data Is Populated

Insert Single Record Of Tax Relief Via Swagger
    Open Browser With URL
    Navigate To Swagger Doc
    Expand Calculator Controller
    Insert Records Of Data Via Swagger  "Single"

Insert Single Record Of Tax Relief Via API
    Post Insert Single Hero Record

Insert Multiple Record Of Tax Relief Via Swagger
    Open Browser With URL
    Navigate To Swagger Doc
    Expand Calculator Controller
    Insert Records Of Data Via Swagger  "Multiple"

Insert Multiple Record Of Tax Relief Via API
    Post Insert Multiple Hero Records

Get Individuals Tax Relief Amount Via Swagger
    Open Browser With URL
    Navigate To Swagger Doc
    Post Insert Multiple Hero Records
    Expand Calculator Controller
    ${actualTaxRelief}  ${actualName}  ${natid}    ${responseSize}     Get Tax Relief Details Via Swagger
    Verify Tax Relief Details    ${actualTaxRelief}     ${actualName}   ${natid}    ${responseSize}

Dispense Tax Relief Amount For Working Class Heroes
    Open Browser With URL
    Post Insert Multiple Hero Records
    Verifying Dispense Now Button Colour And Text
    Dispense Tax Relief
    Verify Number Of Heroes After Dispense

Rake Reset Database Via API
    Post Insert Multiple Hero Records
    Post Rake Reset Database

*** Keywords ***
Teardown Keyword
    Post Rake Reset Database
    Close Browser

