
*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
Resource          resource.robot

*** VARIABLES ***
${ERROR URL}      http://${SERVER}/error.html
    
*** Test Cases ***
Invalid Login
    [Template]    Logging in should fail
    invalid          ${VALID PASSWORD}
    ${VALID USER}    invalid
    invalid          whatever
    ${EMPTY}         ${VALID PASSWORD}
    ${VALID USER}    ${EMPTY}
    ${EMPTY}         ${EMPTY}

*** Keywords ***
Logging in should fail
    [Arguments]    ${username}    ${password}
    Go To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed

Login Should Have Failed
    Location Should Be    ${ERROR URL}
    Title Should Be    Error Page