*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=ChangeStatusTask
Test Setup       Open My Browser  ${URL}
Test Teardown    Close Browsers
Test Template    Change Status

*** Variables ***

*** Test Cases ***
Test Case to Change Status of Task

*** Keywords ***
Change Status
    [Arguments]         ${username}     ${password}   ${task_id}
    Open Login Page
    Enter Username  ${username}
    Enter Password   ${password}
    Click Login Button
    go to         ${URL}/done/${task_id}/${username}
    page should contain     Completed


