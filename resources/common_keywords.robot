*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot

*** Keywords ***
Open Sauce Demo Login Page
    [Documentation]    Launch Chrome and open the Sauce Demo login page.
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id=user-name    timeout=15s
    Title Should Be    Swag Labs

Login With Credentials
    [Documentation]    Enter the supplied username and password and submit the login form.
    [Arguments]    ${username}    ${password}
    Input Text    id=user-name    ${username}
    Input Password    id=password    ${password}
    Click Button    id=login-button

Login With Valid Credentials
    [Documentation]    Log in using the standard Sauce Demo test account.
    Login With Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}

Verify Products Page Is Displayed
    [Documentation]    Confirm that login navigated to the inventory/products page.
    Wait Until Location Contains    inventory.html    timeout=15s
    Wait Until Element Is Visible    class=inventory_list    timeout=10s
    Element Should Be Visible    class=title
    Element Text Should Be    class=title    Products

Add Product To Cart
    [Documentation]    Find a product by its displayed name and add it to the cart.
    [Arguments]    ${product_name}
    ${product_card}=    Set Variable
    ...    xpath=//div[contains(@class,'inventory_item')][.//div[contains(@class,'inventory_item_name') and normalize-space(.)="${product_name}"]]
    Wait Until Element Is Visible    ${product_card}    timeout=10s
    Click Button    ${product_card}//button[contains(@class,'btn_inventory')]

Open Shopping Cart
    [Documentation]    Open the cart using the shopping cart icon.
    Click Element    class=shopping_cart_link
    Wait Until Location Contains    cart.html    timeout=10s
    Wait Until Element Is Visible    class=cart_list    timeout=10s

Verify Product Is In Cart
    [Documentation]    Verify that a named product appears in the shopping cart.
    [Arguments]    ${product_name}
    Wait Until Element Is Visible
    ...    xpath=//div[contains(@class,'cart_item')]//div[contains(@class,'inventory_item_name') and normalize-space(.)="${product_name}"]
    Element Should Be Visible
    ...    xpath=//div[contains(@class,'cart_item')]//div[contains(@class,'inventory_item_name') and normalize-space(.)="${product_name}"]

Proceed To Checkout Overview
    [Documentation]    Continue from the cart to the checkout information and overview pages.
    Click Button    id=checkout
    Wait Until Element Is Visible    id=first-name    timeout=10s
    Input Text    id=first-name    GUVI
    Input Text    id=last-name    Student
    Input Text    id=postal-code    560001
    Click Button    id=continue
    Wait Until Location Contains    checkout-step-two.html    timeout=10s
    Wait Until Element Is Visible    class=cart_list    timeout=10s

Verify Checkout Item And Quantity
    [Documentation]    Confirm the expected product is listed once in checkout overview.
    [Arguments]    ${product_name}
    ${item}=    Set Variable
    ...    xpath=//div[contains(@class,'cart_item')][.//div[contains(@class,'inventory_item_name') and normalize-space(.)="${product_name}"]]
    Wait Until Element Is Visible    ${item}    timeout=10s
    Element Should Be Visible    ${item}//div[contains(@class,'cart_quantity')]
    ${quantity}=    Get Text    ${item}//div[contains(@class,'cart_quantity')]
    Should Be Equal As Integers    ${quantity}    1

Verify Checkout Overview Page
    [Documentation]    Confirm the browser is on the order overview page.
    Location Should Contain    checkout-step-two.html
    Element Should Be Visible    class=summary_info
    Element Should Be Visible    id=finish
