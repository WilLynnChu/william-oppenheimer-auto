*** Settings ***
Documentation   Generic keyword file
Library         SeleniumLibrary
Library         String
Library         DateTime
Library         OperatingSystem
Library         Collections
Library         ../customLibraries/CommonUtils.py

*** Variables ***
${PROJ_DIR}     .
${execution_profile_chrome_name}    Chrome
${execution_profile_chrome_path}    executable_path=${PROJ_DIR}/drivers/chromedriver/chromedriver

*** Keywords ***
Count Records in CSV
    [Arguments]    ${workingClassHeroJsonData}
    ${numberOfLine}=    Get Line Count  ${workingClassHeroJsonData}
    Log    ${numberOfLine}
    [Return]    ${numberOfLine}

Verify Number Of Heroes After Insert
    [Arguments]    ${totalHeroesBefore}     ${numberOfNewRecord}     ${totalHeroesAfter}
    ${totalHeroesAfter}      Evaluate    ${totalHeroesBefore} + ${numberOfNewRecord}

Get Expected Tax Relief And Name From JSON Data
    [Arguments]    ${jsonPath}
    ${expectedTaxRelief}    Create List
    ${expectedName}  Create List
    ${taxReliefBeforeCalc}  Create List
    ${iteration}    Evaluate    0
    ${todayDate}=   Get Today's Date
    ${workingClassHeroJsonData}=     Get File    ${jsonPath}
    ${responseBodyJson}=    Evaluate    json.loads('''${workingClassHeroJsonData}''')    json
    FOR    ${item}     IN      @{responseBodyJson}
        ${age}  Evaluate    ${todayDate} - ${item}[birthday]
        ${ageVariable}=    Age Variable Classification    ${age}
        ${taxReliefTemp}    ${taxReliefBeforeCalcTemp}    Calculate Tax Relief    ${item}[salary]    ${item}[tax]    ${ageVariable}    ${item}[gender]
        Append To List    ${expectedTaxRelief}      ${taxReliefTemp}
        Append To List    ${expectedName}           ${item}[name]
        Append To List    ${taxReliefBeforeCalc}    ${taxReliefBeforeCalcTemp}
        Log    \nName: ${item}[name]\nAge: ${age}\nAge Variable: ${ageVariable}\nSalary: ${item}[salary]\nTax: ${item}[tax]\n
    END
    [Return]    ${expectedTaxRelief}    ${expectedName}     ${taxReliefBeforeCalc}

Get Today's Date
   ${date}=      Get Current Date
   ${convert}=      Convert Date      ${date}      result_format=%d%m%Y
   [Return]    ${convert}

Number Of Decimal Places
    [Arguments]    ${numbers}
    ${numbers}  Convert To String    ${numbers}
    ${numberSplit}   Split String    ${numbers}   .
    ${numberSplitSize}     Get Length   ${numberSplit}
    IF    ${numberSplitSize} != 1
        ${numberOfDec}     Get Length    ${numberSplit}[1]
    ELSE
        ${numberOfDec}  Evaluate    0
    END
    [Return]    ${numberOfDec}

Trunc To Three Decimal
    [Arguments]    ${numbers}
    ${regExTruncTwoDec}     Set Variable    ^\\d*\\....
    ${numbers}    Convert To String    ${numbers}
#    ${numbers}    Catenate    ${numbers}00
    ${numbers}    Get Regexp Matches    ${numbers}     ${regExTruncTwoDec}
    ${numbers}    Set Variable    ${numbers}[0]
    [Return]    ${numbers}

Calculate Tax Relief
    [Arguments]    ${salary}    ${taxPaid}    ${variable}    ${gender}
    ${genderBonus}  Evaluate    0
    IF    $gender == "F"
        ${genderBonus}  Evaluate    500
    END
    ${taxRelief}    Evaluate    ((${salary} - ${taxPaid}) * ${variable}) + ${genderBonus}
    ${taxReliefBeforeCalc}   Set Variable    ${taxRelief}
    Log    ${taxRelief}
    ${noOfDecPlaces}=   Number Of Decimal Places    ${taxRelief}
    ${taxRelief}=       Convert To Number           ${taxRelief}
    IF    $taxRelief > 0 and $taxRelief < 50
        ${taxRelief}    Set Variable    50
    ELSE IF    ${noOfDecPlaces} <= 2
        ${taxRelief}=   Round Half Up               ${taxRelief}   0
    ELSE IF    ${noOfDecPlaces} >= 3
        ${taxRelief}=   Trunc To Three Decimal      ${taxRelief}
        ${taxRelief}=   Round Half Up               ${taxRelief}   2
    END
    [Return]    ${taxRelief}    ${taxReliefBeforeCalc}

Age Variable Classification
    [Arguments]    ${age}
    ${ageVariable}  Evaluate    0
    IF    ${age} <= 18
        ${ageVariable}  Evaluate    1
    ELSE IF    ${age} <= 35
        ${ageVariable}  Evaluate    0.8
    ELSE IF    ${age} <= 50
        ${ageVariable}  Evaluate    0.5
    ELSE IF    ${age} <= 75
        ${ageVariable}  Evaluate    0.367
    ELSE
        ${ageVariable}  Evaluate    0.05
    END
    [Return]    ${ageVariable}