*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=LoginData
Suite Setup       Open My Browser  ${URL}
Suite Teardown    Close Browsers
Test Template   Login user

*** Variables ***

*** Test Cases ***
LoginTaskmanager
#some comment
*** Keywords ***
Login user
        [Arguments]     ${username}     ${password}
        Open Login Page
        Enter Username      ${username}
        Enter Password      ${password}
        Click Login Button
        Logout Should be visible
