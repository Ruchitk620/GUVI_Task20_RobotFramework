# GUVI Task 20 - Robot Framework Automation

## Objective

Automate the Sauce Demo application using Robot Framework and SeleniumLibrary.

Application: https://www.saucedemo.com/

## Technology

- Python
- Robot Framework
- SeleniumLibrary
- Selenium WebDriver
- Chrome

## Project structure

```text
GUVI_Task20_RobotFramework/
├── resources/
│   ├── variables.robot
│   └── common_keywords.robot
├── tests/
│   └── sauce_demo_tests.robot
├── reports/
│   └── .gitkeep
├── requirements.txt
├── .gitignore
└── README.md
```

## Setup on Windows / PyCharm

Open the project folder in PyCharm, then run these commands in the terminal:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

If PowerShell blocks virtual environment activation, either allow activation for the current terminal using your normal Windows policy, or run the commands using the Python interpreter in `.venv` directly.

Install a current version of Google Chrome. Selenium Manager (included with Selenium 4) normally resolves the matching driver automatically when the tests run.

## Test data

The assignment-provided Sauce Demo account is declared in `resources/variables.robot`:

- Username: `standard_user`
- Password: `secret_sauce`

The invalid login test uses a deliberately incorrect username and password.

## Test cases

1. TC01 - Login with valid credentials and verify the Products page.
2. TC02 - Login with invalid credentials and verify the error message.
3. TC03 - Add Sauce Labs Backpack to the cart and verify it is listed.
4. TC04 - Add two products, proceed to checkout overview, and verify product names and quantity values.

## Run tests

From the project root:

```powershell
robot --outputdir reports tests
```

This generates `report.html`, `log.html`, and `output.xml` in the `reports` folder.

To run the suite with a visible browser, Chrome is opened by default. To change the browser, edit `${BROWSER}` in `resources/variables.robot`.

## Framework notes

- Test cases are written in Robot Framework's keyword-driven format.
- Reusable browser actions and assertions are in `resources/common_keywords.robot`.
- Reusable URL, browser, account and product values are in `resources/variables.robot`.
- SeleniumLibrary provides browser interactions; BuiltIn keywords are available automatically in Robot Framework.
- Each test opens a fresh browser and closes it during teardown.

## GitHub submission

Create a new **public** GitHub repository named `GUVI_Task20_RobotFramework`. Do not commit virtual environments or personal credentials. The reports folder is excluded from Git by default; keep generated reports locally or upload them separately if GUVI asks for execution evidence.
