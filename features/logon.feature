Feature: logon   

Scenario: Unsuccessful login
	Given a user has an account
    When the user tries to log in with invalid information
    Then the user should see an log in error message

Scenario: Successful login
    Given a user has an account
    When the user logs in
    Then the user should see an log in success message
    

