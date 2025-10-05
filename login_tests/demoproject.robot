*** Settings ***
Library        SeleniumLibrary
Resource       resource.robot
Test Teardown  Close All Browsers

*** Test Cases ***
HelloWorld
    Log To Console  Hello, World!

loginTest
    Given Open Browser To Login Page
    When User "demo" logs in with password "mode"
    Then welcome page should be open

ValidAccountCreationTest
    Given Open Browser To Login Page
    When Navigate to Account Creation page
    And Enter New Account Details    Jane    Doe    janedoe    password123    johndoe@example.com    +61412345678    password123
    Then Verify Account Creation Success Alert for    Jane    Doe
      
InvalidEmailAccountCreationTest
    Given Open Browser To Login Page
    When Navigate to Account Creation page
    And Enter New Account Details    John    Doe    johndoe    password123    johndoe    12567890    password123
    Then Invalid Input Data Alert Displayed for    Email

InvalidMobileAccountCreationTest
    Given Open Browser To Login Page
    When Navigate to Account Creation page
    And Enter New Account Details    John    Doe    johndoe    password123    johndoe@example.com    12567890    password123
    Then Invalid Input Data Alert Displayed for    Mobile
