*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=RegisterData
Suite Setup       Open My Browser  ${URL}
Suite Teardown    Close Browsers
Test Template   Register user

*** Variables ***

*** Test Cases ***
RegisterTaskmanager

*** Keywords ***
Register user
        [Arguments]     ${username}     ${password}
        Open Register Page
        Enter Username      ${username}
        Enter Password      ${password}
        Click Register Button
        Login should be visible





