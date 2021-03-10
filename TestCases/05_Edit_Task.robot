*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Task_Resources.robot
Library  DataDriver  ../TestData/TestCasesForRobo.xls   sheet_name=EditTask
Test Setup       Open My Browser  ${URL}
Test Teardown    Close Browsers
Test Template   Test Case to Edit Task

*** Variables ***

*** Test Cases ***
Test case to Edit the Task

*** Keywords ***
Test Case to Edit Task
    [Arguments]             ${username}     ${password}  ${task_id}  ${updatedName}   ${updatedDesc}
    Open Login Page
    Enter Username  ${username}
    Enter Password   ${password}
    Click Login Button
    go to         ${URL}/update/${task_id}/${username}
    Input TaskName      ${updatedName}
    Input TaskDescription       ${updatedDesc}
    Click Button  xpath://button[@id='submitUpdate']
    page should contain     ${updatedName}
