
*** Settings ***
# Library           OperatingSystem
Library           LoginLibrary.py

*** Test Cases ***
User can create an account
    Create user    fred    fredpA55
    Status should be    SUCCESS
*** Keywords ***
Create valid user
    [Arguments]    ${username}    ${password}
    Create user    ${username}    ${password}
    Status should be    SUCCESS

*** Test Cases ***
User can create an account and log in
    Create valid user    fred    fredpA55
    Attempt to Login with Credentials    fred    fredpA55
    Status Should Be    Logged In
    
User cannot log in with bad password
    Create Valid User    betty    P4ssw0rd
    Attempt to Login with Credentials    betty    wrong
    Status Should Be    Access Denied    
*** Test Cases ***
User can change password
    Given a user has a valid account
    When she changes her password
    Then she can log in with the new password
    And she cannot use the old password anymore
    
# In the keywords drop "given", "when", "then" and "and".
*** Variables ***
${USERNAME}               janedoe
${PASSWORD}               J4n3D0e
${NEW PASSWORD}           e0D3n4J

*** Keywords ***
A user has a valid account
    Create valid user    ${USERNAME}    ${PASSWORD}

She changes her password
    Change password    ${USERNAME}    ${PASSWORD}    ${NEW PASSWORD}
    Status should be    SUCCESS

She can log in with the new password
    Login    ${USERNAME}    ${NEW PASSWORD}

She cannot use the old password anymore
    Attempt to login with credentials    ${USERNAME}    ${PASSWORD}
    Status should be    Access Denied
    
Login
    [Arguments]    ${username}    ${password}
    Attempt to login with credentials    ${username}    ${password}
    Status should be    Logged In
*** Keywords ***
Creating user with invalid password should fail
    [Arguments]    ${password}    ${error}
    Create user    example    ${password}
    Status should be    Creating user failed: ${error}

*** Test Cases ***
Invalid password: too short
    Creating user with invalid password should fail    abCD5    Password must be 7-12 characters long
    
Invalid password: too long
    Creating user with invalid password should fail    abCD567890123    Password must be 7-12 characters long
*** Variables ***
${PWD INVALID LENGTH}     Password must be 7-12 characters long
${PWD INVALID CONTENT}    Password must be a combination of lowercase and uppercase letters and numbers

*** Test Cases ***
Invalid password
    [Template]    Creating user with invalid password should fail
    abCD5            ${PWD INVALID LENGTH}
    abCD567890123    ${PWD INVALID LENGTH}
    123DEFG          ${PWD INVALID CONTENT}
    abcd56789        ${PWD INVALID CONTENT}
    AbCdEfGh         ${PWD INVALID CONTENT}
    abCD56+          ${PWD INVALID CONTENT}
*** Variables ***
${DATABASE FILE}          ${TEMPDIR}${/}robotframework-quickstart-db.txt

*** Settings ***
Suite Setup       Clear Login Database
Test Teardown     Clear Login Database
*** Settings ***
Library           OperatingSystem

*** Keywords ***
Clear login database
    Remove file    ${DATABASE FILE}
*** Settings ***
Force Tags    AllTests

*** Test Cases ***
Tagged Test
    [tags]   TaggedTest
    