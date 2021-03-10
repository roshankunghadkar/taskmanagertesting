*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=Tasks
Suite Setup       Open My Browser  ${URL}
Suite Teardown    Close Browsers
Test Template   Add Task

*** Variables ***

*** Test Cases ***
AddingTaskWithExel

*** Keywords ***
Add Task
        [Arguments]     ${TaskName}  ${TaskDescription}  ${username}  ${password}
        Open Login Page
        Enter Username  ${username}
        Enter Password  ${password}
        Click Login Button
        Tasks should be visible
        Input TaskName      ${TaskName}
        Input TaskDescription      ${TaskDescription}
        Click Create Button
        Tasks should be visible
