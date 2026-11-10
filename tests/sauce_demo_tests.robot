*** Settings ***
Documentation    GUVI Task 20 - Sauce Demo automation using Robot Framework and SeleniumLibrary.
Library          SeleniumLibrary
Resource         ../resources/variables.robot
Resource         ../resources/common_keywords.robot
Test Setup       Open Sauce Demo Login Page
Test Teardown    Close All Browsers

*** Test Cases ***
TC01 - Login With Valid Credentials
    [Documentation]    Verify that a valid user reaches the products page.
    Login With Valid Credentials
    Verify Products Page Is Displayed

TC02 - Login With Invalid Credentials
    [Documentation]    Verify that invalid credentials display an appropriate error.
    Login With Credentials    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Wait Until Element Is Visible    css=h3[data-test="error"]    timeout=10s
    Element Should Contain    css=h3[data-test="error"]    Username and password do not match

TC03 - Add One Product And Verify Cart
    [Documentation]    Add one product and verify it is listed in the shopping cart.
    Login With Valid Credentials
    Verify Products Page Is Displayed
    Add Product To Cart    ${PRODUCT_BACKPACK}
    Open Shopping Cart
    Verify Product Is In Cart    ${PRODUCT_BACKPACK}

TC04 - Add Multiple Products And Verify Checkout Summary
    [Documentation]    Add multiple products and verify their names and quantities in checkout overview.
    Login With Valid Credentials
    Verify Products Page Is Displayed
    Add Product To Cart    ${PRODUCT_BACKPACK}
    Add Product To Cart    ${PRODUCT_BIKE_LIGHT}
    Open Shopping Cart
    Verify Product Is In Cart    ${PRODUCT_BACKPACK}
    Verify Product Is In Cart    ${PRODUCT_BIKE_LIGHT}
    Proceed To Checkout Overview
    Verify Checkout Overview Page
    Verify Checkout Item And Quantity    ${PRODUCT_BACKPACK}
    Verify Checkout Item And Quantity    ${PRODUCT_BIKE_LIGHT}
