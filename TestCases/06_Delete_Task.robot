*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=DeleteTask
Test Setup       Open My Browser  ${URL}
Test Teardown    Close Browsers
Test Template   Delete Task

*** Variables ***

*** Test Cases ***
Test Case to Delete Task


*** Keywords ***
Delete Task
    [Arguments]         ${username}     ${password}  ${task_id}
    Open Login Page
    Enter Username  ${username}
    Enter Password   ${password}
    Click Login Button
    go to       ${URL}/delete/${task_id}/${username}
    Deleted Tasks should not be visible
