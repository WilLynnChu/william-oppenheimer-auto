# Setting up the environment

## Installing Python and packages

##### 1. Install Python from https://www.python.org/downloads/
##### 2. Add the path into your shell profile
```
alias python='/usr/local/bin/python3'
```
##### 3. Check the default python used
```
which python
```
##### 4. Install robotframework and robotframework-seleniumlibrary package using pip3
```
pip3 install robotframework
pip3 install robotframework-seleniumlibrary
pip3 install robotframework-requests
```
##### 5. Check is the packages installed correctly
```
pip3 show robotframework
pip3 show robotframework-seleniumlibrary
pip3 install robotframework-requests
```
#### Setting up PyCharm
##### 6. Install PyCharm from https://www.jetbrains.com/pycharm/
##### 7. Open the project
##### 8. Go to PyCharm preferences and search for Python Interpreter
##### 9. Select/add your Python interpreter. In my case, it is as below
```
Adding existing interpreter at this path /usr/local/bin/python3
```
##### 10. If the correct interpreter is added, the packages that you had installed at step 4 will be shown
##### 11. Go to PyCharm preferences and go to plugin
##### 12. (OPTIONAL) Search and install Hyper RobotFramework Support
#### Setting up Chromedriver
##### 13. Check your Chrome version
##### 14. Download the respective version of Chromedriver from https://chromedriver.chromium.org/downloads
##### 15. Extract and replace chromedriver in this path <RepoName>/drivers/chromedriver


# To execute test suite created:
##### 1. Download and clone this repository to your desktop. You may also choose to download the jar OppenheimerProjectDev.jar
##### 2. To run the application, issue the following to your terminal. Replace {path-to-this-jar} with your actual path to the folder containing the jar
```
java -jar {path-to-this-jar}/OppenheimerProjectDev.jar
```
##### 3. Open project with PyCharm
##### 4. In the built in terminal in PyCharm, make sure you are in the root of the project folder 
##### 5. In the terminal, run this command to run the test suite. Running from terminal allow us to specify where would the reports/output saved in. In this case, it will be saved in reports. Alternatively you can run from the UI by opening the tests file and clicking the run button beside test case.
```
robot -d reports tests/assessmentSuite.robot
```


# Test Cases Scripted
##### 1. Upload Csv File To The Portal
##### 2. Insert Single Record Of Tax Relief Via Swagger
##### 3. Insert Single Record Of Tax Relief Via API
##### 4. Insert Multiple Record Of Tax Relief Via Swagger
##### 5. Insert Multiple Record Of Tax Relief Via API
##### 6. Get Individuals Tax Relief Amount Via Swagger
##### 7. Dispense Tax Relief Amount For Working Class Heroes
##### 8. Rake Reset Database Via API


# Issues Found

## 1. Home page down when send API request with invalid body
### Pre-requisite:
     - N/A
### Step to replicate(STR):
     1. Send API with invalid body
     2. In this case, send API with natid that has less than 4 char
     3. Try to access home page
### Actual behavior:
     - Home page down with error. 
#####       https://ibb.co/SwRtfDt
### Expected behavior:
     - Home page should work as usual. There should be validation for API
### Priority: P0
##### Related to issue no. 2

## 2. API has missing validation
### Pre-requisite:
     - N/A
### Step to replicate(STR):
     1. Send API with invalid body
     2. In this case, send API with natid that has less than 4 char
     3. Check process of the listening port in terminal
### Actual behavior:
     - The API was sent successfully which cause the out of string error and home page to went down
#####       https://ibb.co/6sVsrmZ
### Expected behavior:
     - There should be validation for API and preventing to send the request like other attributes as shown as the image below:
#####       https://ibb.co/N1btbMW
### Priority: P0
##### Related to issue no. 1

## 3. Calculation of Tax Relief is inaccurate
### Pre-requisite:
     - The tax relief amount that will be rounded is even number
     - The decimal is less than 2 decimal point
### Step to replicate(STR):
     1. Use normal rounding rule to performed calculation on tax relief
     2. Cross check with the output of the system
### Actual behavior:
     - The normal rounding rule is **round half up** however the system used **round half even**. It will not round up if the to be rounded up amount is even
     - Sometimes it does not round up to nearest whole number when there is two exact decimal
#####     https://ibb.co/wcw1Phs
### Expected behavior:
     - It should be applying normal rounding rule which is round half up. And also round to the nearest whole number when there is two or less decimal point
### Priority: P0
    
## 4. Dispense Tax Relief Amount For Working Class Heroes        
### Pre-requisite:
     - Insert working class hero record to database
### Step to replicate(STR):
     1. Click on Dispense Now button
     2. Check the current number of working class hero and tax relief amount
### Actual behavior:
     - After dispense the current number of working class hero and tax relief amount remain the same
     - Able to click on Dispense Now button repeatedly
#####     https://ibb.co/wyLkxBj
### Expected behavior:
     - The current number of working class hero and tax relief amount should be cleared
### Priority: P0
    
## 5. No role was implemented in the system
### Pre-requisite:
     - N/A
### Step to replicate(STR):
     - N/A
### Actual behavior:
     - Everyone can use all function or features of the system regardless of the role
### Expected behavior:
     - Everyone should have function or features limited to their own role
### Priority: P1

## 6. API Documentation is not informative
### Pre-requisite:
     - N/A
### Step to replicate(STR):
     1. Navigate to Swagger doc
     2. Expend to show API
     3. Read through the API doc
### Actual behavior:
     - Example body is not informative enough and can easily cause people to enter wrong data. It can be a risk especially if the validation is not sufficient.
     - Example response is not clear as some of the API responses is not recorded in the doc. There isn't any meaningful example response as well.
### Expected behavior:
     - API Doc should be informative whereby people will know how to use it and what data/params to pass after they read on it.
### Priority: P1
