*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Firefox
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html
${ACCOUNT URL}    http://${SERVER}/createaccount.html

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Input First Name
    [Arguments]    ${firstname}
    Input Text    firstname_field    ${firstname}

Input Last Name 
    [Arguments]    ${lastname}
    Input Text    lastname_field    ${lastname}

Input Email
    [Arguments]    ${email}
    Input Text    email_field    ${email}

Input Mobile
    [Arguments]    ${mobile}
    Input Text    mobile_field    ${mobile}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page

Navigate to Account Creation page
    Click Button    create_account_button
    Location Should Be    ${ACCOUNT URL}
    Title Should Be    Create Account

Enter New Account Details
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${password}    ${email}    ${mobile}   ${confirmpassword}
    Input First Name    ${firstname}
    Input Last Name    ${lastname}
    Input Username    ${username}
    Input Mobile    ${mobile}
    Input Email    ${email}
    resource.Input Password    ${password}
    Click Button    createaccount_button

User "${username}" logs in with password "${password}"
    Input username    ${username}
    resource.Input password    ${password}
    Submit credentials

Verify Account Creation Success Alert for
    [Arguments]    ${first_name}    ${last_name}
    ${message} =    Handle Alert    action=ACCEPT
    Should Be Equal As Strings    ${message}    Account created successfully for ${first_name} ${last_name}. You can now log in.

Invalid Input Data Alert Displayed for
    [Arguments]    ${WrongData}
    ${message} =    Handle Alert    action=ACCEPT
    IF    '${WrongData}' == 'Email'
        Should Be Equal As Strings    ${message}    Please enter a valid email address.
    ELSE IF    '${WrongData}' == 'Mobile'
        Should Be Equal As Strings    ${message}    Please enter a valid Australian mobile number.
    END