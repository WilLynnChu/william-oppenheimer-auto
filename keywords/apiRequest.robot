*** Settings ***
Documentation       Keyword file for API requests
Library             Collections
Library             RequestsLibrary
Library             OperatingSystem
Resource            ../objectRepository/requestObject.robot
Resource            ../keywords/generic.robot

*** Variables ***
${singleHeroJsonPath}     ${PROJ_DIR}/dataFiles/workingClassHero1.json
${multiHeroesJsonPath}     ${PROJ_DIR}/dataFiles/workingClassHero10.json

*** Keywords ***
Post Insert Single Hero Record
    ${beforeTotalWorkingClassHeroes}    ${beforeTotalTaxReliefAmount}      Get Tax Relief Summary via API
    ${singleHeroData}=     Get File    ${singleHeroJsonPath}
    ${dataJson}=     Evaluate        json.loads('''${singleHeroData}''')    json
    ${response}=    POST    ${api_post_insert_single_hero_record}   json=${dataJson}    #expected_status=200
    ${dataSize}=    Evaluate    1
    ${beforeTotalWorkingClassHeroes}    Evaluate    ${beforeTotalWorkingClassHeroes} + ${dataSize}
    ${afterTotalWorkingClassHeroes}    ${afterTotalTaxReliefAmount}     Get Tax Relief Summary Via API
    Should Be Equal As Numbers     ${beforeTotalWorkingClassHeroes}     ${afterTotalWorkingClassHeroes}
    Log    ${response}

Post Insert Multiple Hero Records
    ${beforeTotalWorkingClassHeroes}    ${beforeTotalTaxReliefAmount}      Get Tax Relief Summary via API
    ${multiHeroesData}=     Get File    ${multiHeroesJsonPath}
    ${dataJson}=     Evaluate        json.loads('''${multiHeroesData}''')    json
    ${response}=    POST    ${api_post_insert_mult_hero_record}     json=${dataJson}   #expected_status=200
    ${dataSize}=    Get Length    ${dataJson}
    ${beforeTotalWorkingClassHeroes}    Evaluate    ${beforeTotalWorkingClassHeroes} + ${dataSize}
    ${afterTotalWorkingClassHeroes}    ${afterTotalTaxReliefAmount}     Get Tax Relief Summary Via API
    Should Be Equal As Numbers     ${beforeTotalWorkingClassHeroes}     ${afterTotalWorkingClassHeroes}
    Log    ${response}

Post Rake Reset Database
    ${beforeTotalWorkingClassHeroes}    ${beforeTotalTaxReliefAmount}      Get Tax Relief Summary via API
    ${response}=    POST    ${api_post_rake_database}   expected_status=200
    ${beforeTotalWorkingClassHeroes}    Evaluate    ${beforeTotalWorkingClassHeroes} - ${beforeTotalWorkingClassHeroes}
    ${afterTotalWorkingClassHeroes}    ${afterTotalTaxReliefAmount}     Get Tax Relief Summary Via API
    Should Be Equal As Numbers     ${beforeTotalWorkingClassHeroes}     ${afterTotalWorkingClassHeroes}
    Log    ${response}

Get Tax Relief Details via API
    ${response}=    GET    ${api_get_tax_relief_details}    expected_status=200
    Log    ${response.json()}

Get Tax Relief Summary via API
    ${response}=    GET    ${api_get_tax_relief_summary}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key       ${response.json()}      totalWorkingClassHeroes
    Dictionary Should Contain Key       ${response.json()}      totalTaxReliefAmount
    [Return]    ${response.json()}[totalWorkingClassHeroes]     ${response.json()}[totalTaxReliefAmount]

