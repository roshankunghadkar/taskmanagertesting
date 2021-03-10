*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String

#*** Variables ***
#${Browser}  Chrome
#${URL}  http://${ip}:5000/
#${DBURL}   ${ip}
#${DELAY}    2

*** Keywords ***
Open My Browser
    #open browser  ${URL}    ${Browser}
    #maximize browser window now
    [Arguments]    ${URL}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    #Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument     --no-sandbox
    Call Method    ${chrome_options}    add_argument     --headless
    #Call Method    ${chrome_options}    add_argument    --disable-extensions
    Run Keyword If    os.sep == '/'    Create Webdriver    Chrome    my_alias    chrome_options=${chrome_options}    executable_path=/usr/bin/chromedriver
    ...    ELSE    Create Webdriver    Chrome    my_alias    chrome_options=${chrome_options}
    # Maximize Browser Window  # doesn't work under XVFB
    Set Window Size    1200    1000
    Go To    ${URL}

Open Browser to Page
    [Documentation]     Opens one of:
    ...                 - Google Chrome
    ...                 - Mozilla Firefox
    ...                 - Microsoft Internet Explorer
    ...                 to a given web page.
    [Arguments]    ${URL}
    Run Keyword If      '${BROWSER}' == 'Chrome'      Open Chrome Browser to Page                 ${URL}
    ...     ELSE IF     '${BROWSER}' == 'Firefox'     Open Firefox Browser to Page                ${URL}
    ...     ELSE IF     '${BROWSER}' == 'IE'          Open Internet Explorer to Page      ${URL}
    Set Selenium Speed              ${DELAY}

Close Browsers
        close all browsers


Open Login Page
        go to   ${URL}

Open Register Page
        go to   ${URL}/register

Enter Username
        [Arguments]     ${username}
        input text  name:Uname  ${username}

Enter Password
        [Arguments]     ${password}
        input text  name:Pass  ${password}

Click Register Button
        click element  id:register

Click Login Button
        click element  id:login


Click Delete Button
        click element  id:deleteTask

Click Edit Button
        click element  id:editTask

Input TaskName
        [Arguments]  ${TaskName}
        input text  name:name   ${Taskname}

Input TaskDescription
        [Arguments]  ${TaskDescription}
        input text  name:desc   ${TaskDescription}

Click Create Button
        click element  id:submitCreate

Error message should be visible
        page should contain     There was an issue while adding your task

Tasks should be visible
        page should contain     Task Manager

Login should be visible
        page should contain  Login Form

Register should be visible
        page should contain     Register Form

InvalidLogin should be visible
        page should contain  Invalid Credentials

Logout Should be visible
        page should contain  Logout

Deleted Tasks should not be visible
        page should not contain  Azure

*** Variables ***
${Browser}  Chrome
${URL}  http://${ip}:5000/
${DBURL}   ${ip}
${DELAY}    2
${ip}   127.0.0.1