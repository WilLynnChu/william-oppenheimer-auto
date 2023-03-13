*** Settings ***
Documentation       Keyword file for swagger Doc Page
Library             SeleniumLibrary
Library             OperatingSystem
Library             ../customLibraries/CommonUtils.py
Resource            ../objectRepository/swaggerObject.robot
Resource            ../keywords/generic.robot
Resource            ../keywords/apiRequest.robot

*** Variables ***
${singleHeroJsonPath}     ${PROJ_DIR}/dataFiles/workingClassHero1.json
${multiHeroesJsonPath}     ${PROJ_DIR}/dataFiles/workingClassHero10.json
${regEx}    ^\\d*\\...

*** Keywords ***
Expand Calculator Controller
    Wait Until Page Contains Element    ${btn_expand_calculator_swagger}
    Click Element    ${btn_expand_calculator_swagger}

Insert Records Of Data Via Swagger
    [Arguments]    ${multipleOfNumbers}
    Click Element    ${btn_expand_insert_swagger}
    Click Element    ${btn_try_swagger}
    IF    ${multipleOfNumbers} == "Single"
        ${workingClassHeroJsonData}=     Get File    ${singleHeroJsonPath}
    ELSE IF    ${multipleOfNumbers} == "Multiple"
        ${workingClassHeroJsonData}=     Get File    ${multiHeroesJsonPath}
    END
    Input Text      ${input_body_swagger}       ${workingClassHeroJsonData}
    ${totalHeroesBefore}    ${totalReliefAmountBefore}=  Get Tax Relief Summary Via API
    ${numberOfNewRecords}=   Count Records In CSV   ${workingClassHeroJsonData}
    Click Element    ${btn_execute_swagger}
    ${responseJson}=    Get Tax Relief Summary Via API
    ${totalHeroesAfter}    ${totalReliefAmountAfter}=  Get Tax Relief Summary Via API
    Verify Number Of Heroes After Insert      ${totalHeroesBefore}    ${numberOfNewRecords}   ${totalHeroesAfter}

Insert Multiple Record Of Data Via Swagger
    Click Element       ${btn_expand_insert_multi_swagger}
    Click Element       ${btn_try_swagger}
    ${workingClassHeroJsonData}=     Get File    ${multiHeroesJsonPath}
    Input Text          ${input_body_swagger}       ${workingClassHeroJsonData}
    ${totalHeroesBefore}    ${totalReliefAmountBefore}=  Get Tax Relief Summary Via API
    ${numberOfNewRecords}=   Count Records In CSV   ${workingClassHeroJsonData}
    Click Element       ${btn_execute_swagger}
    ${responseJson}=    Get Tax Relief Summary Via API
    ${totalHeroesAfter}    ${totalReliefAmountAfter}=  Get Tax Relief Summary Via API
    Verify Number Of Heroes After Insert      ${totalHeroesBefore}    ${numberOfNewRecords}   ${totalHeroesAfter}

Get Tax Relief Details Via Swagger
    ${actualTaxRelief}      Create List
    ${actualName}                Create List
    ${natid}                Create List
    Click Element    ${btn_expand_tax_relief_swagger}
    Click Element    ${btn_try_swagger}
    Scroll Element Into View    ${btn_execute_swagger}
    Click Element    ${btn_execute_swagger}
    Scroll Element Into View        ${label_response_body_swagger}
    Wait Until Element Is Visible    ${label_response_body_swagger}
    ${responseBodySwagger}=         Get Text        ${label_response_body_swagger}
    ${responseBodySwaggerJson}=     Evaluate        json.loads('''${responseBodySwagger}''')    json
    ${responseBodyJasonSize}=       Get Length      ${responseBodySwaggerJson}
    FOR    ${item}     IN      @{responseBodySwaggerJson}
        Append To List    ${actualTaxRelief}    ${item}[relief]
        Append To List    ${actualName}         ${item}[name]
        Append To List    ${natid}              ${item}[natid]
    END
    [Return]    ${actualTaxRelief}  ${actualName}  ${natid}    ${responseBodyJasonSize}

Verify Tax Relief Details
    [Arguments]    ${actualTaxRelief}   ${actualName}   ${natid}    ${responseSize}
    ${expectedTaxRelief}    ${expectedName}     ${taxReliefBeforeCalc}=   Get Expected Tax Relief and Name From JSON Data   ${multiHeroesJsonPath}
    FOR    ${index}     IN RANGE    0   ${responseSize}
        Log    \n\n${index}\nBefore Calculation:${taxReliefBeforeCalc}[${index}]\nExpected: ${expectedTaxRelief}[${index}]\nActual: ${actualTaxRelief}[${index}]\n\n
        Log To Console    \n\n${index}\nBefore Calculation:${taxReliefBeforeCalc}[${index}]\nExpected: ${expectedTaxRelief}[${index}]\nActual: ${actualTaxRelief}[${index}]\n\n
        Should Match Regexp    ${natid}[${index}]   \\d\\d\\d-\\$\\$\\$\\$\\$\\$\\$
        Should Be Equal As Numbers    ${actualTaxRelief}[${index}]  ${expectedTaxRelief}[${index}]
#        IF    ${index} == 5 or ${index} == 6 or ${index} == 8 or ${index} == 9
#            Log    SKIP INDEX ${index}
#            Log To Console    SKIP INDEX ${index}
#        ELSE
#            Should Be Equal As Numbers    ${actualTaxRelief}[${index}]  ${expectedTaxRelief}[${index}]
#        END
    END