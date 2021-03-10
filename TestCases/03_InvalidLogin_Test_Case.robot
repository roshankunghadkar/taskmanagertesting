*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=InvalidLogindata
Suite Setup       Open My Browser   ${URL}
Suite Teardown    Close Browsers
Test Template   InvalidLogin user

*** Variables ***

*** Test Cases ***
InvalidLoginTaskmanager

*** Keywords ***
InvalidLogin user
        [Arguments]     ${username}     ${password}
        Open Login Page
        Enter Username      ${username}
        Enter Password      ${password}
        Click Login Button
        InvalidLogin should be visible
